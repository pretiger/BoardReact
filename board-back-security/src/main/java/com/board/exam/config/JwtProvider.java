package com.board.exam.config;

import java.security.Key;
import java.util.Date;

import javax.annotation.PostConstruct;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;
import javax.xml.bind.DatatypeConverter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import com.board.exam.config.authentication.PrincipalDetailService;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

@Component
public class JwtProvider {

	@Value("${jwt.secret.key}")
    private String salt;

    private Key secretKey;

    // 만료시간 : 1 minutue(1000L) 100minute(100000L)
    private final long exp = 100000L * 60 * 1;
    
    private SignatureAlgorithm signatureAlgorithm;

    @Autowired
    private PrincipalDetailService userDetailsService;

    @PostConstruct
    protected void init() {
    	signatureAlgorithm = SignatureAlgorithm.HS256;
    	byte[] ketByte = DatatypeConverter.parseBase64Binary(salt);
        secretKey = new SecretKeySpec(ketByte, signatureAlgorithm.getJcaName());
    }

    // 토큰 생성
    public String createToken(String username) {
        Date now = new Date();
        return Jwts.builder()
                .setSubject(username)
                .signWith(secretKey, signatureAlgorithm)
                .setExpiration(new Date(System.currentTimeMillis() + exp))
                .compact();
    }

    // 권한정보 획득
    // Spring Security 인증과정에서 권한확인을 위한 기능
    public Authentication getAuthentication(String token) {
        UserDetails userDetails = userDetailsService.loadUserByUsername(this.getAccount(token));
        return new UsernamePasswordAuthenticationToken(userDetails, "", userDetails.getAuthorities());
    }

    // 토큰에 담겨있는 유저 account 획득
    public String getAccount(String token) {
        return Jwts.parserBuilder()
        				.setSigningKey(DatatypeConverter.parseBase64Binary(salt))
        				.build()
        				.parseClaimsJws(token)
        				.getBody()
        				.getSubject();
    }

    // Authorization Header를 통해 인증을 한다.
    public String resolveToken(HttpServletRequest request) {
        return request.getHeader("Authorization");
    }

    // 토큰 검증
    public boolean validateToken(String token) {
        try {
            // Bearer 검증
            if (!token.substring(0, "BEARER ".length()).equalsIgnoreCase("BEARER ")) {
                return false;
            } else {
                token = token.split(" ")[1].trim();
            }
            Jws<Claims> claims = Jwts.parserBuilder()
            										.setSigningKey(DatatypeConverter.parseBase64Binary(salt))
            										.build()
            										.parseClaimsJws(token);
            // 만료되었을 시 false
            return !claims.getBody()
            						.getExpiration()
            						.before(new Date());
        } catch (Exception e) {
            return false;
        }
    }
}
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>

<div class="container">
	<div class="form-group">
		<label for="username">Username:</label> <input type="text" class="form-control" id="username">
	</div>
	<div class="form-group">
		<label for="password">Password:</label> <input type="password" class="form-control" id="password">
	</div>
	<button id="btn-login" class="btn btn-primary">Login</button>
<%-- 	<a id="btn-kakao" href="https://kauth.kakao.com/oauth/authorize?client_id=062868188caa38399a29c76b43a4d391&redirect_uri=http://localhost/security/auth/kakao/callback&response_type=code"><img height="38px" src ="${path}/image/kakao_login.png" /></a> --%>
</div>

<script>
$(function(){
/* 	const header = $("meta[name='_csrf_header']").attr("content");
	const token = $("meta[name='_csrf']").attr("content"); */
	
	$("#btn-login").click(function(){
		const data = {
			username: $("#username").val(),
			password: $("#password").val()
		};
 
		$.ajax({
			type: "post",
			url: "${path}/auth/login",
/* 			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			}, */
			contentType: "application/json;charset=utf-8",
			dataType: "json",
			data: JSON.stringify(data),
			success: function(result){
				if(result.status == 200){
					location.href="${path}/";
					console.log(result);
				}else{
					console.log(result);
					$("#username").val("");
					$("#password").val("");
					$("#username").focus();
					console.log(result);
				}
			},
			error: function(error){
				console.log(error);
			}
		});
	});
});
</script>
<%@ include file="../layout/footer.jsp"%>

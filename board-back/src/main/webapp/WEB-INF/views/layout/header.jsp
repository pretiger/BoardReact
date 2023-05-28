<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- csrf설정 시작-->
<%-- <meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" /> --%>
<!-- csrf설정 끝-->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
</head>
<body>

	<nav class="navbar navbar-expand-md bg-dark navbar-dark">
		<a class="navbar-brand" href="${path}/">Tiger</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="collapsibleNavbar">
			<ul class="navbar-nav">
				<c:choose>
					<c:when test="${empty principal}">
						<li class="nav-item"><a class="nav-link" href="${path}/auth/loginForm">Login</a></li>
						<li class="nav-item"><a class="nav-link" href="${path}/auth/joinForm">Join</a></li>
					</c:when>
					<c:otherwise>
<%-- 						<sec:authorize access="hasRole('ROLE_USER')">
							<li class="nav-item"><a class="nav-link" href="${path}/board/writeForm">Writing</a></li>
						</sec:authorize>
						<sec:authorize access="hasRole('ROLE_ADMIN')"> --%>
							<li class="nav-item"><a class="nav-link" href="${path}/board/writeForm">Writing</a></li>
							<li class="nav-item"><a class="nav-link" href="${path}/admin/managed">Mangement</a></li>
<!-- 						</sec:authorize> -->
						<li class="nav-item"><a class="nav-link" href="${path}/user/userInfo">Userinfo</a></li>
						<li class="nav-item"><a class="nav-link" href="javascript:;" onclick="logout()">Logout</a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</nav>
	<br />

	<script>
		function logout() {
			console.log("Logout clicked");
			$.ajax({
				url : "${path}/logout",
				success : function(result) {
					console.log(result);
					location.href = "${path}/";
				}
			});
		}
	</script>
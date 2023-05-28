<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>

<div class="container">
	<div class="form-group">
		<label for="username">Username:</label> <input type="text" class="form-control" id="username" readonly value="${dto.username}">
	</div>
	<div class="form-group">
		<label for="password">Password:</label> <input type="password" class="form-control" id="password" value="${dto.password}">
	</div>
	<div class="form-group">
		<label for="email">Email:</label> <input type="email" class="form-control" id="email" value="${dto.email}">
	</div>
	<div class="form-group">
		<label for="role">Role list:</label> <select class="form-control" id="role">
			<c:choose>
				<c:when test="${dto.role == 'ROLE_USER'}">
					<option value="ROLE_USER" selected>User</option>
					<option value="ROLE_GUEST">Guest</option>
					<option value="ROLE_ADMIN">Admin</option>
				</c:when>
				<c:when test="${dto.role == 'ROLE_GUEST'}">
					<option value="ROLE_USER">User</option>
					<option value="ROLE_GUEST" selected>Guest</option>
					<option value="ROLE_ADMIN">Admin</option>
				</c:when>
				<c:otherwise>
					<option value="ROLE_USER">User</option>
					<option value="ROLE_GUEST">Guest</option>
					<option value="ROLE_ADMIN" selected>Admin</option>
				</c:otherwise>
			</c:choose>
		</select>
	</div>
	<c:if test="${empty principal.oauth}">
		<button id="btn-update" class="btn btn-primary">Update</button>
	</c:if>
</div>

<script>
	$(function() {
/* 		const header = $("meta[name='_csrf_header']").attr("content");
		const token = $("meta[name='_csrf']").attr("content"); */

		$("#btn-update").click(function() {
			console.log("Save clicked");
			const data = {
				username : $("#username").val(),
				password : $("#password").val(),
				email : $("#email").val(),
				role : $("#role").val()
			}
			console.log(data);
			$.ajax({
				type : "put",
				url : "${path}/user/update",
/* 				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				}, */
				contentType : "application/json;charset=utf-8",
				dataType : "json",
				data : JSON.stringify(data),
				success : function(result) {
					console.log(result);
					if (result.status === 200) {
						alert("user update success!");
						location.href = "${path}/";
					} else {
						console.log("user update fail!");
					}
				},
				error : function(error) {
					console.log(error);
				}
			});
		});
	});
</script>
<%@ include file="../layout/footer.jsp"%>

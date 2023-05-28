<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- <div class="card-header">Reply List</div> -->
<ul id="reply-box" class="list-group">
	<c:forEach var="row" items="${reply}">
		<li id="reply-${row.rnum}" class="list-group-item d-flex justify-content-between">
			<div>${row.replytext}</div>
			<div class="d-flex">
				<div class="font-italic">Writer : ${row.replyer} &nbsp;</div>
				<%-- reply:${row.replyer}, principal:${principal.user.username} --%>
				<c:if test="${row.replyer == username}">
					<button class="badge" onclick="deleteComment('${row.rnum}')">Delete</button>
				</c:if>
			</div>
		</li>
	</c:forEach>
</ul>

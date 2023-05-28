<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>

<div class="container">
	<div class="form-group">
		<label for="subject">Title:</label> 
		<input type="text" class="form-control" id="subject" value="${dto.subject}">
		<input type="hidden" id="writer" value="${principal.username}">
		<input type="hidden" id="subgroup" value="${dto.subgroup}">
		<input type="hidden" id="substep" value="${dto.substep}">
		<input type="hidden" id="sublevel" value="${dto.sublevel}">
	</div>
	<div class="form-group">
		<label for="content">Content:</label> 
		<textarea rows="1" cols=""class="form-control summernote" id="content">${dto.content}</textarea>
	</div>
	<button id="btn-reply" class="btn btn-primary">Reply</button>
</div>

<script>
$(".summernote").summernote({
	tabsize: 2,
	height: 300
});

$(function(){
/* 	const header = $("meta[name='_csrf_header']").attr("content");
	const token = $("meta[name='_csrf']").attr("content"); */
	
	$("#btn-reply").click(function(){
		const data = {
			writer: $("#writer").val(),
			subject: $("#subject").val(),
			content: $("#content").val(),
			subgroup: $("#subgroup").val(),
			substep: $("#substep").val(),
			sublevel: $("#sublevel").val()
		};
		console.log(data);
		$.ajax({
			type: "post",
			url: "${path}/board/reply",
/* 			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			}, */
			data: JSON.stringify(data),
			contentType: "application/json;charset=utf-8",
			dataType: "json",
			success: function(result){
				if(result.status == 200){
					alert("reply insert success!");
					location.href="${path}/";
				}else{
					alert("Error!");
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

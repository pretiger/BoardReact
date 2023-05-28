<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>

<form name="form1" method="post" action="${path}/board/insert" enctype="multipart/form-data">
	<div class="container">
		<div class="form-group">
			<label for="subject">Title:</label> 
			<input type="text" class="form-control" id="subject" name="subject">
			<input type="hidden" id="writer"  name="writer" value="${principal.username}">
		</div>
		<div class="form-group">
			<label for="content">Content:</label> 
			<textarea rows="1" cols=""class="form-control summernote" id="content" name="content"></textarea>
		</div>
		<div class="form-group">
			<input type="file" name="files"  multiple="multiple"/>
		</div> 
	 	<button id="btn-save" class="btn btn-primary">Save</button>
	</div>
</form>

<script>
$(".summernote").summernote({
	tabsize: 2,
	height: 300
});

$(function(){
	$("#btn-save").click(function(){
		document.form1.submit();
	});
});
</script>
<%@ include file="../layout/footer.jsp"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>

<div class="container">
	<div class="card">
		<div class="card-body">
			<a href="#" class="btn btn-dark" onclick="history.back()">Back</a>
			<c:if test="${principal.username == dto.writer}">
				<a href="${path}/board/${dto.num}/updateForm" class="btn btn-primary">Update</a>
				<a href="#" class="btn btn-danger" id="btn-delete">Delete</a>
			</c:if>
			<c:if test="${principal.username != null}">
				<a href="${path}/board/${dto.num}/replyForm" class="btn btn-success">Reply</a>
			</c:if>
			<p>
				number:&nbsp;<i id="num">${dto.num}</i>&nbsp;&nbsp;writer:&nbsp;<i>${dto.writer}</i>
			</p>
			<h2 class="card-title">${dto.subject}</h2>
			<p class="card-text">${dto.content}</p>
			<p id="uploadedFile" class="card-text"></p>
		</div>
		<div class="d-flex justify-content-between">
		<form name="form1">
			<input id="num" type="hidden" name="num" value="${dto.num}">
			<input id="writer" type="hidden" name="writer" value="${principal.username}"> 
			<input id="count" type="hidden" name="count" value="${dto.count}">
		</form>
			<input id="comment" class="form-control" placeholder="Could you write a comment!">
			<button id="btn-comment" class="btn btn-primary btn-sm">Save</button>
		</div>
		<div class="card-footer" id="commentList"></div>
	</div>
</div>

<script>
$(function() {
	attachList();
	commentList();

	$("#btn-comment").click(function() {
		if($("#writer").val()==null || $("#writer").val()==""){
			console.log("writer value : ",$("#writer").val());
			alert("로그인먼저 하세요!");
			$("#comment").val("");
			return;
		}

		const data = {
			bnum : $("#num").text(),
			replyer : $("#writer").val(),
			replytext : $("#comment").val()
		};

 		$.ajax({
			type : "post",
			url : "${path}/board/comment",
			data : JSON.stringify(data),
			contentType : "application/json;charset=utf-8",
			dataType : "json",
			success : function(result) {
				console.log(result);
				if (result.status === 200) {
					commentList();
					$("#comment").val("");
				} else {
					console.log("Comment Insert Fail!");
				}
			},
			error : function(error) {
				console.log(error);
			}
		});
	});

	$("#btn-delete").click(function() {
		if(confirm("삭제 하시겠습니까?")){
			document.form1.action="${path}/board/delete";
			document.form1.submit();
		}
	});
	
	$("#fileList").on("click", "a", function(){
		var that=$(this);
		that.parent("div").remove();
	});
	
	$("#uploadedFile").on("click", "span", function(){
		var that=$(this);
		console.log(that);
		$.ajax({
			url: "${path}/board/deleteFile",
			data: {filename: $(this).attr("data-src")},
			success: function(result){
				if(result == "deleted"){
					that.parent("p").remove();
				}
			}
		});
	});
	
});

function deleteComment(rnum){
	console.log("deleteComment clicked", rnum);
	$.ajax({
		type : "delete",
		url : "${path}/deleteComment/"+rnum,
/* 		beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		}, */
		success : function(result) {
			console.log(result);
			if (result.status == 200) {
				commentList();
			} else {
				console.log("Comment Delete Fail!");
			}
		},
		error : function(error) {
			console.log(error);
		}
	});
}

function commentList(){
	const bnum = $("#num").text();
	
	$.ajax({
		url : "${path}/commentList/"+bnum,
		data: {"username": $("#writer").val()},
/* 		beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		}, */
/* 		data : JSON.stringify(data),
		contentType : "application/json;charset=utf-8",
		dataType : "json", */
		success : function(result) {
			$("#commentList").html(result);
		},
		error : function(error) {
			console.log(error);
		}
	});
}

function attachList(){
	$.ajax({
		url: "${path}/board/attachList/${dto.num}",
		success: function(result){
			$(result).each(function(){
				if("${principal.username}" == "${dto.writer}"){
					var str="<p><a href='${path}/board/downloadFile?filename="
						+this+"'>"+originalName(this)+"</a><span data-src="
						+this+"><a href='#'>  [삭제]</a></span></p>";
				}else{
					var str="<p><a href='${path}/board/downloadFile?filename="
						+this+"'>"+originalName(this)+"</a></p>";
				}
				$("#uploadedFile").append(str);
			});
		}
	});
}

function originalName(filename){
	return filename.substr(filename.lastIndexOf("_")+1);
}

function addtag(){
	str="<div><a href='#'>[Delete]</a><input type='file' name='files'></div>";
	$("#fileList").append(str);
}
</script>
<%@ include file="../layout/footer.jsp"%>

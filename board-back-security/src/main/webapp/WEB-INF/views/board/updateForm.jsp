<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>

<form name="form1" method="post" action="${path}/board/update" enctype="multipart/form-data">
<div class="container">
	<div class="form-group">
		<label for="subject">Title:</label> 
		<input type="text" class="form-control" id="subject" name="subject" value="${dto.subject}">
		<input type="hidden" id="num" name="num" value="${dto.num}">
	</div>
	<div class="form-group">
		<label for="content">Content:</label> 
		<textarea rows="1" cols=""class="form-control summernote" id="content" name="content">${dto.content}</textarea>
	</div>
	<div id="uploadedFile" class="form-group"></div>
	<c:if test="${principal.username == dto.writer}">
		<span id="fileAttach" style="color: blue;" onclick="addtag()"><a href="#">[Add]	</a></span>	
		<input type="file" name="files" ><div id="fileList"></div>
	</c:if>
	<button id="btn-update" class="btn btn-primary">Update</button>
</div>
</form>

<script>
$(".summernote").summernote({
	tabsize: 2,
	height: 300
});

$(function(){
	attachList();
	
	$("#btn-update").click(function(){
		document.form1.submit();
/* 		const data = {
			num: $("#num").val(),
			subject: $("#subject").val(),
			content: $("#content").val()
		};
		console.log(data);
		$.ajax({
			type: "put",
			url: "${path}/board/update",
			data: JSON.stringify(data),
			contentType: "application/json;charset=utf-8",
			dataType: "json",
			success: function(result){
				if(result.status == 200){
					alert("update success!");
					location.href="${path}/";
				}else{
					alert("Error!");
				}
			},
			error: function(error){
				console.log(error);
			}
		}); */
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
					that.parent("div").remove();
				}
			}
		});
	});
	
});

function attachList(){
	$.ajax({
		url: "${path}/board/attachList/${dto.num}",
		success: function(result){
			$(result).each(function(){
				if("${principal.username}" == "${dto.writer}"){
					var str="<div><a href='${path}/board/downloadFile?filename="
						+this+"'>"+originalName(this)+"</a><span data-src="
						+this+"><a href='#'>  [삭제]</a></span></div>";
				}else{
					var str="<div><a href='${path}/board/downloadFile?filename="
						+this+"'>"+originalName(this)+"</a></div>";
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

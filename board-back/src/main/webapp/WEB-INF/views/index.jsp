<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="layout/header.jsp"%>

<style>
#previewTag{
	position: absolute;
	opacity: 0.8;
	padding: 5px;
	width: 250px;
	height: auto;
	background-color: yellow;
	visibility: hidden;
}
</style>

<div class="container">
	<h2>Board List</h2>
	<div id="previewTag">Content Preview</div>
	<table class="table">
		<thead class="thead-dark">
			<tr align="center">
				<th>Number</th>
				<th>Writer</th>
				<th>Title</th>
				<th>Viewcount</th>
				<th>Date</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="list" items="${dto}">
				<tr align="center">
					<td>${list.num}</td>
					<td>${list.writer}</td>
					<td align="left">
						<a href="${path}/detailForm/${list.num}"   onmouseover="preview('${list.num}');show();" 
							onmouseout="hide();"> 
							<c:if test="${list.sublevel > 0}">
								<c:forEach begin="1" end="${list.sublevel}">&nbsp;&nbsp;</c:forEach>
							</c:if> 
							${list.subject}
							<c:if test="${list.count > 0}"><span style="color: red;">[${list.count}]</span></c:if>
						</a>
					</td>
					<td>${list.viewcount}</td>
					<td><fmt:formatDate value="${list.regdate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<ul class="pagination justify-content-center">
	<c:if test="${1 < page.curPage}">
		<li class="page-item"><a class="page-link" href="javascript:list(1)">First</a></li>
	</c:if>
	<c:if test="${1 < page.curBlock}">
		<li class="page-item"><a class="page-link" href="javascript:list('${page.prePage}')">Previous</a></li>
	</c:if>
	<c:forEach var="i" begin="${page.blockStart}" end="${page.blockEnd}">
		<c:choose>
			<c:when test="${page.curPage == i}">
				<li class="page-item"><a class="page-link" href="#" style="color: red;">${i}</a></li>
			</c:when>
			<c:otherwise>
				<li class="page-item"><a class="page-link" href="javascript:list('${i}')">${i}</a></li>
			</c:otherwise>
		</c:choose>
	</c:forEach>
	<c:if test="${page.curBlock < page.totalBlock}">
		<li class="page-item"><a class="page-link" href="javascript:list('${page.nextPage}')">Next</a></li>
	</c:if>
	<c:if test="${page.curPage < page.totalPage}">
		<li class="page-item"><a class="page-link" href="javascript:list('${page.totalPage}')">Last</a></li>
	</c:if>
</ul>
</div>

<script>
/* const header = $("meta[name='_csrf_header']").attr("content");
const token = $("meta[name='_csrf']").attr("content"); */

function list(page) {
	/* location.href = "${path}/auth/list?curPage=" + page; */
	location.href = "${path}?curPage=" + page;
}
function preview(num){
	console.log(num);
	$.ajax({
		url : "${path}/auth/preview/"+num,
/* 		beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		}, */
		success : function(result) {
			$("#previewTag").html(result);
		},
		error : function(error) {
			console.log(error);
		}
	});
}
function show(){
	$("#previewTag").css("visibility", "visible");
}
function hide(){
	$("#previewTag").css("visibility", "hidden");
}
document.onmousemove=function(){
	$("#previewTag").css("marginTop", event.y+"px");
	$("#previewTag").css("marginLeft", event.x+"px");
}
</script>

<%@ include file="layout/footer.jsp"%>

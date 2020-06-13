<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page session="false" %>

<%@ include file="/WEB-INF/views/include/header.jsp" %>

<style>
	.fileDrop {
		width: 80%;
		height: 100px;
		border: 1px dotted gray;
		background-color: lightslategrey;
		margin: auto;
	}
</style>

<form role="form" action="modifyPage" method="post">
	<input type="hidden" name="page" 		value="${cri.page }">
	<input type="hidden" name="perPageNum" 	value="${cri.perPageNum }">
	<input type="hidden" name="searchType"	value="${cri.searchType }">
	<input type="hidden" name="keyword"		value="${cri.keyword }">

	<div class="box-body">
	
		<div class="form-group">
			<label for="exampleInputEmail1">BNO</label>
			<input type="text" name='bno' class="form-control" value="${boardVO.bno}" readonly="readonly">
		</div>
		<div class="form-group">
			<label for="exampleInputEmail1">Title</label>
			<input type="text" name='title' class="form-control" value="${boardVO.title}">
		</div>
		<div class="form-group">
			<label for="exampleInputPassword1">Content</label>
			<textarea class="form-control" name="content" rows="3">${boardVO.content}</textarea>
		</div>
		<div class="form-group">
			<label for="exampleInputEmail1">Writer</label>
			<input type="text" name="writer" class="form-control" value="${boardVO.writer}">
		</div>
		<div class="form-group">
			<label for="exampleInputEmail1">File DROP Here</label>
			<div class="fileDrop"></div>
		</div>
	</div>
	<!-- /.box-body -->
	
	<div class="box-footer">
		<div>
			<hr>
		</div>

		<ul class="mailbox-attachments clearfix uploadedList">
		</ul>
		
		<button type="submit" class="btn btn-primary">SAVE</button> 
		<button type="submit" class="btn btn-warning">CANCEL</button>
	</div>
</form>

<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script src="/resources/js/handlebars-v4.7.6.js"></script>
<script src="/resources/js/upload.js"></script>

<script id="template" type="text/x-handlebars-template">
	<li>
		<span class="mailbox-attachment-icon has-img">
			<img src="{{imgsrc}}" alt="Attachment">
		</span>
		<div class="mailbox-attachment-info">
			<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
			<a href="{{fullName}}" class="btn btn-default btn-xs pull-right delbtn">
				<i class="fa fa-fw fa-remove">
				</i>
			</a>
		</div>
	</li>
</script>

<script id="templateAttach" type="text/x-handlebars-template">
	<li data-src='{{fullName}}'>
		<span class="mailbox-attachment-icon has-img">
			<img src="{{imgsrc}}" alt="Attachment">
		</span>
		<div class="mailbox-attachment-info">
			<a href="/fileupload/{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
		</div>
	</li>
</script>

<script>
	$(document).ready(function() {
		var formObj = $("form[role='form']");
		console.log(formObj);

		$(".btn-warning").on("click", function() {
			self.location = "/sboard/listPage?" + 
							"page=${cri.page}&perPageNum=${cri.perPageNum}" +
							"&searchType=${cri.searchType}&keyword=${cri.keyword}";
		});

		$(".btn-primary").on("click", function() {
			formObj.submit();
		});
	});
	
	var template = Handlebars.compile($("#template").html());
	
	$(".fileDrop").on("dragenter dragover", function(event) {
		event.preventDefault();
	});
	
	$(".fileDrop").on("drop", function(event) {
		event.preventDefault();
		
		var files = event.originalEvent.dataTransfer.files;
		var file = files[0];
		var formData = new FormData();
		
		formData.append("file", file);
		
		$.ajax({
			url: '/fileupload/uploadAjax',
			data: formData,
			dataType: 'text',
			processData: false,
			contentType: false,
			type: 'POST',
			success: function(data) {
				var fileInfo = getFileInfo(data);
				var html = template(fileInfo);
				
				$(".uploadedList").append(html);
			}
		});
	});
	
	$(".uploadedList").on("click", ".delbtn", function(event) {
		event.preventDefault();
		
		var that = $(this);
		 
		$.ajax({
			url: "/fileupload/deleteFile",
			type: "post",
			data: {
					fileName: $(this).attr("href")
				},
			dataType: "text",
			success: function(result) {
				if(result == 'deleted') {
					that.closest("li").remove();
				}
			}
		});
	});
	
	var bno = ${boardVO.bno};
	var template = Handlebars.compile($("#templateAttach").html());
	
	$.getJSON("/sboard/getAttach/" + bno, function(list) {
		$(list).each(function() {
			var fileInfo = getFileInfo(this);
			var html = template(fileInfo);
			
			$(".uploadedList").append(html);
		});
	});
	
	$(".uploadedList").on("click", ".mailbox-attachment-info a", function(event) {
		var fileLink = $(this).attr("href");
		
		if(checkImageType(fileLink)) {
			event.preventDefault();			// 화면이동 방지
			
			var imgTag = $("#popup_img");
			imgTag.attr("src", fileLink);
			
			console.log(imgTag.attr("src"));
			
			$(".popup").show('slow');
			imgTag.addClass("show");
		}
	});
	
	$("#popup_img").on("click", function() {
		$(".popup").hide('slow');
	});
</script>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>

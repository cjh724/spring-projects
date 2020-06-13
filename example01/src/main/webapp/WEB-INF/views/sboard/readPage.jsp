<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page session="false" %>

<%@ include file="/WEB-INF/views/include/header.jsp" %>
<style type="text/css">
	.popup {
		position: absolute;
	}
	.back {
		background-color: gray;
		opacity: 0.5;
		width: 100%;
		height: 300%;
		overflow: hidden;
		z-index: 1101;
	}
	.front {
		z-index: 1110;
		opacity: 1;
		boarder: 1px;
		margin: auto;
	}
	.show {		/* 팝업이미지 맨 아래에 뜸(브라우저 중앙에 오도록 수정해야 함) */
		position: relative;
		max-width: 1200px;
		max-height: 800px;
		overflow: auto;
	}
</style>

<script src="/resources/js/handlebars-v4.7.6.js"></script>
<script src="/resources/js/upload.js"></script>

<script id="template" type="text/x-handlebars-template">
	{{#each .}}
		<li class="replyLi" data-rno={{rno}}>
			<i class="fa fa-comments bg-blue"></i>
			<div class="timeline-item">
				<span class="time">
					<i class="fa fa-clock-o"></i>{{prettifyDate regdate}}
				</span>
				<h3 class="timeline-header"><strong>{{rno}}</strong> -{{replyer}}</h3>
				<div class="timeline-body">{{replytext}}</div>
				<div class="timeline-footer">
					<a class="btn btn-primary btn-xs" data-toggle="modal" data-target="#modifyModal">Modify</a>
				</div>
			</div>
		</li>
	{{/each}}
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
	Handlebars.registerHelper("prettifyDate", function(timeValue) {
		var dateObj = new Date(timeValue);
		var year = dateObj.getFullYear();
		var month = dateObj.getMonth() + 1;
		var date = dateObj.getDate();
		
		return year + "/" + month + "/" + date;
	});
	
	var printDate = function(replyArr, target, templateObject) {
		var template = Handlebars.compile(templateObject.html());
		var html = template(replyArr);
		
		$(".replyLi").remove();
		target.after(html);
	};

	function getPage(pageInfo) {
		$.getJSON(pageInfo, function(data) {
			printDate(data.list, $("#repliesDiv"), $("#template"));
			printPaging(data.pageMaker, $(".pagination"));
			
			$("#modifyModal").modal('hide');
			$("#replycntSmall").html("[ " + data.pageMaker.totalCount + " ]");
		});
	}

	var printPaging = function(pageMaker, target) {
		var str = "";
		
		if(pageMaker.prev) {
			str += "<li><a href='" + (pageMaker.startPage - 1) + "'> << </a></li>";
		}
		
		for(var i=pageMaker.startPage, len=pageMaker.endPage; i<=len; i++) {
			var strClass = pageMaker.cri.page == i ? 'class=active' : '';
			str += "<li " + strClass + "><a href='" + i + "'>" + i + "</a></li>";
		}
		
		if(pageMaker.next) {
			str += "<li><a href='" + (pageMaker.endPage + 1) + "'> >> </a></li>";
		}
		
		target.html(str);
	};
</script>

<script>
	$(document).ready(function() {
		var formObj = $("form[role='form']");
		var bno = ${boardVO.bno};
		var replyPage = 1;
		
		// console.log(formObj);
		
		$("#modifyBtn").on("click", function() {
			formObj.attr("action", "/sboard/modifyPage");
			formObj.attr("method", "get");
			formObj.submit();
		});
		
		$("#removeBtn").on("click", function() {
			formObj.attr("action", "/sboard/removePage");
			formObj.submit();
		});
		
		$("#goListBtn").on("click", function() {
			formObj.attr("method", "get");
			formObj.attr("action", "/sboard/list");
			formObj.submit();
		});
		
		$("#repliesDiv").on("click", function() {
			if($(".timeline li").size() > 1) {
				return;
			}
			
			getPage("/replies/" + bno + "/1");
		});

		$(".pagination").on("click", "li a", function(event) {
			event.preventDefault();
			replyPage = $(this).attr("href");
			
			getPage("/replies/" + bno + "/" + replyPage);
		});
		
		$("#replyAddBtn").on("click", function() {
			var replyerObj = $("#newReplyWriter");
			var replytextObj = $("#newReplyText");
			var replyer = replyerObj.val();
			var replytext = replytextObj.val();
			
			$.ajax({
				type : 'post',
				url : '/replies/',
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				dataType : 'text',
				data : JSON.stringify({
					bno : bno,
					replyer : replyer,
					replytext : replytext
				}),
				success : function(result) {
					console.log("result : " + result);
					
					if(result == 'success') {
						alert("등록 되었습니다.");
						replyPage = 1;
						getPage("/replies/" + bno + "/" + replyPage);
						replyerObj.val("");
						replytextObj.val("");
					}
				}
			});
		});
		
		$(".timeline").on("click", ".replyLi", function(event) {
			var reply = $(this);
			
			$("#replytext").val(reply.find('.timeline-body').text());
			$(".modal-title").html(reply.attr("data-rno"));
		});
		
		$("#replyModBtn").on("click", function() {
			var rno = $(".modal-title").html();
			var replytext = $("#replytext").val();
			
			$.ajax({
				type : 'put',
				url : '/replies/' + rno,
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "PUT"
				},
				data : JSON.stringify({
					replytext : replytext
				}),
				dataType : 'text',
				success : function(result) {
					console.log("result : " + result);
					
					if(result == 'success') {
						alert("수정 되었습니다.");
						getPage("/replies/" + bno + "/" + replyPage);
					}
				}
			});
		});
		
		$("#replyDelBtn").on("click", function() {
			var rno = $(".modal-title").html();
			var replytext = $("#replytext").val();

			$.ajax({
				type : 'delete',
				url : '/replies/' + rno,
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "DELETE"
				},
				dataType : 'text',
				success : function(result) {
					console.log("result : " + result);
					
					if(result == 'success') {
						alert("삭제 되었습니다.");
						getPage("/replies/" + bno + "/" + replyPage);
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
		

		
	});
</script>

<form role="form" action="modifyPage" method="post">
	<input type='hidden' name='bno' 		value="${boardVO.bno}">
	<input type="hidden" name="page" 		value="${cri.page }">
	<input type="hidden" name="perPageNum"	value="${cri.perPageNum }">
	<input type="hidden" name="searchType"	value="${cri.searchType }">
	<input type="hidden" name="keyword"		value="${cri.keyword }">
</form>

<div class="box-body">
	<div class="form-group">
		<label for="exampleInputEmail1">Title</label>
		<input type="text" name="title" class="form-control" value="${boardVO.title }" readonly="readonly">
	</div>
	<div class="form-group">
		<label for="exampleInputPassword1">Content</label>
		<textarea class="form-control" name="content" rows="3" readonly="readonly">${boardVO.content }</textarea>
	</div>
	<div class="form-group">
		<label for="exampleInputEmail1">Writer</label>
		<input type="text" name="writer" class="form-control" value="${boardVO.writer }" readonly="readonly">
	</div>
</div>
<!-- /.box-body -->

<ul class="mailbox-attachments clearfix uploadedList"></ul>

<div class="box-footer">
	<button type="submit" class="btn btn-warning" id="modifyBtn">Modify</button>
	<button type="submit" class="btn btn-danger" id="removeBtn">REMOVE</button>
	<button type="submit" class="btn btn-primary" id="goListBtn">LIST ALL</button>
</div>

<div class="row">
	<div class="col-md-12">
		<div class="box box-success">
			<div class="box-header">
				<h3 class="box-title">ADD NEW REPLY</h3>
			</div>
			<div class="box-body">
				<label for="newReplyWriter">Writer</label>
				<input class="form-control" type="text" placeholder="USER ID" id="newReplyWriter">
				<label for="newReplyText">ReplyText</label>
				<input class="form-control" type="text" placeholder="REPLY TEXT" id="newReplyText">
			</div>
			<div class="box-footer">
				<button type="submit" class="btn btn-primary" id="replyAddBtn">ADD REPLY</button>
			</div>
		</div>
	</div>
</div>

<ul class="timeline">
	<li class="time-label" id="repliesDiv">
		<span class="bg-green">Replies List <small id='replycntSmall'> [ ${boardVO.replycnt } ] </small></span>
	</li>
</ul>

<div class="text-center">
	<ul id="pagination" class="pagination pagination-sm no-margin">
	</ul>
</div>

<!-- Modal -->
<div id="modifyModal" class="modal modal-primary fade" role="dialog">
	<div class="modal-dialog">
		<!-- Modal content -->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title"></h4>
			</div>
			<div class="modal-body" data-rno>
				<p><input type="text" id="replytext" class="form-control"></p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" id="replyModBtn">Modify</button>
				<button type="button" class="btn btn-danger" id="replyDelBtn">DELETE</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<div class='popup back' style="display:none;"></div>
<div id="popup_front" class="popup front" style="display:none;">
	<img id="popup_img">
</div>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>

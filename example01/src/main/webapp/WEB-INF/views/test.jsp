<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
	#modDiv {
		width : 300px;
		height : 100px;
		background-color : gray;
		position : absolute;
		top : 50%;
		left : 50%;
		margin-top : -50px;
		margin-left : -150px;
		padding : 10px;
		z-index : 1000;
	}
	.pagination {
		width: 100%;
	}

	.pagination li{
		list-style: none;
		float: left; 
		padding: 3px; 
		border: 1px solid blue;
		margin:3px;  
	}

	.pagination li a{
		margin: 3px;
		text-decoration: none;  
	}
</style>
<html>
	<head>
		<title>Ajax Test</title>
		<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
	</head>
	<body>
		<h2>Ajax Test Page</h2>
		
		<div>
			<div>
				Replyer <input type='text' name='replyer' id='newReplyWriter'>
			</div>
			<div>
				Reply Text <input type='text' name='replytext' id='newReplyText'>
			</div>
			<button id="replyAddBtn">Add Reply</button>
			<button id="getAllList">All List</button>
		</div>
		
		<ul id="replies">
		</ul>
		
		<div id="modDiv" style="display: none;">
			<div class="modal-title"></div>
			<div>
				<input type="text" id="replytext">
			</div>
			<div>
				<button type="button" id="replyModBtn">Modify</button>
				<button type="button" id="replyDelBtn">Delete</button>
				<button type="button" id="closeBtn">Close</button>
			</div>
		</div>
		
		<ul class="pagination">
		</ul>
		
		<script type="text/javascript">
			var bno = 32761;
			getPageList(0);
		
			$("#replyAddBtn").on("click", function() {			// 댓글 등록
				var replyer = $("#newReplyWriter").val();
				var replytext = $("#newReplyText").val();
				
				$.ajax({
					type : 'post',
					url : '/replies',
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
						if(result == 'success') {
							alert("등록되었습니다.");
							getAllList();
						}
					}
				});
			});
			
			$("#getAllList").on("click", function() {		// 리스트 보기
				getAllList();
			});
			
			$("#replies").on("click", ".replyLi button", function() {		// 각각의 댓글에서 modal 창 발생
				var reply = $(this).parent();
				
				var rno = reply.attr("data-rno");
				var replytext = reply.text();
				
				// alert(rno + " : " + replytext);
				$(".modal-title").html(rno);
				$("#replytext").val(replytext);
				$("#modDiv").show("slow");
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
							
							$("#modDiv").hide("slow");
							getAllList();
						}
					}
				});
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
							$("#modDiv").hide("slow");
							getPageList(replyPage);
						}
					}
				})
			});
			
			var replyPage = 1;
			$(".pagination").on("click", "li a", function(event) {
				event.preventDefault();
				replyPage = $(this).attr("href");
				getPageList(replyPage);
			});
			
			function getAllList() {
				$.getJSON("/replies/all/" + bno, function(data) {
					var str = "";
					console.log(data.length);
					
					$(data).each(function() {
						str += "<li data-rno='"+this.rno+"' class='replyLi'>"
							+ this.rno + " : " + this.replytext
							+ "<button>MOD</button>"
							+ "</li>";
					});
					
					$("#replies").html(str);
				});
			}

			function getPageList(page) {
				$.getJSON("/replies/" + bno + "/" + page, function(data) {
					console.log(data.list.length);
					
					var str = "";
					
					$(data.list).each(function() {
						str += "<li data-rno='" + this.rno + "' class='replyLi'>"
							+ this.rno + " : " + this.replytext
							+ "<button>MOD</button></li>";
					});
					
					$("#replies").html(str);
					
					printPaging(data.pageMaker);
				});
			}
			
			function printPaging(pageMaker) {
				var str = "";
				
				if(pageMaker.prev) {
					str += "<li><a href='" + (pageMaker.startPage-1) + "'> << </a><li>";
				}
				
				for(var i=pageMaker.startPage, len=pageMaker.endPage; i <= len; i++) {
					var strClass = pageMaker.cri.page == i ? 'class=active' : '';
					str += "<li " + strClass + "><a href='" + i + "'>" + i + "</a></li>";
				}
				
				if(pageMaker.next) {
					str += "<li><a href='" + (pageMaker.endPage + 1) + "'> >> </a></li>";
				}
				
				$('.pagination').html(str);
			}
		</script>
	</body>
</html>
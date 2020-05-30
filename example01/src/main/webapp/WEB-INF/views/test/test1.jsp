<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>		<!-- 코어 태그 라이브러리 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>		<!-- 국제화 태그 라이브러리 -->

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<c:set var="name2" value="손흥민"/>
	<c:set var="club2" value="토트넘"/>
	테스트1
	
	<br>
	<c:if test="true">
		테스트2
	</c:if>
	<br>
	
	<c:if test="${17 < age }">
		당신의 나이는 ${age }세
	</c:if>
	
	<h4>1부터 100까지 홀수의 합</h4>
	<c:set var="sum" value="0"/>
	<c:forEach var="i" begin="1" end="100" step="2">
		<c:set var="sum" value="${sum + i }"/>
	</c:forEach>
	결과 = ${sum }
	<br>
	<c:set var="intArray" value="${intArr }"/>
	${intArray[0] }, ${intArray[1] }, ${intArray[2] }
	
	<h4>int형 배열</h4>
	<c:forEach var="i" items="${intArray }" begin="2" end="4" varStatus="status">
		${status.index } - ${status.count } - [${i }] <br>
	</c:forEach>
	
	<br>
	이름 : ${name }, 소속팀 : ${club }<br>
	이름 : ${name2 }, 소속팀 : ${club2 }
</body>
</html>
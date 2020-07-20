<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 현제 페이지가 정상적으로 응답되는 페이지임을 지정하는 코드이다. 이 코드를 생랴하면 웹 브라우저는 자체적으로 제공하는 -->
<%response.setStatus(HttpServletResponse.SC_OK); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>500에러페이지</title>
</head>
<body>
서비스 사용에 불편을 끼쳐드려서 대단히 죄송합니다.
빠른 시간 내에 문제를 처리하겠습니다.
</body>
</html>
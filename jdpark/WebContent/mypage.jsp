<%@page import="ch13.model.LoginDataBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<jsp:include page="include.jsp" flush="false">
	<jsp:param name="titlee" value="My Page" /> 
</jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	div{
		position:relative;
		top:3rem;
	}
</style>
</head>
<body>
<%
//<!-- <input type="button" value="회원탈퇴" onclick="document.location.href='writeForm.jsp?num=<%!--=num>'"> -->	
String id =(String) session.getAttribute("id");
String nickname=(String) session.getAttribute("nickname");
if(nickname==null){

%>
			<script>
			alert("로그인을 해주세요");
			history.go(-1);	
			</script>
<%}

if(nickname!=null && request.getAttribute("check")!=null ){
	int check =	(int)request.getAttribute("check");
		if(check==1){
			 request.setAttribute("check",2);
%>
<script>
var name = '<%=nickname%>'; 
alert(name+"님 반갑습니다. ");
</script> 
<%}}%>
<div>
<form name="form"  action="listShopping.jsp">
<p><%=nickname%>님 환영합니다	</p>
<br>
<input type="submit" value="게시물 " >
<input type="button" value="회원정보" onclick="window.location='mypageUpdate.jsp'">
<input type="button" value="로그아웃" onclick="window.location='logoutPro.jsp'">
<input type="button" value="회원 탈퇴" onclick="window.location='memberDelete.jsp'">
</form>
</div>
</body>
</html>
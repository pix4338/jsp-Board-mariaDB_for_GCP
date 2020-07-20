<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<%request.setCharacterEncoding("utf-8"); %>
<%
	
	if(request.getAttribute("str")!=null){
		String str = (String)request.getAttribute("str");
		if(!str.equals("회원탈퇴 완료")){
%>				<script>
					var str = '<%=str%>'; 
					alert(str);
					
					history.go(-1);	
				</script>
<%		}else{%>
				<script>
					var str = '<%=str%>'; 
					alert(str);
					location.href="shopping.jsp";
				</script>
<%
session.invalidate();
}}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
</head>
<body>
<!-- 비밀번호인증 -->

<form method="post" name="form" action="memberDelete.do">
비밀번호 : <input type="text"  name="pwd" id="pwd"><br>
비밀번호 재확인 : <input type="text"  name="pwdCheck" id="pwdCheck">
<input type="submit" value="확인">
<input type="button" value="취소" onclick="window.location='shopping.jsp'"/>


</form>
</body>
</html>
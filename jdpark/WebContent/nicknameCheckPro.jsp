<%@page import="ch13.model.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
 	String nickname= request.getParameter("nickname");
	if(nickname== null)
		nickname= "";
	BoardDBBean dbPro = BoardDBBean.getInstance();
	int num = dbPro.NicknameCheck(nickname);
	if(num==1){
%> 
<script>
	alert("이미 사용중인 닉네임입니다.");
	history.go(-1);
</script>
<%
}else if(num==2){
%> 
 <script>
	alert("닉네임을 입력해주세요");
	history.go(-1);
</script>
<%	
}else if(num==3){
%>
<script>
	alert("닉네임 사용 가능");
	history.go(-1);
</script>
<%}%>

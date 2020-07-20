<%@page import="ch13.model.BoardDBBean"%>
<%@page import="ch13.model.LoginDataBean"%>
<%@page import="ch13.model.BoardDataBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<%! // 정의부//선언부
// 함수
// 전역변수

%>

<% 	request.setCharacterEncoding("UTF-8");
	LoginDataBean logDb = new LoginDataBean();
	String nickname= logDb.getNickname();
	if(session.getAttribute("id")!=null){
		String id =(String) session.getAttribute("id");
		BoardDBBean dbPro = BoardDBBean.getInstance();
		logDb = dbPro.checkIdPw(id);
		 if(logDb.getEmail()==null){
		   logDb.setEmail("");
	   }
	}
	if(logDb.getEmail()==null){
		logDb.setEmail("");
	}
  int num = 0, ref = 1, re_step = 0, re_level = 0;
  String strV = "";
  try{
    if(request.getParameter("num")!=null){//읽어나온게 있다면 순서를 채워준다.
	   num=Integer.parseInt(request.getParameter("num"));
	   ref=Integer.parseInt(request.getParameter("ref"));
	   re_step=Integer.parseInt(request.getParameter("re_step"));
	   re_level=Integer.parseInt(request.getParameter("re_level"));
	  
    }

%>
<jsp:include page="include.jsp" flush="false">
	<jsp:param name="titlee" value="글 작성" /> 
</jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
    <!-- <link rel="stylesheet" href="../reset.css" /> -->
    <title>게시판</title>

<script type="text/javascript" src="script.js"></script>
<style>
	#table{
		margin: 0 auto;
		border:15px solid blakc;
		width:100%;
		height:100%;
		
	}
	#table_div{
		position: relative;
		margin: 0 auto;
		left:8rem;
		top:1.3rem;
		width:35rem;
		height:35rem;
		border:1px solid balck;
	}
</style>
	
<!-- enctype="multipart/form-data"반드시 post방식으로 해야한다. -->
<form method="post" action="writePro.do"enctype="multipart/form-data">
		<!-- 히든으로 채워준다 -->
		<input type="hidden" name="num" value="<%=num%>"> 
		<input type="hidden" name="ref" value="<%=ref%>"> 
		<input type="hidden" name="re_step" value="<%=re_step%>">
		<input type="hidden" name="re_level" value="<%=re_level%>">
		<input type="hidden" name="writer" value="<%=logDb.getNickname() %>">
		<div id="table_div">
		<a href="listShopping.jsp"> 글목록</a></td>
		<table id="table">
			<tr>
				<td width="70" bgcolor="Beige" align="center">이 름</td>
				<td width="330" align="left">
				<p style="ime-mode: active;"><%=logDb.getNickname() %></p></td>
				
				<!--active:한글-->
			</tr>
			<tr>
				<td width="70" bgcolor="Beige" align="center">제 목</td>
				<td width="330" align="left"><input type="text" size="40"
					maxlength="50" name="subject" value="<%=strV%>"
					style="ime-mode: active;"></td>
			</tr>
			<tr>
				<td width="70" bgcolor="Beige" align="center">Email</td>
				<td width="330" align="left">
				<input type="text" size="40" maxlength="30" name="email" style="ime-mode: inactive;" value="<%=logDb.getEmail()%>"></td>
				<!--inactive:영문-->
			</tr>
			<tr>
				<td width="70" bgcolor="Beige" align="center">내 용</td>
				<td width="330" align="left"><textarea name="content" rows="13"
						cols="40" style="ime-mode: active;"></textarea></td>
			</tr>
			<!-- yji.a for file upload -->
				<tr>
				<td width="70" bgcolor="Beige" align="center">파일선택</td>
				<td width="330" align="left">
				<input type="file" name="selectfile"></td>
			</tr>
			<tr>
				<td width="70" bgcolor="Beige" align="center">비밀번호</td>
				<td width="330" align="left"><input type="password" size="8" maxlength="12" name="passwd" style="ime-mode: inactive;" value="<%=logDb.getPwd()%>"></td>
			</tr>
			<tr>
				<td colspan=2 bgcolor="Beige" align="center">
				<input type="submit" value="글쓰기">
				 <input type="reset" value="다시작성"> 
				 <input type="button" value="목록보기" OnClick="window.location='listShopping.jsp'"></td>
			</tr>
		</table>
	</form>
	</div>
</body>
</html>
<%
  }catch(Exception e){
	  e.printStackTrace();
  }
%>
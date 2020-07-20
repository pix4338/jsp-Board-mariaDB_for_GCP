<%@page import="ch13.model.BoardDataBean"%>
<%@page import="ch13.model.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<%@ include file="color.jspf"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:include page="include.jsp" flush="false">
	<jsp:param name="titlee" value="글 수정" /> 
</jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"/>
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
		width:35rem;
		height:35rem;
		border:1px solid balck;
	}
</style>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
  int num = Integer.parseInt(request.getParameter("num"));
  String pageNum = request.getParameter("pageNum");
  //String writer = request.getParameter("writer");

  try{
	  BoardDBBean dbPro = BoardDBBean.getInstance(); 
	  BoardDataBean article =  dbPro.updateGetArticle(num);
if(session.getAttribute("nickname")!=null){
	String nickname=(String) session.getAttribute("nickname");
		 if(!article.getWriter().equals(nickname)){
%>		 <script>
		alert("작성자가 아니에요")
		history.go(-1)
 	     </script>
<%}}
%>

<br>
<form method="post" name="writeform" 
action="updatePro.jsp?pageNum=<%=pageNum%>" onsubmit="return writeSave()">
<div id="table_div">
<a href="listShopping.jsp"> 글목록</a></td>
<table id="table">
  <tr>
    <td  width="70"  bgcolor="Beige" align="center">이 름</td>
    <td align="left" width="330">
    <p><%=article.getWriter()%></p>
       <!-- <input type="text" size="10" maxlength="10" name="writer" 
         value="<%=article.getWriter()%>" style="ime-mode:active;"> -->
	   <input type="hidden" name="num" value="<%=article.getNum()%>"></td>
  </tr>
  <tr>
    <td  width="70"  bgcolor="Beige" align="center" >제 목</td>
    <td align="left" width="330">
       <input type="text" size="40" maxlength="50" name="subject"
        value="<%=article.getSubject()%>" style="ime-mode:active;"></td>
  </tr>
  <tr>
    <td  width="70"  bgcolor="Beige" align="center">Email</td>
    <td align="left" width="330">
       <input type="text" size="40" maxlength="30" name="email" 
        value="<%=article.getEmail()%>" style="ime-mode:inactive;"></td>
  </tr>
  <tr>
    <td  width="70"  bgcolor="Beige" align="center" >내 용</td>
    <td align="left" width="330">
     <textarea name="content" rows="13" cols="40" 
       style="ime-mode:active;"><%=article.getContent()%></textarea></td>
  </tr>
  <tr>
    <td  width="70"  bgcolor="Beige" align="center" >비밀번호</td>
    <td align="left" width="330" >
     <input type="password" size="8" maxlength="12" 
               name="passwd" style="ime-mode:inactive;">
     
	 </td>
  </tr>
  <tr>      
   <td colspan=2 bgcolor="Beige" align="center">
	 
		 <input type="submit" value="글수정" >  
 
     <input type="reset" value="다시작성">
     <input type="button" value="목록보기" 
       onclick="document.location.href='listShopping.jsp?pageNum=<%=pageNum%>'">
				</td>
			</tr>
		</table>
		</div>
	</form>
	<%
}catch(Exception e){}%>

</body>
</html>
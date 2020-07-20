<%@page import="ch13.model.BoardDataBean"%>
<%@page import="ch13.model.BoardDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="color.jspf"%>
<jsp:include page="include.jsp" flush="false">
	<jsp:param name="titlee" value="글 내용 보기" /> 
</jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 내용 보기</title>
<style>
	#table{
		margin: 0 auto;
		border:15px solid blakc;
		text-align = center;
		//width:100%;
		//height:100%;
		
	}
	#table_div{
		position: relative;
		margin: 0 auto;
		left:8rem;
		top:3rem;
		width:35rem;
		height:35rem;
		border:1px solid balck;
	}
	img{
		width:50%;
		height:50%;
	}
	td{
		width:35rem;
	
	}
</style>

<script type="text/javascript">
function download(filename) {
	//downloadFrm폼 태그 value에 filename을 널어줘라
	document.downloadFrm.filename.value=filename;
	//현제 있는 도큐먼트에서 실행해줘라.
	document.downloadFrm.submit();
}
</script>
</head>
<body >
	<%
   int num = Integer.parseInt(request.getParameter("num"));
   String pageNum = request.getParameter("pageNum");
   SimpleDateFormat sdf = 
        new SimpleDateFormat("yyyy-MM-dd HH:mm");
   try{
      BoardDBBean dbPro = BoardDBBean.getInstance(); 
      BoardDataBean article =  dbPro.getArticle(num);
  
	  int ref=article.getRef();
	  int re_step=article.getRe_step();
	  int re_level=article.getRe_level();
	  
%>	
	

<form name="contentFrm">
<div id="table_div">
<table id="table">  
  <tr height="30">
    <td align="center" width="125"  bgcolor="Beige">글번호</td>
    <td align="center" width="125" align="center">
	     <%=article.getNum()%></td>
    <td align="center" width="125" bgcolor="Beige">조회수</td>
    <td align="center" width="125" align="center">
	     <%=article.getReadcount()%></td>
  </tr>
  <tr height="30">
    <td align="center" width="125" bgcolor="Beige">작성자</td>
    <td align="center" width="125" align="center">
	     <%=article.getWriter()%></td>
    <td align="center" width="125" bgcolor="Beige" >작성일</td>
    <td align="center" width="125" align="center">
	     <%= sdf.format(article.getReg_date())%></td>
  </tr>
  <tr height="30">
    <td align="center" width="125" bgcolor="Beige">글제목</td>
    <td align="center" width="375" align="center" colspan="3">
	     <%=article.getSubject()%></td>
			</tr>
  <tr>
    <td align="center" width="125" bgcolor="Beige">글내용</td>
    <td align="left" width="375"  height="75" colspan="3">
           <pre>
           <%
           String filenameImg = article.getFileName();
           if( filenameImg !=null && !filenameImg.equals("")) { %>
	            <img src="fileSave/<%=filenameImg %>" />
	           </a>
           <%=article.getContent()%></pre></td>
          <%} %> 
  </tr>
  <tr>
    <td align="center" width="125" bgcolor="Beige">파일다운로드</td>
    <td align="left" width="375" height="20" colspan="3">
           <%
           String filename = article.getFileName();
           if( filename !=null && !filename.equals("")) { %>
	           <a href="javascript:download('<%=filename %>')">
	           <%=filename %>
	           </a>
           <%} else { %>
           파일이 없습니다.
           <%}  %>
    </td>
  </tr>
			
			<tr height="30">
    <td colspan="4" bgcolor="" align="right" > 
    <%   if(session.getAttribute("nicname")!=null){
	String nicname =(String) session.getAttribute("nicname");
		 if(article.getWriter().equals(nicname)){
%>	
<input type="button" value="글수정" 
       onclick="document.location.href='updateForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">
	   &nbsp;&nbsp;&nbsp;&nbsp;
	   <input type="button" value="글삭제" 
       onclick="document.location.href='deleteForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">
	   &nbsp;&nbsp;&nbsp;&nbsp;
<%}}
%>
	  
	  
      <input type="button" value="답글쓰기" 
       onclick="document.location.href='writeForm.jsp?num=<%=num%>&ref=<%=ref%>&re_step=<%=re_step%>&re_level=<%=re_level%>'">
	   &nbsp;&nbsp;&nbsp;&nbsp;
       <input type="button" value="글목록" 
					onclick="document.location.href='listShopping.jsp?pageNum=<%=pageNum%>'">
				</td>
			</tr>
		</table>
		</div>
		<%
 }catch(Exception e){} 
 %>
	</form>
	<form name="downloadfrm" action="downloadPro.jsp"method="post">
	<input type="hidden"name="filename">
	</form>
</body>
</html>
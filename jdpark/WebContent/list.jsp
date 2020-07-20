<%@page import="ch13.model.BoardDataBean"%>
<%@page import="java.util.List"%>
<%@page import="ch13.model.BoardDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="color.jspf"%>
<%!int pageSize = 2;
	//
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");//MM분이랑 구분하기 위해서HH24시간 표기
%>

<%
    String id =(String) session.getAttribute("id");
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null) {//request.getParameter 다음에는 반드시 null검사를 해줘야한다.
		pageNum = "1";//지금 현제 페이지수
	}
	%>
	<% 
	//<페이지 계산>
	int currentPage = Integer.parseInt(pageNum);//1//2(페이지안에 숫자만 들어와야 정상 작동한다.)
	int startRow = (currentPage - 1) * pageSize + 1;//1 //11
													//총 글 갯수가35개 있으면 page는 [1][2][3]
													//1.1~10 /2.11~20/3.21~30/4.31~40
	int endRow = currentPage * pageSize;//10 1부터 10까지 나타내겠다//20
	int count = 0;
	int number = 0;
	//</페이지 계산>
	List<BoardDataBean> articleList = null;

	BoardDBBean dbPro = BoardDBBean.getInstance();//db연결
	count = dbPro.getArticleCount();// 현제 몇개 까지 있는지 읽어나옴
	//1개이상 있다면
	//mysql 의 limit기능 (시작하는 index,몇개)
	//articleList = dbPro.getArticles(startRow,pageSize);//읽어나오기로함(1,10)(시작번호,끝번호)
	//oracle은 runum(시작하는index,끝나는 index)
	if (count > 0) {
		articleList = dbPro.getArticles(startRow, endRow);
	}
	number = count - (currentPage - 1) * pageSize;
%>
<html>
<head>
<link href="style.css?after" rel="stylesheet" type="text/css">
<title>게시판</title>
</head>
   <header class="manu">

<p>글목록(전체 글:<%=count%>)</p>
<p><%=id %>님</p>
<!-- <div class="container"> -->
<table >
  <tr>
    <td align="right" bgcolor="<%=value_c%>">
       <a href="writeForm.jsp">글쓰기</a>
    </td>
  </tr>
</table>

<% if (count == 0) { %>
<table>
<tr>
    <td align="center">
              게시판에 저장된 글이 없습니다.
    </td>
</table>

<% } else {%>
<table class="table table-hover"> 
	<thead>
		<tr height="30" bgcolor="<%=value_c%>">
			<th align="center" width="50">번 호</td>
			<th align="center" width="250">제 목</td>
			<th align="center" width="100">작성자</td>
			<th align="center" width="150">작성일</td>
			<th align="center" width="50">조 회</td>
			<th align="center" width="100">IP</td>
		</tr>
    </thead>
		<%
			for (int i = 0; i < articleList.size(); i++) {
					BoardDataBean article = articleList.get(i);
		%>
		<tr height="30">
			<td width="50"><%=number--%></td>
			<td width="250" align="left">
				<%
				int wid = 0;
				if (article.getRe_level() > 0) {
					wid = 5 * (article.getRe_level());
				%>
	  <img src="images/level.png" width="<%=wid%>" height="16">
	  <img src="images/re.png">
<%  }else{%>
	  <img src="images/level.png" width="<%=wid%>" height="16">
<%  }%>
           
      <a href="content.do?num=<%=article.getNum()%>&pageNum=<%=currentPage%>">
           <%=article.getSubject()%></a> 
<% if(article.getReadcount()>=20){%>
         <img src="images/hot.gif" border="0"  height="16"><%}%> </td>
    <td width="100" align="left"> 
       <a href="mailto:<%=article.getEmail()%>">
                     <%=article.getWriter()%></a></td>
    <td width="150"><%= sdf.format(article.getReg_date())%></td>
    <td width="50"><%=article.getReadcount()%></td>
    <td width="100" ><%=article.getIp()%></td>
  </tr>
<%}%>
</table>
<%}%>

<%
    if (count > 0) {
        int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage =1;
		
		if(currentPage % 10 != 0)
           startPage = (int)(currentPage/10)*10 + 1;
		else
           startPage = ((int)(currentPage/10)-1)*10 + 1;

		int pageBlock = 10;
        int endPage = startPage + pageBlock - 1;
        if (endPage > pageCount) endPage = pageCount;
        
        if (startPage > 10) { %>
          <a href="list.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
<%      }
        
        for (int i = startPage ; i <= endPage ; i++) {  %>
           <a href="list.jsp?pageNum=<%= i %>">[<%= i %>]</a>
<%      }
        
        if (endPage < pageCount) {  %>
        <a href="list.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
<%
        }
    }
%>
<!-- </div> -->
</header>
</body>
</html>
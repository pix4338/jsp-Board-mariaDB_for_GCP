<%@page import="ch13.model.BoardDataBean"%>
<%@page import="java.util.List"%>
<%@page import="ch13.model.BoardDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@include file="color.jspf"%>
<%!int pageSize = 10;
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");//MM분이랑 구분하기 위해서HH24시간 표기
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<%
	if((String)session.getAttribute("id")==null){
		%><script>
		alert("회원만 게시물 이용 가능합니다.");
		history.go(-1);	
		</script>
	<%}
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

	String opt = request.getParameter("opt");
	String condition = request.getParameter("condition");
	
	BoardDBBean dbPro = BoardDBBean.getInstance();//db연결
	if(opt !=null){
		count = dbPro.getSearchArticleCount(opt, condition);// 현제 몇개 까지 있는지 읽어나옴
	}else {
		count = dbPro.getArticleCount();// 현제 몇개 까지 있는지 읽어나옴
	}
	
	//1개이상 있다면
	//mysql 의 limit기능 (시작하는 index,몇개)
	//articleList = dbPro.getArticles(startRow,pageSize);//읽어나오기로함(1,10)(시작번호,끝번호)
	//oracle은 runum(시작하는index,끝나는 index)

	//String startRowe = (String)request.getAttribute("startRow");
	// endRowe = (String)request.getAttribute("endRow");
	if(opt !=null){
		articleList = dbPro.getBoardList(opt,condition,startRow,endRow);
	}else {
		articleList = dbPro.getArticles(startRow, endRow);
	}

	number = count - (currentPage - 1) * pageSize;
%>

    <!-- <link rel="stylesheet" href="../reset.css" /> -->
    <title>게시판</title>
 <link href="shopingstyle.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="script.js"></script>
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:700&display=swap" rel="stylesheet">
    <style>
        *{
            font-family: 'Noto Sans KR', sans-serif;
            font-weight: bold   ;
        }
        .manu {
            width: 1500px;
            height: 800px;
            margin: 0 auto;
            // border:1px solid black;
            position: relative;
            font-family: 'Noto Sans KR', sans-serif;
        }
	
        .main {
            position: absolute;
            top: 40px;
        }
        
        a:link{
            color: black; /*방문 전 링크상태일때 검정색으로 표시됌 */
        }
       	a:visited {
            color: black; /*방문 후 링크상태일때 검정색으로 표시됌 */
        }

        #manu_bar {
            font-size: 20px
        }
        #manu_bar>li{
        	 padding-top:8px ;
        	   font-weight: bold  ;
        }

        #manu_bar2 {
            font-size: 17px
        }
        
        #manu_bar2>li{
        	 padding-top:8px; 
        	 font-weight: bold  ;
        }

         #manu_bar3 {
            position: absolute;
            top: 3rem;
            right: 12rem;
            font-size: 15px;
        }

            #manu_bar3 > li {
                 float: left;
                font-weight: bold;
                margin-right:0.5rem;
            }
        #s {
     //       border: 1px solid black;
            margin: 0px auto;
            width: 750px;
            position: absolute;
            top: 145px;
            left: 589px;
            font-size: 18px;
            font-weight: bold  ;
        }
	#bar1{
		   margin: 0px auto;
		   width:800px;
		   position: absolute;
		   top: 130px;
		   left:300px;
		}
		#bar2{
		   margin: 0px auto;
		   width:800px;
		    position: relative;
		   top: 178px;
		  right:50px;  
		}
        .secsion {
           //  border: 1px solid black;
            margin: 0px auto;
            width: 800px;
            height:800px;
            position: absolute;
            top: 180px;
            left: 300px;
           // background-color:AntiqueWhite;
        }
	.list_main{
	    top: -34px;
	 	position: absolute;
	 }

/*table {

	font-size:13pt;
	text-align: center;
	width:800px;
} */
	#write{
	
	margin:0px auto;
	float:right;
	}
	td{
	border: 1px solid black;
	}
	.th1{
	border: 1px solid black;
	}
	thead{
	border: 2px solid black;
	text-align: center;
	}
	
	.table-hover>thead,tr,th,td{
	//  border: 1px solid balck;
	text-align: center;
	}
	.table-hover{
	//border: 3pt solid black;
	text-align: center;
	width:800px;
	position: relative;
	}
	#page{
	/*position:absolute;
	position:relative;*/
	text-align: center;
	 }  

    </style>

</head>
<body>
    <header class="manu">
        <div class="main">
           <p><h1><a href=shopping.jsp>NONCODE</a></h1></p>

            <ul id="manu_bar">
                <li> 당일출고</li>
                <li>BEST 50</li>
                <li>NEW:5%SALE</li>
                <li>OUTER</li>
                <li><a href="topProduct.jsp">TOP</a></li>
                <li><a href="">SHIRT</a></li>
                <li>OPS</li>
                <li>BOTTOM</li>
                <li><a href="skirtProduct.jsp">SKIRT</a></li>
                <li><a href="accProduct.jsp">ACC</a></li>
                <li>SHOES</li>
                <li>BAG</li>
                <li>ONLY</li>
            </ul>
            <br>
            <br>
            <br>
            <ul id="manu_bar2">
                <li>NOTICE</li>
                <li>Q&A</li>
                <li><a  href=listShopping.jsp>REVIEW</a></li>
                <li>EVENT</li>
                <li>MODEL</li>
            </ul>
        </div>
        <ul id="manu_bar3">
         <li><a href=shoppingLogin.jsp>LOGIN &nbsp</a> </li>
            <li><a href=shoppingMemberShip.jsp>JOIN &nbsp</a> </li>
            <li>ORDER &nbsp </li>
           <li> <a href=mypage.jsp>MY PAGE </a></li>
        </ul>
        <hr id="bar1">
        <p ><a id="s">커뮤니티</a></p>
                <hr  id="bar2">  
               <div class="secsion">
   <header class="list_main">
<p>글목록(전체 글:<%=count%>)</p>
<!--/*<p><%//=id %>님</p>-->
<!-- <div class="container"> -->
<table id="write" >
  <tr>
    <td align="right">
       <a  href="writeForm.jsp">글쓰기</a>
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
<table class="table-hover"> 
	<thead>
		<tr height="30" bgcolor="Beige" >
			<th class="th1" align="center" width="50">번 호</td>
			<th class="th1" align="center" width="250">제 목</td>
			<th class="th1" align="center" width="100">작성자</td>
			<th class="th1" align="center" width="150">작성일</td>
			<th class="th1" align="center" width="50">조 회</td>
			<th class="th1" align="center" width="100">IP</td>
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
	  <img src="images/re.png"><!-- 답글 img -->
<%  }else{%>
	  <img src="images/level.png" width="<%=wid%>" height="16">
<%  }%>
           
      <a href="content.do?num=<%=article.getNum()%>&pageNum=<%=currentPage%>">
           <%=article.getSubject()%></a> 
<% if(article.getReadcount()>=20){%><!-- 조회가 많을시 img -->
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
 <div id="page">
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
      
          <a href="listShopping.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
<%      }
        
        for (int i = startPage ; i <= endPage ; i++) {  %>
           <a href="listShopping.jsp?pageNum=<%= i %>">[<%= i %>]</a>
<%      }
        
        if (endPage < pageCount) {  %>
        <a href="listShopping.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
<%
        }
    }
%>

   </div>
 <div id="searchForm">
        <form action="listShopping.jsp">
      <%  if (count > 0) {
        int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage =1;
		
		if(currentPage % 10 != 0)
           startPage = (int)(currentPage/10)*10 + 1;
		else
           startPage = ((int)(currentPage/10)-1)*10 + 1;

		int pageBlock = 10;
        int endPage = startPage + pageBlock - 1;
        if (endPage > pageCount) endPage = pageCount;
        %>
         <select name="opt">
                <option value="0">제목</option>
                <option value="1">내용</option>
                <option value="2">제목+내용</option>
                <option value="3">글쓴이</option>
            </select>
            <input type="text" size="20" name="condition"/>&nbsp;
            <input type="hidden" name="startPage" value="<%=startPage%>" >
            <input type="submit" value="검색"/>
           <%  }
      %>
        
        </form>    
    </div>


    </header>
</body>
</html>

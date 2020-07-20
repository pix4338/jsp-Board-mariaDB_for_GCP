<%@page import="java.util.List"%>
<%@page import="ch13.model.ProductDataBean"%>
<%@page import="java.util.Vector"%>
<%@page import="ch13.model.ProductDBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	int pageSize = 6;
	request.setCharacterEncoding("UTF-8");
	String id =(String) session.getAttribute("id");
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null) {//request.getParameter 다음에는 반드시 null검사를 해줘야한다.
		pageNum = "1";//지금 현제 페이지수
	}
	//<페이지 계산>
	int currentPage = Integer.parseInt(pageNum);//1//2(페이지안에 숫자만 들어와야 정상 작동한다.)
	int startRow = (currentPage - 1) * pageSize + 1;//1 //11
													//총 글 갯수가35개 있으면 page는 [1][2][3]
													//1.1~10 /2.11~20/3.21~30/4.31~40
	int endRow = currentPage * pageSize;//10 1부터 10까지 나타내겠다//20
	int count = 0;
	int number = 0;
	//</페이지 계산>
	Vector<ProductDataBean> v = null;
	ProductDBean proDb = ProductDBean.getInstance();//db연결
	count = proDb.getProductCount(1);// 현제 몇개 까지 있는지 읽어나옴
	//1개이상 있다면
	//mysql 의 limit기능 (시작하는 index,몇개)
	//articleList = dbPro.getArticles(startRow,pageSize);//읽어나오기로함(1,10)(시작번호,끝번호)
	//oracle은 runum(시작하는index,끝나는 index)
	//if (count > 0) {
		v = proDb.getSelectProduct(2,startRow,endRow);
	//pList = proDb.getProductDatas(1, startRow, endRow);
	//}
	number = count - (currentPage - 1) * pageSize;
%>
 

<jsp:include page="include.jsp" flush="false">
	<jsp:param name="titlee" value="SKIRT" /> 
</jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.secsion2 {
          //border: 1px solid black;
            margin: 0px auto;
            width: 50rem;
            top: 2.2rem;
            position: relative;
        }
	img {
             width: 250px;
             height: 250px;
             border:1px solid blakc;
            }
	#pageNum{
			margin-left:25rem;
	}

</style>
</head>
<body>
 

     <div class="secsion2">   
      <table width="800" > 
	      
<% 
	
	int j=0;
  	for(int i = 0 ; i<v.size() ; i++){
	  ProductDataBean pBean = v.get(i);
	  if(j%3==0){
		  
%>
   <tr height="220">
<%}%>	 
 		<td width="230" alingn="center">
 			 <a href="ProducInfo.jsp?no=<%=pBean.getNo()%>">
             <img src="productImg/<%=pBean.getImg()%>" > </a>
			  <p><b><%=pBean.getName()%></b><br>
     		  <%=pBean.getPrice()%> </p></td>       
     


<%j+=1;} %>
</table> 

<div id="pageNum">
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
          <a href="topProduct.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
<%      }
        
        for (int i = startPage ; i <= endPage ; i++) {  %>
           <a href="topProduct.jsp?pageNum=<%= i %>">[<%= i %>]</a>
<%      }
        
        if (endPage < pageCount) {  %>
        <a href="topProduct.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
<%
        }
    }
%>
</div>
</div>
</body>
</header>
</html>
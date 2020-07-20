<%@page import="java.util.List"%>
<%@page import="ch13.model.ProductDataBean"%>
<%@page import="java.util.Vector"%>
<%@page import="ch13.model.ProductDBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% //<페이지 계산>
	request.setCharacterEncoding("UTF-8");
	int pageSize = 6;//한 페이지에 나타날 상품 개수
	String pageNum = request.getParameter("pageNum");
	//페이지 넘긴 값이 있다면
	if (pageNum == null) {//request.getParameter 
		pageNum = "1";//지금 현제 페이지수
	}
	int currentPage = Integer.parseInt(pageNum);// 1 현제 페이지 값 (페이지안에 숫자만 들어와야 정상 작동한다.)
	int startRow = (currentPage - 1) * pageSize + 1;//rnum조회시 시작 번호를 구한다.
													//(지금 페이지 - 1) * 한 페이지에 나타날 상품 개수+1
													//1 = (1-1)*6+1
													//총 글 갯수가18개 있으면 page는 [1][2][3]
													//1.1~6 /2.7~12/3.13~17//
	int endRow = currentPage * pageSize;//rnum조회시 마지막 번호를 구한다.
										//지금페이지 * 한 페이지에 나타날 상품 개수
										//6 = 1*6.
	int count = 0;//상품 개수 
	//</페이지 계산>
	
	Vector<ProductDataBean> v = null;//getProductCount()메소드 return값을 가져오기 위해 자료형 선언
	ProductDBean proDb = ProductDBean.getInstance();//db연결
	count = proDb.getProductCount(1);// 상품이 몇개 까지 있는지 읽어나옴 매개 변수는 상품의 카테고리 이다. 
									//  TOP 1 /  SKIRT 2 / ACC 3 / OPS 4/ BOTTOM 5
	v = proDb.getSelectProduct(1,startRow,endRow);//상품의 내용을 가져온다.
	//									// TOP 1 /  SKIRT 2 / ACC 3 / OPS 4/ BOTTOM 5
	
%>
 

<jsp:include page="include.jsp" flush="false">
	<jsp:param name="titlee" value="TOP" /> 
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
<% 	//상품 목록
	int j=0;
  	for(int i = 0 ; i<v.size() ; i++){// 가져온 내용 만큼 반복 
  		//사용자에게 출력 하기 위해  내용은 pBean에 넣어준다.
	  ProductDataBean pBean = v.get(i);
	  //상품열이 3개씩 보이게하는 조건문
	  if(j%3==0){
%>
   <tr height="220">
<%}%>	 
 		<td width="230" alingn="center">
 			 <a href="ProducInfo.jsp?no=<%=pBean.getNo()%>"><!--클릭했을시 상품 기본키인 No을 전달한다. -->
             <img src="productImg/<%=pBean.getImg()%>" > <!--상품 이미지 출력 -->
             </a>
			  <p><b><%=pBean.getName()%></b><br><!--상품 이름 출력 -->
     		  <%=pBean.getPrice()%> </p></td><!--상품 가격 출력 -->       
<%j+=1;} //증가를 시켜줌%>
</table> 
<div id="pageNum">
<%//<페이지 수 버튼>
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
        
        if (startPage > 10) { %><!-- 페이지수를 넘긴다. -->
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
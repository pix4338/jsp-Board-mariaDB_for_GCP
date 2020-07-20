<%@page import="ch13.model.ProductDataBean"%>
<%@page import="ch13.model.ProductDBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");
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
	#dcenter{
        position: relative;
        float:right;
        top: 2.2rem;
        align-content: center;
       // width:40rem;
	}
	img {
			   float:left;
               width: 300px;
               height: 300px;
               border:1px solid blakc;
            }
    #productMenu{
    	 position: relative;
    	 float:right;
    	  top: 2.2rem;
    	 border: 1px solid black;
    	 top:4rem;
    	 
    }
    #productMenu>p{
    	 text-align:left;
    	 margin-bottom:1rem;
    	 color:DimGrey;
    }
</style>
</head>
<body>

<% int no = Integer.parseInt( request.getParameter("no"));
   ProductDBean proDb = ProductDBean.getInstance();
   ProductDataBean pData = proDb.getSelectProductInfo(no);
   int count = pData.getCount();
   String ppname = pData.getName() ;

%>
<div id="dcenter">
<form action="productPurchase.jsp" method="get">
<input type="hidden" name="pName" value="<%=pData.getName()%>">
<input type="hidden" name="price" value="<%=pData.getPrice()%>">
<input type="hidden" name="no" value="<%=pData.getNo()%>">
<img src="productImg/<%=pData.getImg()%>">
<div id="productMenu">
<p><%=pData.getName()%></p>
<p>₩<%=pData.getPrice()%></p>
<p><%=pData.getInfo()%></p>
<p>수량<%=pData.getCount()%></p> 
<select name="count" style="width:50px;">
<%
	int i = 0;
	while(i<count){
			i++;
	%>
		<option value="<%=i %>"> <%=i %> </option>
<%}	%>	
</select>
<br><input type="submit" value="구매">
</form>
</div>
</body>
</html>
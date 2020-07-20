<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  request.setCharacterEncoding("UTF-8");
	if((String)session.getAttribute("id")==null){
		%><script>
		alert("회원만 구매 가능 합니다. 로그인을 해주세요");
		history.go(-1);	
		</script>
	<%}else{
		String id =(String) session.getAttribute("id");
	}
	int no =  Integer.parseInt(request.getParameter("no"));
	int count = Integer.parseInt(request.getParameter("count"));
	int price = Integer.parseInt(request.getParameter("price"));
	String pName = request.getParameter("pName");
	int priceR = price*count;
	String productName = (String)request.getAttribute("productName");
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
	#purchase{
		margin-top:2.5rem;
		width:35rem;
		height:18rem;
	}
</style>
</head>
<body>
<table id="purchase">
<tr>
<td>상품명</td>
<td><%=pName  %></td>
</tr>
<tr>
<td>가격</td>
<td><%=price %></td>
</tr>
<tr>
<td>수량</td>
<td><%=count %></td>
</tr>
<tr>
<td>가격*수량</td>
<td><%=priceR%></td>
</tr>
<tr>
<td>배송비</td>
<td>2500</td>
</tr>
<tr>
<td>합계</td>
<td><%=2500+priceR %></td>
</tr>
<tr>

<td colspan="2"><input type="button" value="취소">&nbsp;&nbsp;<input type="submit" value="구매하기"></td>
</tr>
</table>
</body>
</html>
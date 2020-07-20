
<%@page import="ch13.model.LoginDataBean"%>
<%@page import="ch13.model.BoardDBBean"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<jsp:include page="include.jsp" flush="false">
<jsp:param name="titlee" value="정보수정" /> 
</jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	div{
		position:relative;
		top:3rem;
	}
</style>
</head>
<body>

<%   //정보수정
	BoardDBBean  dbPro = BoardDBBean.getInstance();
	String id =(String) request.getSession().getAttribute("id");
	String nickname=(String) request.getSession().getAttribute("nickname");
	
	LoginDataBean logDb= dbPro.ProfileSelect(id);
	String newtelV = (String) logDb.getTel();
	String newemailV = (String) logDb.getEmail();
	String newaddressV = (String) logDb.getAddress();
	String dateV = (String) logDb.getDate_number();
	

	//변경하기 눌렀을시
	if(request.getAttribute("checkUpdate") !=null){
		int checkUpdate = (int)request.getAttribute("checkUpdate");
		if(checkUpdate==1){
	%>
		<script>
		alert("수정 완료");
		</script>
	<%	
		}else if(checkUpdate==2){
	%>
		<script>
			alert("변경한 새비밀번호가 일치 하지 않습니다.");
		</script>
	<%	
		}else if(checkUpdate==3){
	%>
		<script>
			alert("비밀번호가 일치하지 않습니다.");
		</script>
	<%	
		}
	}
%>
<div>
<form method="post" action="mypageUpdate.do" >
<table>
	<tr>
		<td>ID</td>
		<td><%=id%></td>
	</tr>
	<tr>
		<td>별명</td>
		<td><%=nickname%></td>
	</tr>
		<tr>
		<td>새 비밀번호</td>
		<td><input type ="password" name="newpass1" maxlength="15"></td>
	</tr>
		<tr>
		<td>새 비밀번호 확인</td>
		<td><input type ="password" name="newpass2" maxlength="15"></td>
	</tr>
	<tr>
		<td>전화번호</td>
		<td><input type ="text" name="newtel" value="<%=newtelV %>" maxlength="13"></td>
	</tr>
	<tr>
		<td>e-mail</td>
		<td><input type ="text" name="newemail" value="<%=newemailV %>"  maxlength="30"></td>
	</tr>
	<tr>
		<td>생년월일</td>
		<td><%=dateV%></td>
	</tr>
	<tr>
		<td>주소</td>
		<td><input type ="text" name="newaddress"  value="<%=newaddressV %>" maxlength="25"></td>
	</tr>
</table>
<br>
	비밀번호 입력 : <input type="password" name="passwd"maxlength="15">
	<input type="submit" value="완료" />
	<input type="button" value="취소" OnClick="window.location='mypage.jsp'" />
</form>
</div>
</body>
</html>
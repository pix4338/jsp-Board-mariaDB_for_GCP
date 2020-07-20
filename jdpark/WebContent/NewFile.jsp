<%@page import="ch13.model.LoginDataBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%request.setCharacterEncoding("utf-8"); %>
<% 
String nic="";
LoginDataBean logDb = new LoginDataBean();
if(request.getAttribute("NicknameCheck") !=null){
	int num = (int) request.getAttribute("NicknameCheck");
//if(session.getAttribute("nickname Check")!=null){
//	int num = (int)session.getAttribute("nickname Check");
	//request.setAttribute("nickname Check",num);
	if(num==1){
%>  <script>
	alert("이미 사용중인 닉네임입니다.");
	</script>
<%}else if(num==2){
%>  <script>
	alert("닉네임을 입력해주세요");
	</script>
<%	}else if(num==3){
%>	<script>
	alert("닉네임 사용 가능");
	</script>
<%}else if(num==4){
%>	<script>
	alert("닉네임 검사를 해주세요");
	</script>
<%}}

if(request.getAttribute("checkNum") !=null){
int checkNum = (int) request.getAttribute("checkNum");
String ide =(String) session.getAttribute("id");

LoginDataBean article = new LoginDataBean();
if(checkNum == 1){
%>
	<script>
	alert("이미 사용중인 아이디입니다.");
	</script>
<%	
}else if(checkNum == 2){
%>
	<script>
	alert("빈칸이 있습니다. 다시 입력해 주세요");
	</script>	
<%
}else if(checkNum==3){
%>
	<script>
	alert("입력하신 비밀번호가 일치하지 않습니다. 다시 입력해 주세요");
	</script> 
<%}else if(checkNum==-1){
%>
	<script>
	alert("가입 완료 환영 합니다.");
	location.href="memberForm.jsp";
	</script> 

<%}
request.setAttribute("checkNum",null);
}%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
  <!-- <link rel="stylesheet" href="../reset.css" /> -->  
    <title>쇼핑몰 메인 페이지</title>
<link href="shopingstyle.css" rel="stylesheet" type="text/css">
<!-- <script type="text/javascript" src="script.js"></script> -->
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:700&display=swap" rel="stylesheet">
    <style>
        * {
            font-family: 'Noto Sans KR', sans-serif;
            font-weight: bold;
        }

        .manu {
           //  width: 1500px;
             width : 85rem;
            //width: 100%;
            height: 800px;
            margin: 0 auto;
            //align-content
            //margin-left:50rem;
           //  border:1px solid black;
            //position: relative;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .main {
            position: absolute;
            top: 40px;
        }

        a:link {
            color: black; /*방문 전 링크상태일때 검정색으로 표시됌 */
        }

        a:visited {
            color: black; /*방문 후 링크상태일때 검정색으로 표시됌 */
        }

        #manu_bar {
            font-size: 20px;
            margin-top:3rem;
        }

            #manu_bar > li {
                padding-top: 0.3rem;
                font-weight: bold;
            }

        #manu_bar2 {
            font-size: 17px
        }

            #manu_bar2 > li {
                padding-top: 8px;
                font-weight: bold;
            }

        #manu_bar3 {
         //   position: absolute;
            float:right;
            margin-top:4rem;

            font-size: 15px;
        }

            #manu_bar3 > li {
                float: left;
                font-weight: bold;
                margin-right:1rem;
            }
        #ment {
            position: absolute;
            //width: 800px;
            width: 30rem;
            top: 13rem;
            //top: 180px;
            left:33rem;
            margin: 0px auto;
            text-align:center;
         //   border: 1px solid black;
        }

            #ment > p > a {
                //border: 1px solid black;
                margin: 0px auto;
                width: 75rem;
                 left:20rem;
                position: absolute;
                position: relative;
                text-align: center;
                // top: 145px;
                // left: 589px;
                font-size: 18px;
                font-weight: bold;
            }

        #bar {
            position: absolute;
            width: 5.5rem;
            left: 32.2rem;
            top: 0.8rem;
            // border: none;
            // border: 1px solid Silver;
            // top: 180px;
            // left: 10px;
        }

        .secsion {
            // border: 1px solid black;
            margin: 0px auto;
            width: 30rem;
            top: 10.5rem;
            left: 7.2rem;
            //width: 885px;
            //height: 600px;
            position: absolute;
            position: relative;
            // top: 180px;
        }
        #login {
         //   border: 1px solid Silver;
            margin: 0px auto;
            // width: 502px;
            width: 60rem;
            height: 30rem;
            top: 5rem;
            // height: 466px;
            position: absolute;
            position: relative;
            // top: 65px;
            left: -280px;
        }
        #membership {
        //    border: 1px solid black;
            margin: 0px auto;
            text-align: center;
            width: 32.5rem;
            top: 1.8rem;
            height: 3rem;
            height: 55px;
            position: absolute;
        }
        #loginbox {
         //   border: 1px solid black;
            position: absolute;
            position: relative;
            margin-top: 2rem;
            width: 32.2rem;
            height: 10rem;
        }
        #tb1 {
            position: absolute;
            width: 100%;
            height: 10px;
        }
        #tb2 {
            position: absolute;
            position:relative;
            top:1.5rem;
            width: 100%;
            height: 10px;
        }
        #text {
            position: absolute;
            text-align: left;
            top:4.5rem;
            text-top
        }
        .thS {
            width: 200px;
            height: 40px;
        }
            #tb1, th, td {
                border: 1px solid #bcbcbc;
                text-align: left;

                // border-bottom: none;
                // border-top: none;
                // border-left: none;
                // border-right: none;
            }
        th{
           padding-left:8px;
        }
    </style>

</head>
<body>
    <header class="manu">
        <div class="main">
            <p><h1>NONCODE</h1></p>

            <ul id="manu_bar">
                <li>  당일출고</li>
                <li>BEST 50</li>
                <li>NEW:5%SALE</li>
                <li>OUTER</li>
                <li>TOP</li>
                <li>SHIRT</li>
                <li>OPS</li>
                <li>BOTTOM</li>
                <li>SKIRT</li>
                <li>ACC</li>
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
                <li><a href=listShopping.jsp>REVIEW</a></li>
                <li>EVENT</li>
                <li>MODEL</li>
            </ul>
        </div>
        <ul id="manu_bar3">
            <li><a href=shoppingLogin.jsp>LOGIN &nbsp</a> </li>
            <li><a href=shoppingMemberShip.jsp>JOIN &nbsp</a> </li>
            <li>ORDER &nbsp </li>
            <li>MY PAGE  </li>
        </ul>
        <form>
        <div id="ment">
            <p><a >회원가입</a></p>
            <hr id="bar">
        </div>
        <div class="secsion">
            <div id="login">
                <table id="tb1">
                    <tr>
                        <th class="thS">회원구분</th>
                        <th id="th1"><input type="radio" checked="checked" />개인회원</th>
                    </tr>
                </table>

                <table id="tb1">
                    <tr>
                        <th class="thS">회원구분</th>
                        <th id="th1"><input type="radio" checked="checked" />개인회원</th>
                    </tr>
                </table>
         
                <a id="text">기본정보</a>
                <table id="tb2">
                    <tr>
                        <th class="thS">아이디</th>
                        <th id="th1"><input type="text" name="idN" id="idN" maxlength="15" ></th>
                    </tr>
                    <tr>
                        <th  class="thS">비밀번호</th>
                        <th id="th1"> <input type="text" name="pwdN" id="pwdN" maxlength="12" ></th>
                    </tr>
                    <tr>
                        <th class="thS">비밀번호 확인</th>
                        <th id="th1"> <input type="password" name="pwdNe" id="pwdNe" maxlength="12"></th>
                    </tr>
                    <tr>
                        <th class="thS">닉네임</th>
                        <th id="th1"><input type="text"name="nickname" id="nickname"  maxlength="15"><input type="submit" value="닉네임 중복 검사" onclick="javascript: form.action='nickname.do';" ></th>
                    </tr>
                     <tr>
                        <th class="thS">생일</th>
                        <th id="th1">
                         <input type="text"name="year" id="year"value="년(4자)"onFocus="this.value='';" style=" width:70px;"maxlength="4">
                         <select name="month"id="month"style="width=50px;">
							<%
							int i = 0;
							while(i<12){
									i++;
							%>
								<option value="<%=i %>"> <%=i %> </option>
							<%}	%>	
						</select>
						<input type="text"name="day"id="day"value="일"onFocus="this.value='';"style="width:70px;"maxlength="2">
                   		</th>
                    </tr>
                    <tr>
                        <th class="thS">주소</th>
                        <th id="th1"><input type="text" name="address" id="address"maxlength="25"></th>
                    </tr>
                    <tr>
                        <th class="thS">전화번호</th>
                        <th id="th1">
                        <select name="tel1" id="tel1">
						<option value="010">010 </option>
						<option value="02">02</option>
						<option value="011">011 </option>
						<option value="016">016 </option>
						<option value="017">017 </option>
						<option value="017">018 </option>
						<option value="017">019 </option>
						</select> 
						-<input type="text" name="tel2" id="tel2"style=" width:50px;"maxlength="4">
						-<input type="text" name="tel3" id="tel3"style=" width:50px;"maxlength="4">
						</th>
                    </tr>
                    <tr>
                        <th class="thS">이메일</th>
                        <th id="th1">
							<input type="text" name="email1" id="email"style="width:70px;" maxlength="21">@
							<select name="email2">
							<option>naver.com</option>
							<option>daum.net</option>
							<option>gmail.com</option>
							<option>nate.com</option>                        
							</select>
						</th>
                  </tr>
                </table>
          
                <input type="submit" value="등록" onclick="javascript: form.action='joinMembership.do';">
		<input type="button" value="취소" OnClick="window.location='login.jsp'">
		</form>

                    <sectioin id="membership">
                        <div id="loginbox">
                        </div>
                    </sectioin>
            </div>
        </div>
    </header>
</body>
</html>

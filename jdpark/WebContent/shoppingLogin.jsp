<%@page import="ch13.model.LoginDataBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); 
	if((String)session.getAttribute("id")!=null){
		%><script>
		alert("이미 로그인을 하였습니다.");
		history.go(-1);	
		</script>
<%}%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>

<%
String ide = "";
String pwd = "";
String id =(String) session.getAttribute("id");
//String namexb =  (String)request.getAttribute("name");

LoginDataBean logDb = new LoginDataBean();
logDb.getNickname();
if(request.getAttribute("checkId") !=null){
int checkId = (int)request.getAttribute("checkId");

if(checkId == -1){
%>
	<script>
	alert("해당 아이디를 찾을 수 없습니다. 회원가입을 해 주세요.");
	</script>
<%	
}
else if(checkId == 1){
%>
	<script>
	alert("아이디와 패스워드가 일치하지 않습니다. 다시 로그인해 주세요.");
	</script>
<%}}%>
<script>
  function goPage() {
      // name이 loginpage인 태그
      var f = document.loginpage;
     
      // input태그의 값들을 전송하는 주소
      f.action = "login.do";

      // 전송 방식 : post
      f.method = "post";
      f.submit();
    };
</script>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<!--  <link rel="stylesheet" href="../reset.css" />-->
<title>쇼핑몰 메인 페이지</title>
<link href="shopingstyle.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="script.js"></script>
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
        	position:relative;
        //	border: 1px solid black;
            width:60rem;
			top: 15rem;
            left:4.8rem;
            margin: 0px auto;
            text-align:center;
        }

            #ment > p > a {
                width: 75rem;
                 left:20rem;
                text-align: center;
                font-size: 18px;
                font-weight: bold;
            }

        #bar {
           
            width: 5.5rem;
          
           
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
            border: 1px solid Silver;
            margin: 0px auto;
            // width: 502px;
            width: 32.5rem;
            height: 30rem;
            top: 5rem;
            // height: 466px;
            position: absolute;
            position: relative;
            // top: 65px;
            left: -120px;
        }
        #membership {
         //   border: 1px solid black;
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
        #membership_title {
            font-size: 12px;
            line-height: 35px;
            color: #666666;
        }
        #id {
            margin-top: 0.5rem;
        }
       .text {
           
            margin-bottom: 0.3rem;
            margin-right:3.8rem;
            height:1.5rem;
            width:12.5rem;

        }
        #img_login {
            position: absolute;
            float: right;
            right: 4rem;
            top:0.3rem;
            height: 4.3rem;
            width: 7rem;
        }
            #img_login:hover {
                -webkit-filter: grayscale(100%);
                filter: gray;
            }
        #img_id {
            position: absolute;
            height: 1.1rem;
            width: 4.5rem;
            left:7.5rem;
            top: 5rem;
              }
        #img_pwd {
            position: absolute;
            height: 1.1rem;
            width: 5rem;
            left: 12rem;
            top: 4.95rem;
        }
        #img_naver {
            position: absolute;
            height: 2.1rem;
            width: 20rem;
            left: 8rem;
            top: 7.5rem;
        }
        #img_c {
            position: absolute;
            height: 2.1rem;
            width: 20rem;
            left: 8rem;
            top:9.8rem;
        }
        #img_apple {
            position: absolute;
            height: 2rem;
            width: 10rem;
            left: 8rem;
            top: 12.2rem;
        }
        #img_member {
            position: absolute;
            height: 2rem;
            width: 5rem;
            left: 25.3rem;
            top: 17.2rem;
        }
        #bar2 {
            position: absolute;
            width: 26rem;
            left: 4rem;
            bottom:-6.5rem;
            border: none;
            border: 1px solid Silver;
            background-color: Silver;
        }
    </style>

</head>
<body>
    <header class="manu">
        <div class="main">
            <a href=shopping.jsp><p><h1>NONCODE</h1></p></a>

            <ul id="manu_bar">
                 <li>  당일출고</li>
                <li>BEST 50</li>
                <li>NEW:5%SALE</li>
                <li>OUTER</li>
                <li><a href="topProduct.jsp">TOP</a></li>
                <li><a href="">SHIRT</a></li>
                <li><a href="topProduct.jsp">OPS</a></li>
                <li><a href="topProduct.jsp">BOTTOM</a></li>
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
                <li><a href=listShopping.jsp>REVIEW</a></li>
                <li>EVENT</li>
                <li>MODEL</li>
            </ul>
        </div>
        <ul id="manu_bar3">
            <li><a href=shoppingLogin.jsp>LOGIN &nbsp</a> </li>
            <li><a href=shoppingMemberShip.jsp>JOIN &nbsp</a> </li>
            <li>ORDER &nbsp </li>
            <li><a href=mypage.jsp>MY PAGE </a></li>
        </ul>
        <div id="ment">
            <p><a >로그인</a></p>
            <hr id="bar">
        </div>
        <div class="secsion">
            <div id="login">
                <sectioin id="membership">
                    <h2>Member Login</h2>
                    <span id="membership_title">가입시 입력하신 아이디와 비밀번호로 로그인이 가능합니다.</span>
                    <div id="loginbox">
                    
                    <form name="loginpage" >
                    <input type="text" class="text" name ="id"><br>
					<input type="password" class="text" name ="pwd">
					 </form>
                 <!--  <input type="submit" value="입력완료">
					<input type="button" value="회원가입" OnClick="window.location='joinMembership.jsp'"> -->  
					
                         <a href="javascript:goPage();" ><img src="img/button.jpg" alt="로그인" id="img_login" /></a>
                        
                    
                     <a href="">  <img src="img/id.png" id="img_id" /></a>
                     
                        <a href=""><img src="img/pwd.png" id="img_pwd" /></a>
                        <a href=""><img src="img/naver.png" id="img_naver" /></a>
                        <a href=""><img src="img/cacao.png" id="img_c" /></a>
                        <a href=""><img src="img/apple.png" id="img_apple" /></a>
                        <a href="shoppingMemberShip.jsp"><img src="img/memberShip.png" id="img_member" /></a>
                        <hr id="bar2">
                    </div>
                </sectioin>
            </div>
        </div>
    </header>
</body>
</html>

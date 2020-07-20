<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String titlee = request.getParameter("titlee");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
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
            left: 42rem;
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
           <p><h1> <a href=shopping.jsp>NONCODE</a></h1></p>

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
        <p ><a id="s"><%=titlee %></a></p>
                <hr  id="bar2">  
               <div class="secsion">
   <header class="list_main">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<script type="text/javascript" src="script.js"></script>
</head>
<body>
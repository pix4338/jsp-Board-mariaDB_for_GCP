<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <!-- <link rel="stylesheet" href="../reset.css" /> -->
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

           .list3 {
                float: left;
                font-weight: bold;
                margin-right:0.5rem;
            }
		#content {
     //       border: 1px solid black;
            margin: 0px auto;
            width: 750px;
            position: absolute;
            top: 145px;
            left: 589px;
            font-size: 18px;
            font-weight: bold  ;
        }
     
        #bar {
            position: absolute;
            width: 5.5rem;
            left: 12.5rem;
            top:0.8rem;
            // border: none;
           // border: 1px solid Silver;
            // top: 180px;
            // left: 10px;
        }
        .secsion {
           //  border: 1px solid black;
            margin: 0px auto;
            width: 50rem;
            top: 10.5rem;
            left: 7.2rem;
            //width: 885px;
            //height: 600px;
            position: absolute;
            position: relative;
           // top: 180px;
        }
		
        #content {
         margin: 0px auto;
                width: 75rem;
                position: absolute;
                position: relative;
                text-align: center;
               left:45rem;
               top:10rem;
                font-size: 18px;
                font-weight: bold;
        //   border: 1px solid black;
          /*  margin: 0px auto;
            width: 750px;
            position: absolute;
            top: 145px;
            left: 589px;
            font-size: 18px;
            font-weight: bold  ;*/
        }

     /*   .secsion {
            // border: 1px solid black;
            margin: 0px auto;
            width: 800px;
            position: absolute;
            top: 180px;
            left: 300px;
        }*/

            .secsion > img {
                width: 30%;
                border:1px solid blakc;
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
                <li><a href="listShopping.jsp">REVIEW</a></li>
                <li>EVENT</li>
                <li>MODEL</li>
            </ul>
        </div>
        <ul id="manu_bar3">
         <li class="list3"><a href=shoppingLogin.jsp>LOGIN &nbsp</a> </li>
            <li class="list3"><a href=shoppingMemberShip.jsp>JOIN &nbsp</a> </li>
            <li class="list3">ORDER &nbsp </li>
            <li class="list3"><a href=mypage.jsp>MY PAGE</a>  </li>
        </ul>
        <p></p><a id="content">BEST ITEM</a></p>
               <div class="secsion">
                   
                   <img src="img/hood.jpg" />
                   <img src="img/skirt.jpg" />
                   <img src="img/skirt2.jpg" />
                   <img src="img/t1.jpg" />
                   <img src="img/t2.jpg" />
                   <img src="img/t3.jpg" />
                   <img src="img/e1.jpg" />
                   <img src="img/e2.jpg" />
                   <img src="img/e3.jpg" />
               </div>
    </header>
</body>
</html>

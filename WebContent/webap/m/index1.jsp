<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="jQueryMob/jquery.mobile.custom.structure.css" />	
<link rel="stylesheet" href="jQueryMob/jquery.mobile.custom.theme.css" />	
<script src="jQueryMob/jquery.js" language="javascript"></script>	
<script src="jQueryMob/jquery.mobile.custom.js" language="javascript"></script>	

</head>
<body>

<!--login Successful-->
<div data-role="page" id="pageHome">
  <div data-role="panel" id="myPanel" data-position="right">
    <h2>Panel Header</h2>
    <p>Function List.</p>
    <a class="ui-btn" href="#pageSwapCal">換班飛時試算</a>
    <a class="ui-btn" href="#pageSwap">換班申請</a>
    <a class="ui-btn" href="#pagePick">選班申請</a>
    <a href="login.jsp" class="ui-btn" data-ajax="false">登出</a>
  </div>
  <div data-role="header">
    <h1>iCrew</h1>
    <a href="#myPanel" class="ui-btn ui-btn-inline ui-corner-all ui-shadow ui-btn-right">list</a>
  </div>
  <div data-role="main" class="ui-content">
<!--     <p>Click on the button below to open the Panel.</p> -->
    <div data-role="navbar">
		<a class="ui-btn" href="#pageSwapCal">換班</a>
		<a class="ui-btn" href="#pageSwap">選班</a>
		<a class="ui-btn" href="#pagePick">請假</a>
        
        <ul>
          <li>
            <a href="#">全員即時通訊</a>
          </li>
          <li>
            <a href="#">全員信箱</a>
          </li>
        </ul>    
<!--         <ul> -->
<!--           <li> -->
<!--             <a href="#pageSwapCal">換班飛時試算</a> -->
<!--           </li> -->
<!--           <li> -->
<!--             <a href="#pageSwap">換班</a> -->
<!--           </li> -->
<!--           <li> -->
<!--             <a href="#pagePick">選班</a> -->
<!--           </li> -->
<!--           <li> -->
<!--             <a href="#">4</a> -->
<!--           </li> -->
<!--           <li> -->
<!--             <a href="#">5</a> -->
<!--           </li> -->
<!--           <li> -->
<!--             <a href="#">6</a> -->
<!--           </li> -->
<!--         </ul> -->
      </div>
  </div>
  <div data-role="footer" data-position="fixed">
<!--     <h1>Page Footer</h1> -->
  </div>
</div>
  
<!--換班試算-->
<div id="pageSwapCal" data-role="page" data-theme="b">
  <div role="main" class="ui-content">
    <a class="ui-btn" id="btnBack" data-transition="slide" href="#pageHome">back</a>
  </div>
</div>
<!--換班-->
<div id="pageSwap" data-role="page" data-theme="b">
  <div role="main" class="ui-content">
    <a class="ui-btn" id="btnBack" data-transition="slide" href="#pageHome">back</a>
  </div>
</div>
<!--選班-->
<div id="pagePick" data-role="page" data-theme="a">
  <div role="main" class="ui-content">
    <a class="ui-btn" id="btnBack" data-transition="slide" href="#pageHome">back</a>
  </div>
</div>

</body>
</html>
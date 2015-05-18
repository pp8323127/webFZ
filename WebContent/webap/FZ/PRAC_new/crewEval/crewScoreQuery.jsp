<html>
<head>
<title>Crew Score Query</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href= "../style.css" rel="stylesheet" type="text/css">
<script src="../../js/showDate.js"></script>

<style type=text/css>
<!--
BODY{margin:0px;/*內容貼緊網頁邊界*/}
.style1 {
	color: #9900FF;
	font-weight: bold;
	font-family: Arial, Helvetica, sans-serif;
}
.style2 {color: #FFFFFF}
.style3 {color: #0000FF}
.style5 {color: #0000FF; font-weight: bold; font-family: Arial, Helvetica, sans-serif; }
-->
</style>
</head>

<body onload="showYear('form1','syy');">
<div align="left">
<p>
<form name="form1" method="post" target="mainFrame" action="crewScoreList.jsp">
  <p><span class="style1">Grade Year</span>
   <select name="syy" class="t1">
	  <script language="javascript" type="text/javascript">
		var nowDate = new Date();
		for(var i=2012;i<= nowDate.getFullYear()+1;i++)
		{
			document.write("<option value='"+i+"'>"+i+"</option>");
		}
	  </script>
   </select>
  </span>
  &nbsp;
  <input type="submit" name="Submit" value="Query">
  </form>
</div>
</body>
</html>

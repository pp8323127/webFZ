<html>
<head>
<title>Check Record Query</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href= "../style.css" rel="stylesheet" type="text/css">
<script src="../js/showDate.js"></script>

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

<body onload="showYM('form1','syy','smm');showYM('form1','eyy','emm');">
<div align="center">
<p>

<form name="form1" method="post" target="mainFrame" action="prBeReportList.jsp">
  <p><span class="style1">Query Period</span>     
    <span class="txtblue">From</span>     
   <select name="syy" class="t1">
  <script language="javascript" type="text/javascript">
  	var nowDate = new Date();
  	for(var i=2003;i<= nowDate.getFullYear()+2;i++){
		document.write("<option value='"+i+"'>"+i+"</option>");
	}
  </script>

        </select>
  
      <select name="smm"  class="t1">
        <option value="01">01</option>
        <option value="02">02</option>
        <option value="03">03</option>
        <option value="04">04</option>
        <option value="05">05</option>
        <option value="06">06</option>
        <option value="07">07</option>
        <option value="08">08</option>
        <option value="09">09</option>
        <option value="10">10</option>
        <option value="11">11</option>
        <option value="12">12</option>
      </select>

  </span><span class="txtblue">
     
  To</span> 
  <select name="eyy" class="t1">
  <script language="javascript" type="text/javascript">
  	var nowDate = new Date();
  	for(var i=2003;i<= nowDate.getFullYear()+2;i++){
		document.write("<option value='"+i+"'>"+i+"</option>");
	}
  </script>
  </select>
    
  <select name="emm"  class="t1">
    
    <option value="01">01</option>
      <option value="02">02</option>
      <option value="03">03</option>
      <option value="04">04</option>
      <option value="05">05</option>
      <option value="06">06</option>
      <option value="07">07</option>
      <option value="08">08</option>
      <option value="09">09</option>
      <option value="10">10</option>
      <option value="11">11</option>
      <option value="12">12</option>
  </select>
  <input type="submit" name="Submit" value="Query">
  </form>
</div>
</body>
</html>

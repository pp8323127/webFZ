<html>
<head>
<title>Check Record Query</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href= "style.css" rel="stylesheet" type="text/css">
<script src="js/showDate.js"></script>

<script language="JavaScript" type="text/javascript">
function checkDate(formName,year1,month1,day1,year2,month2,day2 ){	
	var yy1 = eval("document."+formName+"."+year1+".value");
	var mm1 = eval("document."+formName+"."+month1+".value");
	var dd1 = eval("document."+formName+"."+day1+".value");
	var yy2 = eval("document."+formName+"."+year2+".value");
	var mm2 = eval("document."+formName+"."+month2+".value");
	var dd2 = eval("document."+formName+"."+day2+".value");
	//潤年
	if((yy1%2000)==4){	
		if( (mm1=="02" && dd1=="30" )||(mm1=="02" && dd1=="31" )){
			Warning();
			return false;
		}		
	}
	else{		//非潤年
		if( (mm1=="02" && dd1=="29" )||(mm1=="02" && dd1=="30" ) ||(mm1=="02" && dd1=="31" )){
			Warning();
			return false;
		}	
	}
	
	if((yy2%2000)==4){	
		if( (mm2=="02" && dd2=="30" )||(mm2=="02" && dd2=="31" )){
			Warning();
			return false;
		}		
	}
	else{		//非潤年
		if( (mm2=="02" && dd2=="29" )||(mm2=="02" && dd2=="30" ) ||(mm2=="02" && dd2=="31" )){
			Warning();
			return false;
		}	
	}	
	
	//判斷為30天的月份
	if(mm1 =="04" || mm1=="06" || mm1=="09" || mm1=="11"){	
		if(dd1 =="31"){
			Warning();
			return false;
		}
	}
	
	//判斷為30天的月份
	if(mm2 =="04" || mm2=="06" || mm2=="09" || mm2=="11"){	
		if(dd2 =="31"){
			Warning();
			return false;
		}
	}
	return true;	
}

function Warning(){
	alert("您選擇了無效的日期\n請重新選擇！！");
}	


function checkdate2(){		//檢查超過設定的時間，則不予查詢

	var sdate = form1.syy.value + form1.smm.value + form1.sdd.value;
	var edate = form1.eyy.value + form1.emm.value + form1.edd.value;

	if (parseInt(sdate) > parseInt(edate))
	{
		alert("Please select correct period!!\n\n日期區間輸入有誤，請重新選擇！！");
		location.reload();
		return false;
	}
	return checkDate('form1','syy','smm','sdd','eyy','emm','edd');
}

</script>
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

<body onload="showYMD('form1','syy','smm','sdd');showYMD('form1','eyy','emm','edd');">
<div align="center">
<p>

<form name="form1" method="post" target="mainFrame" action="prChkReportList.jsp" onsubmit=" return checkdate2()">
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

      <select name="sdd" class="t1" >
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
        <option value="13">13</option>
        <option value="14">14</option>
        <option value="15">15</option>
        <option value="16">16</option>
        <option value="17">17</option>
        <option value="18">18</option>
        <option value="19">19</option>
        <option value="20">20</option>
        <option value="21">21</option>
        <option value="22">22</option>
        <option value="23">23</option>
        <option value="24">24</option>
        <option value="25">25</option>
        <option value="26">26</option>
        <option value="27">27</option>
        <option value="28">28</option>
        <option value="29">29</option>
        <option value="30">30</option>
        <option value="31">31</option>
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

  <select name="edd" class="t1" >
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
      <option value="13">13</option>
      <option value="14">14</option>
      <option value="15">15</option>
      <option value="16">16</option>
      <option value="17">17</option>
      <option value="18">18</option>
      <option value="19">19</option>
      <option value="20">20</option>
      <option value="21">21</option>
      <option value="22">22</option>
      <option value="23">23</option>
      <option value="24">24</option>
      <option value="25">25</option>
      <option value="26">26</option>
      <option value="27">27</option>
      <option value="28">28</option>
      <option value="29">29</option>
      <option value="30">30</option>
      <option value="31">31</option>
  </select>
  <input type="submit" name="Submit" value="Query">
  </form>
</div>
</body>
</html>

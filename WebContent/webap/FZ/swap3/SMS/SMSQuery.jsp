<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%

String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
/*response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);*/

if (session.isNew() || sGetUsr == null) 
{		//check user session start first
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>query SMS</title>
<script src="../js/showDate.js" language="javascript"></script>
<script src="../js/checkDate.js" language="javascript"></script>

<script language="javascript" type="text/javascript">
	function checkFlt(){
		var flt = document.form1.fltno.value;
		if(flt == ""){
			//document.form1.showMakeFile.value="N";
			document.form1.action="ShowFlt.jsp";
			return true;
		}
		else{
			document.form1.showMakeFile.value="Y";
			document.form1.action="Show1Flt.jsp";						
			return true;
		}
	}
	/*
function checkDate(){
	var yy = document.form2.yy.value;
	var mm = document.form2.mm.value;
	var dd = document.form2.dd.value;
	var hh = document.form2.hh.value;
	var inHour = document.form2.inHour.value;
	
	//潤年
	if((yy%2000)==4){	
		if( (mm=="02" && dd=="30" )||(mm=="02" && dd=="31" )){
			Warning();
			return false;
		}		
	}
	else{		//非潤年
		if( (mm=="02" && dd=="29" )||(mm=="02" && dd=="30" ) ||(mm=="02" && dd=="30" )){
			Warning();
			return false;
		}	
	}
	
	//判斷為30天的月份
	if(mm =="04" || mm=="06" || mm=="09" || mm=="11"){	
		if(dd =="31"){
			Warning();
			return false;
		}
	
	}
	
	return true;

}

function Warning(){
	alert("您選擇了無效的日期\n請重新選擇！！");
}	
*/
</script>
<link href="../menu.css" rel="stylesheet" type="text/css">

</head>

<body onLoad="showYMD('form1','yy','mm','dd');showYMDHM('form2','yy','mm','dd','hh','mi');document.form1.fltno.focus();showYMD('form3','yy','mm','dd')"><br>
<br>
<br>

<form name="form1" method="post" action="ShowFlt.jsp" target="_self" onSubmit="return checkFlt()">
    <span class="txtblue">★發特定航班：</span>  
    <select name="yy">
    <option value="2003">2003</option>
    <option value="2004">2004</option>
    <option value="2005">2005</option>
    <option value="2006">2006</option>
  </select>
    <span class="txtblue">年</span>  
  <select name="mm" >
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
  <span class="txtblue">月</span>&nbsp;&nbsp;
  <select name="dd" >
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
  <span class="txtblue">日</span>  <span class="txtblue">
  <input type="hidden" name="showMakeFile">
  Fltno</span>
  <input name="fltno" type="text" id="fltno" size="4" maxlength="4">
  <input name="Submit" type="submit" value="Query">
</form><br>
<br>


<form name="form2" method="post" action="ShowSomeTimeFlt.jsp" target="_self" onSubmit="return checkDate('form2','yy','mm','dd')">
  <span class="txtblue">★依時間發送：</span>
  <select name="yy">
    <option value="2003">2003</option>
    <option value="2004">2004</option>
    <option value="2005">2005</option>
    <option value="2006">2006</option>
  </select>
  <span class="txtblue">年</span>
  <select name="mm" >
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
  <span class="txtblue">月</span>&nbsp;&nbsp;
  <select name="dd" >
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
  <span class="txtblue">日</span>
  <select name="hh">
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


</select>
  <span class="txtblue">時</span>
  <select name="mi">
	<option value="00">00</option>
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
	<option value="32">32</option>	
	<option value="33">33</option>	
	<option value="34">34</option>	
	<option value="35">35</option>	
	<option value="36">36</option>	
	<option value="37">37</option>	
	<option value="38">38</option>	
	<option value="39">39</option>	
	<option value="40">40</option>	
	<option value="41">41</option>	
	<option value="42">42</option>	
	<option value="43">43</option>	
	<option value="44">44</option>	
	<option value="45">45</option>	
	<option value="46">46</option>	
	<option value="47">47</option>	
	<option value="48">48</option>	
	<option value="49">49</option>	
	<option value="50">50</option>	
	<option value="51">51</option>	
	<option value="52">52</option>	
	<option value="53">53</option>	
	<option value="54">54</option>	
	<option value="55">55</option>	
	<option value="56">56</option>	
	<option value="57">57</option>	
	<option value="58">58</option>	
	<option value="59">59</option>	
</select>
  <span class="txtblue">分&nbsp;&nbsp;
  在</span>
  <select name="inHour">
	<option value="1">1</option>
	<option value="2">2</option>
	<option value="3">3</option>
	<option value="6">6</option>
	<option value="12">12</option>
	<option value="24">24</option>
	<option value="48">48</option>
</select>
<span class="txtblue">幾小時內起飛的航班</span>
<input name="Submit" type="submit" value="Query">
</form>
<br>
<br><form name="form3" method="post" action="ShowFlt2.jsp" target="_self" onSubmit="return checkFlt()">
    <span class="txtblue">★待命或上課組員：</span>  
    <select name="yy">
    <option value="2003">2003</option>
    <option value="2004">2004</option>
    <option value="2005">2005</option>
    <option value="2006">2006</option>
  </select>
    <span class="txtblue">年</span>  
  <select name="mm" >
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
  <span class="txtblue">月</span>&nbsp;&nbsp;
  <select name="dd" >
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
  <span class="txtblue">日</span>  <span class="txtblue">
  <input type="hidden" name="showMakeFile">
  課程代碼
  <input name="classType" type="text"  size="4" onkeyup="javascript:this.value=this.value.toUpperCase();">
  </span>
  <input name="Submit" type="submit" value="Query" >
</form>

<hr size="1" noshade >
<p class="top">*使用說明：</p>
<ol>
  <li class="txtblue">發送簡訊予某日全部航班之後艙組員，使用「★發特定航班」。</li>
  <li class="txtblue">發送簡訊予特定航班，或該航班內組員名單有變動，使用「★發特定航班」及輸入Fltno。</li>
  <li class="txtblue">發送簡訊予某日幾小時內起飛的航班，使用「★依時間發送」。</li>
  <li class="txtxred">發送簡訊與上課或待命組員，請使用「★待命或上課組員」。</li>
  <li class="txtblue">產生手機號碼檔後，請至<a href="http://km.china-airlines.com/km/" target="_blank"><font color="#FF0000" style="text-decoration:underline;font-size:10pt ">華航簡訊服務網eSMS</font></a>上傳號碼檔以發送簡訊。</li>
</ol>
</body>
</html>

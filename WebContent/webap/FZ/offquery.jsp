<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,java.sql.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String occu = (String)session.getValue("occu");
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login

if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 
%>
<html>
<head>
<title>Off Crew Query</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" href="menu.css" type="text/css">
<script language="JavaScript" type="text/JavaScript">

	
 function shownow(){
	 nowdate = new Date();
	 var y,m,d;
	y = nowdate.getFullYear() ;
	m = nowdate.getMonth()+1;
	d =nowdate.getDate();

	if (m < 10) {
		form1.fmm.value = "0"+m;
	}
	else{
	form1.fmm.value = m;
	} 
	if(d<10){
		form1.fdd.value ="0" + d;
	}
	else{
		form1.fdd.value = d;

	}
	
	form1.fyy.value = y;

	form1.occu.value = "<%=occu%>";
 }
 
function checkdate(){		//檢查超過設定的時間，則不予查詢
	 /* nowdate = new Date();	//抓現在時間
	 var y,m,d
		m = nowdate.getMonth()+1;*/
		dt = new Date(40*86400000+(new Date()).getTime() );  //今天之後40天的日期
		//一天86400000豪秒= 1000*60*60*24
		
		


	var sely,selm,seld;
	seldate = new Date();	
	sely = form1.fyy.value;
	selm = parseInt(form1.fmm.value)-1;
	seld = parseInt(form1.fdd.value);
	
		seldate.setFullYear(sely);
		seldate.setMonth(selm);
		seldate.setDate(seld);		//設定選擇的日期
		

	if (seldate > dt){
		alert("Please reselect date to query!!\n\n日期超出資料範圍，請重新選擇！！");
		location.reload();
		return false;
		
	}
	

	else{
		return true;
	}


}

</script>

</head>

<body  onLoad="shownow()" >
<form name="form1" method="post" action="offcrewquery.jsp" target="mainFrame" onSubmit="return checkdate()">
  <select name="fyy" class="t1">
    <option value="2003">2003</option>
      <option value="2004">2004</option>
      <option value="2005">2005</option>
      <option value="2006">2006</option>
  </select>
    
  <select name="fmm" class="t1">
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
  <select name="fdd" class="t1">
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
  <select name="occu" class="t1" >
    <option value="CA">CA</option>
    <option value="FO">FO</option>
    <option value="FA">FA</option>
    <option value="PR">PR</option>
    <option value="FE">FE</option>
    <option value="FS">FS</option>
  </select>
  <input type="submit" name="Submit" value="Query" class="btm"> 
  <span class="txtblue">*Select date to query  off crew</span>
</form>
</body>
</html>

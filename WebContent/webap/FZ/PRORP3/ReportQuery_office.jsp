<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,java.util.GregorianCalendar"  %>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>座艙長報告 歷史資料查詢</title>
<link href="style2.css" rel="stylesheet" type="text/css">

</head>
<%
//今年跟去年
GregorianCalendar currentDate = new GregorianCalendar();
int thisYear = currentDate.get(GregorianCalendar.YEAR);
String month = Integer.toString(currentDate.get(GregorianCalendar.MONTH)+1);
int thisDate = currentDate.get(GregorianCalendar.DATE);
String myDate = String.valueOf(thisDate);
if(thisDate < 10) myDate = "0" + String.valueOf(thisDate);

if(month.length()<2){
	month = "0"+month;
}

String actionPage = "";
if("O".equals(request.getParameter("auth")) || "640073".equals(sGetUsr) || "638716".equals(sGetUsr)){
	actionPage="RepostListView.jsp";
}
else{
	actionPage="RepostList.jsp";
}
%>
<script language="javascript">
function showDate(){
	document.getElementById("yy").value="<%=thisYear%>";
	document.getElementById("mm").value="<%=month%>";
	document.getElementById("dd").value="<%=myDate%>";

}
function goPage(){
	var yy = document.getElementById("yy").value;
	var mm = document.getElementById("mm").value;
	var thisyear = "<%=thisYear%>";
	var thismonth = "<%=month%>";
	//同一年的
	if( yy == thisyear){
		if( (thismonth -mm )>=2){
			document.form1.action="RepostListHistory.jsp";
			//alert("1顯示歷史紀錄");
			return true;
		}else{
			document.form1.action="<%=actionPage%>";
			return true;
		}
	}else if( yy > thisyear){//跨年度
		document.form1.action="<%=actionPage%>";
		//alert("顯示紀錄");
		return true;
	}else{//去年的
		if(thismonth =="01" &&(  (yy==thisyear-1) && mm=="12")){	//
		document.form1.action="<%=actionPage%>";
		return true;
		}else{
			document.form1.action="RepostListHistory.jsp";
			//alert("2顯示歷史紀錄");
			return true;
		}
	}
}

function getGdYear(){
	var getFlightYear = document.form1.yy.value;
	var getFlightMohth = document.form1.mm.value;
	var setGdYear;
	
	if(parseInt(getFlightMohth)>10){
		document.form1.GdYear.value=parseInt(getFlightYear)+1;
	}
	else{
		document.form1.GdYear.value=parseInt(getFlightYear);
	}
}
</script>
<body onLoad="showDate();getGdYear()">
<form name="form1" action="RepostListHistory.jsp" method="post" target="mainFrame">
<select name="yy" class="txtblue" id="yy">
  <option value="<%=(thisYear-1)%>" ><%=(thisYear-1)%></option>
  <option value="<%=thisYear%>" ><%=thisYear%></option>
  <option value="<%=(thisYear+1)%>" ><%=(thisYear+1)%></option>
</select>
/ 
<select name="mm" class="txtblue" onChange="getGdYear()" id="mm">
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
/
<select name="dd" class="txtblue" id="dd">
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
  <label for="textfield" class="txtxred"><strong>GradeYear:</strong></label>
  <input type="text" name="GdYear" size="4" style="background-color:#FFFFFF ;border:0pt" class="txtxred" readonly>
<input name="Submit" type="submit" class="txtblue" value="Query" >
</form>
</body>
</html>

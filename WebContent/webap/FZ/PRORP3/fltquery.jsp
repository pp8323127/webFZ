<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.util.GregorianCalendar"%>
<%
//今年跟去年
GregorianCalendar currentDate = new GregorianCalendar();
int thisYear = currentDate.get(GregorianCalendar.YEAR);
int nextYear = thisYear +1;
String defaultVAL = "";
String monthHTML = "";
String yearHTML= "";
	String[] monthOption = {"01","02","03","04","05","06","07","08","09","10","11","12"};
	for(int i=0; i < monthOption.length; i++){
		if (monthOption[i].equals(Integer.toString(currentDate.get(GregorianCalendar.MONTH)+1) )) defaultVAL = " selected ";
			else defaultVAL="";
		monthHTML += "<option value=\"" + monthOption[i] + "\"" + defaultVAL + ">" + monthOption[i] + "</option>\r\n";
	}
	
	String[] yearOption = {Integer.toString(thisYear-1),Integer.toString(thisYear),Integer.toString(nextYear)};
	for(int i=0; i < yearOption.length; i++){
		if (yearOption[i].equals(Integer.toString(thisYear) )) defaultVAL = " selected ";
			else defaultVAL="";
		yearHTML += "<option value=\"" + yearOption[i] + "\"" + defaultVAL + ">" + yearOption[i] + "</option>\r\n";
	}

%>
<html>
<head>
<title>Flight Query</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">


<script language="JavaScript" type="text/JavaScript" src="../js/showDate.js"></script>

<script language="JavaScript" type="text/JavaScript">
function checkFltno(){
	var flt = document.form1.fltno.value;
	if(	flt == ""){	
		alert("請輸入Fltno.\n\nPlease insert Flight Number ");
		document.form1.fltno.focus();	
		return false;

	}
	
	else{
		return true;
	}
	
}
function getGdYear(){
	var getFlightYear = document.form1.fyy.value;
	var getFlightMohth = document.form1.fmm.value;
	var setGdYear;
	
	if(parseInt(getFlightMohth)>10){
		document.form1.GdYear.value=parseInt(getFlightYear)+1;
	}
	else{
		document.form1.GdYear.value=parseInt(getFlightYear);
	}
//	document.form1.GdYear.value=setGdYear;

}
</script>

<link href="style2.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000" onLoad="showYMD('form1','fyy','fmm','fdd');document.form1.fltno.focus();getGdYear()">
<form name="form1" method="post" target="mainFrame"   action="PRMenu.jsp" onSubmit="return checkFltno()">
  <select name="fyy" class="txtblue">
	<%=yearHTML%>
  </select>
    
  <select name="fmm" class="txtblue" onChange="getGdYear()">
	<%=monthHTML%>
  </select>
  <select name="fdd" class="txtblue" >
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
  <label for="fltno" class="txtblue">Fltno</label>  
  <input type="text" name="fltno" size="4" maxlength="4" onFocus="getGdYear()">&nbsp;  
  <label for="textfield" class="txtxred"><strong>GradeYear:</strong></label>
  <label for="gdyear"></label>
  <input type="text" name="GdYear" size="4" style="background-color:#FFFFFF ;border:0pt" class="txtxred" readonly>
  <input name="Submit" type="submit" class="txtblue" value="Query" >
  <span class="purple_txt"><strong>*You must insert FltNo</strong></span>
</form>
</body>
</html>

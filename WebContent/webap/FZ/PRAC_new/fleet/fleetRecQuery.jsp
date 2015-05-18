<%@page contentType="text/html; charset=big5" language="java" import="java.util.*"%>
<%
/*
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
*/
String userid = (String) session.getAttribute("userid") ; //get user id if already login
String userbase = (String) session.getAttribute("userbase") ; 
//***************************************
if (session.isNew() || userid == null) 
{		//check user session start first
	response.sendRedirect("../../logout.jsp");
} 
%>

<html>
<head>
<title>機型資格紀錄查詢</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href = "../../menu.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="../../style/loadingStatus.css">
<script src="../../js/showDate.js" type="text/javascript"></script>
<script LANGUAGE="JavaScript">
function f_submit()
{
	document.getElementById("showMessage").className="showStatus6";
	document.form1.Submit.disabled=1;
	return true;
}	

</script>
</head>
<body bgcolor="#FFFFFF" text="#000000" >
<form name="form1" method="post" target="mainFrame" action = "fleetRec.jsp" onsubmit= "return f_submit();">
<span class="txtblue">(機型資格紀錄查詢)Year/Month:</span>&nbsp;
  <select name="year1">
  <%
	java.util.Date now2 = new java.util.Date();
	int year	=	now2.getYear() + 1900;
	for (int j=year-1; j<=year; j++) 
	{    
  %>
     <option value="<%=j%>"><%=j%></option>
    <%
	}
  %>
  </select>/
  <select name="month1">
	<option value="01"><font face="Arial, Helvetica, sans-serif" size="2">01</font></option>
    <option value="02"><font face="Arial, Helvetica, sans-serif" size="2">02</font></option>
    <option value="03"><font face="Arial, Helvetica, sans-serif" size="2">03</font></option>
    <option value="04"><font face="Arial, Helvetica, sans-serif" size="2">04</font></option>
    <option value="05"><font face="Arial, Helvetica, sans-serif" size="2">05</font></option>
    <option value="06"><font face="Arial, Helvetica, sans-serif" size="2">06</font></option>
    <option value="07"><font face="Arial, Helvetica, sans-serif" size="2">07</font></option>
    <option value="08"><font face="Arial, Helvetica, sans-serif" size="2">08</font></option>
    <option value="09"><font face="Arial, Helvetica, sans-serif" size="2">09</font></option>
    <option value="10"><font face="Arial, Helvetica, sans-serif" size="2">10</font></option>
    <option value="11"><font face="Arial, Helvetica, sans-serif" size="2">11</font></option>
    <option value="12"><font face="Arial, Helvetica, sans-serif" size="2">12</font></option>
  </select> 
  <span class="txtblue">~Year/Month:</span>&nbsp;
  <select name="year2">
  <%
	java.util.Date now3 = new java.util.Date();
	int year2	=	now3.getYear() + 1900;
	for (int j=year-1; j<=year; j++) 
	{    
  %>
     <option value="<%=j%>"><%=j%></option>
    <%
	}
  %>
  </select>/
  <select name="month2">
	<option value="01"><font face="Arial, Helvetica, sans-serif" size="2">01</font></option>
    <option value="02"><font face="Arial, Helvetica, sans-serif" size="2">02</font></option>
    <option value="03"><font face="Arial, Helvetica, sans-serif" size="2">03</font></option>
    <option value="04"><font face="Arial, Helvetica, sans-serif" size="2">04</font></option>
    <option value="05"><font face="Arial, Helvetica, sans-serif" size="2">05</font></option>
    <option value="06"><font face="Arial, Helvetica, sans-serif" size="2">06</font></option>
    <option value="07"><font face="Arial, Helvetica, sans-serif" size="2">07</font></option>
    <option value="08"><font face="Arial, Helvetica, sans-serif" size="2">08</font></option>
    <option value="09"><font face="Arial, Helvetica, sans-serif" size="2">09</font></option>
    <option value="10"><font face="Arial, Helvetica, sans-serif" size="2">10</font></option>
    <option value="11"><font face="Arial, Helvetica, sans-serif" size="2">11</font></option>
    <option value="12"><font face="Arial, Helvetica, sans-serif" size="2">12</font></option>
  </select> 
  <span class="txtblue">&nbsp;&nbsp;Fleet:</span>&nbsp;
  <select name="fleet">
    <option value="333"><font face="Arial, Helvetica, sans-serif" size="2">333</font></option>
    <option value="343"><font face="Arial, Helvetica, sans-serif" size="2">343</font></option>
    <option value="738"><font face="Arial, Helvetica, sans-serif" size="2">738</font></option>
    <option value="744"><font face="Arial, Helvetica, sans-serif" size="2">744</font></option>
  </select>
  <span class="txtblue">&nbsp;&nbsp;Rank:</span>&nbsp;
  <select name="rank">
    <option value="PR"><font face="Arial, Helvetica, sans-serif" size="2">PR</font></option>
    <option value="FC"><font face="Arial, Helvetica, sans-serif" size="2">FC</font></option>
    <option value="FF"><font face="Arial, Helvetica, sans-serif" size="2">FF</font></option>
    <option value="MF"><font face="Arial, Helvetica, sans-serif" size="2">MF</font></option>
    <option value="FY"><font face="Arial, Helvetica, sans-serif" size="2">FY</font></option>
    <option value="MY"><font face="Arial, Helvetica, sans-serif" size="2">MY</font></option>
  </select>
   <span class="txtblue">&nbsp;&nbsp;or Empn./Sern:</span>&nbsp;
  <input name="empn" id="empn"  type="text" size="10" maxlength="10" class="txtblue">
<input name="Submit" type="submit" id="Submit" value="Query">
<input name="btn" type="button" value="Reset" OnClick="document.form1.Submit.disabled=0;"> 
<div id="showMessage" class="hiddenStatus">Loading....</div>
</form>
</body>
</html>

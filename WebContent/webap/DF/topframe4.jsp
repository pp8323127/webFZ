<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
if (session.isNew()) 
{		//check user session start first
  %> <jsp:forward page="login.jsp" /> <%
} 
if (sGetUsr == null) 
{		//check if not login
  %> <jsp:forward page="login.jsp" /> <%
} 
%>
<html>
<head>
<title>Top Frame</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
</head>

<body bgcolor="#FFFFFF" text="#000000" background="crew_tital.gif">
<p>&nbsp;</p>
<table width="81%" border="0">
  <tr> 
    <td height="38"> 
      <form name="form1" method="post" action="dfr002.jsp" target="mainFrame">
        <font face="Arial, Helvetica, sans-serif" size="2"> Year 
        <select name="year" size="1">
          <option value="1999">1999</option>
          <option value="2000">2000</option>
          <option value="2001">2001</option>
          <option value="2002">2002</option>
          <option value="2003">2003</option>
          <option value="2004">2004</option>
          <option value="2005">2005</option>
        </select>
<!--        Month
        <select name="month" size="1">
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
        </select>-->
        <input type="submit" name="Submit" value="Submit">
        </font> 
      </form>
    </td>
  </tr>
</table>
<p>&nbsp;</p>
</body>
</html>

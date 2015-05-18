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
      <form name="form1" method="post" action="crewlist.jsp" target="_top">
        <font face="Arial, Helvetica, sans-serif" size="2"> Fleet 
        <select name="fleet" size="1">
          <option value="744">744</option>
          <option value="742">742</option>
          <option value="738">738</option>
          <option value="343">343</option>
          <option value="AB6">AB6</option>
          <option value="M11">M11</option>
          <option value="74F">74F</option>
        </select>
        Duty 
        <select name="duty" size="1">
          <option value="CA">CA</option>
          <option value="FO">FO</option>
          <option value="SO">SO</option>
          <option value="FE">FE</option>
          <option value="RP">RP</option>
        </select>
        <input type="submit" name="Submit" value="Submit">
        </font> 
      </form>
    </td>
    <!--<td height="38"> 
      <form name="form2" method="post" action="accrec.jsp" target="mainFrame">
        <font face="Arial, Helvetica, sans-serif" size="2"> Year 
        <select name="year" size="1">
          <option value="1999">1999</option>
          <option value="2000">2000</option>
          <option value="2001">2001</option>
          <option value="2002">2002</option>
          <option value="2003">2003</option>
          <option value="2004">2004</option>
          <option value="2005">2005</option>
          <option value="2006">2006</option>
        </select>
        Month
        <select name="month" size="1">
          <option value="1">1</option>
          <option value="2">2</option>
          <option value="3">3</option>
          <option value="4">4</option>
          <option value="5">5</option>
          <option value="6">6</option>
          <option value="7">7</option>
          <option value="8">8</option>
          <option value="9">9</option>
          <option value="10">10</option>
          <option value="11">11</option>
          <option value="12">12</option>
        </select>
        EmpNo 
        <input type="text" name="empno" size="12">
        <input type="submit" name="Submit2" value="Submit">
        </font> 
      </form>
    </td>-->
  </tr>
</table>
<p>&nbsp;</p>
</body>
</html>

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
<%@ page import="java.util.Calendar" %>
<% 
  Calendar today = Calendar.getInstance() ;
  int year = today.get(Calendar.YEAR);
  int mon  = today.get(Calendar.MONTH);  //MONTH from 0 to 11
  if (mon == 0)
  {
  		mon = 12;
		year = year -1;
  }
  int day = today.get(Calendar.DATE);
%>
<html>
<head>
<title>Accrec Select</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
</head>

<body bgcolor="#FFFFFF" text="#000000" background="crew_tital.gif">
<p>&nbsp;</p>
<table width="81%" border="0">
  <tr> 
  <td height="38"> 
      <form name="form" method="post" action="accrec.jsp" target="_top">
        <font face="Arial, Helvetica, sans-serif" size="2"> Year 
        <select name="year" size="1">
          <option value="<%= year %>"><%= year %></option>
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
          <option value="<%= mon %>"><%= mon %></option>
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
        <%
           String myempno = request.getParameter("empno");
        %>
        <input type="text" name="empno" size="12" value="<%= myempno %>">
        <input type="submit" name="Submit" value="Submit">
        </font> 
      </form>
    </td>
  </tr>
</table>
<p>&nbsp;</p>
</body>
</html>

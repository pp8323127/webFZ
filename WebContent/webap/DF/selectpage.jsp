<html>
<head>
<title>select page</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
</head>

<body bgcolor="#FFFFFF" text="#000000" background="clearday.jpg">
<p>&nbsp;</p>
<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
if (session.isNew()) 
{		//check user session start first
%>
<jsp:forward page="login.jsp" /> 
<%
} 
if (sGetUsr == null) 
{		//check if not login
} 

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
    <div>
  <p align="center"><font face="Comic Sans MS" size="5" color="#330099"><b><i><font color="#660099">Crew 
    Record </font></i></b></font></p>
</div>
<table width="99%" border="0" height="38">
  <tr> 
    <td height="45"> 
      <form name="form" method="post" action="accrec.jsp" target="_top">
        <font face="Arial, Helvetica, sans-serif" size="2"> 
        <div align="center">Year 
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
        </div>
        </font>
      </form>
    </td>
  </tr>
</table>
  <p align="center"><font face="Comic Sans MS" color="#339966"><a href="frame.jsp">Crew 
    Personal Report</a></font></p>
  <%
  //if (!session.getValue("MM_Username").equals("guest"))
  //{
  %>
  <p align="center"><font face="Comic Sans MS" color="#339966"><a href="ckauthorized.jsp?pageid=p0003&linkpage=frame1.jsp">Month 
    Record Modify</a></font></p>
  <!--<p align="center"><font face="Comic Sans MS" color="#339966"><a href="ckauthorized.jsp?pageid=p0001&linkpage=addcrew.jsp">Crew Insert</a></font></p>
  
<p align="center"><font face="Comic Sans MS" color="#339966"><a href="ckauthorized.jsp?pageid=p0002&linkpage=frame2.jsp">Crew 
  Modify</a></font></p>-->
<p align="left"><font face="Arial, Helvetica, sans-serif" color="#CC0000" size="3">FlightCrew 
  Report</font><br>
</p>
<ul>
  <li><font face="Arial, Helvetica, sans-serif" size="2"><a href="frame3.jsp" target="_top">BLK 
    Time Report</a></font> </li>
  <li><a href="frame4.jsp" target="_top"><font face="Arial, Helvetica, sans-serif" size="2">PIC 
    Time Report</font></a></li>
</ul>
<%
  //}
  %>
<p>&nbsp;</p>
<p align="right"><img src="logo2.gif" width="165" height="35"></p>
</body>
</html>
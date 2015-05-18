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
<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*"%>
<%@ include file="../Connections/cnORP3DF.jsp" %>
<html>
<head>
<title>Blk Time</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
</head>
<body background="clearday.jpg">
<center>
<%
String year = request.getParameter("year");
String userid = (String)session.getValue("MM_Username");
float keeptotal[] = new float[12];
String oldempno = "";
String oldfleet = "";
String oldoccu = "";
String oldname = "";
int i;
float timesum = 0;

String mysql = "select a.yy yy, " +
"a.mm mm, " +
"b.fleet fleet, " +
"b.occu occu, " +
"a.staff_num empno, " +
"b.name name, " +
"a.dutyip + a.dutyca + a.dutyfo + a.dutyife + a.dutyfe total " +
"from DFTCREC a, dftcrew b " +
"where to_char(a.staff_num) = b.empno and a.yy = " + year +
" group by a.staff_num, a.yy, a.mm, b.fleet, b.occu, b.name, a.dutyip, a.dutyca, a.dutyfo, a.dutyife, a.dutyfe " +
"order by b.fleet, a.staff_num";

Class.forName(MM_cnORP3DF_DRIVER);
Connection myConn = DriverManager.getConnection(MM_cnORP3DF_STRING,MM_cnORP3DF_USERNAME,MM_cnORP3DF_PASSWORD);
Statement stmt = myConn.createStatement();
ResultSet myResultSet = stmt.executeQuery(mysql);
%>
<p><font face="Comic Sans MS" size="3"><%= year %> Flight Crew BLK Time Report</font></p>
  <table border="1">
    <tr> 
      <td> 
        <div align="center"><b>Fleet</b></div>
      </td>
      <td> 
        <div align="center"><b>Occu</b></div>
      </td>
      <td> 
        <div align="center"><b>Empno</b></div>
      </td>
      <td> 
        <div align="center"><b>Name</b></div>
      </td>
      <td> 
        <div align="center"><b>JAN</b></div>
      </td>
      <td> 
        <div align="center"><b>FEB</b></div>
      </td>
      <td> 
        <div align="center"><b>MAR</b></div>
      </td>
      <td> 
        <div align="center"><b>APR</b></div>
      </td>
      <td> 
        <div align="center"><b>MAY</b></div>
      </td>
      <td> 
        <div align="center"><b>JUN</b></div>
      </td>
      <td> 
        <div align="center"><b>JUL</b></div>
      </td>
      <td> 
        <div align="center"><b>AUG</b></div>
      </td>
      <td> 
        <div align="center"><b>SEP</b></div>
      </td>
      <td> 
        <div align="center"><b>OCT</b></div>
      </td>
      <td> 
        <div align="center"><b>NOV</b></div>
      </td>
      <td> 
        <div align="center"><b>DEC</b></div>
      </td>
	  <td> 
        <div align="center"><b>Summary</b></div>
      </td>
    </tr>
    <%
if (myResultSet != null)
{
while (myResultSet.next())
{
   String yy = myResultSet.getString("yy");
   String mm = myResultSet.getString("mm");
   String fleet = myResultSet.getString("fleet");
   String occu = myResultSet.getString("occu");
   String empno = myResultSet.getString("empno");
   String name = myResultSet.getString("name");
   String total = myResultSet.getString("total");
   
   if (oldempno.equals(empno))
   {
   		i = Integer.parseInt(mm) - 1;
		keeptotal[i] = Integer.parseInt(total);
   }
   else
   {
   		if (oldempno != "")
		{
		for (int n = 0; n < keeptotal.length; n++)
			{
				timesum = timesum + keeptotal[n];
			}
%>
    <!--<form name="form1" method="post" action="updcrew.jsp">-->
    <tr> 
      <td> 
        <div align="center"><%= oldfleet %></div>
      </td>
      <td> 
        <div align="center"><%= oldoccu %></div>
      </td>
      <td> 
        <div align="center"><%= oldempno %></div>
      </td>
      <td> 
        <div align="center"><%= oldname %></div>
      </td>
      <td> 
        <div align="center"><%= Math.floor(((keeptotal[0]/60)+0.0005)*1000)/1000 %></div>
      </td>
      <td> 
        <div align="center"><%= Math.floor(((keeptotal[1]/60)+0.0005)*1000)/1000 %></div>
      </td>
      <td> 
        <div align="center"><%= Math.floor(((keeptotal[2]/60)+0.0005)*1000)/1000 %></div>
      </td>
      <td> 
        <div align="center"><%= Math.floor(((keeptotal[3]/60)+0.0005)*1000)/1000 %></div>
      </td>
      <td> 
        <div align="center"><%= Math.floor(((keeptotal[4]/60)+0.0005)*1000)/1000 %></div>
      </td>
      <td> 
        <div align="center"><%= Math.floor(((keeptotal[5]/60)+0.0005)*1000)/1000 %></div>
      </td>
      <td> 
        <div align="center"><%= Math.floor(((keeptotal[6]/60)+0.0005)*1000)/1000 %></div>
      </td>
      <td> 
        <div align="center"><%= Math.floor(((keeptotal[7]/60)+0.0005)*1000)/1000 %></div>
      </td>
      <td> 
        <div align="center"><%= Math.floor(((keeptotal[8]/60)+0.0005)*1000)/1000 %></div>
      </td>
      <td> 
        <div align="center"><%= Math.floor(((keeptotal[9]/60)+0.0005)*1000)/1000 %></div>
      </td>
      <td> 
        <div align="center"><%= Math.floor(((keeptotal[10]/60)+0.0005)*1000)/1000 %></div>
      </td>
      <td> 
        <div align="center"><%= Math.floor(((keeptotal[11]/60)+0.0005)*1000)/1000 %></div>
      </td>
	  <td> 
        <div align="center"><%= Math.floor(((timesum/60)+0.0005)*1000)/1000 %></div>
      </td>
    </tr>
    <!--</form>-->
    <% 
			}
			
			oldempno = empno;
			oldfleet = fleet;
			oldoccu = occu;
			oldname = name;
			timesum = 0;
			for (int n = 0; n < keeptotal.length; n++)
			{
				keeptotal[n] = 0;
			}
			i = Integer.parseInt(mm) - 1;
			keeptotal[i] = Integer.parseInt(total);
		}       
	}  
}
stmt.close();
myConn.close();
%>
  </table>
</center>
</body>
</html>
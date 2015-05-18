<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*,javax.sql.DataSource,javax.naming.*"%>
<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

if (session.isNew() || sGetUsr == null) 
{		//check user session start first
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 
%>
<html>
<head>
<title>Pic Time</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>
<body>
<center>
<%
String year = request.getParameter("year");
String fleet = request.getParameter("fleet");
String rank = request.getParameter("rank");

float pic[] = {0,0};
String oldempno = "";
String oldfleet = "";
String oldname = "";
float timesum = 0;
//GetRound gr = new GetRound();
Connection myConn = null;
Statement stmt = null;
ResultSet myResultSet = null;

String whereString = "";

if(!"".equals(fleet)) whereString = " and b.ac_type='"+fleet+"' ";
if(!"".equals(rank)) whereString = whereString + " and b.job_type='"+rank+"' ";

String mysql = "select a.staff_num empno, a.fleet_cd afleet, nvl(b.ac_type,'---') fleet, b.c_name name, sum(nvl(a.pic,0)) sumpic " +
"from DFTCREC a, fztckpl b " +
"where to_char(a.staff_num) = b.empno and a.yy = "+year+" and a.fleet_cd <> 'OPS' " + whereString +
"group by a.staff_num, a.fleet_cd, b.c_name, b.ac_type " +
"order by b.ac_type, a.staff_num";
//DataSource
Context initContext = null;
DataSource ds = null;
//DataSource
try{
	initContext = new InitialContext();
	//connect to ORP3 by Datasource
	ds = (javax.sql.DataSource)initContext.lookup("CAL.DFDS01");
	myConn = ds.getConnection();
	stmt = myConn.createStatement();
	myResultSet = stmt.executeQuery(mysql);
%>
<p class="txtblue"><font face="Comic Sans MS" size="3"><%= year %> Flight Crew PIC Time Report(UTC Date / 員額表)</font></p>
  <table width="50%" border="1" cellpadding="0" cellspacing="0">
    <tr class="tablehead"> 
      <td>Fleet</td>
      <td>Empno</td>
      <td>Name</td>
      <td>On Type PIC</td>
      <td>Other Type PIC</td>
	  <td>Summary</td>
    </tr>
    <%
if (myResultSet != null)
{
while (myResultSet.next())
{
   String fleet = myResultSet.getString("fleet");
   String afleet = myResultSet.getString("afleet");
   String empno = myResultSet.getString("empno");
   String name = myResultSet.getString("name");
   int sumpic = myResultSet.getInt("sumpic");
   
   if (oldempno.equals(empno))
   {
   		if (oldfleet.equals(afleet))
		{
			pic[0] = pic[0] + sumpic;
		}
		else
		{
			pic[1] = pic[1] + sumpic;
		}

    }
   else
   {
  		timesum = pic[0] + pic[1];
   		if (oldempno != "" && timesum != 0)
		{
%>

    <tr class="tablebody"> 
      <td><%= oldfleet %></td>
      <td><%= oldempno %></td>
      <td><%= oldname %></td>
      <td><div align="left"><%= Math.floor(((pic[0]/60)+0.0005)*1000)/1000 %></div></td>
	  <td><div align="left"><%= Math.floor(((pic[1]/60)+0.0005)*1000)/1000 %></div></td>
      <td><div align="left"><%= Math.floor(((timesum/60)+0.0005)*1000)/1000 %></div></td>
    </tr>

    <% 
			}
			
			oldempno = empno;
			oldfleet = fleet;
			oldname = name;
			timesum = 0;
			for (int n = 0; n < pic.length; n++)
			{
				pic[n] = 0;
			}
			if (oldfleet.equals(afleet))
			{
				pic[0] =  sumpic;
			}
			else
			{
				pic[1] =  sumpic;
			}
	
		}       
	}  
}
}
catch(Exception e) {  
	out.print(e.toString());
}
finally
{
	try{if(stmt != null) stmt.close();}catch(Exception e){}
	try{if(myConn != null) myConn.close();}catch(Exception e){}
}
%>
</table>
</center>
</body>
</html>
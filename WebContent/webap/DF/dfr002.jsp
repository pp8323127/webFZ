<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first
  %> <jsp:forward page="login.jsp" /> <%
} 
%>
<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*"%>
<%@ include file="../Connections/cnORP3DF.jsp" %>
<html>
<head>
<title>Pic Time</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
<style type="text/css">
<!--
.style7 {font-family: Arial, Helvetica, sans-serif; font-size: 12px; font-weight: bold; }
-->
</style>
<link href="../FZ/menu.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style9 {font-size: 16px; line-height: 22px; color: #464883; font-family: "Arial";}
-->
</style>
</head>
<body background="clearday.jpg">
<center>
<%
String year = request.getParameter("year");
//String userid = (String)session.getValue("MM_Username");
float pic[] = {0,0};
String oldempno = "";
String oldfleet = "";
String oldname = "";
float timesum = 0;
//GetRound gr = new GetRound();
Connection myConn = null;
Statement stmt = null;
ResultSet myResultSet = null;

String mysql = "select a.staff_num empno, a.fleet_cd afleet, nvl(b.fleet,'---') fleet, b.name name, sum(nvl(a.pic,0)) sumpic " +
" from DFTCREC a, dftcrew b " +
" where to_char(a.staff_num) = b.empno and a.yy = " + year + " and a.fleet_cd <> 'OPS'" +
" group by a.staff_num, a.fleet_cd, b.name, b.fleet " +
" order by b.fleet, a.staff_num";
try{
Class.forName(MM_cnORP3DF_DRIVER);
myConn = DriverManager.getConnection(MM_cnORP3DF_STRING,MM_cnORP3DF_USERNAME,MM_cnORP3DF_PASSWORD);
stmt = myConn.createStatement();
myResultSet = stmt.executeQuery(mysql);
%>
<p class="style9"><font face="Comic Sans MS" size="3"><%= year %> Flight Crew PIC Time Report</font></p>
  <table width="50%" border="1" cellpadding="0" cellspacing="0">
    <tr class="tablehead"> 
      <td> 
        <div align="center" class="style7">Fleet</div>
      </td>
      <td> 
        <div align="center" class="style7">Empno</div>
      </td>
      <td> 
        <div align="center" class="style7">Name</div>
      </td>
      <td> 
        <div align="center" class="style7">On Type PIC</div>
      </td>
      <td> 
        <div align="center" class="style7">Other Type PIC</div>
      </td>
	  <td> 
        <div align="center" class="style7">Summary</div>
      </td>
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
      <td> 
        <div align="center"><%= oldfleet %></div>
      </td>
      <td> 
        <div align="center"><%= oldempno %></div>
      </td>
      <td> 
        <div align="center"><%= oldname %></div>
      </td>
      <td> 
        <div align="left"></div>
      <div align="left"><%= Math.floor(((pic[0]/60)+0.0005)*1000)/1000 %></div></td>
      <td> 
        <div align="left"><%= Math.floor(((pic[1]/60)+0.0005)*1000)/1000 %></div></td>
      <td> 
        <div align="left"><%= Math.floor(((timesum/60)+0.0005)*1000)/1000 %></div></td>
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
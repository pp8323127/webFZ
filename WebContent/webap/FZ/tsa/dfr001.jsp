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
<title>Blk Time</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>
<body>
<center>
<%
String year = request.getParameter("year");
String in_fleet = request.getParameter("fleet");
String rank = request.getParameter("rank");

String userid = (String)session.getValue("MM_Username");
float keeptotal[] = new float[12];
String oldempno = "";
String oldfleet = "";
String oldoccu = "";
String oldname = "";
int i;
float timesum = 0;
String bcolor = null;
int xCount = 0;
String whereString = "";

if(!"".equals(in_fleet)) whereString = " and b.ac_type='"+in_fleet+"' ";
if(!"".equals(rank)) whereString = whereString + " and b.job_type='"+rank+"' ";

String mysql = "select a.yy yy, " +
"a.mm mm, " +
"a.fleet_cd fleet, " +
"b.job_type occu, " +
"a.staff_num empno, " +
"b.c_name name, " +
"sum(a.dutyip + a.dutyca + a.dutyfo + a.dutyife + a.dutyfe) total " +
"from DFTCREC a, fztckpl b " +
"where to_char(a.staff_num) = b.empno and a.fleet_cd = decode(b.ac_type,'738','737', b.ac_type) and a.yy = " + year + 
whereString +
" group by a.staff_num, a.yy, a.mm, a.fleet_cd, b.job_type, b.c_name " +
"order by a.fleet_cd, b.job_type, a.staff_num";
//out.println(mysql);
//DataSource
Context initContext = null;
DataSource ds = null;
//DataSource
Connection myConn = null;
Statement stmt = null;
ResultSet myResultSet = null;

try{
	initContext = new InitialContext();
	//connect to ORP3 by Datasource
	ds = (javax.sql.DataSource)initContext.lookup("CAL.DFDS01");
	myConn = ds.getConnection();
		stmt = myConn.createStatement();
		myResultSet = stmt.executeQuery(mysql);
		%>
		<div class="txtblue"><font face="Comic Sans MS" size="3"><%= year %> Flight Crew BLK Time Report(Log - UTC Date / 員額表)</font></div>
		<br>
		<span class="txtxred">Cumulate All Type
		  </span>
		<table width="85%" border="1" cellpadding="0" cellspacing="0">
			<tr class="tablehead"> 
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
				xCount++;
				if (xCount%2 == 0)
				{
					bcolor = "#C9C9C9";
				}
				else
				{
					bcolor = "#FFFFFF";
				}
		%>
			<!--<form name="form1" method="post" action="updcrew.jsp">-->
			<tr class="tablebody"  bgcolor="<%=bcolor%>"> 
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
}
catch (Exception e)
{
	  out.println(e.toString());
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(myConn != null) myConn.close();}catch(SQLException e){}
}
if(xCount > 0){
	for (int n = 0; n < keeptotal.length; n++){
		timesum = timesum + keeptotal[n];
	}
%>
<tr class="tablebody"  bgcolor="<%=bcolor%>"> 
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
<%
}
%>
  </table>
</center>
</body>
</html>
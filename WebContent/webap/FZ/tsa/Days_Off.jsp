<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*,javax.naming.*,javax.sql.DataSource,fz.UnicodeStringParser"%>
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
<title>Days Off</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>
<body>
<center>
<%
String yy = request.getParameter("yy");
String in_fleet = request.getParameter("fleet");
String in_rank = request.getParameter("rank");

ArrayList fleet = new ArrayList();
ArrayList rank = new ArrayList();
ArrayList empno = new ArrayList();
ArrayList mm = new ArrayList();
ArrayList cdays = new ArrayList();
ArrayList cname = new ArrayList();

Context initContext = null;
DataSource ds = null;

Connection myConn = null;
Statement stmt = null;
ResultSet myResultSet = null;

String myrank = "";
String kempno = "";
String bcolor = "";
boolean t = false;
int sdays = 0;
int xCount = 0;

if(!"ALL".equals(in_rank)){
	myrank = "and k.rank_cd='"+in_rank+"' ";
}

String mysql = "select fleet, rank, empno, cname, mymm, count(*) cdays " +
"from ( " +
"select f.fleet_cd fleet, k.rank_cd rank, r.staff_num empno, c.preferred_name cname, to_char(r.act_str_dt,'mm') mymm " +
"from roster_v r, crew_v c, crew_rank_v k, rank_tp_v rt, crew_fleet_v f " +
"where r.staff_num = c.staff_num " +
"and c.staff_num=k.staff_num " +
"and c.staff_num=f.staff_num " +
"and k.rank_cd=rt.display_rank_cd " +
"and (f.exp_dt is null or f.exp_dt >= sysdate) " +
"and (k.exp_dt is null or k.exp_dt >= sysdate) " +
"and f.fleet_cd='"+in_fleet+"' " + myrank +
"and r.delete_ind='N' " +
"and emp_status='A' " +
"and rt.fd_ind='Y' " +
"AND r.act_str_dt BETWEEN  to_date('"+yy+"0101 00:00','yyyymmdd hh24:mi') " + 
"AND To_Date('"+yy+"1231 23:59','yyyymmdd hh24:mi') " + 
"and (r.duty_cd in ('ADO','RDO','BOFF','HLT') or r.duty_cd is null) " +
") " +
"group by fleet, rank, empno, cname, mymm";

//out.println(mysql);
try {
	initContext = new InitialContext();
	//connect to AOCIPROD ORP3 / ORT1 by Datasource
	ds = (javax.sql.DataSource)initContext.lookup("CAL.FZDS03");
	myConn = ds.getConnection();
	UnicodeStringParser usp = new UnicodeStringParser();
	
	stmt = myConn.createStatement();
	myResultSet = stmt.executeQuery(mysql);
	
	if (myResultSet != null)
	{
		while (myResultSet.next())
		{
			empno.add(myResultSet.getString("empno"));
			mm.add(myResultSet.getString("mymm"));
			cname.add(new String(usp.removeExtraEscape(myResultSet.getString("cname")).getBytes(), "Big5"));
			rank.add(myResultSet.getString("rank"));
			fleet.add(myResultSet.getString("fleet"));
			cdays.add(myResultSet.getString("cdays"));
		}  
	}
}catch (Exception e)
{
	  out.println(e.toString());
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(myConn != null) myConn.close();}catch(SQLException e){}
}
%>
<div class="txtblue"><font face="Comic Sans MS" size="3"><%= yy %> <%=in_fleet%> <%=in_rank%> Flight Crew Days Off Report</font></div>
<br>
  <table width="85%" border="1" cellpadding="0" cellspacing="0">
    <tr class="tablehead"> 
      <td> 
        <div align="center"><b>Fleet</b></div>
      </td>
      <td> 
        <div align="center"><b>Rank</b></div>
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
for(int i=0;i<empno.size();i++){	
	if (i != 0) i--;
	t = false;
	if( kempno == null || !kempno.equals((String)empno.get(i))){
		t = true;
		kempno = (String)empno.get(i);
		sdays = 0;
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
		<tr class="tablebody" bgcolor="<%=bcolor%>"> 
		<td> 
			<div align="center"><%=(String)fleet.get(i)%></div>
		</td>
		<td> 
			<div align="center"><%=(String)rank.get(i)%></div>
		</td>
		<td> 
			<div align="center"><%=kempno%></div>
		</td>
		<td> 
			<div align="left"><%=(String)cname.get(i)%></div>
		</td>
<%
	}
	for(int j=1;j<13;j++){
		if(j == Integer.parseInt((String)mm.get(i)) && kempno.equals((String)empno.get(i)))	{
			sdays = sdays + Integer.parseInt((String)cdays.get(i));
			if(Integer.parseInt((String)cdays.get(i)) < 8){
				out.println("<td><div align='center'><span class='txtxred'>"+(String)cdays.get(i)+"</span></div></td>");
			}
			else{
				out.println("<td><div align='center'>"+(String)cdays.get(i)+"</div></td>");
			}
			if (i<empno.size() - 1) i++;
		}
		else{
			out.println("<td><div align='center'>&nbsp;</div></td>");
		}
		if(j == 12){
			if(sdays < 96){
				out.println("<td><div align='center'><span class='txtxred'>"+sdays+"</span></div></td>");
			}
			else{
				out.println("<td><div align='center'>"+sdays+"</div></td>");
			}
		}
	}
	if(t){
		out.println("</tr>");
	}
}
%>
  </table>
  <table width="85%"  border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="txttitle">Records : <%=xCount%></td>
    </tr>
  </table>
</center>
</body>
</html>
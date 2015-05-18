<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*,javax.naming.*,javax.sql.DataSource,java.math.BigDecimal"%>
<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

if (session.isNew()) 
{		//check user session start first
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 
if (sGetUsr == null) 
{		//check if not login
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
String infleet = request.getParameter("fleet");
String rank = request.getParameter("rank");

String conditionString = "";

if(!"".equals(infleet)) conditionString = conditionString + " and b.fleet='"+infleet+"' ";
if(!"".equals(rank)) conditionString = conditionString + " and b.occu='"+rank+"' ";

float kops = 0;
float sblk = 0;
int scale = 3; //取三位小數
String kempno = null;
String bcolor = null;
int xCount = 0;
boolean t = false;

ArrayList empno = new ArrayList();
ArrayList mm = new ArrayList();
ArrayList ops = new ArrayList();
ArrayList cname = new ArrayList();
ArrayList occu = new ArrayList();
ArrayList fleet = new ArrayList();

Context initContext = null;
DataSource ds = null;

Connection myConn = null;
Statement stmt = null;
ResultSet myResultSet = null;

String mysql = "select a.staff_num staff_num, a.mm mm, (a.ca + a.pic + a.ops) ops, b.name cname, b.occu occu, b.fleet fleet " + 
"from dftcrec a, dftcrew b " + 
"where to_char(a.staff_num) = b.empno " + conditionString +
"and yy = "+year+" and fleet_cd = 'OPS' order by b.fleet, b.occu, a.staff_num, mm";
//out.println(mysql);
try {
	initContext = new InitialContext();
	//connect to DFDB ORP3 / ORT1 by Datasource
	ds = (javax.sql.DataSource)initContext.lookup("CAL.DFDS01");
	myConn = ds.getConnection();
	
	stmt = myConn.createStatement();
	myResultSet = stmt.executeQuery(mysql);
	
	if (myResultSet != null)
	{
		while (myResultSet.next())
		{
			empno.add(myResultSet.getString("staff_num"));
			mm.add(myResultSet.getString("mm"));
			cname.add(myResultSet.getString("cname"));
			occu.add(myResultSet.getString("occu"));
			fleet.add(myResultSet.getString("fleet"));
			
			kops = myResultSet.getFloat("ops")/60;  //換成小時
			BigDecimal bd = new BigDecimal(kops);
			
			ops.add(bd.setScale(scale,BigDecimal.ROUND_HALF_UP).toString());
		}  
	}
	/*for(int i=0;i<empno.size();i++)
	{
		out.println(i + " ");
		out.println(empno.get(i));
		out.println(mm.get(i));
		out.println(ops.get(i)+"<br>");
	}*/
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
<div class="txtblue"><font face="Comic Sans MS" size="3"><%= year %> <%=infleet%> <%=rank%> Flight Crew BLK Time Report(OPS - TPE Time)</font></div>
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
for(int i=0;i<empno.size();i++){	
	if (i != 0) i--;
	t = false;
	if( kempno == null || !kempno.equals((String)empno.get(i))){
		t = true;
		kempno = (String)empno.get(i);
		sblk = 0;
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
			<div align="center"><%=(String)occu.get(i)%></div>
		</td>
		<td> 
			<div align="center"><%=kempno%></div>
		</td>
		<td> 
			<div align="center"><%=(String)cname.get(i)%></div>
		</td>
<%
	}
	for(int j=1;j<13;j++){
		if(j == Integer.parseInt((String)mm.get(i)) && kempno.equals((String)empno.get(i)))	{
			sblk = sblk + Float.parseFloat((String)ops.get(i));
%>	
		  <td> 
			<div align="center"><%=(String)ops.get(i)%></div>
		  </td>
<%
			if (i<empno.size() - 1) i++;
		}
		else{
%>
		  <td> 
			<div align="center">&nbsp;</div>
		  </td>

<%
		}
		if(j == 12){
			BigDecimal bd = new BigDecimal(sblk);
%>
		  <td> 
			<div align="center"><%=bd.setScale(scale,BigDecimal.ROUND_HALF_UP).toString()%></div>
		  </td>

<%		
		}
	}
	if(t){
%>
    </tr>
<%
	}
}
%>
  </table>
  <table width="85%"  border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="txttitle">Remark : <br>
	  (1)	The summary is flightcrew yearly block hours.<br>
	  (2)	The Block hours over 2 months period will be split to respective month hours base on TPE Local time.</td>
    </tr>
  </table>
</center>
</body>
</html>
<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*,java.math.BigDecimal,javax.sql.DataSource,javax.naming.*"%>
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
<title>Crew Blk Time Edit</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>
<body>
<center>
<%
String year = request.getParameter("year");
String month = request.getParameter("month");
String inempno = request.getParameter("empno").trim();
if("".equals(inempno)) inempno = "N";
String f = request.getParameter("f");
if("s".equals(f)){
%>
	<script language="JavaScript" type="text/JavaScript">
	alert("Update Success !");
	</script>
<%
}

ArrayList empno = new ArrayList();
ArrayList ops = new ArrayList();
ArrayList cname = new ArrayList();
ArrayList hr = new ArrayList();

int xCount = 0;
String bcolor = null;

Connection myConn = null;
Statement stmt = null;
ResultSet myResultSet = null;
//DataSource
Context initContext = null;
DataSource ds = null;
//DataSource

String mysql = null;

if("N".equals(inempno)) {
	mysql = "select staff_num, b.name, ops, round(ops/60, 3) hr " +
	"from dftcrec a, dftcrew b " +
	"where to_char(a.staff_num)=b.empno and yy = "+year+" and mm = "+
	month+" and fleet_cd = 'OPS' and ops > 5400 " +
	"order by ops desc";
}
else{
	mysql = "select staff_num, b.name, ops, round(ops/60, 3) hr " +
	"from dftcrec a, dftcrew b " +
	"where to_char(a.staff_num)=b.empno and yy = "+year+" and mm = "+
	month+" and fleet_cd = 'OPS' and staff_num = "+inempno;
}

try {
	initContext = new InitialContext();
	//connect to ORP3 by Datasource
	ds = (javax.sql.DataSource)initContext.lookup("CAL.DFDS01");
	myConn = ds.getConnection();
stmt = myConn.createStatement();
myResultSet = stmt.executeQuery(mysql);

if (myResultSet != null)
{
	while (myResultSet.next())
	{
    	empno.add(myResultSet.getString("staff_num"));
		cname.add(myResultSet.getString("name"));
		ops.add(myResultSet.getString("ops"));
		hr.add(myResultSet.getString("hr"));
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
<form  method="post" name="form1" action="updcrewpos.jsp">
<div class="txtblue"><font face="Comic Sans MS" size="3"><%=year%>/<%=month%> OPS BLK Time Edit</font></div><br>
  <table width="60%" border="1" cellpadding="0" cellspacing="0">
    <tr class="tablehead"> 
      <td> 
        <div align="center"><b>EmpNo</b></div>
      </td>
      <td> 
        <div align="center"><b>Name</b></div>
      </td>
      <td> 
        <div align="center"><b>OPS Min</b></div>
      </td>
      <td> 
        <div align="center"><b>OPS HR</b></div>
      </td>
    </tr>
<%
for(int i=0;i<empno.size();i++){	
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
			<div align="center">
			<input name="empno" type="text" size="10" maxlength="10" value="<%=(String)empno.get(i)%>" readonly>
			</div>
		</td>
		<td> 
			<div align="center"><%=(String)cname.get(i)%></div>
		</td>
		<td> 
			<div align="center">
			<input name="ops" type="text" size="10" maxlength="10" value="<%=(String)ops.get(i)%>">
			</div>
		</td>
		<td> 
			<div align="center"><%=(String)hr.get(i)%></div>
		</td>
<%
}
%>
    </tr>
  </table><br>
  <input name="Submit" type="Submit" class="btm" value="Modify">
  <input name="year" type="hidden" value="<%=year%>">
  <input name="month" type="hidden" value="<%=month%>">
  <input name="inempno" type="hidden" value="<%=inempno%>">
 </form>
</center>
</body>
</html>
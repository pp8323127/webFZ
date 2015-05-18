<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,java.util.*,javax.sql.DataSource,javax.naming.*,lic.*" %>
<jsp:useBean id="unicodeStringParser" class="fz.UnicodeStringParser" />
<%
String s_date = request.getParameter("s_date");//2006-05-08
String e_date = request.getParameter("e_date");//2006-05-08

ArrayList empno = new ArrayList();
ArrayList cname = new ArrayList();
ArrayList checkAll = new ArrayList();
String rstring = null;
int xCount = 0;

Connection conn = null;
Statement stmt = null;
ResultSet myResultSet = null;
//DataSource
Context initContext = null;
DataSource ds = null;
//DataSource

checkLic cl = new checkLic();

try{
	initContext = new InitialContext();
	//connect to AOCIPROD by Datasource
	ds = (javax.sql.DataSource)initContext.lookup("CAL.FZDS03");
	conn = ds.getConnection();
	stmt = conn.createStatement();

	String sql = "select r.staff_num, c.preferred_name " +
			"from roster_v r, duty_prd_seg_v dps, crew_v c " +
			"where r.staff_num = c.staff_num " +
			"and r.series_num = dps.series_num " + 
			"and dps.fd_ind='Y' " +
			"and r.delete_ind='N' " +
			"and dps.duty_cd='FLY' " + 
			"and dps.act_str_dt_tm_gmt between to_date('"+s_date+"0000','yyyy-mm-ddHH24MI') " + 
			"and to_date('"+e_date+"2359','yyyy-mm-ddHH24MI') " + 
			//"and c.staff_num = '310085' " +
			"group by r.staff_num, c.preferred_name";
			
	myResultSet = stmt.executeQuery(sql); 
	if(myResultSet != null){
		while (myResultSet.next()){
			empno.add(myResultSet.getString(1));
			cname.add(new String(unicodeStringParser.removeExtraEscape(myResultSet.getString(2)).getBytes(), "Big5"));
			//¬dÅçlicence, passport, visa, medical
			checkAll.add(cl.checkAll(myResultSet.getString(1), conn));
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
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>

<html>
<head>
<title>Crew Licence Check</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../../menu.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style1 {
	color: #FF0000;
	font-weight: bold;
	font-size: 12px;
}
-->
</style>
</head>

<body>
 <p align="center" class="txttitle"><%=s_date%> to <%=e_date%> Licence Check</p>
  <table width="70%"  border="1" align="center" cellpadding="0" cellspacing="1" class="fortable">
    <tr>
      <td colspan="3" class="tablehead3"><div align="center">Crew Licence Check</div></td>
    </tr>
 <tr class="tablehead2">
      <td>EmpNo</td>
	  <td>Name</td>
	  <td>Check</td>
 </tr>

<div align="center">
<%
for(int i=0; i<empno.size(); i++)
{
%>
    <%
	rstring = (String)checkAll.get(i);
   if(rstring.indexOf("Y") >= 0){
   %>
   <tr>
   <td class="txtblue"><div align="center"><a href="crewlic.jsp?empno=<%=empno.get(i)%>" target="_blank"><%=empno.get(i)%></a></div></td>
   <td class="txtblue"><div align="left"><%=cname.get(i)%></div></td>
   <td class="txtblue"><div align="center"><%=checkAll.get(i)%></div></td>
   </tr>	  
    <%
	xCount++;
	}
}
%>  
    </div>
	  <td colspan="3" class="txtblue">Record count : <%=xCount%></td>
</table>
</body>
</html>
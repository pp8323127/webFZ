<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*,java.lang.*,java.math.BigDecimal,javax.sql.DataSource,javax.naming.*"%>
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

ArrayList empno = new ArrayList();
ArrayList cname = new ArrayList();
ArrayList stdl = new ArrayList();
ArrayList stal = new ArrayList();
ArrayList etdu = new ArrayList();
ArrayList etau = new ArrayList();
ArrayList fltno = new ArrayList();
ArrayList dpt = new ArrayList();
ArrayList arv = new ArrayList();
ArrayList blk = new ArrayList();

float tblk = 0;

String bcolor = null;

Connection myConn = null;
Statement stmt = null;
ResultSet myResultSet = null;
//DataSource
Context initContext = null;
DataSource ds = null;
//DataSource

String mysql = null;
int xCount = 0;

if("N".equals(inempno)) {
	out.println("<span class='txtblue'>Please Input EmpNo !!</span>");
}
else{
	mysql = "select c.empno empno, a.name cname, to_char(b.da13_stdl,'yyyy/mm/dd HH24MI') stdl, to_char(b.da13_stal,'yyyy/mm/dd HH24MI') stal, " +
	"to_char(b.da13_etdu,'yyyy/mm/dd HH24MI') etdu, to_char(b.da13_etau,'yyyy/mm/dd HH24MI') etau, "+
	"f.fltno fltno, f.dpt dpt, f.arv arv, " +
	"round((b.da13_etau - b.da13_etdu) * 24,3) blk  " +
	"from dftlogf f, dftlogc c, fzdb.v_ittda13_ci b, dftcrew a " +
	"where f.logno=c.logno and to_char(c.empno)=a.empno and f.flag='3' and c.tr_tag='3' " +
	"and f.year||f.mon||f.dd = to_char(b.da13_etdu,'yyyymmdd') and (c.jobid not in ('M','G','S','O') or c.jobid is null) " +
	"and lpad(trim(f.fltno),4,'0') = b.da13_fltno " +
	"and f.dpt = b.da13_fm_sector " +
	"and f.arv = b.da13_to_sector " + 
	"and (replace(b.da13_cond,' ','0') <> 'CF' or b.da13_cond is null) " +
	"and to_char((b.da13_stdl),'yyyy/mm') = '"+year+"/"+month+"' " +
	"and c.empno='"+inempno+"' " +
	"and ((to_date(f.year||f.mon||f.dd||f.blkout,'yyyymmddHH24MI') - b.da13_etdu) * 24 >= -2 " +
	"and (to_date(f.year||f.mon||f.dd||f.blkout,'yyyymmddHH24MI') - b.da13_etdu) * 24 <= 2) " +
	"order by b.da13_stdu";

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
			empno.add(myResultSet.getString("empno"));
			cname.add(myResultSet.getString("cname"));
			stdl.add(myResultSet.getString("stdl"));
			stal.add(myResultSet.getString("stal"));
			etdu.add(myResultSet.getString("etdu"));
			etau.add(myResultSet.getString("etau"));
			fltno.add(myResultSet.getString("fltno"));
			dpt.add(myResultSet.getString("dpt"));
			arv.add(myResultSet.getString("arv"));
			blk.add(myResultSet.getString("blk"));
			tblk = tblk + Float.parseFloat(myResultSet.getString("blk"));
			xCount++;
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
	if(xCount > 0){
	%>
	<div class="txtblue"><font face="Comic Sans MS" size="3"><%=inempno%>/<%=cname.get(0)%>&nbsp;&nbsp;&nbsp;&nbsp;<%=year%>/<%=month%> BLK Time List -- Port Local Time</font></div>
	<br>
	  <table width="80%" border="1" cellpadding="0" cellspacing="0">
		<tr class="tablehead"> 
		  <td> 
			<div align="center"><b>STDL</b></div>
		  </td>
		  <td> 
			<div align="center"><b>STAL</b></div>
		  </td>
		  <td> 
			<div align="center"><b>ETDU</b></div>
		  </td>
		  <td> 
			<div align="center"><b>ETAU</b></div>
		  </td>
		  <td> 
			<div align="center"><b>FltNo</b></div>
		  </td>
		  <td> 
			<div align="center"><b>Dpt</b></div>
		  </td>
		  <td> 
			<div align="center"><b>Arv</b></div>
		  </td>
		  <td> 
			<div align="center"><b>BLK/HR</b></div>
		  </td>
		</tr>
	<%
	for(int i=0;i<empno.size();i++){	
			if (i%2 == 0)
			{
				bcolor = "#C9C9C9";
			}
			else
			{
				bcolor = "#FFFFFF";
			}
	%>
			<tr class="tablebody" bgcolor="<%=bcolor%>"> 
			<td><%=(String)stdl.get(i)%></td>
			<td><%=(String)stal.get(i)%></td>
			<td><%=(String)etdu.get(i)%></td>
			<td><%=(String)etau.get(i)%></td>
			<td><%=(String)fltno.get(i)%></td>
			<td><%=(String)dpt.get(i)%></td>
			<td><%=(String)arv.get(i)%></td>
			<td><%=(String)blk.get(i)%></td>
	<%
	}
	%>
		</tr>
  </table>
	  <span class="txtblue">Total : <%=tblk%>  </span>
    <%
	}
	else{
		out.println("<span class='txtblue'>No Data Found !!</span>");
	}
}
%>	
</center>
</body>
</html>
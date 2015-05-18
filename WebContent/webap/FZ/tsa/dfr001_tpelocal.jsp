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
String fleet = request.getParameter("fleet");
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

if(!"".equals(fleet)) whereString = " and a.ac_type='"+fleet+"' ";
if(!"".equals(rank)) whereString = whereString + " and a.job_type='"+rank+"' ";

String mysql = "select to_char((b.da13_stdu+(8/24)),'mm') mm, c.empno empno, a.c_name name, a.ac_type fleet, a.job_type occu, " +
"sum(round((b.da13_etau - b.da13_etdu) * 24, 3)) total " +
"from dftlogf f, dftlogc c, fzdb.v_ittda13_ci b, fzdb.fztckpl a " +  
"where f.logno=c.logno and to_char(c.empno)=a.empno and f.flag='3' and c.tr_tag='3' and c.duty not in ('FA','FS','PR') " +  
"and f.year||f.mon||f.dd = to_char(b.da13_etdu,'yyyymmdd') and (c.jobid not in ('M','G','S','O') or c.jobid is null) " +  
"and lpad(trim(f.fltno),4,'0') = b.da13_fltno " +  
"and f.dpt = b.da13_fm_sector " +  
"and f.arv = b.da13_to_sector " +   
"and (replace(b.da13_cond,' ','0') <> 'CF' or b.da13_cond is null) " +  
"and to_char((b.da13_stdu+(8/24)),'yyyy') = '"+year+"' " + whereString +
"and substr(c.empno,1,1) <> '8' " +
"and ((to_date(f.year||f.mon||f.dd||f.blkout,'yyyymmddHH24MI') - b.da13_etdu) * 24 >= -2 " +  
"and (to_date(f.year||f.mon||f.dd||f.blkout,'yyyymmddHH24MI') - b.da13_etdu) * 24 <= 2) " +  
"group by a.ac_type, a.job_type, c.empno, to_char((b.da13_stdu+(8/24)),'mm'), a.c_name";
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
<div class="txtblue"><font face="Comic Sans MS" size="3"><%= year %> Flight Crew BLK Time Report(Log - TPE Local Time / 員額表)</font></div>
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
while (myResultSet.next())
{
   String mm = myResultSet.getString("mm");
   //cs66 2006/2/3改，原為 String fleet = myResultSet.getString("fleet");
   String fleet2 = myResultSet.getString("fleet");
   String occu = myResultSet.getString("occu");
   String empno = myResultSet.getString("empno");
   String name = myResultSet.getString("name");
   String total = myResultSet.getString("total");
   //out.println(mm+","+fleet+","+occu+","+empno+","+name+","+total+"<br>");
   
   if (oldempno.equals(empno))
   {
   		i = Integer.parseInt(mm) - 1;
		keeptotal[i] = Float.parseFloat(total);
   }
   else
   {
   		if (oldempno != "")
		{
			for (int n = 0; n < keeptotal.length; n++){
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
        <div align="center"><%= keeptotal[0] %></div>
      </td>
      <td> 
        <div align="center"><%= keeptotal[1] %></div>
      </td>
      <td> 
        <div align="center"><%= keeptotal[2] %></div>
      </td>
      <td> 
        <div align="center"><%= keeptotal[3] %></div>
      </td>
      <td> 
        <div align="center"><%= keeptotal[4] %></div>
      </td>
      <td> 
        <div align="center"><%= keeptotal[5] %></div>
      </td>
      <td> 
        <div align="center"><%= keeptotal[6] %></div>
      </td>
      <td> 
        <div align="center"><%= keeptotal[7] %></div>
      </td>
      <td> 
        <div align="center"><%= keeptotal[8] %></div>
      </td>
      <td> 
        <div align="center"><%= keeptotal[9] %></div>
      </td>
      <td> 
        <div align="center"><%= keeptotal[10] %></div>
      </td>
      <td> 
        <div align="center"><%= keeptotal[11] %></div>
      </td>
	  <td> 
        <div align="center"><%= timesum %></div>
      </td>
    </tr>
    <!--</form>-->
    <% 
		}
		
		oldempno = empno;
		//cs66 2006/2/3 改, 原為oldfleet = fleet;
		oldfleet = fleet2;
		oldoccu = occu;
		oldname = name;
		timesum = 0;
		for (int n = 0; n < keeptotal.length; n++)
		{
			keeptotal[n] = 0;
		}
		i = Integer.parseInt(mm) - 1;
		keeptotal[i] = Float.parseFloat(total);
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
        <div align="center"><%= keeptotal[0] %></div>
      </td>
      <td> 
        <div align="center"><%= keeptotal[1] %></div>
      </td>
      <td> 
        <div align="center"><%= keeptotal[2] %></div>
      </td>
      <td> 
        <div align="center"><%= keeptotal[3] %></div>
      </td>
      <td> 
        <div align="center"><%= keeptotal[4] %></div>
      </td>
      <td> 
        <div align="center"><%= keeptotal[5] %></div>
      </td>
      <td> 
        <div align="center"><%= keeptotal[6] %></div>
      </td>
      <td> 
        <div align="center"><%= keeptotal[7] %></div>
      </td>
      <td> 
        <div align="center"><%= keeptotal[8] %></div>
      </td>
      <td> 
        <div align="center"><%= keeptotal[9] %></div>
      </td>
      <td> 
        <div align="center"><%= keeptotal[10] %></div>
      </td>
      <td> 
        <div align="center"><%= keeptotal[11] %></div>
      </td>
	  <td> 
        <div align="center"><%= timesum %></div>
      </td>
    </tr>
<%
}
%>
  </table>
</center>
</body>
</html>
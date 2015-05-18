<%@ page contentType="text/html; charset=big5" 
        language="java" 
		import="fz.*,java.sql.*,java.util.*,java.text.*,java.math.BigDecimal"  
		errorPage="err.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Crew Hours</title>
<link href="../menu.css" rel="stylesheet" type="text/css">

<style type="text/css">
<!--
.style1 {
	color: #0000FF;
	font-weight: bold;
}
.style2 {color: #FF0000}
-->
</style>
</head>
<%
String user_cname = (String) session.getAttribute("cs55.cname") ;

String tmonth = request.getParameter("sel_year")+"/"+request.getParameter("sel_mon");
String empno = request.getParameter("empno");
float tblkhr = 0;

String name = null;
String ename = null;
String occu = null;
String fleet = null;
String sysdate = null;
String update_dt = null;
int theday = 0;

ArrayList fdate = new ArrayList();
ArrayList actdate = new ArrayList();
ArrayList fltno = new ArrayList();
ArrayList dpt = new ArrayList();
ArrayList arv = new ArrayList();
ArrayList blkout = new ArrayList();
ArrayList blkin = new ArrayList();
ArrayList blkhr = new ArrayList();
ArrayList atau = new ArrayList();

String sql = null;
String bcolor = null;
int xCount = 0;

Driver dbDriver = null;
Connection conn = null;
Statement stmt = null;
ResultSet myResultSet = null;
//
try{
//抓取目前schedule table
ctlTable ct = new ctlTable();
ct.doSet();

dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
stmt = conn.createStatement();

//get the crew basic information
sql = "select name, ename, occu, fleet, sysdate from fztcrew where empno='"+empno+"'"; 
myResultSet = stmt.executeQuery(sql);
if(myResultSet.next())
{
	name = myResultSet.getString("name");
	ename = myResultSet.getString("ename");
	occu = myResultSet.getString("occu");
	fleet = myResultSet.getString("fleet");
	sysdate = myResultSet.getString("sysdate");
}
myResultSet = stmt.executeQuery("select update_dt, to_char(sysdate, 'dd') theday from fztupdt");
if(myResultSet.next())
{
	update_dt = myResultSet.getString("update_dt");
	theday = myResultSet.getInt("theday");
}
if(theday < 11){
	sql = "select a.fdate fd, a.dutycode dc, a.dpt dpt, a.arv arv, to_char(b.da13_etdl,'yyyy/mm/dd') actdate, " +
	"b.da13_atau atau, to_char(b.da13_etdu,'HH24:MI') blkout, to_char(b.da13_etau,'HH24:MI') blkin, "+
	"round(((b.da13_etau - b.da13_etdu) * 24),3) blkhr " +
	"from " + ct.getTable() + " a, fzdb.v_ittda13_ci b " +
	"where a.fdate = to_char(b.da13_stdl,'yyyy/mm/dd') " +
	"and (case when substr(a.dutycode,1,1)='9' then lpad(substr(a.dutycode,2),4,'0') " + 
	"else lpad(trim(a.dutycode),4,'0') end) = b.da13_fltno " +
	"and (case " +
	"when a.dpt = 'TYO' then 'NRT' " +
	"when a.dpt = 'NYC' then 'JFK' " +
	"else a.dpt " +
	"end) = b.da13_fm_sector " +
	"and (case " +
	"when a.arv = 'TYO' then 'NRT' " +
	"when a.arv = 'NYC' then 'JFK' " +
	"else a.arv " +
	"end) = b.da13_to_sector " +
	"and (replace(b.da13_cond,' ','0') not in ('CF','OF','RR') or b.da13_cond is null) " +
	"and substr(a.fdate,1,7) = '"+tmonth+"' " +
	"and length(a.dutycode)>= 3  " +
	"and a.dutycode<>'REST' and a.dh<>'Y' and a.occu<>'FA' and a.empno='"+empno+"' " +
	"and ((to_date(a.fdate||a.btime,'yyyy/mm/ddHH24MI') - b.da13_stdl) * 24 >= -2 " +
	"and (to_date(a.fdate||a.btime,'yyyy/mm/ddHH24MI') - b.da13_stdl) * 24 <= 2) " +
	"order by fd, b.da13_etdu";
}
else{
	sql = "select a.fdate fd, a.dutycode dc, a.dpt dpt, a.arv arv, to_char(b.da13_etdl,'yyyy/mm/dd') actdate, " +
	"b.da13_atau atau, to_char(b.da13_etdu,'HH24:MI') blkout, to_char(b.da13_etau,'HH24:MI') blkin, "+
	"round(((b.da13_etau - b.da13_etdu) * 24),3) blkhr " +
	"from (select empno, fdate, dutycode, dpt, arv, btime, occu, dh " +
	"from " + ct.getTable() +
	" where substr(fdate,1,7) = '"+tmonth+"' and fdate > '"+tmonth+"/10' " +
	"and length(dutycode)>= 3 and dutycode<>'REST' and dh<>'Y' and occu<>'FA' and empno='"+empno+"' union all " +
	"select empno, fdate, dutycode, dpt, arv, btime, occu, dh " +
	"from fztsche2 " +
	"where substr(fdate,1,7) = '"+tmonth+"' " + 
	"and length(dutycode)>= 3 and dutycode<>'REST' and dh<>'Y' and occu<>'FA' and empno='"+empno+"') a, fzdb.v_ittda13_ci b " +
	"where a.fdate = to_char(b.da13_stdl,'yyyy/mm/dd') " +
	"and (case when substr(a.dutycode,1,1)='9' then lpad(substr(a.dutycode,2),4,'0') " + 
	"else lpad(trim(a.dutycode),4,'0') end) = b.da13_fltno " +
	"and (case " +
	"when a.dpt = 'TYO' then 'NRT' " +
	"when a.dpt = 'NYC' then 'JFK' " +
	"else a.dpt " +
	"end) = b.da13_fm_sector " +
	"and (case " +
	"when a.arv = 'TYO' then 'NRT' " +
	"when a.arv = 'NYC' then 'JFK' " +
	"else a.arv " +
	"end) = b.da13_to_sector " +
	"and (replace(b.da13_cond,' ','0') not in ('CF','OF','RR') or b.da13_cond is null) " +
	"and ((to_date(a.fdate||a.btime,'yyyy/mm/ddHH24MI') - b.da13_stdl) * 24 >= -2 " +
	"and (to_date(a.fdate||a.btime,'yyyy/mm/ddHH24MI') - b.da13_stdl) * 24 <= 2) " +
	"order by fd, b.da13_etdu";
}
//out.println(sql);
myResultSet = stmt.executeQuery(sql);
if(myResultSet != null)
{
	while(myResultSet.next())
	{
		fdate.add(myResultSet.getString("fd")); //fztsche fdate (local schedule date)
		actdate.add(myResultSet.getString("actdate")); //aociprod da13_schdl (local act date)
		fltno.add(myResultSet.getString("dc"));
		dpt.add(myResultSet.getString("dpt"));
		arv.add(myResultSet.getString("arv"));
		atau.add(myResultSet.getString("atau"));
		blkout.add(myResultSet.getString("blkout"));
		blkin.add(myResultSet.getString("blkin"));
		blkhr.add(myResultSet.getString("blkhr"));
		tblkhr = tblkhr + myResultSet.getFloat("blkhr");
		xCount++;
	}
}

%>
<body>
<div align="center">
  <p>
    <%
if(xCount == 0){
%>
      <span class="txttitletop"><br>
      No Crew Hours</span><br>
    <%
}
else{
BigDecimal bd = new BigDecimal(tblkhr);
%>
</p>
  <table width="90%"  border="0" cellpadding="0" cellspacing="0">
    <tr class="txttitle">
      <td><span class="txtxred">Port Local</span> <%=tmonth%>&nbsp;&nbsp;<%=empno%> <%=name%>&nbsp;/&nbsp;<%=ename%>&nbsp;&nbsp;&nbsp;&nbsp;<%=occu%>&nbsp;/&nbsp;<%=fleet%></td>
      <td><div align="right">Total BlkHr : <span class="style1"><%=bd.setScale(3,BigDecimal.ROUND_HALF_UP).toString()%></span></div></td>
	  <td><div align="right"><a href="javascript:window.print()"><img src="../images/print.gif" width="17" height="15" border="0" alt="列印"></a> 
        </div></td>
    </tr>
  </table>
</div>
<table width="90%" border="1" align="center" cellpadding="1" cellspacing="1">
  <tr class="tablehead3">
    <td class="tablehead3">SCHDate</td>
	<td class="tablehead3">ACTDate</td>
    <td class="tablehead3">FLT</td>
	<td class="tablehead3">DPT</td>
	<td class="tablehead3">ARV</td>
	<td class="tablehead3">BlkOut</td>
	<td class="tablehead3">BlkIn</td>
	<td class="tablehead3">BlkHr</td>
  </tr>
<%
for(int i = 0; i<fdate.size(); i++)
{
	if (((String)atau.get(i)) == null)
	{
		bcolor = "#FFCCFF";
	}
	else
	{
		if (i%2 == 0)
		{
			bcolor = "#C9C9C9";
		}
		else
		{
			bcolor = "#FFFFFF";
		}
	}

%>
  <tr bgcolor = "<%=bcolor%>"> 
    <td class="tablebody"><%=(String)fdate.get(i)%></td>
	<td class="tablebody"><%=(String)actdate.get(i)%></td>
    <td class="tablebody"><%=(String)fltno.get(i)%></td>
	<td class="tablebody"><%=(String)dpt.get(i)%></td>
	<td class="tablebody"><%=(String)arv.get(i)%></td>
	<td class="tablebody"><%=(String)blkout.get(i)%></td>
	<td class="tablebody"><%=(String)blkin.get(i)%></td>
	<td class="tablebody"><%=(String)blkhr.get(i)%></td>
  </tr>
<%
}
%>
</table>
<table width="90%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><p><span class="txttitle"><span class="style2">Schedule Last Update Time : <%=update_dt%><br>
	The following shedule is for reference only. For official up-to-date schedule information, please contact Scheduling Department.<br>
下列班表僅供參考，請向組員派遣部門確認個人正式班表任務。</span>
	<br>Remark:<br>
        1.Data in red background color are schedule information.<br>
		2. Crew schedule from SBS system, Datetime from JC/AirOps system<br>
		Print Date : <%=sysdate%><br>
		Made by : <%=user_cname%></span><br>
      </p></td>
  </tr>
</table>
</body>
</html>
<%
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
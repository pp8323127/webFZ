<%@ page contentType="text/html; charset=big5"
		language="java"
		import="java.sql.*,fz.*,java.util.*,java.text.*,java.math.BigDecimal"
		errorPage="err.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Crew Hours</title>
<link href="../menu.css" rel="stylesheet" type="text/css">
<script language="javascript">
/*
function switchColor(){	
	if(test.style.color=="navy"){
		test.style.color="red";
	}
	else if(test.style.color=="red"){
		test.style.color="navy";
	}
	setTimeout("switchColor()",750);
}
*/
</script>
<style type="text/css">
<!--
.style2 {color: #FF0000}
-->
</style>
</head>
<%
String user_cname = (String) session.getAttribute("cs55.cname") ;

String y = request.getParameter("sel_year");
String m = request.getParameter("sel_mon");
String fleetin = request.getParameter("fleet").trim();
String occuin = request.getParameter("occu").trim();
String s_mark = request.getParameter("s_mark");
String s_num = request.getParameter("s_num");
String checkbk = request.getParameter("checkbk");
/*out.println(fleetin+"<br>");
out.println(s_mark+"<br>");
out.println(s_num+"<br>");
out.println(checkbk+"<br>");*/
String sql = null;
String bcolor = null;
String tmonth = y+"/"+m;
String fleet = null;
String occu = null;
String cname = null;

ArrayList empno = new ArrayList();
ArrayList blkhr = new ArrayList();
int xCount = 0;
int rCount = 0;
float blkcount = 0;
String sysdate = null;
int theday = 0;

Driver dbDriver = null;
Connection conn = null;
Statement stmt = null;
ResultSet myResultSet = null;

try{
//抓取目前schedule table
ctlTable ct = new ctlTable();
ct.doSet();

dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
stmt = conn.createStatement();

myResultSet = stmt.executeQuery("select to_char(sysdate, 'dd') theday from dual");
if(myResultSet.next())
{
	theday = myResultSet.getInt("theday");
}
if(theday < 11){
	sql= "select a.empno empno, round(sum((b.da13_etau - b.da13_etdu) * 24),3) blkhr " +
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
	"and substr(a.fdate,1,7) = '"+tmonth+"' "+
	"and length(a.dutycode) >= 3  " +
	"and a.dutycode <> 'REST' and a.dh <> 'Y' and a.occu <> 'FA' " +
	"and ((to_date(a.fdate||a.btime,'yyyy/mm/ddHH24MI') - b.da13_stdl) * 24 >= -2 " +
	"and (to_date(a.fdate||a.btime,'yyyy/mm/ddHH24MI') - b.da13_stdl) * 24 <= 2) " +
	"group by a.empno " ;
}
else{
	sql= "select a.empno empno, round(sum((b.da13_etau - b.da13_etdu) * 24),3) blkhr " +
	"from (select empno, fdate, dutycode, dpt, arv, btime, occu, dh " +
	"from " + ct.getTable() +
	" where substr(fdate,1,7) = '"+tmonth+"' and fdate > '"+tmonth+"/10' " +
	"and length(dutycode)>= 3 and dutycode<>'REST' and dh<>'Y' and occu<>'FA' union all " +
	"select empno, fdate, dutycode, dpt, arv, btime, occu, dh " +
	"from fztsche2 " +
	"where substr(fdate,1,7) = '"+tmonth+"' " + 
	"and length(dutycode)>= 3 and dutycode<>'REST' and dh<>'Y' and occu<>'FA') a, fzdb.v_ittda13_ci b " +
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
	"group by a.empno " ;
}

if(checkbk != null){
	sql = sql + "having sum((b.da13_etau - b.da13_etdu) * 24)" + s_mark + s_num;
}
sql = sql + " order by blkhr desc";
//out.print(sql);
myResultSet = stmt.executeQuery(sql);
if(myResultSet != null)
{
	while(myResultSet.next())
	{
		empno.add(myResultSet.getString("empno"));
		blkhr.add(myResultSet.getString("blkhr"));
		xCount++;
	}
}

%>
<body >
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
%>
</p>
  <table width="90%"  border="0" cellpadding="0" cellspacing="0">
    <tr class="txttitle">
      <td><span class="txtxred">班表網 Port Local Time</span> Made by : <%=user_cname%>&nbsp;&nbsp;Date : <%=tmonth%></td>
	  <%
	  if(checkbk != null){
	  %>
	  <td><div align="right"><%=fleetin.toUpperCase()%>&nbsp;&nbsp;/&nbsp;&nbsp;<%=occuin.toUpperCase()%>&nbsp;&nbsp;BlkHr<%=s_mark%><%=s_num%></div></td>
	  <%
	  }
	  else{
	  %>
	  <td><div align="right"><%=fleetin.toUpperCase()%>&nbsp;&nbsp;/&nbsp;&nbsp;<%=occuin.toUpperCase()%>&nbsp;&nbsp;</div></td>
      <%
	  }
	  %>
	  <td><div align="right"><a href="javascript:window.print()"><img src="../images/print.gif" width="17" height="15" border="0" alt="列印"></a> 
        </div></td>
	</tr>
  </table>
</div>
<table width="90%" border="1" align="center" cellpadding="1" cellspacing="1">
  <tr class="tablehead3">
    <td class="tablehead3">Empno</td>
	<td class="tablehead3">Name</td>
	<td class="tablehead3">Fleet</td>
	<td class="tablehead3">Occu</td>
    <td class="tablehead3">BlkHr</td>
  </tr>
<%
for(int i = 0; i<empno.size(); i++)
{
	myResultSet = stmt.executeQuery("select name, nvl(fleet,' ') fleet, nvl(occu,' ') occu, sysdate from fztcrew where empno='"+(String)empno.get(i)+"'");
	if(myResultSet.next())
	{
		cname = myResultSet.getString("name");
		fleet = myResultSet.getString("fleet");
		occu = myResultSet.getString("occu");
		sysdate = myResultSet.getString("sysdate");
	}
	if((fleetin.toUpperCase().equals(fleet) || fleetin.equals("")) && (occuin.toUpperCase().equals(occu) || occuin.equals("")))
	{
		rCount++;
		blkcount = blkcount + Float.parseFloat((String)blkhr.get(i));
		if (rCount%2 == 0)
		{
			bcolor = "#C9C9C9";
		}
		else
		{
			bcolor = "#FFFFFF";
		}
	%>
	  <tr bgcolor = "<%=bcolor%>"> 
		<td class="tablebody"><a href="crewhrdetail.jsp?sel_year=<%=y%>&sel_mon=<%=m%>&empno=<%=(String)empno.get(i)%>" target="_blank"><%=(String)empno.get(i)%></a></td>
		<td class="tablebody"><%=cname%></td>
		<td class="tablebody"><%=fleet%></td>
		<td class="tablebody"><%=occu%></td>
		<%
		if(Float.parseFloat((String)blkhr.get(i)) > 95.0)
		{
		%>
			<td class="tablebody"><font id="test" style="color:red"><%=(String)blkhr.get(i)%></font></td>
		<%
		}
		else
		{
		%>
			<td class="tablebody"><font style="color:navy"><%=(String)blkhr.get(i)%></font></td>
		<%
		}
	}
}
%>
	</tr>
</table>
<%
if(rCount > 0){
	BigDecimal bd = new BigDecimal(blkcount/rCount);
	%>
	<table width="90%"  border="0" align="center" cellpadding="0" cellspacing="0">
		<tr class="txttitle">
		  <td>Records : <%=rCount%></td>
		  <td><div align="right">Avg : <%=bd.setScale(3,BigDecimal.ROUND_HALF_UP).toString()%></div></td>
		</tr>
	</table>
	<table width="90%"  border="0" align="center" cellpadding="0" cellspacing="0">
	  <tr>
		<td><p><span class="txttitle">Remark:<br>
			1.Data in red background color are schedule information.<br>
			2. Crew schedule from SBS system, Datetime from JC/AirOps system<br>
		    3.The Block hours over 2 months period will be split to respective month hours base on <span class="style2">Port</span> Local time.<br>
	        Print Date : <%=sysdate%></span><br>
	      </td>
	  </tr>
	</table>
<%
}
else{
	out.println("<span class='txttitletop'>No Data Found !!</span>");
}
%>
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
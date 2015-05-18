<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,fz.*,java.util.*"%>
<%@ page import="ci.db.*,javax.sql.DataSource,javax.naming.InitialContext" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Crew Hours</title>
<link href="../menu.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style2 {color: #FF0000}
.style3 {color: #000066}
-->
</style>
</head>
<%
String yy = request.getParameter("yy");
String mm = request.getParameter("mm");
String dd = request.getParameter("dd");

String sql = null;
String bcolor = null;
String inday = yy+mm+dd;

ArrayList empno = new ArrayList();
ArrayList blkhr = new ArrayList();
ArrayList cname = new ArrayList();
ArrayList fleet = new ArrayList();

int xCount = 0;
int rCount = 0;
float blkcount = 0;
String sysdate = null;
int theday = 0;
String lday = null;

Driver dbDriver = null;
Connection conn = null;
Statement stmt = null;
ResultSet myResultSet = null;

//v03 data source
ConnDB cn = new ConnDB();
DataSource ds = null;             
InitialContext initialcontext ; 

try{
		//抓取目前schedule table
		ctlTable ct = new ctlTable();
		ct.doSet();
		
		//dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
		//conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);

//cn.setORP3FZUser();
//dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//java.lang.Class.forName(cn.getDriver());
//conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());
//conn = dbDriver.connect(cn.getConnURL(), null);
	//DataSource
	cn.setORP3FZUserCP_new();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn  = dbDriver.connect(cn.getConnURL(), null);


		stmt = conn.createStatement();
		
		sql = "select a.empno empno, c.name cname, c.fleet fleet, round(sum(b.da13_etau - b.da13_etdu) * 24,3) blkhr " + 
		"from "+ct.getTable()+" a, fzdb.v_ittda13_ci b, fztcrew c " + 
		"where a.empno=c.empno " + 
		"and a.fdate = to_char(b.da13_stdl,'yyyy/mm/dd')  " + 
		"and (case when substr(a.dutycode,1,1)='9' then lpad(substr(a.dutycode,2),4,'0')  " + 
		"else lpad(trim(a.dutycode),4,'0') end) = b.da13_fltno " + 
		"and (case  " + 
		"when a.dpt = 'TYO' then 'NRT'  " + 
		"when a.dpt = 'NYC' then 'JFK' " +  
		"else a.dpt " + 
		"end) = b.da13_fm_sector  " + 
		"and (case  " + 
		"when a.arv = 'TYO' then 'NRT'  " + 
		"when a.arv = 'NYC' then 'JFK' " + 
		"else a.arv  " + 
		"end) = b.da13_to_sector  " + 
		"and (replace(b.da13_cond,' ','0') not in ('CF','OF','RR') or b.da13_cond is null)  " + 
		"and to_char((b.da13_etdu + (8/24)),'yyyymmdd') between to_char(to_date('"+inday+"','yyyymmdd') - 3,'yyyymmdd') and to_char(to_date('"+inday+"','yyyymmdd') + 3,'yyyymmdd') " + 
		"and (trim(a.dutycode) in ('233','234','271','272','273','274','283','284','285','286','295','296','297','298', " + 
		"'303','304','305','306','331','332','333','334','335','336','337','338','371','372','375','376','377','378','052','054') or " + 
		"substr(b.da13_fltno,1,2) in ('57','58','67','68')) " + 
		"and a.spcode not in ('O','S','J','P') " + 
		"and a.dh <> 'Y' and a.occu <> 'FA' " + 
		"and ((to_date(a.fdate||a.btime,'yyyy/mm/ddHH24MI') - b.da13_stdl) * 24 >= -2 " + 
		"and (to_date(a.fdate||a.btime,'yyyy/mm/ddHH24MI') - b.da13_stdl) * 24 <= 2) " + 
		"group by a.empno, c.name, c.fleet " + 
		"having round(sum(b.da13_etau - b.da13_etdu) * 24,3) >= 30 " +
		"order by blkhr desc";
		//out.print(sql);
		myResultSet = stmt.executeQuery(sql);
		if(myResultSet != null)
		{
			while(myResultSet.next())
			{
				empno.add(myResultSet.getString("empno"));
				cname.add(myResultSet.getString("cname"));
				fleet.add(myResultSet.getString("fleet"));
				blkhr.add(myResultSet.getString("blkhr"));
				xCount++;
			}
		}
		
		%>
		<body >
		<div align="center">
		  <table width="70%"  border="0" cellpadding="0" cellspacing="0">
			<tr class="txttitle">
			  <td><span class="txtxred">班表網 TPE Time --  Report Date : <%=inday%> + / - 3days</span></td>
			  <td><div align="right"><a href="javascript:window.print()"><img src="../images/print.gif" width="17" height="15" border="0" alt="列印"></a> 
				</div></td>
			</tr>
		  </table>
		</div>
		<table width="70%" border="1" align="center" cellpadding="1" cellspacing="1">
		  <tr class="tablehead3">
			<td class="tablehead3">Empno</td>
			<td class="tablehead3">Name</td>
			<td class="tablehead3">Fleet</td>
			<td class="tablehead3">BlkHr</td>
		  </tr>
		<%
		for(int i = 0; i<empno.size(); i++)
		{
				rCount++;
				if (Float.parseFloat((String)blkhr.get(i)) > 32.0){
					bcolor = "#FF66FF";
				}
				else{
					if (rCount%2 == 0){
						bcolor = "#C9C9C9";
					}
					else{
						bcolor = "#FFFFFF";
					}
				}
			%>
			  <tr bgcolor = "<%=bcolor%>"> 
				<td class="tablebody"><%=(String)empno.get(i)%></td>
				<td class="tablebody"><%=(String)cname.get(i)%></td>
				<td class="tablebody"><%=(String)fleet.get(i)%></td>
				<td class="tablebody"><%=(String)blkhr.get(i)%></td>
			  </tr>
			<%
		}
		%>
		</table>
			<table width="70%"  border="0" align="center" cellpadding="0" cellspacing="0">
			  <tr>
				<td><p><span class="txttitle">Remark:<br>
&quot;0&quot;字頭保留052,054。<br>
&quot;2&quot;字頭保留233,234,271,272,273,274,283,284,285,286,295,296,297,298。<br>
&quot;3&quot;字頭保留303,304,305,306,331,332,333,334,335,336,337,338,371,372,375,376,377,378。<br>
&quot;1&quot;、&quot;5&quot;、&quot;6&quot;、&quot;7&quot;、&quot;8&quot;、&quot;9&quot;字頭全數保留。<br>
刪除550,551。<br>
				  四碼班次非 &quot;5&quot;、&quot;6&quot; 字頭者均保留。<br>
				  四碼班次為 &quot;5&quot;、&quot;6&quot; 字頭者僅保留 &quot;57XX&quot;、&quot;58XX&quot; 及 &quot;67XX&quot;、&quot;68XX&quot; 即可。<br>
				  Special code &quot;O&quot;、&quot;S&quot;、&quot;J&quot;、&quot;P&quot;及DH部份刪除。</span><br>
				  </p></td>
			  </tr>
		</table>
		</body>
		</html>
		<%
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
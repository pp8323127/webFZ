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
		//����ثeschedule table
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
			  <td><span class="txtxred">�Z��� TPE Time --  Report Date : <%=inday%> + / - 3days</span></td>
			  <td><div align="right"><a href="javascript:window.print()"><img src="../images/print.gif" width="17" height="15" border="0" alt="�C�L"></a> 
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
&quot;0&quot;�r�Y�O�d052,054�C<br>
&quot;2&quot;�r�Y�O�d233,234,271,272,273,274,283,284,285,286,295,296,297,298�C<br>
&quot;3&quot;�r�Y�O�d303,304,305,306,331,332,333,334,335,336,337,338,371,372,375,376,377,378�C<br>
&quot;1&quot;�B&quot;5&quot;�B&quot;6&quot;�B&quot;7&quot;�B&quot;8&quot;�B&quot;9&quot;�r�Y���ƫO�d�C<br>
�R��550,551�C<br>
				  �|�X�Z���D &quot;5&quot;�B&quot;6&quot; �r�Y�̧��O�d�C<br>
				  �|�X�Z���� &quot;5&quot;�B&quot;6&quot; �r�Y�̶ȫO�d &quot;57XX&quot;�B&quot;58XX&quot; �� &quot;67XX&quot;�B&quot;68XX&quot; �Y�i�C<br>
				  Special code &quot;O&quot;�B&quot;S&quot;�B&quot;J&quot;�B&quot;P&quot;��DH�����R���C</span><br>
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
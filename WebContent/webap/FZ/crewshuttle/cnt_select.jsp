<%@ page import="java.sql.*,java.io.*,ci.db.*" contentType="text/html;charset=big5" %>
<jsp:useBean id="unicodeStringParser" class="cs40javabean.UnicodeStringParser" />
<%

//String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login

/*
if ( sGetUsr == null) 
{	//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 
*/

String yyyy = request.getParameter("sel_year");
String mm	= request.getParameter("sel_mon");
String dd	= request.getParameter("sel_dd");
String path = application.getRealPath("/")+"/FZ/crewshuttle/file/";
int count_dpt = 0;
int count_arv = 0;

String bgColor = "";

//save in AL
ArrayList fltnoAL_dpt = new ArrayList();
ArrayList countAL_dpt = new ArrayList();
ArrayList timeAL_dpt = new ArrayList();
ArrayList fltnoAL_arv = new ArrayList();
ArrayList countAL_arv = new ArrayList();
ArrayList timeAL_arv = new ArrayList();
//DB connection initial
Connection conn	= null;
Statement  stmt = null;
ResultSet  rs   = null;
Driver dbDriver = null;
ConnDB cn = new ConnDB();
String sql = null;

try
{
	/*
	cn.setAOCIPROD();
	Class.forName(cn.getDriver()); 
	conn = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());
	stmt = conn.createStatement();
	*/

	//cn.setAOCIPRODCP();
	cn.setORP3FZUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	stmt = conn.createStatement();

//  *********  Dpt from TPE **************
// if the count # is incorrect, it maybe the flt doesn't in fztflin table 
	sql = "select col1, col2, count(*) as col3 from (  ";

	sql = sql + "select dps.flt_num  AS col1, To_Char(dps.act_str_dt_tm_gmt,'hh24:mi') AS col2 from fzdb.roster_v r, fzdb.duty_prd_seg_v dps where r.series_num = dps.series_num and r.delete_ind='N' and dps.duty_cd = 'FLY' and dps.act_port_a = 'TPE' and dps.str_dt_tm_gmt between to_date('"+yyyy+mm+dd+" 00:00','yyyymmdd hh24:mi') and to_date('"+yyyy+mm+dd+" 23:59','yyyymmdd hh24:mi')";

	//sql = sql + "select dps.flt_num  AS col1, Nvl(To_Char(flin.tsa_dt,'hh24:mi'),To_Char(dps.act_str_dt_tm_gmt,'hh24:mi')) AS col2 from fzdb.roster_v r,fzdb.duty_prd_seg_v dps, fztflin flin where r.series_num = dps.series_num and r.delete_ind = 'N' and dps.duty_cd = 'FLY' and dps.act_port_a = 'TPE' and to_char(dps.str_dt_tm_gmt,'yyyymmdd') = '"+yyyy+mm+dd+"' AND flin.fltd = To_Date('"+yyyy+mm+dd+" 0000','yyyymmdd hh24mi') AND SubStr(flin.sect,1,3) = 'TPE' AND dps.act_port_a||dps.act_port_b = sect AND dps.flt_num = flin.fltno ";

	sql = sql + " ) group by col1, col2 ORDER BY col2, col1 ";

	rs = stmt.executeQuery(sql);
	
	while (rs.next())
	{ 
		fltnoAL_dpt.add(rs.getString("col1"));
		timeAL_dpt.add(rs.getString("col2"));
		countAL_dpt.add(rs.getString("col3"));
		count_dpt++;
	}

//  **************************************
//  ***********  Arv to TPE **************
	sql = "select col1, col2, count(*) as col3 from (  ";

	sql = sql + "select dps.flt_num AS col1, To_Char(dps.act_end_dt_tm_gmt,'hh24:mi') AS col2 from fzdb.roster_v r, fzdb.duty_prd_seg_v dps where r.series_num = dps.series_num and r.delete_ind='N' and dps.duty_cd = 'FLY' and dps.act_port_b = 'TPE' and dps.str_dt_tm_gmt between to_date('"+yyyy+mm+dd+" 00:00','yyyymmdd hh24:mi') and to_date('"+yyyy+mm+dd+" 23:59','yyyymmdd hh24:mi') ";
	
	//sql = sql + " select dps.duty_cd as col1,  To_Char(dps.act_str_dt_tm_gmt,'hh24:mi') AS col2 from roster_v r, duty_prd_seg_v dps where r.series_num = dps.series_num and r.delete_ind='N' and dps.duty_cd in  ('744SIM','744SIM_SUPP','74FSIM','74FSIM_SUPP','AB6SIM','AB6SIM_SUPP','738SIM','738SIM_SUPP','343SIM','343SIM_SUPP','333SIM','333SIM_SUPP','S1','S2','S3','S4','S5','S6','SB','SG') and dps.act_port_a='TPE' and to_char(dps.str_dt_tm_gmt,'yyyymmdd') = '"+yyyy+mm+dd+"' union all";

	//sql = sql + " select dps.duty_cd as col1,  To_Char(dps.act_end_dt_tm_gmt,'hh24:mi') AS col2 from roster_v r, duty_prd_seg_v dps where r.series_num = dps.series_num and r.delete_ind='N' and dps.duty_cd in  ('744SIM','744SIM_SUPP','74FSIM','74FSIM_SUPP','AB6SIM','AB6SIM_SUPP','738SIM','738SIM_SUPP','343SIM','343SIM_SUPP','333SIM','333SIM_SUPP','S1','S2','S3','S4','S5','S6','SB','SG') and dps.act_port_b='TPE' and to_char(dps.str_dt_tm_gmt,'yyyymmdd') = '"+yyyy+mm+dd+"' ";

	sql = sql + " ) group by col1, col2 ORDER BY col2, col1 ";

	rs = stmt.executeQuery(sql);
	
	while (rs.next())
	{ 
		fltnoAL_arv.add(rs.getString("col1"));
		timeAL_arv.add(rs.getString("col2"));
		countAL_arv.add(rs.getString("col3"));
		count_arv++;
	}
}
catch (Exception e)
{
	  out.print("<BR>"+e.toString());
}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}

%>

<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="crewcar.css">
<style type="text/css">
<!--
.style1 {color: #0000FF}
.style2 {color: #FFFFFF}
-->
</style>
</head>
<body>
<div align="center">
<%
if (count_dpt > 0 || count_arv > 0)
{
	//Creat file
	FileWriter fw = new FileWriter(path+yyyy+mm+dd+"_tpecrew.TXT",false);
%>
<p class="style1"><b>離到TPE航班組員人數</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
<img src="images/ed4.gif" width="20" height="20" border="0">&nbsp;&nbsp;<a href="file/<%=yyyy%><%=mm%><%=dd%>_tpecrew.TXT">Download File</a></p>
  <table width="50%"  border="0">
  <tr bgcolor="#66CCCC">
    <th scope="col"><span class="style1">日期</span></th>
	<th scope="col"><span class="style1">離到時間</span></th>
    <th scope="col"><span class="style1">航班</span></th>
    <th scope="col"><span class="style1">組員人數</span></th>
  </tr>
<%
	//write file title
	fw.write("日期\t\t"+"離到時間\t\t"+"航班\t\t"+"組員人數\r\n");
	fw.write("************************* Departure ***************************\r\n");
%>
  <tr align="center"><td colspan="4" align="center" bgcolor="#0000FF"><span class="style2">Departure</span></td>
  </tr>
<%
	for(int i=0; i<fltnoAL_dpt.size(); i++)
	{
		if (i%2 == 0)
		{
			bgColor = "#FFCCFF";
		}
		else
		{
			bgColor = "#99FFFF";
		}
%>
  <tr bgcolor="<%=bgColor%>" align="center">
    <td><%=yyyy%>/<%=mm%>/<%=dd%></td>
    <td><%=timeAL_dpt.get(i)%></td>
<%
	// real fltno with CI-, otherwise just duty_cd
	if ( "0123456789".indexOf(fltnoAL_dpt.get(i).toString().trim().substring(0,1)) >=0 && "0123456789".indexOf(fltnoAL_dpt.get(i).toString().trim().substring(fltnoAL_dpt.get(i).toString().length()-1,fltnoAL_dpt.get(i).toString().length())) >=0 )
	{
%>
    <td>CI-<%= fltnoAL_dpt.get(i)%></td>
<%
	}
	else
	{
%>
	<td><%= fltnoAL_dpt.get(i)%></td>
<%
	}
%>
    <td><%= countAL_dpt.get(i)%></td>
  </tr>
<%
	//write into file

	if ( "0123456789".indexOf(fltnoAL_dpt.get(i).toString().trim().substring(0,1)) >=0 && "0123456789".indexOf(fltnoAL_dpt.get(i).toString().trim().substring(fltnoAL_dpt.get(i).toString().length()-1,fltnoAL_dpt.get(i).toString().length())) >=0 )
	{
		fw.write(yyyy+"/"+mm+"/"+dd+"\t"+timeAL_dpt.get(i)+"\t\tCI-"+fltnoAL_dpt.get(i)+"\t\t"+countAL_dpt.get(i)+"\r\n");
	}
	else
	{
		fw.write(yyyy+"/"+mm+"/"+dd+"\t"+timeAL_dpt.get(i)+"\t\t"+fltnoAL_dpt.get(i)+"\t\t"+countAL_dpt.get(i)+"\r\n");
	}

	}// end of for(int i=0; i<fltnoAL_dpt.size(); i++)

//***********************************************************
%>
  <tr align="center"><td colspan="4" align="center" bgcolor="#0000FF"><span class="style2">Arrival</span></td></tr>
<%
	fw.write("*************************** Arrival ***************************\r\n");
	for(int i=0; i<fltnoAL_arv.size(); i++)
	{
		if (i%2 == 0)
		{
			bgColor = "#FFCCFF";
		}
		else
		{
			bgColor = "#99FFFF";
		}
%>
  <tr bgcolor="<%=bgColor%>" align="center">
    <td><%=yyyy%>/<%=mm%>/<%=dd%></td>
    <td><%=timeAL_arv.get(i)%></td>
<%
	// real fltno with CI-, otherwise just duty_cd
	if ( "0123456789".indexOf(fltnoAL_arv.get(i).toString().trim().substring(0,1)) >=0 && "0123456789".indexOf(fltnoAL_arv.get(i).toString().trim().substring(fltnoAL_arv.get(i).toString().length()-1,fltnoAL_arv.get(i).toString().length())) >=0 )
	{
%>
    <td>CI-<%= fltnoAL_arv.get(i)%></td>
<%
	}
	else
	{
%>
	<td><%= fltnoAL_arv.get(i)%></td>
<%
	}
%>
    <td><%= countAL_arv.get(i)%></td>
  </tr>
<%
	//write into file

	if ( "0123456789".indexOf(fltnoAL_arv.get(i).toString().trim().substring(0,1)) >=0 && "0123456789".indexOf(fltnoAL_arv.get(i).toString().trim().substring(fltnoAL_arv.get(i).toString().length()-1,fltnoAL_arv.get(i).toString().length())) >=0 )
	{
		fw.write(yyyy+"/"+mm+"/"+dd+"\t"+timeAL_arv.get(i)+"\t\tCI-"+fltnoAL_arv.get(i)+"\t\t"+countAL_arv.get(i)+"\r\n");
	}
	else
	{
		fw.write(yyyy+"/"+mm+"/"+dd+"\t"+timeAL_arv.get(i)+"\t\t"+fltnoAL_arv.get(i)+"\t\t"+countAL_arv.get(i)+"\r\n");
	}

	}// end of for(int i=0; i<fltnoAL_arv.size(); i++)
	fw.close();
%>
</table>
<%
}
else
{
%>
	<p class="style1"><b>No Data</b></p>
<%
}
%>
</div>
</body>
</html>








































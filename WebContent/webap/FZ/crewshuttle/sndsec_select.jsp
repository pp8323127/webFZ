<%@ page import="java.sql.*,java.io.*,ci.db.*" contentType="text/html;charset=big5" %>
<jsp:useBean id="unicodeStringParser" class="fz.UnicodeStringParser" />
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
int count = 0;
String bgColor = "";
String name ="";

//save in AL
ArrayList fltnoAL = new ArrayList();
ArrayList nameAL = new ArrayList();
ArrayList secAL = new ArrayList();
ArrayList empnoAL = new ArrayList();

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

	cn.setAOCIPRODCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	stmt = conn.createStatement();

	sql = "select r.staff_num as staff_num, c.preferred_name as name, dps.flt_num as flt_num, dps.port_a||'/'||dps.port_b as sec from roster_v r, duty_prd_seg_v dps, crew_v c where r.series_num = dps.series_num and r.staff_num = c.staff_num and r.delete_ind='N' and dps.duty_cd = 'FLY' and dps.act_port_a = 'TPE' and dps.str_dt_tm_gmt between to_date('"+yyyy+mm+dd+" 00:00','yyyymmdd hh24:mi') and to_date('"+yyyy+mm+dd+" 23:59','yyyymmdd hh24:mi') and Duty_seq_num <> 1 order by dps.flt_num, to_char(dps.str_dt_tm_gmt,'YYYYMMDD HH:MI:SS') asc";

	//out.println(sql);

	rs = stmt.executeQuery(sql);
	
	while (rs.next())
	{ 
		if (!rs.getString("staff_num").substring(0,1).toString().equals("8"))
		{
			empnoAL.add(rs.getString("staff_num"));
			name = new String(unicodeStringParser.removeExtraEscape(rs.getString("name")).getBytes(), "Big5"); 		
			nameAL.add(name);
			fltnoAL.add(rs.getString("flt_num"));
			secAL.add(rs.getString("sec"));
			count++;
		}
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
-->
</style>
</head>
<body>
<div align="center">
<%
if (count > 0)
{
	//Creat file
	FileWriter fw = new FileWriter(path+yyyy+mm+dd+"_sndsec.TXT",false);
%>
<p class="style1"><b>續飛組員名單</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
<img src="images/ed4.gif" width="20" height="20" border="0">&nbsp;&nbsp;<a href="file/<%=yyyy%><%=mm%><%=dd%>_sndsec.TXT">Download File</a></p>
  <table width="70%"  border="0">
  <tr bgcolor="#66CCCC">
    <th scope="col"><span class="style1">日期</span></th>
    <th scope="col"><span class="style1">航班</span></th>
    <th scope="col"><span class="style1">航段</span></th>
    <th scope="col"><span class="style1">員工號</span></th>
    <th scope="col"><span class="style1">姓名</span></th>
  </tr>
<%
	//write file title
	fw.write("日期\t\t航班\t航段\t員工號\t姓名\r\n");
	for(int i=0; i<fltnoAL.size(); i++)
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
    <td>CI-<%= fltnoAL.get(i)%></td>
	<td><%= secAL.get(i)%></td>
	<td><%= empnoAL.get(i)%></td>
    <td align="left">&nbsp;&nbsp;&nbsp;<%= nameAL.get(i)%></td>
  </tr>
<%		
	fw.write(yyyy+"/"+mm+"/"+dd+"\tCI-"+fltnoAL.get(i)+"\t"+secAL.get(i)+"\t"+empnoAL.get(i)+"\t"+nameAL.get(i)+"\r\n");

	}// end of for(int i=0; i<fltnoAL.size(); i++)
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








































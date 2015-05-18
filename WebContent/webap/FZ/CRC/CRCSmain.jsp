<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.util.*,fz.UnicodeStringParser"%>
<jsp:useBean id="unicodeStringParser" class="fz.UnicodeStringParser" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //Check if logined
if ((sGetUsr == null) || (session.isNew()) )
{		//check user session start first or not login
	response.sendRedirect("sendredirect.jsp");
} 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Crew Reporting Check System</title>
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
String f = request.getParameter("f");
//out.print(" f= "+f);
Driver dbDriver = null;
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;

//取得check in時間(建明轉入)
Connection conn2 = null;
Statement stmt2 = null;
ResultSet rs2 = null;
//*************************

ArrayList str_dt_tpe_c = new ArrayList();
ArrayList end_dt_utc = new ArrayList();
ArrayList end_dt_tpe = new ArrayList();
ArrayList str_dt_loc = new ArrayList();
ArrayList end_dt_loc = new ArrayList();
ArrayList fltno = new ArrayList();
ArrayList gmt_dt = new ArrayList();
ArrayList sect = new ArrayList();
ArrayList fleet = new ArrayList();
ArrayList rank = new ArrayList();
ArrayList fltdate = new ArrayList();

String sql = null;
String cname = null;
String empno = null;
String Big5CName =  null;
String tsa_dt = null;
String no_show = null;
String crc_ck = null;

ConnDB cn = new ConnDB();

try{
	//connect to ORP3/FZ
	cn.setORP3FZUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn2 = dbDriver.connect(cn.getConnURL(), null);
	stmt2 = conn2.createStatement(); 
	
	//connect to AOCIPROD
	cn.setAOCIPRODCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	stmt = conn.createStatement(); 

	sql = "select to_char(d.act_end_dt_tm_gmt - 8/24,'mm/dd HH24MI') end_dt_utc, " +
	"to_char(d.act_str_dt_tm_gmt,'yyyy/mm/dd HH24MI') str_dt_tpe_c, " +
	"to_char(d.act_end_dt_tm_gmt,'mm/dd HH24MI') end_dt_tpe,c.preferred_name cname, r.staff_num staff_num,d.flt_num flt_num, " +
	"to_char(d.act_str_dt_tm_gmt,'yyyy/mm/dd') fltdate, d.act_port_a port_a, d.act_port_b port_b, r.acting_rank rank, " +
	"d.fleet_cd fleet, to_char(d.str_dt_tm_loc,'mm/dd HH24MI') str_dt_loc, to_char(d.end_dt_tm_loc,'mm/dd HH24MI') end_dt_loc " +
	"from roster_v r, duty_prd_seg_v d, crew_v c " +
	"where r.sched_nm=d.sched_nm and r.series_num=d.series_num and r.staff_num=c.staff_num " +
	"and r.staff_num='"+sGetUsr+"' and (d.duty_cd='FLY' OR (d.duty_cd='TVL' and d.cop_duty_cd in ('ACM','SUP','OCM','ECM','JCM'))) " +  
	"and r.delete_ind='N' and d.act_port_a='TPE' " +
	//"and  to_char(d.str_dt_tm_gmt,'yyyymm') =  '200502' order by d.str_dt_tm_gmt";
	"and  d.act_str_dt_tm_gmt >= sysdate and r.pub_dt_tm is not null order by d.act_str_dt_tm_gmt";

	rs = stmt.executeQuery(sql);

	if(rs != null)
	{
		while(rs.next())
		{
			str_dt_tpe_c.add(rs.getString("str_dt_tpe_c"));
			end_dt_tpe.add(rs.getString("end_dt_tpe"));
			if(cname == null){
				cname = rs.getString("cname");
				Big5CName = new String(unicodeStringParser.removeExtraEscape(cname).getBytes(), "Big5");
				empno = rs.getString("staff_num");
			}
			fltno.add(rs.getString("flt_num"));
			str_dt_loc.add(rs.getString("str_dt_loc"));
			end_dt_utc.add(rs.getString("end_dt_utc"));
			end_dt_loc.add(rs.getString("end_dt_loc"));
			sect.add(rs.getString("port_a") + rs.getString("port_b"));
			fleet.add(rs.getString("fleet"));
			rank.add(rs.getString("rank"));
			fltdate.add(rs.getString("fltdate"));
		}
	}
%>
<br>
<div align="center" class="txttitle"><%=sGetUsr%> / <%=Big5CName%></div>
<br>
<table width="90%"  border="1" align="center" cellpadding="0" cellspacing="0">
  <tr bgcolor="#00CCFF" class="tablehead" >
    <td>DEP/TPE</td>
	<td>FltNo</td>
	<td>Sector</td>
	<td>ARV/TPE</td> 
	<td>DEP/LCL</td>
	<td>ARV/LCL</td> 
	<td>Fleet</td>
	<td>ACChkIn</td>
	<td>CRC</td>
  </tr>
<%
for(int i=0; i < str_dt_tpe_c.size(); i++){
	//取得check in時間(建明轉入)
	sql = "select to_char(tsa_dt,'mm/dd HH24MI') tsa_dt from fztflin " +
	"where fltd=to_date('"+fltdate.get(i)+"','yyyy/mm/dd') and fltno='"+fltno.get(i)+"' and sect='"+sect.get(i)+"'";
	tsa_dt = "";
	rs2 = stmt2.executeQuery(sql);
	if(rs2.next()) tsa_dt = rs2.getString("tsa_dt");
	//取得組員是否已於CRC完成證照自我檢核報到程序
	sql = "select nvl(crewchk,'N') crc_ck from fzdb.fztckin where fltd=to_date('"+fltdate.get(i)+
	"','yyyy/mm/dd') and fltno='"+fltno.get(i)+"' and sect='"+sect.get(i)+"' and empno='"+sGetUsr+"'";
	crc_ck = "N";
	rs2 = stmt2.executeQuery(sql);
	if(rs2.next()) crc_ck = rs2.getString("crc_ck");
	//檢查Aircrews(crew_dops_v column no_show)
	//flt_dt_tm --> TPE time
	no_show = "N/A";
	String mysect = (String)sect.get(i);
	sql = "select decode(nvl(no_show,'Y'),'N','Y','Y','N') no_show from crew_dops_v " +
	"where to_char(flt_dt_tm,'yyyy/mm/dd')='"+fltdate.get(i)+"'" +
	" and flt_num='"+fltno.get(i)+"' and dep_arp_cd='"+mysect.substring(0,3) +
	"' and staff_num='"+empno+"'";
	//out.println(sql);
	rs = stmt.executeQuery(sql);
	if(rs.next()) no_show = rs.getString("no_show");
%>
	<tr class="tablebody">
		<td><div align="center"><%=str_dt_tpe_c.get(i)%></div></td>
		<%
		if(f == null){
		%>
		<td><div align="center"><a href="../tsa/daily/DailyCrew.jsp?fltdate=<%=fltdate.get(i)%>&fltno=<%=fltno.get(i)%>&sector=<%=sect.get(i)%>&end_dt_utc=<%=end_dt_utc.get(i)%>&str_dt_tpe_c=<%=str_dt_tpe_c.get(i)%>&end_dt_tpe=<%=end_dt_tpe.get(i)%>&fleet=<%=fleet.get(i)%>&str_dt_loc=<%=str_dt_loc.get(i)%>&end_dt_loc=<%=end_dt_loc.get(i)%>&showfltno=<%=fltno.get(i)%>&tsa_dt=<%=tsa_dt%>&userid=<%=sGetUsr%>&flag='FC'"><%=fltno.get(i)%></a></div></td>
		<%
		}
		else{
		%>
		<td><div align="center"><%=fltno.get(i)%></div></td>
		<%
		}
		%>
		<td><div align="center"><%=sect.get(i)%></div></td>
		<td><div align="center"><%=end_dt_tpe.get(i)%></div></td>
		<td><div align="center"><%=str_dt_loc.get(i)%></div></td>
		<td><div align="center"><%=end_dt_loc.get(i)%></div></td>
		<td><div align="center"><%=fleet.get(i)%></div></td>
		<%
		if("Y".equals(no_show) && "N".equals(crc_ck)){
		//  if(("Y".equals(no_show) && "N".equals(crc_ck)) || "636130".equals(sGetUsr)){
			//if(f != null){
			if (true) {
				%>
				<td><div align="center"><a href="check_menu1.jsp?fltdate=<%=fltdate.get(i)%>&fltno=<%=fltno.get(i)%>&sector=<%=sect.get(i)%>&fleet=<%=fleet.get(i)%>&rank=<%=rank.get(i)%>"><img src="../images/ed1.gif" alt="Check In" width="22" height="22" border="0"></a></div></td>
  				<%
			}
			else{
				%>

				<td><div align="center"><%=no_show%></div></td>
				<%
			}
		}
		else{
			%>
			<td><div align="center"><%=no_show%></div></td>
			<%
		}
		%>
		<td><div align="center"><%=crc_ck%></div></td>
  </tr>
<%
}
}catch (Exception e){
	  out.println(e.toString() + sql);
}
finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
	try{if(rs2 != null) rs2.close();}catch(SQLException e){}
	try{if(stmt2 != null) stmt2.close();}catch(SQLException e){}
	try{if(conn2 != null) conn2.close();}catch(SQLException e){}
}
 %>
</table>
</body>
</html>
<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.util.*,java.io.*,fz.*,fz.daily.*,java.text.*" errorPage="" %>
<jsp:useBean id="unicodeStringParser" class="fz.UnicodeStringParser" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%

response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

String sGetUsr = request.getParameter("userid"); //get user id if already login
String cabin = request.getParameter("cabin");

String OZPUB = "";
  if(session.getAttribute("OZPUB") != null){
  	OZPUB  =(String) session.getAttribute("OZPUB");
}
  
if (sGetUsr == null){
	sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader ("Expires", 0);
	
	if (session.isNew() || sGetUsr == null) 
	{		//check user session start first
		response.sendRedirect("../sendredirect.jsp");
	} 
}
String fleet_cd = null;	
if(request.getParameter("fleet_cd") != null && !"".equals(request.getParameter("fleet_cd"))){
	fleet_cd	= request.getParameter("fleet_cd");
}
String yy	= request.getParameter("fyy");
String mm	= request.getParameter("fmm");
String dd	= request.getParameter("fdd");
String yy2	= request.getParameter("eyy");
String mm2	= request.getParameter("emm");

String path = ""; /* CS40: 2008/12/08 */
String filename = "";/* CS40: 2008/12/08 */

String fullUCD = request.getParameter("fullUCD");//190A.068D

//檢查班表是否公布
swap3ac.PublishCheck pc = new swap3ac.PublishCheck(yy2, mm2);

if((!"190A".equals(fullUCD) && !"068D".equals(fullUCD))
	&& !pc.isPublished()){
//非航務、空服簽派者，才檢查班表是否公佈
%>
<div style="background-color:#99FFFF;text-align:center;color:#FF0000;font-family:Verdana;font-size:10pt; ">
		<%=yy2+"/"+mm2%>班表尚未正式公佈!!
</div>
<%

}else{
//寫入log
fz.writeLog wl = new fz.writeLog();
wl.updLog(sGetUsr, request.getRemoteAddr(),request.getRemoteHost(), "CII030");



String dd2	= request.getParameter("edd");
String myoccu	= request.getParameter("occu");
String duty_cd	= request.getParameter("duty_cd");
String fltno	= request.getParameter("fltno");
String sect		= request.getParameter("sector");
String fdate	= yy+mm+dd;
String edate	= yy2+mm2+dd2;
String title    = null;
String rs_emp	= 	null;
String name		=	null;
String box		=	null;
String rank		=	null;
String fleet	=	null;
String base		=	null;
String off_date =   null;
String flt_no   =   null;
String gch_yymm =   null;
String fd_ind	=	null;
String sector	=	null;
String bcolor	=	null;
String sql		=	null;
String tripno = null;
String exp_dt = "";
String grp = "";
int xCount = 0;
fzac.AllCrewBaseInfo allCrewInfo = null;
//BASE
String b = "";
if(!"".equals(request.getParameter("B")) && null != request.getParameter("B") ){
	b = request.getParameter("B");
}
if(!"".equals(b)){
	allCrewInfo = new fzac.AllCrewBaseInfo(yy+mm+dd);
}


Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
ConnDB cn = new ConnDB();
Driver dbDriver = null;
String preEmpno = "";


boolean t = false;
//抓取組員相關資料, Create Hours, next schedule
//GetCrewInfo gch = new GetCrewInfo();
//前艙	gch.getBlkHr(gch_yymm,rs_emp, 1)
//後艙	gch.getBlkHr(gch_yymm,rs_emp, 2)

//取得前艙組員機隊資料
fzac.CockpitCrewFleet cft = new fzac.CockpitCrewFleet();
try {
	cft.initData();
} catch (ClassNotFoundException e) {
	out.print(e.toString());
} catch (SQLException e) {
	out.print(e.toString());
}catch (Exception e) {
	out.print(e.toString());
}

//SR6481 取得前艙組員空勤檢定證號碼(licencd_cd=RAT)
fzac.CockpitCrewRATLicenceNo ccLno = new fzac.CockpitCrewRATLicenceNo();
try {	
	ccLno.initData();
	
} catch (Exception e) {
	out.print(e.toString());
}

try
{
cn.setAOCIPRODCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
/*
sql = "select r.staff_num empno, c.seniority_code sern, c.preferred_name name,c.section_number grp,"
	+" r.acting_rank rank, dps.fleet_cd fleet, r.location_cd base,r.series_num, "
	+"to_char(dps.str_dt_tm_gmt,'yyyy/mm/dd') off_date, dps.flt_num flt_num,"
	+" to_char(dps.str_dt_tm_gmt,'yyyy/mm') gch_yymm, dps.fd_ind fd_ind, "
	+"dps.port_a||dps.port_b sector "
	+"from roster_v r, crew_v c, duty_prd_seg_v dps"
	+" where r.staff_num=c.staff_num and r.series_num = dps.series_num "
	+" and r.delete_ind='N' and to_char(dps.str_dt_tm_gmt,'yyyymmdd') >= '"
	+fdate+"' and to_char(dps.str_dt_tm_gmt,'yyyymmdd') <= '"+edate+"' ";
*/	
sql = "select dps.duty_cd,r.staff_num empno, c.seniority_code sern, c.preferred_name name,"
	+" cv.rank_cd rank, dps.fleet_cd fleet, r.location_cd base,r.series_num,c.section_number, "
	+"to_char(dps.str_dt_tm_gmt,'yyyy/mm/dd') off_date, dps.flt_num flt_num,"
	+" to_char(dps.str_dt_tm_gmt,'yyyy/mm') gch_yymm, dps.fd_ind fd_ind, "
	+"dps.act_port_a||dps.act_port_b sector,nvl(to_char(cv.exp_dt,'yyyy/mm/dd'),'&nbsp;') exp_dt "
	+"from roster_v r, crew_v c, duty_prd_seg_v dps,crew_rank_v cv "
	+" where r.staff_num=c.staff_num and r.staff_num=cv.staff_num and r.series_num = dps.series_num "	
	+" and r.delete_ind='N' and dps.str_dt_tm_gmt between to_date('"+fdate+" 0000','yyyymmdd hh24mi') "
	+"and to_date('"+edate+" 2359','yyyymmdd hh24mi') " 
	+" and (cv.exp_dt > sysdate or cv.exp_dt is null) ";



if (fltno.length()==0)
{// fltno is empty
	if (duty_cd.equals("FLY"))
	{// fltno is empty and dutycode is FLY
		
		if (sect.length()==0)
		{// sector is empty, just match dutycode
		
			sql = sql + " and dps.duty_cd = '"+duty_cd+"' ";
			title = "All Flight ";
		
		}
		else
		{// fltno is empty but sector is not empty, match sector
			sql = sql + " and dps.act_port_a||dps.act_port_b = '"+sect+"' ";
			title = "Sector " + sect + " ";
		}
		
	}
	else
	{// fltno is empty and dutycode is not FLY
	
		if (sect.length()==0)
		{// fltno and sector are empty
	
			sql = sql + " and dps.duty_cd = '"+duty_cd+"' ";
			title = duty_cd;
			
		}
		else
		{// dutycode is not FLY , fltno is empty but sector is not empty
			sql = sql + " and dps.act_port_a||dps.act_port_b = '"+sect+"' ";
			title = "Sector " + sect + " ";
		}
    }
}
else
{// fltno is not empty
	DecimalFormat df = new DecimalFormat("0000");
	fltno = df.format(Integer.parseInt(fltno));

	if (sect.length()==0)
	{

		sql = sql + " and dps.flt_num = '"+fltno+"' ";
		title = "FltNo " + fltno +" "+duty_cd;

	}
	else
	{// fltno is not empty and sector is not empty
		sql = sql + " and dps.flt_num = '"+fltno+"' and dps.act_port_a||dps.act_port_b = '"+sect+"' ";
		title = "FltNo " + fltno+" "+duty_cd;
	}
//若輸入fltno,選擇FLY，則也要顯示該班的TVL
	if("FLY".equals(duty_cd)){
		sql += " and dps.duty_cd in ('"+duty_cd+"','TVL') ";
	}else{
		sql += " and dps.duty_cd='"+duty_cd+"' ";
	}
}
/*
if(fleet_cd != null){
	sql += " and dps.fleet_cd = '"+fleet_cd+"' ";
}
*/

/*if(!"".equals(b)){
	sql = sql + " and r.location_cd = '"+ b+"' ";
}
*/
if (myoccu.equals("all"))
{
	sql = sql + " order by off_date, flt_num, sector, fd_ind desc, empno ";
	title = title + " Crew List";
}else if("Y".equals(myoccu)){//前艙
	sql = sql +" and dps.fd_ind = 'Y' order by off_date, flt_num, sector, fd_ind desc, empno ";
	title = title + " Crew List";
}else if("N".equals(myoccu)){//後艙
	sql = sql +" and dps.fd_ind = 'N' order by off_date, flt_num, sector, fd_ind desc, empno ";
	title = title + " Crew List";
}else
{
	//sql = sql + " and r.acting_rank = '"+myoccu+"' order by off_date, flt_num, sector, fd_ind desc, empno ";
	
	sql = sql + " and cv.rank_cd = '"+myoccu+"' order by off_date, flt_num, sector, fd_ind desc, empno ";
	title = title + " " + myoccu + " Crew List";
}



//System.out.print(sql);
rs = stmt.executeQuery(sql); 

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Query Crew List</title>
<link href="menu.css" rel="stylesheet" type="text/css">
<script src="../../js/subWindow.js"></script>
<style type="text/css">
<!--
.style2 {
	color: #FF0000;
	font-size: small;
}
-->
</style>
</head>
<style type="text/css">
<!--

BODY{margin:0px;}/*內容貼緊網頁邊界*/

.style1 {font-size: 16px; line-height: 22px; color: #464883; font-family: "Arial";}
-->
</style>
<body>
<div align="center">
<span class="txttitletop"><%=yy%>/<%=mm%>/<%=dd%>&nbsp;&nbsp;~&nbsp;&nbsp;<%=yy2%>/<%=mm2%>/<%=dd2%>&nbsp;&nbsp;<%=title%>&nbsp;
<%
if(fleet_cd !=null){	out.print("&nbsp;&nbsp;Fleet:"+fleet_cd);}
%>

	  <br>
  </span>
  
<form name="form1" method="post">
	<input type="hidden" name="tripno">
	<input type="hidden" name="flag" value="L">
	<input type="hidden" name="acno">
	<input type="hidden" name="empno">
	<input type="hidden" name="cname">
</form>
<script language="javascript" type="text/javascript">
	function showTrip(tripno,fleet){
		subwinXY('../../temple/loading.htm','tripList','700','500');
		document.form1.target="tripList";
		document.form1.action="TripListAll.jsp";
		document.form1.tripno.value = tripno;
		document.form1.acno.value = fleet;		
		document.form1.submit();
	}
	
	function showTel(empno,cname){
		subwinXY('../../temple/loading.htm','phone','500','300');
		document.form1.target="phone";
		document.form1.action="PhoneList.jsp";
		document.form1.empno.value = empno;
		document.form1.cname.value = cname;		
		document.form1.submit();
	}
</script>
  
<table width="90%"  border="0" align="center"  cellpadding="0" cellspacing="1">
  <tr>
    <td width="83%" align="right">
	<%
	if(!"Y".equals(OZPUB)){
	%>
	<span class="txtblue">You can query the crew by click Name column (點選姓名可查詢該組員資料)</span>
	<%
	}
	%>
	 </td>
    <td width="17%" align="right"><a href="javascript:window.print()"><img height="15" src="../../images/print.gif" width="17" border="0"></a></td>
  </tr>
</table>
</div>
<table width="90%"  border="0" align="center" class="fortable" cellpadding="0" cellspacing="1"> 
  <tr>
    <td width="2%" class="tablehead3">&nbsp;</td>
    <td width="6%" class="tablehead3">&nbsp;EmpNo&nbsp;</td>
    <td width="8%" class="tablehead3">LicenceNo</td>
    <td class="tablehead3">&nbsp;Name&nbsp;</td>
    <td width="4%" class="tablehead3">&nbsp;Sern&nbsp;</td>
	<%
	if ( (duty_cd.equals("FLY")) || (fltno.length()!=0) || (sect.length()!=0)
		| duty_cd.equals("TVL"))
	{
	%>
    <td width="5%" class="tablehead3">&nbsp;FltNo&nbsp;</td>
    <td width="6%" class="tablehead3">&nbsp;Sector&nbsp;</td>
	<%
	}
	%>
    <td width="5%" class="tablehead3">&nbsp;Occu&nbsp;</td>
    <td width="5%" class="tablehead3">&nbsp;Fleet&nbsp;</td>
 
    <td width="5%" class="tablehead3">Group</td>
    <td width="7%" class="tablehead3">&nbsp;Date&nbsp;</td>
    <td width="7%" class="tablehead3">&nbsp;Tripno&nbsp;</td>
	<td width="6%" class="tablehead3">&nbsp;Exp_Dt&nbsp;</td>
  </tr>
<%

path = application.getRealPath("/")+"/file/"; /* CS40: 2008/12/08 */
filename = "crewlistquery_by_"+sGetUsr+ ".csv";/* CS40: 2008/12/08 */
FileWriter fw = new FileWriter(path+filename,false);/* CS40: 2008/12/08 */
fw.write("Count,EmpNo,LicenceNo,Name,Sern,FltNo,Sector,Occu,Fleet,Group,Date,TripNo,Exp_Dt" + "\r\n");/* CS40: 2008/12/08 */	
		
if(rs != null)
{
	while(rs.next())
	{	
		rs_emp		= 	rs.getString("empno").trim();
		if(fleet_cd !=null){
			if(!fleet_cd.equals(cft.getFleetCd(rs_emp))){
				continue;
			}
		}
		if(!"".equals(b) && !"ALL".equals(b)){
			if(!b.equals(allCrewInfo.getBase(rs_emp))){
				continue;
			}
		}

		name		=	rs.getString("name");
		box			=	rs.getString("sern");
		rank		=	rs.getString("rank");
		fleet		=	rs.getString("fleet");
		base		=	rs.getString("base");
		off_date	=	rs.getString("off_date");
		flt_no		=	rs.getString("flt_num");
		gch_yymm	=	rs.getString("gch_yymm");
		fd_ind		=	rs.getString("fd_ind");
		sector		=	rs.getString("sector");
		tripno 		=	rs.getString("series_num");
		exp_dt 		=	rs.getString("exp_dt");
		grp 		= 	rs.getString("section_number");

		name = new String(unicodeStringParser.removeExtraEscape(name).getBytes(), "Big5"); 		xCount++;
		if(preEmpno.equals(rs_emp)){xCount--;}
		
		if (xCount%2 == 0)
		{
			bcolor = "#C9C9C9";
		}
		else
		{
			bcolor = "#FFFFFF";
		}
		
%>
		<tr bgcolor="<%= bcolor%>">
			<td height="22" class="tablebody"><%
			if(preEmpno.equals(rs_emp)){
				out.print("&nbsp;");
				fw.write(",");/* CS40: 2008/12/08 */
			}else{
				out.print(xCount);
				fw.write(xCount + ",");/* CS40: 2008/12/08 */
			}

			
			%>
			</td>
			<td height="22" class="tablebody"><%=rs_emp%></td><%fw.write(rs_emp + ",");/* CS40: 2008/12/08 */%>
			<td height="22" class="tablebody">&nbsp;<%=ccLno.getLicenceNo(rs_emp)%></td><%fw.write(ccLno.getLicenceNo(rs_emp) + ",");/* CS40: 2008/12/08 */%>
			<td  class="tablebody" width="29%"><p align="left">
			<%
			if("Y".equals(OZPUB)){
				out.print(name);
	
			}else{
			%>
			<a href="javascript:showTel('<%=rs_emp%>','<%=name%>');" >
			&nbsp;&nbsp;<%=name%>&nbsp;&nbsp;</a>
			<%
			}
			fw.write(name + ",");/* CS40: 2008/12/08 */
			%>
			</p></td>
			<td class="tablebody">&nbsp;<%=box%>&nbsp;</td><%fw.write(box + ",");/* CS40: 2008/12/08 */%>
			<%
			if ( (duty_cd.equals("FLY")) || (fltno.length()!=0) || (sect.length()!=0) 
				| duty_cd.equals("TVL") )		
			{
			%>
			<td class="tablebody">&nbsp;<%=flt_no%>&nbsp;<%fw.write(flt_no);/* CS40: 2008/12/08 */%>
			<% if( rs.getString("duty_cd").equals("TVL")){out.print("<span style=color:red>TVL</span>");fw.write("TVL");/* CS40: 2008/12/08 */}%></td><%fw.write(",");/* CS40: 2008/12/08 */%>
			<td class="tablebody">&nbsp;<%=sector%>&nbsp;</td><%fw.write(sector + ",");/* CS40: 2008/12/08 */%>
			<%
			}
			%>
			<td class="tablebody">&nbsp;<%=rank%>&nbsp;</td><%fw.write(rank + ",");/* CS40: 2008/12/08 */%>
		  <td class="tablebody">&nbsp;<%=cft.getFleetCd(rs_emp)%>&nbsp;</td><%fw.write(cft.getFleetCd(rs_emp) + ",");/* CS40: 2008/12/08 */%>
	
			
			<td class="tablebody">&nbsp;<%=grp%></td><% if (grp==null) grp=""; fw.write(grp + ",");/* CS40: 2008/12/08 */%>
			<td class="tablebody">&nbsp;<%=off_date%>&nbsp;</td><%fw.write(off_date + ",");/* CS40: 2008/12/08 */%>
			<td width="7%" class="tablebody">&nbsp;<a href="javascript:showTrip('<%=tripno%>','<%=fleet%>')" ><%=tripno%></a>&nbsp;</td><%fw.write(tripno + ",");/* CS40: 2008/12/08 */%>				
			<td class="tablebody"><span class="txtxred"><%=exp_dt%></span></td><% if ("&nbsp;".equals(exp_dt)) exp_dt=""; fw.write(exp_dt + "\r\n");/* CS40: 2008/12/08 */%>

		</tr>

<%
preEmpno = rs_emp;
  	}// end of while

	if(xCount==0)
	{
		try{if(rs != null) rs.close();}catch(SQLException e){}
		try{if(stmt != null) stmt.close();}catch(SQLException e){}
		try{if(conn != null) conn.close();}catch(SQLException e){}
		response.sendRedirect("../showmessage.jsp?messagestring=No Data Found!!");
	}

}//if(rs != null)
fw.close();/* CS40: 2008/12/08 */
%>
		<tr >
		  <td height="22" colspan="14" class="txtblue">*Licence_No:前艙組員空勤檢定證號碼</td>
  </tr>
</table>
<div align="center">
  <p>&nbsp;</p>
  <p><a href="saveFile.jsp?filename=<%= filename %>"><font size="4"><img src="../../images/ed4.gif" border="0"> 
    <span class="txtblue"><%= filename %> </span></font></a><br>
    <br>
  </p>
</div>
<div align="center" class="txtblue">請點擊連結存檔<BR>Click link to save file</div>

</body>
</html>
<%
}
catch (Exception e)
{
	  t = true;
	  out.print(e.toString());

}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
if(t)
{
	//response.sendRedirect("../err.jsp");
}

}
%>
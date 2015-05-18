<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,fz.daily.*" %>
<jsp:useBean id="hmc" class="fz.daily.CheckHMC" /> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
/*response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
*/
if (session.isNew() || sGetUsr == null) 
{		//check user session start first
  %> <jsp:forward page="../sendredirect.jsp" /> <%
} 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Daily</title>
<link href="../../menu.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style2 {font-size: 12}
.style3 {color: #FF0000}
-->
</style>
<script language="javascript" type="text/javascript">
function f_checkbox(){ 
var c = document.form1.fltno.value;
    alert(c);
    //eval("document."+formName+".mode.value='INSERT'");
	//eval("document."+formName+".target = '_self'");
	//eval("document.form1.curremp.value = empno");
	//eval("document.form1.curradj.value = adjckdt");
	//eval("document.form1.action = 'pc_update_form.jsp'");
	//eval("document.form1.submit()");
}//function
</script>
</head>
<body>
<p>
<%
//fltdate --> TPE local time
String fltdate 	= request.getParameter("yy")+"/"+ request.getParameter("mm")+"/"+request.getParameter("dd");
String showDate = request.getParameter("mm")+"/"+request.getParameter("dd");
String fltno_in	= request.getParameter("fltno");
String fltnoCondition = null;
	if(fltno_in.equals("")){
		fltnoCondition = "";
	}
	else{
		fltnoCondition = " and flt_num ='"+ fltno_in +"' ";
	}
String status 	= request.getParameter("status");
String stime 	= request.getParameter("stime");
String etime 	= request.getParameter("etime");
if("".equals("stime")) stime = "0000";
if("".equals("etime")) etime = "2359";
String statusCondition = null;
	if(status.equals("dpt")){
		statusCondition = " and act_str_dt_tm_gmt between to_date('"+fltdate+stime+"','yyyy/mm/ddHH24MI') and to_date('"+fltdate+etime+"','yyyy/mm/ddHH24MI') "+
		"and port_a in ('TPE','TSA') group by act_str_dt_tm_gmt,act_end_dt_tm_gmt,flt_num,fleet_cd,str_dt_tm_loc,end_dt_tm_loc,duty_cd,port_a,port_b "+
		"order by act_str_dt_tm_gmt, flt_num";
	}
	else{
		statusCondition = " and act_end_dt_tm_gmt between to_date('"+fltdate+stime+"','yyyy/mm/ddHH24MI') and to_date('"+fltdate+etime+"','yyyy/mm/ddHH24MI') "+
		"and port_b in ('TPE','TSA') group by act_str_dt_tm_gmt,act_end_dt_tm_gmt,flt_num,fleet_cd,str_dt_tm_loc,end_dt_tm_loc,duty_cd,port_a,port_b "+
		"order by act_end_dt_tm_gmt, flt_num";
	}

String end_dt_utc = null;
String str_dt_tpe_c = null;
String end_dt_tpe = null;
String fltno = "";
String showfltno = null;
String fleet = null;
String sect = null;
String str_dt_loc = null;
String end_dt_loc = null;
String duty_cd = null;
String tsa_dt = "";
String cks_dt = "";
String myst = "style2";
//add by Betty 2007/11/07
String str_dt_loc_full = "";

Driver dbDriver = null;
Connection conn = null;
Statement stmt = null;
ResultSet myResultSet = null;

//取得check in時間(建明轉入)
Statement stmt2 = null;
Connection conn2 = null;
ResultSet rs = null;
//*************************

boolean t = false;
String  sql = null;
int Count = 0;
String bgColor = null;
String ct = null; //判斷flt是否超過140min Y or N

ConnDB cn = new ConnDB();
//取得該班組員是否皆已報到完成
CheckFlag cf = new CheckFlag();

try{
	//connect to ORP3/FZ
	cn.setORP3FZUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn2 = dbDriver.connect(cn.getConnURL(), null);
	stmt2 = conn2.createStatement(); 

	//connect to ORP3/AOCIPROD
	cn.setAOCIPRODCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	stmt = conn.createStatement();
	
sql = "select to_char(act_end_dt_tm_gmt - 8/24,'mm/dd HH24MI') end_dt_utc, " + 
	  "to_char(act_str_dt_tm_gmt,'yyyy/mm/dd HH24MI') str_dt_tpe_c, " + 
	  "to_char(str_dt_tm_loc,'yyyy/mm/dd HH24MI') str_dt_loc_full, " +
	  "case when act_str_dt_tm_gmt <= (sysdate + (140/1440)) and act_str_dt_tm_gmt > sysdate then 'Y' else 'N' end checktime, " +
	  //"case when str_dt_tm_gmt <= to_date('2005020218', 'yyyymmddHH24') and str_dt_tm_gmt > to_date('2005020216', 'yyyymmddHH24') then 'Y' else 'N' end checktime, " +
	  "to_char(act_end_dt_tm_gmt,'mm/dd HH24MI') end_dt_tpe, " +
	  "flt_num, "+
	  "fleet_cd, port_a||port_b sect, to_char(str_dt_tm_loc,'mm/dd HH24MI') str_dt_loc, "+
	  "to_char(end_dt_tm_loc,'mm/dd HH24MI') end_dt_loc, duty_cd " +
	  "from duty_prd_seg_v " +
	  "where (duty_cd in ('FLY','HST','744SIM','744SIM_SUPP','744SIM_SUP','74FSIM','74FSIM_SUPP','74FSIM_SUP','AB6SIM','AB6SIM_SUPP','738SIM','738SIM_SUPP','738SIM_SUP','343SIM','343SIM_SUPP','343SIM_SUP','333SIM','333SIM_SUPP','333SIM_SUP','OBS_SIM') " + 
	  "or (duty_cd='TVL' and arln_cd='AE') or flt_num in ('0193','0195','0197')) " +
	  "and delete_ind = 'N' " +
	  fltnoCondition + statusCondition;
//out.println(sql);
myResultSet = stmt.executeQuery(sql);

%>
</p>
<p align="center">
<%
	if(status.equals("dpt")){%>
	<span class="txttitletop">TPE Departure&nbsp; <%=fltdate%></span>  
	<%}
	else{%>
	<span class="txttitletop">TPE Arrival&nbsp; <%=fltdate%></span>  
	<%}
%>
</p>
<table width="90%"  border="0" align="center" cellpadding="0" cellspacing="0" class="fortable">
  <tr class="tablehead3">
    <td>Crew Check</td>
	<td></td>
	<td>TSA</td>
	<td>TTY</td>
    <td>TSA Check In</td>
	<td>TTY Check In</td>
    <td>Fltno</td>
	<td>Fleet</td>
    <td>Sector</td>
	<td>DEP/LCL</td>
    <td>ARV/LCL</td>
	<td>ARV/UTC</td>
  </tr>
<%
 	if(myResultSet != null){
		while(myResultSet.next()){
		end_dt_utc = myResultSet.getString("end_dt_utc");
		str_dt_tpe_c = myResultSet.getString("str_dt_tpe_c");
		end_dt_tpe = myResultSet.getString("end_dt_tpe");
		str_dt_loc_full = myResultSet.getString("str_dt_loc_full");
		fltno = myResultSet.getString("flt_num");
		showfltno = fltno;
		fleet = myResultSet.getString("fleet_cd");
		sect = myResultSet.getString("sect");
		str_dt_loc = myResultSet.getString("str_dt_loc");
		end_dt_loc = myResultSet.getString("end_dt_loc");
		duty_cd = myResultSet.getString("duty_cd");
		ct = myResultSet.getString("checktime");
		if (fltno.equals("0")) showfltno = duty_cd;
		//取得check in時間(建明轉入)
		sql = "select to_char(tsa_dt,'mm/dd HH24MI') tsa_dt from fztflin " +
		"where fltd=to_date('"+fltdate+"','yyyy/mm/dd') and fltno=substr('"+showfltno+"',1,4) and sect='"+sect+"'";
		tsa_dt = "";
		rs = stmt2.executeQuery(sql);
		if(rs.next()) tsa_dt = rs.getString("tsa_dt");
		//**************************
		Count ++;
			
			if (Count%2 == 0)
			{
				bgColor = "#99CCFF";//"#C9C9C9";
			}
			else
			{
				bgColor = "#FFFFFF";
			}

%>

  
  <tr bgcolor="<%=bgColor%>" class="tablebody">
    <%
	if(status.equals("dpt")){
	%>
  	<td><div align="center"><a href="checklist.jsp?str_dt_tpe_c=<%=str_dt_tpe_c.substring(0,10)%>&fltno=<%=fltno%>&sector=<%=sect%>" target="_blank"><img src="../../images/ed1.gif" alt="show crew check in" width="22" height="22" border="0"></a></div></td>
    <td><%
	if ("634319x".equals(sGetUsr)){%>
		<form name="form1" method="post" action="">
			<input type="checkbox" name="prehdl" id="prehdl"  onClick="f_checkbox()">
		</form>	<% 
	} //if %>
	</td>
	<%
	}
	else{
		out.print("<td>&nbsp;</td>");
	}
	
	//1.TPE 起飛的班機  2.離報到時間140min前  3.有組員未完成報到
	if(status.equals("dpt") && "Y".equals(ct.trim())){
		//-2 : error
		//-1 : 無組員
		// 0 : 全報到
		// 1 : TSA 有未報到組員
		// 2 : TTY 有未報到組員
		// 3 : TSA & TTY 均有未報到
		String ck = cf.getCheckInfo(str_dt_tpe_c.substring(0,10), fltno, sect);
		if("0".equals(ck)){
			out.print("<td><div align='center'><img src='../../images/dot_green.gif' width='14' height='14'></div></td>");
			out.print("<td><div align='center'><img src='../../images/dot_green.gif' width='14' height='14'></div></td>");
		}
		else if("1".equals(ck)){
			out.print("<td><div align='center'><img src='../../images/dot_red.gif' width='14' height='14'></div></td>");
			out.print("<td><div align='center'><img src='../../images/dot_green.gif' width='14' height='14'></div></td>");
		}
		else if("2".equals(ck)){
			out.print("<td><div align='center'><img src='../../images/dot_green.gif' width='14' height='14'></div></td>");
			out.print("<td><div align='center'><img src='../../images/dot_red.gif' width='14' height='14'></div></td>");
		}
		else if("3".equals(ck)){
			out.print("<td><div align='center'><img src='../../images/dot_red.gif' width='14' height='14'></div></td>");
			out.print("<td><div align='center'><img src='../../images/dot_red.gif' width='14' height='14'></div></td>");
		}
		else{
			out.print("<td>&nbsp;</td>");
			out.print("<td>&nbsp;</td>");
		}
	}
	else{
		out.print("<td>&nbsp;</td>");
		out.print("<td>&nbsp;</td>");
	}
	cks_dt = "";
	if (!fltno.equals("0") && "TPE".equals(sect.substring(0,3))){
		CheckInTime cit = new CheckInTime();
		//IN--> '0006', act_str_dt_tm_gmt : '2004/11/24 0930', return-->2004/11/240830
		cks_dt = cit.getCKSTime(fltno, str_dt_tpe_c); 
		cks_dt = cks_dt.substring(5,10) + " " + cks_dt.substring(10,14);
	}
	%>	
	<td><div align="center"><span class="style2"><%=tsa_dt%></span></div></td>
	<td><div align="center"><span class="style2"><%=cks_dt%></span></div></td>
	<%
	if (!fltno.equals("0")){
		if("Y".equals(hmc.doCheck(str_dt_tpe_c, fltno, sect))){
			myst = "style3";
		}
		else{
			myst = "style2";
		}
		//myst = hmc.doCheck(str_dt_tpe_c, fltno, sect);
	}
	else{
		myst = "style2";
	}
	%>
    <td><div align="center"><a href="DailyCrew.jsp?fltdate=<%=fltdate%>&fltno=<%=fltno%>&sector=<%=sect%>&end_dt_utc=<%=end_dt_utc%>&str_dt_tpe_c=<%=str_dt_tpe_c%>&end_dt_tpe=<%=end_dt_tpe%>&fleet=<%=fleet%>&str_dt_loc=<%=str_dt_loc%>&end_dt_loc=<%=end_dt_loc%>&showfltno=<%=showfltno%>&tsa_dt=<%=tsa_dt%>" target="_self" class="style2"><%=showfltno%></a>
<%
if(fltno.length()==4)
{//display GD link when is real flight
%>
	<a href="../../GD/gdList_noDB2.jsp?sel_year=<%=str_dt_loc_full.substring(0,4)%>&sel_mon=<%=str_dt_loc_full.substring(5,7)%>&sel_dd=<%=str_dt_loc_full.substring(8,10)%>&arln=CI&fltno=<%=fltno%>&dpt=<%=sect.substring(0,3)%>&ftime=<%=str_dt_loc_full.substring(11)%>" target="_blank" class="style2"><img src="../../images/ed3.gif" alt="General GD" width="22" height="22" border="0"></a>
	<a href="../../GD/gdList_J_noDB2.jsp?sel_year=<%=str_dt_loc_full.substring(0,4)%>&sel_mon=<%=str_dt_loc_full.substring(5,7)%>&sel_dd=<%=str_dt_loc_full.substring(8,10)%>&arln=CI&fltno=<%=fltno%>&dpt=<%=sect.substring(0,3)%>&ftime=<%=str_dt_loc_full.substring(11)%>" target="_blank" class="style2"><img src="../../images/loglist.gif" alt="Japan GD" width="22" height="22" border="0"></a>	
<%
}
%>
	</div></td>
    <td><div align="center"><span class="style2"><%=fleet%></span></div></td>
    <td><div align="center"><span class="<%=myst%>"><%=sect%></span></div></td>
	<td><div align="center"><span class="style2"><%=str_dt_loc %></span></div></td>
    <td><div align="center"><span class="style2"><%=end_dt_loc%></span></div></td>
	<td><div align="center"><span class="style2"><%=end_dt_utc %></span></div></td>
  </tr>
  <%
  		}
	}
  
  %>
</table>
<br>

<table width="90%"  border="0">
  <tr>
    <td class="txtblue">Total Filght:<%=Count%> </td>
    <td class="txtxred">*Sector為紅色時，則代表該航班CA均為HMC。</td>
  </tr>
</table>

</p>
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
	try{if(myResultSet != null) myResultSet.close();}catch(Exception e){}
	try{if(rs != null) rs.close();}catch(Exception e){}
	try{if(stmt != null) stmt.close();}catch(Exception e){}
	try{if(stmt2 != null) stmt2.close();}catch(Exception e){}
	try{if(conn != null) conn.close();}catch(Exception e){}
	try{if(conn2 != null) conn2.close();}catch(Exception e){}
}

%>


<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,fz.daily.*" errorPage="" %>
<jsp:useBean id="unicodeStringParser" class="fz.UnicodeStringParser" />
<%
response.setContentType("text/html; charset=big5");
String sGetUsr = request.getParameter("userid");

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Trip List</title>
<link href="../../menu.css" rel="stylesheet" type="text/css">
</head>
<body>
<div align="center">
  <%
String tripno = request.getParameter("tripno"); 
String flag = request.getParameter("flag"); 

String fdate = null;//format: yyyy/mm/dd

if( null != request.getParameter("fdate") | 
	!"".equals(request.getParameter("fdate"))){
	fdate= request.getParameter("fdate");	
}
String chk = flag;
String butlabel = null;
if (flag.equals("L")){ //local time
	butlabel = "Change TPE Time";
	chk = "T";
}
else{  //TPE time
	butlabel = "Change LOC Time";
	chk = "L";
}

Driver dbDriver = null;
Connection conn 	= null;
Statement stmt 		= null;
ResultSet myResultSet = null;
String sql 			= null;
String dpt = null;
String strdt = null;
String arv = null;
String enddt = null;
String strdtgmt = null;
String enddtgmt = null;
String empno = null;
String sern = null;
String cname = null;
String rank = null;
String spcode = null;
String fltno = null;
String fleet_cd = null;
int fmm = 0;
String flt_time = null;
String tempBig5PreferredName =null;
String big5CName =  null;
String rank_cd = null;
int Count = 0;
String bgColor = null;

ConnDB cn = new ConnDB();

try{
	cn.setAOCIPRODCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	
    stmt = conn.createStatement(); 
	
	sql = "select dps.act_port_a dpt, dps.act_str_dt_tm_gmt," +
	"to_char(dps.str_dt_tm_loc,'yyyy-mm-dd HH24:MI') strdt, " +
	"dps.act_port_b arv, " +
	"to_char(dps.end_dt_tm_loc,'yyyy-mm-dd HH24:MI') enddt, " +
	"to_char(dps.act_str_dt_tm_gmt,'yyyy-mm-dd HH24:MI') strdtgmt, " +
	"to_char(dps.act_end_dt_tm_gmt,'yyyy-mm-dd HH24:MI') enddtgmt, " +
	"dps.flt_num fltno,dps.fleet_cd, " + 
	"nvl(dps.duration_mins,0) fmm,dps.duty_cd " + 
	"from roster_v r, duty_prd_seg_v dps " +
	"where r.series_num = dps.series_num  " +
	//"dps.fd_ind='N' and
	//"and (dps.duty_cd='FLY' or dps.duty_cd='LO' or dps.duty_cd='TVL')   " +
	"and r.delete_ind='N' and r.series_num=" + tripno +
	" group by dps.act_str_dt_tm_gmt,dps.str_dt_tm_loc,dps.act_port_a,dps.end_dt_tm_loc,dps.act_port_b,dps.act_str_dt_tm_gmt,"
	+"dps.act_end_dt_tm_gmt,dps.flt_num,dps.fleet_cd,dps.duration_mins,dps.duty_cd";
	myResultSet = stmt.executeQuery(sql);
	//out.print(sql);
%> 
  <span class="txtblue">TripNo : <%=tripno%>&nbsp;&nbsp;&nbsp;</span>
  
</div>
<table width="90%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>&nbsp;</td>
    <td><div align="right"><a href="javascript:window.print()"><img src="../../images/print.gif" width="17" height="15" border="0" alt="列印"></a></div></td>
  </tr>
</table>
<table width="90%"  border="1" align="center" cellpadding="0" cellspacing="0" class="tablebody">
  <tr class="tablehead" style="background-color:#483D8B; ">
  	<td width="7%">DutyCd</td>
    <td width="6%">DPT</td>
<%
if(flag.equals("L")){ //local time
%>	
    <td width="6%">Fleet_Cd</td>
    <td width="22%">Start DT LOC</td>
    <%
}
else{ //TPE time
%>
    <td width="6%">Fleet_Cd</td>
    <td width="16%">Start DT TPE</td>
<%
}
%>
	<td width="6%">ARV</td>
<%
if(flag.equals("L")){ //local time
%>	
    <td width="15%">End DT LOC</td>
<%
}
else{ //TPE time
%>
    <td width="15%">End DT TPE</td>
<%
}
%>
	<td width="7%">T HR</td>
  </tr>
  <%
  	Count = 0;
  	if(myResultSet != null){
		while(myResultSet.next()){
		Count++;
			dpt = myResultSet.getString("dpt");
			strdt = myResultSet.getString("strdt");
		 	arv = myResultSet.getString("arv");
			enddt = myResultSet.getString("enddt");
			strdtgmt = myResultSet.getString("strdtgmt");
			enddtgmt = myResultSet.getString("enddtgmt");
			fltno = myResultSet.getString("fltno");
			fmm = myResultSet.getInt("fmm");
			flt_time = String.valueOf(fmm/60) + ":" + String.valueOf(fmm%60);
			fleet_cd = myResultSet.getString("fleet_cd");

	if (Count%2 == 1)
			{
				bgColor = "#FFFFFF";
			}
			else
			{
				bgColor = "#E6E6FA";
			}
			
  %>
  <tr  bgcolor="<%=bgColor%>" class="txtblue">
  	<td><%	
	
	if("FLY".equals(myResultSet.getString("duty_cd")) 
		||"LO".equals(myResultSet.getString("duty_cd"))
		||"TVL".equals(myResultSet.getString("duty_cd"))
	){
		
		out.print(fltno);
		if("TVL".equals(myResultSet.getString("duty_cd"))){
		out.print("<br><span style=color:red>TVL</span>");
		}
	}else{		
		out.print(myResultSet.getString("duty_cd"));
		
	}	
	%></td>
    <td><%=dpt%></td>
<%
if(flag.equals("L")){ //local time
%>	
    <td><%=fleet_cd%>
	</td>
    <td><%=strdt%></td>
    <%
}
else{ //TPE time
%>
    <td><%=fleet_cd%>	

</td>

    <td><%=strdtgmt%></td>
<%
}
%>
	<td><%=arv%></td>
<%
if(flag.equals("L")){ //local time
%>	
    <td><%=enddt%></td>
<%
}
else{ //TPE time
%>
    <td><%=enddtgmt%></td>
<%
}
%>
	<td><%=flt_time%></td>
  </tr>
  <%
  		}
	}
  %>
</table>
<%
if(fdate  == null){
	sql = "select r.staff_num empno,'&nbsp;' rank_cd, " +
	"c.seniority_code sern, " +
	"c.preferred_name cname, " +
	"r.acting_rank rank, " +
	"r.special_indicator spcode " +
	"from roster_v r, crew_v c, duty_prd_seg_v dps " +
	"where r.staff_num=c.staff_num and r.series_num = dps.series_num and " +
	//"dps.fd_ind='N' and 
	"r.delete_ind='N' and " + 
	"r.series_num='" + tripno +"' "+
  //  " AND (c.eff_dt <= To_Date('"+fltdate+" 0000','yyyy/mm/dd hh24mi') and  ( c.exp_dt IS NULL OR c.exp_dt > To_Date('"+fltdate+" 0000','yyyy/mm/dd hh24mi')) )"+
	" group by r.staff_num,c.seniority_code,c.preferred_name,r.acting_rank,r.special_indicator " +
	"order by  empno,rank";  //fd_ind = 'N' 後艙
	
}else{
//以fdate 設定rank 
		sql = "select r.staff_num empno, " +
	"c.seniority_code sern, " +
	"c.preferred_name cname, " +
	"r.acting_rank rank, " +
	"r.special_indicator spcode,cv.rank_cd " +
	"from roster_v r, crew_v c, duty_prd_seg_v dps,crew_rank_v cv " +
	"where r.staff_num=c.staff_num and r.series_num = dps.series_num AND r.staff_num=cv.staff_num  " +
	//"and dps.fd_ind='N' 
	"and r.delete_ind='N' and " + 
	"r.series_num='" + tripno +"' "+
    " AND (cv.eff_dt <= To_Date('"+fdate+" 0000','yyyy/mm/dd hh24mi') and  ( cv.exp_dt IS NULL OR cv.exp_dt >= To_Date('"+fdate+" 0000','yyyy/mm/dd hh24mi')) )"+
	" group by r.staff_num,c.seniority_code,c.preferred_name,r.acting_rank,r.special_indicator,cv.rank_cd " +
	"order by  empno,rank";

	
}

 	myResultSet = stmt.executeQuery(sql);
%>
<br>
<table width="90%"  border="1" align="center" cellpadding="0" cellspacing="0" class="tablebody">
  <tr class="tablehead">
  	<td width="12%">Row</td>
    <td width="19%">EmpNo</td>
    <td width="14%">SerNo</td>
	<td width="22%">Name</td>
    <td width="10%">Qual</td>
    <td width="10%">Acting</td>
    <td width="13%">SPcode</td>
  </tr>
  <%
  	Count = 0;
  	if(myResultSet != null){
		while(myResultSet.next()){
			empno = myResultSet.getString("empno");
			sern = myResultSet.getString("sern");
		 	rank = myResultSet.getString("rank");
			spcode = myResultSet.getString("spcode");
		 	cname = myResultSet.getString("cname");
			tempBig5PreferredName =  unicodeStringParser.removeExtraEscape(cname);
			big5CName = new String(tempBig5PreferredName.getBytes(), "Big5"); 
			rank_cd = myResultSet.getString("rank_cd");
			Count ++;
			
			if (Count%2 == 1)
			{
				bgColor = "#FFFFFF";
			}
			else
			{
				bgColor = "#D1EFFE";
			}
  %>
  <tr bgcolor="<%=bgColor%>" class="txtblue">
  	<td><%=Count%></td>
    <td><%=empno%></td>
    <td><%=sern%></td>
	<td><div align="left"><%=big5CName%></div></td>
    <td><%=rank_cd%></td>
    <td><%=rank%></td>
    <td>&nbsp;<%=spcode%></td>
  </tr>
  <%
  		}
	}
  %>
</table>
<%
	if(Count ==0){
		try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
		try{if(stmt != null) stmt.close();}catch(SQLException e){}
		try{if(conn != null) conn.close();}catch(SQLException e){}
	
	%>
	  <jsp:forward page="../showmessage.jsp"> 
      <jsp:param name="messagestring" value="<p  style='font-size:10pt;color:red'>目前尚無資料<br>No Data!!</p>" />
      <jsp:param name="messagelink" value="<p  style='font-size:10pt;color:#0066CC'>Back</p>" />
      <jsp:param name="linkto" value="javascript:history.back(-1)" />
	  </jsp:forward>

	
	<%
	
	}

%>
<p align="center">
  <input type="button" name="Submit" value="Close" onClick="self.close()">
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
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
	
}
%>
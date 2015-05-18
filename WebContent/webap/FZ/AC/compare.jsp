<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*,java.util.*,swap3ac.*,ci.db.*"%>
<%


response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

//String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
String sGetUsr= request.getParameter("aEmpno");


if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
  %>
<jsp:forward page="sendredirect.jsp" />
<%
} 
//String empno = request.getParameter("empno").trim();
String empno = request.getParameter("rEmpno");
String year = request.getParameter("year");
String month = request.getParameter("month");
String mymm = year+"/"+month;

//取得該月第一天是星期幾
GregorianCalendar calendar =	new GregorianCalendar(Integer.parseInt(year),Integer.parseInt(month)-1,1);
int FirstDayOfWeek = calendar.get(GregorianCalendar.DAY_OF_WEEK)-1;
//out.println("FirstDayOfWeek"+FirstDayOfWeek);
String[] week = {"SUN","MON","TUE","WED","THU","FRI","SAT"};

int dd = 0;


boolean status = true;
String errMsg  = "";
String aCr = " ";
String rCr = " ";


//取得兩人資本資料
fzac.CrewInfo c = new fzac.CrewInfo(sGetUsr);
fzac.CrewInfoObj objA = c.getCrewInfo();
if( !c.isHasData() ){
	errMsg += sGetUsr+"非有效之組員員工號<br>";
}

c = new fzac.CrewInfo(empno);
fzac.CrewInfoObj objR = c.getCrewInfo();
if( !c.isHasData() ){
	errMsg += empno+"非有效之組員員工號<br>";
}


//取得CR
fzac.CrewMonthCR cr = new fzac.CrewMonthCR(year,month);
try{
	cr.initData(sGetUsr);
	if(null != cr.getCr()){
		aCr = cr.getCr();		
	}

	cr.initData(empno);
	if(null != cr.getCr()){
		rCr = cr.getCr();		
	}

	
}catch (SQLException e) {
	errMsg = e.toString();
}catch(Exception e){
	errMsg = e.toString();
}



if(!"".equals(errMsg )){
	out.print(errMsg);
}else{

ArrayList fdd = new ArrayList();
ArrayList fltno = new ArrayList();
ArrayList dpt = new ArrayList();
ArrayList arv = new ArrayList();

ArrayList rfdd = new ArrayList();
ArrayList rfltno = new ArrayList();
ArrayList rdpt = new ArrayList();
ArrayList rarv = new ArrayList();

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
String sql = null;
ConnDB cn = new ConnDB();
Driver dbDriver = null;
String bcolor="";

try {

	cn.setAOCIPRODCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);

//取得比對者之班表
	pstmt = conn.prepareStatement("select dps.act_str_dt_tm_gmt a,to_char(dps.act_str_dt_tm_gmt,'dd') d,r.staff_num," 
		+"To_Char(dps.str_dt_tm_loc,'yyyy/mm/dd') fdate, "	
		+"(CASE WHEN dps.flt_num='0' then dps.duty_cd ELSE dps.flt_num end ) duty_cd,"
		+"dps.act_port_a dpt,dps.act_port_b arv "	
		+"from duty_prd_seg_v dps, roster_v r "
		+"where dps.series_num=r.series_num "
		+"and dps.delete_ind = 'N' AND  r.delete_ind='N' "
		+"and r.staff_num =? AND dps.act_str_dt_tm_gmt BETWEEN  to_date(?,'yyyymmdd hh24:mi') "
		+"AND last_day(To_Date(?,'yyyymmdd hh24:mi')) "
		+"UNION ALL SELECT r.str_dt a,to_char(r.str_dt,'dd') d,r.staff_num,To_Char(str_dt,'yyyy/mm/dd') fdate,"
		+"duty_cd,' ' dpt,' ' arv "    
		+"FROM roster_v r WHERE r.staff_num=? AND r.series_num=0 AND r.delete_ind='N' "
		+"AND str_dt BETWEEN To_Date(?,'yyyymmdd hh24mi') "
		+"AND last_day(To_Date(?,'yyyymmdd hh24mi'))  order by a");
	
	for(int i=1;i<7;i=i+3){
		pstmt.setString(i,sGetUsr);
		pstmt.setString(i+1,year+month+"01 0000");
		pstmt.setString(i+2,year+month+"01 2359");		
	}
	rs = pstmt.executeQuery();
	while(rs.next()){

		fdd.add(rs.getString("d"));
		fltno.add(rs.getString("duty_cd"));		
		dpt.add(rs.getString("dpt"));
		arv.add(rs.getString("arv"));

	}
	pstmt.close();


//取得被對者之班表	
	pstmt = conn.prepareStatement("select dps.act_str_dt_tm_gmt a,to_char(dps.act_str_dt_tm_gmt,'dd') d,r.staff_num," 
		+"To_Char(dps.str_dt_tm_loc,'yyyy/mm/dd') fdate, "	
		+"(CASE WHEN dps.flt_num='0' then dps.duty_cd ELSE dps.flt_num end ) duty_cd,"
		+"dps.act_port_a dpt,dps.act_port_b arv "	
		+"from duty_prd_seg_v dps, roster_v r "
		+"where dps.series_num=r.series_num "
		+"and dps.delete_ind = 'N' AND  r.delete_ind='N' "
		+"and r.staff_num =? AND dps.act_str_dt_tm_gmt BETWEEN  to_date(?,'yyyymmdd hh24:mi') "
		+"AND last_day(To_Date(?,'yyyymmdd hh24:mi')) "
		+"UNION ALL SELECT r.str_dt a,to_char(r.str_dt,'dd') d,r.staff_num,To_Char(str_dt,'yyyy/mm/dd') fdate,"
		+"duty_cd,' ' dpt,' ' arv "    
		+"FROM roster_v r WHERE r.staff_num=? AND r.series_num=0 AND r.delete_ind='N' "
		+"AND str_dt BETWEEN To_Date(?,'yyyymmdd hh24mi') "
		+"AND last_day(To_Date(?,'yyyymmdd hh24mi'))  order by a");
		
	for(int i=1;i<7;i=i+3){
		pstmt.setString(i,empno);
		pstmt.setString(i+1,year+month+"01 0000");
		pstmt.setString(i+2,year+month+"01 2359");		
	}
	rs = pstmt.executeQuery();

	while(rs.next()){
		rfdd.add(rs.getString("d"));
		rfltno.add(rs.getString("duty_cd"));
		rdpt.add(rs.getString("dpt"));
		rarv.add(rs.getString("arv"));

	}
	pstmt.close();
	
//取得該月最後一天
	pstmt = conn.prepareStatement("select to_char(last_day(to_date(?,'yymm')), 'dd') dd from dual");
	pstmt.setString(1,year+month);
	
	rs =pstmt.executeQuery();
	while(rs.next()){
		dd = rs.getInt("dd");
	}
	rs.close();
	pstmt.close();
	conn.close();
	
	//若有一人無班表
	/*
	if(rfdd.size() == 0){
		for(int i=0;i<dd;i++){
			rfdd.add("");
			rfltno.add("");
			rdpt.add("");
			rarv.add("");
		}
	}
	if(fdd.size() == 0){
		for(int i=0;i<dd;i++){
			fdd.add("");
			fltno.add("");
			dpt.add("");
			arv.add("");
		}
	}
	*/
	status = true;
} catch (SQLException e) {
	errMsg = e.toString();

} catch (Exception e) {
	errMsg = e.toString();
} finally {

	if ( rs != null ) try {
		rs.close();
	} catch (SQLException e) {}
	if ( pstmt != null ) try {
		pstmt.close();
	} catch (SQLException e) {}
	if ( conn != null ) try {
		conn.close();
	} catch (SQLException e) {}

}



//班表內容

StringBuffer sb = new StringBuffer();
for (int i = 1; i < dd + 1; i++) {

	
	if (week[(i-1 + FirstDayOfWeek) % 7].equals("SUN")
			|| week[(i-1 + FirstDayOfWeek) % 7].equals("SAT")) {
		bcolor = "rgb(255,231,247)";
	}else{
		bcolor = "#FFFFFF";
	}

	sb.append("<tr bgcolor=\"" + bcolor + "\">");
	sb.append("<td height=\"20\" align=\"center\"><b> ");
	if(i <10){
		sb.append("&nbsp;");
	}
	
	sb.append(i+"&nbsp;(" + week[(i - 1 + FirstDayOfWeek) % 7]+ ")");
	sb.append("</b></td>");
	sb.append("<td>");


String str = "";

	for (int idxA = 0; idxA < fdd.size(); idxA++) {
	
		if (Integer.parseInt((String) fdd.get(idxA)) == i) {
			if ("".equals(str)) {
				str = fltno.get(idxA) + "&nbsp;" + dpt.get(idxA) + arv.get(idxA);				
			} else {
				str +=",&nbsp;"+fltno.get(idxA) + "&nbsp;" + dpt.get(idxA) + arv.get(idxA);
			}

		}
		


	}
	sb.append(str);

	sb.append("</td>");

	sb.append("<td>");
	
 str = "&nbsp;";
	for (int idxA = 0; idxA < rfdd.size(); idxA++) {
		
		if (Integer.parseInt((String) rfdd.get(idxA)) == i) {

			if ("&nbsp;".equals(str)) {
				str = rfltno.get(idxA) + "&nbsp;" + rdpt.get(idxA) + rarv.get(idxA);

			} else {
				str =str + ",&nbsp;" + rfltno.get(idxA) + "&nbsp;" + rdpt.get(idxA) + rarv.get(idxA);
			}

		}
		
		

	}
	sb.append(str);

	sb.append("</td>");
	sb.append("</tr>\n");

}


%>
<html>
<head>
<title>Schedule Compare</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">

<link rel="stylesheet" href="../errStyle.css" type="text/css">
<style>
body{
	font-family:Verdana, Arial, Helvetica, sans-serif;
	font-size:10pt;
}
.txtxred{
	color:#FF0000;
}
.tablehead2{
	background-color:#831F53;
	color:#FFFFFF;
	font-weight:bold;
	text-align:center;
}

td{
	padding-left:2pt;
	text-align:left;
}

	
</style>
</head>

<body >
<%

if(!status){
	out.print("ERROR:"+errMsg);
}else{
%>
<table width="80%" border="0" cellpadding="0" cellspacing="0" align="center">
  <tr>
        <td colspan="3" >
          <div class="txtxred"><strong>  The following shedule is for reference only. <br>
            For official up-to-date schedule information, 
            please contact Scheduling Department. <br>
    下列班表僅供參考，請向組員派遣部門確認個人正式班表任務。  </strong></div></td>
  </tr>
  <tr>
    <td width="14%">&nbsp;</td>
    <td width="80%">      <div align="center"><b><%=year+"/"+month%></b></div>
</td>
    <td width="6%">
      <div align="right"><a href="javascript:window.print()"><img src="../images/print.gif" width="17" height="15" border="0" alt="列印"></a> </div>
    </td>
  </tr>
</table>
 

<table width="80%" border="1" cellspacing="0" cellpadding="0" align="center" style="border-collapse:collapse;empty-cells:show; " >
  <tr class="tablehead2" id="r"> 
    <td width="10%" >
      <div align="center">Date</div>
    </td>
    <td width="45%" > 
      <div align="center"><%=objA.getEmpno()+"&nbsp;"+objA.getSern()+"&nbsp;"+objA.getCname()+" CR:"+aCr%></div>
    </td>
    <td width="45%"> 
      <div align="center"><%=objR.getEmpno()+"&nbsp;"+objR.getSern()+"&nbsp;"+objR.getCname()+" CR:"+rCr%></div>
    </td>
  </tr>
<%=sb.toString()%>
</table>
  <%
}
%>
</body>
</html>
<%
}
%>

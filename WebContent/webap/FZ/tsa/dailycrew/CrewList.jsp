2014<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,fz.daily.*,java.util.ArrayList" errorPage="" %>
<%!
public class CrewListOfDailyCheckObj {
	private String no_Show;
	private String cr;
	private String empno;
	private String rank;
	private String acting_Rank;
	private String ACM;
	private String cName;
	private String GROUPS;
	private String sern;
	private String tripNo;
	private String spcode;
	private String phone;
	private boolean isCheckIn = false;
	private String rptLoc= "";
	private String chnVisaExpDt = "";//CS40 2009-5-18 SR9232
	public String getNo_Show() {
		return no_Show;
	}
	
	public void setNo_Show(String no_Show) {
		this.no_Show = no_Show;
	}
	public String getCr() {
		return cr;
	}
	public void setCr(String cr) {
		this.cr = cr;
	}
	public String getEmpno() {
		return empno;
	}
	public void setEmpno(String empno) {
		this.empno = empno;
	}
	public String getRank() {
		return rank;
	}
	public void setRank(String rank) {
		this.rank = rank;
	}
	public String getActing_Rank() {
		return acting_Rank;
	}
	public void setActing_Rank(String acting_Rank) {
		this.acting_Rank = acting_Rank;
	}
	public String getACM() {
		return ACM;
	}
	public void setACM(String acm) {
		ACM = acm;
	}
	public String getCName() {
		return cName;
	}
	public void setCName(String name) {
		cName = name;
	}
	public String getGROUPS() {
		return GROUPS;
	}
	public void setGROUPS(String groups) {
		GROUPS = groups;
	}
	public String getSern() {
		return sern;
	}
	public void setSern(String sern) {
		this.sern = sern;
	}
	public String getTripNo() {
		return tripNo;
	}
	public void setTripNo(String tripNo) {
		this.tripNo = tripNo;
	}
	public String getSpcode() {
		return spcode;
	}
	public void setSpcode(String spcode) {
		this.spcode = spcode;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public boolean isCheckIn() {
		return isCheckIn;
	}
	public void setCheckIn(boolean isCheckIn) {
		this.isCheckIn = isCheckIn;
	}
	public String getRptLoc() {
		return rptLoc;
	}
	public void setRptLoc(String rptLoc) {
		this.rptLoc = rptLoc;
	}
	
	public String getChnVisaExpDt() { //CS40 2009-5-18 SR9232
		return chnVisaExpDt;
	}
	
	public void setChnVisaExpDt(String chnVisaExpDt) { //CS40 2009-5-18 SR9232
		this.chnVisaExpDt = chnVisaExpDt;
	}
}

%>

<%
response.setContentType("text/html; charset=big5");

String sGetUsr = request.getParameter("userid");

if (sGetUsr == null){
	sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login

	if (session.isNew() || sGetUsr == null) 
	{		//check user session start first
	 response.sendRedirect("../sendredirect.jsp");
	} 
}

//寫入log
fz.writeLog wl = new fz.writeLog();
wl.updLog(sGetUsr, request.getRemoteAddr(),request.getRemoteHost(), "CII015");

String fltdate= request.getParameter("fltdate"); //schedule datetime yyyy/mm/ddHH24MI
String fltno = request.getParameter("fltno");  //0681
String Rsector = request.getParameter("sector"); //TPEHKG
String str_dt_tpe = request.getParameter("str_dt_tpe");
String end_dt_tpe = request.getParameter("end_dt_tpe");
String fleet = request.getParameter("fleet");
String str_dt_loc = request.getParameter("str_dt_loc");
String end_dt_loc = request.getParameter("end_dt_loc");
String showfltno = request.getParameter("showfltno");
String status = request.getParameter("status"); //add by cs55 2006/10/31
String totalOpen = null;	//Open人數
if(request.getParameter("totalOpen") != null 
	&&!"".equals(request.getParameter("totalOpen")) ){
	totalOpen= request.getParameter("totalOpen");
}

String dutycdCondition="";
if(request.getParameter("dutycd") != null && 
	!"".equals(request.getParameter("dutycd") )
	){
if( "TVL".equals(request.getParameter("dutycd"))  | 
 "FLY".equals(request.getParameter("dutycd")) ){
	dutycdCondition = " and dps.duty_cd='"+request.getParameter("dutycd")+"' ";
	}
}
String mailfdate = fltdate.substring(0,10).replace("/", "");
String ftime = fltdate.substring(10);
out.println(mailfdate +"===" + ftime);
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
Driver dbDriver = null;
ConnDB cn = new ConnDB();
String errMsg = "";
boolean sqlStatus = false;
ArrayList al = null;
try {

 cn.setAOCIPRODCP();
 dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
 conn = dbDriver.connect(cn.getConnURL(), null);


StringBuffer sb = new StringBuffer();

sb.append("select (CASE WHEN dp.no_show='N' THEN 'Y' ELSE 'N' END ) chkin,dp.no_show,");
sb.append("r.staff_num empno, cv.rank_cd rank, r.acting_rank,");
sb.append("(CASE WHEN dps.duty_cd='TVL' THEN 'TVL' ELSE '' END )   ACM ,");
sb.append("c.preferred_name cname,  c.section_number grps,");
sb.append("c.seniority_code sern,  r.series_num tripno, ");
sb.append("r.special_indicator spcode,  ct.call_phone_num phone, ");
sb.append("NVL(to_char(v.exp_dt, 'yyyy/mm/dd'),'NULL') chn_visa_exp_dt "); //CS40 2009-5-18 SR9232
//sb.append("'' chn_visa_exp_dt "); //CS40 2009-5-18 SR9232
sb.append("from roster_v r, duty_prd_seg_v dps, crew_v c,  ");

sb.append("crew_contact_v ct,crew_rank_v cv,crew_dops_v dp, ");
sb.append("crew_visa_v v "); //CS40 2009-5-18 SR9232
sb.append("where r.staff_num=c.staff_num ");
sb.append("AND r.staff_num=ct.staff_num(+) ");
sb.append("AND r.staff_num=cv.staff_num ");
sb.append("AND r.staff_num = dp.staff_num (+) ");
sb.append("AND r.series_num = dps.series_num ");
sb.append("and c.staff_num = v.staff_num(+) "); //CS40 2009-5-18 SR9232
sb.append("AND dps.fd_ind='N' and r.delete_ind='N' ");
//sb.append("and dps.duty_cd='FLY' ");
sb.append(dutycdCondition);

sb.append("and dps.port_a||dps.port_b=? ");
sb.append("and dps.act_str_dt_tm_gmt BETWEEN  to_date(?,'yyyy/mm/ddhh24mi')-2 ");
sb.append("AND to_date(?,'yyyy/mm/ddhh24mi')+2 ");
sb.append("and dps.str_dt_tm_gmt = to_date(?,'yyyy/mm/ddhh24mi') ");
sb.append("and dps.flt_num =? ");
sb.append("AND (cv.eff_dt <= To_Date(?,'yyyy/mm/dd hh24mi') ");
sb.append("and  ( cv.exp_dt IS NULL OR cv.exp_dt >= To_Date(?,'yyyy/mm/dd hh24mi')) ) ");
//sb.append("AND dps.arln_cd = dp.aln_cd ");
sb.append("and dp.dep_arp_cd(+) =? ");
sb.append("AND dp.flt_dt_tm(+)  ");
sb.append(" = to_date(?,'yyyy/mm/dd hh24mi') ");
/*
BETWEEN to_date(?,'yyyy/mm/dd hh24mi') ");
sb.append("AND to_date(?,'yyyy/mm/dd hh24mi') ");
*/
sb.append("and dp.flt_num(+) =lpad(?,4,'0')  ");
sb.append("and v.visa_type(+) = 'CHN' "); //CS40 2009-5-18 SR9232
sb.append("order by decode(cv.rank_cd,'PR','1','FC','2',r.staff_num) ");

pstmt = conn.prepareStatement(sb.toString());
pstmt.setString(1, Rsector);
pstmt.setString(2, fltdate);
pstmt.setString(3, fltdate);
pstmt.setString(4, fltdate);
pstmt.setString(5, fltno);
pstmt.setString(6, fltdate.substring(0, 10) + " 0000");
pstmt.setString(7, fltdate.substring(0, 10) + " 0000");
pstmt.setString(8, Rsector.substring(0, 3));
pstmt.setString(9, fltdate);
//pstmt.setString(9, fltdate.substring(0, 10) + " 0000");
//pstmt.setString(10, fltdate.substring(0, 10) + " 2359");
pstmt.setString(10, fltno);

rs = pstmt.executeQuery();
//取得 Crew List 資料
while (rs.next()) {
	if (al == null)
		al = new ArrayList();

	CrewListOfDailyCheckObj obj = new CrewListOfDailyCheckObj();
	obj.setACM(rs.getString("acm"));
	obj.setActing_Rank(rs.getString("acting_Rank"));
	if ("Y".equals(rs.getString("chkin"))) {
		obj.setCheckIn(true);
	}
	obj.setCName(ci.tool.UnicodeStringParser.removeExtraEscape(rs
			.getString("cname")));
	obj.setEmpno(rs.getString("empno"));
	obj.setGROUPS(rs.getString("grps"));
	obj.setNo_Show(rs.getString("no_Show"));
	obj.setPhone(rs.getString("phone"));
	obj.setRank(rs.getString("rank"));
	obj.setSern(rs.getString("sern"));
	obj.setSpcode(rs.getString("spcode"));
	obj.setTripNo(rs.getString("tripNo"));
	obj.setChnVisaExpDt(rs.getString("chn_visa_exp_dt"));//CS40 2009-5-18 SR9232
	al.add(obj);

}

rs.close();
pstmt.close();

if (al != null) {
//取得 Credit Hour

	for (int i = 0; i < al.size(); i++) {
		CrewListOfDailyCheckObj obj = (CrewListOfDailyCheckObj) al
				.get(i);

		pstmt = conn
				.prepareStatement(" SELECT staff_num,sum(non_std_fly_hours) totalcr "
						+ "FROM crew_cum_hr_cc_v c   WHERE staff_num = ? AND  c.cal_dt  BETWEEN "
						+ "To_Date(?,'yyyy/mmdd hh24mi')  AND Last_Day(To_Date(?,'yyyy/mmdd hh24mi')) GROUP BY  staff_num");

		pstmt.setString(1, obj.getEmpno());
		pstmt.setString(2, fltdate.substring(0, 7) + "01 0000");
		pstmt.setString(3, fltdate.substring(0, 7) + "01 2359");
		rs = pstmt.executeQuery();
		if (rs.next()) {
			obj.setCr(ci.tool.TimeUtil.minToHHMM(rs
					.getString("totalcr")));
		}
		rs.close();
		pstmt.close();

	}

	conn.close();

//取得 組員報到地點
	cn.setORP3EGUserCP();
	conn = dbDriver.connect(cn.getConnURL(), null);

	for (int i = 0; i < al.size(); i++) {
		CrewListOfDailyCheckObj obj = (CrewListOfDailyCheckObj) al
				.get(i);

		pstmt = conn
				.prepareStatement("select rptloc from egdb.egtchkin "
						+ "where empno=? "
						+ "AND sdate <= to_date(?,'yyyy/mm/dd') "
						+ "and edate >= to_date(?,'yyyy/mm/dd')");

		pstmt.setString(1, obj.getEmpno());
		pstmt.setString(2, fltdate.substring(0, 10));
		pstmt.setString(3, fltdate.substring(0, 10));
		rs = pstmt.executeQuery();
		if (rs.next()) {
			if (!"TSA".equals(rs.getString("rptloc"))) {
				obj.setRptLoc(rs.getString("rptloc"));
			}

		}
		rs.close();
		pstmt.close();

	}
	conn.close();
	sqlStatus = true;
	} 
}catch (Exception e) {
	sqlStatus = false;
	errMsg +=e.getMessage();
} finally {
	if (rs != null)
		try {
			rs.close();
		} catch (SQLException e) {}
	if (pstmt != null)
		try {
			pstmt.close();
		} catch (SQLException e) {}
	if (conn != null) {
		try {
			conn.close();
		} catch (SQLException e) {

		}
		conn = null;
	}
}



%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Crew</title>
<link href="../../menu.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="../../kbd.css">
<link rel="stylesheet" type="text/css" href="../../errStyle.css">
<script src="../../js/subWindow.js"></script>
<style type="text/css">
<!--
.style1 {
	color: #000099;
	font-weight: bold;
}
-->
</style>
</head>
<body>
<%

if(!sqlStatus){
%>
<div class="errStyle1"><%=errMsg%></div>
<%
	
}else if(al == null){
%>
<div class="errStyle1">NO DATA FOUND!!</div>
<%
}else{



%>


<table width="90%"  border="1" align="center" cellpadding="0" cellspacing="0" class="tablebody" style="empty-cells:show;border-collapse:collapse;border-color:#666666;">
<caption class="txttitletop">Crew List
<div align="right"><a href="javascript:window.print()"><img src="../../images/print.gif" width="17" height="15" border="0" alt="列印"></a>
<a href="../../PRAC_new/mail/mail.jsp?sect=<%=Rsector%>&fdate=<%=mailfdate%>&ftime=<%=ftime%>&fltno=<%=showfltno%>&user=<%=sGetUsr%>&rid=X">
<img src="../../images/mail.gif" width="17" height="15" border="0" alt="mail"></a></div>
</td>
</caption>
  <tr class="tablehead3">
    <td>Start LOC</td>
    <td>Fltno</td>
	<td>Fleet</td>
    <td>Sector</td>
    <td>End LOC</td>
  </tr>
<tr class="txtred" align="center">
    <td><%=str_dt_loc%></td>
    <td><%=showfltno%></td>
    <td><%=fleet%></td>
    <td><%=Rsector%></td>
    <td><%=end_dt_loc%></td>
</tr>
</table>

<table width="90%"  border="1" align="center" cellpadding="0" cellspacing="0" class="tablebody" style="empty-cells:show;border-collapse:collapse;border-color:#666666;margin-top:2em; ">

 <%
  //add by cs55 2006/10/31
  if("d".equals(status.substring(0,1))){
  %>
    <caption class="txtxred" align="center">*姓名背景為紅色組員代表AirCrews Check In系統未報到者.
    </caption>
  <%
  }
  
  %>

<tr class="tablehead">
	<td width="6%" height="22">Row</td>
    <td width="6%">Remark</td>
    <td width="7%">EmpNo</td>
    <td width="18%"><div align="left">Name</div></td>
    <td width="7%">SerNo</td>
	<td width="4%">Qual</td>
    <td width="4%">Acting</td>
    <td width="2%">Group</td>
    <td width="7%">TripNo</td>
	<td width="6%">SPcode</td>
	<td width="6%">RptLoc</td>
	<td width="9%">Phone</td>
	<td width="6%">Cr</td>
	<td width="6%">CHN Visa</td>
	<td width="6%"> Info</td>
  </tr>
<%
	for (int i = 0; i < al.size(); i++) {
		CrewListOfDailyCheckObj obj = (CrewListOfDailyCheckObj) al.get(i);
		
					
	String bg ="";
	if(i%2==0){
		bg="#FFFFFF"	;
	}else{
		bg ="rgb(231,243,255)"; ;
	}
		
	
				
  %>
  <tr  class="txtblue"  style='background-color:<%=bg%>' >
  	<td height="20"><%=i+1%></td>
    <td><%=obj.getACM()%></td>
    <td><a href="javascript:goSche('<%=obj.getEmpno()%>')" title="組員月班表"><%=obj.getEmpno()%></a></td>
	<%
	bg = "";
	//CS40 commented 2009/1/12
	if(!obj.isCheckIn()&& "d".equals(status.substring(0,1)) && ("1".equals(obj.getGROUPS()) || "2".equals(obj.getGROUPS()) || "3".equals(obj.getGROUPS()) || "4".equals(obj.getGROUPS()) || "98".equals(obj.getGROUPS()) || "96".equals(obj.getGROUPS()))){
	
	//CS40 rollback 2009/3/4
	//if(!obj.isCheckIn()&& "d".equals(status.substring(0,1))){
		bg = " background-color:#FFCCCC;";
	}		
	%>
	<td  style='text-align:left;padding-left:0.5em;<%=bg%>'><%=obj.getCName()%></td>   
    <td><%=obj.getSern()%></td>
    <td><%=obj.getRank()%></td>
    <td><%=obj.getActing_Rank()%></td>
	<td><%=obj.getGROUPS()%></td>
	<td><a href="javascript:showTrip('<%=obj.getTripNo()%>','<%=fleet%>');" title="Trip Info"><%=obj.getTripNo()%></a>&nbsp;</td>
	<td><%=obj.getSpcode()%>&nbsp;</td>
	<td><span class="style1"><%=obj.getRptLoc()%></span>&nbsp;</td>
	<td><a href="javascript:showTel('<%=obj.getEmpno()%>','<%=obj.getCName()%>');" title="聯絡電話"><%=obj.getPhone()%></a>&nbsp;</td>
	<td><%=obj.getCr()%></td>
	
	<% //CS40 2009-5-18 SR9232
	   
	   if ((obj.getChnVisaExpDt()).compareTo(fltdate.substring(0,10)) > 0) // check CHN visa expired
	        out.println("<td>" + obj.getChnVisaExpDt()+"</td>");
	   else out.println("<td style=' background-color:#FFCCCC'>" + obj.getChnVisaExpDt()+"</td>");	   
	   
	   //out.println("<td></td>");
	%>
	
	<td><a href="javascript:showCrewInfo('<%=obj.getEmpno()%>');" title="Crew Info"><img src="../../images/blue_view.gif" width="16" height="16" border="0" alt="Crew Info"></a></td>
  </tr>
  <%
  		
	}
  %>
</table>
<%
if("Y".equals(totalOpen)){


%>
    <table width="90%"  border="0" align="center" cellpadding="0" cellspacing="0" >
      <tr >
        <td colspan="12">
        
	  <div align="left" class="txtblue">各艙等OPEN人數：PR：
	    <% if(Integer.parseInt(request.getParameter("cc1")) > 0){ %>
		  <span style="color:#FF0000 "><%=request.getParameter("cc1")%></span>		  
		  <% }else{  out.print(request.getParameter("cc1")); }	  %>

,&nbsp;&nbsp;MF：	    <% if(Integer.parseInt(request.getParameter("cc2")) > 0){ %>

		  <span style="color:#FF0000 "><%=request.getParameter("cc2")%></span>		  
		  <% }else{  out.print(request.getParameter("cc2")); }	  %>
&nbsp;&nbsp;FF：	    <% if(Integer.parseInt(request.getParameter("cc3")) > 0){ %>

		  <span style="color:#FF0000 "><%=request.getParameter("cc3")%></span>		  
		  <% }else{  out.print(request.getParameter("cc3")); }	  %>
&nbsp;&nbsp;MC：	    <% if(Integer.parseInt(request.getParameter("cc4")) > 0){ %>

		  <span style="color:#FF0000 "><%=request.getParameter("cc4")%></span>		  
		  <% }else{  out.print(request.getParameter("cc4")); }	  %>
&nbsp;&nbsp;FC：	    <% if(Integer.parseInt(request.getParameter("cc5")) > 0){ %>

		  <span style="color:#FF0000 "><%=request.getParameter("cc5")%></span>		  
		  <% }else{  out.print(request.getParameter("cc5")); }	  %>
&nbsp;&nbsp;MY：	    <% if(Integer.parseInt(request.getParameter("cc6")) > 0){ %>

		  <span style="color:#FF0000 "><%=request.getParameter("cc6")%></span>		  
		  <% }else{  out.print(request.getParameter("cc6")); }	  %>
&nbsp;&nbsp;FY：	    <% if(Integer.parseInt(request.getParameter("cc7")) > 0){ %>

		  <span style="color:#FF0000 "><%=request.getParameter("cc7")%></span>		  
		  <% }else{  out.print(request.getParameter("cc7")); }	  %>
		  
		  </div>
        </td>
      </tr>
    </table>    
<%
}



%>

      
      <br>
<div align="center">
    <table width="90%"  border="0" align="center" cellpadding="0" cellspacing="0" >
      <tr >
        <td colspan="12">
          <div align="left"  class="txtxred">*Cr: Credit Hour.格式:HHMM<br>
            *點選Empno:查詢組員該月班表<br>
  *點選Tripno:查詢Trip明細.<br>
  *點選Phone:查詢組員聯絡電話<br>
  *點選Crew Info:查詢組員相關資料<br>
          </div></td>
      </tr>
    </table> 
        <input name="backButton" type="button" class="kbd" onClick="history.back(-1)" value="Back" style="font-family:Verdana, Arial, Helvetica, sans-serif; ">
</div>

<form name="form1" method="post" action="showScheByMonth.jsp" target="_blank" >
<input type="hidden" name="emp">
<input type="hidden" name="y1" value="<%=fltdate.substring(0,4)%>">
<input type="hidden" name="m1"value="<%=fltdate.substring(5,7)%>">
</form>
<form name="form2" method="post">
	<input type="hidden" name="fltdate" value="<%=fltdate.substring(0,10)%>" >
	<input type="hidden" name="fltno" value="<%=fltno%>">
	<input type="hidden" name="sector" value="<%=Rsector%>">
	<input type="hidden" name="empno">
	<input type="hidden" name="cname">
	<input type="hidden" name="tripno">
	<input type="hidden" name="flag" value="L">
	<input type="hidden" name="acno">
</form>
<script src="../../js/subWindow.js"></script>
<script language="javascript" type="text/javascript">
function goSche(empno){
	document.form1.emp.value = empno;
	document.form1.submit();
}


	function showCrewInfo(empno){
		subwinXY('../../temple/loading.htm','CrewInfo','750','170');
		document.form2.target="CrewInfo";
		document.form2.action="CrewInfo.jsp";
		document.form2.empno.value = empno;		
		document.form2.submit();
	}
	
	function showTel(empno,cname){
		subwinXY('../../temple/loading.htm','phone','500','300');
		document.form2.target="phone";
		document.form2.action="PhoneList.jsp";
		document.form2.empno.value = empno;
		document.form2.cname.value = cname;		
		document.form2.submit();
	}
	function showTrip(tripno,fleet){
		subwinXY('../../temple/loading.htm','tripList','700','500');
		document.form2.target="tripList";
		document.form2.action="TripList.jsp";
		document.form2.tripno.value = tripno;
		document.form2.acno.value = fleet;		
		document.form2.submit();
	}
	
</script>


<%
}
%>
</body>
</html>

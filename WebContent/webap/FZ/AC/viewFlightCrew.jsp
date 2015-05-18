<%@ page contentType="text/html; charset=big5" language="java"
	import="java.sql.*,ci.db.*,fz.daily.*,java.util.*" errorPage=""%>
<%!
public class CrewObj {
	private String empno;
	private String sern;
	private String cname;
	private String ename;
	private String grp;
	private String acting_rank;
	private String spCode;
	public String getActing_rank() {
		return acting_rank;
	}
	public void setActing_rank(String acting_rank) {
		this.acting_rank = acting_rank;
	}
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	public String getEmpno() {
		return empno;
	}
	public void setEmpno(String empno) {
		this.empno = empno;
	}
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}
	public String getGrp() {
		return grp;
	}
	public void setGrp(String grp) {
		this.grp = grp;
	}
	public String getSern() {
		return sern;
	}
	public void setSern(String sern) {
		this.sern = sern;
	}
	public String getSpCode() {
		return spCode;
	}
	public void setSpCode(String spCode) {
		this.spCode = spCode;
	}

}
%>
<%!public class FlightObj {

	private String fltno;
	private String dpt;
	private String arv;
	private String startDate;
	private String endDate;
	
	public String getArv() {
		return arv;
	}
	
	public void setArv(String arv) {
		this.arv = arv;
	}
	
	public String getDpt() {
		return dpt;
	}
	
	public void setDpt(String dpt) {
		this.dpt = dpt;
	}
	
	public String getEndDate() {
		return endDate;
	}
	
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	
	public String getFltno() {
		return fltno;
	}
	
	public void setFltno(String fltno) {
		this.fltno = fltno;
	}
	
	public String getStartDate() {
		return startDate;
	}
	
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	
	
}%>
<%
String sGetUsr = request.getParameter("userid");

	String tripno = request.getParameter("tripno");

	Driver dbDriver = null;
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;

	boolean status = false;
	String errMsg = "";

	ConnDB cn = new ConnDB();
	ArrayList flightAL = null;
	ArrayList crewAL = null;
	try {

		cn.setAOCIPRODCP();
		dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
		conn = dbDriver.connect(cn.getConnURL(), null);
/*
		cn.setAOCIPRODFZUser();
		java.lang.Class.forName(cn.getDriver());
		conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),
			cn.getConnPW());
*/
		pstmt = conn
		.prepareStatement("SELECT dps.act_port_a dpt,dps.act_port_b arv,"
				+ "to_char(dps.str_dt_tm_loc,'yyyy-mm-dd HH24:MI') strdt,"
				+ "to_char(dps.end_dt_tm_loc,'yyyy-mm-dd HH24:MI') enddt,dps.flt_num "
				+ "from duty_prd_seg_v dps "
				+ "WHERE (dps.duty_cd='FLY' or dps.duty_cd='LO' or dps.duty_cd='TVL') "
				+ "and dps.delete_ind='N' and dps.series_num=? ORDER BY duty_seq_num");
				
		pstmt.setString(1,tripno);
		rs = pstmt.executeQuery();

		while(rs.next()){
			if(flightAL == null){
				flightAL = new ArrayList();
			}
			FlightObj o = new FlightObj();
			o.setArv(rs.getString("arv"));
			o.setDpt(rs.getString("dpt"));
			o.setEndDate(rs.getString("enddt"));
			o.setStartDate(rs.getString("strdt"));
			o.setFltno(rs.getString("flt_num"));
			
			flightAL.add(o);
		}
		rs.close();
		pstmt.close();

		pstmt = conn.prepareStatement("select r.staff_num empno,"
				+ "LTrim(c.seniority_code,'0') sern, "
				+ "c.preferred_name cname, "
				+ "r.acting_rank ,r.special_indicator spcode "				
				+ "from roster_v r, crew_v c, duty_prd_seg_v dps "
				+ "where r.staff_num=c.staff_num and r.series_num = dps.series_num  "
				+ "and r.delete_ind='N' "
				+ "and r.series_num=? "
				+" group by r.staff_num,c.seniority_code,c.preferred_name,r.acting_rank,r.special_indicator "
				+ "order by  empno,acting_rank");
		pstmt.setString(1,tripno);
		
		rs = pstmt.executeQuery();
		while(rs.next()){
			if(crewAL == null){
				crewAL = new ArrayList();
			}
			CrewObj o = new CrewObj();
			o.setEmpno(rs.getString("empno"));
			o.setSern(rs.getString("sern"));
			o.setActing_rank(rs.getString("acting_rank"));
			o.setCname(ci.tool.UnicodeStringParser.removeExtraEscape(rs.getString("cname")));
			o.setSpCode(rs.getString("spcode"));
			crewAL.add(o);
		}
		rs.close();
		pstmt.close();

		status = true;
	}catch(Exception e){
		errMsg += e.getMessage();
	}finally {
		if (rs != null)
			try {
				rs.close();
			} catch (SQLException e) {	errMsg += e.getMessage();}
		if (pstmt != null)
			try {
				pstmt.close();
			} catch (SQLException e) {	errMsg += e.getMessage();}
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
					errMsg += e.getMessage();
			}
			conn = null;
		}
	}	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Trip List</title>
<link rel="stylesheet" type="text/css" href="swapArea.css">
<link rel="stylesheet" type="text/css" href="hintsClass.css">
<script language="JavaScript" src="tigra_hints.js"></script>
<script language="JavaScript" src="tigra_hints_cfg.js"></script>
<script language="JavaScript" >
	var myHint = new THints (HINTS_ITEMS, HINTS_CFG);
</script>

</head>
<body>
<%
if(!status){
%>
<p class="errStyle">ERROR:<%=errMsg %></p>
<%	
}else if(flightAL == null){
	%>
	<p class="errStyle">No Flight Information.</p>
	<%	
	
}else if(crewAL == null){
	
		%>
		<p class="errStyle">No Flight Crew List.</p>
		<%	
}else{	
%>
 
<table width="65%" border="0" align="center" cellpadding="0" cellspacing="0">

	<tr>
	  <td height="82" colspan="2" valign="top" class="left red">The following shedule is for reference only. <br>
For official up-to-date schedule information, please contact Scheduling Department. <br>
下列班表僅供參考，請向組員派遣部門確認個人正式班表任務。</td>
  </tr>
	<tr>
		<td width="95%" class="center blue"> Flight Crew List By Trip,TripNo : <%=tripno%></td>
	    <td width="5%" class="right"><a href="javascript:window.print()"><img src="../images/print.gif" border="0"></a></td>
	</tr>
</table>
<table width="65%" border="0" align="center" cellpadding="0" cellspacing="1" style="border:1pt solid black;border-collapse:collapse; "  >
  <tr>
		<th width="18%">FltNo</th>
		<th width="17%">DPT</th>
		<th width="17%">ARV</th>
		<th width="24%">Start DT LOC</th>
		<th width="24%">End DT LOC</th>
  </tr>
	<%
	for(int i=0;i<flightAL.size();i++){
		FlightObj obj = (FlightObj)flightAL.get(i);
	String cssStyle = "";
	if (i%2 == 1)	{
		cssStyle = "gridRowEven";
	}	else{
		cssStyle = "gridRowOdd";
	}
%>
      <tr class="center <%=cssStyle %>"> 
		<td><%=obj.getFltno()%></td>
		<td><%=obj.getDpt() %></td>
		<td><%=obj.getArv() %></td>										
		<td><%=obj.getStartDate() %></td>
		<td><%=obj.getEndDate() %></td>

	</tr>
  <%} %>
</table>	
<hr width="65%" noshade>
<table width="65%" border="0" align="center" cellpadding="0" cellspacing="1" style="border:1pt solid black;border-collapse:collapse; ">
	<tr class="center" >
		<th width="113"  class="darkPurpleBG">EmpNo<br>
<span style="font-size:smaller; ">(View Skj)</span></th>
		<th width="112" class="darkPurpleBG" >SerNo</th>
		<th width="204" class="darkPurpleBG" >Name<br>
		<span style="font-size:smaller; ">(Crew's Info)</span></th>
		<th width="71" class="darkPurpleBG">Rank</th>
		<th width="95" class="darkPurpleBG">SpCode</th>
	</tr>
	<%
	for(int i=0;i<crewAL.size();i++){
		CrewObj obj = (CrewObj)crewAL.get(i);
		
	String cssStyle = "";
	if (i%2 == 1)	{
		cssStyle = "lightPurpleBG";
	}	else{
		cssStyle = "gridRowOdd";
	}
%>
      <tr class="center <%=cssStyle %>"> 
		<td><a name="<%=i%>" href="#<%=i%>"  onMouseOver="myHint.show(0)" onMouseOut="myHint.hide()" onClick="javascript:viewCrew('<%=obj.getEmpno()%>','S');"><%=obj.getEmpno()%></a></td>
		<td class="right"><%=obj.getSern() %></td>
		<td ><a name="<%=i%>" href="#<%=i%>"  onMouseOver="myHint.show(1)" onMouseOut="myHint.hide()" onClick="javascript:viewCrew('<%=obj.getEmpno()%>','C');"><%=obj.getCname() %></a></td>										
		<td ><%=obj.getActing_rank() %></td>
		<td ><%=obj.getSpCode() %></td>
	</tr>	
	<%} %>	
	<tr>
	<td colspan="5">Click EmpNo to View Crew's Schedule,Click Name to View Crew's information.<br>
	  點擊EmpNo可檢視組員班表,點擊Name可查詢組員資料.</td>
	</tr>
</table><br>

<table width="65%" border="0" align="center" cellpadding="0" cellspacing="1">
<tr>
   <td class="center"><input type="button" value="CLOSE WINDOW" onClick="javascript:self.close();"></td>
</tr>
</table>
<form name="form1" method="post" id="form1" target="_blank">
	<input type="hidden" name="empno" id="empno">
	<input type="hidden" name="tripno" id="tripno">
	<input type="hidden" name="tf_empno" id="tf_empno">
	<input type="hidden" name="tf_sess1" id="tf_sess1">
	<input type="hidden" name="tf_sess2" id="tf_sess2">
	<input type="hidden" name="tf_ename" id="tf_ename">
</form>
<script language="javascript" type="text/javascript">
	function viewCrew(empno,str){
		
		if(str == "S"){
			document.getElementById("empno").value = empno;
			document.form1.action="crewSkj.jsp";
		}else if(str =="C"){//Crew info
			document.getElementById("tf_empno").value = empno;
			document.form1.action="crewInfo.jsp";		
		}
		
		document.form1.submit();
	}
	

</script>
<%
	
}
%>




</body>
</html>
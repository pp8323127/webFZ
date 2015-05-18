<%@ page contentType="text/html; charset=big5" language="java"   %>
<%@ page import="java.sql.*,ci.db.*,java.util.*,ci.tool.*"%>
<%!
public class OtherDutyCrewListObj {

	private String empno;
	private String cname;
	private String ename;
	private String sern;
	private String dutyCd;
	private String rank;
	private String fdate;

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public String getDutyCd() {
		return dutyCd;
	}

	public void setDutyCd(String dutyCd) {
		this.dutyCd = dutyCd;
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

	public String getFdate() {
		return fdate;
	}

	public void setFdate(String fdate) {
		this.fdate = fdate;
	}

	public String getRank() {
		return rank;
	}

	public void setRank(String rank) {
		this.rank = rank;
	}

	public String getSern() {
		return sern;
	}

	public void setSern(String sern) {
		this.sern = sern;
	}

}

%>
<%

String userid = (String) session.getAttribute("userid") ; //get user id if already login
String strDt = request.getParameter("sdate");
String type = request.getParameter("type");
if (session.isNew() |userid == null) {		
	response.sendRedirect("../sendredirect.jsp");
} else{


//檢查班表是否公布
swap3ac.PublishCheck pc = new swap3ac.PublishCheck(strDt.substring(0,4), strDt.substring(5,7));

if(!pc.isPublished()){
%>
<div style="background-color:#99FFFF;text-align:center;color:#FF0000;font-family:Verdana;font-size:10pt; ">
		<%=strDt.substring(0,7)%>班表尚未正式公佈!!
</div>
<%

}else{
//寫入log
/*
fz.writeLog wl = new fz.writeLog();
wl.updLog(userid, request.getRemoteAddr(),request.getRemoteHost(), "CII060");
*/

String base 	= "";

if( null == (String)session.getAttribute("base") | "".equals((String)session.getAttribute("base"))
			| "ADM".equals((String)session.getAttribute("base"))){
	base="TPE";			
}else{
	base =  (String)session.getAttribute("base");
}
String titleText = "";

//艙等
	String occu = request.getParameter("occu");
	StringBuffer rankCondition = new StringBuffer();

	if ("1".equals(occu)) { // F.C
		rankCondition.append("  in ('MF','MC','FF','FC') ");
	} else if ("2".equals(occu)) { // Y
		rankCondition.append("  in ('MY','FY') ");
	} else if ("3".equals(occu)) { // PR
		rankCondition.append("  ='PR' ");
	} /*else if("0".equals(occu)){ //all
		if("PR".equals((String)session.getAttribute("occu"))){
			rankCondition.append("  ='PR' ");		
		}else{
			rankCondition.append("  <>'PR' ");		
		}
		
	}*/





Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
ConnDB cn = new ConnDB();
Driver dbDriver = null;
String preEmpno = "";
String sql =null;


//out.print(sql);
boolean queryStatus = false;
ArrayList dataAL = null;
String errMsg = "";
try
{
	cn.setAOCIPRODCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	
/*	cn.setAOCIPRODFZUser();
	java.lang.Class.forName(cn.getDriver());
conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),
	cn.getConnPW());
*/	
if("1".equals(type)){	//RST,ADO
	titleText = " OFF (RST,ADO) ";
	
	sql = "select r.staff_num empno, ltrim(c.seniority_code,'0') sern,"
		+"c.other_surname||' '||c.other_first_name ename,c.preferred_name cname,c.section_number, "
		  +"b.base, cv.rank_cd rank,to_char(r.str_dt,'yyyy/mm/dd ') fdate,r.duty_cd,r.str_dt dd "
		  +"from roster_v r, crew_v c,crew_base_v b,crew_rank_v cv "
		  +"where r.staff_num=c.staff_num "
		  +"AND r.staff_num = b.staff_num "
		  +"AND r.staff_num = cv.staff_num "
		  +"AND r.delete_ind='N'  and r.str_dt between to_date(?,'yyyy/mm/dd hh24mi') "
		  +"AND to_date(?,'yyyy/mm/dd hh24mi') AND r.duty_cd IN ('ADO') "
		  +"AND b.prim_base='Y' "
		  +"AND b.eff_dt <= sysdate "
		  +"AND (b.Exp_dt IS NULL OR b.Exp_dt >=sysdate) "
		  +"AND ( cv.exp_dt IS NULL  OR cv.exp_dt >= sysdate ) "
		  +"AND cv.eff_dt <= sysdate "
		  +"AND cv.rank_cd "+ rankCondition.toString()
	+"UNION all "
	+"select r.staff_num empno, LTrim(c.seniority_code,'0') sern,"
	+"c.other_surname||' '||c.other_first_name ename, c.preferred_name cname,c.section_number, "
		  +"b.base,cv.rank_cd rank,to_char(dps.act_str_dt_tm_gmt,'yyyy/mm/dd') fdate, dps.duty_cd ,dps.act_str_dt_tm_gmt dd "
	+"from roster_v r, crew_v c, duty_prd_seg_v dps,crew_rank_v cv,crew_base_v b "
		  +"where r.staff_num=c.staff_num "
		  +"AND r.staff_num=cv.staff_num "
		  +"AND r.series_num = dps.series_num "
		  +"AND r.staff_num = b.staff_num "
		  +"AND r.delete_ind='N' and dps.fd_ind='N' "
		  +"AND b.prim_base='Y' "
		  +"AND dps.act_str_dt_tm_gmt between to_date(?,'yyyy/mm/dd hh24mi') "
		  +"AND to_date(?,'yyyy/mm/dd hh24mi') "
		  +"AND b.eff_dt <= sysdate "
		  +"AND (b.Exp_dt IS NULL OR b.Exp_dt >=sysdate ) "
		  +"AND cv.eff_dt <= sysdate "
		  +"AND ( cv.exp_dt IS NULL  OR cv.exp_dt >= sysdate ) "
		  +"AND dps.duty_cd = 'RST' "
  		  +"AND cv.rank_cd "+ rankCondition.toString()
	+"ORDER BY empno,Rank,duty_cd  ";
		
		
		pstmt = conn.prepareStatement(sql);
		
		for(int i=1;i<=4;i=i+2){
			pstmt.setString(i,strDt+" 0000");
			pstmt.setString(i+1,strDt+" 2359");
		}
	
}else if("2".equals(type)){//R1,R2,R3,R4
	titleText = " 上課 (R1,R2,R3,R4,R5) ";
	
	sql = "select r.staff_num empno, LTrim(c.seniority_code,'0') sern,"
		+"c.other_surname||' '||c.other_first_name ename, c.preferred_name cname,c.section_number, "
		  +"b.base,cv.rank_cd rank,to_char(dps.act_str_dt_tm_gmt,'yyyy/mm/dd') fdate, dps.duty_cd ,dps.act_str_dt_tm_gmt dd "
	+"from roster_v r, crew_v c, duty_prd_seg_v dps,crew_rank_v cv,crew_base_v b "
		  +"where r.staff_num=c.staff_num "
		  +"AND r.staff_num=cv.staff_num "
		  +"AND r.series_num = dps.series_num "
		  +"AND r.staff_num = b.staff_num "
		  +"AND r.delete_ind='N' and dps.fd_ind='N' "
		  +"AND b.prim_base='Y' "
		  +"AND dps.act_str_dt_tm_gmt between to_date(?,'yyyy/mm/dd hh24mi') "
		  +"AND to_date(?,'yyyy/mm/dd hh24mi') "
		  +"AND b.eff_dt <= sysdate "
		  +"AND (b.Exp_dt IS NULL OR b.Exp_dt >=sysdate ) "
		  +"AND cv.eff_dt <= sysdate "
		  +"AND ( cv.exp_dt IS NULL  OR cv.exp_dt >= sysdate ) "
		  +"AND dps.duty_cd  in (?,?,?,?,?) "
	+"ORDER BY r.staff_num,cv.rank_cd,duty_cd ";

	pstmt = conn.prepareStatement(sql);
	
			pstmt.setString(1,strDt+" 0000");
			pstmt.setString(2,strDt+" 2359");
			pstmt.setString(3,"R1");
			pstmt.setString(4,"R2");
			pstmt.setString(5,"R3");
			pstmt.setString(6,"R4");
			pstmt.setString(7,"R5");			


}else if("3".equals(type)){	//MT
	titleText = " 開會 (MT) ";

	sql = "select r.staff_num empno, LTrim(c.seniority_code,'0') sern,"
	+"c.other_surname||' '||c.other_first_name ename, c.preferred_name cname,c.section_number, "
		  +"b.base,cv.rank_cd rank,to_char(dps.act_str_dt_tm_gmt,'yyyy/mm/dd') fdate, dps.duty_cd ,dps.act_str_dt_tm_gmt dd "
	+"from roster_v r, crew_v c, duty_prd_seg_v dps,crew_rank_v cv,crew_base_v b "
		  +"where r.staff_num=c.staff_num "
		  +"AND r.staff_num=cv.staff_num "
		  +"AND r.series_num = dps.series_num "
		  +"AND r.staff_num = b.staff_num "
		  +"AND r.delete_ind='N' and dps.fd_ind='N' "
		  +"AND b.prim_base='Y' "
		  +"AND dps.act_str_dt_tm_gmt between to_date(?,'yyyy/mm/dd hh24mi') "
		  +"AND to_date(?,'yyyy/mm/dd hh24mi') "
		  +"AND b.eff_dt <= sysdate "
		  +"AND (b.Exp_dt IS NULL OR b.Exp_dt >=sysdate ) "
		  +"AND cv.eff_dt <= sysdate "
		  +"AND ( cv.exp_dt IS NULL  OR cv.exp_dt >= sysdate ) "
		  +"AND dps.duty_cd  =? "
	+"ORDER BY r.staff_num,cv.rank_cd,duty_cd ";

	pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,strDt+" 0000");
			pstmt.setString(2,strDt+" 2359");
			pstmt.setString(3,"MT");

		
}	
else if("4".equals(type)){	//EF
	titleText = " 會議 (EF) ";

	sql = "select r.staff_num empno, LTrim(c.seniority_code,'0') sern,"
	+"c.other_surname||' '||c.other_first_name ename, c.preferred_name cname,c.section_number, "
		  +"b.base,cv.rank_cd rank,to_char(dps.act_str_dt_tm_gmt,'yyyy/mm/dd') fdate, dps.duty_cd ,dps.act_str_dt_tm_gmt dd "
	+"from roster_v r, crew_v c, duty_prd_seg_v dps,crew_rank_v cv,crew_base_v b "
		  +"where r.staff_num=c.staff_num "
		  +"AND r.staff_num=cv.staff_num "
		  +"AND r.series_num = dps.series_num "
		  +"AND r.staff_num = b.staff_num "
		  +"AND r.delete_ind='N' and dps.fd_ind='N' "
		  +"AND b.prim_base='Y' "
		  +"AND dps.act_str_dt_tm_gmt between to_date(?,'yyyy/mm/dd hh24mi') "
		  +"AND to_date(?,'yyyy/mm/dd hh24mi') "
		  +"AND b.eff_dt <= sysdate "
		  +"AND (b.Exp_dt IS NULL OR b.Exp_dt >=sysdate ) "
		  +"AND cv.eff_dt <= sysdate "
		  +"AND ( cv.exp_dt IS NULL  OR cv.exp_dt >= sysdate ) "
		  +"AND dps.duty_cd  =? "
	+"ORDER BY r.staff_num,cv.rank_cd,duty_cd ";

	pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,strDt+" 0000");
			pstmt.setString(2,strDt+" 2359");
			pstmt.setString(3,"EF");

		
}	
else if("5".equals(type)){	//BL
	titleText = " 公假 (BL) ";

	sql = "select r.staff_num empno, LTrim(c.seniority_code,'0') sern,"
	+"c.other_surname||' '||c.other_first_name ename, c.preferred_name cname,c.section_number, "
		  +"b.base,cv.rank_cd rank,to_char(dps.act_str_dt_tm_gmt,'yyyy/mm/dd') fdate, dps.duty_cd ,dps.act_str_dt_tm_gmt dd "
	+"from roster_v r, crew_v c, duty_prd_seg_v dps,crew_rank_v cv,crew_base_v b "
		  +"where r.staff_num=c.staff_num "
		  +"AND r.staff_num=cv.staff_num "
		  +"AND r.series_num = dps.series_num "
		  +"AND r.staff_num = b.staff_num "
		  +"AND r.delete_ind='N' and dps.fd_ind='N' "
		  +"AND b.prim_base='Y' "
		  +"AND dps.act_str_dt_tm_gmt between to_date(?,'yyyy/mm/dd hh24mi') "
		  +"AND to_date(?,'yyyy/mm/dd hh24mi') "
		  +"AND b.eff_dt <= sysdate "
		  +"AND (b.Exp_dt IS NULL OR b.Exp_dt >=sysdate ) "
		  +"AND cv.eff_dt <= sysdate "
		  +"AND ( cv.exp_dt IS NULL  OR cv.exp_dt >= sysdate ) "
		  +"AND dps.duty_cd  =? "
	+"ORDER BY r.staff_num,cv.rank_cd,duty_cd ";

	pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,strDt+" 0000");
			pstmt.setString(2,strDt+" 2359");
			pstmt.setString(3,"BL");

		
}	
	rs = pstmt.executeQuery(); 

	while(rs.next()){
		//去掉不同BASE者
		if(!rs.getString("base").equals(base)){
			continue;
		}
		
		//去掉Rank
		
		if(dataAL == null)
			dataAL = new ArrayList();
		OtherDutyCrewListObj obj = new OtherDutyCrewListObj();
		
		obj.setCname(UnicodeStringParser.removeExtraEscape(rs.getString("cname")));		//轉中文碼
		obj.setEname(rs.getString("ename"));
		obj.setDutyCd(rs.getString("duty_cd"));		
		obj.setEmpno(rs.getString("empno"));			
		obj.setRank(rs.getString("rank"));		
		obj.setSern(rs.getString("sern"));
		dataAL.add(obj);
		
		/*if(dataAL.size() ==9999){
			break;
		}*/
		
	}
	pstmt.close();
	rs.close();
	

	 queryStatus = true;
	 
}catch(SQLException e){
	errMsg	= e.toString();
	
}
catch (Exception e){
	errMsg	= e.toString();
	
}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}



%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Other Duty Crew List</title>
<link rel="stylesheet" type="text/css" href="../errStyle.css">
<link rel="stylesheet" type="text/css" href="swapArea.css">
<link rel="stylesheet" type="text/css" href="hintsClass.css">
<script language="JavaScript" src="tigra_hints.js"></script>
<script language="JavaScript" src="tigra_hints_cfg.js"></script>
<script language="JavaScript" >
	var myHint = new THints (HINTS_ITEMS, HINTS_CFG);
</script>
<style type="text/css">
.statusText{	
	text-align:center;
	color:#FF0000;
	font-weight:bold;
	display:block;
	margin-top:100pt;

}
</style>
</head>
<body >

<div id="showStatusText" class="statusText"><img src="img/Indicator.gif" width="16" height="16" style="vertical-align:bottom; ">loading...</div>

<div id="treeDIV" style="display:none; ">

<%
if(!queryStatus){
%>
<p class="errStyle1">ERROR:<%=errMsg%></p>

<%
}else if(dataAL == null){
%>
<p class="errStyle1">NO DATA.</p>

<%

}else{


%>
<div class="center"> 
<table width="80%"  border="0" align="center"  cellpadding="0" cellspacing="1">
  <tr>
    <td height="38" colspan="2"  class="center blue"><%=strDt%>&nbsp;&nbsp;<%=titleText%> &nbsp;&nbsp;Crew List  </td>
    </tr>
  <tr>
    <td width="98%" align="left">Click EmpNo to View Crew's Schedule, Name to View Crew's information.<br>
點擊EmpNo可檢視組員班表,點擊Name可查詢組員資料. </td>
    <td width="2%" align="right"><a href="javascript:window.print()"><img height="15" src="../images/print.gif" width="17" border="0"></a></td>
  </tr>

</table>
</div>
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="1" style="border:1pt solid black;border-collapse:collapse; "> 
  <tr >
    <th width="12%"  >      EmpNo</th>
    <th width="12%"  >      CName</th>
    <th width="28%"  >EName</th>
    <th width="10%"  >      Sern</th>
    <th width="12%"  > Duty</th>
    <th width="9%" >      Rank</th>
  </tr>
<%
		
	for(int i=0;i<dataAL.size();i++){
		OtherDutyCrewListObj obj = (OtherDutyCrewListObj)dataAL.get(i);
		//若有重複，則不顯示
		if(preEmpno.equals(obj.getEmpno())){
			continue;
		}
		String cssStyle = "";
		if (i%2 == 1)	{
			cssStyle = "gridRowEven";
		}	else{
			cssStyle = "gridRowOdd";
		}
%>
      <tr class="center <%=cssStyle %>"> 
			<td > <a name="<%=i%>" href="#<%=i%>"  onMouseOver="myHint.show(0)" onMouseOut="myHint.hide()" onClick="javascript:viewCrew('<%=obj.getEmpno()%>');"><%=obj.getEmpno()%></a> </td>
			<td class="left"><a name="<%=i%>" href="#<%=i%>" onMouseOver="myHint.show(1)" onMouseOut="myHint.hide()" onClick="javascript:viewCrewInfo('<%=obj.getEmpno()%>');"><%=obj.getCname()%></a> </td>
			<td class="left"><%=obj.getEname()%></td>
			<td class="right"><%=obj.getSern()%></td>
			<td ><%=obj.getDutyCd()%></td>
			<td ><%=obj.getRank()%></td>
		</tr>
<%
	preEmpno = obj.getEmpno();
}		
%>
  <tr>
    <td colspan="6" align="left">Click EmpNo to View Crew's Schedule, Name to View Crew's information.<br>
點擊EmpNo可檢視組員班表,點擊Name可查詢組員資料.</td>
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
	function viewCrew(empno){
		document.getElementById("empno").value = empno;
		document.form1.action="crewSkj.jsp";
		document.form1.submit();
	}
	
	function viewCrewInfo(empno){
		document.getElementById("tf_empno").value = empno;
		document.form1.action="crewInfo.jsp";				
		document.form1.submit();
	}

</script>

<%
}//end of has data
%>
</div>
<script language="javascript" type="text/javascript">
	function showDIV(){
		document.getElementById("treeDIV").style.display='';
		document.getElementById("showStatusText").style.display='none';	
	}
	setTimeout("showDIV()",500);
</script>

</body>
</html>
<script language="javascript" type="text/javascript">
	if(parent.topFrame.document.getElementById("submit") != null){
		parent.topFrame.document.getElementById("submit").disabled=0;
	}
	if(parent.topFrame.document.getElementById("showStatus") != null){
		parent.topFrame.document.getElementById("showStatus").className="hiddenStatus";
	}

</script>
<%
}//end of has session value

}
%>
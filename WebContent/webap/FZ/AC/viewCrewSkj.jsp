<%@ page contentType="text/html; charset=big5" language="java" 	import="java.sql.*"%>
<%!
public class CrewSkjObj {
	private java.util.Date startLocDate;
	private java.util.Date startTPEDate;
	private String fltno;
	private String sector;
	private String actingRank;
	private String endInfo;
	
	public String getActingRank() {
		return actingRank;
	}
	
	public void setActingRank(String actingRank) {
		this.actingRank = actingRank;
	}
	
	public String getEndInfo() {
		return endInfo;
	}
	
	public void setEndInfo(String endInfo) {
		this.endInfo = endInfo;
	}
	
	public String getFltno() {
		return fltno;
	}
	
	public void setFltno(String fltno) {
		this.fltno = fltno;
	}
	
	public String getSector() {
		return sector;
	}
	
	public void setSector(String sector) {
		this.sector = sector;
	}
	
	public java.util.Date getStartLocDate() {
		return startLocDate;
	}
	
	public void setStartLocDate(java.util.Date startLocDate) {
		this.startLocDate = startLocDate;
	}
	
	public java.util.Date getStartTPEDate() {
		return startTPEDate;
	}
	
	public void setStartTPEDate(java.util.Date startTPEDate) {
		this.startTPEDate = startTPEDate;
	}
}
%>
<%
String empno = request.getParameter("empno");
swap3ac.CheckLockSkj cLock = new swap3ac.CheckLockSkj(empno);
try{
	cLock.SelectData();
		
}catch(Exception e){

}
if(empno == null){
%>
<div style="background-color:#99FFFF;
		color:#FF0000;
		font-family:Verdana;
		font-size:10pt;padding:5pt;
		text-align:center; ">資料不足，無法查詢</div>
<%

}else if(!cLock.isOpenSkj()){
%>
<div style="background-color:#99FFFF;
		color:#FF0000;
		font-family:Verdana;
		font-size:10pt;padding:5pt;
		text-align:center; "><%=empno%> 不開放個人班表提供查詢</div>
<%
}else{

StringBuffer sb = new StringBuffer();
sb.append("SELECT r.STAFF_NUM,str_dt_tm_loc,");
sb.append("act_str_dt dutydt,act_str_dt_tm_gmt segdt,flt_num,act_port_a||act_port_b sector,");
sb.append("r.ACTING_RANK act_RK	,r.DUTY_CD rst_duty,seg.duty_cd seg_duty,");
sb.append("(CASE WHEN r.duty_cd='FLY' then ");
sb.append("(SELECT  To_Char(seg2.act_str_dt_tm_gmt,'yyyy/mm/dd')||' '||seg2.flt_num||' '||seg2.act_port_a||seg2.act_port_b ");
sb.append("FROM (SELECT * FROM DUTY_PRD_SEG_V ORDER BY act_str_dt_tm_gmt desc) seg2 ");
sb.append("WHERE seg2.series_num=seg.series_num AND seg2.duty_cd<>'RST' AND ROWNUM=1) ");
sb.append("ELSE ' ' ");
sb.append("  end)    DateFltSector_back ");
sb.append("FROM   ROSTER_V r  ");
sb.append(",DUTY_PRD_SEG_V seg ");
sb.append("WHERE  r.DELETE_IND='N' ");
sb.append("AND duty_published='Y' ");
sb.append("AND r.staff_num=? ");
sb.append("AND r.SERIES_NUM = seg.SERIES_NUM(+) ");
sb.append("AND r.act_str_dt>=SYSDATE ");
sb.append("AND seg.duty_seq_num=1 ");
sb.append("AND seg.item_seq_num=1 ");
sb.append("ORDER BY staff_num,act_str_dt,seg.ACT_STR_DT_TM_GMT ");

Connection conn = null;
Driver dbDriver = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
boolean status = false;
String errMsg = "";
ci.db.ConnDB cn = new ci.db.ConnDB();
java.util.ArrayList dataAL = null;

try {
	cn.setAOCIPRODCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	pstmt = conn.prepareStatement(sb.toString());
	pstmt.setString(1,empno);
	rs = pstmt.executeQuery();
	while(rs.next()){
		if(dataAL == null){
			dataAL = new java.util.ArrayList();			
		}
		
		CrewSkjObj obj = new CrewSkjObj();
		obj.setStartLocDate(rs.getDate("str_dt_tm_loc"));
		obj.setStartTPEDate(rs.getDate("segdt"));
		obj.setActingRank(rs.getString("act_RK"));
		obj.setEndInfo(rs.getString("DateFltSector_back"));
		if("0".equals(rs.getString("flt_num"))){
			obj.setFltno(rs.getString("seg_duty"));
		
		}else{
			obj.setFltno(rs.getString("flt_num"));		
		}

		obj.setSector(rs.getString("sector"));
		dataAL.add(obj);	
		
	}
	rs.close();
	pstmt.close();
	conn.close();
	status = true;

} catch (Exception e) {
	errMsg = e.toString();
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

java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm");

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>View Crew Skj</title>
<link rel="stylesheet" type="text/css" href="../errStyle.css">
<link rel="stylesheet" type="text/css" href="swapArea.css">

</head>

<body>
<%
if(!status){
%>
<p class="errStyle1">ERROR:<%=errMsg%></p>
<%
}else if(dataAL == null){
%>
<p class="errStyle1">NO DATA.</p>
<%
}else{
%>
 <table width="90%" border="0" align="center" cellpadding="0" cellspacing="1" style="border:0pt solid black;border-collapse:collapse; " >
 <tr>
   <td class="center">Crew's Current Month Schedule By Trip,
Empno:<%=empno%></td></tr>
 </table>

    <table width="90%" border="0" align="center" cellpadding="0" cellspacing="1" style="border:1pt solid black;border-collapse:collapse; " >
      <tr > 
        <th width="13%" >Fltno<br>
        (View Crew List) </th>
        <th width="19%">Start Date Time (Local)</th>
        <th width="16%">Start Date Time (TPE)</th>
        <th width="14%">Sector</th>
		<th width="11%"> Rank </th>
        <th width="27%">BackSector</th>
      </tr>
	  <%
	  for(int i=0;i<dataAL.size();i++){
	  	CrewSkjObj obj = (CrewSkjObj)dataAL.get(i);
		String cssStyle = "";
		if (i%2 == 1)	{
			cssStyle = "gridRowEven";
		}	else{
			cssStyle = "gridRowOdd";
		}
%>
      <tr class="<%=cssStyle %>"> 
        <td ><%=obj.getFltno()%></td>
        <td><%=formatter.format(obj.getStartLocDate())%></td>
        <td><%=formatter.format(obj.getStartTPEDate())%></td>
        <td><%=obj.getSector()%></td>
        <td><%=obj.getActingRank()%></td>
        <td ><%=obj.getEndInfo()%> </td>
      </tr>
	  <%	

	  }
	  %>
</table>

 <table width="90%" border="0" align="center" cellpadding="0" cellspacing="1" style="border:0pt solid black;border-collapse:collapse; " >
 <tr>
   <td class="center"><input type="button" value="CLOSE WINDOW" onClick="javascript:self.close();"></td></tr>
 </table>


<%
}
%>
</body>
</html>
<%
}
%>

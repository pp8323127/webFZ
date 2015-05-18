<%@ page contentType="text/html; charset=big5" language="java"
	import="java.sql.*,java.util.*"%>
<%!
public class SwapFlightObj{
	private String empno;
	private String sern ;
	private String cname;
	private String fdate;
	private String fltno;
	private String tripno;
	private String occu;
	private java.util.Date put_date;
	private String comments;
	
	
	public String getCname() {
		return cname;
	}
	
	public void setCname(String cname) {
		this.cname = cname;
	}
	
	public String getComments() {
		return comments;
	}
	
	public void setComments(String comments) {
		this.comments = comments;
	}
	
	public String getEmpno() {
		return empno;
	}
	
	public void setEmpno(String empno) {
		this.empno = empno;
	}
	
	public String getFdate() {
		return fdate;
	}
	
	public void setFdate(String fdate) {
		this.fdate = fdate;
	}
	
	public String getFltno() {
		return fltno;
	}
	
	public void setFltno(String fltno) {
		this.fltno = fltno;
	}
	
	public String getOccu() {
		return occu;
	}
	
	public void setOccu(String occu) {
		this.occu = occu;
	}
	
	public java.util.Date getPut_date() {
		return put_date;
	}
	
	public void setPut_date(java.util.Date put_date) {
		this.put_date = put_date;
	}
	
	public String getSern() {
		return sern;
	}
	
	public void setSern(String sern) {
		this.sern = sern;
	}
	
	public String getTripno() {
		return tripno;
	}
	
	public void setTripno(String tripno) {
		this.tripno = tripno;
	}
	
}
%>	
<%
	String[] fltno = request.getParameterValues("fltno");
	ArrayList fltnoAL = null;
	if (fltno != null) {
		fltnoAL = new ArrayList();
		for (int i = 0; i < fltno.length; i++) {
			if ("".equals(fltno[i].trim())) {
		fltno[i] = null;
		break;
			} else {
		fltnoAL.add(fltno[i]);
			}
		}
	}

	String occu = request.getParameter("occu");
	StringBuffer sb = new StringBuffer(
			"SELECT * FROM fzdb.fztsput where homebase = ? and ");

	if("PR".equals((String)session.getAttribute("occu"))){
		sb.append(" occu ='PR' ");
	}else if ("1".equals(occu)) { // F.C
		sb.append(" occu in ('MF','MC','FF','FC') ");
	} else if ("2".equals(occu)) { // Y
		sb.append(" occu in ('MY','FY') ");
	}  else if ("3".equals(occu)) { // ZC
		sb.append(" occu ='FC' ");
	} else { //all
		sb.append(" occu in ('MF','MC','MY','FF','FC','FY') ");
	}

	String sel = request.getParameter("sel");
	if ("1".equals(sel))   {//自訂班號
		if (fltnoAL != null) {
			sb.append(" and fltno in (");
		for (int i = 0; i < fltnoAL.size(); i++) {
		
		//非航班號者
			try{
				Integer.parseInt((String)fltnoAL.get(i));
				sb.append(" lpad('" + fltnoAL.get(i) + "',4,'0')");
			}catch(NumberFormatException e){
				sb.append(" upper('"+fltnoAL.get(i)+"') ");
			}	
		
			
			if (i != fltnoAL.size() - 1) {	
				sb.append(",");
			}
		}
			sb.append(") ");
		}

	}else if ("2".equals(sel)) { //Special Flight
		
		//媽媽班	004/006/008/032
		if ("1".equals(request.getParameter("spcialFlight"))) {
			sb.append("AND fltno IN ('0004','0006','0008','0032') ");
		}
	
		//大長班 012/063/065/067
		else if ("2".equals(request.getParameter("spcialFlight"))) {		
			sb.append(" and fltno IN ('0012','0063','0065','0067') ");
		}

	}
	sb.append("AND To_Date(fdate,'yyyy/mm/dd') BETWEEN ");
	sb.append("To_Date(?,'yyyy/mm/dd') ");
	sb.append("AND To_Date(?,'yyyy/mm/dd') ");
	sb.append("ORDER BY empno,fdate,occu");

Connection conn = null;
Driver dbDriver = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
boolean status = false;
String errMsg = "";
ci.db.ConnDB cn = new ci.db.ConnDB();
ArrayList dataAL = null;
try {
	cn.setORP3FZUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	pstmt = conn.prepareStatement(sb.toString());
	if(null == (String)session.getAttribute("base") | "".equals((String)session.getAttribute("base"))
		| "ADM".equals((String)session.getAttribute("base"))){
	//預設為TPE
		pstmt.setString(1,"TPE");
		
	}else{
		pstmt.setString(1,(String)session.getAttribute("base"));
		
	}
	
	pstmt.setString(2,request.getParameter("sdate"));
	pstmt.setString(3,request.getParameter("edate"));
	rs = pstmt.executeQuery();
	while(rs.next()){
		if(dataAL == null){
			dataAL = new ArrayList();
		}		
		SwapFlightObj obj = new SwapFlightObj();
		obj.setCname(rs.getString("cname"));
		obj.setComments(rs.getString("comments"));
		obj.setEmpno(rs.getString("empno"));
		obj.setFdate(rs.getString("fdate"));
		obj.setFltno(rs.getString("fltno"));
		obj.setOccu(rs.getString("occu"));
		obj.setPut_date(rs.getDate("put_date"));
		obj.setSern(rs.getString("sern"));
		obj.setTripno(rs.getString("tripno"));
		dataAL.add(obj);			
		
	}
	status = true;

} catch (Exception e) {
	errMsg = e.toString();
} finally {
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

java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd");
	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="../errStyle.css">
<link rel="stylesheet" type="text/css" href="swapArea.css">
<!-- Link Tigra Hints script file to your HTML document-->
<script language="JavaScript" src="hints.js"></script>
<!-- Link Tigra Hints configuration file to your HTML document-->
<script language="JavaScript" src="hints_cfg.js"></script>

<title>可換班表</title>
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
    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="1" >
  <tr>
  <td colspan="2" class="center blue" style="font-size:larger; ">Put Schedule Query 可換班表查詢 </td>
  </tr>
  <tr>
    <td width="97%" class="left"> 	Click EmpNo to View Crew's Schedule, Name to View Crew's information.Fltno to View Flight Crew List By Trip.<br>
	點擊EmpNo可檢視組員班表,點擊Name可查詢組員資料,點擊Fltno可檢視該任務組員名單.</td>
    <td width="3%" class="right"><a href="javascript:window.print()"><img src="../images/print.gif" border="0"></a></td>
  </tr>
</table>
    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="1" style="border:1pt solid black;border-collapse:collapse; " >
      <tr > 
        <th width="8%" >Empno<br>
        <span style="font-size:smaller ">(Skj)</span> </th>
        <th width="5%">Sern</th>
        <th width="8%">Name</th>
        <th width="9%">Fdate</th>
		<th width="10%" >Fltno<br>
		  <span style="font-size:smaller ">(Crew List)</span> </th>
        <th width="7%">TripNo</th>
        <th width="6%">Occu</th>
		<th width="37%">Comments</th>
        <th width="10%">PutDate</th>
      </tr>
      <%
  for(int i=0;i<dataAL.size();i++){
  	SwapFlightObj obj = (SwapFlightObj)dataAL.get(i);
	String cssStyle = "";
	if (i%2 == 1)	{
		cssStyle = "gridRowEven";
	}	else{
		cssStyle = "gridRowOdd";
	}
%>
      <tr class="<%=cssStyle %>"> 
        <td  class="center"> <a name="<%=i%>" href="#<%=i%>"  onMouseOver="myHint.show('vSkj')" onMouseOut="myHint.hide()" onClick="javascript:viewCrew('<%=obj.getEmpno()%>');"><%=obj.getEmpno()%></a>   </td>
        <td  class="right"> <%=obj.getSern()%>   </td>
        <td class="center"> <a name="<%=i%>" href="#<%=i%>" onMouseOver="myHint.show('vCrew')" onMouseOut="myHint.hide()" onClick="javascript:viewCrewInfo('<%=obj.getEmpno()%>');"><%=obj.getCname()%></a>   </td>
        <td class="center"> <%=obj.getFdate()%>   </td>
        <td class="right"> <a href="#<%=i%>" onMouseOver="myHint.show('vList')" onMouseOut="myHint.hide()" onClick="javascript:viewFlightCrew('<%=obj.getTripno()%>');"><%=obj.getFltno()%></a>   </td>
        <td  class="right"> <%=obj.getTripno()%>   </td>
        <td  class="center"> <%=obj.getOccu()%>   </td>
        <td class="left"> <%=obj.getComments()%> </td>
        <td  class="center"> <%=formatter.format(obj.getPut_date())%>   </td>		
	  </tr>
      <%
		  }

%>
  <tr>
  <td colspan="9"><br>
	Click EmpNo to View Crew's Schedule, Name to View Crew's information.Fltno to View Flight Crew List By Trip.<br>
	點擊EmpNo可檢視組員班表,點擊Name可查詢組員資料,點擊Fltno可檢視該任務組員名單.
  </td>
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
	function viewFlightCrew(tripno){
		document.getElementById("tripno").value = tripno;
		//document.form1.action="viewFlightCrew.jsp";
		document.form1.action="viewFlightCrew.jsp";
		document.form1.submit();
	
	}
	
	function viewCrewInfo(empno){
		document.getElementById("tf_empno").value = empno;
		document.form1.action="crewInfo.jsp";				
		document.form1.submit();
	}

</script>
<%
}
%>
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
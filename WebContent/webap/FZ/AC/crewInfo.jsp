<%@ page contentType="text/html; charset=big5" language="java"%>
<%@page import="fz.*,java.sql.*,ci.db.*,java.util.Date,java.text.DateFormat, java.net.URLEncoder"%>
<jsp:useBean id="unicodeStringParser" class="cs40javabean.UnicodeStringParser" />
<%!
public class CrewInfoObj{
	private String empno;
	private String cname;
	private String ename;
	private String sern;
	private String sess;	
	private String occu;
	private String fleet;
	private String base;
	private String mobile;
	private String home;
	private String icq;
	
	public String getBase() {
		return base;
	}
	
	public void setBase(String base) {
		this.base = base;
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
	
	public String getFleet() {
		return fleet;
	}
	
	public void setFleet(String fleet) {
		this.fleet = fleet;
	}
	
	public String getHome() {
		return home;
	}
	
	public void setHome(String home) {
		this.home = home;
	}
	
	public String getIcq() {
		return icq;
	}
	
	public void setIcq(String icq) {
		this.icq = icq;
	}
	
	public String getMobile() {
		return mobile;
	}
	
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
	public String getOccu() {
		return occu;
	}
	
	public void setOccu(String occu) {
		this.occu = occu;
	}
	
	public String getSern() {
		return sern;
	}
	
	public void setSern(String sern) {
		this.sern = sern;
	}
	
	public String getSess() {
		return sess;
	}
	
	public void setSess(String sess) {
		this.sess = sess;
	}	
	
}
%>
<%
//查詢其他組員資料
//response.setHeader("Cache-Control","no-cache");
//response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
String empno	= request.getParameter("tf_empno");	//員工號

if (sGetUsr == null ) 
{		
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
}

String sess1	= request.getParameter("tf_sess1");	//起始期別
String sess2	= request.getParameter("tf_sess2");	//結束期別
String tf_ename 	= request.getParameter("tf_ename");	//姓名


//String sql = "SELECT EMPNO,BOX,SESS,NAME,ENAME,CABIN,OCCU,FLEET,BASE,EMAIL,MPHONE,HPHONE,ICQ FROM FZTCREW ";
String sql = 
"SELECT a.EMPNO, b.seniority_code BOX, b.preferred_name NAME, CABIN, " +
       "c.rank_cd OCCU, a.FLEET, d.base BASE, a.EMAIL, a.MPHONE, a.HPHONE, a.ICQ "+ 
"FROM FZTCREW a, crew_v b, crew_rank_v c, crew_base_v d "+
"WHERE a.empno=b.staff_num and a.empno=c.staff_num and a.empno=d.staff_num "+
"and (c.exp_dt is null or c.exp_dt > sysdate) "+
"and (d.exp_dt is null or d.exp_dt > sysdate) and d.prim_base='Y' ";

//out.print(tf_ename);
if(!tf_ename.equals("")){//用姓名查詢
	//sql = sql + " WHERE NAME LIKE '%" + tf_ename + "%'  AND LOCKED='N'";
	sql = sql + " and a.NAME LIKE '%" + tf_ename + "%'  AND (a.LOCKED='N' or a.LOCKED  is null)";
}
else{
	if ( empno.equals("")){	//以期別查詢
	
		if(sess2.equals("")){	//以單一期別查詢
			//sql = sql + " WHERE SESS = '" + sess1 + "'  AND LOCKED='N'";
			sql = sql + " and SUBSTR(b.seniority_code,1,5) = LPAD('"+ sess1 +"', 5, '0') AND (LOCKED='N' or LOCKED is null) ";
			//out.println(sql);	
		}
		else
		{	//以介於兩個期別間查詢
			//sql = sql + " WHERE to_number(SESS) >= " + sess1 + " AND to_number(SESS) <= " + sess2 +"  AND LOCKED='N'";
			//sql = sql + " and to_number(SUBSTR(b.seniority_code,1,5)) >= " + sess1 + " AND to_number(SUBSTR(b.seniority_code,1,5)) <= " + sess2 +"  AND LOCKED='N'";

			sql = sql + " AND SUBSTR(LPad(Nvl(Trim(seniority_code),0),7,0),3,3) BETWEEN '" + sess1 + "' AND '" + sess2 +"' AND (LOCKED='N' or LOCKED is null)  ";
			//out.println(sql);
		}
	
	}
	else{	//以員工號查詢
		if(empno.length()<6){
			//sql = sql +" WHERE TRIM(BOX) = '"+ empno + "'  AND LOCKED='N'";
			//sql = sql +" and to_char(to_number(b.seniority_code)) = '"+ empno + "'  AND LOCKED='N'";
			sql = sql +" and to_char(trim(b.seniority_code)) = '"+ empno + "'  AND (LOCKED='N' or LOCKED is null)";
		}
		else{
		//sql = sql + " WHERE EMPNO = '" + empno + "' AND LOCKED='N' ";
		sql = sql + " and a.EMPNO = '" + empno + "' AND (LOCKED='N' or LOCKED is null) ";
		//out.println(sql);
		}
	}
}
sql = sql + " order by empno";

if("640790".equals(sGetUsr))
{
//out.println(sql);
}

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
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	while(rs.next()){
		if(dataAL == null){
			dataAL = new ArrayList();
		}		
		CrewInfoObj obj = new CrewInfoObj();
			
	    String cname = rs.getString("name"); if (cname == null) {cname = "";}
        String tempCname = unicodeStringParser.removeExtraEscape(cname);
        String big5Cname = new String(tempCname.getBytes(), "Big5");
        cname = big5Cname;

    	obj.setCname(cname);
    	obj.setEmpno(rs.getString("empno"));
    //	obj.setEname(rs.getString("ename"));
    	obj.setFleet(rs.getString("fleet"));
    	obj.setHome(rs.getString("HPHONE"));
    	obj.setIcq(rs.getString("icq"));
    	obj.setMobile(rs.getString("MPHONE"));
    	obj.setOccu(rs.getString("occu"));
    	obj.setSern(rs.getString("box"));
    	//obj.setSess(rs.getString("sess"));
		obj.setBase(rs.getString("BASE"));
		dataAL.add(obj);			
		
	}
	rs.close();
	pstmt.close();
	conn.close();
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

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Crew Qeury</title>
<link href="../AC/swapArea.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="../errStyle.css">
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
<p class="errStyle1">ERROR:<%=errMsg%></p>
<%
}else if(dataAL == null){

%>
<p class="errStyle1">NO DATA.</p>
<%
}else{
%>
<table width="95%" align="center"  border="0" cellpadding="0" cellspacing="1" >
    <tr> 
      <td colspan="2" class="center blue"> 
       Crew Query       </td>
    </tr>
    <tr>
      <td class="left">Click EmpNo to View Crew's Schedule, Mail to mail that crew.<br>
點擊EmpNo可檢視組員班表,點擊Mail圖示可寄送Email與該組員.</td>
      <td width="5%" class="right"><a href="javascript:window.print()"> <img src="../images/print.gif" width="17" height="15" border="0" alt="列印"></a></td>
    </tr>
</table>

    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="1" style="border:1pt solid black;border-collapse:collapse; ">
      <tr>
        <th width="8%">EmpNO</th>
        <th width="6%">Name</th>
        
        <th width="6%">Sern</th>
        
        <th width="6%">Occu</th>
        <th width="6%">Fleet</th>
        <th width="6%">Base</th>
        <th width="6%">Mail</th>
        <th width="16%">Mobile</th>
        <th width="12%">Home</th>
        <th width="9%">ICQ</th>
      </tr>
      <%
  for(int i=0;i<dataAL.size();i++){
  	CrewInfoObj obj = (CrewInfoObj)dataAL.get(i);
	String cssStyle = "";
	if (i%2 == 1)	{
		cssStyle = "gridRowEven";
	}	else{
		cssStyle = "gridRowOdd";
	}
%>
      <tr class="center <%=cssStyle %>">
        <td ><a  name="<%=i%>" href="#<%=i%>" onMouseOver="myHint.show(0)" onMouseOut="myHint.hide()" onClick="javascript:viewCrew('<%=obj.getEmpno()%>');"><%=obj.getEmpno()%></a></td>
        <td class="left" ><%=obj.getCname()%></td>
        
        <td class="right" ><%=obj.getSern()%></td>
        
        <td ><%=obj.getOccu()%></td>
        <td ><%=obj.getFleet()%></td>
        <td ><%=obj.getBase()%></td>
        <td ><a href="#<%=i%>" onMouseOver="myHint.show(3)" onMouseOut="myHint.hide()" onClick="javascript:emailCrew('<%=obj.getEmpno()%>','<%=obj.getCname()%> <%=obj.getEname()%>');"><img src="../img2/Send.gif"  border="0"></a></td>
        <td  class="left" ><%=obj.getMobile()%></td>
        <td  class="left" ><%=obj.getHome()%></td>
        <td  class="left" ><%=obj.getIcq()%></td>
      </tr>
      <%
}
%>
    </table>
    <form name="formV" method="post" id="form1" target="_blank">
	<input type="hidden" name="empno" id="empno">
	<input type="hidden" name="cname" id="cname">
	<input type="hidden" name="to" id="to">
</form>
<script language="javascript" type="text/javascript">
	function viewCrew(empno){
		document.getElementById("empno").value = empno;
		document.formV.action="../AC/crewSkj.jsp";
		document.formV.submit();
	}
	function emailCrew(empno,cname){
		document.getElementById("empno").value = empno;
		document.getElementById("to").value = empno+"@cal.aero";		
		document.getElementById("cname").value = cname;		
		document.formV.action="../mail.jsp";
		document.formV.submit();
	}	
</script>
<%}%>
<script language="javascript" type="text/javascript">
if(top.topFrame != null){
	if(top.topFrame.document.getElementById("submit") != null){
		top.topFrame.document.getElementById("submit").disabled=0;
	}
	if(top.topFrame.document.getElementById("showStatus") != null){
		top.topFrame.document.getElementById("showStatus").className="hiddenStatus";
	}
}
	

</script>

</body>
</html>

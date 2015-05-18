<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,ci.db.*"%>
<%!
public class SwapFormObj {
	private String formNo;
	private String aCname;
	private String aEmpno;
	private String aGroups;
	private String rCname;
	private String rEmpno;
	private String rGroups;
	private String edCheck;
	private String checkUser;
	private String comments;
	private String newDate;
	private String checkDate;
	private String chg_all;
	private String formtype;
	
	public String getFormNo() {
		return formNo;
	}
	public void setFormNo(String formNo) {
		this.formNo = formNo;
	}
	public String getACname() {
		return aCname;
	}
	public void setACname(String cname) {
		aCname = cname;
	}
	public String getAEmpno() {
		return aEmpno;
	}
	public void setAEmpno(String empno) {
		aEmpno = empno;
	}
	public String getAGroups() {
		return aGroups;
	}
	public void setAGroups(String groups) {
		aGroups = groups;
	}
	public String getRCname() {
		return rCname;
	}
	public void setRCname(String cname) {
		rCname = cname;
	}
	public String getREmpno() {
		return rEmpno;
	}
	public void setREmpno(String empno) {
		rEmpno = empno;
	}
	public String getRGroups() {
		return rGroups;
	}
	public void setRGroups(String groups) {
		rGroups = groups;
	}
	public String getEdCheck() {
		return edCheck;
	}
	public void setEdCheck(String edCheck) {
		this.edCheck = edCheck;
	}
	public String getCheckUser() {
		return checkUser;
	}
	public void setCheckUser(String checkUser) {
		this.checkUser = checkUser;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public String getNewDate() {
		return newDate;
	}
	public void setNewDate(String newDate) {
		this.newDate = newDate;
	}
	public String getCheckDate() {
		return checkDate;
	}
	public void setCheckDate(String checkDate) {
		this.checkDate = checkDate;
	}
	public String getChg_all() {
		return chg_all;
	}
	public void setChg_all(String chg_all) {
		this.chg_all = chg_all;
	}
	public String getFormtype() {
		return formtype;
	}
	public void setFormtype(String formtype) {
		this.formtype = formtype;
	}
}
%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
String username = (String) session.getAttribute("cname") ; 

if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 

String conf = request.getParameter("conf");//Y : agress, N : reject
String cdate = request.getParameter("cdate");//A : apply date, C : check date
String mysdate = request.getParameter("syy")+"/"+request.getParameter("smm")+"/"+request.getParameter("sdd");
String myedate = request.getParameter("eyy")+"/"+request.getParameter("emm")+"/"+request.getParameter("edd");
String empno = request.getParameter("empno").trim();
String sqlRs = null;
String tstring = null;
String fstring = null;

Connection conn = null;
Driver dbDriver = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
boolean status = false;
String errMsg = "";

String bcolor="";
String sql="";
ArrayList al = null;

try
{
//dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
//conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
ConnDB cn = new ConnDB();
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
if (conf.equals("Y"))
{
	sqlRs = "ed_check = 'Y' ";
	tstring = "核准";
}
else if ((conf.equals("N")))
{
	sqlRs = "ed_check = 'N' ";
	tstring = "退回";
}
else
{
	sqlRs = "ed_check in ('Y','N') ";
	tstring = "核准/退回";
}

if (cdate.equals("A"))
{
	fstring = "ApplyDate : "+mysdate+" to "+myedate;
	sqlRs+= " and to_char(newdate, 'yyyy/mm/dd') >= ? and to_char(newdate, 'yyyy/mm/dd') <= ?";
}
else
{
	fstring = "CheckDate : "+mysdate+" to "+myedate;
	sqlRs += " and to_char(checkdate, 'yyyy/mm/dd') >= ? and to_char(checkdate, 'yyyy/mm/dd') <= ?";
}

if (!empno.equals(""))
{
	sqlRs  += " and (aempno='"+empno+"' or rempno='"+empno+"') ";
}

int xCount=0;
sql = "select * from ( select to_char(f.newdate,'yyyy/mm/dd hh24:mi') newD,to_char(f.checkdate,'yyyy/mm/dd hh24:mi') checkD , f.*, 'Y' acount, '0' acomm, 'Y' rcount, '0' rcomm, 'A' formtype from fztform f where "+sqlRs+"  union all select to_char(f.newdate,'yyyy/mm/dd hh24:mi') newD,to_char(f.checkdate,'yyyy/mm/dd hh24:mi') checkD ,f.*, 'B' formtype from fztbform f where "+sqlRs+" ) order by formno";

//out.println(sql+"<br>");
pstmt = conn.prepareStatement(sql);
pstmt.setString(1,mysdate);
pstmt.setString(2,myedate);
pstmt.setString(3,mysdate);
pstmt.setString(4,myedate);
rs = pstmt.executeQuery();


	while (rs.next())
	{ 
		if(al == null){
			al = new ArrayList();
		}
		SwapFormObj obj = new SwapFormObj();

		obj.setACname(rs.getString("acname"));
		obj.setAEmpno(rs.getString("aempno"));
		obj.setAGroups(rs.getString("agroups"));
		obj.setCheckDate(rs.getString("checkD"));
		obj.setCheckUser(rs.getString("checkuser"));
		obj.setChg_all(rs.getString("chg_all"));
		obj.setComments(rs.getString("comments"));
		obj.setEdCheck(rs.getString("ed_check"));
		obj.setFormNo(rs.getString("formno"));
		obj.setNewDate(rs.getString("newD"));
		obj.setRCname(rs.getString("rcname"));
		obj.setREmpno(rs.getString("rempno"));
		obj.setRGroups(rs.getString("rgroups"));
		obj.setFormtype(rs.getString("formtype"));
		
		al.add(obj);
	}
	rs.close();
	pstmt.close();
	conn.close();
	
	status = true;
	if(al== null){
		status= false;
		errMsg = "查無資料!!<br>可能為 1.查詢日期區間內尚無資料. <br>2.無「已處理」申請單記錄.<br><br>未處理之申請單,請至「申請單處理」查詢."; 
	}
}catch (Exception e){
	status = false;
	errMsg +="ERROR:"+e.getMessage();
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}	






%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>申請單列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="../style/errStyle.css">
<link rel="stylesheet" type="text/css" href="../style/style1.css">
<link rel="stylesheet" type="text/css" href="../style/lightColor.css">
<script language="javascript" src="js/subWindow.js"></script>
<script language="javascript" type="text/javascript">
function showForm(formNo,formtype)
{
	document.getElementById("formno").value = formNo;
	subwin('blank.htm','showform');

	if(formtype=="A")
	{
		document.form1.action="swap3/showForm.jsp";
	}
	else
	{
		document.form1.action="credit/swaptpe/showBForm.jsp";
	}
	document.form1.submit();

	
}
</script>
</head>

<body>
<form name="form1" method="post" action="" target="showform" >
<input type="hidden" name="formno" id="formno">
</form>
<%

if(!status){
%>
<div class="errStyle3"><img src="images/messagebox_warning.png" align="absmiddle"><%=errMsg%></div>
<%
}else{


%>


 
  <table width="100%" border="1" cellspacing="1" cellpadding="0" style="border-collapse:collapse; ">
  <caption >
 <div class="txttitletop"><%=tstring%> 申請單記錄<br>
<%=fstring%></div>
<div class="right"><a href="javascript:window.print()"> <img src="images/print.gif" width="17" height="15" border="0" alt="列印"></a></div>
  </caption>
    <tr class="bgPurple">
		<td width="6%" height="21"  >No</td>
		<td width="6%" >Empno</td>
		<td width="8%" >Applicant</td>
		<td width="3%" >Group</td>
		<td width="6%" >Empno</td> 
		<td width="8%" >Substitute</td>
		<td width="3%" >Group</td>
		<td width="3%" >ED</td>
		<td width="14%" >CheckDate</td>
		<td width="6%"  >CheckUser</td>
		<td width="14%" >ApplyDate </td>
		<td width="20%" >EDComments </td>
		<td width="3%"  >View</td>

    </tr>
    <%
	for(int i=0;i<al.size();i++){
		SwapFormObj obj = (SwapFormObj)al.get(i);	

		if (i%2 == 1){
			bcolor = " bgLightBlue";
		}else{
			bcolor = "";
		}
		
		

%>
    <tr class="center<%=bcolor%>" style="vertical-align:text-top; "> 
		<td ><%=obj.getFormtype()%><%=obj.getFormNo()%></td>
		
		<td ><%=obj.getAEmpno()%></td>
		<td class="left"><%=obj.getACname()%></td>
		<td ><%=obj.getAGroups()%></td>
		<td ><%=obj.getREmpno()%></td>
		<td class="left"><%=obj.getRCname()%></td>
		<td ><%=obj.getRGroups()%></td>
		<td><%=obj.getEdCheck()%></td>
		<td  class="left"><%=obj.getCheckDate()%></td>
		<td><%=obj.getCheckUser()%></td>
		<td  class="left"><%=obj.getNewDate()%></td>
		<td class="left"><%=obj.getComments()%></td>
	  <td>
        <a href="javascript:showForm('<%=obj.getFormNo()%>','<%=obj.getFormtype()%>');" ><img src="images/blue_view.gif" width="16" height="16" alt="檢視換班單詳細資料" title="檢視換班單詳細資料"></a></td>
    </tr>
    
    <%
		}
	%>
<tr class="bgLGray">
      <td colspan="14">Total Records : <%=al.size()%></td>
    </tr>
  </table>
<%
}
%>  

  <br>
  <table width="77%"  border="0" cellpadding="0" cellspacing="0">
  <tr>
	  <td class="noborder"><span style="color:#FF0000 ">* </span></td>
	  <td class="noborder"><div align="left"><span style="color:#FF0000 ">A 開頭單號為三次換班申請單; B 開頭單號為積點換班申請單</span></div></td>
  </tr>
  </table>    
</body>
</html>

<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*" %>
<%!
public class RealSwapRdObj {
	private String formno;
	private String year;
	private String month;
	private String aEmpno;
	private String aCount;
	private String aComm;
	private String rEmpno;
	private String rCount;
	private String rComm;
	private String chgUser;
	private String chgDate;
	
	public String getAComm() {
		return aComm;
	}
	public void setAComm(String comm) {
		aComm = comm;
	}
	public String getACount() {
		return aCount;
	}
	public void setACount(String count) {
		aCount = count;
	}
	public String getAEmpno() {
		return aEmpno;
	}
	public void setAEmpno(String empno) {
		aEmpno = empno;
	}
	public String getChgDate() {
		return chgDate;
	}
	public void setChgDate(String chgDate) {
		this.chgDate = chgDate;
	}
	public String getChgUser() {
		return chgUser;
	}
	public void setChgUser(String chgUser) {
		this.chgUser = chgUser;
	}
	public String getFormno() {
		return formno;
	}
	public void setFormno(String formno) {
		this.formno = formno;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}

	public String getRComm() {
		return rComm;
	}
	public void setRComm(String comm) {
		rComm = comm;
	}
	public String getRCount() {
		return rCount;
	}
	public void setRCount(String count) {
		rCount = count;
	}
	public String getREmpno() {
		return rEmpno;
	}
	public void setREmpno(String empno) {
		rEmpno = empno;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}

}

%>
<%
String formno = request.getParameter("formno");

Connection conn = null;
Driver dbDriver = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
boolean status = false;
String errMSg = "";


ci.db.ConnDB cn = new ci.db.ConnDB();
RealSwapRdObj obj = null;
ArrayList citemAL = new ArrayList();

try{
	cn.setORP3FZUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	
			
pstmt = conn.prepareStatement("SELECT To_Char(r.chgdate,'yyyy/mm/dd') chgDate1,r.* "
		+"FROM fztrformf r WHERE station='KHH' and  formno=?");
	
	pstmt.setString(1,formno);
	
	rs = pstmt.executeQuery(); 

	while(rs.next()){
		obj = new RealSwapRdObj();
		obj.setAComm(rs.getString("acomm"));
		obj.setACount(rs.getString("aCount"));
		obj.setAEmpno(rs.getString("aempno"));
		obj.setChgDate(rs.getString("chgDate1"));
		obj.setChgUser(rs.getString("chguser"));
		obj.setFormno(rs.getString("formno"));
		obj.setMonth(rs.getString("mm"));
		obj.setRComm(rs.getString("rcomm"));
		obj.setRCount(rs.getString("rcount"));
		obj.setREmpno(rs.getString("rempno"));
		obj.setYear(rs.getString("yyyy"));			
	}
rs.close();

	pstmt = conn.prepareStatement("SELECT citem FROM fztrcomf where  station='KHH'  ORDER BY citem");
	rs = pstmt.executeQuery();
	while(rs.next()){
			citemAL.add(rs.getString("citem"));		
	}


status = true;



}catch (SQLException e){	 
	 errMSg = e.toString();
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>���鴫�Z�O���ק�</title>
<link  rel="stylesheet" type="text/css" href="realSwap.css">
<link  rel="stylesheet" type="text/css" href="../style/kbd.css">
<link rel="stylesheet" type="text/css" href="../loadingStatus.css">


<script language="javascript" type="text/javascript" src="../js/showDate.js"></script>
<script language="javascript" type="text/javascript" src="../js/showAndHiddenButton.js"></script>

<script language="javascript" type="text/javascript" >

function checkForm(){
	var a = document.form1.aempno.value;
	var r = document.form1.rempno.value;
	
	if(a == ""){
		alert("�п�J���Z�̭��u��!!");
		document.form1.aempno.focus();
		return false;
	}else if(r == ""){
		alert("�п�J�Q���̭��u��!!");
		document.form1.rempno.focus();
		return false;
	
	}else{
		if(confirm("�T�w�n�ק�?!")){
			disabledButton("s1");
			document.getElementById("showStatus").className="showStatus";
			return true;
		}else{
			return false;
		}
		
	}
}

</script>
</head>

<body >
<div id="showStatus" class="hiddenStatus">��Ƹ��J��...�еy��</div>

<div align="center">

<form name="form1" action="updRealSwap.jsp" method="post" onsubmit="return checkForm()">
<table width="61%"  border="0" cellpadding="0" cellspacing="0" class="tableBorder1">
<tr><td>


  <table width="100%"  border="0" cellpadding="1" cellspacing="0">
    <tr class="tableInner3">
      <td height="25" colspan="4">KHH���鴫�Z�O���ק�</td>
    </tr>
    <tr >
      <td width="15%" height="33" class="tableh5">���Z�渹</td>
      <td width="35%"  >
        <div align="left"><%=obj.getFormno()%> </div>
      </td>
      <td width="16%" class="tableh5" >���Z�~/��</td>
      <td width="34%"  >
        <select name="year">
          <option value="<%=obj.getYear()%>" selected="Y"><%=obj.getYear()%></option>
          <jsp:include page="../temple/year.htm" />
        </select>
/
<select name="month">
  <option value="<%=obj.getMonth()%>" selected="Y"><%=obj.getMonth()%></option>
  <jsp:include page="../temple/month.htm" />
</select>
</td>
    </tr>
  </table>
  <table width="100%"  border="0" cellspacing="1" cellpadding="0">
    <tr class="tableInner2">
      <td width="15%" rowspan="2">�ӽЪ� </td>
      <td width="14%" height="25">���u��</td>
      <td width="21%">���Z���ƭp��</td>
      <td width="50%">���Z�z��</td>
    </tr>
    <tr>
      <td height="29">
        <input type="text" size="6" maxlength="6" name="aempno" value="<%=obj.getAEmpno()%>">
</td>
      <td>
        <select name="aCount">
          <%
	if("Y".equals(obj.getACount())){
	%>
          <option value="Y" selected="Y">YES</option>
          <option value="N">NO</option>
          <%
	}else{
	%>
          <option value="Y" >YES</option>
          <option value="N" selected="Y">NO</option>
          <%	
	}
	%>
        </select>
</td>
      <td>
        <select name="aComm">
          <option value="<%=obj.getAComm()%>"><%=obj.getAComm()%></option>
          <option value="�L">�L</option>
          <%	for(int i=0;i<citemAL.size();i++){
			out.print("<option value=\""+citemAL.get(i)+"\">"+citemAL.get(i)+"</option>");		}		
		%>
        </select>
</td>
    </tr>
  </table>
  <table width="100%"  border="0" cellspacing="1" cellpadding="0">
    <tr class="tableInner3">
      <td width="15%" rowspan="2">�Q���� </td>
      <td width="14%" height="27">���u��</td>
      <td width="21%">���Z���ƭp��</td>
      <td width="50%">���Z�z��</td>
    </tr>
    <tr>
      <td height="29">
        <input type="text" size="6" maxlength="6" name="rempno" value="<%=obj.getREmpno()%>">
</td>
      <td>
        <select name="rCount">
          <%
	if("Y".equals(obj.getRCount())){
	%>
          <option value="Y" selected="Y">YES</option>
          <option value="N">NO</option>
          <%
	}else{
	%>
          <option value="Y" >YES</option>
          <option value="N" selected="Y">NO</option>
          <%	
	}
	%>
        </select>
</td>
      <td>
        <select name="rComm">
          <option value="<%=obj.getRComm()%>"><%=obj.getRComm()%></option>
          <option value="�L">�L</option>
          <%	for(int i=0;i<citemAL.size();i++){
			out.print("<option value=\""+citemAL.get(i)+"\">"+citemAL.get(i)+"</option>");		}		
		%>
        </select>
</td>
    </tr>
    <tr>
      <td colspan="4">
        <div align="center">
          <input type="submit" name="Submit" id="s1" value="Modify" class="kbd">
          <input type="hidden" name="formno" value="<%=obj.getFormno()%>">
          <input type="hidden" name="oYear" value="<%=obj.getYear()%>">
          <input type="hidden" name="oMonth" value="<%=obj.getMonth()%>">
        </div>
      </td>
    </tr>
  </table>
</td></tr>
</table>
</form>
</div>
</body>
</html>

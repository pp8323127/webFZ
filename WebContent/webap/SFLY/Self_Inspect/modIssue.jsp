<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,ci.db.*,java.util.*" %>
<%
//modify Self Inspection List Issue
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("../logout.jsp");
} 

String reqItemno = request.getParameter("issueNo");
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;

ConnDB cn = new ConnDB();

String issueNo  = null;
String issueDsc = null;
String flag = null;
Driver dbDriver = null;

try{

cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
sql = "select itemno, subject, flag from egtstci where itemno='"+reqItemno+"'" ;
rs = stmt.executeQuery(sql);
while(rs.next()){
	issueNo  = rs.getString("itemno");
	issueDsc = rs.getString("subject");
	flag = rs.getString("flag");
}

}catch(Exception e){
	out.print(e.toString());
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href ="../style.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript">
function checkField(){
	var v = document.form1.issueDsc.value;
	if(v == ""){
		alert("請輸入項目內容(Iuuse Description)\nPLease insert the Issue Description");
		document.form1.issueDsc.focus();
		return false;
	}else{
		return true;
	}
}	
</script>

<title>Edit Self Inspection List Issue</title>
</head>

<body onLoad="document.form1.issueDsc.focus();">
<form name="form1" method="post" action="updSILIssue.jsp" onsubmit="return checkField()">
  <table width="65%"  border="0" align="center"  class="tablebody">
    <tr class="tablehead">
      <td width="10%"><div align="center">IssueNo</div></td>
      <td width="85%"><div align="center">Issue Description </div></td>
      <td width="5%"><div align="center">Flag</div></td>
    </tr>
    
	<tr>
      <td><%=issueNo%></td>
      <td><div align="left">
          <input name="issueDsc" type="text" id="issueDsc" value="<%=issueDsc%>" size="60" maxlength="150"></div>
	  </td>
	  <td>
		<select name="flag" >
			<option value="<%=flag%>"><%=flag%></option>
			<option value="Y">Y</option>
			<option value="N">N</option>
		</select>
	  </td>
    </tr>	
    <tr>
      <td colspan="3">
        <div align="center">
          <input name="Submit" type="submit" class="button1" value="Update">&nbsp;&nbsp;
          <input type="reset" name="reset" value="Reset">&nbsp;&nbsp;
          <input type="button" name="closew" value="Close Window" onclick="window.close()">
		  <input type="hidden" name="issueNo" value="<%=issueNo%>">
        </div>
      </td>
    </tr>
  </table>
</form>

</body>
</html>

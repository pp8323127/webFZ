<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="java.sql.*"%>
<%
//刪除組員申請附註
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login

} 

String[] comm = request.getParameterValues("checkdel");

Connection conn = null;
Driver dbDriver = null;

PreparedStatement pstmt = null;
ci.db.ConnDB cn = new ci.db.ConnDB();
String errMsg = "";
boolean status = false;

try {

	if (comm == null) {
		errMsg = "請勾選欲刪除之項目!!";

	} else {
		cn.setORP3FZUserCP();
		dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
		conn = dbDriver.connect(cn.getConnURL(), null);

		pstmt = conn
				.prepareStatement("delete fztccomf where station='KHH' and citem=?");
		for (int i = 0; i < comm.length; i++) {
			pstmt.setString(1, comm[i]);
			pstmt.executeUpdate();
		}
		pstmt.close();
		status = true;
	}
} catch (Exception e) {
	errMsg += e.toString();
} finally {

	try {
		if (pstmt != null)
			pstmt.close();
	} catch (SQLException e) {}
	try {
		if (conn != null)
			conn.close();
	} catch (SQLException e) {}
}


if (!status) {
%>
<div style="background-color:#99FFFF;
		color:#FF0000;
		font-family:Verdana;
		font-size:10pt;padding:5pt;
		text-align:center; ">刪除失敗!!<br>
ERROR: <%=errMsg%><br>
<a href="crewcomm.jsp" target="_self">BACK</a></div>

<%	
} else {
%>
<script language="javascript" type="text/javascript">
	alert("刪除成功!!");
	self.location.href="crewcomm.jsp";
</script>

<%

}
%>

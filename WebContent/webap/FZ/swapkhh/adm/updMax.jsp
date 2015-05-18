<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,java.sql.*,ci.db.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login

if (sGetUsr == null) 
{		
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
}

Connection conn = null;
Driver dbDriver = null;
PreparedStatement pstmt = null;


ci.db.ConnDB cn = new ci.db.ConnDB();
String maxformcount = "0";

if (!"".equals(request.getParameter("maxcount"))
		&& null != request.getParameter("maxcount")) {
	maxformcount = request.getParameter("maxcount");
}

String errMsg = "";
boolean status = false;

try {
	cn.setORP3FZUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);

	pstmt = conn
	.prepareStatement("UPDATE FZTCMAXf SET MAXFORM =? where station='KHH'");

	pstmt.setInt(1, Integer.parseInt(maxformcount));
	pstmt.executeUpdate();
	status = true;
} catch (Exception e) {
	errMsg = e.toString();
}finally {
	
	if (conn != null)
		try {
			conn.close();
		} catch (SQLException e) {
			errMsg += e.toString();
		}
}

if(!status){
%>
<div style="background-color:#99FFFF;
		color:#FF0000;
		font-family:Verdana;
		font-size:10pt;padding:5pt;
		text-align:center; ">更新失敗!!<BR>
ERROR:<%=errMsg%><br>
<a href="max.jsp" target="_self">BACK</a></div>		
<%
}else{
%>
<script language="javascript" type="text/javascript">
	alert("更新成功!!");
	self.location.href="max.jsp";
</script>
<%	
	
}
%>

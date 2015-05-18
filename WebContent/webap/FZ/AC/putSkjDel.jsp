<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="ci.db.*,java.sql.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");

} 


String[] tripno = request.getParameterValues("checkdelete");
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
String sql = null;
ConnDB cn = new ConnDB();
Driver dbDriver = null;
String year = request.getParameter("year");
String month = request.getParameter("month");
try {

cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

	sql = "delete fztsput where empno=? and tripno=?";
	pstmt = conn.prepareStatement(sql);
	for(int i=0;i<tripno.length;i++){
		pstmt.setString(1,sGetUsr);
		pstmt.setString(2,tripno[i]);
		pstmt.executeUpdate();
	}

	

} catch (SQLException e) {
	//System.out.print(e.toString());
} catch (Exception e) {
	//System.out.print(e.toString());
} finally {

	if ( rs != null ) try {
		rs.close();
	} catch (SQLException e) {}
	if ( pstmt != null ) try {
		pstmt.close();
	} catch (SQLException e) {}
	if ( conn != null ) try {
		conn.close();
	} catch (SQLException e) {}

}
%>
<form action="putSkj.jsp" method="post" name="form1">
	<input type="hidden" name="year" value="<%=year%>">
	<input type="hidden" name="month" value="<%=month%>">
</form>
<script language="javascript">
document.form1.submit();
</script>


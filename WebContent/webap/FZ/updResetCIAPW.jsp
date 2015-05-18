<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*,java.util.*,ci.db.ConnDB,java.io.*,java.text.*"%>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if ( sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 


ConnDB cn = new ConnDB();

Driver dbDriver = null;
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;	
String sql = null;
try{
	cn.setAOCIPRODCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	
	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);	
	sql = "update user_login_v A set A.PASSWORD = "+
		"(select B.PASSWORD from user_login_v B where B.USER_ID = 'aircrews') "+
		"where A.USER_ID = '"+sGetUsr+"' ";
//	out.print(sql);
	stmt.executeQuery(sql);
/*
ResetCIAPwLog rw = new ResetCIAPwLog();
rw.writeLog(sGetUsr);
*/

fz.writeLog wl = new fz.writeLog();
wl.updLog(sGetUsr, request.getRemoteAddr(),request.getRemoteHost(), "FZ333");

ci.tool.WriteLog wl2 = new ci.tool.WriteLog("/apsource/csap/projfz/webap/Log/reset_cia_log.txt");
wl2.WriteFileWithTime(sGetUsr+"\t"+request.getRemoteAddr()+"\t Reset CIA Password");

	
}
catch (Exception e)
{
	 
	  out.print(e.toString());
}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>update Reset CIA Password</title>
<link href="menu.css" rel="stylesheet" type="text/css">
</head>
<script>
	alert("Success!!");
</script>
<body>
<div align="center">
    <p><span class="txtxred">Reset Password Success!!<br>
    <br>
Reset 後需稍待1~30分鐘系統同步.<br>

  </span></p>
    <p><br>
    
	  <input type="button"  onClick="javascript:window.open('http://cia.china-airlines.com');" value=" CIA 班表查詢" style="background-color: #edf3fe;color: #000000;text-align: center; "  >
        </p>
</div>
</body>
</html>

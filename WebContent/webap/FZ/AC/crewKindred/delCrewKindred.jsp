<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<%
String userid = (String)session.getAttribute("userid");
String errMsg = "";
boolean status = false;
if(userid == null){
	errMsg = "網頁已過期,請重新登入.";
}else{
	String kindSName = request.getParameter("kindSName");
	String kindFName  = request.getParameter("kindFName");
	String kindMbl = request.getParameter("kindMbl");
	Connection conn = null;
	PreparedStatement pstmt = null;
	ci.db.ConnDB cn = new ci.db.ConnDB();
	Driver dbDriver = null;

	try {     
	
	cn.setORP3FZUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	conn.setAutoCommit(false);
	pstmt = conn.prepareStatement("update fztckind set delete_ind='Y',apply_time=sysdate "
			+"where empno=? and export_ind='N' and delete_ind='N'");
	pstmt.setString(1,userid);
	
	pstmt.executeUpdate();
	conn.commit();

	status = true;
	}catch(Exception e){
		status = false;
		errMsg += e.getMessage();
	
		try {
		//有錯誤時 rollback
			conn.rollback();
		} catch (SQLException e1) {
			errMsg += e1.getMessage();
		}
	}  finally {
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

}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>刪除家屬聯絡資料</title>
<link rel="stylesheet" type="text/css" href="../../checkStyle1.css">
<link rel="stylesheet" type="text/css" href="../../lightColor.css">
<link rel="stylesheet" type="text/css" href="../../../style/kbd.css">
</head>

<body>
<%
if(!status){
%>
<div class="paddingTopBottom1 bgLYellow red center"><img src="../../images/messagebox_warning.png"><%=errMsg%></div>
<%
}else{



%>
<div class="paddingTopBottom1 bgLYellow red center"><img src="../../images/messagebox_info.png">資料已刪除!!</div>
<script type="text/javascript" language="javascript">
alert("資料已刪除!!");
self.location.href="editCrewKindred.jsp";
</script>
</body>
</body>
</html>
<%
}
%>
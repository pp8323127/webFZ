<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<%



String userid =(String)session.getAttribute("userid");
if(userid == null){
	response.sendRedirect("../sendredirect.jsp");
}else{

String seqno = null;
if( !"".equals(request.getParameter("seqno")) && null != request.getParameter("seqno")){
	seqno =  request.getParameter("seqno");
}

boolean status = false;
String errMsg = "";


Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
ci.db.ConnDB cn = new ci.db.ConnDB();
Driver dbDriver = null;

try {

	cn.setORP3EGUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	conn.setAutoCommit(false);

	pstmt = conn.prepareStatement("delete egtzcds where seqno=?");
	pstmt.setString(1,seqno);//seqno
	
	pstmt.executeUpdate();
	pstmt.close();	

	pstmt = conn.prepareStatement("delete egtzcdm where seqno=?");
	pstmt.setString(1,seqno);//seqno
	
	pstmt.executeUpdate();
	pstmt.close();	

conn.commit();

status = true;

	

}catch(SQLException e){
	status = false;
	errMsg += e.getMessage();
	try {
	//有錯誤時 rollback
		conn.rollback();
	} catch (SQLException e1) {
		errMsg += e1.getMessage();
	}
		
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
<title>刪除 Zone Chief Evaluation 資料</title>
<link rel="stylesheet" type="text/css" href="../errStyle.css">
</head>

<body>
<%
if(!status){

out.print("<div class='errStyle1'>刪除失敗!!<br>ERROR :"+errMsg+"</div>");

}else{
%>
<script language="javascript" type="text/javascript">
	alert("資料已刪除");
	self.close();
</script>
<%
}
%>


</body>
</html>
<%
}
%>
<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*"  %>
<%
String userid = (String)session.getAttribute("userid");
if(userid ==  null){
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
}else{

String formno = request.getParameter("formno");
String ed_check = request.getParameter("ed_check");
String addcomm = request.getParameter("addcomm").trim();
String comm = request.getParameter("comm").trim();
String aEmpno = request.getParameter("aEmpno");
String rEmpno = request.getParameter("rEmpno");
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;
ci.db.ConnDB cn = new ci.db.ConnDB();
Driver dbDriver = null;
int rowCount = 0;
boolean status =false;
String errMsg = "";
try{
//User connection pool 
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);




stmt = conn.createStatement();

sql = "update fztformf set ed_check='"+ed_check+"',comments='"
+addcomm+comm+"',checkuser='"+userid+"',checkdate=sysdate where station='KHH' and  formno='"+formno+"'";


rowCount = stmt.executeUpdate(sql);
}catch (SQLException e){
	  out.print(e.toString());
}catch (Exception e){
	  out.print(e.toString());
}finally{

	if (rs != null) try {rs.close();} catch (SQLException e) {}	
	if (stmt != null) try {stmt.close();} catch (SQLException e) {}
	if (conn != null) try { conn.close(); } catch (SQLException e) {}
}

if(rowCount == 1){	//mail 與組員.

ci.tool.DeliverMail dm = new ci.tool.DeliverMail();
String msg = "ApplyNumber : "+formno+" \r\nConfirm : "+ed_check+"\r\nComments : "+addcomm+" "+comm;

	try{
//		dm.DeliverWithSenderName("客艙組員任務互換申請單[狀態更新通知]","640073",msg,"TPEED","Big5");
		dm.DeliverWithSenderName("客艙組員任務互換申請單[狀態更新通知]",aEmpno,msg,"KHHEF","Big5");
		dm.DeliverWithSenderName("客艙組員任務互換申請單[狀態更新通知]",rEmpno,msg,"KHHEF","Big5");		
		status = true;
	}catch (Exception e) {

		errMsg = "任務互換申請單[狀態更新通知] ERROR:\r"+e.toString();
	}

}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Re-Update Swap Form</title>
<link href="../style/errStyle.css" rel="stylesheet" type="text/css">
</head>

<body>
<div class="errStyle1">
  <%
if(rowCount == 1){
	if(status){//更新成功&mail成功!!
		out.print("申請單狀態更新成功,並重新寄送email通知組員");
	}else{//更新成功.mail失敗
		out.print("申請單狀態更新成功<br>");
		out.print("email傳送失敗.<br>");
		//out.print("測試版不寄送EMAIL.");
	}
}else{	//更新失敗
		out.print("申請單狀態更新失敗<br>");
}
%>
</div>
</body>
</html>
<%
}
%>
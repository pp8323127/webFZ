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

if(rowCount == 1){	//mail �P�խ�.

ci.tool.DeliverMail dm = new ci.tool.DeliverMail();
String msg = "ApplyNumber : "+formno+" \r\nConfirm : "+ed_check+"\r\nComments : "+addcomm+" "+comm;

	try{
//		dm.DeliverWithSenderName("�ȿ��խ����Ȥ����ӽг�[���A��s�q��]","640073",msg,"TPEED","Big5");
		dm.DeliverWithSenderName("�ȿ��խ����Ȥ����ӽг�[���A��s�q��]",aEmpno,msg,"KHHEF","Big5");
		dm.DeliverWithSenderName("�ȿ��խ����Ȥ����ӽг�[���A��s�q��]",rEmpno,msg,"KHHEF","Big5");		
		status = true;
	}catch (Exception e) {

		errMsg = "���Ȥ����ӽг�[���A��s�q��] ERROR:\r"+e.toString();
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
	if(status){//��s���\&mail���\!!
		out.print("�ӽг檬�A��s���\,�í��s�H�eemail�q���խ�");
	}else{//��s���\.mail����
		out.print("�ӽг檬�A��s���\<br>");
		out.print("email�ǰe����.<br>");
		//out.print("���ժ����H�eEMAIL.");
	}
}else{	//��s����
		out.print("�ӽг檬�A��s����<br>");
}
%>
</div>
</body>
</html>
<%
}
%>
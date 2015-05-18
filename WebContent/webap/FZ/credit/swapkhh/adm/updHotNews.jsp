<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,java.sql.*,java.text.*,java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
//KHH 更新最新消息
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
 
 
} 
String ms = request.getParameter("ms").trim();

Connection conn = null;
Driver dbDriver = null;
PreparedStatement pstmt = null;
ci.db.ConnDB cn = new ci.db.ConnDB();

String errMsg = "";
boolean status = false;
try{

cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

pstmt = conn.prepareStatement("update fzthotn set ms=replace(?,'\r\n','<BR>'),chgdate=sysdate,chguser=? where flag=2 and station='KHH'");
pstmt.setString(1,ms);
pstmt.setString(2,sGetUsr);
pstmt.executeUpdate();

pstmt.close();
conn.close();
status = true;

} catch (Exception e) {
	errMsg = e.toString();
}finally {
	if (pstmt != null)
		try {
			pstmt.close();
		} catch (SQLException e) {}
	if (conn != null)
		try {
			conn.close();
		} catch (SQLException e) {}
}


if(!status){
%>
<div style="background-color:#99FFFF;
		color:#FF0000;
		font-family:Verdana;
		font-size:10pt;padding:5pt;
		text-align:center; ">更新失敗!!<br>
  ERROR:<%=errMsg%><br>
<a href="edHotNews.jsp" target="_self">BACK</a></div>
<%	
}else{
%>
<script language="javascript" type="text/javascript">
	alert("更新成功!!");
	self.location.href="edHotNews.jsp";
</script>
<%
}
%>

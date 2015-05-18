<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,java.sql.*,ci.db.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
 %>
 <jsp:forward page="sendredirect.jsp" /> 
<%
} 
Connection conn = null;
Driver dbDriver = null;

Statement stmt = null;
ResultSet myResultSet = null;
boolean t = false;
try
{
ConnDB cn = new ConnDB();
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement();

String userid 	=(String) session.getAttribute("userid") ; 
String papers = request.getParameter("papers");
String openday = request.getParameter("openday");
String opentime = request.getParameter("opentime");
String offday = request.getParameter("offday");

String sql = "UPDATE egtalco SET offday =" + offday +", papers = "+papers+", openday="+openday+", opentime='"+opentime+"'" ;
stmt.executeUpdate(sql); 	//執行
}
catch (Exception e)
{
	  t = true;
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
if(t)
{
%>
      <jsp:forward page="err.jsp" /> 
<%
}
else
{
%>
	<script language="javascript" type="text/javascript">
	alert("更新完成");	
	window.location.href="alparaset.jsp";
	</script>
<%
}
%>

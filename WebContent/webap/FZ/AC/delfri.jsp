<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,java.sql.*,ci.db.*"%>
<%
//delete good friend
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
 %>
 <jsp:forward page="../sendredirect.jsp" /> 
<%
} 

String[] friend = request.getParameterValues("to");

if(friend == null){
%>
		<jsp:forward page="../showmessage.jsp">
		<jsp:param name="messagestring" value="Error!!<br>尚未選擇要刪除何筆資料<br><a href='javascript:history.back(-1)'>back</a>" />
		</jsp:forward>
<%
}

String ks=null;
String sql=null;
for(int i=0;i<friend.length;i++)
{
	if (i==0)
	{
		ks = "'"+friend[i]+"'";
	}
	else
	{
		ks = ks+",'"+friend[i]+"'";
	}
}
sql = "delete fztfrid where empno='"+ sGetUsr+"' and  bf_empno in ("+ks+")";

Connection conn = null;
Driver dbDriver = null;

Statement stmt = null;
ResultSet myResultSet = null;
boolean t = false;
try{

ConnDB cn = new ConnDB();
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

//dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
//conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);

stmt = conn.createStatement();


stmt.executeUpdate(sql); 	
	
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
      <jsp:forward page="../err.jsp" /> 
<%
}
%>
<jsp:forward page="goodfriend.jsp" />

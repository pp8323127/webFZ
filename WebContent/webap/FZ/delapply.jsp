<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,java.sql.*,ci.db.*"%>
<%
//cancel apply form
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
 %>
 <jsp:forward page="sendredirect.jsp" /> 
<%
} 

String[] formno = request.getParameterValues("checkapply");

if (formno == null)
{
	%>
	<jsp:forward page="showmessage.jsp">
	<jsp:param name="messagestring" value="No ApplyForm been Delete !" />
	</jsp:forward>
	<%
}

String ks = null;
String sql = null;
String sql2 = null;

for(int i = 0; i < formno.length; i++)
{
	if (i==0)
	{
		ks = formno[i];
	}
	else
	{
		ks = ks+","+formno[i];
	}
}
sql = "delete fztform where formno in ("+ks+")";
sql2 = "delete fztaply where formno in ("+ks+")";

Connection conn = null;
Driver dbDriver = null;

Statement stmt = null;
boolean t = false;

try{
//dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
//conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
ConnDB cn = new ConnDB();
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement();

stmt.executeUpdate(sql); 	//°õ¦æ
stmt.executeUpdate(sql2);

}
catch (Exception e)
{
	  t = true;
}
finally
{
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
if(t)
{
%>
      <jsp:forward page="err.jsp" /> 
<%
}
%><jsp:forward page="applyquery.jsp" />

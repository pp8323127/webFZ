<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,java.sql.*,ci.db.*"%>
<%
//刪除不收單日

response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
 %>
 <jsp:forward page="sendredirect.jsp" /> 
<%
} 
String[] setdate = request.getParameterValues("checkdel");

if(setdate == null)
{
%>
		<jsp:forward page="showmessage.jsp">
		<jsp:param name="messagestring" value="No selected date!!" />
		</jsp:forward>
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

String ks=null;
String sql=null;
for(int i=0;i<setdate.length;i++)
{
	if (i==0)
	{
		ks = "'"+setdate[i]+"'";
	}
	else
	{
		ks = ks+",'"+setdate[i]+"'";
	}
}

sql = "delete fztsetd where station='TPE' and to_char(setdate,'YYYY/MM/DD hh24:mi') in ("+ks+")";


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
      <jsp:forward page="err.jsp" /> 
<%
}
%>
<jsp:forward page="setdate.jsp" />

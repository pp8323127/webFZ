<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,java.sql.*"%>

<%

//??Comment
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
 %>
 <jsp:forward page="sendredirect.jsp" /> 
<%
} 

String[] fltno = request.getParameterValues("checkdel");

if(fltno == null){
%>
		<jsp:forward page="showmessage.jsp">
		<jsp:param name="messagestring" value="No selected flight!!<br><a href='javascript:history.back(-1)'>back</a>" />
		</jsp:forward>
<%
}

String ks=null;
String sql=null;
for(int i=0;i<fltno.length;i++)
{
	if (i==0)
	{
		ks = "'"+fltno[i]+"'";
	}
	else
	{
		ks = ks+",'"+fltno[i]+"'";
	}
}
sql = "delete fztfavr where empno = '"+sGetUsr+"' and fltno in ("+ks+")";

ConnORA co = null;
Statement stmt = null;
boolean t = false;
try{
co = new ConnORA();
stmt = co.getConnORA().createStatement();


stmt.executeUpdate(sql); 	
}
catch (Exception e)
{
	  t = true;
}
finally
{
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(co != null) co.close();}catch(SQLException e){}
}
if(t)
{
%>
      <jsp:forward page="err.jsp" /> 
<%
}
%>
<jsp:forward page="favorflt.jsp" />

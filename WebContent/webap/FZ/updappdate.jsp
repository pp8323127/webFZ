<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,java.sql.*,ci.db.*"%>
<%
//新增不收單日
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
String sdateyyyy = request.getParameter("sdateyyyy");
String sdatemm = request.getParameter("sdatemm");
String sdatedd = request.getParameter("sdatedd");
String sdatehh = request.getParameter("sdatehh");
String sdatemi = request.getParameter("sdatemi");
String edateyyyy = request.getParameter("edateyyyy");
String edatemm = request.getParameter("edatemm");
String edatedd = request.getParameter("edatedd");
String edatehh = request.getParameter("edatehh");
String edatemi = request.getParameter("edatemi");

//判斷是否已有值
int count = 0;
String sqlquery ="select setdate from fztsetd where station='TPE' and to_char(setdate,'YYYY/MM/DDhh24mi') ='"+sdateyyyy+"/"+sdatemm+"/"+sdatedd+sdatehh+sdatemi+"'";
out.println(sqlquery+"<br>");
myResultSet = stmt.executeQuery(sqlquery);
	if(myResultSet != null)
	{
		while(myResultSet.next())
		{
			count++;
		}
	}

if(count != 0)
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}

%>
<jsp:forward page="setdate.jsp" />
<%
}
else
{
String sql = "insert into fztsetd(setdate,station,setedate) values(to_date('"+sdateyyyy+"/"+sdatemm+"/"+sdatedd+sdatehh+sdatemi+"','YYYY/MM/DDhh24mi'),'TPE',to_date('"+edateyyyy+"/"+edatemm+"/"+edatedd+edatehh+edatemi+"','YYYY/MM/DDhh24mi'))";

stmt.executeUpdate(sql); 	//執行
}
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
%><jsp:forward page="setdate.jsp" />

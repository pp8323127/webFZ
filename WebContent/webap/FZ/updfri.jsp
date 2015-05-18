<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,java.sql.*,ci.db.*"%>
<%
//update friend list
/*response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);*/
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
try{

//dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
//conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
ConnDB cn = new ConnDB();
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement();

String userid 	=(String) session.getAttribute("userid") ; 
String addfri = request.getParameter("addfrid");


//§PÂ_¬O§_¦³­È
int count = 0;
String sqlquery ="select bf_empno from fztfrid where (empno='"+ sGetUsr+"' and bf_empno='"+addfri+"')";
myResultSet = stmt.executeQuery(sqlquery);
	if(myResultSet != null){
		while(myResultSet.next()){
		count++;
		}
	}
if(count != 0){
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}

%>
<jsp:forward page="goodfriend.jsp" />
<%
}
else{
String sql = "insert into fztfrid(empno,bf_empno) values('"+userid+"','"+ addfri +"')";

stmt.executeUpdate(sql); 	

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
%>
<jsp:forward page="goodfriend.jsp" />

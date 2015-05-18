<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,java.sql.*,ci.db.*"%>
<%
//ED審核意見
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
 %>
 <jsp:forward page="sendredirect.jsp" /> 
<%
} 
String empno = request.getParameter("empno");
String cname = request.getParameter("cname");

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

String fltno = null;

String sql = "select fltno from fztfavr where empno = '" +empno +"' order by fltno";
%>

<html>
<head>
<title>查詢最愛航班</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="menu.css" rel="stylesheet" type="text/css">
</head>

<body>
<form  method="post" name="form1" action="delfavor.jsp">
  <table width="45%"  border="1" align="center" cellpadding="0" cellspacing="1" class="fortable">
    <tr> 
      <td colspan="3" class="tablehead3">
        <div align="center"><%=empno%> <%=cname%> 最愛的班Favorite Flight </div>
      </td>
    </tr>
    <tr> 
      <td width="68%" bgcolor="#CCCCCC"  class="tablebody">Fltno</td>
    </tr>
    <div align="center"> 
    <%
	myResultSet = stmt.executeQuery(sql); 
	if(myResultSet != null){
	while (myResultSet.next()){
		fltno = myResultSet.getString("fltno");
	%>
      <tr> 
        <td class="tablebody"> 
          <div align="center"><%=fltno%></div>
        </td>
      </tr>
      <%
		}
	}
	
	%>
    </div>
  </table>
</form>
</body>
</html>
<%
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
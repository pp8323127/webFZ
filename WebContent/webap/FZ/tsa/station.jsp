<%

String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
/*
if (session.isNew()) 
{		//check user session start first
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 
if (sGetUsr == null) 
{		//check if not login
  %> <jsp:forward page="sendredirect.jsp" /> <%
} */
%>
<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*,fz.*"%>
<%
Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet myResultSet = null;
boolean t = false;

try{
dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
stmt = conn.createStatement();

String station = null;

String sql = "select station from fztustat order by station";
myResultSet = stmt.executeQuery(sql); 

%>

<html>
<head>
<title>USA Station</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>

<body>
<form  method="post" name="form1" action="delstat.jsp">
  <table width="45%"  border="1" align="center" cellpadding="0" cellspacing="1" class="fortable">
    <tr>
      <td colspan="3" class="tablehead3"><div align="center">USA Station </div></td>
    </tr>
 <tr>
      <td width="62%" bgcolor="#CCCCCC"  class="tablebody">Station</td>
	   <td width="38%" bgcolor="#CCCCCC"  class="tablebody">Delete</td>
    </tr>

        <div align="center">
          <%
	if(myResultSet != null){
	while (myResultSet.next()){
		station = myResultSet.getString("station");
	%>
 <tr>
   <td class="tablebody">
     <div align="left"><%=station%>
         <input name="sta" type="hidden" value="<%=station%>">
         <br>
   </div></td>
   <td class="tablebody"><input name="checkdel" type="checkbox" id="checkdel" value="<%=station%>"></td>
      </tr>	  
          <%
		}
	}
	
	%>  
        </div>
   
    <tr>
      <td colspan="3"  class="tablebody"><div align="center">&nbsp;&nbsp;
          <input name="Submit" type="submit" class="btm" value="Confirm Delete">
</div></td>
    </tr>
  </table>
</form>
<br>
<form action="updstat.jsp"  method="post" name="form2" id="form2">
  <table width="45%"  border="1" align="center" cellpadding="0" cellspacing="1" class="fortable">
    <tr>
      <td colspan="2" class="tablehead3"><div align="center">Add Station </div></td>
    </tr>

        <div align="center">

 <tr>
   <td class="tablebody">     <div align="left">
         <input name="addsta" type="text" size="50" maxlength="40">
</div></td>
   </tr>	  
        </div>
   
    <tr>
      <td colspan="2"  class="tablebody"><div align="center">        &nbsp;&nbsp;
        <input name="Submit2" type="submit" class="btm" value="Confirm Add">
      </div></td>
    </tr>
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
      <jsp:forward page="../err.jsp" /> 
<%
}
%>
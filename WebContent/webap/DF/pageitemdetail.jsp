<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
if (session.isNew()) 
{		//check user session start first
  %> <jsp:forward page="login.jsp" /> <%
} 
if (sGetUsr == null) 
{		//check if not login
  %> <jsp:forward page="login.jsp" /> <%
} 
%>
<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*"%>
<%@ include file="../Connections/cnORP3DF.jsp" %>
<html>
<head>
<title>
Page Item Detail
</title>
<meta http-equiv="pragma" content="no-cache">
</head>

<body background="clearday.jpg">
<center>
  <p><font face="Comic Sans MS" color="#333333">Page Item Detail</font></p>

<%
   String pageid = request.getParameter("pageid");
     
   Class.forName(MM_cnORP3DF_DRIVER);
   Connection myConn = DriverManager.getConnection(MM_cnORP3DF_STRING,MM_cnORP3DF_USERNAME,MM_cnORP3DF_PASSWORD);
   Statement stmt = myConn.createStatement();
   ResultSet myResultSet = stmt.executeQuery("select * from DFTPAGI where pageid = '" + pageid + "'");
   if (myResultSet != null)
   {
   		while (myResultSet.next())
		{
   			String pagename = myResultSet.getString("pagename");
			String comments = myResultSet.getString("comments");
%>
  <form method="post" action="updpageitem.jsp">
    <table border="1">
      <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">PageId</font></b></td>
        <td><%= pageid %> 
          <input type="hidden" name="pageid" value="<%= pageid %>">
        </td>
      </tr>
      <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">PageName</font></b></td>
        <td><input type="text" name="pagename" value="<%= pagename %>">
        </td>
      </tr>
      <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Comments</font></b></td>
        <td><input name="comments" type="text" width="50" value="<%= comments %>">
        </td>
      </tr>
      <tr> 
        <td colspan="2"> 
          <center>
            <font face="Arial, Helvetica, sans-serif" size="2"> 
            <input type="submit" value="Update Change" >
            </font> 
          </center>
        </td>
      </tr> 
	  <tr> 
        <td colspan="2"> 
          <center>
            <font face="Arial, Helvetica, sans-serif" size="2"> <a href="delpageitem.jsp?pageid=<%=pageid%>">Delete 
            Record </a> </font> 
          </center>
        </td>
      </tr> 
    </table>
</form>
<%        
    	}  
   }
   stmt.close();
   myConn.close();
%>
</center>
</body>
</html>
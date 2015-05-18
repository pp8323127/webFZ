<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*,javax.sql.DataSource,javax.naming.*"%>
<html>
<head>
<title>
License Code
</title>
<meta http-equiv="pragma" content="no-cache">
<link href="menu.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=big5"></head>

<body >
<center>
  <span class="txttitletop">License</span><br>


<%
   Connection myConn = null;
   Statement stmt = null;
   ResultSet myResultSet = null;
   //DataSource
	Context initContext = null;
	DataSource ds = null;
	//DataSource

try{
	initContext = new InitialContext();
	//connect to AOCIPROD by Datasource
	ds = (javax.sql.DataSource)initContext.lookup("CAL.FZDS03");
	myConn = ds.getConnection();
   stmt = myConn.createStatement();	
   
%>
<table width="50%" border="1" cellpadding="0" cellspacing="0" class="fortable">
	<tr>
        <td class="tablehead3">Licence CD</td>
        <td class="tablehead3">Desc</td>     
    </tr>
<%
   myResultSet = stmt.executeQuery("select * from licence_tp_v order by 1");  
   if (myResultSet != null)
   {
   		while (myResultSet.next())
		{
%>
      <tr class="txtblue">
        <td><div align="center"><%= myResultSet.getString("licence_cd") %> </div></td>
        <td><div align="center"><%= myResultSet.getString("licence_dsc") %> </div></td>
      </tr>
<%
		}
	}
%>
</table>
<%        

}//end of try
catch(Exception e) {  
	out.print(e.toString());
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(myConn != null) myConn.close();}catch(SQLException e){}
}
%>
<input type="button" name="close" value="Close" onClick="javascript:self.close()">
</center>
</body>
</html>

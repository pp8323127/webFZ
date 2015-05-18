<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*,javax.sql.DataSource,javax.naming.*"%>
<html>
<head>
<title>
Ctry Code
</title>
<meta http-equiv="pragma" content="no-cache">
<link href="menu.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=big5"></head>

<body >
<center>
  <span class="txttitletop">Ctry</span><br>


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
        <td class="tablehead3">Ctry CD</td>
        <td class="tablehead3">Desc</td> 
		<td class="tablehead3">Oag Valid Dep</td>
		<td class="tablehead3">Oag Valid Arv</td>    
    </tr>
<%
   myResultSet = stmt.executeQuery("select ctry_cd,ctry_desc,nvl(oag_valid_dep,' ') oag_valid_dep,nvl(oag_valid_arv,' ') oag_valid_arv from countries_v order by 1");  
   if (myResultSet != null)
   {
   		while (myResultSet.next())
		{
			String dep = "";
			String arv = "";
			if(!myResultSet.getString("oag_valid_dep").equals(""))  dep = myResultSet.getString("oag_valid_dep");
			if(!myResultSet.getString("oag_valid_arv").equals(""))  arv = myResultSet.getString("oag_valid_arv");
%>
      <tr class="txtblue">
        <td><div align="center"><%= myResultSet.getString("ctry_cd") %> </div></td>
        <td><div align="center"><%= myResultSet.getString("ctry_desc") %> </div></td>
		<td><div align="center">&nbsp;<%= dep %> </div></td>
		<td><div align="center">&nbsp;<%= arv %> </div></td>
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

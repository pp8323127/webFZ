<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*"%>
<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

if (session.isNew() | sGetUsr == null) 
{		//check user session start first
  response.sendRedirect("sendredirect.jsp");
} 


   Connection conn = null;
   Statement stmt = null;
   ResultSet rs = null;
   boolean t = false;
   String occu = null;
   String fleet = null;
	ci.db.ConnDB cna = new ci.db.ConnDB();
	Driver dbDriver = null;  
	 ArrayList fleetAL = new ArrayList();
	 ArrayList occuAL = new ArrayList();
   try
   {
	cna.setDFUserCP();
	dbDriver = (Driver) Class.forName(cna.getDriver()).newInstance();
	conn = dbDriver.connect(cna.getConnURL(), null);
   
   stmt = conn.createStatement();
     rs = stmt.executeQuery("SELECT DISTINCT fleet FROM dftcrew "+
   					"where fleet IS NOT NULL and fleet NOT IN ('---',' ') "+
					"ORDER BY fleet");
	while(rs.next()){
		fleetAL.add(rs.getString("fleet"));
	}
	
	rs.close();
	
	rs = stmt.executeQuery("SELECT DISTINCT occu FROM dftcrew "+
   						 "where occu IS NOT NULL and occu NOT IN ('--',' ','FA','FS','PR') "+
						 "ORDER BY occu");
  
	while(rs.next()){
		
		occuAL.add(rs.getString("occu"));
	}		
	rs.close();	 
	conn.close();
	
	
}catch (SQLException se){
	t = true;
	
}finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}	
%>

<html>
<head>
<title>Query  Crew Record</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000" >
<table width="81%" border="0">
  <tr> 
    <td height="38"> 
      <form name="form1" method="post" action="crewrecord.jsp" target="mainFrame">
        <span class="txtblue">Fleet</span>        
        <select name="fleet" size="1">
		<%	
		for(int i=0;i<fleetAL.size();i++){
		%>		
		<option value="<%=fleetAL.get(i)%>"><%=fleetAL.get(i)%></option>
		<%}
			
		%>		  
        </select>
        <span class="txtblue">Duty</span>        
        <select name="duty" size="1">
		<%	for(int i=0;i<occuAL.size();i++){
		%>		
		<option value="<%=occuAL.get(i)%>"><%=occuAL.get(i)%></option>
		  <%
			  	
			}
		  %>
        </select>
        <span class="txtblue">Empno</span>
        <input name="empno" type="text" id="empno" size="6" maxlength="6" onClick="this.value=''">        
        <input name="Submit" type="submit" class="btm" value="Query"  >
      </form>
    </td>
  </tr>
</table>

</body>
</html>

<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*,javax.sql.DataSource,javax.naming.*"%>
<%
String empno = request.getParameter("empno");
if(empno == null){
	String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader ("Expires", 0);
	
	if (session.isNew()) 
	{		//check user session start first
	  %> <jsp:forward page="sendredirect.jsp" /> <%
	} 
	if (sGetUsr == null) 
	{		//check if not login
	  %> <jsp:forward page="sendredirect.jsp" /> <%
	} 
}
%>
<html>
<head>
<title>
DFCrew detail Information
</title>
<meta http-equiv="pragma" content="no-cache">
<link href="../menu.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=big5"></head>

<body >
<center>
  <span class="txttitletop">Crew Detail Information</span><br>


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
	//connect to ORP3 by Datasource
	ds = (javax.sql.DataSource)initContext.lookup("CAL.DFDS01");
	myConn = ds.getConnection();

   stmt = myConn.createStatement();	
   
 //  ResultSet myResultSet = stmt.executeQuery("select * from dftcrew where empno = '" + empno + "'");
   String sql = "select  empno, name, ename, sex, flag, chgid, chgtime, cabin , box, nflrk, oflrk , ovrk  , indt , poid ,"
   			  +" podt , pout , post , occu , fleet , base , sect , paycode , brk   , brkrate , banknont , banknous , "
			  +"taxfmin , ipcp, traf , sess, to_char(birthdate,'yyyy-mm-dd') birthdate, birthplace, passno , passcontry, "
			  +"passcon , nation , to_char(passvalid,'yyyy-mm-dd') passvalid, lastname, firstname, middlename from dftcrew "
			  +" where empno = '" + empno + "'";
	  
   myResultSet = stmt.executeQuery(sql);  
int count = 0;
   if (myResultSet != null)
   {
   		while (myResultSet.next())
		{
		count ++;
   			String name = myResultSet.getString("name");
			String ename = myResultSet.getString("ename");
			String sex = myResultSet.getString("sex");
			String flag = myResultSet.getString("flag");
			String cabin = myResultSet.getString("cabin");
			String box = myResultSet.getString("box");
			String nflrk = myResultSet.getString("nflrk");
			String oflrk = myResultSet.getString("oflrk");
			String ovrk = myResultSet.getString("ovrk");
			String indt = myResultSet.getString("indt");
			String poid = myResultSet.getString("poid");
			String podt = myResultSet.getString("podt");
			String pout = myResultSet.getString("pout");
			String post = myResultSet.getString("post");
			String occu = myResultSet.getString("occu");
			String fleet = myResultSet.getString("fleet");
			String base = myResultSet.getString("base");
			String sect = myResultSet.getString("sect");
			String paycode = myResultSet.getString("paycode");
			String brk = myResultSet.getString("brk");
			String brkrate = myResultSet.getString("brkrate");
			String banknont = myResultSet.getString("banknont");
			String banknous = myResultSet.getString("banknous");
			String taxfmin = myResultSet.getString("taxfmin");
			String ipcp = myResultSet.getString("ipcp");
			String traf = myResultSet.getString("traf");
	// add by cs66...start

			String birthdate	= myResultSet.getString("birthdate");//.substring(0,10);
			String birthplace	= myResultSet.getString("birthplace");
			String passno		= myResultSet.getString("passno");
			String passcontry	= myResultSet.getString("passcontry");
			String passcon		= myResultSet.getString("passcon");
			String nation		= myResultSet.getString("nation");
			String passvalid	= myResultSet.getString("passvalid");//.substring(0,10);
			String lastname		= myResultSet.getString("lastname");
			String firstname	= myResultSet.getString("firstname");
			String middlename	= myResultSet.getString("middlename");
	 // add by cs66...end
%>
  <table border="1" class="fortable">
      <tr>
        <td width="71" class="tablehead3">EmpNo</td>
        <td width="179" class="txtblue"><span class="txtblue">&nbsp;<%= empno %>           
        </span> </td>
        <td width="85" class="tablehead3">Name</td>
        <td width="166" colspan="3" class="txtblue">&nbsp;<%= name %></td>
      </tr>
      <tr>
        <td class="tablehead3">Ename</td>
        <td class="txtblue">&nbsp;<%= ename %></td>
        <td class="tablehead3">Sex</td>
        <td class="txtblue">&nbsp;<%= sex %></td>
      </tr>
      <tr>
        <td class="tablehead3">Flag</td>
        <td class="txtblue">&nbsp;<%= flag %></td>
        <td class="tablehead3">Cabin</td>
        <td class="txtblue">&nbsp;<%= cabin %></td>
      </tr>
      <tr>
        <td class="tablehead3">Box</td>
        <td class="txtblue">&nbsp;<%= box %></td>
        <td class="tablehead3">Nflrk</td>
        <td class="txtblue">&nbsp;<%= nflrk %></td>
      </tr>
      <tr>
        <td class="tablehead3">Oflrk</td>
        <td class="txtblue">&nbsp;<%= oflrk %></td>
        <td class="tablehead3">Ovrk</td>
        <td class="txtblue">&nbsp;<%= ovrk %></td>
      </tr>
      <tr>
        <td class="tablehead3">Indt</td>
        <td class="txtblue">&nbsp;<%= indt %></td>
        <td class="tablehead3">Poid</td>
        <td class="txtblue">&nbsp;<%= poid %></td>
      </tr>
      <tr>
        <td class="tablehead3">Podt</td>
        <td class="txtblue">&nbsp;<%= podt %></td>
        <td class="tablehead3">Pout</td>
        <td class="txtblue">&nbsp;<%= pout %></td>
      </tr>
      <tr>
        <td class="tablehead3">Post</td>
        <td class="txtblue">&nbsp;<%= post %></td>
        <td class="tablehead3">Occu</td>
        <td class="txtblue">&nbsp;<%= occu %></td>
      </tr>
      <tr>
        <td class="tablehead3">Fleet</td>
        <td class="txtblue">&nbsp;<%= fleet %></td>
        <td class="tablehead3">Base</td>
        <td class="txtblue">&nbsp;<%= base %></td>
      </tr>
      <tr>
        <td class="tablehead3">Sect</td>
        <td class="txtblue">&nbsp;<%= sect %></td>
        <td class="tablehead3">Paycode</td>
        <td class="txtblue">&nbsp;<%= paycode %></td>
      </tr>
      <tr>
        <td class="tablehead3">Brk</td>
        <td class="txtblue">&nbsp;<%= brk %></td>
        <td class="tablehead3">Brkrate</td>
        <td class="txtblue">&nbsp;<%= brkrate %></td>
      </tr>
      <tr>
        <td class="tablehead3">Banknont</td>
        <td class="txtblue">&nbsp;<%= banknont %></td>
        <td class="tablehead3">Banknous</td>
        <td class="txtblue">&nbsp;<%= banknous %></td>
      </tr>
      <tr>
        <td class="tablehead3">Taxfmin</td>
        <td class="txtblue">&nbsp;<%= taxfmin %></td>
        <td class="tablehead3">Ipcp</td>
        <td class="txtblue">&nbsp;<%= ipcp %></td>
      </tr>
      <tr>
        <td class="tablehead3">Traf</td>
        <td class="txtblue">&nbsp;<%= traf %></td>
        <td class="tablehead3">Birthdate</td>
        <td class="txtblue">&nbsp;<%=birthdate%></td>
      </tr>
      <tr>
        <td class="tablehead3">Birthplace</td>
        <td class="txtblue">&nbsp;<%=birthplace%></td>
        <td class="tablehead3">Passno</td>
        <td class="txtblue">&nbsp;<%=passno%></td>
      </tr>
      <tr>
        <td class="tablehead3">Passcontry</td>
        <td class="txtblue">&nbsp;<%=passcontry%></td>
        <td class="tablehead3">Passcon</td>
        <td class="txtblue">&nbsp;<%=passcon%></td>
      </tr>
      <tr>
        <td class="tablehead3">Nation</td>
        <td class="txtblue">&nbsp;<%=nation%></td>
        <td class="tablehead3">Passvalid</td>
        <td class="txtblue">&nbsp;<%=passvalid%></td>
      </tr>
      <tr>
        <td class="tablehead3">Lastname</td>
        <td class="txtblue">&nbsp;<%=lastname%></td>
        <td class="tablehead3">Firstname</td>
        <td class="txtblue">&nbsp;<%=firstname%></td>
      </tr>
      <tr>
        <td class="tablehead3">Middlename</td>
        <td colspan="3"><span class="txtblue">&nbsp;</span><%=middlename%></td>
      </tr>


  </table>
    <br>

<%        
    	}  
   }
   if( count == 0){
    try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(myConn != null) myConn.close();}catch(SQLException e){}
   %>
   <jsp:forward page="showmessage.jsp">
   <jsp:param name="messagestring" value="查無資料<br>No Record!!" />
   </jsp:forward>

   <%
   
   }
  
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

</center>
</body>
</html>

<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*"%>
<%

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

   Connection myConn = null;
   Statement stmt = null;
   ResultSet myResultSet = null;
   boolean t = false;
   String sql = null;
   String occu = null;
	ci.db.ConnDB cna = new ci.db.ConnDB();
	ArrayList al =  new ArrayList();
	Driver dbDriver = null;
   try
   {
	cna.setDFUserCP();
	dbDriver = (Driver) Class.forName(cna.getDriver()).newInstance();
	myConn = dbDriver.connect(cna.getConnURL(), null);

   
   stmt = myConn.createStatement();
   sql = "SELECT DISTINCT occu FROM dftcrew "+
   		 "where occu IS NOT NULL and occu NOT IN ('--',' ','FA','FS','PR') "+
		 "ORDER BY occu";
   myResultSet = stmt.executeQuery(sql);
	while(myResultSet.next()){
		al.add(myResultSet.getString("occu"));
	}
}catch (SQLException se)
{
	t = true;
	
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(myConn != null) myConn.close();}catch(SQLException e){}
}	
%>
<html>
<head>
<title>
Insert Crew Information
</title>
<meta http-equiv="pragma" content="no-cache">
<link href="../menu.css" rel="stylesheet" type="text/css">

</head>

<body background="clearday.jpg">
<center>
  <p class="txttitletop">Insert Crew Information</p>

  <form method="post" action="insdfcrew.jsp">
    <table border="1" class="fortable">
      <tr>
        <td width="71" class="tablehead3"><font color="#CCFF66">EmpNo</font><span class="txtxred">*</span></td>
        <td width="186"><input type="text" name="empno">
        </td>
        <td width="78" class="tablehead3"><font color="#CCFF66">Name<span class="txtxred">*</span></font></td>
        <td width="168" colspan="3"><input type="text" name="name">
        </td>

      </tr>
      <tr>
        <td class="tablehead3">Ename</td>
        <td><input type="text" name="ename">
        </td>
        <td class="tablehead3">Sex</td>
        <td><input type="text" name="sex">
        </td>
      </tr>
      <tr>
        <td class="tablehead3">Flag</td>
        <td><!-- <input type="text" name="flag">-->
		<select name="flag">
			<option value="Y" selected>Y</option>
			<option value="N">N</option>
		</select>
        </td>
        <td class="tablehead3">Cabin</td>
        <td><input type="text" name="cabin">
        </td>
      </tr>
      <tr>
        <td class="tablehead3">Box</td>
        <td><input type="text" name="box">
        </td>
        <td class="tablehead3">Nflrk</td>
        <td><input type="text" name="nflrk">
        </td>
      </tr>
      <tr>
        <td class="tablehead3">Oflrk</td>
        <td><input type="text" name="oflrk">
        </td>
        <td class="tablehead3">Ovrk</td>
        <td><input type="text" name="ovrk">
        </td>
      </tr>
      <tr>
        <td class="tablehead3">Indt</td>
        <td><input type="text" name="indt">
        </td>
        <td class="tablehead3">Poid</td>
        <td><input type="text" name="poid">
        </td>
      </tr>
      <tr>
        <td class="tablehead3">Podt</td>
        <td><input type="text" name="podt">
        </td>
        <td class="tablehead3">Pout</td>
        <td><input type="text" name="pout">
        </td>
      </tr>
      <tr>
        <td class="tablehead3">Post</td>
        <td><input type="text" name="post">
        </td>
        <td class="tablehead3">Occu</td>
        <td>
		<select name="occu">
		<%
			for(int i=0;i<al.size();i++){
		%>
 		  <option value="<%=al.get(i)%>"><%=al.get(i)%></option>
		<%
				}
			
		%>
		</select>
        </td>
      </tr>
      <tr>
        <td class="tablehead3">Fleet</td>
        <td><input type="text" name="fleet">
        </td>
        <td class="tablehead3">Base</td>
        <td><input type="text" name="base">
        </td>
      </tr>
      <tr>
        <td class="tablehead3">Sect</td>
        <td><input type="text" name="sect">
        </td>
        <td class="tablehead3">Paycode</td>
        <td><input type="text" name="paycode">
        </td>
      </tr>
      <tr>
        <td class="tablehead3">Brk</td>
        <td><input type="text" name="brk">
        </td>
        <td class="tablehead3">Brkrate</td>
        <td><input type="text" name="brkrate">
        </td>
      </tr>
      <tr>
        <td class="tablehead3">Banknont</td>
        <td><input type="text" name="banknont">
        </td>
        <td class="tablehead3">Banknous</td>
        <td><input type="text" name="banknous">
        </td>
      </tr>
      <tr>
        <td class="tablehead3">Taxfmin</td>
        <td><input type="text" name="taxfmin">
        </td>
        <td class="tablehead3">Ipcp</td>
        <td><input type="text" name="ipcp">
        </td>
      </tr>
      <tr>
        <td class="tablehead3">Traf</td>
        <td><input type="text" name="traf">
        </td>
        <td class="tablehead3">Birthdate</td>
        <td><input type="text" name="birthdate">
        </td>
      </tr>
      <tr>
        <td class="tablehead3">Birthplace</td>
        <td><input type="text" name="birthplace">
        </td>
        <td class="tablehead3">Passno</td>
        <td><input type="text" name="passno">
        </td>
      </tr>
      <tr>
        <td class="tablehead3">Passcontry</td>
        <td><input type="text" name="passcontry">
        </td>
        <td class="tablehead3">Passcon</td>
        <td><input type="text" name="passcon">
        </td>
      </tr>
      <tr>
        <td class="tablehead3">Nation</td>
        <td><input type="text" name="nation">
        </td>
        <td class="tablehead3">Passvalid</td>
        <td><input type="text" name="passvalid">
        </td>
      </tr>
      <tr>
        <td class="tablehead3">Lastname</td>
        <td><input type="text" name="lastname">
        </td>
        <td class="tablehead3">Firstname</td>
        <td><input type="text" name="firstname">
        </td>
      </tr>
      <tr>
        <td class="tablehead3">Middlename</td>
        <td colspan="3"><input type="text" name="middlename">
        </td>
      </tr>
      <tr>
        <td colspan="4"><div align="center"><font face="Arial, Helvetica, sans-serif" size="2">
            <input name="submit" type="submit" value="Insert" >
            <br>
            <span class="txttitle">column marked by</span><span class="txtxred"> *</span><span class="txttitle"> must
        be insert</span></font> <br>
        <span class="txtblue">date format is: yyyy-mm-dd (ex:2004-01-02) </span></div></td>
      </tr>


    </table>
    <p><br>
    </p>
  </form>

</center>
</body>
</html>
<%
  

if(t){
%>
      <jsp:forward page="err.jsp" /> 
<%
}
%>
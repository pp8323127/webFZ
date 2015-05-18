<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
/*
if (session.isNew()) 
{		//check user session start first
  %> <jsp:forward page="login.jsp" /> <%
} 
if (sGetUsr == null) 
{		//check if not login
  %> <jsp:forward page="login.jsp" /> <%
} */
%>
<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*"%>
<%@ include file="../../Connections/cnORT1DF.jsp" %>
<html>
<head>
<title>
DFCrew detail Information
</title>
<meta http-equiv="pragma" content="no-cache">
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>

<body >
<center>
  <p class="txttitletop">Crew Detail Information</p>

<%
   String empno = request.getParameter("empno");
 try{
   Class.forName(MM_cnORT1DF_DRIVER);
   Connection myConn = DriverManager.getConnection(MM_cnORT1DF_STRING,MM_cnORT1DF_USERNAME,MM_cnORT1DF_PASSWORD);
   Statement stmt = myConn.createStatement();	
   
 //  ResultSet myResultSet = stmt.executeQuery("select * from dftcrew where empno = '" + empno + "'");
   String sql = "select  empno, name, ename, sex, flag, chgid, chgtime, cabin , box, nflrk, oflrk , ovrk  , indt , poid ,"
   			  +" podt , pout , post , occu , fleet , base , sect , paycode , brk   , brkrate , banknont , banknous , "
			  +"taxfmin , ipcp, traf , sess, to_char(birthdate,'yyyy-mm-dd') birthdate, birthplace, passno , passcontry, "
			  +"passcon , nation , to_char(passvalid,'yyyy-mm-dd') passvalid, lastname, firstname, middlename from dftcrew "
			  +" where empno = '" + empno + "'";
	//out.print(sql);			
	  
   ResultSet myResultSet = stmt.executeQuery(sql);  
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
  <form method="post" action="upddfcrew.jsp">
    <table border="1" class="fortable">
      <tr> 
        <td width="71" class="tablehead3">EmpNo<span class="txtxred"><strong>*</strong></span></td>
        <td width="168" class="tablebody"><%= empno %>
		    <input type="hidden" name="empno" value="<%= empno %>">
        </td>
      </tr>
      <tr> 
        <td class="tablehead3">Name</td>
        <td><input type="text" name="name" value="<%= name %>">
        </td>
      </tr>
      <tr> 
        <td class="tablehead3">Ename</td>
        <td><input type="text" name="ename" value="<%= ename %>">
        </td>
      </tr>
	  <tr> 
        <td class="tablehead3">Sex</td>
        <td><input type="text" name="sex" value="<%= sex %>">
        </td>
      </tr>
	  <tr> 
        <td class="tablehead3">Flag</td>
        <td><input type="text" name="flag" value="<%= flag %>">
        </td>
      </tr>
	  <tr> 
        <td class="tablehead3">Cabin</td>
        <td><input type="text" name="cabin" value="<%= cabin %>">
        </td>
      </tr>
	  <tr> 
        <td class="tablehead3">Box</td>
        <td><input type="text" name="box" value="<%= box %>">
        </td>
      </tr>
	  <tr> 
        <td class="tablehead3">Nflrk</td>
        <td><input type="text" name="nflrk" value="<%= nflrk %>">
        </td>
      </tr>
	  <tr> 
        <td class="tablehead3">Oflrk</td>
        <td><input type="text" name="oflrk" value="<%= oflrk %>">
        </td>
      </tr>
	  <tr> 
        <td class="tablehead3">Ovrk</td>
        <td><input type="text" name="ovrk" value="<%= ovrk %>">
        </td>
      </tr>
	  <tr> 
        <td class="tablehead3">Indt</td>
        <td><input type="text" name="indt" value="<%= indt %>">
        </td>
      </tr>
	  <tr> 
        <td class="tablehead3">Poid</td>
        <td><input type="text" name="poid" value="<%= poid %>">
        </td>
      </tr>
	  <tr> 
        <td class="tablehead3">Podt</td>
        <td><input type="text" name="podt" value="<%= podt %>">
        </td>
      </tr>
	  <tr> 
        <td class="tablehead3">Pout</td>
        <td><input type="text" name="pout" value="<%= pout %>">
        </td>
      </tr>
	  <tr> 
        <td class="tablehead3">Post</td>
        <td><input type="text" name="post" value="<%= post %>">
        </td>
      </tr>
	  <tr> 
        <td class="tablehead3">Occu</td>
        <td><input type="text" name="occu" value="<%= occu %>">
        </td>
      </tr>
	  <tr> 
        <td class="tablehead3">Fleet</td>
        <td><input type="text" name="fleet" value="<%= fleet %>">
        </td>
      </tr>
	  <tr> 
        <td class="tablehead3">Base</td>
        <td><input type="text" name="base" value="<%= base %>">
        </td>
      </tr>
	  <tr> 
        <td class="tablehead3">Sect</td>
        <td><input type="text" name="sect" value="<%= sect %>">
        </td>
      </tr>
	  <tr> 
        <td class="tablehead3">Paycode</td>
        <td><input type="text" name="paycode" value="<%= paycode %>">
        </td>
      </tr>
	  <tr> 
        <td class="tablehead3">Brk</td>
        <td><input type="text" name="brk" value="<%= brk %>">
        </td>
      </tr>
	  <tr> 
        <td class="tablehead3">Brkrate</td>
        <td><input type="text" name="brkrate" value="<%= brkrate %>">
        </td>
      </tr>
	  <tr> 
        <td class="tablehead3">Banknont</td>
        <td><input type="text" name="banknont" value="<%= banknont %>">
        </td>
      </tr>
	  <tr> 
        <td class="tablehead3">Banknous</td>
        <td><input type="text" name="banknous" value="<%= banknous %>">
        </td>
      </tr>
	  <tr> 
        <td class="tablehead3">Taxfmin</td>
        <td><input type="text" name="taxfmin" value="<%= taxfmin %>">
        </td>
      </tr>
	  <tr> 
        <td class="tablehead3">Ipcp</td>
        <td><input type="text" name="ipcp" value="<%= ipcp %>">
        </td>
      </tr>
	  <tr> 
        <td class="tablehead3">Traf</td>
        <td><input type="text" name="traf" value="<%= traf %>">
        </td>
      </tr>
<!-- -->
	  <tr> 
        <td class="tablehead3">Birthdate</td>
        <td><input type="text" name="birthdate" value="<%=birthdate%>">
        </td>
      </tr>
	  <tr> 
        <td class="tablehead3">Birthplace</td>
        <td><input type="text" name="birthplace" value="<%=birthplace%>">
        </td>
      </tr>
	  <tr> 
        <td class="tablehead3">Passno</td>
        <td><input type="text" name="passno" value="<%=passno%>">
        </td>
	  </tr>	
	  <tr> 
        <td class="tablehead3">Passcontry</td>
        <td><input type="text" name="passcontry" value="<%=passcontry%>">
        </td>		
	  </tr>	
	  <tr> 
        <td class="tablehead3">Passcon</td>
        <td><input type="text" name="passcon" value="<%=passcon%>">
        </td>	
	  </tr>	
	  <tr> 
        <td class="tablehead3">Nation</td>
        <td><input type="text" name="nation" value="<%=nation%>">
        </td>	
	  </tr>	
	  <tr> 
        <td class="tablehead3">Passvalid</td>
        <td><input type="text" name="passvalid" value="<%=passvalid%>">
        </td>	
	  </tr>	
	  <tr> 
        <td class="tablehead3">Lastname</td>
        <td><input type="text" name="lastname" value="<%=lastname%>">
        </td>														
      </tr>	
	  <tr> 
        <td class="tablehead3">Firstname</td>
        <td><input type="text" name="firstname" value="<%=firstname%>">
        </td>														
      </tr>		
	  <tr> 
        <td class="tablehead3">Middlename</td>
        <td><input type="text" name="middlename" value="<%=middlename%>">
        </td>														
      </tr>			
<!-- -->	  
      <tr> 
        <td colspan="2"> 
          <center>
            <font face="Arial, Helvetica, sans-serif" size="2"> 
            <input type="submit" value="Update Change" >
            <br>
            <span class="txttitle">column marked by</span><span class="txtxred"> *</span><span class="txttitle"> must
            be insert </span></font> 
          </center>
        </td>
      </tr> 
    </table>
</form>

</center>
</body>
</html>
<%        
    	}  
   }
   if( count == 0){
   %>
	<jsp:forward page="../showmessage.jsp">
	<jsp:param name="messagestring" value="No Data Found !!" />
	</jsp:forward>
   <%
   
   }
   stmt.close();
   myConn.close();
   
  
}//end of try
    catch(Exception e) {  
	out.print(e.toString());
}
%>
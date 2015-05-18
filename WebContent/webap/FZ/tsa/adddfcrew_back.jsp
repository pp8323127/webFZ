<%

String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
/*if (session.isNew()) 
{		//check user session start first
  %> <jsp:forward page="login.jsp" /> <%
} 
if (sGetUsr == null) 
{		//check if not login
  %> <jsp:forward page="login.jsp" /> <%
} */
%>
<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*"%>
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
        <td width="71" class="tablehead3">EmpNo<span class="txtxred"><strong>*</strong></span></td> 
        <td><input type="text" name="empno">
        </td>
      </tr>
      <tr>
        <td class="tablehead3">Name</td> 
        <td><input type="text" name="name">
        </td>
      </tr>
      <tr>
        <td class="tablehead3">Ename</td> 
        <td><input type="text" name="ename">
        </td>
      </tr>
	  <tr>
	    <td class="tablehead3">Sex</td> 
        <td><input type="text" name="sex">
        </td>
      </tr>
	  <tr>
	    <td class="tablehead3">Flag</td> 
        <td><input type="text" name="flag">
        </td>
      </tr>
	  <tr>
	    <td class="tablehead3">Cabin</td> 
        <td><input type="text" name="cabin">
        </td>
      </tr>
	  <tr>
	    <td class="tablehead3">Box</td> 
        <td><input type="text" name="box">
        </td>
      </tr>
	  <tr>
	    <td class="tablehead3">Nflrk</td> 
        <td><input type="text" name="nflrk">
        </td>
      </tr>
	  <tr>
	    <td class="tablehead3">Oflrk</td> 
        <td><input type="text" name="oflrk">
        </td>
      </tr>
	  <tr>
	    <td class="tablehead3">Ovrk</td> 
        <td><input type="text" name="ovrk">
        </td>
      </tr>
	  <tr>
	    <td class="tablehead3">Indt</td> 
        <td><input type="text" name="indt">
        </td>
      </tr>
	  <tr>
	    <td class="tablehead3">Poid</td> 
        <td><input type="text" name="poid">
        </td>
      </tr>
	  <tr>
	    <td class="tablehead3">Podt</td> 
        <td><input type="text" name="podt">
        </td>
      </tr>
	  <tr>
	    <td class="tablehead3">Pout</td> 
        <td><input type="text" name="pout">
        </td>
      </tr>
	  <tr>
	    <td class="tablehead3">Post</td> 
        <td><input type="text" name="post">
        </td>
      </tr>
	  <tr>
	    <td class="tablehead3">Occu</td> 
        <td><input type="text" name="occu">
        </td>
      </tr>
	  <tr>
	    <td class="tablehead3">Fleet</td> 
        <td><input type="text" name="fleet">
        </td>
      </tr>
	  <tr>
	    <td class="tablehead3">Base</td> 
        <td><input type="text" name="base">
        </td>
      </tr>
	  <tr>
	    <td class="tablehead3">Sect</td> 
        <td><input type="text" name="sect">
        </td>
      </tr>
	  <tr>
	    <td class="tablehead3">Paycode</td> 
        <td><input type="text" name="paycode">
        </td>
      </tr>
	  <tr>
	    <td class="tablehead3">Brk</td> 
        <td><input type="text" name="brk">
        </td>
      </tr>
	  <tr>
	    <td class="tablehead3">Brkrate</td> 
        <td><input type="text" name="brkrate">
        </td>
      </tr>
	  <tr>
	    <td class="tablehead3">Banknont</td> 
        <td><input type="text" name="banknont">
        </td>
      </tr>
	  <tr>
	    <td class="tablehead3">Banknous</td> 
        <td><input type="text" name="banknous">
        </td>
      </tr>
	  <tr>
	    <td class="tablehead3">Taxfmin</td> 
        <td><input type="text" name="taxfmin">
        </td>
      </tr>
	  <tr>
	    <td class="tablehead3">Ipcp</td> 
        <td><input type="text" name="ipcp">
        </td>
      </tr>
	  <tr>
	    <td class="tablehead3">Traf</td> 
        <td><input type="text" name="traf">
        </td>
 	 </tr>
		<!--    Start   -->   
	  <tr>
	    <td class="tablehead3">Birthdate</td> 
        <td><input type="text" name="birthdate">
        </td>
      </tr>
	  <tr>
	    <td class="tablehead3">Birthplace</td> 
        <td><input type="text" name="birthplace">
        </td>
      </tr>
	  <tr>
	    <td class="tablehead3">Passno</td> 
        <td><input type="text" name="passno">
        </td>
	  </tr>	
	  <tr>
	    <td class="tablehead3">Passcontry</td> 
        <td><input type="text" name="passcontry">
        </td>		
	  </tr>	
	  <tr>
	    <td class="tablehead3">Passcon</td> 
        <td><input type="text" name="passcon">
        </td>	
	  </tr>	
	  <tr>
	    <td class="tablehead3">Nation</td> 
        <td><input type="text" name="nation">
        </td>	
	  </tr>	
	  <tr>
	    <td class="tablehead3">Passvalid</td> 
        <td><input type="text" name="passvalid">
        </td>	
	  </tr>	
	  <tr>
	    <td class="tablehead3">Lastname</td> 
        <td><input type="text" name="lastname">
        </td>														
      </tr>	
	  <tr>
	    <td class="tablehead3">Firstname</td> 
        <td><input type="text" name="firstname">
        </td>														
      </tr>		
	  <tr>
	    <td class="tablehead3">Middlename</td> 
        <td><input type="text" name="middlename">
        </td>														
      </tr>			    
	  	<!--  End -->	 

      <tr> 
        <td colspan="2"> 
          <center>
            <font face="Arial, Helvetica, sans-serif" size="2"> 
            <input type="submit" value="Insert" >
            <br>
            <span class="txttitle">column marked by</span><span class="txtxred"> *</span><span class="txttitle"> must
            be insert</span></font> <br>
            <span class="txtblue">date format is: yyyy-mm-dd (ex:2004-01-02) </span>          </center>
        </td>
      </tr> 
    </table>
</form>

</center>
</body>
</html>
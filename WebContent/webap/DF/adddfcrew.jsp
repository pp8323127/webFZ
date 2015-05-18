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
<html>
<head>
<title>
Insert Crew Information
</title>
<meta http-equiv="pragma" content="no-cache">
</head>

<body background="clearday.jpg">
<center>
  <p><font face="Comic Sans MS" color="#333333">Insert Crew Information</font></p>

  <form method="post" action="insdfcrew.jsp">
    <table border="1">
      <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">EmpNo</font></b></td>
        <td><input type="text" name="empno">
        </td>
      </tr>
      <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Name</font></b></td>
        <td><input type="text" name="name">
        </td>
      </tr>
      <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Ename</font></b></td>
        <td><input type="text" name="ename">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Sex</font></b></td>
        <td><input type="text" name="sex">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Flag</font></b></td>
        <td><input type="text" name="flag">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Cabin</font></b></td>
        <td><input type="text" name="cabin">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Box</font></b></td>
        <td><input type="text" name="box">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Nflrk</font></b></td>
        <td><input type="text" name="nflrk">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Oflrk</font></b></td>
        <td><input type="text" name="oflrk">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Ovrk</font></b></td>
        <td><input type="text" name="ovrk">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Indt</font></b></td>
        <td><input type="text" name="indt">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Poid</font></b></td>
        <td><input type="text" name="poid">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Podt</font></b></td>
        <td><input type="text" name="podt">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Pout</font></b></td>
        <td><input type="text" name="pout">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Post</font></b></td>
        <td><input type="text" name="post">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Occu</font></b></td>
        <td><input type="text" name="occu">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Fleet</font></b></td>
        <td><input type="text" name="fleet">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Base</font></b></td>
        <td><input type="text" name="base">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Sect</font></b></td>
        <td><input type="text" name="sect">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Paycode</font></b></td>
        <td><input type="text" name="paycode">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Brk</font></b></td>
        <td><input type="text" name="brk">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Brkrate</font></b></td>
        <td><input type="text" name="brkrate">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Banknont</font></b></td>
        <td><input type="text" name="banknont">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Banknous</font></b></td>
        <td><input type="text" name="banknous">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Taxfmin</font></b></td>
        <td><input type="text" name="taxfmin">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Ipcp</font></b></td>
        <td><input type="text" name="ipcp">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Traf</font></b></td>
        <td><input type="text" name="traf">
        </td>
      </tr>
      <tr> 
        <td colspan="2"> 
          <center>
            <font face="Arial, Helvetica, sans-serif" size="2"> 
            <input type="submit" value="Insert" >
            </font> 
          </center>
        </td>
      </tr> 
    </table>
</form>

</center>
</body>
</html>
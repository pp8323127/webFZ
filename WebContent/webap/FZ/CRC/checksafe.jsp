<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html; charset=big5" language="java"%>
<%@ page import="ci.auth.chkAuth,java.util.ArrayList,fz.*,javax.naming.*,java.io.*,"%>


<%
     String userid = request.getParameter("userid").trim();
     String qry_id = request.getParameter("qry_id").trim();
     String password = request.getParameter("password");
     session.setAttribute("suserid", userid);
     session.setAttribute("sqry_id", qry_id);
     session.setAttribute("spassword", password);

  /*     String userida = (String) session.getAttribute("suserid");
     String passworda = (String) session.getAttribute("spassword");
    
      out.println(userida +"<br>");   
      out.println(passworda +"<br>");   */
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>CRC--Crew Reporting Check System</title>
<script language=javascript> 
function f_onload()
{
 
    
 }
function checkrdo(){
   
	 var selectedIndex = -1;
         var form1 = document.getElementById("form1");
         var i = 0;
    
         for (i=0; i<form1.rdo_YN.length; i++)
           {
             if (form1.rdo_YN[i].checked)
             {
               selectedIndex = i;
               break;
             }
           }
         if (selectedIndex < 0)
           {
             alert("Please click YES or NO radio button!!");
             return false;
           }
	
        if(form1.rdo_YN[i].value == "N"  ){
	 	alert("I  am not safe!!");

     
         	return true;
	 }
         else return true;
	  
 
}
</script>
<link href="../menu.css" rel="stylesheet" type="text/css">
 
<style type="text/css"> 
<!--
.style1 {font-size: 10pt}
.style3 {
	color: #000099;
	font-family: Georgia, "Times New Roman", Times, serif;
	font-size: 24px;
}
-->
</style>
</head>
 
<body onLoad="f_onload()">
<form name="form1" method="post" action="checkCRCSuser.jsp" >
  <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
    <!--DWLayoutTable-->
    <tr>
      <td width="69" height="50">&nbsp;</td>
      <td width="90" valign="top" class="txttitletop"><div align="center"></div></td>
      <td colspan="2" valign="left"><p>&nbsp;</p>
        <p align="center"><span class="style3"><font size="6" face="Arial, Helvetica, sans-serif"><strong><u>I'M SAFE Self-Review Items</u></strong></font></span></p>
        <p align="center"><font size="4" face="Arial, Helvetica, sans-serif"><strong> (To identify any item may affect flight safety)</strong></font></p>
        <p> </p>
      </td>
      <td width="65">&nbsp;</td>
    </tr>
    <tr>
      <td height="78">&nbsp;</td>
      <td >&nbsp;</td>
      <td  align="right"><strong><font color="#FF0000" size="5" face="Arial, Helvetica, sans-serif">I</font></strong><br>
                         <strong><font color="#FF0000" size="5" face="Arial, Helvetica, sans-serif">M</font></strong><br>
			 <strong><font color="#FF0000" size="5" face="Arial, Helvetica, sans-serif">S</font></strong><br>
                         <strong><font color="#FF0000" size="5" face="Arial, Helvetica, sans-serif">A</font></strong><br>
                         <strong><font color="#FF0000" size="5" face="Arial, Helvetica, sans-serif">F</font></strong><br>
                         <strong><font color="#FF0000" size="5" face="Arial, Helvetica, sans-serif">E</font></strong><br>
      </td>
      <td  align="left"><strong><font color="#FF0000" size="5">&nbsp;-- &nbsp;Illness    </font></strong><br>
                        <strong><font color="#FF0000" size="5">&nbsp;-- &nbsp;Medication </font></strong><br>
			<strong><font color="#FF0000" size="5">&nbsp;-- &nbsp;Stress     </font></strong><br>
                        <strong><font color="#FF0000" size="5">&nbsp;-- &nbsp;Alcohol    </font></strong><br>
                        <strong><font color="#FF0000" size="5">&nbsp;-- &nbsp;Fatigue    </font></strong><br>
                        <strong><font color="#FF0000" size="5">&nbsp;-- &nbsp;Emotion    </font></strong><br>
      </td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
	<td>&nbsp;</td>
	<td>&nbsp;</td>
 	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
    </tr>
    <tr>
      <td height="50">&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td class="style3"><font size="6"><u>I have reviewed all the items and been aware of my condition which is suitable to perform this flight duty.</u></font></td>
      <td>&nbsp;</td>
    </tr>
    

         
    <tr>
      <td height="50">&nbsp;</td>
      <td valign="middle"><div align="center">
      </div></td>
     <td colspan="2" valign="left"><p>&nbsp;</p>
        <p align="center"><span class="style3"><font size="5"><input type="submit" name="Submit" value="Enter" ></font></span> 
        </p>
        <p> </p>
     </td>
    
      <td >&nbsp;</td>
    </tr>
    <tr>
      <td height="80" colspan="5"><div align="right"><a href="http://www.china-airlines.com" target="_blank"><img src="../images/logo.jpg" border="0"></a></div>
      </td>
    </tr>
  </table>
</form>
</body>
</html>

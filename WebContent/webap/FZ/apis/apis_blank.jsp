<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="apis.*,java.sql.*,java.util.*,ci.db.*" %>

<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //Check if logined
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
if (session.isNew() || sGetUsr == null) {		//check user session start first
    %> <jsp:forward page="../sendredirect.jsp" /> <%
}//if
if (sGetUsr.equals("630973") || sGetUsr.equals("626542") || sGetUsr.equals("640354")){
   //
}else if (sGetUsr.equals("633007") || sGetUsr.equals("634319") || sGetUsr.equals("637299") || sGetUsr.equals("638716") || sGetUsr.equals("640073") || sGetUsr.equals("640790")) {
   //
}else{	
   session.setAttribute("errMsg", "You are not authorized."); 
  %> <jsp:forward page="apis_error.jsp" /> <% 
}//if

String status= (String) session.getAttribute("seStatus"); 
if (status == null){
   status = "Ready.";
   session.setAttribute("seStatus", status);
}//if 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>APIS Select</title>
<link href="../style2.css" rel="stylesheet" type="text/css">
<script language="JavaScript">          
function apisInsert(formName){
    eval("document."+formName+".chgtype.value='insert'");
	eval("document."+formName+".insertwho.value='unknown'");
	eval("document."+formName+".target = '_self'");
	eval("document."+formName+".action = 'apis_fillform.jsp'");
	eval("document."+formName+".submit()");
}//function
</script>
</head>
<body>
<table width="100%"  border="0" align="center"><tr><td>
    <div align="right"><a href="javascript:window.print()"> <img src="../images/print.gif" width="17" height="15" border="0" alt="Printing"></a> 
    </div>
</td></tr>
</table>
<table width="130%"  border="0" align="center">
  <tr bgcolor="#FFFF11"> 
     <td colspan="29"> <div align="left">Ready</div></td>
  </tr>
</table>

<table width="100%"  border="1" align="center">
  <tr>
    <td colspan="2" bgcolor="#DAFCD1"><br> 
   <form name="forminsert" method="post">
      <input name="chgtype" type="hidden">
	  <input name="insertwho" type="hidden">
      <input name="insert" type="button" value="Insert" onClick="apisInsert('forminsert')">
   </form>
   </td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Ca-<br>rrier</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Flt<br>num</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Flt<br>date</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Empno</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Last<br>name</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">First<br>name</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Dep</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Arv</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Nat-<br>ion</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Birth<br>date</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Birth<br>city</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Birth<br>ctry</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Resi-<br>dent<br>ctry</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Pass<br>num</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Pass<br>ctry</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Pass<br>doc<br>type</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Pass<br>expiry</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Sex</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">GD<br>order</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Occu</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Tvl<br>sta-<br>tus</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">DH</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Meal</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">2nd<br>doc<br>num</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">2nd<br>doc<br>ctry</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">2nd<br>doc<br>type</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">2nd<br>doc<br>expiry</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Change<br>date</td>
</table>
<p>
<table width="100%"  border="0">
   <tr><td><p align="left"> * 2nd document: Pilot certificate or cabin crew green card.</p></td></tr>
</table>
</p>
</body>
</html>
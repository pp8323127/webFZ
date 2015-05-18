<%@ page contentType="text/html; charset=big5" language="java" import="ci.db.*,java.util.*,java.sql.*,fz.UnicodeStringParser" errorPage=""%>
<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //Check if logined
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
if (session.isNew() || sGetUsr == null) {		//check user session start first
    %> <jsp:forward page="../sendredirect.jsp" /> <%
}//if

String authority = null;
if (sGetUsr.equals("630973") || sGetUsr.equals("626542") || sGetUsr.equals("640354")){
   authority = "pilot";
}else if ( sGetUsr.equals("628152") || sGetUsr.equals("633248")) {
   authority = "cabin";
}else if (sGetUsr.equals("633007") || sGetUsr.equals("634319") || sGetUsr.equals("637299") || sGetUsr.equals("638716") || sGetUsr.equals("640073") || sGetUsr.equals("640790")) {
    authority = "all";
}else{	
   session.setAttribute("errMsg", "You are not authorized."); 
  %> <jsp:forward page="mcl_error.jsp" /> <% 
}//if
%>
<html>
<head>
<title>Master Crew List</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../menu.css" rel="stylesheet" type="text/css">
<script src="../js/showDate.js"></script>
</head>
<body>
<table border="0"><tr><td>
<form name="form1" method="post" action="mcl_broker.jsp" class="txtblue" target="mainFrame">
  <p ><strong>Master Crew List</strong></p>
  <p > 
    <select name="sel_crewtype">
	 <% if ((authority == "pilot") || (authority == "all")) { 
	           %> <option value="pilot">Pilot crew</option><% 
           }//if
      %>

	 <% if ((authority == "cabin") || (authority == "all")) { 
	           %>  <option value="cabin">Cabin crew</option><%
          }//if
	  %>
	</select>
    &nbsp;&nbsp; 
    <select name="sel_ghi">
      <option value="G">G(Add)</option>
      <option value="H">H(Delete)</option>
      <option value="I">I(Change)</option>
    </select>
	&nbsp;&nbsp; 
	<select name="sel_nat">
      <option value="S">Single nationality</option>
      <option value="D">Double nationality(USA or CAN)</option>
    </select>
  </p>
  <p > 
    <textarea name="txa_empnolist" cols="8" rows="10"></textarea>
  </p>
  <p > &nbsp; 
    <input name="Submit" type="submit" class="btm" value="Submit">
  </p>
  </form>
  </td></tr>
  <% if ((authority == "pilot") || (authority == "all")) { 
        %><tr><td><BR><BR>
		<form name="form2" method="post" action="mcl_misname_pilot.jsp" class="txtblue" target="mainFrame">
		   <input name="misname" type="submit" class="btm" value="Mismatched names">
		</form>
		</td><% 
  } //if
  %>
  </tr></table>
</body>
</html>
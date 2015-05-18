<%@ page contentType="text/html; charset=big5" language="java" import="apis.*,java.sql.*,ci.db.*,java.util.*,java.io.*, java.text.*,java.math.*" %>
<jsp:useBean id="apisDelete" class="fz.ApisDelete" />
<%!
String status;
String fdate;
String fltno;
String fltyyyy, fltmm, fltdd;
String empno; 
%>
<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ;
if (session.isNew() || sGetUsr == null) {		//check user session start first
    %> <jsp:forward page="../sendredirect.jsp" /> <%
}//if
status = "";
fdate  = request.getParameter("fdate"); 
fltyyyy = "20"+fdate.substring(0,2);
fltmm   = fdate.substring(2,4);
fltdd   = fdate.substring(4,6);
fltno   = request.getParameter("fltno");
empno   = request.getParameter("empno"); 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5"><title></title>
<style type="text/css">
<!--
.invisibleButton {border:0; background-color:white;}
-->
</style>
<script language=javascript>
function apisSelect(){  	   
   document.form1.target = "_self";
   document.form1.action = "apis_select.jsp";
   document.form1.submit();	
}//function
</script>
</head>
<body>
<form name="form1" method="post">
    <input name="sel_year" type="hidden" value=<%=fltyyyy%> >
    <input name="sel_mon"  type="hidden" value=<%=fltmm%>   >
    <input name="sel_dd"   type="hidden" value=<%=fltdd%>   >
    <input name="fltno"    type="hidden" value=<%=fltno%>   >
    <input class="invisibleButton" name="submit"   type="submit" value="" onClick="apisSelect()"> 
</form>
<%
status = apisDelete.delete(fdate, fltno, empno);
session.setAttribute("seStatus", status);
pageContext.removeAttribute("apisDelete");
%><script language="javascript">	   
document.form1.submit.click();
</script><%   
%>
</body>
</html>

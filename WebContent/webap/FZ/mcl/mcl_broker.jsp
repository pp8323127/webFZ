<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*, java.util.*, java.io.*, java.text.*, ci.db.*, org.apache.poi.hssf.usermodel.*" %>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
</head>
<body>
<%
String ghi = request.getParameter("sel_ghi");
String crewtype = request.getParameter("sel_crewtype");
String empnoString  = request.getParameter("txa_empnolist");

//out.println( ghi); 
//out.println(crewtype); 
//out.println(empnoString); 

session.setAttribute("ghi", ghi); 
session.setAttribute("crewtype", crewtype); 
session.setAttribute("empnoString", empnoString); 

if (crewtype.equals("pilot")) {
    %> <jsp:forward page="mcl_result_pilot.jsp" /> <%
}//if

if (crewtype.equals("cabin")) {
    %> <jsp:forward page="mcl_result_cabin.jsp" /> <%
 }//if 
 
 if (crewtype.equals("crxx")) {
    %> <jsp:forward page="mcl_result_crxx.jsp" /> <%
 }//if 
%>
</body>
</html>
<%@page import="eg.safetyAudit.SafetyAudit"%>
<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,java.util.*,ci.db.*,java.util.ArrayList" %>
<%
String purempn = (String) session.getAttribute("userid") ; //get user id if already login

if (purempn  == null) {		
	response.sendRedirect("../../logout.jsp");
}
String form_num ="";//   request.getParameter("form_num");
String empn ="";//    request.getParameter("empn");
String sern ="";//    request.getParameter("sern");

String purname  = null;//   request.getParameter("psrname");//auditor
String pursern =   null;//request.getParameter("pursern");
String fltno   =   request.getParameter("fltno");//V
String sect    =   request.getParameter("sect");
String fleet  =   request.getParameter("fleet");
String fltd   =   request.getParameter("fltdt");//V
String acno   =   request.getParameter("acno");//a/c no

String fiNo  = null;
String fiDsc = null;
String fiFlag= null;
String siNo  = null;
String siDsc = null;
String siFlag= null;

out.println(purempn+fltno+sect+fleet+fltd+acno);
SafetyAudit a = new SafetyAudit();
out.print(a.getSAinfo(purempn));


        

%>

</body>
</html>

<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,swap3ackhh.*" %>
<%
String aEmpno = request.getParameter("aEmpno");
String rEmpno = request.getParameter("rEmpno");
String year = request.getParameter("year");
String month =request.getParameter("month");

CheckRetire cr = new CheckRetire(aEmpno);
boolean aRetire = false;
boolean rRetire = false;
try {
	cr.RetrieveDate();
	if(cr.isRetire()){
		aRetire = true;
	}
	
	 cr = new CheckRetire(rEmpno);
	 
	cr.RetrieveDate();
	if(cr.isRetire()){
		rRetire= true;
	}
} catch (ClassNotFoundException e) {
	out.print(e.toString());
} catch (SQLException e) {
	out.print(e.toString());
} catch (InstantiationException e) {
	out.print(e.toString());
} catch (IllegalAccessException e) {
	out.print(e.toString());
}

if(aRetire | rRetire){//有一為屆退人員，使用applicantRetire.jsp
	response.sendRedirect("applicantRetire.jsp?aEmpno="+aEmpno+"&rEmpno="+rEmpno+"&year="
				  +year+"&month="+month);
}else{
	response.sendRedirect("applicant.jsp?aEmpno="+aEmpno+"&rEmpno="+rEmpno+"&year="
				  +year+"&month="+month);
}

%>

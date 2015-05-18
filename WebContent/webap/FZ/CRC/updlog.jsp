<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*, fz.*"%>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //Check if logined
if ((sGetUsr == null) || (session.isNew()) )
{		//check user session start first or not login
	response.sendRedirect("sendredirect.jsp");
} 

String linkpage = request.getParameter("linkpage");
String sysname = request.getParameter("sysname");

String userip = request.getRemoteAddr();
String userhost = request.getRemoteHost();
//°O¿ý¼g¶ilog
writeCRCLog wl = new writeCRCLog();
String rs = wl.updLog(sGetUsr, userip, userhost, sysname,"");

if (rs.equals("0"))
{
     response.sendRedirect(linkpage);
}
else
{
     out.println("Write Log Fail !! Error : " + rs);
}
%>

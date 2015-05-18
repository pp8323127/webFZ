<%@ page contentType="text/html; charset=big5" language="java"  %>
<%
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader ("Expires", 0);

	String userid = request.getParameter("userid");
	String password = request.getParameter("password");	
	
	if(userid == null | password == null | "".equals(userid) | "".equals(password) )
	{
			session.invalidate();
			response.sendRedirect("index.htm");
	
	}
	else
	{
		session.setAttribute("userid",userid);
		session.setAttribute("password",password);
		response.sendRedirect("checkuserAC.jsp");
	 }
%>

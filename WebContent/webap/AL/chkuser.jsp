<%@page contentType="text/html; charset=big5" language="java" import="fzAuthP.*" %>
<jsp:useBean id="ALInfo" scope="page" class="al.ALInfo"/>
<link href="style.css" rel="stylesheet" type="text/css">
<p>&nbsp;</p>
<p>&nbsp;</p>

<%
	String userid = request.getParameter("userid");
	String password = request.getParameter("password");
	boolean chkstatus = false;
try
{	
	String rs = ALInfo.chkUser(userid, password);
	if(!"0".equals(rs))
	{
		//login fail
		response.sendRedirect("loginfail.jsp");
	}
	else
	{
		fzAuthP.UserID uid = new fzAuthP.UserID (userid, password);
		fzAuthP.CheckEG chkEG = new fzAuthP.CheckEG();
		if(chkEG.isEGCrew() )
		{
			fzAuthP.EGObj egObj =  chkEG.getEgObj();
			if("1".equals(egObj.getStatus()))
			{
				chkstatus = true;
			}
			else
			{
				chkstatus = false;
			}
		}
		else
		{
			chkstatus = false;
		}		
	}

	if(chkstatus == false)
	{
		response.sendRedirect("../FZ/noALMessage.htm");
	}
	else
	{
		//login success
		session.setAttribute("userid", userid) ;
		response.sendRedirect("selectpage.jsp");	
	}
}
catch(Exception e)
{
	out.println("<p align='center' class='font_hilred'>系統忙碌中請稍後再試....................</p>");
}
%>
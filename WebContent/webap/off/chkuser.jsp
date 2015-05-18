<%@page contentType="text/html; charset=big5" language="java"%>
<%@ page import="fzAuthP.*,java.net.*,fz.chkUserSession" %>

<jsp:useBean id="ALInfo" scope="page" class="al.ALInfo"/>
<link href="style.css" rel="stylesheet" type="text/css">
<p>&nbsp;</p>
<p>&nbsp;</p>

<%
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader ("Expires", 0);
	String userid = request.getParameter("userid");
	String password = request.getParameter("password");
	String userid_eip = request.getParameter("Empn");
	String pk_eip = request.getParameter("PK");
	String hostip = InetAddress.getLocalHost().getHostAddress();
	String clientip = request.getRemoteAddr(); 
	boolean chkstatus = false;
	String rs = "";

if ((userid == null | "".equals(userid)) && (userid_eip == null | "".equals(userid_eip))) 
{	//check user session start first or not login
	response.sendRedirect("login.jsp");
} 
else
{
	try
	{	
		if(!"".equals(userid) && userid != null)
		{
			rs = ALInfo.chkUser(userid, password);
		}
		else //if SSO
		{
			CheckEIPSSO ckEIPSSO = new CheckEIPSSO(pk_eip, userid_eip, hostip, clientip) ;
			if(ckEIPSSO.isPassEIPSSO())
			{
				rs = "0";
				userid = userid_eip;
			}
		}


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
					//設定session 20130417				
					//***遞AL時應剔除重複登入帳號***//
					chkUserSession sess = new chkUserSession();
					session.setAttribute("sessStatus",sess.setUserSess(userid)) ;
					//out.println(session.getAttribute("sessStatus"));	
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
			response.sendRedirect("offFrame.htm");	
		}
	}
	catch(Exception e)
	{
		out.println("<p align='center' class='font_hilred'>系統忙碌中請稍後再試....................</p>");
	}
}
%>
<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="eg.off.*,java.net.URLEncoder"%>
<%
response.setHeader("Pragma","no-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0); //prevents caching at the proxy server
String userid = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || userid == null || "null".equals(userid)) 
{		//check user session start first
	response.sendRedirect("../login.jsp");
} 
else
{
String chkresult = "Y";
String str = "Y";
String updresult = "N";
String updstr = "Y";
%>
<html>
<head>
<title>
Delete AL offsheet
</title>
<meta http-equiv="pragma" content="no-cache">
</head>
<body>
<div align="center"> 
<%
	String offyear = request.getParameter("gdyear");
	String[] instring = request.getParameterValues("checkdel");

	if (instring == null)
	{
%>
	<jsp:forward page="sm.jsp">
	<jsp:param name="messagestring" value="No Delete Offsheet!!<br><a href='javascript:history.back(-1)'>back</a>" />
	</jsp:forward>
<% 
    }
	else
	{
		//Check deletable
		for(int i =0; i<instring.length; i++)
		{
			CancelALCheck calc = new CancelALCheck(userid, instring[i].substring(20), instring[i].substring(0,10), instring[i].substring(10,20), userid);
			String temp_str = calc.getALCheckResult();
			if (!"Y".equals(temp_str))
			{
				str = temp_str;
				chkresult = "N";
			}
		}

		//Deletable
		if("Y".equals(str) && "Y".equals(chkresult))
	    {
			for(int i =0; i<instring.length; i++)
			{
				ALProgress ap = new ALProgress(userid, "0", instring[i].substring(0,10), instring[i].substring(10,20), userid);
				updresult = ap.delALRequest(instring[i].substring(20), userid);
				if(!"Y".equals(updresult))
				{
					response.sendRedirect("sm.jsp?messagestring="+URLEncoder.encode(updresult));
				}				
			}
			response.sendRedirect("viewoffsheet.jsp?offyear="+offyear);
		}
		else
		{
			String str1 ="Cancel AL request failed!!<br> Msg: "+str+"!!<br>";
			//<a href='javascript:history.back(-1)'>back</a>";
			response.sendRedirect("sm.jsp?messagestring="+URLEncoder.encode(str1));
		}		
	}
%>
</div>
</body>
</html>
<%
}	
%>
<%@page contentType="text/html; charset=big5" language="java"%>

<%
/*	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader ("Expires", 0);*/
	String ms = null;
	String ms2 = null;
	String linkpage =null;
	ms = request.getParameter("messagestring");
	ms2 = request.getParameter("messagelink");
	linkpage = request.getParameter("linkto");
	
	//if (ms == null )
	//{
		//ms = request.getParameter("messagestring").trim();
		//ms="Welcome to China Airlines Cabin Crew Schedule Inquiry System";
	//}

%>
<html>
<head>
<title>Show Message</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" href="style.css" type="text/css">
</head>

<body text="#000000" class="txttitletop">
<div align="center">
  <p><%=ms%>
</p>
<%
	if (ms2 == null){
		ms2 = "&nbsp;";
		linkpage = "#";
	}

  else{
%>
  <p><a href="<%=linkpage%>"><%=ms2%></a></p>
  <%
  }
  %>
</div>
</body>
</html>

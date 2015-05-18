<%@ page contentType="text/html; charset=big5" language="java" import="java.util.*" %>
<%

String userid = (String) session.getAttribute("userid") ; //get user id if already login
String unitcd = (String) session.getAttribute("Unitcd") ;

if (userid == null) 
{		
	response.sendRedirect("../sendredirect.jsp");
} 
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Month Query</title>
<link href="../style2.css" rel="stylesheet" type="text/css">
<script language="Javascript" src="../../js/showDate.js"></script>
</head>
<body onload="showYM('form1','fyy','fmm');">
<form action="sphForm.jsp" method="post" name="form1" target="mainFrame" class="txtblue">
  Year
  <select name="fyy" id="fyy">
  <%
	java.util.Date now = new Date();
	int syear	=	now.getYear() + 1900;
	for (int i=2003; i<syear+2; i++) 
	{    
  %>
	 <option value="<%=i%>"><%=i%></option>
  <%
	}
  %>
  </select>
  Month
  <select name="fmm" id="fmm">
  <%
	for (int j=1; j<13; j++) 
	{    
	  if (j<10 )
		{
  %>	 
			<option value="0<%=j%>">0<%=j%></option>
  <%
		}
		else
		{
  %>
		  	<option value="<%=j%>"><%=j%></option>
  <%

		}
	}
  %>
  </select>
  <input name="Submit" type="submit" class="table_body3" value="Query" > 
</form>
</body>
</html>

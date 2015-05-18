<%@ page contentType="text/html; charset=big5" language="java" import="ci.db.*,java.util.*,fz.UnicodeStringParser" errorPage=""%>

<%

//String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //Check if logined

/*response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
*/
/*
if ( sGetUsr == null) 
{	//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 
*/
%>

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="crewcar.css" rel="stylesheet" type="text/css">
<script src="js/showDate.js"></script>
</head>
<body onLoad="showYMD('form1','sel_year','sel_mon','sel_dd')">
<form name="form1" method="post" action="sndsec_select.jsp" class="txtblue" target="mainFrame">
  <span class="txtblue">Year</span>  
  <select name="sel_year">
  <%
	java.util.Date now = new Date();
	int syear	=	now.getYear() + 1900;
	for (int i=2003; i<=syear+1; i++) 
	{    
  %>
	 <option value="<%=i%>"><%=i%></option>
  <%
	}
  %>
  </select>
  <span class="txtblue">Month</span>  
  <select name="sel_mon">
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
  Day
  <select name="sel_dd">
  <%
	for (int j=1; j<32; j++) 
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
  &nbsp;&nbsp;<input name="Submit" type="submit" class="btm" value="Query">
</form>
</body>
</html>

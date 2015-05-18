<%@ page contentType="text/html; charset=big5" language="java" import="java.util.*,fz.purspeech.*" %>
<%

String userid = (String) session.getAttribute("userid") ; //get user id if already login
String unitcd = (String) session.getAttribute("Unitcd") ;

if (userid == null) 
{		
	response.sendRedirect("../sendredirect.jsp");
} 
ArrayList subjAL = new ArrayList();

PurSpeech ps = new PurSpeech();
ps.getAllSubj();
subjAL = ps.getSubjAL();
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Month Query</title>
<link href="../style2.css" rel="stylesheet" type="text/css">
<script language="Javascript" src="../../js/showDate.js"></script>
</head>
<body>
<form action="purspeech.jsp" method="post" name="form1" target="mainFrame" class="txtblue">
  Subject : 
  <select name="subj" id="subj">
  <%
	for (int i=0; i<subjAL.size(); i++) 
	{    
		PurSpeechSubjObj obj = (PurSpeechSubjObj) subjAL.get(i);
  %>
	 <option value="<%=obj.getFormno()%>"><%=obj.getFormno().substring(0,4)%>/<%=obj.getFormno().substring(4,6)%>
	 &nbsp;&nbsp;<%=obj.getSubj()%></option>
  <%
	}
  %>
  </select>
  <input name="Submit" type="submit" class="table_body3" value="Query" > 
</form>
</body>
</html>

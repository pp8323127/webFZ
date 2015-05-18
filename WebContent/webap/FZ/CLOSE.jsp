<%@ page contentType="text/html;charset=Big5" %>

<%
session.invalidate();
System.out.println("session.invalidate");
%>
<html>
<head>
<title>CLOSE</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
</head>
<SCRIPT LANGUAGE="JAVASCRIPT" TYPE="TEXT/JAVASCRIPT">
   function KillMe(){
      parent.close();
   }
</SCRIPT>
<body onload="KillMe()"> 
</body>
</html>
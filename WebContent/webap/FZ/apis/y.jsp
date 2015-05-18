<%@ page contentType="text/html; charset=big5" language="java" import="apis.*,java.sql.*,ci.db.*,java.util.*,java.io.*, java.text.*,java.math.*" %>
<jsp:useBean id="apisDelete" class="fz.ApisDelete" />
<jsp:useBean id="crewNationType" class="fz.CrewNationType" />


<%

String nation = crewNationType.getCrewNationType("628586"); 

out.println("==>"+nation+"#");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title></title>
</head>
<body>
</body>
</html>

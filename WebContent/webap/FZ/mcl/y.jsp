<%@ page contentType="text/html; charset=big5" language="java" import="ci.db.*,java.util.*,java.sql.*,fz.*" errorPage=""%>
<jsp:useBean id="b2u" class="fz.Big5ToUnicode" />
<%
//String s1 = "�}�Q�fChristi Hsu";
String s1 = "��";
String s2 = b2u.getUnicodeString(s1);
out.println(s2);
%>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
</head>
<body>
</body>
</html>
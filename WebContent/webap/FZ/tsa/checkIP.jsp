<%@page contentType="text/html; charset=big5" language="java"%>
<%@ page import="fz.*,java.sql.*,ci.auth.*,fzAuthP.CheckAccPwd"%>
<%
String loginIP = request.getRemoteAddr() ;
String RemoteClient = request.getRemoteHost() ;
String Header =  request.getHeader("VIA")              //RETURNS GATEWAY     
String Client = request.getHeader("X-FORWARDED-FOR") //RETURNS IP ADDRESS OF CLIENT SYSTEM  
%>

<html>
<head>
      <title>checkTSAuser</title>


<script language="javascript">
<!-- Begin
//IP address display: By http://www.Hostroute.com
//Script featured on JavaScript Kit (http://www.javascriptkit.com)

var ip = '<!--#echo var="REMOTE_ADDR"-->'

function ipval() {
document.myform.ipaddr.value=ip;
}
window.onload=ipval
// End
--> </script>

<%
out.println("<script>");
  out.println("//RemoteIP= "+loginIP) ;
  out.println("//RemoteClient= "+RemoteClient) ;
out.println("</script>") ;
%>
</head>
<body>

<%    //JSP code
  out.println("<br>RemoteIP= "+loginIP) ;
  out.println("<br>RemoteClient= "+RemoteClient) ;
  out.println("<br>Header= "+Header) ;
  out.println("<br>Client= "+Client) ;
%>

<script>
document.write("Javascript get Your IP address is "+ip );
//document.write("var _ip = '%s';",$_SERVER['REMOTE_ADDR']); 
</script>

<form method="post" action="" name="myform">
  <input type="text" name="ipaddr" readonly>
</form>


</body>
</html>


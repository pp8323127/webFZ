<% 
//String fromInternet = (String)session.getAttribute("outside");

response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

session.invalidate(); 

%>
<script language="JavaScript">

//  parent.location="login.htm";
 parent.location="login2.htm";
</script>
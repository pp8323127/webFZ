<% 
//String fromInternet = (String)session.getAttribute("outside");

response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

session.invalidate(); 

/*
String goPage = "login.htm";
//�Ϥ�Internet��intranet�i�J,
/*
���login.jsp
*/
/*
if("Y".equals(fromInternet)){
	goPage="http://tpeweb02.china-airlines.com:8080/loginIP.jsp";
}
*/
%>
<script language="JavaScript">

//  parent.location="login.htm";
 parent.location="index.htm";
</script>
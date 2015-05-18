<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,java.util.*,java.text.DateFormat"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login

if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 

String password = (String) session.getAttribute("password");


//add by cs55 2004/08/05
String userip = request.getRemoteAddr();
String aladdress = null;



%>
<html>
<head>
<title>function screen</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" href="menu.css" type="text/css">

<script type="text/javascript" language="JavaScript">
function load(w1,w2){
		/*top.topFrame.location.href=w1;
		top.mainFrame.location.href=w2;*/
		parent.topFrame.location.href=w1;
		parent.mainFrame.location.href=w2;

}

function logout(){	//登出

	//top.location.href="sendredirect.jsp";
	self.location="sendredirect.jsp";	
}

	
</script>

<style type="text/css">
<!--

BODY{margin:0px;}
/*內容貼緊網頁邊界*/
-->
</style>
</head>



<body bgcolor="#CCCCCC" text="#000000"  oncontextmenu="window.event.returnValue=false" onselectstart="event.returnValue=false" ondragstart="window.event.returnValue=false">
<br>
<img src="images/friend.gif" width="22" height="22" border="0" align="absmiddle"><a href="#"  onClick='load("blank.htm","adminAccount.jsp")'>帳號管理</a><br>


<HR>
	<table width="100%"  border="0">
       <tr>
		<td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
          <td width="5%" height="46" align="right" valign="middle"><img src="images/logout.gif" width="21" height="21" border="0"></td>
          <td width="95%"><a href="#"  onClick="logout()">登出系統&nbsp;Logout</a></td>
      </tr>	
</table>  	

</body>

</html>


<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,java.util.*,java.text.DateFormat,ci.db.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (session.isNew() || userid == null) {
	response.sendRedirect("sendredirect.jsp");

} else{

%>
<html>
<head>
<title>高雄換班管理 </title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<SCRIPT Language="JavaScript" type="text/javascript">


function pageLoad(w1,w2){
		parent.topFrame.location.href=w1;
		parent.mainFrame.location.href=w2;
}
function logout(){	
	top.location.href="sendredirect.jsp";
}


</script>
<style type="text/css">
body,table,input {
	font-family: Verdana;
	font-size: 10pt;
}
body{
	background-color:#B1D3EC	;
	margin:2pt;
}
.n{
	display:inline;
}
.e4 {
	background-color: #edf3fe;
	color: #000000;
	text-align: center;
}

a:link,a:visited {  color: blue; text-decoration: none;}
a:hover,a:active {  color: #FFFFFF ;background-color: #0066B2	;  text-decoration: none; }
img{
	border:0pt;
}
</style>

</head>



<body >

	<img src="img2/open.gif" width="24" height="24" id="pic4">【管理功能】
<div id="txt4">
<table border="0" cellpadding="0" cellspacing="0">
    <td width="163" colspan="2"  style="padding-left:2pt; ">
		<img src="img2/notepad.gif" width="16" height="16">&nbsp;<a href='javascript:pageLoad("swapkhh/adm/confquery.jsp","blank.htm")'>申請單查詢</A><br>
<%
	String userip = request.getRemoteAddr();
	//if("192.168".equals(userip.substring(0,7)) | "10.18".equals(userip.substring(0,5))) --cs40 modified 2010/3/14
	if("192.168".equals(userip.substring(0,7)) | "10.16".equals(userip.substring(0,5))) 
	{
%>		
		<img src="img2/doc5.gif" width="16" height="16">&nbsp;<a href='javascript:pageLoad("../off/Leave/offEmpno.jsp","blank.htm")'>代填假單</a><BR>
<%
	}	
%>
		
        <img src="img2/cp.gif" width="16" height="16">&nbsp;<a href='javascript:pageLoad("swapkhh/adm/formquery.htm","blank.htm")'>申請單處理</a><BR>
        <img src="img2/doc3.gif" width="16" height="16">&nbsp;<a href='javascript:pageLoad("blank.htm","swapkhh/adm/max.jsp")'>設定受理數量</a><BR>
        <img src="img2/04.gif" width="16" height="16">&nbsp;<a href='javascript:pageLoad("swapkhh/adm/chgSwapFromQuery.jsp","swapkhh/adm/chgSwapFromMenu.htm")'>更新申請單狀態</a><br>
        <img src="img2/doc.gif" width="16" height="16">&nbsp;<a href='javascript:pageLoad("blank.htm","swapkhh/adm/comm.jsp")'>設定審核意見</a><br>
        <img src="img2/rdoc.gif" width="16" height="16">&nbsp;<a href='javascript:pageLoad("blank.htm","swapkhh/adm/setdate.jsp")'>設定不受理日</a><br>
        
        <img src="img2/sup.gif" width="16" height="16">&nbsp;<a href='javascript:pageLoad("blank.htm","swapkhh/adm/crewcomm.jsp")'>設定組員申請附註</a><br>     

		<!--<img src="img2/p1.gif" width="16" height="16">&nbsp;<a href='javascript:pageLoad("blank.htm","swapkhh/SMSAC/SMSQuery.jsp")'>簡訊通報</a><br>-->

		<img src="img2/p1.gif" width="16" height="16">&nbsp;<a href='javascript:pageLoad("blank.htm","../FZ/SMSAC/SMSQuery.jsp")'>簡訊通報</a><br>

		<img src="img2/we.gif" width="16" height="16">&nbsp;<a href='javascript:pageLoad("blank.htm","swapkhh/realSwap/realSwapAdm.jsp")'>實體換班記錄</a>
		<br>		
		<img src="img2/d1.gif" width="16" height="16">&nbsp;<a href='javascript:pageLoad("blank.htm","swapkhh/adm/edHotNews.jsp")'>編輯最新消息</a><br>
		<img src="images/format-justify-fill.png" width="16" height="16">&nbsp;<a href='javascript:pageLoad("blank.htm","swapkhh/adm/KHHciiRptMenu.jsp")'>CII Report</a><br>

	</td>
  </tr>
  </table>
</div><br>

	<img src="img2/open.gif" width="24" height="24" id="pic3"><div class="n"id="n3">【其他功能】</div>

<table border="0" cellpadding="0" cellspacing="0" width="185">
  <tr>
    <td colspan="2">
		<img src="img2/Get Mail.gif" width="16" height="16">&nbsp;<a href='javascript:pageLoad("AC/crewInfoQueryPage.htm","blank.htm")'><div class="n"id="n31">查詢組員電話</div></a><br>
		<img src="img2/02.gif" width="16" height="16">&nbsp;<a href='javascript:pageLoad("efmail.htm","blank.htm")'><div class="n"id="n32">意見信箱</div></a>
	</td>
  </tr>
</table>


<p>&nbsp;</p>
<table border="0" cellpadding="0" cellspacing="0" width="185">

  </tr>
  <tr>
    <td colspan="2"><img src="img2/Security.gif" width="16" height="16">
		&nbsp;<a href='javascript:logout()'><div class="n" id="n0">登出</div>
		</a>	</td>
  </tr>
</table>

	
	

<br>



</body>

</html>
<%
}
%>
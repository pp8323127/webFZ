<%@page contentType="text/html; charset=big5" language="java"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
session.invalidate(); 
%>

<html>
<head>
<title>Login</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
</head>
<script language=javascript>
function f_onload()
{
   document.form1.userid.focus();
}
</script>
<%
GregorianCalendar gc = new GregorianCalendar();  
String year = new java.text.SimpleDateFormat("yyyy").format(new GregorianCalendar().getTime());       
if( 1 == 1)
{
%>
<body>
<meta http-equiv="refresh" content="3; url=../off/login.jsp">
<p align="center">　</p>
<p align="center">　</p>
<p align="center">網址已更新, 5秒以後系統自動轉址至新版網頁</p>

<p align="center">無法自動轉址者請按<a href="../off/login.jsp">New URL</a></p>
<%
}
else
{
%>
<body bgcolor="#FFFFFF" text="#000000" style='font-family: Courier New' onload='f_onload();'>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p align="center"><font face="標楷體" size="5" color="#003399">客艙組員網路特休假申請系統</font></p>
<p align="center"><font face="Comic Sans MS" color="#3366FF">Cabin Crew Annual 
  Leave Off-Sheet System</font></p>
<p align="center"><font face="Arial, Helvetica, sans-serif" color="#FF0099">Please 
  input Id and Password</font></p>
<form name="form1" method="post" action="chkuser.jsp">
  <table width="50%" border="1" align="center">
    <tr> 
      <td width="40%"> 
        <div align="right"><font face="Arial, Helvetica, sans-serif" size="3" color="#000099">UserId</font></div>
      </td>
      <td width="60%"> <font face="Arial, Helvetica, sans-serif"> 
        <input type="text" name="userid">
        </font></td>
    </tr>
    <tr> 
      <td width="40%"> 
        <div align="right"><font face="Arial, Helvetica, sans-serif" size="3" color="#000099">Password</font></div>
      </td>
      <td width="60%"> <font face="Arial, Helvetica, sans-serif"> 
        <input type="password" name="password" AUTOCOMPLETE="off"/>
        </font></td>
    </tr>
  </table>
  <p align="center"> 
    <input type="submit" name="Submit" value="Submit">
    <input type="reset" name="Submit2" value="Reset">
</p>
</form>
<p align="center"><b><font color="#FF0000" size="2">*UserId and Password 與班表資訊網相同, 
  本系統不提供變更Password</font></b></p>
<p align="center"><font size="2"><b><font color="#666666">更改密碼</font><font color="#FF0000">請進入<a href="http://tpeweb03:9901/webfz/FZ/login.htm">班表資訊網</a>, 
Thanks!! </font></b></font></p>
<p align="right"><img src="logo2.gif" width="165" height="35"></p>
<%
}	
%>
</body>
</html>

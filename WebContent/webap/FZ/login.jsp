<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*"  %>
<%

//out.print("userip="+request.getParameter("userip"));
session.setAttribute("userip",request.getParameter("userip"));
session.setAttribute("userhost",request.getParameter("userhost"));
session.setAttribute("outside",request.getParameter("outside"));

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>座艙長及組員班表資訊系統 Crew Schedule Information System</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">

 
<link href="menu.css" rel="stylesheet" type="text/css">
<style type=text/css>
<!--
BODY{margin:0px;/*內容貼緊網頁邊界*/}
.style1 {font-size: 10pt}
.style5 {
	font-family: Arial;
	font-weight: bold;
}
-->
</style>
<script language="javascript">
function showAlert(){
var s = "請注意，班表資訊網原有授權密碼調整中,\n";
	s += "請至全員信箱(http://mail.cal.aero)取得臨時密碼.\n";
	s +="進入系統後，可於個人資料中修改密碼.\n"
	s += "忘記密碼，請點選Forget Password.\n\n";
	s +="Password of this system is changed!!\n";
	s+="We have mailed you the new password by web mail(http://mail.cal.aero)\n";
	s+="Please use the new password instead.\n";
	s+="You are able to modify your password after logon the sysetm!!\n";
	s+="Click Forget Password to get your password. ";
	alert(s);
	//subwinXY('chgPW.htm','notice','600','400');
	
}
</script>
</head>

<!--<body  onload="f_onload();showAlert()">-->
<body  onload="f_onload()">
<div align="center"> 
  <table width="88%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr> 
      <td height="119" colspan="3"><div align="center"><img src="images/index_banner.jpg"  border="0" alt="座艙長及組員班表資訊系統<br>Crew Schedule Information System"></div></td>
    </tr>
    <tr> 
      <td height="82" colspan="3" align="center" valign="bottom"><form name="form1" method="post" action="checkuser2.jsp" class="t1" onSubmit="return checkid()">
        <table width="52%" border="1" cellspacing="0" cellpadding="3">
              <tr> 
                <td>&nbsp;&nbsp;<span class="txtblue">UserID</span></td>
                <td>&nbsp;&nbsp; <input type="text" name="userid" class="t1"  ></td>
              </tr>
              <tr> 
                <td height="27">&nbsp;&nbsp;<span class="txtblue">Password</span></td>
                <td>&nbsp;&nbsp; <input type="password" name="password" class="t1" onFocus="this.value=''"></td>
              </tr>
              <tr> 
                <td height="20" colspan="2">
                  <div align="center"> 
                  <input name="Submit" type="submit"     id="Submit" value="Logon" class="btm">
                  &nbsp;<input name="reset" type="reset" id="reset" value="Reset" class="btm">&nbsp;&nbsp;  <a href="requestPW.jsp" target="_self" class="style5"><u>Forget  Password</u>                  </a>
				  <br>
				                   </div>
                </td>
              </tr>
          </table>
            
          </form>
      </td>
    </tr>
    <tr> 
      <td width="21%" height="25" valign="bottom"><div align="left">
        
          <p><br>
          </p>
    
      </div>
      </td>
      <td width="59%" valign="bottom">
        <div align="left">
          <p><strong><span class="txtxred">•UserID 請輸入員工號。<br>
            •Password 如忘記請點<a href="requestPW.jsp" target="_self">Forget Password</a>後至<a href="http://mail.cal.aero" target="_blank">全員信箱</a>取得個人密碼。欲修改密碼，
            進入系統後，於個人專區中修改。</span></strong><br>
          <span class="txtxred">•UserID：Your Employee number•<br>
          •Password：Forgot your password? To find out your password，
		  please click on "<a href="requestPW.jsp" target="_self">Forget Password</a>" and login your web mail <a href="http://mail.cal.aero" target="_blank"><u>http://mail.cal.aero</u></a><br>
		  •You are able to modify your password after logon the sysetm!!</span></p>
        </div>
      </td>
      <td width="20%" valign="bottom">&nbsp;</td>
    </tr>
    <tr> 
      <td height="35" colspan="3" valign="bottom"><hr width="100%" size="1" noshade>
        <div align="center" class="style1">本系統建議使用
           Internet Explorer 5.5 以上版本，1024 x768 解析度<br>
        所有內容版權屬於中華航空股份有限公司所有 <br>

We recommend that you view this site with Internet
Explorer 5.5+,and with a resolution of 1024 x 768 <br>
Copyright &copy; 2004 China Airlines Inc. All rigths reserved.        </div></td>
    </tr>
    <tr> 
      <td height="35" colspan="3" valign="bottom"><div align="right"><a href="http://www.china-airlines.com" target="_blank"><img src="images/logo.jpg" border="0"></a></div></td>
    </tr>
  </table>
</div>
</body>
</html>
<script language="javascript" type="text/javascript" src="js/subWindow.js"></script>
<script language=javascript>
function f_onload()
{
   document.form1.userid.focus();
}
function checkid(){
	 if(document.form1.userid.value ==""){
	 	alert("Please insert userid!!\n請輸入帳號!!");
		document.form1.userid.focus();
		return false;
	 }
	 else if(document.form1.password.value ==""){
	 	alert("Please insert passsword!!\n請輸入密碼!!");
	 	document.form1.password.focus();
		return false;
	 }
	 else{
	 	return true;
	 }

}
</script>

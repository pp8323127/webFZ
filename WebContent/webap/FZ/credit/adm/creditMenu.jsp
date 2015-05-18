<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="ci.auth.*" %>
<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
//取得是否為PowerUser
String  unidCD=  (String) session.getAttribute("fullUCD");	//get unit cd
fzAuth.UserID userID = new fzAuth.UserID(sGetUsr,null);
fzAuth.CheckPowerUser ck = new fzAuth.CheckPowerUser();
// ck.isHasPowerUserAccount()  僅檢查是否有帳號，不檢查密碼
//add by Betty ****************************************
ci.auth.GroupsAuth ga = new ci.auth.GroupsAuth(sGetUsr);
ga.initData();
//*******************************************************
boolean eddisplay = false;
boolean efdisplay = false;
boolean otherdisplay = false;

if("189".equals(unidCD))
{
	otherdisplay = true;
}

if("EDUser".equals(sGetUsr) | "190A".equals(unidCD) | ga.isBelongThisGroup("KHHEFFZ"))
{
	eddisplay = true;
}
if (ck.isHasPowerUserAccount())
{
	efdisplay = true;
	eddisplay = true;
}

if ("195B".equals(unidCD) | ga.isBelongThisGroup("EZEFOFFICE")  | ga.isBelongThisGroup("EZEFKHH"))
{
	efdisplay = true;
}

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>實體換班記錄管理</title>
<style type="text/css">
<!--
.selected {		background-color:#FFCC99;
		color:#000000;
		font-weight: bold;
}
body,table,tr,td{
	font-family:Verdana;
	font-size:10pt;
}

.tableh{
	background-color:#FFFFCC;
	font-weight:bold;

}
.tableh2{
	background-color:#FFCC99;	
	font-weight:bold;
}
.tableh3{
	background-color:#CC9966;	
	color:#FFFFCC;
	font-weight:bold;
}
.tableh4{
	background-color:#FFCC33;	
	color:#000000;
	font-weight:bold;
}


.tableInner{
	background-color:#FFFFCC;
	
}
table,tr,td{
	padding:2pt;
	text-align:center;
}
.r{
	color:#FF0000;
}

a:link,a:visited
{
	color:#0000FF;
	text-decoration:none;
}
a:hover,a:active
{
	color:#0000FF;
	text-decoration:underline;
}

-->
</style>
<script language="javascript" type="text/javascript" src="../js/color.js"></script>
</head>

<body >
    <table width="41%"  border="0" align="center" cellpadding="0" cellspacing="0" id="t1">
      <tr>
        <td height="30"  class="selected">
          <p align="center" >全勤/積點選班管理功能</p>
        </td>
      </tr>
<%
if(eddisplay == true | efdisplay == true | otherdisplay == true)
{
%>
      <tr height="30">
        <td height="30" bgcolor= "#FFFFFF" align="left">
		   <table width="100%"  border="0" cellpadding="0" cellspacing="0">
		   <tr>
		   <td width="4%"><div align="left">*</div></td>
		   <td width="96%"><div align="left"><a href="#" onClick='linkTo("creditQuery.jsp","../../blank.htm")'>EF/ED積點維護(By Empno)</a></div></td>
		   </tr>
		   <tr>
		   <td><div align="left"></div></td>
		   <td><div align="left"><a href="#" onClick='linkTo("creditByFltQuery.jsp","../../blank.htm")'>EF積點新增(By Flt)</a></div></td>
		   </tr>
		   <tr>
		   <td><div align="left"></div></td>
		   <td><div align="left"><a href="#" onClick='linkTo("newCreditQuery.jsp","../../blank.htm")'>積點查詢</a></div></td>
		   </tr>
		   </table>
        </td>
      </tr>
<%
}
%>

<%
if(efdisplay == true)
{
%>
      <tr  height="30">
        <td height="30" bgcolor= "#FFFFCC">
          <div align="left">* <a href="#"		  onClick='linkTo("pickskjQuery2.jsp","../../blank.htm")'>EF選班申請單維護</a></div>
        </td>
      </tr>
<%
}
%>

<%
if(eddisplay == true)
{
%>
      <tr  height="30">
        <td height="30" bgcolor= "#FFFFFF">
          <div align="left">* <a href="#"		  onClick='linkTo("pickskjQuery.jsp","../../blank.htm")'>ED選班申請單處理</a></div>
        </td>
      </tr>
      <tr  height="30">
        <td height="30" bgcolor= "#FFFFCC">
          <div align="left">*<a href="#"		  onClick='linkTo("pickskjQuery3.jsp","../../blank.htm")'> ED選班申請單歷史記錄查詢</a></div>
        </td>
      </tr>
<%
}	
%>
    </table>          
</body>
</html>
<script language="javascript">
function linkTo(w1,w2){
		parent.topFrame.location.href=w1;
		parent.mainFrame.location.href=w2;
}
</script>
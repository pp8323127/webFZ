<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*" %>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if ( sGetUsr == null) 
{		//check user session start first or not login
	response.sendRedirect("sendredirect.jsp");
} 

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>新增帳號</title>
<script language="javascript">
function checkEmpno(){
	if(document.getElementById("empno").value==""){
		alert("Please insert the account(Employee number) you want to add.\n請輸入欲新增的帳號（員工號）");
		document.form1.empno.focus();
		return false;
	}else if(document.getElementById("empno").value.length <6){
		alert("account(Employee number) must be 6 characters long .\n請輸入六位數員工號");
		document.form1.empno.focus();
		return false;
	
	}else{
		if( confirm("確定要新增帳號:"+document.form1.empno.value)){

			document.form1.Submit.disabled=1;
			return true;
		}else{
			return false;
		}
	}
}
</script>
<link href="menu.css" rel="stylesheet" type="text/css">
<style type="text/css">
.table1{background-color:#EBF3FA;color:black;font-size:9pt;line-height:170%;text-decoration:none;text-transform:none;padding-left:2px;padding-right:2px;padding-top:2px;padding-bottom:2px;} 
.table2{background-color:#FFFFFF;color:black;font-size:9pt;line-height:170%;text-decoration:none;text-transform:none;padding-left:2px;padding-right:2px;padding-top:2px;padding-bottom:2px;} 
.table3{		border: 1px solid #996431;}

</style>
</head>

<body onLoad="document.form1.empno.focus()">
<form action="updAddAccount.jsp" method="post" name="form1" onsubmit="return checkEmpno()">
<div align="center">
  <table width="50%"  border="0"  class="table3" cellSpacing=0 cellpadding="0">
    <tr>
	    <td class="table1"> 
	      <div align="center"><span class="txtblue">新增使用者帳號</span></div>
	    </td>
	    
</tr>
    <tr>
    <td height="43">
      <div align="center"><span class="txtblue">欲新增的員工號(Empno)</span>
        <input name="empno" id="empno" type="text" size="6" maxlength="6">
      </div>
    </td>
    </tr>
    <tr>
      <td height="30">
        <div align="center">
          <input name="Submit" type="submit" class="btm" value="Save">
        </div>
      </td>
    </tr>
    <tr>
      <td height="30" class="table1">
        <p class="txtxred">*請先確認組員身份，再新增帳號。</p>
      </td>
    </tr>
  </table>
</div>
<p align="center">&nbsp;</p>
  <p>&nbsp;</p>
</form>
</body>
</html>

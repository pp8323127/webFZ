<%@ page contentType="text/html; charset=big5" language="java"   %>
<%
String userid = (String)session.getAttribute("userid");
if(userid == null){
		session.invalidate();
			response.sendRedirect("index.htm");
}else{
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>���K�X</title>
<style type="text/css">
body,input{font-family:Verdana, ;font-size:13px}

.t2{		
	margin:10pt;padding:10pt;text-align:justify;color:#FF0000;background-color:#FFFFCC;
	
}
</style>
</head>
<script language="JavaScript" type="text/JavaScript">
function checkForm(){

	var newPW	= document.form1.pw1.value;
	var newPW2 	= document.form1.pw2.value;

	
	if(newPW ==""){
		alert("Please provide a new password!!\n\n�п�J�s���K�X!!");
		document.form1.pw1.focus();
		return false;
	}else if(newPW2 ==""){
		alert("Please verify your new password!!\n\n�п�J�s���K�X!!");		
		document.form1.pw2.focus();
		return false;
	}else if(newPW2 != newPW){
		alert("Your passwords do no match!!\n\n�K�X���šA�ЦA����J���ܧ󪺱K�X!!");	
		document.form1.reset();		
		document.form1.pw1.focus();
		return false;
	}else if(newPW.length < 6){
		alert("Your password must be at least 6 characters long!!\n\n�K�X�ܤֻݭn����ơA�Э��s��J!!");
		document.form1.reset();		
		document.form1.pw1.focus();
		return false;
	
	}else{
		return true;
	}
}

//-->
</script>
<body onLoad="document.form1.pw1.focus()">
<form name="form1" method="post" action="forceUpdPW.jsp" onsubmit="return checkForm()">

  <table width="417" border="0" align="center" cellpadding="0" cellspacing="1" class="t2">
    <tr bgcolor="#FFFFCC">
      <td colspan="2" >
        <p >In comply with the company's information security policy and safeguard your data, please be informed that all account users are requested to check his/her password to see if it meets the following requirement: <br>
1. At least 6 characters. <br>
2. Must include one numeric(0~9) and one character(A~Z or a~z).<br>
The Cabin Crew Schedule Inquiry System will check the password specification from now on. And the password can't meet the above requirement won��t be accepted by system form now on.</p>
        <p>��󤽥q��T�w���F���ΫO�@�z��Ʀw���ʡA�Y��_�A�бN�K�X��אּ�ŦX�U�C�W�d�G <br>
  1.�K�X���צܤֻݬ����Ӧr <br>
  2.���e�ܤֻݥ]�t�@�X��r(A~Z �� a~z)�Τ@�X�Ʀr(0~9), ���o�ϥΥ���r�Υ��Ʀr.<br>
  <br>
  ���խ��Z���T���t�αN�ˬd�K�X�W�d�A�Y��_�N���������ŦX�W�z�W�d���K�X�C </p>
        <p ><br>
        </p>
      </td>
    </tr>
  </table>
  <br>
  <table width="417" border="0" align="center" cellpadding="0" cellspacing="1" class="t">
    <tr bgcolor="#EBF3FA">
      <td height="30" colspan="2">
        <div align="center">Please change your password!!</div>
      </td>
    </tr>
    <tr >
      <td width="201" height="29">
        <div align="right">New Password:</div>
      </td>
      <td width="211" height="29">
        <input type="password" name="pw1" size="12" maxlength="12">
      </td>
    </tr>
    <tr >
      <td height="29">
        <div align="right">Confirm new password: </div>
      </td>
      <td height="29">
        <input type="password" name="pw2" size="12" maxlength="12">
      </td>
    </tr>
    <tr>
      <td colspan="2" height="29">
        <div align="center">
          <input type="submit" name="Submit" value="Change Your Password">&nbsp;&nbsp;&nbsp;
          <input type="reset" name="Submit" value="Reset">
        </div>
      </td>
    </tr>
  </table>

</form>
</body>
</html>
<%
}
%>

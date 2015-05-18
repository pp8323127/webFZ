<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page  import="java.sql.*,ci.db.*"%>
<%

String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (sGetUsr == null) {
	response.sendRedirect("sendredirect.jsp");

} 

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>change Password</title>
<link href="menu.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
function checkForm(){
	var oldPW = document.getElementById("oldPW").value;
	var newPW= document.getElementById("newPW").value;
	var newPW2 = document.getElementById("newPW2").value;

	
	if(oldPW ==""){
		alert("Please provide your current password!!\n\n�п�J�K�X!!");
		document.form1.oldPW.focus();
		return false;
	}else if(newPW ==""){
		alert("Please provide a new password!!\n\n�п�J���ܧ󪺱K�X!!");
		document.form1.newPW.focus();
		return false;
	}else if(newPW2 ==""){
		alert("Please verify your new password!!\n\n�ЦA����J���ܧ󪺱K�X!!");		
		document.form1.newPW2.focus();
		return false;
	}else if(newPW2 != newPW){
		alert("Your passwords do no match!!\n\n�K�X���šA�ЦA����J���ܧ󪺱K�X!!");	
		document.form1.newPW2.value="";
		document.form1.newPW2.focus();
		return false;
	}else if (document.form1.newPW.value.length < 6) {
        alert("Your new password must be a minimum of six characters long\n\n�K�X�ܤֻݭn����ơA�Э��s��J!!");
		document.form1.newPW.value="";
		document.form1.newPW2.value="";
		document.form1.newPW.focus();
        return false;
    }else{
		return true;
	}
}

//-->
</script>
<style type="text/css">
<!--
.t2 {	margin:10pt;padding:10pt;text-align:justify;color:#FF0000;background-color:#FFFFCC;font-family:Verdana, ;font-size:13px
}
-->
</style>
</head>

<body onLoad="document.form1.oldPW.focus()">
<form name="form1" method="post" action="updatePW.jsp" onsubmit="return checkForm()">
  <div align="center">
    <table width="500"  border="0" cellspacing="0" cellpadding="0">
      <tr  bgcolor="#EBF3FA">
          <td height="44" colspan="2">
          <div align="center" class="txttitletop">Change Password </div>
        </td>
      </tr>
      <tr>
        <td width="54%" class="txtblue">
          <div align="right">Enter your <strong>Current Password</strong>:</div>
        </td>
        <td >
 <input name="oldPW" type="password" id="oldPW" size="12" maxlength="12">
        </td>
      </tr>
      <tr>
        <td class="txtblue">
          <div align="right">Choose a <strong>New Password</strong>:</div>
        </td>
        <td>
 <input name="newPW" type="password" id="newPW" size="12" maxlength="12">
  </td>
      </tr>
      <tr>
        <td class="txtblue">
          <div align="right">Confirm your <strong>New Password</strong>:</div>
        </td>
        <td>
 <input name="newPW2" type="password" id="newPW2" size="12" maxlength="12">
        </td>
      </tr>
      <tr>
        <td height="44" colspan="2">
          <div align="center">
            <input name="Submit" type="submit" class="btm"  value="Save change">&nbsp;&nbsp;&nbsp;
            <input name="reset" type="reset" id="reset" value="Reset">
          </div>
        </td>
      </tr>

    </table>  
  <table width="500" border="0" align="center" cellpadding="0" cellspacing="1" class="t2">
      <tr bgcolor="#FFFFCC">
        <td width="462" colspan="2" >
          <p>In comply with the company's information security policy and safeguard your data, please be informed that all account users are requested to check his/her password to see if it meets the following requirement:
            <br>
            1. At least 6 characters.
            <br>
            2. Must include one numeric(0~9) and one character(A~Z or a~z).<br>
            The Cabin Crew Schedule Inquiry System will check the password specification from now on. And the password can't meet the above requirement won��t be accepted by system form now on.</p>
		  <p>��󤽥q��T�w���F���ΫO�@�z��Ʀw���ʡA�Y��_�A�бN�K�X��אּ�ŦX�U�C�W�d�G
            <br>
            1.�K�X���צܤֻݬ����Ӧr
            <br>
            2.���e�ܤֻݥ]�t�@�X��r(A~Z �� a~z)�Τ@�X�Ʀr(0~9), ���o�ϥΥ���r�Υ��Ʀr.<br>
            <br>
	        ���խ��Z���T���t�αN�ˬd�K�X�W�d�A�Y��_�N���������ŦX�W�z�W�d���K�X�C
            <!--           <p >���O�@��ƾ��K�ʡA�K�X�вŦX�U�C�W��G<br>
        1.�K�X���צܤֻݬ������<br>
        2.���e�ܤֻݥ]�t�@�X��r (A-Z �� a-z)�Τ@�X�Ʀr (�ίS��Ÿ�),���o�ϥΥ���r�Υ��Ʀr.<br>
        <br>
        <br>
        To better protect your account,your new password must be a minimum of six characters long,at least within one character and a digit ( include special characters such as +,$,etc ) .<br>
          </p> -->
            </p>
	    </td>
      </tr>
    </table>

  </div>
</form>
</body>
</html>

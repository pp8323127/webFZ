<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,java.net.URLEncoder"%>
<%

String to = request.getParameter("to");
//String toAdd = "";
String toStr = "";
if("1".equals(to)){
//	toAdd = "1stcabincrewdept@email.china-airlines.com";
	toStr = "空一組 (Section 1)";
}else if("2".equals(to)){
	//toAdd = "2stcabincrewdept@email.china-airlines.com";	
	toStr = "空二組 (Section 2)";
}else if("3".equals(to)){
	//toAdd = "3rdcabincrewdept@email.china-airlines.com";	
	toStr = "空三組 (Section 3)";	
}else if("4".equals(to)){
	//toAdd = "4thcabincrewdept@email.china-airlines.com";	
	toStr = "空四組 (Section 4)";	
}else if("ef".equals(to)){
	//toAdd = "tpeef@email.china-airlines.com";	
	toStr = "TPEEFCI";
}else if("ee".equals(to)){
	//toAdd = "tpeee@email.china-airlines.com";
	toStr = "TPEEECI";
}else if("kh".equals(to)){
	//toStr = "khhefcibox@email.china-airlines.com";
	toStr = "KHHEFCI";
}else if("ea".equals(to)){
	//toStr = "629458@cal.aero";
	toStr = "行政部員關組";	
}

String subject = request.getParameter("subject");


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Example on using JavaMail</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="kbd.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="style.css">
<link rel="stylesheet" type="text/css" href="style2.css">
</head>
<body  onload='document.SendMessage.Subject.focus();'>
<p align="center" class="blue"><b>Contact EF </b></p>

<form name="SendMessage" Method="post" ONSUBMIT="return f_submit()" action="sendmailEF.jsp" >
  <table width="52%"  border="2" cellpadding="1" cellspacing="0" align="center" class="tableStyl1">
    <tr class="bgLightBlue"> 
      <td class="sel3">To</td>
      <td>
        <div align="left" class="red"><%=toStr%>         </div></td>
    </tr>
    <tr> 
      <td height="26" class="sel3">Subject</td>
      <td >
        <div align="left">
          <input type="text" name="Subject" size="50" maxlength="50" value="<%=subject%>"  >
        </div></td>
    </tr>
    <tr> 
      <td rowspan="2" class="sel3">Message</td>
      <td class="bgLightBlue"> <p align="left"> 
          <textarea name="Message" cols=50 rows=10  ></textarea>
          <br>
          <input name="submit" type="submit" value="SendMail" class="kbd">
          &nbsp;&nbsp; 
          <input name="reset" type="reset" value="Reset" class="kbd">
		  <input type="hidden" name="to" value="<%=to%>">
</p>      
      </td>
    </tr>
    <tr>
      <td ><div align="left"><span class="blue">一次寄送多人時，郵件地址請用<span class="red">逗號</span>,隔開。<br>
  若要寄至全員信箱，僅輸入員工號即可。<br>
  系統寄送上限為二十人。</span> <br>
  <span class="red"><strong>系統寄出之信件皆有紀錄可查，請勿寄送與換班無關之信件。</strong></span> </div></td>
    </tr>
  </table>
  <p>&nbsp; </p>
</form>
</body>
</html>
<script language=javascript>
function f_submit()
{  
 if(SendMessage.Message.value =="")
	{
	 	alert("Please input Message !");
		return false;
	
	}
	else 
	{
		if(confirm("系統寄出之信件皆有紀錄可查 \n請勿寄送與換班無關之信件.\n確定要送出??"))
		return true;
		else
			return false;
	}
}

</script>

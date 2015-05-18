<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>新增實體換班記錄</title>
<link rel="stylesheet" type="text/css" href="../style/kbd.css">
<link rel="stylesheet" type="text/css" href="realSwap.css" >
<link rel="stylesheet" type="text/css" href="../loadingStatus.css">

<script language="javascript" type="text/javascript" src="../js/showDate.js"></script>
<script language="javascript" type="text/javascript" >
function checkForm(){
	var a = document.form1.aempno.value;
	var r = document.form1.rempno.value;
	
	if(a == ""){
		alert("請輸入換班者員工號!!");
		document.form1.aempno.focus();
		return false;
	}else if(r == ""){
		alert("請輸入被換者員工號!!");
		document.form1.rempno.focus();
		return false;
	
	}else{
		document.form1.Submit.disabled=1;
		document.getElementById("showStatus").className="showStatus";
		return true;		
	}
}

</script>



</head>

<body onLoad="showYM('form1','year','month');document.form1.aempno.focus();">
<div id="showStatus" class="hiddenStatus">資料載入中...請稍候</div>

<div align="center">
<form name="form1" action="addRealSwap2.jsp" method="post" onsubmit="return checkForm()">
<p>&nbsp;</p>
<table width="60%"  border="0" cellpadding="0" cellspacing="1" class="tableBorder1">
  <tr class="tableInner2">
    <td height="25" colspan="2">新增KHH實體換班記錄 <span style="color:#0000FF">[Step1.選擇換班月份及員工號.]</span></td>
  </tr>
  <tr >
    <td width="28%" height="33" class="tableh5">換班年/月</td>
    <td width="72%"  >
      <div align="left">
  <select name="year">
	  <%
  java.util.Date curDate = java.util.Calendar.getInstance().getTime();
java.text.SimpleDateFormat dateFmY = new java.text.SimpleDateFormat("yyyy");
for(int i=Integer.parseInt(dateFmY.format(curDate))-1;i<=Integer.parseInt(dateFmY.format(curDate))+1;i++){
	out.print("<option value=\""+i+"\">"+i+"</option>\r\n");
}
  %>	        </select>
  /
  <select name="month">
      <option value="01">01</option>
      <option value="02">02</option>
      <option value="03">03</option>
      <option value="04">04</option>
      <option value="05" >05</option>
      <option value="06" >06</option>
      <option value="07">07</option>
      <option value="08">08</option>
      <option value="09">09</option>
      <option value="10">10</option>
      <option value="11">11</option>
      <option value="12">12</option>
  </select>
      </div>
    </td>
    </tr>
  <tr >
    <td height="33" class="tableInner2">申請者 員工號 </td>
    <td  >
      <div align="left">
        <input type="text" size="6" maxlength="6" name="aempno">
      </div>
    </td>
  </tr>
  <tr >
    <td height="33" class="tableInner3">被換者 員工號 </td>
    <td  >
      <div align="left">
        <input type="text" size="6" maxlength="6" name="rempno">
      </div>
    </td>
  </tr>
  <tr >
    <td height="33" colspan="2">
      <input name="Submit" type="submit" class="kbd" value="Next">
    </td>
    </tr>
</table>
</form>
</div>
</body>
</html>

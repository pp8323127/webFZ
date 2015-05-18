<%@ page contentType="text/html; charset=big5" language="java"  %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>高雄組員換班申請Step1</title>
<script language="javascript" type="text/javascript" src="../js/showDate.js"></script>
<script type="text/javascript" src="showAndHiddenButton.js"></script>
<link rel="stylesheet" type="text/css" href="loadingStatus.css">

<link href="swap.css" rel="stylesheet" type="text/css">
<script type="text/javascript" >
function chkForm(){
	if(document.form1.rEmpno.value == "" || document.form1.aEmpno.value == ""){
		alert("Please insert the EmployID of replacer.\n請輸入申請者/被換者員工號!!");
		return false;
	}else{
		disabledButton("submit");
		document.getElementById("showStatus").className="showStatus";
		return true;
	}
}

</script>

</head>

<body onLoad="document.form1.aEmpno.focus();showYM('form1','year','month')" >
<div id="showStatus" class="hiddenStatus">資料載入中...請稍候</div>

<div style="color:red;text-align:left;font-family:Verdana;font-size:10pt;background-color:#CCFFFF;padding:2pt;">
【高雄組員換班申請】<br>
&nbsp;Step1.輸入申請月份、申請者與被換者之員工號</div>
<form name="form1" action="step2.jsp" method="post"  onsubmit="return chkForm()">
  <p>
    <select name="year">
	  <%
  java.util.Date curDate = java.util.Calendar.getInstance().getTime();
java.text.SimpleDateFormat dateFmY = new java.text.SimpleDateFormat("yyyy");
for(int i=Integer.parseInt(dateFmY.format(curDate))-1;i<=Integer.parseInt(dateFmY.format(curDate))+1;i++){
	out.print("<option value=\""+i+"\">"+i+"</option>\r\n");
}
  %>		 
    </select>
  
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
</p>
  <p>申請者員工號：
    <input type="text" name="aEmpno" size="6" maxlength="6" onfocus="this.select()"> 
    <br>
    被換者員工號：
    <input type="text" name="rEmpno" size="6" maxlength="6" onfocus="this.select()"> 
</p>
  <p>
    <input type="submit" id="submit"  value="Next">
    <input type="reset" value="Reset">
  </p>
</form>
</body>
</html>

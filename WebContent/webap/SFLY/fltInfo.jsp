<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="al.*, java.sql.*, java.util.Date" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("logout.jsp");
} 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>flt info input</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="calendar2.js" ></script>
<script src="js/showDate.js"></script>
<script src="js/checkDate.js"></script>
<script language="JavaScript" type="text/JavaScript">
function f_onload()
{
   document.form1.trip1.focus();
}

function chkBlank(para)
{
	if(para=="new")
	{
		if(document.form1.trip1.value =="" || document.form1.trip2.value =="" )
		{ //至少要二個trip
			alert("Please insert Sector!!\n請輸入航段!!");
			document.form1.trip1.focus();
			return false;
		 }
		 else if(document.form1.fltno_1.value ==""){
			alert("Please insert Flight Number!!\n請輸入航班!!");
			document.form1.fltno_1.focus();
			return false;
		 }
		 else if(document.form1.acno.value ==""){
			alert("Please insert Craft Number!!\n請輸入機號!!");
			document.form1.acno.focus();
			return false;
		 }
		 else if(document.form1.fleet.value ==""){
			alert("Please insert Fleet!!\n請輸入機隊!!");
			document.form1.fleet.focus();
			return false;
		 }
		 else if(document.form1.pursern.value ==""){
			alert("Please insert Purser's Sern!!\n請輸入客艙經理序號!!");
			document.form1.pursern.focus();
			return false;
		 }
		 document.form1.action="viewEditListInfo.jsp";
	}
	else
	{
		document.form1.action="viewEditListInfo2.jsp"
	}
	
	document.form1.submit();
}

</script>
<style type="text/css">
<!--
.style1 {font-weight: bold}
.style2 {font-weight: bold}
.style3 {font-weight: bold}
.style4 {font-weight: bold}
.style6 {font-weight: bold; font-size: 10px; }
.style10 {color: #D6D3CE}
.style11 {color: #424984}
.style12 {font-size: 12px}
.style13 {color: #9966FF}
.style14 {color: #9C65FF}

-->
</style></head>
<body>
<span class="style1"></span>
<form method="post" name="form1" target="mainFrame" class="txtblue" id="form1" action="viewEditListInfo.jsp">
  <p align="center" class="txttitletop"><strong>Cabin Safety Check List </strong></p>
  <p align="center" class="txttitletop style12"><span class="style13">Insert flight information </span>&nbsp;&nbsp;or &nbsp;&nbsp;<span class="style14">Modify List </span><span class="style14"> Data</span></p>
  <table width="70%" height= "5" border="2" align="center" bordercolor ="#999999" bgcolor="#FFFFFF" class="fortable">
  	<tr class="fortable">
	  <td colspan="2" nowrap bgcolor="#FFFFFF"><p align="left"><span class="style6">　</span><span class="style4"><strong>Sector</strong></span><span class="style6">　</span>
          <input name="trip1" type="text" id="trip1" size="3" maxlength="3" onkeyup= "javascript:this.value=this.value.toUpperCase();">	  
          /
          <input name="trip2" type="text" id="trip2" size="3" maxlength="3" onkeyup= "javascript:this.value=this.value.toUpperCase();">
          / 
          <input name="trip3" type="text" id="trip3" size="3" maxlength="3" onkeyup= "javascript:this.value=this.value.toUpperCase();">      
          / 
          <input name="trip4" type="text" id="trip4" size="3" maxlength="3" onkeyup= "javascript:this.value=this.value.toUpperCase();">
          / 
          <input name="trip5" type="text" id="trip5" size="3" maxlength="3" onkeyup= "javascript:this.value=this.value.toUpperCase();">
          </p>
    <tr class="fortable">
				   <td colspan="2">
				     <p align="left"><strong><span class="style3">　Flight No　</span></strong>
                       <input name="fltno_1" type="text" id="fltno_1" size="4" maxlength="4">	       			   
                       /
			     	   <input name="fltno_2" type="text" id="fltno_2" size="4" maxlength="4">
			     		/
			     	   <input name="fltno_3" type="text" id="fltno_3" size="4" maxlength="4">
		      			/
              		   <input name="fltno_4" type="text" id="fltno_4" size="4" maxlength="4">
	  </p></td>
	</tr>
			<tr class="fortable">
			  <td width="50%">
			    <p align="left"><strong><span class="style3">　A/C</span></strong> <span class="style4">Type</span>			      
			      <select name="fleet" id="fleet">
			        <option value="343">343</option>
			        <option value="330">330</option>
			        <option value="738">738</option>
			        <option value="744">744</option>
			        <option value="AB6">AB6</option>
		          </select>　		        
		      </p></td>
			  <td width="50%"><div align="left"><strong>&nbsp;A/C No </strong>
                  <input name="acno" type="text" id="acno" size="6" maxlength="6" onKeyUp= "javascript:this.value=this.value.toUpperCase();">
		      </div></td>
	</tr>
	<tr class="fortable">
			  <td colspan="2"><p align="left"><strong><span class="style3">　Cabin Manager's Sern</span></strong>
                      <input name="pursern" type="text" size="5" maxlength="5">
              </p></td>
    </tr>
	<tr class="fortable">
		<td colspan="2" bgcolor="#FFFFFF">
		  <div align="left"><span class="style3"><strong>　Flight Date</strong></span>
			<input name="sdate" id="sdate" type="text" size="10" maxlength="10" class="txtblue"> 	
			<img height="20" src="images/p2.gif" width="20" onClick ="cal1.popup();">&nbsp;</div>
		 </td>
	</tr>
	<tr class="fortable">
		<td colspan="2" bordercolor ="#D4D0C8">
		   <div align="left">
		     <div align="center" valign="middle">
               <input type="button" name="Sub" value="New" onclick="chkBlank('new')">　
               <input type="reset" name="Submit2" value="Reset" onClick="javascript:location.reload()">
			   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			   <input type="button" name="Mod" value="Modify" onclick="chkBlank('mod')">
			   <span class="txtred">*請選擇日期查詢已編輯報告。</span>　
             </div>
	      </div></td>
	</tr>
  </table>

</form>

<body>
<hr width="100%" size="2" >
<br>
<table width="480"  border="0" align="center">
  <tr>
    <td><p align="center" class="txtred"><strong><span class="style11">Step 1.</span> Please fill in ALL flight information.</strong></p>
      <p align="center" class="txtred"><strong><span class="style11">Step 2.</span> Please select the status for each check item. </strong></p>
      <p align="center" class="txtred"><strong><span class="style11">Step 3.</span> Q&amp;A , Comments &amp; Suggestion, and Process fields are optional.</strong></p></td>
  </tr>
</table>
<blockquote class="style10">
  <p align="left" class="txtred"><strong>　　　　</strong></p>
</blockquote>
</body>
</html>

<script  type="text/javascript" language="javascript">
	var cal1 = new calendar2(document.forms[0].elements['sdate']);
	cal1.year_scroll = true;
	cal1.time_comp = false;
	document.getElementById("sdate").value =cal1.gen_date(new Date());
</script>



<%@ page contentType="text/html; charset=big5" language="java"  %>
<%
//response.setHeader("Cache-Control","no-cache");
//response.setDateHeader ("Expires", 0);
String userid = (String) session.getAttribute("userid") ; //get user id if already login
//***************************************
if (session.isNew() || userid == null) 
{		//check user session start first
	response.sendRedirect("../logout.jsp");
} 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>客艙經理職能評量 統計報表(1)</title>
<script language="JavaScript" src="calendar2.js" ></script>
<link href="../style.css" rel="stylesheet" type="text/css">
<script LANGUAGE="JavaScript">
function chkRequest()
{
	var sdate = eval("document.form1.sdate.value");
	var edate = eval("document.form1.edate.value");
	 if(sdate =="")
	 {
	 	alert("Please input the date range!!");
		document.form1.sdate.focus();
		return false;
	 }
	 else if(edate =="")
	 {
	 	alert("Please input the date range!!");
		document.form1.edate.focus();
		return false;
	 }
	 else if ((f_score!="" && t_score == "") | (t_score!="" && f_score == ""))
	 {
		alert("Please input the score range!!");
		document.form1.t_score.focus();
		return false;
	 }
	 else
	 {
		document.form1.Submit.disabled=1;
	 	return true;
	 }
}
</script>
</head>

<body>
<form action="PRfunc_evalStat.jsp" method="post" name="form1" target="mainFrame" class="txtblue" onsubmit="return chkRequest();">
<fieldset style="width:80%; ">
<legend class="txtred">客艙經理職能評量 統計報表</legend>
 <br>
 <table width="95%" cellpadding="2" cellspacing="2" class="tableStyle2 borderGray" align="center" border="1" style="margin: ">
<tr>
	<td width="18%" class="tablehead">DATE RANGE</td>
    <td width="82%" class="left bg6">
	<input name="sdate" id="sdate" type="text" size="10" maxlength="10" class="txtblue"> 			
	<img height="20" src="../images/p2.gif" width="20" onClick ="cal1.popup();"> ~
	<input name="edate" id="edate" type="text" size="10" maxlength="10" class="txtblue"> 			
	<img height="20" src="../images/p2.gif" width="20" onClick ="cal2.popup();"><br>
	<span class="txtred">
    *點選月曆圖示以選擇日期，或自行輸入，格式：yyyy/mm/dd。</span></td>
</tr>
<tr>
  <td class="tablehead">BASE</td>
  <td class="left">
	<select name="base">
	<option value="ALL">ALL</option>
	<option value="TPE">TPE</option>
	<option value="KHH">KHH</option>
	</select>
  </td>
</tr>
<tr>
	<td width="18%" class="tablehead">EMPNO/SERN </td>
    <td width="82%" class="left bg6"><input type="text" size="6" maxlength="6" name="empno"  id="empno" class="txtblue"></td>
</tr>
<tr>
  <td class="tablehead">SCORE</td>
  <td class="left">
  <input type="text" size="4" maxlength="4" name="f_score" id="f_score" value=""> ~   
  <input type="text" size="4" maxlength="4" name="t_score" id="t_score" value="">
  <span class="txtred">
    * Between 0 ~ 100。</span>
</td>
</tr>
<tr>
	<td width="18%" class="tablehead">INSPECTOR</td>
    <td width="82%" class="left bg6 txtblue"><input type="text" size="6" maxlength="6" name="inspector"  id="inspector" value=""></td>
</tr>
<tr>
  <td colspan="2" class="center">
	<input name="Submit" type="submit" class="txtblue" value="Query"  > 
	<input name="btn" type="button" value="Reset" class="txtblue" OnClick="document.form1.Submit.disabled=0">
  </td>
  </tr>
</table>
<br>
</fieldset>
</form>
<script  type="text/javascript" language="javascript">
	var cal1 = new calendar2(document.forms[0].elements['sdate']);
	cal1.year_scroll = true;
	cal1.time_comp = false;
	document.getElementById("sdate").value =cal1.gen_date(new Date());

	var cal2 = new calendar2(document.forms[0].elements['edate']);
	cal2.year_scroll = true;
	cal2.time_comp = false;
	document.getElementById("edate").value =cal2.gen_date(new Date());
</script>
</body>
</html>

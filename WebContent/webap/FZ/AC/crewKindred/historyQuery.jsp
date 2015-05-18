<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>查詢歷史紀錄</title>
<link rel="stylesheet" type="text/css" href="../../../style/style1.css">
<link rel="stylesheet" type="text/css" href="../../lightColor.css">
<link rel="stylesheet" type="text/css" href="../../../style/kbd.css">
<link rel="stylesheet" type="text/css" href="../../../style/loadingStatus.css">
<style type="text/css">.l{margin-left:0.5em;} .r{margin-right:0.5em;}</style>
<script language="javascript" type="text/javascript" src="../../js/showDate.js"></script>
<script language="javascript" type="text/javascript">
function chkForm(){
	if(document.getElementById("empno").value =="" 
		&& document.getElementById("selAll").checked == true ){
		alert("勾選「顯示組員所有申請紀錄」，必須輸入員工號.");
		document.getElementById("empno").focus();
		return false;
	}else{
		document.getElementById("s1").disabled=true;
		document.getElementById("showMessage").className="showStatus4";
		return true;
	}
}
</script>
</head>
<body onLoad="showYM('form1','year','month')">
<fieldset style="width:600pt; ">
<legend><img src="../../images/blue_view.gif" width="16" height="16" align="top" class="r">查詢組員家屬聯絡電話歷史紀錄</legend>
<form name="form1" method="post" action="historyData.jsp" onSubmit="return chkForm()">
<label for="year" class="blue">申請年 / 月</label>
<select name="year">
	<script language="javascript" type="text/javascript">
		var y =new Date().getFullYear() ;
	
		for(var i=2008;i<=new Date().getFullYear();i++){			
			document.write("<option value='"+i+"'"+">"+i+"</option>");
		}
	</script>
</select>
/
<select name="month" class="r">
	<jsp:include page="../../temple/month.htm"/>
</select>

<p>
  <label for="empno" ></label>
  <label for="empno" ><span class="blue">組員員工號</span>    <input type="text" name="empno" id="empno" size="6" maxlength="6">
( 若不輸入組員員工號，則顯示全部組員資料 )</label>
</p>
<p>
  <label for="selAll">
    <input type="checkbox" name="selAll" id="selAll" value="Y">
    <span class="blue">查詢組員所有申請紀錄</span></label> 
  ( 勾選此選項，必須輸入組員員工號，且不計算「申請年/月」條件。 )</p>
<p>
  <label for="selDeleted">
  <input type="checkbox" name="selDeleted" value="Y" >
    <span class="blue">查詢包含已刪除資料</span></label>
(勾選此項，將一併顯示組員自行刪除之資料。預設為不顯示。)</p>
<p>
  <label for="selDeleted"></label>
  <input type="submit"  id="s1" value="  查詢  " class="kbd">
</p>
<div id="showMessage" class="hiddenStatus"><img src="../../images/ajax-loader1.gif" width="15" height="15">Loading....</div>
</form>
</fieldset>

</body>
</html>

<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*"  %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>新增/變更家屬聯絡電話</title>
<link rel="stylesheet" type="text/css" href="checkStyle1.css">
<link rel="stylesheet" type="text/css" href="lightColor.css">
<style type="text/css">
.tfvHighlight{font-weight:bold;color:#FF0000;text-align:right;padding-right:0.5em;}
.tfvNormal{font-weight:normal;color:#0000FF;text-align:right;padding-right:0.5em;}
</style>
<script language="javascript" type="text/javascript" src="js/validator.js"></script>
<script language="javascript" type="text/javascript" >
var a_fields = {
	'kindName' : {
		'l': '家屬姓名',  // label
		'r': true,    // required
		//'f': 'integer',  // format (see below)
		't': 'kindNameL',// id of the element to highlight if input not validated
		
		'm': null,     // must match specified form field		
		'mx': 20       // maximum length
	}	,
	'kindRel' : {'l':'關係','r':true,'t':'kindRelL'},
	'kindMbl' : {'l':'家屬手機','r':true,'t':'kindMblL','f': 'integer','mn':10,'mx':10}
	
}
o_config = {
	//'to_disable' : ['Submit'],
	'alert' : 1
}
var v = new validator('form1', a_fields, o_config);

function chk(){
	if(v.exec() && confirm("確認要申請變更？")){
		document.getElementById("Submit").disabled=true;
		return true;
	}else{
		
		return false;
	}
}
</script>
</head>

<body onLoad="document.getElementById('kindName').focus();">
<%

String userid = (String)session.getAttribute("userid");
if(userid == null){
%>
<div class="paddingTopBottom1 bgLYellow red center">網頁已過期,請重新登入.</div>
<%
}else{

fzac.CrewKindred ck = new fzac.CrewKindred(userid);
ArrayList al = null;
boolean status = false;
String errMsg = "";
try {
	ck.SelectData();
	al = ck.getDataAL();
	if(al == null){
		errMsg ="目前尚無家屬聯絡資料";
	}else{
		status = true;
	}
} catch (Exception e) {
	errMsg +=e.getMessage();
}
%>

<fieldset style="width:400pt; ">
<legend class="blue"><img src="images/page_edit.gif" width="16" height="16">登錄 / 變更家屬聯絡資料</legend>
<form method="post" name="form1" action="emailCrewKindred.jsp"n onSubmit="return chk()">
<table width="100%"  border="0" cellspacing="1" cellpadding="0">
  <tr>
    <td width="30%" class="right blue"  id="kindNameL">家屬姓名*(必填)</td>
    <td width="70%" ><input type="text" name="kindName" id="kindName" size="20" maxlength="20"></td>
  </tr>
  <tr>
    <td class="right blue" id="kindRelL">關係*(必填)</td>
    <td><input type="text" name="kindRel" id="kindRel" size="20" maxlength="20"></td>
  </tr>
  <tr>
    <td class="right blue" id="kindMblL">家屬手機*(必填)</td>
    <td><input type="text" name="kindMbl" id="kindMbl" size="20" maxlength="10"> 
    (EX: 0912345678) </td>
  </tr>
  <tr>
    <td class="right">家屬家用電話</td>
    <td><input type="text" name="kindPhone" id="kindPhone" size="20" maxlength="10"> 
    (EX: 0212345678)</td>
  </tr>
  <tr>
  <td></td>
    <td ><input type="submit" id="Submit" class="buttonLPink" value="資料登錄 / 變更"></td>
  </tr>
</table>
</form>
</fieldset>
<p></p>


<fieldset style="width:400pt;">
<legend><img src="images/folder_image.gif" width="16" height="16">使用說明</legend>
<table width="100%"  border="0" cellspacing="2" cellpadding="0">
  <tr>
    <td width="30%" height="26" class="right" >申請時間：</td>
    <td width="70%" >任何時間均可上網登錄變更。</td>
  </tr>
  <tr>
    <td height="29" class="right" >資料更新：</td>
    <td >數個工作天（<span class="blue">非即時更新</span>）。</td>
  </tr>
  <tr>
    <td valign="top" class="right" >作業流程：</td>
    <td >您的申請資料，將由行政組承辦人於工作日處理及更新。
      <br>
    若下列家屬資料尚未更新，請耐心稍候。</td>
  </tr>
</table>

</fieldset>

<%
	if(!status){
%>
<div class="paddingTopBottom1 bgLYellow red"><%=errMsg%></div>
<%		
	}else{
%>
<p></p>
<fieldset style="width:400pt; ">
<legend><img src="images/application_double.gif" width="16" height="16">目前家屬資訊</legend>

<%
	for (int i = 0; i < al.size(); i++) {
		fzac.CrewKindredObj obj = (fzac.CrewKindredObj) al.get(i);
		if(i!=0){
			//out.print("<hr>");
		}
				
%>
<table width="100%"  border="0" cellspacing="1" cellpadding="2" class="<%if(i%2==1){%>bgLBlue<%}else{%>bgLYellow<%}%>">
  <tr>
    <td width="30%" class="right" >家屬姓名：</td>
    <td width="70%" class="left" ><%=obj.getKindredName()%></td>
  </tr>
  <tr>
    <td class="right">關係：</td>
    <td class="left"><%=obj.getRelation_Desc()%></td>
  </tr>
  <tr>
    <td class="right">家屬手機：</td>
    <td class="left"><%=obj.getKindredMobile()%></td>
  </tr>
  <tr>
    <td class="right">家屬家用電話：</td>
    <td class="left"><%=obj.getKindredPhone()%></td>
  </tr>
 
</table>
<%	
	}
%></fieldset>
<%	
	}
%>

</body>
</html>
<%
}
%>

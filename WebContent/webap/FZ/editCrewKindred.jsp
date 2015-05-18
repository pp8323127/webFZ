<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*"  %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>�s�W/�ܧ�a���p���q��</title>
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
		'l': '�a�ݩm�W',  // label
		'r': true,    // required
		//'f': 'integer',  // format (see below)
		't': 'kindNameL',// id of the element to highlight if input not validated
		
		'm': null,     // must match specified form field		
		'mx': 20       // maximum length
	}	,
	'kindRel' : {'l':'���Y','r':true,'t':'kindRelL'},
	'kindMbl' : {'l':'�a�ݤ��','r':true,'t':'kindMblL','f': 'integer','mn':10,'mx':10}
	
}
o_config = {
	//'to_disable' : ['Submit'],
	'alert' : 1
}
var v = new validator('form1', a_fields, o_config);

function chk(){
	if(v.exec() && confirm("�T�{�n�ӽ��ܧ�H")){
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
<div class="paddingTopBottom1 bgLYellow red center">�����w�L��,�Э��s�n�J.</div>
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
		errMsg ="�ثe�|�L�a���p�����";
	}else{
		status = true;
	}
} catch (Exception e) {
	errMsg +=e.getMessage();
}
%>

<fieldset style="width:400pt; ">
<legend class="blue"><img src="images/page_edit.gif" width="16" height="16">�n�� / �ܧ�a���p�����</legend>
<form method="post" name="form1" action="emailCrewKindred.jsp"n onSubmit="return chk()">
<table width="100%"  border="0" cellspacing="1" cellpadding="0">
  <tr>
    <td width="30%" class="right blue"  id="kindNameL">�a�ݩm�W*(����)</td>
    <td width="70%" ><input type="text" name="kindName" id="kindName" size="20" maxlength="20"></td>
  </tr>
  <tr>
    <td class="right blue" id="kindRelL">���Y*(����)</td>
    <td><input type="text" name="kindRel" id="kindRel" size="20" maxlength="20"></td>
  </tr>
  <tr>
    <td class="right blue" id="kindMblL">�a�ݤ��*(����)</td>
    <td><input type="text" name="kindMbl" id="kindMbl" size="20" maxlength="10"> 
    (EX: 0912345678) </td>
  </tr>
  <tr>
    <td class="right">�a�ݮa�ιq��</td>
    <td><input type="text" name="kindPhone" id="kindPhone" size="20" maxlength="10"> 
    (EX: 0212345678)</td>
  </tr>
  <tr>
  <td></td>
    <td ><input type="submit" id="Submit" class="buttonLPink" value="��Ƶn�� / �ܧ�"></td>
  </tr>
</table>
</form>
</fieldset>
<p></p>


<fieldset style="width:400pt;">
<legend><img src="images/folder_image.gif" width="16" height="16">�ϥλ���</legend>
<table width="100%"  border="0" cellspacing="2" cellpadding="0">
  <tr>
    <td width="30%" height="26" class="right" >�ӽЮɶ��G</td>
    <td width="70%" >����ɶ����i�W���n���ܧ�C</td>
  </tr>
  <tr>
    <td height="29" class="right" >��Ƨ�s�G</td>
    <td >�ƭӤu�@�ѡ]<span class="blue">�D�Y�ɧ�s</span>�^�C</td>
  </tr>
  <tr>
    <td valign="top" class="right" >�@�~�y�{�G</td>
    <td >�z���ӽи�ơA�N�Ѧ�F�թӿ�H��u�@��B�z�Χ�s�C
      <br>
    �Y�U�C�a�ݸ�Ʃ|����s�A�Э@�ߵy�ԡC</td>
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
<legend><img src="images/application_double.gif" width="16" height="16">�ثe�a�ݸ�T</legend>

<%
	for (int i = 0; i < al.size(); i++) {
		fzac.CrewKindredObj obj = (fzac.CrewKindredObj) al.get(i);
		if(i!=0){
			//out.print("<hr>");
		}
				
%>
<table width="100%"  border="0" cellspacing="1" cellpadding="2" class="<%if(i%2==1){%>bgLBlue<%}else{%>bgLYellow<%}%>">
  <tr>
    <td width="30%" class="right" >�a�ݩm�W�G</td>
    <td width="70%" class="left" ><%=obj.getKindredName()%></td>
  </tr>
  <tr>
    <td class="right">���Y�G</td>
    <td class="left"><%=obj.getRelation_Desc()%></td>
  </tr>
  <tr>
    <td class="right">�a�ݤ���G</td>
    <td class="left"><%=obj.getKindredMobile()%></td>
  </tr>
  <tr>
    <td class="right">�a�ݮa�ιq�ܡG</td>
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

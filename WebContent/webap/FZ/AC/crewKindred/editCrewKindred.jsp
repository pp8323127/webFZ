<%@ page contentType="text/html; charset=big5" language="java"   %>
<%@ page import="java.sql.*,fzac.crewkindred.*,java.text.*"%>
<%

String userid = (String)session.getAttribute("userid");

String errMsg = "";
boolean  status = true;
RetrieveKindredData rd = null;
CrewKindredObj noneExportedObj = null;//�|���פJ����ơ]�@���^
ArrayList exportedDataAL= null;	//�w�פJ�����v��ơ]�h���^
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm",Locale.TAIWAN);
CrewKindredObj activeDataObj = null;

if( userid == null){
	errMsg = "�����w�L���A�Э��s�n�J";
}else{

	try {
		rd = new RetrieveKindredData(userid);
		
		if (rd.hasNoneExportedData()) {
			noneExportedObj = rd.getNoneExportedObj();
		}
		
		if (rd.getKindredAL() != null) {
			exportedDataAL = rd.getKindredAL() ;
		}
		
		rd.SelectActiveData();
		activeDataObj = rd.getActiveCKDataObj();
		
		status = true;
	} catch (Exception e) {
		status = false;
		errMsg +="ERROR:"+e.getMessage();	
	}
	
	
	
	
	
	
}

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>�s�W/�ܧ�a���p���q��</title>
<link rel="stylesheet" type="text/css" href="../../checkStyle1.css">
<link rel="stylesheet" type="text/css" href="../../lightColor.css">
<link rel="stylesheet" type="text/css" href="../../../style/kbd.css">
<link rel="stylesheet" type="text/css" href="../../../style/loadingStatus.css">
<style type="text/css">
.tfvHighlight{font-weight:bold;color:#FF0000;text-align:right;padding-right:0.5em;}
.tfvNormal{font-weight:normal;color:#0000FF;text-align:right;padding-right:0.5em;}
.l{margin-left:0.5em;} 
.r{margin-right:0.5em;}

</style>

</head>

<body onLoad="document.getElementById('kindSName').focus();">

<%
if(!status){
%>
<div class="paddingTopBottom1 bgLYellow red center"><%=errMsg%></div>
<%
}else{
%>
<script language="javascript" type="text/javascript" src="../../js/validator.js"></script>
<script language="javascript" type="text/javascript" >
var a_fields = {
	'kindSName' : {
		'l': '�a�ݩm��',  // label
		'r': true,    // required
		//'f': 'integer',  // format (see below)
		't': 'kindSNameL',// id of the element to highlight if input not validated
		
		'm': null,     // must match specified form field		
		'mx': 20       // maximum length
	}	,
	'kindFName' : {
		'l': '�a�ݦW�r',  // label
		'r': true,    // required
		//'f': 'integer',  // format (see below)
		't': 'kindFNameL',// id of the element to highlight if input not validated
		
		'm': null,     // must match specified form field		
		'mx': 20       // maximum length
	}	,
	'kindMbl' : {'l':'�a�ݤ��','r':true,'t':'kindMblL','f': 'integer','mn':10,'mx':10}
	
}
o_config = {
	//'to_disable' : ['Submit'],
	'alert' : 1
}
var v = new validator('form1', a_fields, o_config);

function chk(){
	document.form1.action="updCrewKindred.jsp";
	var kindMbl = document.getElementById("kindMbl").value;

	if(v.exec() && "09"==kindMbl.substring(0,2) && confirm("�T�{�n�ӽЩέק惡���a�ݸ�ơH") ){
		submitForm();
		document.getElementbyId("kindRelL").className='tfvNormal';		
		return true;
	}else{
		if(kindMbl != "" && kindMbl.length==10 && "09"!=kindMbl.substring(0,2)){
			document.getElementById("kindMblL").className='tfvHighlight';
			document.getElementById("kindMbl").focus();
			alert("������X�榡����,\n�ݬ�09�}�Y���Q��Ʀr.\n�Э��s��J���T������X!!");

		}
		
		return false;
		
	}
}

function delData(){
var  ms = "�ثe���@���|���ͮĤ��p���H��Ʀp�U�G\n\n"
		ms +="�m�W�G"+document.getElementById("kindSName").value+" "+document.getElementById("kindFName").value+"\n";
	  	 ms +="����G"+document.getElementById("kindMbl").value+"\n\n";
		 ms+="�T�w�n�����ӽЦ����a�ݸ��??";


	if(confirm(ms)){
		document.form1.action="delCrewKindred.jsp";
		submitForm();
		document.form1.submit();
		
		return true;
	}else{
		return false;
	}

}

function submitForm(){
			document.getElementById("showMessage").className="showStatus4";
			document.getElementById("Submit").disabled=true;
			
			if(document.getElementById("delButton") != null){
				document.getElementById("delButton").disabled=true;
			}
			
			if(document.getElementById("delActiveButton") != null){
				document.getElementById("delActiveButton").disabled=true;
			}

}
</script>

<fieldset style="width:550pt; ">
<legend class="red"><img src="../../images/pencil.gif" width="16" height="16">�n�� / �ܧ�a���p�����

</legend>

<form method="post" name="form1" action="updCrewKindred.jsp" onSubmit="return chk()">
<table width="100%"   cellspacing="2" cellpadding="5" >
	<caption class="blue bold left" valign="bottom" style="padding-left:10em; ">
<%if(noneExportedObj != null){%>

	<div><img src="../../images/information.png" width="16" height="16" align="top" class="r">�{�b���@���ӽи�Ʃ|���ͮ�,�z�i��ܭק�Ψ��������ӽи��.</div>

    <%}

if(activeDataObj != null){
%>
<div><img src="../../images/information.png" width="16" height="16" align="top" class="r">�ثe���Ĥ��p���H��Ƭ��G<%=activeDataObj.getKindred_surName()+" "+activeDataObj.getKindred_First_Name()%>,����G<%=activeDataObj.getKinddred_Phone_Num()%></div>
<%
}
%>
	</caption>
  <tr >
    <td width="30%" class="right blue"  id="kindNameL">�a�ݩm�W</td>
    <td width="70%" >
	<label for="kindSName" id="kindSNameL">�m��</label><input type="text" name="kindSName" id="kindSName" size="20" maxlength="30"m style="margin-right:1em;margin-left:0.5em "><br>

	<label for="kindFName" id="kindFNameL">�W�r</label><input type="text" name="kindFName" id="kindFName" size="20" maxlength="100" m style="margin-right:1em;margin-left:0.5em "></td>
  </tr>
  <tr >
    <td class="right blue " id="kindMblL">�a�ݤ��</td>
    <td ><input type="text" name="kindMbl" id="kindMbl" size="25" maxlength="10"> 
    (EX: 0912345678) </td>
  </tr>  
  <tr >
<td></td>
    <td  class="left"  ><button type="submit" class="kbd r" id="Submit"  ><img src="../../images/pencil.gif" width="16" height="16" align="top" class="r">�ӽ� / �ק�</button>
	<%
	if(noneExportedObj != null){
	%>
	
	<button type="button" class="kbd r" id="delButton" onClick="delData()"><img src="../../images/delete_gray.gif" width="16" height="16" align="top" class="r">�������ӽ�</button>
	<%
	}
	
	if(activeDataObj != null){
	%>
	
	
	<button type="button" class="kbd" id="delActiveButton"  onClick="delActive()" ><img src="../../images/cancel_16x16.png" width="16" height="16" align="top" class="r">�R���p���H</button>
		<%
	}
	
	%><div id="showMessage" class="hiddenStatus"><img src="../../images/ajax-loader1.gif" width="15" height="15">Loading....</div></td>
  </tr>
</table>
</form>

<%
	if(noneExportedObj != null){
%>
<script language="javascript" type="text/javascript">
document.getElementById("kindSName").value="<%=noneExportedObj.getKindred_surName()%>";
document.getElementById("kindFName").value="<%=noneExportedObj.getKindred_First_Name()%>";
document.getElementById("kindMbl").value="<%=noneExportedObj.getKinddred_Phone_Num()%>";

</script>
<%
}
if( activeDataObj != null){
%>
<form name="form2" method="post" action="updCrewKindred.jsp">
<input type="hidden" name="kindSName" value="<%=activeDataObj.getKindred_surName()%>">
<input type="hidden" name="kindFName" value="<%=activeDataObj.getKindred_First_Name()%>">
<input type="hidden" name="kindMbl" value="<%=activeDataObj.getKinddred_Phone_Num()%>">
<input type="hidden" name="deleteCK_ind" value="Y">
</form>
<script language="javascript" type="text/javascript" >
function delActive(){
	var  ms = "�ثe�w�ͮĤ��p���H��Ʀp�U�G\n\n"
		ms +="�m�W�G"+"<%=activeDataObj.getKindred_surName()%>"+" "+"<%=activeDataObj.getKindred_First_Name()%>"+"\n";
	  	 ms +="����G"+"<%=activeDataObj.getKinddred_Phone_Num()%>"+"\n\n";
		 ms+="�O�_�T�w�n�R�����p���H���??";
		 if(confirm(ms)){
			submitForm();
			document.form2.submit();
		 }

}
</script>
<%
}

%>
</fieldset>

<p></p>
<%
if( exportedDataAL != null){
%>

<fieldset style="width:550pt;">
<legend><img src="../../images/database_save.gif" width="16" height="16">���v�ӽи��</legend>
<table width="100%"  border="1" cellspacing="2" cellpadding="2" class="tableStyle2">
<tr class="bgLBlue3 center" height="24">
	<td width="14%">���O</td>
	<td width="28%"  >�a�ݩm�W</td>
	<td width="18%">�a�ݤ��</td>
	<td width="20%">�ӽЮɶ�</td>
	<td width="20%">��s�ɶ�</td>			
</tr>
<%//�ثe�w�ӽЩ|���ͮġ]�B�z���^�����
if(noneExportedObj != null){
%>
<tr class="left">
<td class="center"><%
	if(null ==noneExportedObj.getDelete_ind()){
	%>
	  <img src="../../images/cancel_16x16.png" width="16" height="16" align="top" class="center" alt="�ӽЧR��" title="�ӽЧR��">
	<%
	
	}else if("N".equals( noneExportedObj.getDelete_ind())){%>
<img src="../../images/accept.png" width="16" height="16" align="top" class="center" alt="��Ƥw�פJ" title="��Ƥw�פJ">
    <%}%></td>
<td ><%=noneExportedObj.getKindred_surName()+"&nbsp;"+noneExportedObj.getKindred_First_Name()%></td>
<td class="center"><%=noneExportedObj.getKinddred_Phone_Num()%></td>
<td><%=formatter.format(noneExportedObj.getApply_time())%></td>
<td class="center red bold">�@�~�B�z��</td>
</tr>
<%
}

	for(int i=0;i<exportedDataAL.size();i++){
		CrewKindredObj  obj = (CrewKindredObj)exportedDataAL.get(i);
%>
<tr class="left<%if(i%2==0){%> bgLBlue<%}%>">
<td class="center"><%
	if(null ==obj.getDelete_ind()){
	%>
	  <img src="../../images/cancel_16x16.png" width="16" height="16" align="top" class="center" alt="�ӽЧR��" title="�ӽЧR��">
	<%
	
	}else if("Y".equals( obj.getDelete_ind())){%>
  <img src="../../images/delete_gray.gif" width="16" height="16" align="top" class="center" alt="�ӽШ���" title="�ӽШ���">
    <%}else if("Y".equals( obj.getExport_ind())){
	%>
	  <img src="../../images/accept.png" width="16" height="16" align="top" class="center" alt="��Ƥw�פJ" title="��Ƥw�פJ">
	<% } 	%></td>
	 <td><%=obj.getKindred_surName()+"&nbsp;"+obj.getKindred_First_Name()%></td>
  <td class="center"><%=obj.getKinddred_Phone_Num()%></td>
  <td><%=formatter.format(obj.getApply_time())%></td>  
  <td><%if(obj.getExport_time() != null){out.print(formatter.format(obj.getExport_time()));}
  else if(obj.getExport_time()==null && !"Y".equals(obj.getDelete_ind()) && "N".equals(obj.getExport_ind())){
  	//���ݧ�s�����
  %>
  <div class="red bold center">�@�~�B�z��</div>
  <%	
  }
  
  %></td>
</tr>

<%
}
%>
<tr >
  <td colspan="5" class="bgLGray left">
   <img src="../../images/accept.png" width="16" height="16" align="top">�G�ӽзs�W/�ק惡���p���H��T<br>
   <img src="../../images/delete_gray.gif" width="16" height="16" align="top">�G�b�����J�e�A�w�ۦ���������ӽ�<br>
   <img src="../../images/cancel_16x16.png" width="16" height="16" align="top" >�G�ӽЧR���w�ͮĤ��p���H��T

  </td>
  </tr>
</table>

</fieldset>
<%
	}//�����v���
	
}
%>
<p></p>


<fieldset style="width:550pt;">
<legend><span class="red"><img src="../../images/readme.png" width="16" height="16" align="top"></span>�ϥλ���</legend>
<table width="100%"  border="0" cellspacing="2" cellpadding="0">
  <tr>
    <td width="30%" height="26" class="right" >�ӽЮɶ��G</td>
    <td width="70%" >����ɶ����i�W���n���ܧ�C</td>
  </tr>
  <tr>
    <td height="29" class="right" >��Ƨ�s�G</td>
    <td >2 �Ӥu�@�ѡC</td>
  </tr>
  <tr>
    <td valign="top" class="right" >�@�~�y�{�G</td>
    <td ><p>�z���ӽи�ơA�N�Ѧ�F���ӿ�H�T�{��B�z�ç�s<br>
�Y��Ʃ|����s�A�Э@�ߵy��<br>
      ��Ƨ�s�e�A�i�ק�ΧR��<br>
      ��Ƨ�s��A�i�˵��Ҧ��ӽЪ����v����</p>
    </td>
  </tr>
  <tr>
    <td valign="top" class="right" >�Բӻ����G</td>
    <td ><a href="readme.htm" target="_blank">�аѾ\�������<img src="../../images/bullet_go.gif" width="16" height="16" align="top" class="l"></a></td>
  </tr>
</table>

</fieldset>
</body>
</html>

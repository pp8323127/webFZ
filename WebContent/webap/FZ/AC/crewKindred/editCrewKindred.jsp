<%@ page contentType="text/html; charset=big5" language="java"   %>
<%@ page import="java.sql.*,fzac.crewkindred.*,java.text.*"%>
<%

String userid = (String)session.getAttribute("userid");

String errMsg = "";
boolean  status = true;
RetrieveKindredData rd = null;
CrewKindredObj noneExportedObj = null;//尚未匯入的資料（一筆）
ArrayList exportedDataAL= null;	//已匯入的歷史資料（多筆）
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm",Locale.TAIWAN);
CrewKindredObj activeDataObj = null;

if( userid == null){
	errMsg = "網頁已過期，請重新登入";
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
<title>新增/變更家屬聯絡電話</title>
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
		'l': '家屬姓氏',  // label
		'r': true,    // required
		//'f': 'integer',  // format (see below)
		't': 'kindSNameL',// id of the element to highlight if input not validated
		
		'm': null,     // must match specified form field		
		'mx': 20       // maximum length
	}	,
	'kindFName' : {
		'l': '家屬名字',  // label
		'r': true,    // required
		//'f': 'integer',  // format (see below)
		't': 'kindFNameL',// id of the element to highlight if input not validated
		
		'm': null,     // must match specified form field		
		'mx': 20       // maximum length
	}	,
	'kindMbl' : {'l':'家屬手機','r':true,'t':'kindMblL','f': 'integer','mn':10,'mx':10}
	
}
o_config = {
	//'to_disable' : ['Submit'],
	'alert' : 1
}
var v = new validator('form1', a_fields, o_config);

function chk(){
	document.form1.action="updCrewKindred.jsp";
	var kindMbl = document.getElementById("kindMbl").value;

	if(v.exec() && "09"==kindMbl.substring(0,2) && confirm("確認要申請或修改此筆家屬資料？") ){
		submitForm();
		document.getElementbyId("kindRelL").className='tfvNormal';		
		return true;
	}else{
		if(kindMbl != "" && kindMbl.length==10 && "09"!=kindMbl.substring(0,2)){
			document.getElementById("kindMblL").className='tfvHighlight';
			document.getElementById("kindMbl").focus();
			alert("手機號碼格式不符,\n需為09開頭的十位數字.\n請重新輸入正確手機號碼!!");

		}
		
		return false;
		
	}
}

function delData(){
var  ms = "目前有一筆尚未生效之聯絡人資料如下：\n\n"
		ms +="姓名："+document.getElementById("kindSName").value+" "+document.getElementById("kindFName").value+"\n";
	  	 ms +="手機："+document.getElementById("kindMbl").value+"\n\n";
		 ms+="確定要取消申請此筆家屬資料??";


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
<legend class="red"><img src="../../images/pencil.gif" width="16" height="16">登錄 / 變更家屬聯絡資料

</legend>

<form method="post" name="form1" action="updCrewKindred.jsp" onSubmit="return chk()">
<table width="100%"   cellspacing="2" cellpadding="5" >
	<caption class="blue bold left" valign="bottom" style="padding-left:10em; ">
<%if(noneExportedObj != null){%>

	<div><img src="../../images/information.png" width="16" height="16" align="top" class="r">現在有一筆申請資料尚未生效,您可選擇修改或取消此筆申請資料.</div>

    <%}

if(activeDataObj != null){
%>
<div><img src="../../images/information.png" width="16" height="16" align="top" class="r">目前有效之聯絡人資料為：<%=activeDataObj.getKindred_surName()+" "+activeDataObj.getKindred_First_Name()%>,手機：<%=activeDataObj.getKinddred_Phone_Num()%></div>
<%
}
%>
	</caption>
  <tr >
    <td width="30%" class="right blue"  id="kindNameL">家屬姓名</td>
    <td width="70%" >
	<label for="kindSName" id="kindSNameL">姓氏</label><input type="text" name="kindSName" id="kindSName" size="20" maxlength="30"m style="margin-right:1em;margin-left:0.5em "><br>

	<label for="kindFName" id="kindFNameL">名字</label><input type="text" name="kindFName" id="kindFName" size="20" maxlength="100" m style="margin-right:1em;margin-left:0.5em "></td>
  </tr>
  <tr >
    <td class="right blue " id="kindMblL">家屬手機</td>
    <td ><input type="text" name="kindMbl" id="kindMbl" size="25" maxlength="10"> 
    (EX: 0912345678) </td>
  </tr>  
  <tr >
<td></td>
    <td  class="left"  ><button type="submit" class="kbd r" id="Submit"  ><img src="../../images/pencil.gif" width="16" height="16" align="top" class="r">申請 / 修改</button>
	<%
	if(noneExportedObj != null){
	%>
	
	<button type="button" class="kbd r" id="delButton" onClick="delData()"><img src="../../images/delete_gray.gif" width="16" height="16" align="top" class="r">取消此申請</button>
	<%
	}
	
	if(activeDataObj != null){
	%>
	
	
	<button type="button" class="kbd" id="delActiveButton"  onClick="delActive()" ><img src="../../images/cancel_16x16.png" width="16" height="16" align="top" class="r">刪除聯絡人</button>
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
	var  ms = "目前已生效之聯絡人資料如下：\n\n"
		ms +="姓名："+"<%=activeDataObj.getKindred_surName()%>"+" "+"<%=activeDataObj.getKindred_First_Name()%>"+"\n";
	  	 ms +="手機："+"<%=activeDataObj.getKinddred_Phone_Num()%>"+"\n\n";
		 ms+="是否確定要刪除此聯絡人資料??";
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
<legend><img src="../../images/database_save.gif" width="16" height="16">歷史申請資料</legend>
<table width="100%"  border="1" cellspacing="2" cellpadding="2" class="tableStyle2">
<tr class="bgLBlue3 center" height="24">
	<td width="14%">註記</td>
	<td width="28%"  >家屬姓名</td>
	<td width="18%">家屬手機</td>
	<td width="20%">申請時間</td>
	<td width="20%">更新時間</td>			
</tr>
<%//目前已申請尚未生效（處理中）的資料
if(noneExportedObj != null){
%>
<tr class="left">
<td class="center"><%
	if(null ==noneExportedObj.getDelete_ind()){
	%>
	  <img src="../../images/cancel_16x16.png" width="16" height="16" align="top" class="center" alt="申請刪除" title="申請刪除">
	<%
	
	}else if("N".equals( noneExportedObj.getDelete_ind())){%>
<img src="../../images/accept.png" width="16" height="16" align="top" class="center" alt="資料已匯入" title="資料已匯入">
    <%}%></td>
<td ><%=noneExportedObj.getKindred_surName()+"&nbsp;"+noneExportedObj.getKindred_First_Name()%></td>
<td class="center"><%=noneExportedObj.getKinddred_Phone_Num()%></td>
<td><%=formatter.format(noneExportedObj.getApply_time())%></td>
<td class="center red bold">作業處理中</td>
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
	  <img src="../../images/cancel_16x16.png" width="16" height="16" align="top" class="center" alt="申請刪除" title="申請刪除">
	<%
	
	}else if("Y".equals( obj.getDelete_ind())){%>
  <img src="../../images/delete_gray.gif" width="16" height="16" align="top" class="center" alt="申請取消" title="申請取消">
    <%}else if("Y".equals( obj.getExport_ind())){
	%>
	  <img src="../../images/accept.png" width="16" height="16" align="top" class="center" alt="資料已匯入" title="資料已匯入">
	<% } 	%></td>
	 <td><%=obj.getKindred_surName()+"&nbsp;"+obj.getKindred_First_Name()%></td>
  <td class="center"><%=obj.getKinddred_Phone_Num()%></td>
  <td><%=formatter.format(obj.getApply_time())%></td>  
  <td><%if(obj.getExport_time() != null){out.print(formatter.format(obj.getExport_time()));}
  else if(obj.getExport_time()==null && !"Y".equals(obj.getDelete_ind()) && "N".equals(obj.getExport_ind())){
  	//等待更新的資料
  %>
  <div class="red bold center">作業處理中</div>
  <%	
  }
  
  %></td>
</tr>

<%
}
%>
<tr >
  <td colspan="5" class="bgLGray left">
   <img src="../../images/accept.png" width="16" height="16" align="top">：申請新增/修改此筆聯絡人資訊<br>
   <img src="../../images/delete_gray.gif" width="16" height="16" align="top">：在資料轉入前，已自行取消此筆申請<br>
   <img src="../../images/cancel_16x16.png" width="16" height="16" align="top" >：申請刪除已生效之聯絡人資訊

  </td>
  </tr>
</table>

</fieldset>
<%
	}//有歷史資料
	
}
%>
<p></p>


<fieldset style="width:550pt;">
<legend><span class="red"><img src="../../images/readme.png" width="16" height="16" align="top"></span>使用說明</legend>
<table width="100%"  border="0" cellspacing="2" cellpadding="0">
  <tr>
    <td width="30%" height="26" class="right" >申請時間：</td>
    <td width="70%" >任何時間均可上網登錄變更。</td>
  </tr>
  <tr>
    <td height="29" class="right" >資料更新：</td>
    <td >2 個工作天。</td>
  </tr>
  <tr>
    <td valign="top" class="right" >作業流程：</td>
    <td ><p>您的申請資料，將由行政部承辦人確認後處理並更新<br>
若資料尚未更新，請耐心稍候<br>
      資料更新前，可修改或刪除<br>
      資料更新後，可檢視所有申請的歷史紀錄</p>
    </td>
  </tr>
  <tr>
    <td valign="top" class="right" >詳細說明：</td>
    <td ><a href="readme.htm" target="_blank">請參閱說明文件<img src="../../images/bullet_go.gif" width="16" height="16" align="top" class="l"></a></td>
  </tr>
</table>

</fieldset>
</body>
</html>

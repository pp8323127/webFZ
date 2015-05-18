<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*"%>
<%@ page import = "eg.flightcheckitem.*"%>			
<%
String seqno = request.getParameter("seqno");
String fltd = request.getParameter("fltd");
String fltno = request.getParameter("fltno");
String sector = request.getParameter("sector");
String psrEmpn = request.getParameter("psrEmpn");
String LingPar = request.getParameter("LingPar");
String goPage = request.getParameter("goPage");


		 
RetrieveCheckItem rCk = new RetrieveCheckItem(seqno);
CheckMainItemObj obj = null;
boolean status = false;
String errMsg  = "";

try{
	rCk.SelectData();
	obj = rCk.getChkMainItemObj();
	status = true;
}catch(Exception e){
	errMsg 	 +="ERROR:"+ e.toString();
}
%>	
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="checkStyle1.css">
<link rel="stylesheet" type="text/css" href="kbd.css">
<link rel="stylesheet" type="text/css" href="loadingStatus.css">
<title>編輯查核項目</title>
</head>

<body>
<%
if(!status){
%>
<div><%=errMsg%></div>
<%
}else{
%>
<form  name="form1" method="post" onReset="clearForm()" action="insChkItem.jsp" onSubmit="return chkUpdForm()">
<fieldset style="width:70% " >
	<legend>
<span class="red"><%=obj.getDescription()%></span>
Flight Date:<span class="blue"><%=fltd%></span>,
Fltno :<span class="blue"><%=fltno%></span>,
Sector:<span class="blue"><%=sector%></span>,
Purser:<span class="blue"><%=psrEmpn%></span><br>
</legend>


<fieldset style="width:80% " >
	<legend><input type="radio" name="executeStatus" value="Y" onClick="document.getElementById('exY').className='display';document.getElementById('exN').className='hidden';document.getElementById('esYComm').focus();" >已執行</legend>
	<div id="exY" class="hidden">
	<li>
	 	 <input type="radio" name="ev" value="Y" onClick="document.getElementById('evN').className='hidden';" >執行一切正常</li>
	<li>
	<input type="radio" name="ev" value="N" onClick="document.getElementById('evN').className='display';">執行未達標準
	</li>
	 
	<br><br>
	<%
	
	if(obj.getCheckDetailAL() != null)
	{
	%>
	<div class="hidden" id="evN">
		<table border="0" cellpadding="0" cellspacing="2" width="100%" style="margin-left:2em;" class="tableStyle2">
		<tr class="bg4 bottomBorderStyle1 center rightBottomStyle1"  >
			<td width="10%" height="22">Select</td>
			<td width="10%">是否矯正</td>
			<td width="80%" class="left">未達標準選項</td>
		</tr>
	        <%
		for(int i=0;i<obj.getCheckDetailAL().size();i++){
			CheckDetailItemObj dObj = (CheckDetailItemObj)obj.getCheckDetailAL().get(i);
			if(dObj.isExecuteStatus() && !dObj.isEvalStatus()){
				//out.print(dObj.getDescription()+"<Br>");
	%>
		<tr class="center<%if(i%2==1){out.print(" bg6");}%>">
			<td><input type="checkbox" name="evItm" value="<%=dObj.getItemSeqno()%>" onClick="showCoi('coi<%=i%>',this.checked)" ></td>
			<td><input type="checkbox" name="correctItm" id="coi<%=i%>" value="<%=dObj.getItemSeqno()%>" disabled ></td>
			<td class="left"><%=dObj.getDescription()%></td>
		</tr>
	<%				
			}
			
		}
	%>
		</table>
	</div>	
	<%	
	}
	%>
	
		<div style="margin-left:2em;">
			Comments：<br>
		<textarea name="esYComm" cols="40" rows="5" id="esYComm"></textarea><br>
		*字數限制100個中文字或200個英文字.
		</div>
	</div>
	
</fieldset>	
<fieldset style="width:80%; ">
	<legend><input type="radio" name="executeStatus" value="N" onClick="document.getElementById('exN').className='display';document.getElementById('exY').className='hidden';document.getElementById('esNComm').focus();">未執行</legend>
<div  id="exN" class="hidden" style="margin-left:2em;">
	Comments(<span class="red">必須輸入原因</span>)<br>
<textarea name="esNComm" cols="40" rows="5" id="esNComm"></textarea><br>
*字數限制100個中文字或200個英文字.

  </div>	
</fieldset>	<br>

<input type="submit" id="submitForm" value="儲存" class="kbd">&nbsp;&nbsp;<input type="reset" value="清除" class="kbd" id="resetForm">
<div id="showMsg" class="hidden"><img src="../../images/ajax-loader1.gif" width="15" height="15" align="absmiddle">loading.....</div>

<%
}
%>
	</fieldset>
	<input type="hidden" name="seqno" value="<%=seqno%>">
	<input type="hidden" name="fltd" value="<%=fltd%>">
	<input type="hidden" name="fltno" value="<%=fltno%>">
	<input type="hidden" name="sector" value="<%=sector%>">
	<input type="hidden" name="psrEmpn" value="<%=psrEmpn%>">	
	<input type="hidden" name="LingPar" value="<%=LingPar%>">
	<input type="hidden" name="goPage" value="<%=goPage%>">

	<input type="hidden" name="dpt" value="<%=request.getParameter("dpt").trim()%>">		
	<input type="hidden" name="arv" value="<%=request.getParameter("arv").trim()%>">	
	<input type="hidden" name="purserEmpno" value="<%=psrEmpn%>">	
	<input type="hidden" name="psrname" value="<%=request.getParameter("psrname")%>">	
	<input type="hidden" name="psrsern" value="<%=request.getParameter("psrsern")%>">
	<input type="hidden" name="pur" value="<%=psrEmpn%>">	
	
</form>
<script language="javascript" type="text/javascript">
function clearForm(){
	document.getElementById('exN').className='hidden';
	document.getElementById('exY').className='hidden';
}

function chkUpdForm(){
	var chkValue= null;
	for (var i=0; i < document.form1.executeStatus.length; i++) {
	   if (document.form1.executeStatus[i].checked) {
		  chkValue = document.form1.executeStatus[i].value;
		 }
	 }
	 
	 var evValue = null;
	 for (var i=0; i < document.form1.ev.length; i++) {
	   if (document.form1.ev[i].checked) {
		  evValue = document.form1.ev[i].value;
		 }
	 }

	if(chkValue == null){
		alert("請輸入考核執行狀況");
		return false;
	}else if(chkValue=="N"){
		if(document.getElementById("esNComm").value == ""){
			alert("您點選「未執行」<%=obj.getDescription()%>,\n請於備註欄輸入原因.");
			document.getElementById("esNComm").focus();
			return false;
		}else{
			disaButton();	
			return true;
		}
	}else{
		if(evValue == null){
			alert("請輸入執行狀態");
			document.getElementById("esYComm").focus();
			return false;
		}else{
			disaButton();	
			return true;
		}
		
	}
}

function showCoi(idx,ischecked){
	if(ischecked){
		document.getElementById(idx).disabled=false;
	}else{
		document.getElementById(idx).disabled=true;
	}
}
function disaButton(){
	document.getElementById("submitForm").disabled=true;
	document.getElementById("resetForm").disabled=true;
	document.getElementById("showMsg").className="showStatus4";
}


</script>
</body>
</html>

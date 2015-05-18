<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*"%>
<%@ page import = "eg.flightcheckitem.*"%>			
<%
String checkRdSeq = null;
if(null != request.getParameter("checkRdSeq") && !"".equals(request.getParameter("checkRdSeq"))){
	checkRdSeq = request.getParameter("checkRdSeq");
}
String seqno = null;
if(null != request.getParameter("seqno") && !"".equals(request.getParameter("seqno"))){
	seqno = request.getParameter("seqno");
}
String fltd = request.getParameter("fltd");
String fltno = request.getParameter("fltno");
String sector = request.getParameter("sector");
String psrEmpn = request.getParameter("psrEmpn");
String LingPar = request.getParameter("LingPar");
String goPage = request.getParameter("goPage");

boolean status = false;
String errMsg  = "";

RetrieveCheckItem rCk = new RetrieveCheckItem(seqno);
CheckMainItemObj obj = null;

try{
	rCk.SelectData();
	obj = rCk.getChkMainItemObj();
	status = true;
}catch(Exception e){
	errMsg 	 +="ERROR:"+ e.toString();
}

CheckItemKeyValue chkValue = null;
if(fltd != null && fltno != null && sector != null && psrEmpn != null){
	chkValue = new CheckItemKeyValue();
	chkValue.setFltd(fltd);
	chkValue.setFltno(fltno);
	chkValue.setSector(sector);
	chkValue.setPsrEmpn(psrEmpn);
}

//TODO
RetrieveCheckRd rcd = new RetrieveCheckRd(seqno);
CheckRecordObj rdObj = null;
try {
	rcd.setCheckRdSeqno(checkRdSeq);
	rcd.setChkItemKey(chkValue);
	rcd.SelectData();
	rdObj = rcd.getCheckRdObj();
	status = true;
} catch (Exception e) {
	status = false;
	errMsg += e.toString();
}
		 

%>	
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="checkStyle1.css">
<link rel="stylesheet" type="text/css" href="kbd.css">
<link rel="stylesheet" type="text/css" href="loadingStatus.css">
<title>�ק�d�ָ��</title>
</head>

<body>
<%
if(!status){
%>
<div class="paddingTopBottom1 bg3 red center"><%=errMsg%></div>
<%
}else if(rdObj == null){
%>
<div class="paddingTopBottom1 bg3 red center">NO DATA FOUND!!</div>
<%

}else{
%>
<form  name="form1" method="post" onReset="clearForm()" action="updChkItem.jsp" onSubmit="return chkUpdForm()">
<fieldset style="width:70% " >
	<legend>
<span class="red"><%=obj.getDescription()%></span>
Flight Date:<span class="blue"><%=rdObj.getFltd()%></span>,
Fltno :<span class="blue"><%=rdObj.getFltno()%></span>,
Sector:<span class="blue"><%=rdObj.getSector()%></span>,
Purser:<span class="blue"><%=rdObj.getPsrEmpn()%></span><br>
</legend>


<fieldset style="width:80% " >
	<legend><input type="radio" name="executeStatus" value="Y" onClick="document.getElementById('exY').className='display';document.getElementById('exN').className='hidden';document.getElementById('esYComm').focus();" <%if(rdObj.isExecuteCheck()){out.print("checked");}%>>�w����</legend>
	<div id="exY" class="<%if(rdObj.isExecuteCheck()){out.print("show");}else{out.print("hidden");}%>">
	<li>
	 	 <input type="radio" name="ev" value="Y" onClick="document.getElementById('evN').className='hidden';" <%if(rdObj.isExecuteCheck()&& rdObj.isEvalStatus()){out.print("checked");}%>>����@�����`
	</li>
	<li>
	<input type="radio" name="ev" value="N" onClick="document.getElementById('evN').className='display';" <%if(rdObj.isExecuteCheck()&& !rdObj.isEvalStatus()){out.print("checked");}%>>���楼�F�з�
	</li>
	 
	<br><br>
	<%
	
	if(obj.getCheckDetailAL() != null){
	%>
	<div class="<%if(rdObj.isExecuteCheck()&& !rdObj.isEvalStatus()){out.print("show");}else{out.print("hidden");}%>" id="evN">
		<table border="0" cellpadding="0" cellspacing="2" width="100%" style="margin-left:2em;" class="tableStyle2">
		<tr class="bg4 bottomBorderStyle1 center rightBottomStyle1"  >
			<td width="10%" height="22">Select</td>
			<td width="10%">�O�_�B��</td>
			<td width="80%" class="left">���F�зǿﶵ</td>
		</tr>
	        <%

		for(int i=0;i<obj.getCheckDetailAL().size();i++){
			CheckDetailItemObj dObj = (CheckDetailItemObj)obj.getCheckDetailAL().get(i);
			if(dObj.isExecuteStatus() && !dObj.isEvalStatus()){
				if(rdObj.getCheckDetailAL() == null){//�L�Ӷ��A��ܪťյL�Ŀ諸�ﶵ
				
	%>
		<tr class="center<%if(i%2==1){out.print(" bg6");}%>" >
			<td><input type="checkbox" name="evItm" value="<%=dObj.getItemSeqno()%>" onClick="showCoi('coi<%=i%>',this.checked)" ></td>
			<td><input type="checkbox" name="correctItm" id="coi<%=i%>" value="<%=dObj.getItemSeqno()%>" disabled ></td>
			<td class="left"><%=dObj.getDescription()%></td>
		</tr>
	<%				
			}else{//���Ӷ����,��ܦ��Ŀ諸����
			
			boolean tempHascheckItem = false;
			boolean tempisCorrect = false;
			for(int idx=0;idx<rdObj.getCheckDetailAL().size();idx++){
				CheckRecordDetailObj detailObj = (CheckRecordDetailObj)rdObj.getCheckDetailAL().get(idx);
				

				if(detailObj.getCheckDetailSeq().equals(dObj.getItemSeqno())){
						tempHascheckItem = true;
						tempisCorrect = detailObj.isCorrect();
				}

			} //end of for(int idx=0;idx<rdObj.getCheckDetailAL().size();idx++){
	%>
		<tr class="center<%if(i%2==1){out.print(" bg6");}%>">
			<td><input type="checkbox" name="evItm" value="<%=dObj.getItemSeqno()%>" <%if(tempHascheckItem){out.print("checked");}%> onClick="showCoi('coi<%=i%>',this.checked)" ></td>
			<td><input type="checkbox" name="correctItm" id="coi<%=i%>" value="<%=dObj.getItemSeqno()%>"  <%if(!tempHascheckItem){out.print("disabled");} if(tempisCorrect){out.print(" checked");}%> ></td>
			<td class="left"><%=dObj.getDescription()%></td>
		</tr>
	<%				

			}//end of ���Ӷ����
			
			}//end of if(dObj.isExecuteStatus() && !dObj.isEvalStatus()){
			
		}
	%>
		</table>
	</div>	
	<%	
	}
	%>
	
		<div style="margin-left:2em;">
			Comments�G<br>
		<textarea name="esYComm" cols="40" rows="5" id="esYComm"><%if(rdObj.isExecuteCheck()&& rdObj.getComments()!= null){out.print(rdObj.getComments());}%></textarea><br>
		*�r�ƭ���100�Ӥ���r��200�ӭ^��r.
		</div>
	</div>
	
</fieldset>	
<fieldset style="width:80%; ">
	<legend><input type="radio" name="executeStatus" value="N" onClick="document.getElementById('exN').className='display';document.getElementById('exY').className='hidden';document.getElementById('esNComm').focus();" <%if(!rdObj.isExecuteCheck()){out.print("checked");}%>>������</legend>
<div  id="exN" class="<%if(!rdObj.isExecuteCheck()){out.print("show");}else{out.print("hidden");}%>" style="margin-left:2em;">
	Comments(<span class="red">������J��]</span>)<br>
<textarea name="esNComm" cols="40" rows="5" id="esNComm"><%if(!rdObj.isExecuteCheck()&& rdObj.getComments()!= null){out.print(rdObj.getComments());}%></textarea><br>
*�r�ƭ���100�Ӥ���r��200�ӭ^��r.

  </div>	
</fieldset>	<br>

<input type="submit" id="submitForm" value="�x�s" class="kbd">&nbsp;&nbsp;<input type="reset" value="�M��" class="kbd" id="resetForm">
<div id="showMsg" class="hidden"><img src="../../images/ajax-loader1.gif" width="15" height="15" align="absmiddle">loading.....</div>
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
	<input type="hidden" name="checkRdSeq" value="<%=checkRdSeq%>">
	
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
		alert("�п�J�Үְ��檬�p");
		return false;
	}else if(chkValue=="N"){
		if(document.getElementById("esNComm").value == ""){
			alert("�z�I��u������v<%=obj.getDescription()%>,\n�Щ�Ƶ����J��].");
			document.getElementById("esNComm").focus();
			return false;
		}else{
			disaButton();
			return true;
		}
	}else{
		if(evValue == null){
			alert("�п�J���檬�A");
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
<%
}
%>
</body>
</html>

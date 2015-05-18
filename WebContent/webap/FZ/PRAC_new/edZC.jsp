<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*"  %>
<%
String userid = (String)session.getAttribute("userid");
if(userid == null){
	response.sendRedirect("../sendredirect.jsp");
}else{
String fltd = null;
if( !"".equals(request.getParameter("fltd")) && null != request.getParameter("fltd")){
	 fltd = request.getParameter("fltd");
}

String fltno = null;
if( !"".equals(request.getParameter("fltno")) && null != request.getParameter("fltno")){
	fltno = request.getParameter("fltno");
}
String sect = null;
if( !"".equals(request.getParameter("sect")) && null != request.getParameter("sect")){
	sect = request.getParameter("sect");
}
String empno= null;
if( !"".equals(request.getParameter("empno")) && null != request.getParameter("empno")){
	empno =  request.getParameter("empno");
}
String cname = "";

boolean status = false;
String errMsg = "";

//���o�򥻸��
fzac.CrewInfo c = new fzac.CrewInfo(empno);
fzac.CrewInfoObj o = c.getCrewInfo();

if (c.isHasData()) {
	cname=o.getCname();
}


//���oZC�ҵ����ءB�ԭz
fz.pracP.zc.EvaluationType evalType = new fz.pracP.zc.EvaluationType();
ArrayList evalTypeAL = evalType.getDataAL();
status = true;

//���oZC�ҵ����
fz.pracP.zc.ZoneChiefEvalData zcData = new fz.pracP.zc.ZoneChiefEvalData(fltd,fltno,sect,empno);
ArrayList evalScoreDataAL = null;
try{
	zcData.SelectData();
	evalScoreDataAL = zcData.getDataAL();
	status = true;
	
}catch(Exception e){
	status = false;
	errMsg = e.toString();
}



%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Zone Chief Evaluation Score</title>
<link rel="stylesheet" type="text/css" href="../errStyle.css">
<link rel="stylesheet" type="text/css" href="ZC/style.css">
<link rel="stylesheet" type="text/css" href="../kbd.css">
<script type="text/javascript" src="alttxt.js"></script> 
<script language="javascript" type="text/javascript">
function disableButton(){
		document.getElementById("exitButton").disabled=1;
		document.getElementById("resetButton").disabled=1;
		if(document.getElementById("delButton") != null){
			document.getElementById("delButton").disabled=1;
		}
		document.getElementById("SaveButton").disabled=1;			
}
function goDel(){
	if(confirm("�T�w�n�R��������ơH")){
		document.form1.action="delZC.jsp";
		document.form1.submit();
		disableButton();
		return true;
	}else{
		return false;
	}	
}

function compose_note(colname)
{
	var c_value = "";
	for (var i=0; i < eval("document.form1.str_"+colname+".length"); i++)
	{
		if (eval("document.form1.str_"+colname+"[i].checked"))
		{
			c_value = c_value+" "+ eval("document.form1.str_"+colname+"[i].value") ;
		}
	}

	document.getElementById("comm"+colname).value = c_value ;
}



</script>
</head>

<body class="center">
<%
if(!status)
{
%>
<div class="errStyle1"><%=errMsg%></div>
<%
}
else
{
	if(evalTypeAL != null){
%>
<center>
<div class="blue"><span style="font-size:large;font-weight:bold; " >Purser Evaluation Score</span><br>
<%=fltd%> <%=fltno%> / <%=sect%> <%=empno%> <%=cname%></div>
<form name="form1" action="updZC.jsp" method="post" onSubmit="return checkForm()">
<table cellpadding="0" cellspacing="2" class="tableBorder1">
	<tr class="tableInner3">
    <td >Evaluation Item</td>
    <td >Score<br>(1~10)</td>
	<td >Comments</td>	
	<td>Template</td>	
	</tr>
<%
for(int i=0;i<evalTypeAL.size();i++)
{
	fz.pracP.zc.EvaluationTypeObj evalObj = (fz.pracP.zc.EvaluationTypeObj)evalTypeAL.get(i);
	String classType = "";
	if(i%2 == 0)
	{
		classType ="";
	}
	else
	{
		classType = "class='tableInner2'";
	}
%>
<tr <%=classType%>>
	<td valign="top"><%=evalObj.getScoreDesc()%>
	<img title="<%=evalObj.getDescDetail()%>"  src="../images/qa2.gif" style="vertical-align:text-top;" width="22" height="22">	
	<!--<a href="#" onmouseover="writetxt('<%=evalObj.getDescDetail()%>')" onmouseout="writetxt(0)"><img src="../images/qa2.gif" width="22" height="22" border="0"></a>-->
	</td>
	<!--<div id="navtxt" class="navtext" style="position:absolute; color:red; top:100px; left:100px; visibility:hidden">
	</div>-->
	<td valign="top">
	<select name="score<%=evalObj.getScoreType()%>" id="score<%=evalObj.getScoreType()%>" >
	<option value="">�п��</option>
	<%
	for( int sel=10;sel>0;sel--)
	{
		out.print("<option value=\""+sel+"\">"+sel+"</option>");
	}
	%>
	</select>
	</td>
	<td class="left" valign="top">	
	 <textarea name="comm<%=evalObj.getScoreType()%>" id="comm<%=evalObj.getScoreType()%>" cols="30" rows="3"></textarea>
	</td>
	<td class="left">
<%
	if("��ɲαs".equals(evalObj.getScoreDesc()))		
	{
%>
		<input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="���´�O�P�M�_�O" onclick="compose_note('<%=evalObj.getScoreType()%>')">���´�O�P�M�_�O&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="���q��կ�O��" onclick="compose_note('<%=evalObj.getScoreType()%>')">���q��կ�O��<br>
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="�P�_�O�P�M�_�O����" onclick="compose_note('<%=evalObj.getScoreType()%>')">�P�_�O�P�M�_�O����&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="�ʥF���q�ޥ�" onclick="compose_note('<%=evalObj.getScoreType()%>')">�ʥF���q�ޥ�<br>
<%	
	}

	if("�ζ��X�@".equals(evalObj.getScoreDesc()))		
	{
%>
		<input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="���ΤH���귽" onclick="compose_note('<%=evalObj.getScoreType()%>')">���ΤH���귽&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="�ζ��u�@�Z�Ĩ�" onclick="compose_note('<%=evalObj.getScoreType()%>')">�ζ��u�@�Z�Ĩ�<br>
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="�ۧڷN�ѱj�B�L�k���ΤH���귽" onclick="compose_note('<%=evalObj.getScoreType()%>')">�ۧڷN�ѱj�B�L�k���ΤH���귽<br>
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="�ζ��u�@�Z�Įt" onclick="compose_note('<%=evalObj.getScoreType()%>')">�ζ��u�@�Z�Įt<br>
<%	
	}

	if("�@�~�{��".equals(evalObj.getScoreDesc()))		
	{
%>
		<input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="��ȿ��w���@�~¾��" onclick="compose_note('<%=evalObj.getScoreType()%>')">��ȿ��w���@�~¾��&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="����A�ȵ{��" onclick="compose_note('<%=evalObj.getScoreType()%>')">����A�ȵ{��<br>
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="�P�_�O�P�M�_�O����" onclick="compose_note('<%=evalObj.getScoreType()%>')">�P�_�O�P�M�_�O����&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="�ʥF���q�ޥ�" onclick="compose_note('<%=evalObj.getScoreType()%>')">�ʥF���q�ޥ�<br>
<%	
	}
%>	


<%
	if("�U�ȾɦV".equals(evalObj.getScoreDesc()))		
	{
%>
		<input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="��x���ȫȸ�T" onclick="compose_note('<%=evalObj.getScoreType()%>')">��x���ȫȸ�T&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="�ມ���U�ȴ���" onclick="compose_note('<%=evalObj.getScoreType()%>')">�ມ���U�ȴ���<br>
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="�L�k���T�x���ȫȸ�T" onclick="compose_note('<%=evalObj.getScoreType()%>')">�L�k���T�x���ȫȸ�T&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="�ʥF�A�ȼ���" onclick="compose_note('<%=evalObj.getScoreType()%>')">�ʥF�A�ȼ���<br>
<%	
	}
%>	


<%
	if("�y����O".equals(evalObj.getScoreDesc()))		
	{
%>
		<input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="�~�y��F��O��" onclick="compose_note('<%=evalObj.getScoreType()%>')">�~�y��F��O��&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="��F��O�ΡB�x�����q�ޥ�" onclick="compose_note('<%=evalObj.getScoreType()%>')">��F��O�ΡB�x�����q�ޥ�<br>
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="�~�y��F��O�z" onclick="compose_note('<%=evalObj.getScoreType()%>')">�~�y��F��O�z&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="��F�B���ﶷ�[�j" onclick="compose_note('<%=evalObj.getScoreType()%>')">��F�B���ﶷ�[�j<br>
<%	
	}
%>	

<%
	if("���P�Ҧ�".equals(evalObj.getScoreDesc()))		
	{
%>
		<input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="�����޲z��" onclick="compose_note('<%=evalObj.getScoreType()%>')">�����޲z��&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="��P�z��  ����˩M�O" onclick="compose_note('<%=evalObj.getScoreType()%>')">��P�z�ߡB��˩M�O<br>
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="�����޲z���[�j" onclick="compose_note('<%=evalObj.getScoreType()%>')">�����޲z���[�j&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="�N�H�B�����ĤJ�H�s" onclick="compose_note('<%=evalObj.getScoreType()%>')">�N�H�B�����ĤJ�H�s<br>
<%	
	}
%>	

<%
	if("�M���B�z".equals(evalObj.getScoreDesc()))		
	{
%>
		<input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="�q�e���ܡB�ƥ�x����O��" onclick="compose_note('<%=evalObj.getScoreType()%>')">�q�e���ܡB�ƥ�x����O��&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="ĵı�ʰ�" onclick="compose_note('<%=evalObj.getScoreType()%>')">ĵı�ʰ�<br>
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="�W�áB�ʥF���ܯ�O" onclick="compose_note('<%=evalObj.getScoreType()%>')">�W�áB�ʥF���ܯ�O&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="����ĵı����" onclick="compose_note('<%=evalObj.getScoreType()%>')">����ĵı����<br>
<%	
	}
%>	

<%
	if("�~��欰".equals(evalObj.getScoreDesc()))		
	{
%>
		<input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="�A�����" onclick="compose_note('<%=evalObj.getScoreType()%>')">�A�����&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="���e�ˤ�  ��������§" onclick="compose_note('<%=evalObj.getScoreType()%>')">���e�ˤ��B������§&nbsp;&nbsp;
		<input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="�ʥF���e" onclick="compose_note('<%=evalObj.getScoreType()%>')">�ʥF���e<br>
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="�A�����Ż��e�W�w" onclick="compose_note('<%=evalObj.getScoreType()%>')">�A�����Ż��e�W�w&nbsp;&nbsp;	    
		<input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="�A�״����B���ߤ���" onclick="compose_note('<%=evalObj.getScoreType()%>')">�A�״����B���ߤ���<br>
<%	
	}

	if("�H��S��".equals(evalObj.getScoreDesc()))		
	{
%>
		<input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="���[�i��" onclick="compose_note('<%=evalObj.getScoreType()%>')">���[�i��&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="�{�u�t�d" onclick="compose_note('<%=evalObj.getScoreType()%>')">�{�u�t�d&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="�������" onclick="compose_note('<%=evalObj.getScoreType()%>')">�������<br>
		<input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="��[��B�i�h���`" onclick="compose_note('<%=evalObj.getScoreType()%>')">��[��B�i�h���`&nbsp;&nbsp;
		<input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="�L�k�H��" onclick="compose_note('<%=evalObj.getScoreType()%>')">�L�k�H��&nbsp;&nbsp;<br>
<%	
	}

	if("�M�~���i".equals(evalObj.getScoreDesc()))		
	{
%>
		<input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="�󳡧@�~��X��O��" onclick="compose_note('<%=evalObj.getScoreType()%>')">�󳡧@�~��X��O��&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="�㭸��w����������" onclick="compose_note('<%=evalObj.getScoreType()%>')">�㭸��w����������<br>
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="��ŪA�M�~����" onclick="compose_note('<%=evalObj.getScoreType()%>')">��ŪA�M�~����&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="�A�ȧޥ��¼�" onclick="compose_note('<%=evalObj.getScoreType()%>')">�A�ȧޥ��¼�<br>
		<input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="�󳡧@�~��X��O���z" onclick="compose_note('<%=evalObj.getScoreType()%>')">�󳡧@�~��X��O���z&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="�ʥF����w������" onclick="compose_note('<%=evalObj.getScoreType()%>')">�ʥF����w������<br>
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="�ŪA�M�~���Ѥ���" onclick="compose_note('<%=evalObj.getScoreType()%>')">�ŪA�M�~���Ѥ���&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="�A�ȧޥ�����" onclick="compose_note('<%=evalObj.getScoreType()%>')">�A�ȧޥ�����<br>

<%	
	}
%>	

	</td>
</tr>
<%
}
%>	
<tr>
  <td colspan="4">
<input type="submit" name="SaveButton" id="SaveButton" value="Save (�x�s)" class="kbd">
&nbsp;&nbsp;&nbsp;
<%
if(evalScoreDataAL != null){
	fz.pracP.zc.ZoneChiefEvalObj obj = (fz.pracP.zc.ZoneChiefEvalObj)evalScoreDataAL.get(0);
	
%>
<input name="resetButton" type="button" class="kbd" id="resetButton" onClick="initData()" value="Reset (�M�����g)">
&nbsp;&nbsp;&nbsp;
<input name="delButton" type="button" class="kbd" id="delButton"  onClick="return goDel()" value="Delete (�R��)">  
&nbsp;&nbsp;&nbsp;
<input type="hidden" name="seqno" value="<%=obj.getSeqno()%>">
<%
}else{
%>
<input type="reset" class="kbd" id="resetButton" value="Reset (�M�����g)">
&nbsp;&nbsp;&nbsp;
<input type="hidden" name="seqno" value="">
<%
}
%>
<input name="exitButton" type="button" class="kbd" id="exitButton"  onClick="javascript:self.close()" value="Exit (���})">  

<input type="hidden" name="fltd" value="<%=fltd%>">
<input type="hidden" name="fltno" value="<%=fltno%>">
<input type="hidden" name="sect" value="<%=sect%>">
<input type="hidden" name="empno" value="<%=empno%>">

  </td>
</tr>
<tr class="r">
  <td colspan="4" class="left">*�U���ҵ����Ƨ��ݶ�g�A���o�ť�.<br>
    *�U�ҵ����ظԲӻ����A�i�N�ƹ�����<img src="../images/qa2.gif"  width="22" height="22" style="vertical-align:text-top; " > �ϥ��˵�.</td>
</tr>

</table>
</form>
<script language="javascript" type="text/javascript">
	function checkForm(){
<%
for(int i=0;i<evalTypeAL.size();i++){
	fz.pracP.zc.EvaluationTypeObj evalJSObj = (fz.pracP.zc.EvaluationTypeObj)evalTypeAL.get(i);
		
%>
	if(document.getElementById("score<%=evalJSObj.getScoreType()%>").value ==""){
		alert("�п�� [<%=evalJSObj.getScoreDesc()%>] ���ؤ�����");
		document.getElementById("score<%=evalJSObj.getScoreType()%>").focus();
		return false;
	}
<%
}
%>			
	disableButton();

	return true;
	}
</script>
<%
if(evalScoreDataAL != null){
%>
<script language="javascript" type="text/javascript">
	function initData(){
	<%
		for(int index = 0;index < evalScoreDataAL.size(); index ++){
			fz.pracP.zc.ZoneChiefEvalObj obj = (fz.pracP.zc.ZoneChiefEvalObj)evalScoreDataAL.get(index);
			
	%>
			document.getElementById("score<%=obj.getScoreType()%>").value = "<%=Integer.toString(obj.getScore())%>";
			document.getElementById("score<%=obj.getScoreType()%>")[document.getElementById("score<%=obj.getScoreType()%>").selectedIndex].style.color = "#FF0000";
			document.getElementById("comm<%=obj.getScoreType()%>").value = "<%=obj.getComm()%>";

	<%	
		}
	%>										
	}
	initData();
</script>

<%
} //end of has Eval Data and initial it.

	}//end of evalTypeAL != null
	else{
%>
<div class="errStyle1">��Ʈw�s�u���ѡA�еy��A��.</div>
<%	
	}
}//end of status = true;
%>
</center>
</body>
</html>
<%
}
%>
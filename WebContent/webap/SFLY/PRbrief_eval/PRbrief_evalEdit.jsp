<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.util.*,eg.prfe.*" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("../logout.jsp");
}

String empno	= request.getParameter("empno");
String sdate	= request.getParameter("sdate");
String purname  = "";
String pursern  = "";
String time_hh  = "";
String time_mi  = "";
String newname = "";
String newuser = "";

//�Q�d�֤H
empno = eg.GetEmpno.getEmpno(empno);
eg.EGInfo egi = new eg.EGInfo(empno);
eg.EgInfoObj purobj = egi.getEGInfoObj(empno); 
if(purobj !=null)
{
	empno   = purobj.getEmpn();
	pursern = purobj.getSern();
	purname = purobj.getCname();
}
//�d�֤H
eg.HRInfo hr = new eg.HRInfo(userid);
newname = hr.getCname(userid);
newuser = userid;

PRBriefEval prbe = new PRBriefEval();
prbe.getPRBriefEval(sdate,sdate,empno);
ArrayList objAL = new ArrayList();
objAL = prbe.getObjAL();
PRBriefEvalObj obj = new PRBriefEvalObj();
if(objAL.size()>0)
{
	obj = (PRBriefEvalObj) objAL.get(0);  
	fz.splitString p = new fz.splitString();
    String[] str = p.doSplit(obj.getBrief_time(),":");
    if(str.length >=2)
	{
		time_hh = str[0];
		time_mi = str[1];
	}		
	newname = obj.getNewname();
	newuser = obj.getNewuser();
}
%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>�ȿ��g�z/�ưȪ�����²����{</title>
<link href="../style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="alttxt.js"></script> 
<script LANGUAGE="JavaScript">
function chkRequest()
{
	var brief_hh = eval("document.form1.brief_hh.value");
	var brief_mi = eval("document.form1.brief_mi.value");
	var fltno = eval("document.form1.fltno.value");
	var chk1 = eval("document.form1.chk1.value");
	var chk2 = eval("document.form1.chk2.value");
	var chk3 = eval("document.form1.chk3.value");
	var chk4 = eval("document.form1.chk4.value");
	var chk5 = eval("document.form1.chk5.value");
	
	 if(brief_hh =="")
	 {
		alert("�п�J����ɶ�!!");
		document.form1.brief_hh.focus();
		return false;
	 }
	 else if(brief_mi =="")
	 {
		alert("�п�J����ɶ�!!");
		document.form1.brief_mi.focus();
		return false;
	 }
	 else if(fltno =="")
	 {
		alert("�п�J���ȯZ��!!");
		document.form1.fltno.focus();
		return false;
	 }
	 else if(chk1 == "" | chk1 == null | parseInt(chk1) >20 | parseInt(chk1) <0  )
	 {
		alert("���ƻݤ��� 0~20!!");
		document.form1.chk1.focus();
		return false;
	 }
	 else if(chk2 == "" | chk2 == null |parseInt(chk2) >20 | parseInt(chk2) <0  )
	 {
		alert("���ƻݤ��� 0~20!!");
		document.form1.chk2.focus();
		return false;
	 }
	 else if(chk3 == "" | chk3 == null | parseInt(chk3) >20 | parseInt(chk3) <0  )
	 {
		alert("���ƻݤ��� 0~20!!");
		document.form1.chk3.focus();
		return false;
	 }
	 else if(chk4 == "" | chk4 == null | parseInt(chk4) >20 | parseInt(chk4) <0  )
	 {
		alert("���ƻݤ��� 0~20!!");
		document.form1.chk4.focus();
		return false;
	 }
	 else if(chk5 == "" | chk5 == null | parseInt(chk5) >20 | parseInt(chk5) <0  )
	 {
		alert("���ƻݤ��� 0~20!!");
		document.form1.chk5.focus();
		return false;
	 }
	 else
	 {
		document.form1.Submit.disabled=1;
		return true;
	 }
}
</script>
<style type="text/css">
<!--
.style3 {color: #000000}
.style4 {
	font-size: 12px;
	font-weight: bold;
}
.navtext 
{ 
width:200px; 
font-size:8pt; 
border: 1px solid #fff; 
background-color:#FFCCFF;
color:#39c; 
} 
-->
</style>

</head>

<body>
<form name="form1" method="post" action="insPRBE.jsp"  Onsubmit = " return chkRequest();">
<input name="empno" type="hidden" value="<%=empno%>">
<input name="sdate" type="hidden" value="<%=sdate%>">
<table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0">
  <tr>
    <td>
      <div align="center"><span class="txttitletop">�ȿ��g�z/�ưȪ�����²����{���q </span></div>
    </td>
  </tr>
</table>
<table width="90%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr class="txtblue">
	  	<td width="20%" align="center" class="tablehead3"><strong>���Ȥ��</strong></div></td>
		<td width="20%"><div align="center" class="tablehead3"><strong>����ɶ�</strong></div></td>
    	<td width="20%"><div align="center" class="tablehead3"><strong>���ȯZ��</strong></div></td>
    	<td width="20%" align="center" class="tablehead3"><strong>�ȿ��g�z/�ưȪ�</strong></div></td>
    	<td width="20%" align="center" class="tablehead3"><strong>�d�֤H</strong></div></td>
  	</tr> 
	<tr class="txtblue">
	  	<td width="20%" align="center"><%=sdate%></td>
	  	<td width="20%" align="center" ><input name="brief_hh" id="brief_hh" type="text" value="<%=time_hh%>"  size="2" maxlength="2">:<input name="brief_mi" id="brief_mi" type="text" value="<%=time_mi%>"  size="2" maxlength="2"></td>
		<td width="20%" align="center" ><input name="fltno" id="fltno" type="text" value="<%=obj.getFltno()%>"  size="5" maxlength="5"></td>
		<td width="20%" align="center"><%=empno%>/<%=pursern%>/<%=purname%></td>
		<td width="20%" align="center"><%=newname%></td>
  	</tr> 
</table>
<table width="90%" border="1" align="center" cellpadding="1" cellspacing="1" class="fortable">
  	<tr>
	   <td align="center" class="tablehead3"><a href="#" onmouseover="writetxt('1.�H���x���O�_�o�y<br>2.²���ɶ��O�_�B�αo�y<br>3.��_���ĿE�y�{���h��<br>4.��_���ĳгy�{����^')" onmouseout="writetxt(0)"><span class="tablehead3"><strong>�{������<br>�x����O</strong></span></a></td>
		<div id="navtxt" class="navtext" style="position:absolute; top:-100px; left:10px; visibility:hidden"></div>
   	   <td align="center" class="tablehead3"><a href="#" onmouseover="writetxt('1.�O�_��ư���ӯ�q���Ƥ�Safety&Service����<br>2.�O�_�F�ѧY�ɳ̷s���i�å��T�ǹF<br>3.�O�_�ŹF��������w�P�����A�Ȥ��ŹF�ƶ�<br>4.���w���ݬO�_�x�����I-Check knowledge�קKreteach<br>')" onmouseout="writetxt(0)"><span class="tablehead3"><strong>�M�~����<br>�B�ί�O</strong></span></a></td>
   	   <td align="center" class="tablehead3"><a href="#" onmouseover="writetxt('1.�P�խ��������ߪ��T��<br>2.��гy�X�z�������Y')" onmouseout="writetxt(0)"><span class="tablehead3"><strong>�H�����Y<br>�{����O</strong></span></a></td>
       <td align="center" class="tablehead3"><a href="#" onmouseover="writetxt('1.�O�_�ϥξA��y��<br>2.�O�_��ⴤ�n�I�A�����c�ʻ���<br>3.��F�O�_�M���B�n�D���T')" onmouseout="writetxt(0)"><span class="tablehead3"><strong>�f�y��F<br>���q��O</strong></span></a></td>
   	   <td align="center" class="tablehead3"><a href="#" onmouseover="writetxt('1.�O�_�T�����²�����n����<br>a.General-Check & Inform<br>-����<br>-�A�˻��e<br>-�ӤH�˳ơq��q���B�����r<br>-�խ����СB���Ȥ��t<br>-�ȫȸ�T�q�pmvc�ήȫȹw���r<br>b.A/C General<br>-�Q�ξ��ا�v���A�����I����<br>�ΥHQ&A�覡�߰ݬ����խ�<br>c.Flt Safety Issue<br>  -�H�@��@Q&A�覡�i��A�߰�<br>���w�ž�ĳ�D��ETS��릳��<br>A/C�BGeneral Part�BSafety�����e<br>�߰ݥD�D�HProcedure������ʬ���<br>d.��Z�A�ȭ��I����<br>-�pCI-065�`�N�s��ʶ��ƴ��ѡA<br>�H�K�ȫȳ��s���Z<br>-CIQ�����W�w<br>-�ⴣ����B�z�B�����A�Ȩ��D�b <br> �šB�קK�u�@�ˮ`<br>e.�y���������\<br>-�p��E�y�P��<br>-�ζ��X�@�A�귽�θ�T����<br>-�ۧڴ��\<br>2.�O�_�������T���u�@����<br>3.�O�_�F��²���w���ĪG<br>4.�O�_����O�ﵽ�{���ʥ�')" onmouseout="writetxt(0)"><span class="tablehead3"><strong>����²��<br>�޲z��O</strong></span></a></td>
    </tr>

	 <tr>
       <td align="center" valign="middle"><input name="chk1" id="chk1" type="text" value="<%=obj.getChk1_score()%>"  size="2" maxlength="2"></td>
      <td align="center" valign="middle"><input name="chk2" id="chk2" type="text" value="<%=obj.getChk2_score()%>"  size="2" maxlength="2"></td>
	  <td align="center" valign="middle"><input name="chk3" id="chk3" type="text" value="<%=obj.getChk3_score()%>"  size="2" maxlength="2"></td>
	  <td align="center" valign="middle"><input name="chk4" id="chk4" type="text" value="<%=obj.getChk4_score()%>"  size="2" maxlength="2"></td>
	  <td align="center" valign="middle"><input name="chk5" id="chk5" type="text" value="<%=obj.getChk5_score()%>"  size="2" maxlength="2"></td>
  	</tr>
</table>
<table width="90%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr class="txtblue">
	  	<td width="25%" align="center" class="tablehead3">General Comment</td>
	  	<td width="75%" align="center"><textarea name="comm" id="comm" cols= "50" rows = "10"><%=obj.getComm()%></textarea></td>
  	</tr> 
</table>
<%
if(purname == null | "".equals(purname))
{
%>
<p class = "txtred" align="center">�нT�{�Q�d�֤H���O�_���T!!</p>
<%
}
%>

<%
String ifallowupdate = "disabled";
if(userid.equals(newuser))
{
	ifallowupdate = "";
}
%>
<table width="90%"  border="0" align="center"> 
	<tr><td align= "center"><br><input name="Submit" type="Submit" value=" SUBMIT " <%=ifallowupdate%>></td></tr>
</table>
</form>
</body>
</html>
<%
session.setAttribute("objAL", objAL);
%>

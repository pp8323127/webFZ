<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="realSwap/realSwap.css">
<title>�������ZMenu</title>
<script type="text/javascript" src="../js/color.js"></script>
<script type="text/javascript">
function loadPage(w1,w2){
		parent.topFrame.location.href=w1;
		parent.mainFrame.location.href=w2;
}
</script>
<style type="text/css">
td{
text-align:left;
padding-left:1.1em;}
</style>
</head>

<body onLoad="stripe('t2');">

<p class="r">&nbsp;</p>
<table width="58%" border="0" align="center"   cellspacing="1" class="tableBorder1" id="t2">
  <tr class="tableh5">
    <td colspan="2"><p align="center">KHH ���Z�޲z�\��</p></td>
  </tr>
  <tr class="tableInner3">
    <td><p>�޲z�\��</p></td>
    <td>����</td>
  </tr>
  <tr>
    <td ><a href="#"  onClick='loadPage("blank.htm","adm/admMembers.jsp")'><span class="r">�ӽг�޲z�H���]�w</span></a></td>
    <td><span class="r">�]�w KHH ���Z�޲z�H��</span></td>
  </tr>
  <tr>
    <td width="44%"><a  href="#" onClick='loadPage("adm/confquery.jsp","blank.htm")'>�ӽг�d��</a></td>
    <td width="56%">�d�� KHH �w�B�z���ӽг�. </td>
  </tr>
  <tr>
    <td><a href="#"  onClick='loadPage("adm/formquery.htm","blank.htm")' >�ӽг�B�z</a></td>
    <td>�B�z KHH �����Z�ӽг�.</td>
  </tr>
  <tr>
    <td><a href="#"  onClick='loadPage("blank.htm","adm/max.jsp")'>�]�w���z�ƶq</a></td>
    <td>�]�w KHH Base�խ����̤j���Z�ƶq. </td>
  </tr>
  <tr>
    <td><a href="#"  onClick='loadPage("adm/chgSwapFromQuery.jsp","adm/chgSwapFromMenu.htm")'>��s�ӽг檬�A</a></td>
    <td>��s KHH ���Z�ӽг檬�A.</td>
  </tr>
  <tr>
    <td><a href="#"  onClick='loadPage("blank.htm","adm/comm.jsp")'>�]�w�f�ַN��</a></td>
    <td>�]�w KHH ���Z�B�z�f�ַN��.</td>
  </tr>
  <tr>
    <td><a href="#" onClick='loadPage("blank.htm","adm/setdate.jsp")'>�]�w�����z��</a></td>
    <td>�]�w KHH ���Z�����z���.</td>
  </tr>
  <tr>
    <td><a href="#" onClick='loadPage("blank.htm","adm/crewcomm.jsp")'>�]�w�խ��ӽЪ���</a></td>
    <td>�]�w KHH ���Z�խ��ӽЪ���.</td>
  </tr>
  <tr>
    <td><a href="#"  onClick='loadPage("blank.htm","adm/edHotNews.jsp")'>�s��̷s����</a></td>
    <td>�]�w KHH �խ��n�J�ɩҨ����̷s����.</td>
  </tr>
  <tr>
    <td><a href="#"  onClick='loadPage("blank.htm","realSwap/realSwapAdm.jsp")'>���鴫�Z�O��</a> </td>
    <td>�]�w KHH ���鴫�Z�O��.</td>
  </tr>
  <tr>
     <!--<td><a href="#"  onClick='loadPage("blank.htm","SMSAC/SMSQuery.jsp")'>²�T�q��</a></td>-->
    <td><a href="#"  onClick='loadPage("blank.htm","../SMSAC/SMSQuery.jsp")'>²�T�q��</a></td>>
    <td>���� KHH  departure ��²�T���X��</td>
  </tr>
</table>
<p>&nbsp;</p>
<!-- 		  <img src="../img2/Search.gif" width="16" height="16" >&nbsp;<a href="#"  onClick='javascript:loadPage("transfer/flyHrQuery.jsp","blank.htm")'><div class="n"id="n11">���ɬd��</div></a><br>
		  <img src="../img2/Table 1.gif" width="16" height="16" >&nbsp;<a href="#"  onClick='javascript:loadPage("transfer/putquery.jsp","blank.htm")'><div class="n" id="n12">�����Z��</div></a><br>
		  <img src="../img2/Browse 3.gif" width="16" height="16" >&nbsp;<a href="#" onClick='javascript:loadPage("transfer/psquery.jsp","blank.htm")'><div class="n"id="n13">�d�ߥi���Z��</div></a><br>
		  <img src="../img2/View Doc.gif" width="16" height="16">&nbsp;<a href="#"  onClick='javascript:loadPage("blank.htm","transfer/showbook.jsp")'><div class="n"id="n14">�ڪ���Z��T</div></a><br>
		  <img src="../img2/Write.gif" width="16" height="16" >&nbsp;<a href="step0.jsp" target="_self"><div class="n"id="n15">��ӽг�</div></a><br>
		  <img src="../img2/rdoc.gif" width="16" height="16">&nbsp;<a href="#"  onClick='javascript:loadPage("swap3ac/swapRdQuery.jsp","swap3ac/swapRd.jsp")'><div class="n"id="n16">�ӽг�O��</div></a><br>
		  <img src="../img2/download.gif" width="16" height="16" >&nbsp;<a href="#"  onClick='javascript:loadPage("admin/uploadQuery.jsp","blank.htm")'><div class="n"id="n17">�U����Z��T</div></a><br>
 -->
</body>
</html>

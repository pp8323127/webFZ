<%@page contentType="text/html; charset=big5" language="java" %>
<%

String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 

String auth = (String)session.getAttribute("auth");

%>

<!--  ��ܶ�g���i�A�Ϊ̬d�߾��v���   -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>�y�������i �\����</title>
<link href="style2.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
function load(w1,w2){
		parent.topFrame.location.href=w1;
		parent.mainFrame.location.href=w2;

}
function newVersion(){

	top.leftFrame.location = "../fscreenAC.jsp";
	top.mainFrame.location='blank.htm';
	top.topFrame.location = 'blank.htm';
	

}
function versionTran(){
	alert('�]������Z��N�H�s�t�ΥX��A\n������H�ᤧ�y�������i�Шϥηs���\���J!!');
/*
	var nowDate = new Date();
	var newDate = new Date(2006,04,01,00, 00, 00);

	alert(newDate);
	if (nowDate < newDate){
		oldVersion();
	}
*/	
}

</script>

</head>

<body onLoad="versionTran()">
<p>&nbsp;</p>
<table width="70%"  border="0" align="center" cellpadding="2" cellspacing="0"> 
<tr >
    <td colspan="2" style="background-color:#99CCFF;font-family:Verdana;font-size:10pt;color:#000000;padding:2pt; "> ���������� �`�N�ƶ� ����������      <br>
    �]������Z��N�H�s�t�ΥX��A������H�ᤧ�y�������i��
      <input type="button" name="newversion" class="e4" onClick="newVersion()" value="�ϥηs���\��"  >
    ��J.</td>
  </tr>  


  <tr>
    <td colspan="2" class="txtxred">
      <strong>�`�N�ƶ�</strong>:���y�������iú��t�Ω�2005/01/14�����W�u�ҥΡA�ñ����������iú��A�Фſ�J���ո�ơA�줽�ǤH���N�}�l�²z�z�Ұe�X�����i
	  !! �p��������D�Ь��Ť@�դH���A���� !!
    </td>
  </tr>
  <tr>
    <td colspan="2">
      <p class="purple_txt"><strong>�п�ܥ\��G</strong></p>
    </td>
  </tr>
  <tr>
    <td colspan="2">
      <p class="txtblue">1.<a href="fltquery.jsp"  target="topFrame"><u>���g���i( Edit Report )</u></a></p>
      <p class="txtblue">2.<a href="ReportQuery.jsp" target="topFrame"><u>�d��ú����i�O�� �]History Query�^</u></a></p>
	  <%
	  //�L�@�n / 625296 ����z / 628997
	  //mark by cs55 2005/09/12
	  //if("628997".equals(sGetUsr) || "625296".equals(sGetUsr)|| "640790".equals(sGetUsr) || "638716".equals(sGetUsr))
	  //{
	  %>
	 <p class="txtblue">3.<a href="#" onClick="load('purspeech/monQuery.jsp','blank.htm')" class="txtblue"><u>�y�����o����</u></a></p>	  
	 <%
	  //}
 //}
%>
	  <%
	  //629019 : �_�� 628997 : ����z
	  if("640073".equals(sGetUsr) || "638716".equals(sGetUsr) ||"O".equals(auth) || "629019".equals(sGetUsr) || "628997".equals(sGetUsr)){
	  %>
      <p class="txtblue">4.<a href="ReportQuery_office.jsp" target="topFrame"><u>View Report(Authorized Personnel Only) </u></a></p>
	  <%
	  }
	  %>
    </td>
  </tr>
  <tr>
    <td height="36" colspan="2"><span style="background-color:#003366;font-family:Verdana;font-size:10pt;color:#FFFFFF;padding:2pt ">      [new!!!]�ϥλ����G</span></td>
  </tr>
  <tr>
    <td width="4%" height="92">&nbsp;</td>
    <td width="96%"><a href="guide/01.htm" target="_self">1.�y�������i�ާ@�ϥλ���</a><br>
      <br>
      <a href="guide/QA.htm">2.�`�����D�ѵ�</a><br>
      <br>
      <a href="guide/bot/index.htm" target="_self"><span style="font-family:Verdana;font-size:10pt;color:#FF0000;font-weight:bold">3.Crew Boarding On Time�ϥλ���</span> </a></td>
  </tr>
</table>



<%
 if("640790".equals(sGetUsr))
 {
%>
      <p class="txtblue">****<a href="#" onClick="load('purspeech2/monQuery.jsp','blank.htm')" class="txtblue"><u>�y�����o����</u></a></p>
<%
 }
%>

</body>
</html>

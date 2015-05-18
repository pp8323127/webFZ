<%@page contentType="text/html; charset=big5" language="java" %>
<%

String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 

String auth = (String)session.getAttribute("auth");

%>

<!--  選擇填寫報告，或者查詢歷史資料   -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>座艙長報告 功能選擇</title>
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
	alert('因五月份班表將以新系統出表，\n五月份以後之座艙長報告請使用新版功能輸入!!');
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
    <td colspan="2" style="background-color:#99CCFF;font-family:Verdana;font-size:10pt;color:#000000;padding:2pt; "> ◎◎◎◎◎ 注意事項 ◎◎◎◎◎      <br>
    因五月份班表將以新系統出表，五月份以後之座艙長報告請
      <input type="button" name="newversion" class="e4" onClick="newVersion()" value="使用新版功能"  >
    輸入.</td>
  </tr>  


  <tr>
    <td colspan="2" class="txtxred">
      <strong>注意事項</strong>:此座艙長報告繳交系統於2005/01/14正式上線啟用，並接受正式報告繳交，請勿輸入測試資料，辦公室人員將開始授理您所送出的報告
	  !! 如有任何問題請洽空一組人員，謝謝 !!
    </td>
  </tr>
  <tr>
    <td colspan="2">
      <p class="purple_txt"><strong>請選擇功能：</strong></p>
    </td>
  </tr>
  <tr>
    <td colspan="2">
      <p class="txtblue">1.<a href="fltquery.jsp"  target="topFrame"><u>撰寫報告( Edit Report )</u></a></p>
      <p class="txtblue">2.<a href="ReportQuery.jsp" target="topFrame"><u>查詢繳交報告記錄 （History Query）</u></a></p>
	  <%
	  //汪駿聲 / 625296 潘文琮 / 628997
	  //mark by cs55 2005/09/12
	  //if("628997".equals(sGetUsr) || "625296".equals(sGetUsr)|| "640790".equals(sGetUsr) || "638716".equals(sGetUsr))
	  //{
	  %>
	 <p class="txtblue">3.<a href="#" onClick="load('purspeech/monQuery.jsp','blank.htm')" class="txtblue"><u>座艙長發言單</u></a></p>	  
	 <%
	  //}
 //}
%>
	  <%
	  //629019 : 于堯 628997 : 潘文琮
	  if("640073".equals(sGetUsr) || "638716".equals(sGetUsr) ||"O".equals(auth) || "629019".equals(sGetUsr) || "628997".equals(sGetUsr)){
	  %>
      <p class="txtblue">4.<a href="ReportQuery_office.jsp" target="topFrame"><u>View Report(Authorized Personnel Only) </u></a></p>
	  <%
	  }
	  %>
    </td>
  </tr>
  <tr>
    <td height="36" colspan="2"><span style="background-color:#003366;font-family:Verdana;font-size:10pt;color:#FFFFFF;padding:2pt ">      [new!!!]使用說明：</span></td>
  </tr>
  <tr>
    <td width="4%" height="92">&nbsp;</td>
    <td width="96%"><a href="guide/01.htm" target="_self">1.座艙長報告操作使用說明</a><br>
      <br>
      <a href="guide/QA.htm">2.常見問題解答</a><br>
      <br>
      <a href="guide/bot/index.htm" target="_self"><span style="font-family:Verdana;font-size:10pt;color:#FF0000;font-weight:bold">3.Crew Boarding On Time使用說明</span> </a></td>
  </tr>
</table>



<%
 if("640790".equals(sGetUsr))
 {
%>
      <p class="txtblue">****<a href="#" onClick="load('purspeech2/monQuery.jsp','blank.htm')" class="txtblue"><u>座艙長發言單</u></a></p>
<%
 }
%>

</body>
</html>

<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="realSwap/realSwap.css">
<title>高雄換班Menu</title>
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
    <td colspan="2"><p align="center">KHH 換班管理功能</p></td>
  </tr>
  <tr class="tableInner3">
    <td><p>管理功能</p></td>
    <td>說明</td>
  </tr>
  <tr>
    <td ><a href="#"  onClick='loadPage("blank.htm","adm/admMembers.jsp")'><span class="r">申請單管理人員設定</span></a></td>
    <td><span class="r">設定 KHH 換班管理人員</span></td>
  </tr>
  <tr>
    <td width="44%"><a  href="#" onClick='loadPage("adm/confquery.jsp","blank.htm")'>申請單查詢</a></td>
    <td width="56%">查詢 KHH 已處理之申請單. </td>
  </tr>
  <tr>
    <td><a href="#"  onClick='loadPage("adm/formquery.htm","blank.htm")' >申請單處理</a></td>
    <td>處理 KHH 之換班申請單.</td>
  </tr>
  <tr>
    <td><a href="#"  onClick='loadPage("blank.htm","adm/max.jsp")'>設定受理數量</a></td>
    <td>設定 KHH Base組員單日最大換班數量. </td>
  </tr>
  <tr>
    <td><a href="#"  onClick='loadPage("adm/chgSwapFromQuery.jsp","adm/chgSwapFromMenu.htm")'>更新申請單狀態</a></td>
    <td>更新 KHH 換班申請單狀態.</td>
  </tr>
  <tr>
    <td><a href="#"  onClick='loadPage("blank.htm","adm/comm.jsp")'>設定審核意見</a></td>
    <td>設定 KHH 換班處理審核意見.</td>
  </tr>
  <tr>
    <td><a href="#" onClick='loadPage("blank.htm","adm/setdate.jsp")'>設定不受理日</a></td>
    <td>設定 KHH 換班不受理日期.</td>
  </tr>
  <tr>
    <td><a href="#" onClick='loadPage("blank.htm","adm/crewcomm.jsp")'>設定組員申請附註</a></td>
    <td>設定 KHH 換班組員申請附註.</td>
  </tr>
  <tr>
    <td><a href="#"  onClick='loadPage("blank.htm","adm/edHotNews.jsp")'>編輯最新消息</a></td>
    <td>設定 KHH 組員登入時所見之最新消息.</td>
  </tr>
  <tr>
    <td><a href="#"  onClick='loadPage("blank.htm","realSwap/realSwapAdm.jsp")'>實體換班記錄</a> </td>
    <td>設定 KHH 實體換班記錄.</td>
  </tr>
  <tr>
     <!--<td><a href="#"  onClick='loadPage("blank.htm","SMSAC/SMSQuery.jsp")'>簡訊通報</a></td>-->
    <td><a href="#"  onClick='loadPage("blank.htm","../SMSAC/SMSQuery.jsp")'>簡訊通報</a></td>>
    <td>產生 KHH  departure 之簡訊號碼檔</td>
  </tr>
</table>
<p>&nbsp;</p>
<!-- 		  <img src="../img2/Search.gif" width="16" height="16" >&nbsp;<a href="#"  onClick='javascript:loadPage("transfer/flyHrQuery.jsp","blank.htm")'><div class="n"id="n11">飛時查詢</div></a><br>
		  <img src="../img2/Table 1.gif" width="16" height="16" >&nbsp;<a href="#"  onClick='javascript:loadPage("transfer/putquery.jsp","blank.htm")'><div class="n" id="n12">欲換班表</div></a><br>
		  <img src="../img2/Browse 3.gif" width="16" height="16" >&nbsp;<a href="#" onClick='javascript:loadPage("transfer/psquery.jsp","blank.htm")'><div class="n"id="n13">查詢可換班表</div></a><br>
		  <img src="../img2/View Doc.gif" width="16" height="16">&nbsp;<a href="#"  onClick='javascript:loadPage("blank.htm","transfer/showbook.jsp")'><div class="n"id="n14">我的丟班資訊</div></a><br>
		  <img src="../img2/Write.gif" width="16" height="16" >&nbsp;<a href="step0.jsp" target="_self"><div class="n"id="n15">填申請單</div></a><br>
		  <img src="../img2/rdoc.gif" width="16" height="16">&nbsp;<a href="#"  onClick='javascript:loadPage("swap3ac/swapRdQuery.jsp","swap3ac/swapRd.jsp")'><div class="n"id="n16">申請單記錄</div></a><br>
		  <img src="../img2/download.gif" width="16" height="16" >&nbsp;<a href="#"  onClick='javascript:loadPage("admin/uploadQuery.jsp","blank.htm")'><div class="n"id="n17">下載選班資訊</div></a><br>
 -->
</body>
</html>

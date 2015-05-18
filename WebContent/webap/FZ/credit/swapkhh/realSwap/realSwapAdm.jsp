<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>KHH實體換班記錄管理</title>
<style type="text/css">
<!--
.selected {		background-color:#FFCC99;
		color:#000000;
		font-weight: bold;
}

-->
</style>
<link href="realSwap.css" rel="stylesheet" type="text/css">

<script language="javascript" type="text/javascript" src="../js/color.js"></script>
</head>

<body onload="stripe('t1','#FFFFFF','#DAE9F8');" >


    <table width="41%"  border="0" align="center" cellpadding="0" cellspacing="0" id="t1"  class="tableBorder1">
      <tr>
        <td height="30"  class="tableInner3">KHH實體換班紀錄</td>
      </tr>
      <tr height="30">
        <td height="30" >
          <div align="left">1.<a href="rcomm.jsp">自訂手工換班理由</a></div>
        </td>
      </tr>
      <tr  height="30">
        <td height="30" >
          <div align="left">2.<a href="addRealSwap.jsp">實體換班紀錄新增</a></div>
        </td>
      </tr>
      <tr  height="30">
        <td height="30" >
          <div align="left">3.<a href="rSwapRdQuery.jsp" target="topFrame">實體換班記錄查詢/ 維護</a>
          </div>
        </td>
      </tr>
</table>
          
</body>
</html>

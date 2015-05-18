<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,java.util.*,java.text.*,df.overTime.ac.*" %>
<%
String userid = (String) session.getAttribute("cs55.usr") ; //get user id if already login
if (userid == null) 
{		
	response.sendRedirect("../logout.jsp");
} 

String idx = request.getParameter("idx");
String bgColor="#CCCCCC";
ArrayList objAL = (ArrayList) session.getAttribute("objAL");
String adjmins   = request.getParameter("adjmins");
String adjmins2   = request.getParameter("adjmins2");
OverTimeObj obj = (OverTimeObj)objAL.get(Integer.parseInt(idx));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Update SB or Irregular case </title>
<link href="style.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style2 {
	font-family: "Courier New", Courier, mono;
	font-size: 12pt;
}
.style8 {color: #000000}
.style10 {font-size: 14px; color: #000000; font-weight: bold; }
-->
</style>
<script language="javascript" type="text/javascript">
function checkField()
{
	var v1 = document.form1.adjmins_upd.value;
	var v2 = document.form1.adjmins2_upd.value;

	if(v1 == ""){
		alert("請輸入延長工時(分鐘) 14~16小時");
		document.form1.adjmins_upd.focus();
		return false;
	}
	
	if(v2 == "")
	{
		alert("請輸入延長工時(分鐘) 16小時以上");
		document.form1.adjmins2_upd.focus();
		return false;
	}

	document.form1.Submit.disabled=1
	return true;
}	
</script>
</head>

<body>
<div align="center">
  <table width="90%" border="0" align="center">
    <tr>
      <td class="txtblue">待命及特殊情形工時調整 </td>
    </tr>
  </table>
</div>

<p align="center"></p>
<div align="center">
<form name="form1" method="post" action="updAdjt2_ac.jsp" onsubmit="return checkField()">
<input type="hidden" name="adjmins" value="<%=adjmins%>">
<input type="hidden" name="adjmins2" value="<%=adjmins2%>">
  <table width="90%" border="1" align="center" class="tablebody2">
    <tr bgcolor="#9CCFFF"  class="txtblue">
      <td width="12%" class="table_head">
        <div align="center" class="txtblue">組員員工號</div>
      </td>
      <td width="40%" class="table_head"><div align="center" class="txtblue">延長工時(分鐘)<br>
      越洋線14~16小時<br>區域線12~16小時</span></div></td>
      <td width="33%" class="table_head">
        <div align="center" class="txtblue">延長工時(分鐘)<br>
      16小時以上</div>
      </td>
    </tr>
    <tr>
      <td>
        <div align="center"><%=obj.getEmpno()%></div>
      </td>
      <td>
        <div align="left">
          <input type="text" name="adjmins_upd" maxlength="5" size="5" value="<%=obj.getOvermins_sbir()%>">
		  </div>
	  </td>
      <td>
        <div align="left">
          <input type="text" name="adjmins2_upd" maxlength="5" size="5" value="<%=obj.getOvermins2_sbir()%>">
		</div>
	  </td>
    </tr>
    <tr>
      <td colspan="4">
        <div align="center">
          <input name="Submit" type="submit" class="button1" value="Update">&nbsp;&nbsp;
          <input type="button" name="closew" class="button2" value="Close Window" onclick="window.close()">
		  <input type="hidden" name="idx" value="<%=idx%>">
        </div>
      </td>
    </tr>
</table>
</form>
</div>
</body>
</html>
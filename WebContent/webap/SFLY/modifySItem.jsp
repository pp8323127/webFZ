<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.util.*" %>
<%

String sql = null;
String bgColor=null;
String kin;
String itemno;
String itemdesc;

kin = request.getParameter("kin").trim();
itemno = request.getParameter("itemno").trim();
itemdesc = request.getParameter("itemdesc").trim();
itemno="dd";
itemdesc="uu";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Modify SubItem</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script src="js/subWindow.js" type="text/javascript"></script>
<script language=javascript>
function checkinput(){
	 if(document.form1.itemno.value ==""){
	 	alert("Please input SubItemNo!!\n請輸入子項目編號!!");
		document.form1.itemno.focus();
		return false;
	 }
	 else if(document.form1.itemdesc.value ==""){
	 	alert("Please input SubItem!!\n請輸入子項目描述!!");
	 	document.form1.itemdesc.focus();
		return false;
	 }
	 else{
		return true;
	 }

}
</script>

</head>

<body onLoad="javascript:document.form1.itemno.focus()">
<form name="form1" method="post" class="t1" action="updSItem.jsp?status=upd" onSubmit="return checkinput()">
<input type="hidden" name="kin" value="<%=kin%>">
<table width="80%" border="0" align="center">
  <tr>
    <td>
      <div align="right">
        <input name="add" type="submit"  class="button2" id="add" value="Insert" >&nbsp;&nbsp;&nbsp; 
		<input type="reset" name="reset" value="Reset" class="button2">&nbsp;&nbsp;&nbsp; 
		<input type="button" name="close" value="Close window" class="button2" onclick="window.close()">
      </div>
    </td>
  </tr>
</table>
<p>
<table width="80%" border="0" align="center" class="tablebody">
  <tr>
    <td width="15%" class="table_head">
      <div align="center">SubItemNo</div>
    </td>
    <td width="70%" class="table_head">
      <div align="center">SubItem</div>
    </td>
    <td width="15%" class="table_head">
      <div align="center">Kin</div>
    </td>
  </tr>
  <tr>
    <td >
      <input name="itemno" type="text"  size="10" maxlength="10" value=<%=itemno%>>
    </td>
    <td>
      <input name="itemdesc" type="text"  size="60" maxlength="100" value=<%=itemdesc%>>
    </td>
    <td>
      <%=kin%>
    </td>
  </tr>
</table>
</form>
</body>
</html>

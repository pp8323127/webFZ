<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.util.*" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("logout.jsp");
} 

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
ConnDB cn = new ConnDB();

String sql = null;
String bgColor=null;
String kin = null;
String itemno = null;
String itemdesc = null;

kin = request.getParameter("kin");
Driver dbDriver = null;

try{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);

sql = "select itemdsc from egtstfi where itemno = '" + kin + "'";
rs = stmt.executeQuery(sql);
while(rs.next())
{
	itemdesc = rs.getString("itemdsc");
}

}catch(Exception e){
	out.print(e.toString());
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Insert SubItem</title>
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

<style type="text/css">
<!--
.style2 {color: #0000FF; font-size: 12px; font-family: "Courier New", Courier, mono;}
.style3 {color: #0000FF}
.style5 {color: #FF0000}
-->
</style>
</head>

<body onLoad="javascript:document.form1.itemno.focus()">
<form name="form1" method="post" class="t1" action="updSItem.jsp?status=ins" onSubmit="return checkinput()">
<input type="hidden" name="kin" value="<%=kin%>">
<table width="80%" border="0" align="center">
  <tr>
    <td class="style2">Item :&nbsp;&nbsp;<%=itemdesc%></td>
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
    <td width="25%" class="table_head">
      <div align="center">SubItemNo</div>
    </td>
    <td width="75%" class="table_head">
      <div align="center">SubItem</div>
    </td>
  </tr>
  <tr>
    <td >
      <p>
        <input name="itemno" type="text"  size="10" maxlength="5">
        </p>
      </td>
    <td><div align="center"><input name="itemdesc" type="text"  size="60" maxlength="100">
        </div></td>
  </tr>
  <tr>
  	<td width="25%">Example: <span class="style3">5.7</span></td>
  	<td width='75%'>&nbsp;&nbsp;Max words of description:<span class="style5">100</span></td>
  </tr>
</table>
</form>
</body>
</html>

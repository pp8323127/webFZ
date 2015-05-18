<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.util.*" %>
<%

String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("logout.jsp");
} 

String sql = null;
String bgColor=null;
String kin = null;
String itemno = null;
String tempDsc = null;
String itemDsc = null;


Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
ConnDB cn = new ConnDB();

kin = request.getParameter("kin");
itemno = request.getParameter("itemno");
Driver dbDriver = null;

try{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);

sql = "select itemno, itemdsc, kin, sflag,selectitem from egtstsi where itemno = '"+itemno+"'";

//out.print(sql);
rs = stmt.executeQuery(sql);
while(rs.next())
{
	tempDsc = rs.getString("selectitem");
	itemDsc = rs.getString("itemdsc");
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
<title>Modify Template Item</title>
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
.style3 {color: #0000FF}
.style5 {color: #FF0000}
.style7 {color: #000000; font-weight: bold; }
.style8 {color: #000000}
-->
-->
</style>
</head>

<body onLoad="javascript:document.form1.itemno.focus()">
<form name="form1" method="post" class="t1" action="updTItem.jsp?status=upd&keyno=<%=itemno%>">
<input type="hidden" name="kin" value="<%=kin%>">
<table width="80%" border="0" align="center" class="table_no_border">
  <tr>
    <td class="txtblue style3" colspan="2">&nbsp;Item :&nbsp;&nbsp;<%=itemDsc%></td>
  </tr>
  <tr>
    <td>
      <div align="right">
        <input name="add" type="submit"  class="button2" id="add" value="Modify" >&nbsp;&nbsp;&nbsp; 
		<input type="reset" name="reset" value="Reset" class="button2">&nbsp;&nbsp;&nbsp; 
		<input type="button" name="close" value="Close window" class="button2" onclick="window.close()">
      </div>
    </td>
  </tr>
</table>
<table width="80%" border="0" align="center" class="tablebody">
  <tr bgcolor="#9CCFFF" class="txtblue">
    <td width="30%" bgcolor="#9CCFFF" class="table_head">
      <div align="center" class="style7">Item No</div>
    </td>
    <td width="60%" bgcolor="#9CCFFF" class="table_head">
      <div align="center" class="style7">Template Item</div>
    </td>

  </tr>
  <%if(null!=tempDsc){
		String[] temp = tempDsc.split("\\*");
		for(int i=0;i<temp.length;i++){  
  %>
  <tr class="txtblue">
    <td >
      <%=itemno%>
    </td>
    <td>
      <input name="tempdsc" type="text" value="<%=temp[i]%>"  size="60" maxlength="100">
    </td> 
  </tr>
  <%
  		}
  }
   %>
  <tr class="txtblue">
    <td >
      <%=itemno%>
    </td>
    <td>
      <input name="tempdsc" type="text" value=""  size="60" maxlength="100">
    </td> 
  </tr>
   
  <tr>
  	<td width="25%" class="txtblue">&nbsp;<span class="style8"></td>
  	<td width="75%" class="txtblue">&nbsp;<span class="style8">Description max length:</span><span class="style5"> 100 English words</span></td>
  </tr>
</table>

</form>
</body>
</html>

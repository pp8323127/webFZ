<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,ci.db.*,java.util.*" %>
<%
//modify Remark Attribute Value
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("logout.jsp");
} 

String reqItemno = request.getParameter("itemNo");
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;

ConnDB cn = new ConnDB();

String itemNo  = null;
String itemDsc = null;
Driver dbDriver = null;

try{

cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);

sql = "select itemno, itemdsc from egtstrm where itemno='"+reqItemno+"'" ;
rs = stmt.executeQuery(sql);
while(rs.next()){
	itemNo  = rs.getString("itemno");
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
<title>Edit Remark Attribute Value Description</title>
<link href ="style.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript">
function checkField(){
	var v = document.form1.itemDsc.value;
	if(v == ""){
		alert("請輸入備註欄屬性值內容(Remark Attribute Value Description)\nPLease Remark Attribute Value Description");
		document.form1.itemDsc.focus();
		return false;
	}else{
		return true;
	}
}	
</script>

</head>

<body onLoad="document.form1.itemdsc.focus();">
<form name="form1" method="post" action="updRmkItemDsc.jsp" onsubmit="return checkField()">
  <table width="65%"  border="0" align="center"  class="tablebody">
    <tr class="tablehead">
      <td width="20%"><div align="center">ItemNo</div></td>
      <td width="82%"><div align="center">Remak Attribute Value Description </div></td>
    </tr>
    
	<tr class="txtblue">
      <td><%=itemNo%></td>
      <td><div align="left">
          <input name="itemDsc" type="text" id="itemDsc" value="<%=itemDsc%>" size="55" maxlength="50">
      </div>
	  </td>
    </tr>
	
    <tr>
      <td colspan="3">
        <div align="center">
          <input name="Submit" type="submit" class="button1" value="Update">&nbsp;&nbsp;
          <input type="reset" name="reset" value="Reset">&nbsp;&nbsp;
          <input type="button" name="closew" value="Close Window" onclick="window.close()">
		  <input type="hidden" name="itemNo" value="<%=itemNo%>">
        </div>
      </td>
    </tr>
  </table>
</form>

</body>
</html>

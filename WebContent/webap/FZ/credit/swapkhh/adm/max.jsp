<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="java.sql.*,ci.db.*"%>
<%
//砞﹚虫ら程瞶计秖
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login

if (sGetUsr == null) 
{		
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
}

Connection conn = null;
Driver dbDriver = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
ci.db.ConnDB cn = new ci.db.ConnDB();
int maxForm  = 0;

String errMsg = "";
boolean status = false;


try{

cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

pstmt = conn.prepareStatement("select maxform from fztcmaxf where station='KHH'");
rs = pstmt.executeQuery(); 
while(rs.next()){
	maxForm = rs.getInt("maxform");
}
rs.close();
pstmt.close();
conn.close();
status = true;
} catch (Exception e) {
	errMsg = e.toString();
}finally {
	if (rs != null)
		try {
			rs.close();
		} catch (SQLException e) {}
	if (pstmt != null)
		try {
			pstmt.close();
		} catch (SQLException e) {}
	if (conn != null)
		try {
			conn.close();
		} catch (SQLException e) {}
}

%>

<html>
<head>
<title>砞﹚虫ら瞶计秖</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="../realSwap/realSwap.css" >

<link href="../style/validator.css" rel="stylesheet" type="text/css">
<script src="../js/validator.js"></script>
</head>
<body onload="document.form1.maxcount.focus();">
<form action="updMax.jsp" method="post" name="form1" id="form1" onSubmit="return v.exec()">
<table width="44%"  border="0" align="center" cellpadding="0" cellspacing="1" class="tableBorder1">
  <tr class="tableInner3">
    <td colspan="2" >砞﹚KHH虫ら瞶计秖</td>
  </tr>
  <tr class="tableInner2">
    <td width="37%"  id="maxText">程</td>
	
    <td width="63%">

	<input name="maxcount" type="text" value="<%=maxForm%>" id="maxcount" size="5" maxlength="3">
	
	</td>
  </tr>
  <tr>
    <td colspan="2"  ><input name="Submit" type="submit" id="Submit"  value="э"></td>
  </tr>
</table>

</form>
</body>
</html>

<script language="javascript" type="text/javascript">

var a_fields = {
	'maxcount' : {
		'l': '程',  // label
		'r': true,    // required
		'f': 'integer',  // format (see below)
		't': 'maxText'// id of the element to highlight if input not validated	
		
	}		
	
}
o_config = {
	'to_disable' : ['Submit'],
	'alert' : 1
}
var v = new validator('form1', a_fields, o_config);
</script>
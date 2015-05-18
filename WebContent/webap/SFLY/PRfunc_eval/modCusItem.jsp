<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,ci.db.*" %>
<%
//modify First Item
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("../logout.jsp");
} 

String reqItemno = request.getParameter("itemno");
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;

ConnDB cn = new ConnDB();

String itemno  = null;
String itemdsc = null;
String flag    = null;
Driver dbDriver = null;

try{

cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
sql = "select * from egtprcus where itemno='"+reqItemno+"'" ;
rs = stmt.executeQuery(sql);
while(rs.next()){
	itemno	= rs.getString("itemno");
	itemdsc	= rs.getString("itemdsc");
	flag    = rs.getString("flag");
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
<link href="../style.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript">
function checkField(){
	var v2 = document.form1.itemdsc.value;
	if(v2 == ""){
		alert("請輸入項目內容(Item Description)\nPLease insert Item Description");
		document.form1.itemdsc.focus();
		return false;
	
	}else{
		return true;
	}

}	
</script>

<title>Edit First Item</title>
<style type="text/css">
<!--
.style2 {color: #000000; font-weight: bold; }
-->
</style>
</head>

<!--<body onLoad="document.form1.itemdsc.focus();document.form1.flag.value = '<%=flag%>';">   Betty wrote -->
<body onLoad="document.form1.itemdsc.focus();">
<form name="form1" method="post" action="updCusItem.jsp?itemno=<%=itemno%>" onsubmit="return checkField()">
  <table width="65%"  border="0" align="center"  class="tablebody">
    <tr bgcolor="#9CCFFF" class="txtblue">
      <td>
        <div align="center" class="style2">ItemNo</div>
      </td>
      <td>
        <div align="center" class="style2">Item Description </div>
      </td>
	  <td>
	  	<div align="center" class="style2">Show Item
      </div></td>
    </tr>
    <tr>
      <td>
        <div align="center">
          <div align="center" class="style2"><%=itemno%></div>
        </div>
      </td>
      <td>
        <div align="left">
          <input type="text" name="itemdsc" maxlength="100" size="40" value="<%=itemdsc%>">
      </div></td>
	  <td>
	    <div align="center">  
		<select name="flag" >
            <%
	 	if( flag.equals("Y")){
		%>
			<option value="<%=flag%>" selected>Yes</option>
            <option value="N">No</option>
            <%
		}else{
		%>
       		<option value="<%=flag%>" selected>No</option>
            <option value="Y">Yes</option>
            <%
		}
		%>
          </select> 
	  	<!--  <select name="flag" id="flag" >
	  	    <option value="<%=flag%>" <%=((flag.toString().equals(flag))?"SELECTED":"")%>>Yes</option>
	  	    <option value="<%=flag%>" <%=((flag.toString().equals(flag))?"SELECTED":"")%>>No</option>          
		  </select>-->		   
		</div>
		</td>
    </tr>
    <tr>
      <td colspan="3">
        <div align="center">
          <input name="Submit" type="submit" class="button1" value="Update">&nbsp;&nbsp;
          <input type="reset" name="reset" value="Reset">&nbsp;&nbsp;
          <input type="button" name="closew" value="Close Window" onclick="window.close()">
		  <input type="hidden" name="oItemno" value="<%=reqItemno%>">
        </div>
      </td>
    </tr>
  </table>
</form>

</body>
</html>

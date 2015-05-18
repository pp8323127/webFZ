<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.util.*" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("../logout.jsp");
} 

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
ConnDB cn = new ConnDB();

String sql = null;
String bgColor=null;
String kin = null;
String itemno= null;
String tempDsc= "";
String sflag = "";
int rowCount = 0;

Driver dbDriver = null;

try{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
String[] tempArray = request.getParameterValues("tempdsc");
if(null != tempArray){
	for(int i=0;i<tempArray.length;i++){
		if(null!= tempArray[i] &&!"".equals(tempArray[i].toString())){
			tempDsc += tempArray[i]+"/";			
		}
	}		
}
	
	itemno = request.getParameter("itemno").trim();

	sql = "update egtprcus set selectitem = '"+tempDsc+"' where itemno = '"+itemno+"'";
	stmt.executeUpdate(sql); 	
%>
	<script language=javascript>
	alert("Update completed!!\n更新成功!!");
	//close_self("insSItem.jsp");
	window.opener.location.reload();
	this.window.close();
	</script>
<%

		
}
catch(Exception e)
{
	out.print(e.toString());
}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Insert TempItem </title>
<link href="../style.css" rel="stylesheet" type="text/css">
<script src="../js/close.js" type="text/javascript"></script>
</head>
<body>
</body>
</html>

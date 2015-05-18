<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,ci.db.*,java.net.URLEncoder"%>
<%
//update First Item
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("../logout.jsp");
} 
String itemno 	= request.getParameter("itemno");//
String itemdsc  =  request.getParameter("itemdsc");//修改後的itemdsc
String flag     =  request.getParameter("flag");//修改後的flag

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;
ConnDB cn = new ConnDB();
int countUpdate =0;
String forwardPage = "";
Driver dbDriver = null;

try{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);


//update
sql = "update egtprcus set itemdsc='"+itemdsc+"',flag='"+flag+"' "+
	"where itemno='"+itemno+"'" ;
			
	countUpdate = stmt.executeUpdate(sql);
%>
	<script language=javascript>
	alert("Update completed!!\n更新成功!!");
	//close_self("insSItem.jsp");
	window.opener.location.reload();
	this.window.close();
	</script>
<%

}catch(Exception e)
{
	out.print(e.toString());
}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}


//response.sendRedirect(forwardPage);
out.println(forwardPage);


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Modify CusItem </title>
<link href="../style.css" rel="stylesheet" type="text/css">
<script src="../js/close.js" type="text/javascript"></script>
</head>
<body>
</body>
</html>
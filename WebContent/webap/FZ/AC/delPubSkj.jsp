<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*" errorPage="" %>
<%

String ym =  request.getParameter("ym");
String userid = (String)session.getAttribute("userid");

Connection conn = null;
Driver dbDriver = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
ConnDB cn = new ConnDB();
String errMsg = "";
boolean status = false;
int rowCount = 0;
try{

cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);



String sql = "delete fztspub where yyyy||'/'||mm=?";
pstmt = conn.prepareStatement(sql);
pstmt.setString(1,ym);

rowCount = pstmt.executeUpdate();
if(rowCount != 0 ){
	status = true;
}else{
	errMsg = "�R������";
}
}catch (SQLException e){
	 errMsg = e.toString();
}
catch (Exception e){
	 errMsg = e.toString();
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}

if(status){
response.sendRedirect("pubSkj.jsp");
}else{
out.print(errMsg);
}
%>

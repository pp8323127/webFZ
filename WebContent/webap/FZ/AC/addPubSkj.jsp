<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*" errorPage="" %>
<%
String y = request.getParameter("y");
String m  = request.getParameter("m");
String fdate = request.getParameter("fdate");
String hh =  request.getParameter("hh");
String mm =  request.getParameter("mm");
String upper_limit =  request.getParameter("upper_limit");
String lower_limit =  request.getParameter("lower_limit");

String userid = (String)session.getAttribute("userid");

Connection conn = null;
Driver dbDriver = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
ConnDB cn = new ConnDB();
String errMsg = "";
boolean status = false;

try{

cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);



String sql = "insert into fztspub (yyyy,mm,pubdate,upduser,upper_limit,lower_limit) values (?,?,to_date('"+fdate+" "+hh+mm+"','yyyy/mm/dd hh24mi'),?,to_number(?),to_number(?))";
pstmt = conn.prepareStatement(sql);
pstmt.setString(1,y);
pstmt.setString(2,m);
pstmt.setString(3,userid);
pstmt.setString(4,upper_limit);
pstmt.setString(5,lower_limit);


pstmt.executeUpdate();
status = true;

}catch (SQLException e){
	errMsg = "新增失敗，請檢查是否重複設定!!<BR>";
	 errMsg += e.toString();
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

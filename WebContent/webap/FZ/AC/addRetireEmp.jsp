<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*" errorPage="" %>
<%
String empno = request.getParameter("empno");
String rtryear = request.getParameter("rtyear");
String userid = (String)session.getAttribute("userid");

Connection conn = null;
Driver dbDriver = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
ConnDB cn = new ConnDB();
String errMsg = "";
boolean status = false;
if(empno == null | "".equals(empno) |  rtryear == null | "".equals(rtryear)){
	errMsg = "請輸入屆退人員之員工號,及退休年份";
}else{
	try{

	cn.setORP3FZUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	
	
	
	String sql = "insert into fztretire values(?,?,?,sysdate)";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,empno);
	pstmt.setString(2,rtryear);
	pstmt.setString(3,userid);
	
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

}
if(status){
response.sendRedirect("retireEmp.jsp");
}else{
out.print(errMsg);
}
%>

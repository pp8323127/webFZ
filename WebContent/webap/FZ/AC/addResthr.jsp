<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*" errorPage="" %>
<%
String condi_col = request.getParameter("condi_col");
String condi_val  = request.getParameter("condi_val");
String edate = request.getParameter("edate");
String resthr =  request.getParameter("resthr");
String userid = (String)session.getAttribute("userid");

Connection conn = null;
Driver dbDriver = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
ConnDB cn = new ConnDB();
String errMsg = "";
boolean status = false;

try
{
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

String sql = "insert into fztresthr(seq,condi_col,condi_val,resthr,expdt,base,newuser,newdate) values ((SELECT Nvl(Max(seq),0)+1 FROM fztresthr),?,?,?,to_date(?,'yyyy/mm/dd'),'TPE',?,sysdate)";
pstmt = conn.prepareStatement(sql);
pstmt.setString(1,condi_col);
pstmt.setString(2,condi_val);
pstmt.setString(3,resthr);
pstmt.setString(4,edate);
pstmt.setString(5,userid);
pstmt.executeUpdate();
status = true;

}
catch (SQLException e)
{
	errMsg = "�s�W���ѡA���ˬd�O�_���Ƴ]�w!!<BR>";
	errMsg += e.toString();
}
catch (Exception e)
{
	 errMsg = e.toString();
}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}

if(status)
{
	response.sendRedirect("resthrset.jsp");
}
else
{
	out.print(errMsg);
}
%>

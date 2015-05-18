<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="ci.db.*,java.sql.*"%>
<%
String sno = request.getParameter("sno");
String empno = request.getParameter("empno");
String userid = (String) session.getAttribute("userid") ; //get user id if already login
if (userid == null) 
{		
	response.sendRedirect("../../tsa/sendredirect.jsp");
} 
else
{

String sql = null;
String returnstr = "Y";
Connection conn = null;
PreparedStatement pstmt = null;

try
{
	ConnectionHelper ch = new ConnectionHelper();
	conn = ch.getConnection();	
//sql="update egtcrdt set reason = '"+reason+"', comments='"+comments+"', edate=to_date('"+edate+"','yyyy/mm/dd'), used_ind='"+used_ind+"', intention = '"+intention+"'  where sno = '"+sno+"'";
//out.print(sql + "<br>");
	sql = " delete from egtcrdt where sno = ? ";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,sno);
	pstmt.executeUpdate(); 	
%>
		<script language=javascript>
		alert("Delete completed!!");	
		window.opener.location.href="creditList.jsp?empno=<%=empno%>";	
		void(window.open('','_parent',''));
		self.close();
		</script>
<%
}
catch (Exception e)
{
	  out.println("Error : " + e.toString() + sql);
	  returnstr = e.toString();
}
finally
{
	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
}
%>

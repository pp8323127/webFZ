<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="ci.db.*,java.sql.*, java.util.*"%>
<%
String sector = request.getParameter("sector");
String userid = (String) session.getAttribute("cs55.usr") ; //get user id if already login

if (userid == null) 
{		
	response.sendRedirect("../logout.jsp");
} 

String returnstr = "Y";
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;	
String sql = null;
try{
		ConnectionHelper ch = new ConnectionHelper();
        conn = ch.getConnection();
        stmt = conn.createStatement();

		int qcount = 0;
		sql = " select count(*) c from dfttrns where sector ='"+sector+"' "; 
        rs = stmt.executeQuery(sql);
		if(rs.next())
		{
			qcount = rs.getInt("c");
		}

		if(qcount <=0)
		{
			sql = "insert into dfttrns (sector, upduser, upddt) values ('"+sector+"','"+userid+"',sysdate)";
			stmt.executeUpdate(sql);
			returnstr = "資料已新增!!";		
		}
		else
		{
			 returnstr = "資料已存在!!";		
		}
%>
	<script language=javascript>
	alert("<%=returnstr%>!!");	
	window.opener.location.href="transferfltlist.jsp";	
	self.close();
	</script>
<%
}
catch (Exception e)
{
	  out.println("Error : " + e.toString() + sql);
%>
	<script language=javascript>
	alert("<%=e.toString()%>!!");		
	window.opener.location.href="transferfltlist.jsp";	
	self.close();
	</script>
<%
}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>

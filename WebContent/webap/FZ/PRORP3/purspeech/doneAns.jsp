<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.util.*" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login
String formno = (String) request.getParameter("formno") ; 
String editor = (String) request.getParameter("editor") ; 
String alertstr = formno.substring(0,4)+"/"+formno.substring(4,6)+"討論主題發言單已送出!!";

if (userid == null) 
{		
	response.sendRedirect("../sendredirect.jsp");
} 

/*
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
ConnDB cn = new ConnDB();
*/

Driver dbDriver = null;
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
ConnDB cn = new ConnDB();
String sql = null;

try{
		/*
		cn.setORT1EG();
		java.lang.Class.forName(cn.getDriver());
		conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());
		stmt = conn.createStatement();
		*/
		cn.setORP3EGUserCP();
		dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
		conn = dbDriver.connect(cn.getConnURL(), null);
		stmt = conn.createStatement();

		sql = "insert into egtpspo (formno,empno,closed,senddate) values ('"+formno+"','"+editor+"','N',sysdate)";

		//out.print(sql+"<br>");
		stmt.executeUpdate(sql); 	
%>
		<script language=javascript>
		alert("<%=alertstr%>!!");
		location.replace("sphForm.jsp?fyy=<%=formno.substring(0,4)%>&fmm=<%=formno.substring(4,6)%>");
		self.close();
		</script>
<%
}
catch(Exception e)
{
	out.print(e.toString());
}
finally
{
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>

<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*,ci.db.*"%>
<%
//新增Firtst Item
String userid = (String) session.getAttribute("cs55.usr") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("../logout.jsp");
} 

String type  = request.getParameter("type_del");
String fdate = request.getParameter("fdate_del");
String empno   = request.getParameter("empno_del");
String fltno   = request.getParameter("fltno_del");
String sec   = request.getParameter("sec_del");
String del = "N";


int hasItemCount = 0;
String sql = null;
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
Driver dbDriver = null;
ConnDB cn = new ConnDB();

try
{
	cn.setDFUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	stmt = conn.createStatement();

%>
	<SCRIPT LANGUAGE="JavaScript">
	flag = confirm("Are you sure to delete the record?");
	if (flag == false) 
	{
		window.history.back();
	}
	else
	{
<%
	sql = "delete from dftadjt where type ='"+ type+"' and fdate = '"+ fdate+"' and fltno = '"+fltno+"' and sect = '"+sec+"' and empno = '"+ empno+"'";			

	stmt.executeUpdate(sql);
%>
	alert("Delete completed!!\n刪除成功!!");
	location.replace("editAdjt.jsp?fym=<%=fdate.substring(0,7)%>");
	}
	</SCRIPT>
<%
}
catch(Exception e)
{
	out.print(e.toString());
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}					
%>

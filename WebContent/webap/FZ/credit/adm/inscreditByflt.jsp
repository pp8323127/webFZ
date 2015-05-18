<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="ci.db.*,java.sql.*"%>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login
String fltd = (String) request.getParameter("fltd") ; 
String fltno = (String) request.getParameter("fltno") ; 
String sect = (String) request.getParameter("sect") ; 
String reason = (String) request.getParameter("reason");
String edate = (String) request.getParameter("edate");
String comments = (String) request.getParameter("comments");
String[] chkItem = request.getParameterValues("chkItem");

for(int i=0;i<chkItem.length;i++)
{
	//out.println(chkItem[i]+"<br>");
}

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

	if(chkItem.length > 0)
	{				
		sql = " insert into egtcrdt (sno, empno, reason, comments, edate, used_ind, upduser, upddate, newuser, newdate) values  ((select Nvl(Max(sno),0)+1 from egtcrdt),?,?,?,to_date(?,'yyyy/mm/dd'),'N',?, sysdate,?,sysdate) ";
		pstmt = conn.prepareStatement(sql);

		for(int i=0;i<chkItem.length;i++)
		{
			pstmt.setString(1,chkItem[i]);
			pstmt.setString(2,reason);
			pstmt.setString(3,comments);
			pstmt.setString(4,edate);
			pstmt.setString(5,userid);
			pstmt.setString(6,userid);
			pstmt.executeUpdate(); 	
		}
	}
%>
		<script language=javascript>
		alert("Insert completed!!");	
		//window.location.href="creditByFlt.jsp";	
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

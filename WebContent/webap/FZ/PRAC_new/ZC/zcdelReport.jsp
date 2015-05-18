<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page  import="eg.zcrpt.*,java.sql.*,ci.db.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
ArrayList objAL = (ArrayList) session.getAttribute("zcreportobjAL"); 
if ( sGetUsr == null | objAL == null) 
{		//check user session start first or not login
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
}
else
{
	String idx = request.getParameter("idx");
	boolean chkdup = false;
	ZCReportObj obj = (ZCReportObj) objAL.get(Integer.parseInt(idx));

	Connection conn = null;
	Driver dbDriver = null;
	Statement stmt = null;
	String sql = null;
	String returnstr = "";
       
    try
    {
		ConnectionHelper ch = new ConnectionHelper();
		conn = ch.getConnection();
		conn.setAutoCommit(false);	
		stmt = conn.createStatement();	
		sql = " delete from egtzcflt where seqno = to_number("+obj.getSeqno()+")"; 
		stmt.executeUpdate(sql);			

		sql = " delete from egtzccrew where seqno = to_number("+obj.getSeqno()+")"; 
		stmt.executeUpdate(sql);	
		
		sql = " delete from egtzccmdt where seqno = to_number("+obj.getSeqno()+")"; 
		stmt.executeUpdate(sql);			

		sql = " delete from egtzcgddt where seqno = to_number("+obj.getSeqno()+")"; 
		stmt.executeUpdate(sql);			

		conn.commit();	
		returnstr = "Y";
	}
	catch (Exception e)
	{
		try 
		{ 
			conn.rollback(); 
			returnstr = e.toString(); 
		} 
		catch (SQLException e1) 
		{ 
			returnstr = e1.toString(); 
		}
	} 
	finally
	{
		try{if(stmt != null) stmt.close();}catch (Exception e){}
		try{if(conn != null) conn.close();}catch (Exception e){}
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="../errStyle.css">
<title>刪除報告</title>
</head>

<body>
<%

if("Y".equals(returnstr))
{
%>
	<script>
		alert("報表已刪除");
	</script>
	<%	
	out.print("<div class=\"errStyle1\">"+obj.getFdate()+"&nbsp;"+obj.getFlt_num()+" 報表已刪除!!</div>");
}
else
{
	out.print("<div class=\"errStyle1\">Delete Report Fail : " + returnstr+"</div>");
}

}
%>
</body>
</html>

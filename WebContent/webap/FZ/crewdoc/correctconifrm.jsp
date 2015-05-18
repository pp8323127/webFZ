<%@page contentType="text/html; charset=big5" language="java"  %>
<%@page import="java.util.*,java.sql.*, ci.db.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
</head>
<body>
<div style="color:red;text-align:left;font-family:Verdana;font-size:10pt;background-color:#CCFFFF;padding:2pt;padding-left:50pt;line-height:2">
<%

//清掉cache
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

String userid = (String) session.getAttribute("userid");
if (session.isNew() || userid == null) 
{		//check user session start first or not login
 %>
 <jsp:forward page="../sendredirect.jsp" /> 
<%
} 
else
{
	Connection conn = null;
    Statement stmt = null;
	Driver dbDriver = null;
    String sql = "";
	boolean ifchk = true;

	try 
	{
		ConnectionHelper ch = new ConnectionHelper();
		conn = ch.getConnection();
		stmt = conn.createStatement();

		sql = " insert into fztdocw (empno,doc_type,chk_time) values ('"+userid+"','A',sysdate)";	
		stmt.executeUpdate(sql);
	}
	catch(SQLException e)
	{
		System.out.println(e.toString());
		ifchk = false;
	}
	catch(Exception e)
	{
		System.out.println(e.toString());
		ifchk = false;
	}  
	finally
	{
		try
		{
			if (stmt != null)
				stmt.close();
		}
		catch ( Exception e )
		{
		}
		try
		{
			if (conn != null)
				conn.close();
		}
		catch ( Exception e )
		{
		}
	}

	if(ifchk == true)
	{
%>
		<span style="color:red">
		謝謝您的合作!!<br>
		</span>
<%
	}
	else
	{
%>
		<span style="color:red">
		系統忙碌中.......,請稍後再試!!
		</span>
<%
	}
%>
</div>
</body>
</html>
<%
}//end of has session
%>
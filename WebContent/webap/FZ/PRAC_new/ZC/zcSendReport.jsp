<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=big5" language="java" %><%@ page  import="eg.zcrpt.*,java.sql.*,tool.ReplaceAll,ci.db.*,java.net.URLEncoder"%>
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
	ZCReportObj obj = (ZCReportObj) objAL.get(Integer.parseInt(idx));
	Driver dbDriver = null;
	Connection conn = null;
	PreparedStatement pstmt = null;
	boolean updSuccess = false;
	String msg = "";
	String sql = "";
	try
	{
		ConnectionHelper ch = new ConnectionHelper();
	    conn = ch.getConnection();

		sql = " Update egtzcflt set ifsent = ?, sentdate = sysdate where seqno = ? ";		
		pstmt = conn.prepareStatement(sql);

		pstmt.setString(1,"Y");
		pstmt.setString(2,obj.getSeqno());
		pstmt.executeUpdate();
		updSuccess=true;
}
catch (Exception e)
{
	//  out.print(e.toString());
	//  System.out.print("更新優點錯誤："+e.toString());
	  msg = "錯誤："+e.toString();
}
finally
{
	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}

if(updSuccess)
{
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Send Report(送出報告)</title>
<link href="../style2.css" rel="stylesheet" type="text/css">
</head>
<body>
<div align="center">
  <span class="purple_txt"><strong>報告已成功送出!!!<br>
  <br>Send Report Success!!
<br>
<br>
</strong></span><span class="red12"><strong>報告一經送出，即不得更改。
</strong></span></div>
</body>
<%
}
else
{
%>
	<script>
		alert("<%=msg%>" );
		history.back(-1);
	</script>
<%
}
}
%>
<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,javax.sql.DataSource,javax.naming.InitialContext,ci.db.*,java.util.*,java.io.*, java.text.*,java.math.*" %>
<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ;
if (session.isNew() || sGetUsr == null) {		//check user session start first
    %> <jsp:forward page="../sendredirect.jsp" /> <%
}//if
String empno   = request.getParameter("curremp");
String cname   = request.getParameter("currname");
String adjckdt = request.getParameter("adjckdt");
String chkType   = request.getParameter("chktype");
boolean rc = false;
//out.print("~~~~"+empno+"~~~~"+cname+"~~~~"+mode+"~~~~"+adjckdt);
int resultCount =0;
String sql = null;
ConnDB cn = new ConnDB();
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
PreparedStatement pstmt = null;
Driver dbDriver = null;
DataSource ds = null; 
try{
	InitialContext initialcontext = new InitialContext();
	ds = (DataSource) initialcontext.lookup("CAL.FZDS02");
	conn = ds.getConnection();
	conn.setAutoCommit(false);	

	sql = "INSERT INTO DZDB.DZTCKAJ VALUES "+
          "(?, ?, to_date(?,'yyyy/mm/dd'), ?, sysdate) ";
	
	pstmt = conn.prepareStatement(sql);
	int j = 1;
		
	pstmt.setString(j, empno);
	pstmt.setString(++j, chkType);
	pstmt.setString(++j, adjckdt);
	pstmt.setString(++j, sGetUsr);    
	resultCount=pstmt.executeUpdate();	   
	
	if(resultCount != 0){ %>
	   <script language="javascript">
	   //alert("Modify data successfully.");	   
	   //window.close();
	   </script><%
	   conn.commit();   
	   rc = true;
	   //session.setAttribute("seStatus", "Modify "+ empno + "(" + lname +","+fname + ") data successfully.");
	   //response.sendRedirect("othnat_select.jsp");	   	   
	}//if		   
}catch(Exception e){
	if(resultCount == 0){
		%><script language="javascript">
	   //alert("Modify data failed.");
	   //window.history.back();
	   </script><%
	   conn.rollback();
	   rc = false;
   	   //session.setAttribute("seStatus", "<font color='#FF0000'><strong>Modify "+ empno + "(" + lname +","+fname + ") data failed.</strong></font>");
	   //response.sendRedirect("othnat_select.jsp");	   	   
	}//if
	out.print(e.toString());
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}	
	try{if(conn != null) conn.close();}catch(SQLException e){}	
}//try

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><head><meta http-equiv="Content-Type" content="text/html; charset=big5"><title></title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
<table width="90%" border="0" cellpadding="1" cellspacing="1" bordercolor="#CCCCCC" align="center">
<tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr>
<%
if (rc) {  %>
	<tr><td align="center">	<img src="img/right.jpg" border="0"></td></tr><tr><td>&nbsp;</td></tr>
	<tr><td align="center"><font color='#0000FF'>儲存成功.<BR>請記得再按一次 <img src="img/query_btn.jpg" border="0"> 按鈕,<BR>以便顯示更新後資料!!!</font></td></tr><%
}else {   %>
	<tr><td align="center">	<img src="img/wrong.jpg" border="0"></td></tr><tr><td>&nbsp;</td></tr>
    <tr><td align="center"><font color='#FF0000'>無法儲存, 請檢查日期格式!!!</font></td></tr><%
} //if
%> 
</td></tr>
</table>
<p align="center">
<input type="button" name="Submit" value="Close" onClick="self.close()">
</p>
</body></html>


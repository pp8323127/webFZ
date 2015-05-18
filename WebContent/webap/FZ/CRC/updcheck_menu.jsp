<style type="text/css">
<!--
.style1 {
	font-family: Arial, Helvetica, sans-serif;
	color: #0000FF;
}
-->
</style>
<div align="center">
  <p class="style1">&nbsp;</p>
  <p class="style1">&nbsp;</p>
  <p class="style1">您已完成證照自我檢核報到程序 !!</p>
  <p class="style1">The Crew Reporting Check  has been completed !!</p>
</div>
<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*, ci.db.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //Check if logined
if ((sGetUsr == null) || (session.isNew()) )
{		//check user session start first or not login
	response.sendRedirect("sendredirect.jsp");
} 

String fltd = request.getParameter("fltd");
String fltno = request.getParameter("fltno");
String sect = request.getParameter("sect");
String fleet = request.getParameter("fleet");
String rank = request.getParameter("rank");

Driver dbDriver = null;
Connection conn = null;
Statement stmt = null;

String sql = null;
int rrow = 0;

ConnDB cn = new ConnDB();

try
{
	//connect to ORP3/FZ
	cn.setORP3FZUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	stmt = conn.createStatement(); 
	
	sql = "update fzdb.fztckin set crewchk='Y', crewchkdate=sysdate where fltd=to_date('"+fltd+
	"','yyyy/mm/dd') and fltno='"+fltno+"' and sect='"+sect+"' and empno='"+sGetUsr+"'";
	rrow = stmt.executeUpdate(sql);

	if(rrow <= 0){
		sql = "insert into fzdb.fztckin values(to_date('"+fltd+"','yyyy/mm/dd'), '"+fltno+"', '"+sect+
		"', '"+sGetUsr+"', '"+fleet+"', '"+rank+"', 'N', null, null, 'Y', sysdate)";
		stmt.executeUpdate(sql);
	}
}catch (Exception e){
	  out.println(e.toString() + sql);
}
finally{
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>

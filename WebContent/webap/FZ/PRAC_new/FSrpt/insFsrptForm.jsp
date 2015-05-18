<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.util.*" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login
String eventdate = (String) request.getParameter("eventdate") ; 
String carrier = (String) request.getParameter("carrier") ; 
String fltno = (String) request.getParameter("fltno") ; 
String dpt = (String) request.getParameter("dpt") ; 
String arv = (String) request.getParameter("arv") ; 
String actp = (String) request.getParameter("actp") ; 
String acno = (String) request.getParameter("acno") ; 
String rly = (String) request.getParameter("rly") ; 
String subject = (String) request.getParameter("subject") ; 
String desc = (String) request.getParameter("desc") ; 
String cons = (String) request.getParameter("cons") ; 
String alertstr = "";

if (userid == null) 
{		
	response.sendRedirect("../sendredirect.jsp");
} 

Driver dbDriver = null;
Connection conn = null;
Statement stmt = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
ConnDB cn = new ConnDB();
String sql = null;

try
{
	ConnectionHelper ch = new ConnectionHelper();
	conn = ch.getConnection();
	stmt = conn.createStatement();	

	sql = "insert into egtfsrpt (seq,rpt_subject,rpt_desc,potential_consequence,reply_request,event_date,carrier,fltno,sect,actype,acno,new_user,new_date,sent_date) values ((SELECT Nvl(Max(seq),0)+1 FROM egtfsrpt),?,?,?,?,to_date(?,'yyyy/mm/dd'),?,?,?,?,?,?,sysdate,sysdate)";

	pstmt = conn.prepareStatement(sql);

	int j = 1;
	pstmt.setString(j, subject);
	pstmt.setString(++j, desc);
	pstmt.setString(++j, cons);	                
	pstmt.setString(++j, rly);
	pstmt.setString(++j, eventdate);
	pstmt.setString(++j, carrier);
	pstmt.setString(++j, fltno);
	pstmt.setString(++j, dpt+arv);
	pstmt.setString(++j, actp);	                
	pstmt.setString(++j, acno);
	pstmt.setString(++j, userid);
	//update reply
	pstmt.executeUpdate();	     
%>
	<script language=javascript>
	alert("報告已送出!!");
	window.location.href="fsrptForm.jsp";
	</script>
<%
}
catch(Exception e)
{
	out.print(e.toString());
}
finally
{
	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>

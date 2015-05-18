<%@ page contentType="text/html; charset=big5" language="java"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="df.overTime.ac.*"%>
<%@ page import="ci.db.ConnectionHelper"%>

<%
String userid = (String)session.getAttribute("cs55.usr");
//out.print("userid="+userid+"<br>");
if(userid == null)
{
	response.sendRedirect("../logout.jsp");
}

Connection conn = null;
PreparedStatement pstmt = null;
String sql = "";
ResultSet rs = null;
String returnstr = "";
Driver dbDriver = null;
int count = 0;
boolean iscommit = false;
String idx = request.getParameter("idx");
String adjmins = request.getParameter("adjmins");
String adjmins2 = request.getParameter("adjmins2");
String adjmins_upd = request.getParameter("adjmins_upd");
String adjmins2_upd = request.getParameter("adjmins2_upd");
ArrayList objAL = (ArrayList) session.getAttribute("objAL");
OverTimeObj obj = (OverTimeObj)objAL.get(Integer.parseInt(idx));

/*
out.println("idx = "+idx+"<br>");
out.println("adjmins = "+adjmins+"<br>");
out.println("adjmins2 = "+adjmins2+"<br>");
out.println("empno = "+obj.getEmpno()+"<br>");
out.println("objAL.size()= "+objAL.size()+"<br>");
*/
	try 
	{
		ConnectionHelper ch = new ConnectionHelper();
		conn = ch.getConnection();       
		conn.setAutoCommit(false);	

		sql = "update dftsbir set overmins = to_number(?), overmins2 = to_number(?), chguser = ?, chgdt = sysdate where series_num = ? and duty_seq_num = ? and empno = ? ";

		pstmt = conn.prepareStatement(sql);			
		int j = 1;
		pstmt.setString(j, adjmins_upd);  
		pstmt.setString(++j, adjmins2_upd);  
		pstmt.setString(++j, userid);  
		pstmt.setString(++j, obj.getSeries_num());  
		pstmt.setString(++j, obj.getDuty_seq_num());  
		pstmt.setString(++j, obj.getEmpno());  
		pstmt.executeUpdate();
		conn.commit();	
		iscommit = true;
	} 
	catch (Exception e) 
	{
		try { conn.rollback(); } //有錯誤時 rollback
		catch (SQLException e1) { }
%>
			<script language="javascript" type="text/javascript">
			alert("Update failed!!\n資料更新失敗!!\n<%=e.toString()%>");
			history.back(-1);
			</script>
<%
	} 
	finally 
	{
		if (rs != null) try {rs.close();} catch (SQLException e) {}	
		if (pstmt != null) try {pstmt.close();} catch (SQLException e) {}
		if (conn != null) try { conn.close(); } catch (SQLException e) {}
		if(iscommit == true)
		{
%>
			<script language="javascript" type="text/javascript">
			alert("修改完成");
			window.opener.location.href="newAdjt_ac.jsp?yyyy=<%=obj.getAct_takeoff_utc().substring(0,4)%>&mm=<%=obj.getAct_takeoff_utc().substring(5,7)%>&dd=<%=obj.getAct_takeoff_utc().substring(8,10)%>&fltno=<%=obj.getFltno()%>&adjmins=<%=adjmins%>&adjmins2=<%=adjmins2%>";

			self.close();
			</script>
<%
		}
	}
%>
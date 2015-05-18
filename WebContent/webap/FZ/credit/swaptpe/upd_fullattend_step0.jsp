<%@ page contentType="text/html; charset=big5" language="java"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="credit.*"%>
<%@ page import="ci.db.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String userid = (String)session.getAttribute("userid");
//out.print("userid="+userid+"<br>");
if (session.isNew() || userid == null) 
{		//check user session start first
	response.sendRedirect("../../preCheckAC.jsp");
} 
else
{
	Connection conn = null;
	PreparedStatement pstmt = null;
	String sql = "";
	String returnstr = "";
	int count = 0;
	boolean iscommit = false;
	String[] chkItem = request.getParameterValues("chkItem");
	ArrayList objAL = (ArrayList)session.getAttribute("fullAttendAL");
	if(chkItem.length > 0)
	{
		try 
		{
			ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();  
			conn.setAutoCommit(false);	

			sql = "insert into egtpick (sno, empno, new_tmst, reason, valid_ind, sdate, edate, comments ) values ( (select max(sno)+1 from egtpick),?,sysdate,'1','Y',to_date(?,'yyyy/mm/dd'),to_date(?,'yyyy/mm/dd'),?) ";
			pstmt = conn.prepareStatement(sql);	
			for(int i=0;i<chkItem.length;i++)
			{
				FullAttendanceForPickSkjObj obj = (FullAttendanceForPickSkjObj)  objAL.get(Integer.parseInt(chkItem[i]));
				pstmt.setString(1 ,obj.getEmpno());
				//pstmt.setString(2 ,obj.getCheck_range_final_end());
				//pstmt.setString(3 ,obj.getCheck_range_start());
				pstmt.setString(2 ,obj.getCheck_range_start());
				pstmt.setString(3 ,obj.getCheck_range_final_end());
				pstmt.setString(4 ,obj.getComments());
				pstmt.executeUpdate();
			}
			conn.commit();	
			iscommit = true;
		} 
		catch (Exception e) 
		{
			out.print(e.toString()+"<br>");
			try { conn.rollback(); } //有錯誤時 rollback
			catch (SQLException e1) { out.print(e1.toString()); }
		} 
		finally 
		{
			if (pstmt != null) try { pstmt.close();} catch (SQLException e) {}
			if (conn != null) try { conn.close(); } catch (SQLException e) {}
			if(iscommit == true)
			{
%>
				<script language="javascript" type="text/javascript">
					alert("請盡速至簽派進行選班事宜");
					window.location.href='fullattend_step0.jsp';		
				</script>

<%		
			}
		}
	}
}	
%>
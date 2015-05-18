<%@ page contentType="text/html; charset=big5" language="java"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="credit.*"%>
<%@ page import="ci.db.*"%>

<%
String userid = (String)session.getAttribute("userid");
//out.print("userid="+userid+"<br>");
if (session.isNew() || userid == null) 
{		//check user session start first
	response.sendRedirect("../../preCheckAC.jsp");
} 
else
{
	Connection conn = null;
	Statement stmt = null;
	String sql = "";
	ResultSet rs = null;
	String returnstr = "";
	Driver dbDriver = null;
	int count = 0;
	boolean iscommit = false;
	String credit3 = "";
	String[] chkItem = request.getParameterValues("chkItem");
	ArrayList objAL = (ArrayList)session.getAttribute("creditListAL");
	if(chkItem.length > 0)
	{
		for(int i=0;i<chkItem.length;i++)
		{
				credit3 = credit3 + ","+chkItem[i];
		}
		CreditObj obj = (CreditObj)  objAL.get(0);

		try 
		{
			ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();  
			conn.setAutoCommit(false);	
			stmt = conn.createStatement();
			sql = "insert into egtpick (sno, empno, new_tmst, reason, valid_ind, credit3) values ( (select max(sno)+1 from egtpick),'"+obj.getEmpno()+"',sysdate,'2','Y','"+credit3.substring(1)+"') ";
//out.println(sql+"<br>");
			stmt.executeUpdate(sql);
			//***********************************************************************************
			sql = "update egtcrdt set intention='1', used_ind='Y', upduser='"+userid+"', upddate = sysdate where sno in ("+credit3.substring(1)+") ";
//out.println(sql+"<br>");
			stmt.executeUpdate(sql);
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
			if (stmt != null) try { stmt.close();} catch (SQLException e) {}
			if (conn != null) try { conn.close(); } catch (SQLException e) {}
			if(iscommit == true)
			{
%>
				<script language="javascript" type="text/javascript">
					alert("請於申請日後30天內至簽派進行選班事宜");
					window.location.href='creditpick_step0.jsp';		
				</script>

<%		
			}
		}
	}
}	
%>
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
String act_takeoff_utc = "";
String fltno = "";
int count = 0;
boolean iscommit = false;
String[] chkItem = request.getParameterValues("chkItem");
ArrayList objAL = (ArrayList) session.getAttribute("objAL");
String adjmins   = request.getParameter("adjmins");
String adjmins2   = request.getParameter("adjmins2");
//out.println("chkItem.length = "+chkItem.length+"<br>");
//out.println("objAL.size()= "+objAL.size()+"<br>");

if(chkItem.length > 0)
{
	try 
	{
		//ConnDB cn = new ConnDB();
		//cn.setDFUserCP();
		//dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
		//conn = dbDriver.connect(cn.getConnURL(), null);
		ConnectionHelper ch = new ConnectionHelper();
		conn = ch.getConnection();       
		conn.setAutoCommit(false);	

		sql = "insert into dftsbir (series_num, duty_seq_num, skj_report_gmt, act_release_gmt, skj_takeoff_gmt, act_land_gmt, act_takeoff_utc, workmins, basemins, empno, fltno, port_a, port_b, port_base, overmins, overmins2, sbirflag, paymm, chguser, chgdt) values (?,?,to_date(?,'yyyy/mm/dd hh24:mi:ss'),to_date(?,'yyyy/mm/dd hh24:mi:ss'),to_date(?,'yyyy/mm/dd hh24:mi:ss'),to_date(?,'yyyy/mm/dd hh24:mi:ss'),to_date(?,'yyyy/mm/dd hh24:mi:ss'),0,0,?,?,?,?,?,to_number(?),to_number(?),'Y',?,?,sysdate)";

		pstmt = null;
		pstmt = conn.prepareStatement(sql);			
		int count2 =0;
		for(int i=0;i<chkItem.length;i++)
		{
			OverTimeObj obj = (OverTimeObj)objAL.get(Integer.parseInt(chkItem[i]));
			act_takeoff_utc = obj.getAct_takeoff_utc();
			fltno = obj.getFltno();
			int j = 1;
			pstmt.setString(j, obj.getSeries_num());
			pstmt.setString(++j, obj.getDuty_seq_num());  
			pstmt.setString(++j, obj.getSkj_report_gmt());  
			pstmt.setString(++j, obj.getAct_release_gmt());  
			pstmt.setString(++j, obj.getSkj_takeoff_gmt());  
			pstmt.setString(++j, obj.getAct_land_gmt());  
			pstmt.setString(++j, obj.getAct_takeoff_utc());  
			pstmt.setString(++j, obj.getEmpno());  
			pstmt.setString(++j, obj.getFltno());  
			pstmt.setString(++j, obj.getPort_a());  
			pstmt.setString(++j, obj.getPort_b());  
			pstmt.setString(++j, obj.getPort_base());  
			pstmt.setString(++j, obj.getOvermins_sbir());  
			pstmt.setString(++j, obj.getOvermins2_sbir());  
			pstmt.setString(++j, obj.getPaymm());  
			pstmt.setString(++j, userid);  
			pstmt.addBatch();
			count2++;
			if (count2 == 10)
			{
				pstmt.executeBatch();
				pstmt.clearBatch();
				count2 = 0;
			}
		}

		if (count2 > 0)
		{
			pstmt.executeBatch();
			pstmt.clearBatch();
		}
		conn.commit();	
		iscommit = true;
	} 
	catch (Exception e) 
	{
		out.print("新增失敗 : "+ e.toString()+"<br>");
		try { conn.rollback(); } //有錯誤時 rollback
		catch (SQLException e1) { out.print(e1.toString()); }
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
			alert("新增完成");
			window.location.href="newAdjt_ac.jsp?yyyy=<%=act_takeoff_utc.substring(0,4)%>&mm=<%=act_takeoff_utc.substring(5,7)%>&dd=<%=act_takeoff_utc.substring(8,10)%>&fltno=<%= fltno%>&adjmins=<%=adjmins%>&adjmins2=<%=adjmins2%>";

			</script>
<%
		}
	}
}
%>
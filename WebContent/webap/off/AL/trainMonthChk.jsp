<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="java.sql.*,tool.*,ci.db.*"%>
<%
response.setHeader("Pragma","no-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0); //prevents caching at the proxy server
String userid = (String) session.getAttribute("userid") ; //get user id if already login
String offsdate = request.getParameter("offsdate") ; //get user id if already login
String sql = null;
ResultSet rs = null;
Connection conn = null;
Statement stmt = null;
Driver dbDriver = null;
ConnDB cn = new ConnDB();
try
{
	cn.setORP3EGUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	stmt = conn.createStatement();  

	sql = " select sern, cname, groups from egtcbas where empn = '"+userid+"'";
	//out.print(sql+"<br>");
	 rs = stmt.executeQuery(sql); 
	if (rs.next()) 
	{	       
		String cname = rs.getString("cname");
		String sern = rs.getString("sern");
		String groups = rs.getString("groups");
		//Sent email to notice
		//************************************************************************	
		tool.Email al = new tool.Email();
		String sender = "TPEEG@email.china-airlines.com";
		String receiver = userid+"@cal.aero";
		String cc = "";
		//String cc = "betty.yu@china-airlines.com";
		String mailSubject = "請與空訓部確認是否需提前安排ETS訓練";
		StringBuffer mailContent = new StringBuffer();
		mailContent.append("Dear "+cname+":\r\n\r\n");
		mailContent.append("為符合法規，客艙組員定期複訓應每二十四個月內執行二次；\r\n\r\n");
		mailContent.append("因您所申請的全月休假適逢ETS受訓月份，如您尚未與空訓部安排提前受訓事宜，\r\n\r\n");
		mailContent.append("請洽空訓部分機 3021 或回覆此信件，以免影響您的休假權益。\r\n\r\n");
		mailContent.append("P.S.如您已與空訓部安排提前受訓則無需回覆此信件。\r\n\r\n");
		mailContent.append("空訓部 敬上\r\n");
		al.sendEmail( sender,  receiver, cc, mailSubject, mailContent);
		//************************************************************************
		//************************************************************************	
		tool.Email al2 = new tool.Email();
		String sender2 = "TPEEG@email.china-airlines.com";
		String receiver2 = "TPEEG@email.china-airlines.com";
		//String cc2 = "betty.yu@china-airlines.com";
		String cc2 = "637277@cal.aero,633248@cal.aero,628550@cal.aero,637269@cal.aero,628948@cal.aero,638207@cal.aero";
		String mailSubject2 = "請確認是否需提前安排ETS訓練";
		StringBuffer mailContent2 = new StringBuffer();
		mailContent2.append("給空訓部記錄控管者:\r\n\r\n");
		mailContent2.append("《"+cname+"》"+" 《"+ userid +" ("+sern+")》  《"+rs.getString("groups")+"組》  《"+offsdate.substring(5,7)+"月》 需受ETS 訓練但申請全月AL，煩請追蹤受訓事宜。\r\n\r\n");
		mailContent2.append("WEB EG 通知\r\n");
		al2.sendEmail( sender2,  receiver2, cc2, mailSubject2, mailContent2);
		//************************************************************************
	}
}
catch (Exception e)
{
	  //out.println("Error : " + e.toString() + sql);
}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
	%>
		<script language=javascript>					
	    self.close();
		</script>
	<%		
}
%>
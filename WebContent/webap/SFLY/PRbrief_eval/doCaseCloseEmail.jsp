<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="java.sql.*,tool.*,ci.db.*"%>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login
String yyyymm = request.getParameter("yyyymm");
String base = request.getParameter("base") ; //get user id if already login
String mailSubject = request.getParameter("mailSubject");
String purempno = "";
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

	sql = " select purempno from egtprbe where brief_dt BETWEEN to_date('"+yyyymm+"/01','yyyy/mm/dd')  AND Last_Day(to_date('"+yyyymm+"/01','yyyy/mm/dd')) and caseclose = 'Y' ";
	if(!"ALL".equals(base))
	{
		sql = sql + " and purempno in  (select trim(empn) from egtcbas where station = '"+base+"') ";
	}
	sql = sql + " group by purempno ";
	//out.print(sql+"<br>");
	 rs = stmt.executeQuery(sql); 
	while (rs.next()) 
	{	       
		purempno = rs.getString("purempno");
		//Sent email to notice
		//************************************************************************	
		Email al = new Email();
		String sender = userid+"@cal.aero";
		//String receiver = "shu-fen.chou@china-airlines.com";
		//String receiver = "betty.yu@china-airlines.com";
		String receiver = purempno+"@cal.aero";
		String cc = "";//"betty.yu@china-airlines.com";
		StringBuffer mailContent = new StringBuffer();
		mailContent.append("Dear PUR:\r\n\r\n");
		mailContent.append("您 "+yyyymm+" 座艙長任務簡報表現評估報告已完成，請至組員班表資訊網查詢。\r\n");
		mailContent.append("並請於閱讀後，點擊〝檢視完畢〞按鈕回覆，謝謝!!\r\n\r\n");
		mailContent.append("空管部\r\n");
		al.sendEmail( sender,  receiver, cc, mailSubject, mailContent);
		//************************************************************************
	}
}
catch (Exception e)
{
	  out.println("Error : " + e.toString() + sql);
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
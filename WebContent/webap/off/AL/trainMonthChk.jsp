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
		String mailSubject = "�лP�ŰV���T�{�O�_�ݴ��e�w��ETS�V�m";
		StringBuffer mailContent = new StringBuffer();
		mailContent.append("Dear "+cname+":\r\n\r\n");
		mailContent.append("���ŦX�k�W�A�ȿ��խ��w���ưV���C�G�Q�|�Ӥ뤺����G���F\r\n\r\n");
		mailContent.append("�]�z�ҥӽЪ�����𰲾A�{ETS���V����A�p�z�|���P�ŰV���w�ƴ��e���V�Ʃy�A\r\n\r\n");
		mailContent.append("�Ь��ŰV������ 3021 �Φ^�Ц��H��A�H�K�v�T�z�����v�q�C\r\n\r\n");
		mailContent.append("P.S.�p�z�w�P�ŰV���w�ƴ��e���V�h�L�ݦ^�Ц��H��C\r\n\r\n");
		mailContent.append("�ŰV�� �q�W\r\n");
		al.sendEmail( sender,  receiver, cc, mailSubject, mailContent);
		//************************************************************************
		//************************************************************************	
		tool.Email al2 = new tool.Email();
		String sender2 = "TPEEG@email.china-airlines.com";
		String receiver2 = "TPEEG@email.china-airlines.com";
		//String cc2 = "betty.yu@china-airlines.com";
		String cc2 = "637277@cal.aero,633248@cal.aero,628550@cal.aero,637269@cal.aero,628948@cal.aero,638207@cal.aero";
		String mailSubject2 = "�нT�{�O�_�ݴ��e�w��ETS�V�m";
		StringBuffer mailContent2 = new StringBuffer();
		mailContent2.append("���ŰV���O�����ު�:\r\n\r\n");
		mailContent2.append("�m"+cname+"�n"+" �m"+ userid +" ("+sern+")�n  �m"+rs.getString("groups")+"�աn  �m"+offsdate.substring(5,7)+"��n �ݨ�ETS �V�m���ӽХ���AL�A�наl�ܨ��V�Ʃy�C\r\n\r\n");
		mailContent2.append("WEB EG �q��\r\n");
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
<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="ci.db.*,java.sql.*,tool.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title></title>
</head>
<body>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login
String doclose = request.getParameter("doclose");
String sernno = request.getParameter("sernno");
String syy = request.getParameter("syy");
String smm = request.getParameter("smm");
String sdd = request.getParameter("sdd");
String eyy = request.getParameter("eyy");
String emm = request.getParameter("emm");
String edd = request.getParameter("edd");
String purempno = request.getParameter("purempno");

if (userid == null) 
{		
	response.sendRedirect("logout.jsp");
}
else
{
		if("Y".equals(doclose))
		{
			String sql = null;
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

				sql = " update egtstti set caseclose = 'Y', close_user = '"+userid+"', close_tmst = sysdate where sernno ='"+sernno+"'";
				int c = stmt.executeUpdate(sql); 	
				if (c>0)
				{
					//Sent email to notice
					//************************************************************************	
					/*
					Email al = new Email();
					String sender = "tpeef@cal.aero";
					String receiver = "betty.yu@china-airlines.com,640790@cal.aero ";
					//String receiver = purempno+"@cal.aero";
					String cc = "betty.yu@china-airlines.com,640790@cal.aero ";
					String mailSubject = "�y�����Үֳ��i�q��";
					StringBuffer mailContent = new StringBuffer();
					mailContent.append("Dear crew:\r\n");
					mailContent.append("�z���@���Үֳ��i�w����,�Цܲխ��Z���T���d��,\r\n");
					mailContent.append("�ýЩ��˵����I���˵��������s�^��,����!!\r\n");
					mailContent.append("EF\r\n");
					al.sendEmail( sender,  receiver, cc, mailSubject, mailContent);
					*/
					//************************************************************************
			%>
					<script language=javascript>					window.opener.location.href="case_status_info.jsp?sernno=<%=sernno%>&purempno=<%=purempno%>&syy=<%=syy%>&smm=<%=smm%>&sdd=<%=sdd%>&eyy=<%=eyy%>&emm=<%=emm%>&edd=<%=edd%>";	
					window.location.href="doCaseCloseEmail.jsp?purempno=<%=purempno%>&mailSubject=����԰ȦҮֳ��i�q��";
					self.close();
					</script>
			<%			
				}
			}
			catch (Exception e)
			{
				  out.println("Error : " + e.toString() + sql);
			}
			finally
			{
				try{if(stmt != null) stmt.close();}catch(SQLException e){}
				try{if(conn != null) conn.close();}catch(SQLException e){}
			}
		}
		else
		{
%>
			<SCRIPT LANGUAGE="JavaScript">

			flag = confirm("Case close, �ñH�eEmail�q���ӭ� ?");
			if (flag == true) 
			{
				window.location.href="doCaseClose.jsp?sernno=<%=sernno%>&purempno=<%=purempno%>&syy=<%=syy%>&smm=<%=smm%>&sdd=<%=sdd%>&eyy=<%=eyy%>&emm=<%=emm%>&edd=<%=edd%>&doclose=Y";
			}
			else
			{
				self.close();		
			}
			</SCRIPT>
<%
		}
}	
%>
</body>
</html>

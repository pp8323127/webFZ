<%@page contentType="text/html; charset=big5" language="java"  %>
<%@page import="eg.crewbasic.*,java.util.*,java.sql.*, ci.db.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="swap.css" rel="stylesheet" type="text/css">
</head>
<body>
<div style="color:red;text-align:left;font-family:Verdana;font-size:10pt;background-color:#CCFFFF;padding:2pt;padding-left:50pt;line-height:2">
<%

//清掉cache
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

String userid = (String) session.getAttribute("userid");
StringBuffer mailContent = new StringBuffer();
String sender = userid+"@cal.aero";
//String receiver = "640790@cal.aero ";
String receiver = "ezvisa@china-airlines.com";
String contact_str = "証照資訊異動申請已送出!!<br>請於上班時間主動與空服處行政部#03-3993089 蕭雲芳 連絡!!<br>"; 
String cc = "";
String mailSubject = "証照資訊異動";
String memo = request.getParameter("memo");
boolean ifchg = false;

if (session.isNew() || userid == null) 
{		//check user session start first or not login
 %>
 <jsp:forward page="../sendredirect.jsp" /> 
<%
} 
else
{
	CrewDoc cd = new CrewDoc(userid);
	ArrayList objAL = new ArrayList();
	objAL = cd.getObjAL();

	eg.EGInfo egi = new eg.EGInfo(userid);
	eg.EgInfoObj crewobj = egi.getEGInfoObj(userid); 

	mailContent.append("Empno : "+userid+"\r\n");
	mailContent.append("Sern  : "+crewobj.getSern()+"\r\n");
	mailContent.append("Name  : "+crewobj.getCname()+"\r\n");
	mailContent.append("*******************************************************"+"\r\n");
	for(int i=0; i<objAL.size(); i++)
	{
		CrewDocObj obj = (CrewDocObj) objAL.get(i);
		String val1 = request.getParameter("num"+i);
		String valc = "";
		String val2 = request.getParameter("oldnum"+i);
/*
		if("台胞証".equals(obj.getDoc_type()) && obj.getDoc_num().length()== 10)
		{
			valc = request.getParameter("chnlic_count"+i);
			val1 = val1+valc;
		}
*/
		if(!val1.equals(val2))
		{
			ifchg = true;
			mailContent.append(obj.getDoc_type()+" 原 Number :"+val2+" 更改為"+ val1+"\r\n");	
		}

		String val3 = request.getParameter("issuedt"+i);
		String val4 = request.getParameter("oldissuedt"+i);
		if(!val3.equals(val4))
		{
			ifchg = true;
			mailContent.append(obj.getDoc_type()+" 原 Issue date :"+val4+" 更改為"+ val3+"\r\n");	
		}

		String val5 = request.getParameter("duedt"+i);
		String val6 = request.getParameter("oldduedt"+i);
		if(!val5.equals(val6))
		{
			ifchg = true;
			mailContent.append(obj.getDoc_type()+" 原 Expired date :"+val6+" 更改為"+ val5+"\r\n");	
		}
	}

	if(!"".equals(memo) && memo != null)
	{
		ifchg = true;
		mailContent.append("\r\n");	
		mailContent.append(" Memo :"+memo+"\r\n");	
	}

	if(ifchg == true)
	{
		//**************************************************************
		Connection conn = null;
		Statement stmt = null;
		Driver dbDriver = null;
		String sql = "";
		boolean ifchk = true;

		try 
		{
			ConnectionHelper ch = new ConnectionHelper();
			conn = ch.getConnection();
			stmt = conn.createStatement();

			sql = " insert into fztdocw (empno,doc_type,chk_time) values ('"+userid+"','B',sysdate)";	
			stmt.executeUpdate(sql);
		}
		catch(SQLException e)
		{
			System.out.println(e.toString());
			ifchk = false;
		}
		catch(Exception e)
		{
			System.out.println(e.toString());
			ifchk = false;
		}  
		finally
		{
			try
			{
				if (stmt != null)
					stmt.close();
			}
			catch ( Exception e )
			{
			}
			try
			{
				if (conn != null)
					conn.close();
			}
			catch ( Exception e )
			{
			}
		}
		//**************************************************************
		fzac.CrewInfo c = new fzac.CrewInfo(userid);
		fzac.CrewInfoObj obj = null;
		if (c.isHasData()) 
		{
			obj = c.getCrewInfo();
		}

		if (obj != null && "N".equals(obj.getFd_ind())) 
		{
			if ("KHH".equals(obj.getBase())) 
			{
				receiver = "ching-wen.li@china-airlines.com,gracelin@china-airlines.com,YA-LING_YANG@email.china-airlines.com,amyhsiao@china-airlines.com";
				contact_str = " 証照資訊異動申請已送出!!<br>請於上班時間主動與行政人員#1642 林秀娟 連絡!!<br>";
			}
		}

		tool.Email email = new tool.Email();
		email.sendEmail( sender,  receiver, cc, mailSubject, mailContent);
%>
	<span style="color:blue">
	<%=contact_str%>
	</span>
<%
	
	}
	else
	{
%>
	<span style="color:blue">
	查無任何異動!!<br>
	若發現資料錯誤，請於錯誤欄更正為正確資訊!!
	</span>
<%
	}
%>
</div>
</body>
</html>
<%
}//end of has session
%>
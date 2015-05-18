<link href="../FZ/menu.css" rel="stylesheet" type="text/css">
<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="eg.pickup.*,java.util.*,ci.db.*,java.sql.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String userid = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || userid == null) 
{		//check user session start first
	response.sendRedirect("../preCheckAC.jsp");
} 
else
{
	String yyyymm = request.getParameter("activedate").substring(0,4)+request.getParameter("activedate").substring(5,7);
	String status = "";
	String pkstatus = request.getParameter("pkstatus");
	String pkplace = request.getParameter("pkplace");
	String activedate = request.getParameter("activedate");

	if("N".equals(pkstatus))
	{
		pkplace ="X";
	}
	//String memo = request.getParameter("memo");

	String sql = null;
	String returnstr = "Y";
	Connection conn = null;
	PreparedStatement pstmt = null;
	Driver dbDriver = null;
	ResultSet rs = null; 
	Statement stmt = null;
	int cnt =0;
	int update_cnt =0;
	String where_str = "";
	boolean c_status = true;
	String errMsg = "";

	try
	{
		ConnDB cn = new ConnDB();
		cn.setORP3FZUserCP();
		dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
		conn = dbDriver.connect(cn.getConnURL(), null);
		stmt = conn.createStatement(); 

		if("C".equals(pkstatus))
		{//更改接車地點
			sql = "SELECT trim(traf) traf FROM dftcrew  WHERE empno = '"+userid+"'";
	//out.println(sql+"<br>");
			rs = stmt.executeQuery(sql);	
				 
			if (rs.next())
			{
				if("Y".equals(rs.getString("traf")))
				{
					c_status = false;
					errMsg = "您目前為不接車狀態,無需更改接車地點!";
				}
			}
		}
	}
	catch (Exception e)
	{
		  out.println("Error : " + e.toString() + sql);
		  returnstr = e.toString();
	}
	finally
	{
		try{if(rs != null) rs.close();}catch(SQLException e){}
		try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
		try{if(conn != null) conn.close();}catch(SQLException e){}
	}


	if (!c_status) 
	{
	%>
	<div style="background-color:#99FFFF;
			color:#FF0000;
			font-family:Verdana;
			font-size:10pt;padding:5pt;
			text-align:center; "><%=errMsg%><br>
	<a href="javascript:history.back(-1);">Back</a>
	</div>
	<%		
	}
	else 
	{
		try
		{
			EGConnDB cn = new EGConnDB();          
			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);	
			stmt = conn.createStatement(); 

			if("N".equals(pkstatus) | "Y".equals(pkstatus))
			{//接車不接車
				sql = "select count(*) c from egtpkcg where empno = '"+userid+"' and pk_yyyymm = '"+yyyymm+"' and  pk_status in ('Y','N')";
				where_str = " pk_status in ('Y','N') ";
			}
			else
			{
				sql = "select count(*) c from egtpkcg where empno = '"+userid+"' and pk_yyyymm = '"+yyyymm+"' and  pk_status = 'C'";
				where_str = " pk_status = 'C' ";		
			}

	//out.println(sql+"<br>");
			rs = stmt.executeQuery(sql);	
				 
			if (rs.next())
			{
				cnt = rs.getInt("c");
			}
		

			if(cnt<=0)
			{
				sql = " insert into egtpkcg (empno, pk_yyyymm, pk_status, pk_place, newuser, newdate, activedate) values (?,?,?,?,?,sysdate,to_date(?,'yyyy/mm/dd'))"; 
				pstmt = conn.prepareStatement(sql);		
				int j=1;
				pstmt.setString(j, userid);
				pstmt.setString(++j, yyyymm);
				pstmt.setString(++j, pkstatus);
				pstmt.setString(++j, pkplace);
				pstmt.setString(++j, userid);	
				pstmt.setString(++j, activedate);	

				//out.println(sql);
				update_cnt = pstmt.executeUpdate(); 	
			}
			else
			{//update
				sql = " update egtpkcg set pk_status=?, pk_place=?, activedate = to_date(?,'yyyy/mm/dd'), chguser=?, chgdate=sysdate where empno = ? and pk_yyyymm = ? "; 
				sql = sql + " and "+ where_str;

	//out.println("pkstatus "+ pkstatus +" pkplace "+pkplace+" activedate "+activedate+" yyyymm "+yyyymm+"<br> sql " +sql+"<br>");

				pstmt = conn.prepareStatement(sql);		
				int j=1;
				pstmt.setString(j, pkstatus);
				pstmt.setString(++j, pkplace);
				pstmt.setString(++j, activedate);	
				pstmt.setString(++j, userid);
				pstmt.setString(++j, userid);
				pstmt.setString(++j, yyyymm);	
				//out.println(sql);
				update_cnt = pstmt.executeUpdate(); 	
			}

			//if(update_cnt >=1 && ("C".equals(pkstatus) | "Y".equals(pkstatus)) )
			if(update_cnt >=1 && "C".equals(pkstatus))
			{
				//Sent email to notice 小白,蕭雲芳
				//************************************************************************	
				eg.EGInfo egi = new eg.EGInfo(userid);
				eg.EgInfoObj obj = egi.getEGInfoObj(userid); 

				java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm");

				tool.Email al = new tool.Email();
				String sender = "TPEEG@email.china-airlines.com";	
				String receiver = "629944@cal.aero,629944@china-airlines.com";
				String cc = "MEI-CHIN_TSAO@email.china-airlines.com,634283@cal.aero";
				//String receiver = "640790@cal.aero";
				//String cc = "betty.yu@china-airlines.com";
				String mailSubject = userid+" "+obj.getCname()+" 接車地點異動申請";
				StringBuffer mailContent = new StringBuffer();
				mailContent.append("Dear Sir:\r\n\r\n");
				mailContent.append(userid+" "+obj.getCname()+" 接車地點異動。\r\n\r\n");
				mailContent.append("生效日期 : "+activedate+"。\r\n");
				mailContent.append("接車地點 : "+ pkplace +"。\r\n");
				mailContent.append("申請時間 : "+formatter.format(new java.util.Date())+"。\r\n\r\n");
				mailContent.append("B/regards,\r\n");
				al.sendEmail( sender,  receiver, cc, mailSubject, mailContent);
				//************************************************************************
			}
		}
		catch (Exception e)
		{
			  out.println("Error : " + e.toString() + sql);
			  returnstr = e.toString();
		}
		finally
		{
			try{if(rs != null) rs.close();}catch(SQLException e){}
			try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
			try{if(conn != null) conn.close();}catch(SQLException e){}
		}
		%>
			<script language="javascript" type="text/javascript">
			alert("申請已送出! 請務必於飛行前一日與建民租車(2712-7130)再確認");
			window.location.href="pickup.jsp";	
			</script>
		<%
	}//if (!status) 
}
%>

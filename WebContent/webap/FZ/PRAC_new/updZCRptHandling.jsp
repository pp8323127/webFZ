<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page  import="eg.zcrpt.*,java.sql.*,ci.db.*,java.util.*"%>
<%
//response.setHeader("Cache-Control","no-cache");
//response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
String act_type =(String) request.getParameter("act_type");
String yy =(String) request.getParameter("yy");
String mm =(String) request.getParameter("mm");
String seqno = "";
String src = request.getParameter("src");
ArrayList unhandleobjAL = (ArrayList) session.getAttribute("unhandleobjAL"); 

if(sGetUsr != null || (src != null && src.equals("APP")))
{
Driver dbDriver = null;
Connection conn = null;
ResultSet rs = null;
PreparedStatement pstmt = null;
Statement stmt = null;
boolean updSuccess = false;
String msg = "";
String sql = "";
String sql2 = "";
try
{
	ConnectionHelper ch = new ConnectionHelper();
	conn = ch.getConnection();
	stmt = conn.createStatement();

	for(int u=0; u<unhandleobjAL.size(); u++)
	{
		ZCReportCheckObj obj = (ZCReportCheckObj) unhandleobjAL.get(u);
		sql = " delete from egtzcchk where seqkey = '"+obj.getSeqkey()+"' and handle_userid= '"+sGetUsr+"' ";
		stmt.executeUpdate(sql);
	}

	for(int u=0; u<unhandleobjAL.size(); u++)
	{
		ZCReportCheckObj obj = (ZCReportCheckObj) unhandleobjAL.get(u);		
		
		if("save".equals(act_type))
		{		
			sql = " insert into egtzcchk (seqkey,handle_unit,handle_userid,handle_date,comments,itemclose,itemclose_date)  values	(?,?,?,sysdate,?,'N',null) ";	

			pstmt = conn.prepareStatement(sql);	
			pstmt.setString(1,obj.getSeqkey());
			pstmt.setString(2,"空"+obj.getPgroups()+"組CM");
			pstmt.setString(3,sGetUsr);
			pstmt.setString(4,(String) request.getParameter("comm"+obj.getSeqkey()));
			pstmt.executeUpdate();
		}
		else //if("close".equals(act_type))
		{
			sql = " insert into egtzcchk (seqkey,handle_unit,handle_userid,handle_date,comments,itemclose,itemclose_date)  values (?,?,?,sysdate,?,'Y',sysdate) ";	

			pstmt = conn.prepareStatement(sql);	
			pstmt.setString(1,obj.getSeqkey());
			pstmt.setString(2,"空"+obj.getPgroups()+"組CM");
			pstmt.setString(3,sGetUsr);
			pstmt.setString(4,(String) request.getParameter("comm"+obj.getSeqkey()));
			pstmt.executeUpdate();

			//************************************************************************
			//check egtchk.seqkey if all done, then update egtcmdt.itemclose status to close
			sql2 = " select count(*) c from egtzcchk where seqkey = '"+obj.getSeqkey()+"' AND ( itemclose = 'N' OR itemclose is NULL)  ";

			rs = stmt.executeQuery(sql2);
			int key_cnt =0;
			if (rs.next())
			{
				key_cnt = rs.getInt("c");
			}
			if(key_cnt<=0)
			{
				sql2 = " update egtzccmdt set itemclose='Y', itemclose_date=sysdate where seqkey='"+obj.getSeqkey()+"'";
				stmt.executeUpdate(sql2);
				seqno = obj.getSeqno();
			}
		}
	}

	sql = " update egtzcflt set rptclose='Y', rptclose_userid='"+sGetUsr+"', rptclose_date=sysdate  where seqno='"+seqno+"'";
	stmt.executeUpdate(sql);
	updSuccess=true;
}
catch (Exception e)
{
	//  out.print(e.toString());
	//  System.out.print("更新優點錯誤："+e.toString());
	  msg = "錯誤："+e.toString()+"**"+sql;
}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}

if(updSuccess)
{
%>
	<script language="javascript" type="text/javascript">
	window.opener.location.href="RepostList.jsp?yy=<%=yy%>&mm=<%=mm%>&src=<%=src%>";
	self.close();	
	</script>
<%
}
else
{
	out.print(msg);
%>
	<script>
		alert("<%=msg%>" );
		history.back(-1);
	</script>
<%
}
}else
{		//check user session start first or not login
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
}

%>
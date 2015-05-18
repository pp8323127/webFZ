<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,ci.db.*,java.util.*,fz.projectinvestigate.*"%>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
	response.sendRedirect("../../sendredirect.jsp");
} 

String fltdt = request.getParameter("fltdt");//yyyy/mm/dd
String fltno = request.getParameter("fltno");//006
String sect = request.getParameter("sect");//TPELAX
String proj_no = request.getParameter("proj_no");
String fleet = request.getParameter("fleet");
String acno = request.getParameter("acno");
ArrayList projobjAL = (ArrayList) session.getAttribute("projobjAL") ;
//out.println("projobjAL "+projobjAL.size());
boolean passchk = true;
for(int i=1; i<projobjAL.size(); i++)
{
	PRProjIssueObj obj = (PRProjIssueObj) projobjAL.get(i);
	String tempfeedback = request.getParameter("fackback-"+obj.getProj_no()+"-"+obj.getItemno());
	String tempcomm = request.getParameter("comments-"+obj.getProj_no()+"-"+obj.getItemno());
	//if(tempfeedback == null | "".equals(tempfeedback) | tempcomm == null | "".equals(tempcomm))
	if(tempfeedback == null | "".equals(tempfeedback) )
	{
		passchk = false;
	}
}

if(passchk == true)
{
	Connection conn = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	Driver dbDriver = null;
	String sql = "";
	ResultSet rs = null;
	String returnstr = "";
	int count = 0;
	boolean iscommit = false;
	try
	{
		ConnDB cn = new ConnDB();
		cn.setORP3EGUserCP();
		dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
		conn = dbDriver.connect(cn.getConnURL(), null);
		conn.setAutoCommit(false);	
		stmt = conn.createStatement();

		sql = " delete from egtprpj  WHERE fltdt = To_Date('"+fltdt+"','yyyy/mm/dd') AND fltno = '"+fltno+"' AND sect = '"+sect+"' AND empno = '"+sGetUsr+"'";
		stmt.executeUpdate(sql);

		sql = "insert into egtprpj (fltdt,fltno,sect,empno,fleet,acno,proj_no,projtype, itemno,chkempno,feedback,comments,newdate,newuser) values (to_date(?,'yyyy/mm/dd'),?,?,?,?,?,?,?,?,?,?,?,sysdate,?) ";

		pstmt = null;
		pstmt = conn.prepareStatement(sql);			
		int count2 =0;
		for(int i =1; i<projobjAL.size(); i++)
		{
			PRProjIssueObj obj = (PRProjIssueObj) projobjAL.get(i);
			int j = 1;
			pstmt.setString(j, obj.getFltdt());
			pstmt.setString(++j, obj.getFltno());  
			pstmt.setString(++j, obj.getSect());  
			pstmt.setString(++j, sGetUsr);  
			pstmt.setString(++j, obj.getFleet());  
			pstmt.setString(++j, obj.getAcno());  
			pstmt.setString(++j, obj.getProj_no());  
			pstmt.setString(++j, obj.getKin());  
			pstmt.setString(++j, obj.getItemno());  
			pstmt.setString(++j, obj.getChkempno());  
			pstmt.setString(++j, request.getParameter("fackback-"+obj.getProj_no()+"-"+obj.getItemno()));  
			pstmt.setString(++j, request.getParameter("comments-"+obj.getProj_no()+"-"+obj.getItemno()));  
			pstmt.setString(++j, sGetUsr);  
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
	{	out.println(e.toString());
		try { conn.rollback(); } //有錯誤時 rollback
		catch (SQLException e1) { out.print(e1.toString()); }
	%>
		<script language=javascript>
			alert("Update failed!!\n更新失敗!!");
			window.history.back(-1)
		</script>
	<%
	} 
	finally
	{
		if (stmt != null) try {stmt.close();} catch (SQLException e) {}	
		if (pstmt != null) try {pstmt.close();} catch (SQLException e) {}
		if (conn != null) try { conn.close(); } catch (SQLException e) {}
		if(iscommit == true)
		{
		%>
			<script language=javascript>
				alert("Update completed!!\n更新成功!!");
				//window.opener.location.reload();
				this.window.close();
				</script>
		<%

		}
	}
}//if(passchk == true)
else
{
%>
	<script language=javascript>
		alert("Please complete each Issue!!\n有部份題目尚未填寫完全!!");
		window.history.back(-1);
	</script>
<%
}
%>
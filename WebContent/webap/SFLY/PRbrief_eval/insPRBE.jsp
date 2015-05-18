<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*,ci.db.ConnDB,eg.prfe.*" %>
<%

String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) 
{		
	response.sendRedirect("../logout.jsp");
}

String empno  = request.getParameter("empno");
String sdate = request.getParameter("sdate");
String time_hh = request.getParameter("brief_hh");
String time_mi = request.getParameter("brief_mi");
String fltno = request.getParameter("fltno");
String chk1 = request.getParameter("chk1");
String chk2 = request.getParameter("chk2");
String chk3 = request.getParameter("chk3");
String chk4 = request.getParameter("chk4");
String chk5 = request.getParameter("chk5");
String comm = request.getParameter("comm");

ArrayList objAL = (ArrayList) session.getAttribute("objAL") ;

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
int j=1;
String forwardPage = "";
String sql = null;
String commitstr = "N";
Driver dbDriver = null;
ConnDB cn = new ConnDB();

try
{
//ort1
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
conn.setAutoCommit(false);	
//********************************************************************
if(objAL.size()<=0)
{
	sql = "INSERT INTO egtprbe (brief_dt,brief_time,fltno,purempno,chk1_score,chk2_score,chk3_score,chk4_score,chk5_score,comm,newuser,newdate) VALUES (to_date(?,'yyyy/mm/dd'),?,?,?,?,?,?,?,?,?,?,sysdate)";
	pstmt = conn.prepareStatement(sql);			
	j=1;
	pstmt.setString(j,sdate);
	pstmt.setString(++j, time_hh+":"+time_mi);
	pstmt.setString(++j, fltno);
	pstmt.setString(++j, empno);
	pstmt.setString(++j, chk1);
	pstmt.setString(++j, chk2);				
	pstmt.setString(++j, chk3);
	pstmt.setString(++j, chk4);				
	pstmt.setString(++j, chk5);
	pstmt.setString(++j, comm);				
	pstmt.setString(++j, userid);
	pstmt.executeUpdate();	
}
else
{
	sql = "update egtprbe set brief_time =?, fltno = ?, chk1_score = ?, chk2_score = ?, chk3_score = ?, chk4_score = ?, chk5_score = ?, comm =? where brief_dt = to_date(?,'yyyy/mm/dd') and purempno = ? ";
	pstmt = conn.prepareStatement(sql);			
	j=1;
	pstmt.setString(j, time_hh+":"+time_mi);
	pstmt.setString(++j, fltno);
	pstmt.setString(++j, chk1);
	pstmt.setString(++j, chk2);				
	pstmt.setString(++j, chk3);
	pstmt.setString(++j, chk4);				
	pstmt.setString(++j, chk5);
	pstmt.setString(++j, comm);				
	pstmt.setString(++j, sdate);
	pstmt.setString(++j, empno);
	pstmt.executeUpdate();	
}
conn.commit();
commitstr = "Y";
}
catch (Exception e)
{
	 try 
	{ 
		 conn.rollback(); 
	} 
    catch (SQLException e1) 
	{ 
		out.print(e1.toString()); 
	}
	 %>
	<script language="javascript" type="text/javascript">
	alert("Update failed!!\n資料更新失敗!!");
	window.history.back(-1);
	</script>
	<%
}
finally
{
	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
	if("Y".equals(commitstr))
	{
%>
		<script language="javascript" type="text/javascript">
		alert("Update completed!!");		
		window.location.href='PRbrief_evalView.jsp?empno=<%=empno%>&sdate=<%=sdate%>&edate=<%=sdate%>';
		</script>
<%
	}
}


%>
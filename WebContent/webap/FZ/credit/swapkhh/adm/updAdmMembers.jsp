<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,java.sql.*"%>
<%
//�s�W�������Z�޲z�H��
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
} 

Connection conn = null;
Driver dbDriver = null;

PreparedStatement pstmt = null;
ResultSet rs = null;
ci.db.ConnDB cn = new ci.db.ConnDB();
String errMsg = "";
boolean status = false;
String empno = request.getParameter("empno");

try{

cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
//�P�_�O�_�w����
boolean hasData = false;

pstmt = conn.prepareStatement("SELECT * FROM fztuidg WHERE userid=? AND gid='KHHEFFZ'");
pstmt.setString(1,empno);
rs = pstmt.executeQuery();
	
	while(rs.next()){
		hasData = true;
	}


pstmt = conn.prepareStatement("SELECT cname,exstflg FROM hrdb.hrvegemploy WHERE employid=?");
pstmt.setString(1,empno);
rs = pstmt.executeQuery();
boolean isOnduty = false;
String cname = "";
	while(rs.next()){
		if("Y".equals(rs.getString("exstflg"))){
			isOnduty = true;
			cname = rs.getString("cname");
		}
	}
	
	if(hasData){
		status = false;
		errMsg = "���H���w�s�b.";
	}else if(!isOnduty){
		status = false;
		errMsg = "���u��:"+empno+"�L��(��Ƥ��s�b�ΤH���w���b¾).";
	}else{
		pstmt = conn.prepareStatement("INSERT into fztuidg VALUES(?,NULL,"
			+"?,'KHHEFFZ','SIUD','�B�z�������Z�ӽ�',SYSDATE,?)");
			//(SELECT cname FROM hrdb.hrvegemploy WHERE employid=?)
		pstmt.setString(1,empno);
		pstmt.setString(2,cname);
		pstmt.setString(3,sGetUsr);
				
		pstmt.executeUpdate();
		
		status = true;
		
	}
	rs.close();
	pstmt.close();
}catch (Exception e){
	errMsg += e.toString();
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
if(!status){
%>
<div style="background-color:#99FFFF;
		color:#FF0000;
		font-family:Verdana;
		font-size:10pt;padding:5pt;
		text-align:center; ">��s����!!
  <br>
  ERROR:<%=errMsg%><br>
<a href="admMembers.jsp" target="_self">BACK</a></div>
<%	
}else{
%>
<script language="javascript" type="text/javascript">
	alert("��s���\!!");
	self.location.href="admMembers.jsp";
</script>
<%
}
%>

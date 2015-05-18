<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="java.sql.*"%>
<%
//�s�W�������
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
 
 
} 

Connection conn = null;
Driver dbDriver = null;

PreparedStatement pstmt = null;
ResultSet rs = null;
ci.db.ConnDB cn = new ci.db.ConnDB();
String errMsg = "";
boolean status = false;
String addate = request.getParameter("addate");

try{

cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
//�P�_�O�_�w����
boolean hasData = false;

pstmt = conn.prepareStatement("select setdate from fztsetdf where station='KHH' and setdate= to_date(?,'yyyy/mm/dd')");
pstmt.setString(1,addate);
rs = pstmt.executeQuery();
	
	while(rs.next()){
		hasData = true;
	}
	
	if(hasData){
		status = false;
		errMsg = "�s�W����w�s�b.";
	}else{
	
		pstmt = conn.prepareStatement("insert into fztsetdf (setdate,station) values(to_date(?,'YYYY/MM/DD'),'KHH')");
		pstmt.setString(1,addate);
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
		text-align:center; ">��s����!!<br>
ERROR:<%=errMsg%><br>
<a href="setdate.jsp" target="_self">BACK</a></div>
<%	
}else{
%>
<script language="javascript" type="text/javascript">
	alert("��s���\!!");
	self.location.href="setdate.jsp";
</script>
<%
}
%>

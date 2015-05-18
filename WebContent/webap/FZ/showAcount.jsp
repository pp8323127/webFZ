<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page  import="java.sql.*,ci.db.*" %>
<%

response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if ( sGetUsr == null) 
{		//check user session start first or not login
	response.sendRedirect("sendredirect.jsp");
} 

String empno = request.getParameter("empno");

 
Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;


boolean hasRecord = false;
try{

//connect to ORP3 FZ use connection pool 
ConnDB cn = new ConnDB();
cn.setORP3FZUserCP(); 
dbDriver = (Driver)Class.forName(cn.getDriver()).newInstance(); 
conn =	 dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);

//���ˬd�O�_�w���b��!!
sql = "select * from fztuser where userid='"+empno+"'";

//out.print(sql);
rs = stmt.executeQuery(sql);
rs.last();

if(rs.getRow() == 1){//�b���w�s�b
	hasRecord = true;
}


}catch(Exception se){

	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}

	//out.print(se.toString());
	response.sendRedirect("showmessage.jsp?messagestring=Add Account Failed!!&messagelink=Back&linkto=javascript:history.back(-2)");


	
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}

}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>��ܬd�߱b�����G</title>
<link href="menu.css" rel="stylesheet" type="text/css">
<script language="javascript">
function checkEmpno(){
var empno = "<%=empno%>";

	if( confirm("�T�w�n�s�W�b��:"+empno)){
		document.form1.send.disabled=1;
		return true;
	}else{
		return false;
	}

}
</script>
</head>

<body>
<%
if(hasRecord){
out.print("<span class=\"txtxred\">"+empno+"</span><span class=\"txtblue\">&nbsp;&nbsp;&nbsp;���b���w�s�b!! </span>");
}else{
%>
<span class="txtxred"><%=empno%></span><span class="txtblue">�ثe�L���b��</span><br>
<br>
<form method="post" action="updAddAccount.jsp" onsubmit="return checkEmpno()" name="form1">
  <span class="txtblue">�s�W���b��?</span>  
  <input name="send" type="submit" id="send" value="Add">
<input type="hidden" name="empno" value="<%=empno%>">
</form>
<%
}
%>

</body>
</html>

<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page  import="java.sql.*,ci.db.*,ci.tool.*"%>
<%

String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (sGetUsr == null) {
	response.sendRedirect("sendredirect.jsp");

} 

String oldPW = request.getParameter("oldPW");
String newPW = request.getParameter("newPW");

Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;
int xcount = 0;
String selPW = null;//�q��Ʈw����X�Ӫ���password
try
{
ConnDB cn = new ConnDB();
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement();

sql = "select pwd from fztuser where userid='"+sGetUsr+"'";
rs = stmt.executeQuery(sql);

while(rs.next()){
	selPW = rs.getString("pwd");
}

if(!oldPW.equals(selPW)){
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
	
	response.sendRedirect("showmessage.jsp?messagestring=Sorry, wrong password!!Please insert correct password!!&messagelink=Back&linkto=javascript:history.back(-2)");
}else{
	rs.close();
	PwCheck pwCheck = new PwCheck(newPW);
	if(!pwCheck.isValidPw()){
	
	%>
		<script>
		alert("Your password is invalid,please reinsert new password!!\n\n�K�X���צܤֻݬ������,���e�ܤֻݥ]�t�@�X��r (A-Z �� a-z)\n�Τ@�X�Ʀr (�ίS��Ÿ�),�B���o�ϥΥ���r�Υ��Ʀr.");
		self.location = "chgPw.jsp";
		</script>
	
	<%
	}else{
	
		
		sql = "update fztuser set pwd='"+newPW+"',chgdate=sysdate "+
			"where userid='"+sGetUsr+"'";
		stmt.executeUpdate(sql);
		fz.writeLog wl = new fz.writeLog();
		wl.updLog(sGetUsr, request.getRemoteAddr(),request.getRemoteHost(), "FZ335");
		
	}//end of new password is valid	
}	
}catch(Exception se){
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}

//	out.print(se.toString());
	response.sendRedirect("showmessage.jsp?messagestring=Change Password Failed!!&messagelink=Back&linkto=javascript:history.back(-1)");

	
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}

}

%>

<script language="JavaScript" type="text/JavaScript">
	alert("Password been changed!!System will logout automatically.\nPlease login again!!\n\n�K�X�w���A�t�ΧY�N�۰ʵn�X�A�Э��s�n�J");
	self.parent.location="sendredirect.jsp";	
</script>
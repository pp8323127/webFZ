<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page  import="java.sql.*,ci.db.*,ci.tool.*,fz.*,ci.db.*"%>
<%

String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (sGetUsr == null) {
	response.sendRedirect("sendredirect.jsp");

} else{

String pw1 = request.getParameter("pw1");

PwCheck pwCheck = new PwCheck(pw1);
if(!pwCheck.isValidPw()){
%>
	<script>
	alert("Your password is invalid,please reinsert new password!!\n\n�K�X���צܤֻݬ������,���e�ܤֻݥ]�t�@�X��r (A-Z �� a-z)\n�Τ@�X�Ʀr (�ίS��Ÿ�),�B���o�ϥΥ���r�Υ��Ʀr.");
	self.location = "pwCheck.jsp";
	</script>

<%
}else{
	
	
	

Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
//ResultSet rs = null;
String sql = null;
int xcount = 0;
String selPW = null;//�q��Ʈw����X�Ӫ���password
try{
ConnDB cn = new ConnDB();
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

/*
cn.setORP3FZUser();
java.lang.Class.forName(cn.getDriver());
conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),
	cn.getConnPW());
*/	
stmt = conn.createStatement();

//sql = "select pwd from fztuser where userid='"+sGetUsr+"'";
sql ="update  fztuser set pwd='"+pw1+"',chgdate=sysdate where userid='"+sGetUsr+"'";

stmt.executeUpdate(sql);
//out.print(sql);

//�g�JLog
writeLog wl = new writeLog();
wl.updLog(sGetUsr, request.getRemoteAddr(),request.getRemoteHost(), "FZ330");

%>

<script language="JavaScript" type="text/JavaScript">
	alert("Password been changed!!System will logout automatically.\n\n�K�X�w���A�t�ΧY�N�۰ʵn�X�A�Э��s�n�J");
	self.location="sendredirect.jsp";

</script>

<%

}catch(SQLException se){

	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
	System.out.print("SQLException in force change password "+se.toString());
	out.print("Change password Error!!Please try Again!!");
		
}catch(Exception se){
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
	
	System.out.print("exception in force change password "+se.toString());

//	out.print(se.toString());
	out.print("Change password Error!!Please try Again!!");

	
}finally{

	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}

}


}//end of password is valid

}//end of session is valid
%>
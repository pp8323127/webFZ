<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*,java.util.*,java.text.*,ci.db.*,fz.*" %>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if ( sGetUsr == null) 
{		//check user session start first or not login
	response.sendRedirect("sendredirect.jsp");
} 

String empno = request.getParameter("empno");
//寫入Log
writeLog wl = new writeLog();
String userip = request.getRemoteAddr();
String userhost = request.getRemoteHost();
 
Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;
String password = null;
int xcount = 0;
int status = 0;

boolean t = false;
try{

//connect to ORP3 FZ use connection pool 
ConnDB cn = new ConnDB();
cn.setORP3FZUserCP(); 
dbDriver = (Driver)Class.forName(cn.getDriver()).newInstance(); 
conn =	 dbDriver.connect(cn.getConnURL(), null);
/*
//connect to ORP3 FZ
ConnDB cn = new ConnDB();
cn.setORP3FZUser();
Class.forName(cn.getDriver());
conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),
		cn.getConnPW());
*/		
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);

//先檢查是否已有帳號!!
sql = "select userid from fztuser where userid='"+empno+"'";

//out.print(sql);
rs = stmt.executeQuery(sql);
rs.last();

if(rs.getRow() == 1){//帳號已存在
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
response.sendRedirect("showmessage.jsp?messagestring=Sorry, this account is duplicate!!&messagelink=Back&linkto=javascript:history.back(-2)");	
	
}else{

	rs.close();
	
	//亂數產生密碼
	Random rd = new Random();
	double randomPW =rd.nextGaussian()*100000000;
	if(randomPW<0){
		randomPW =0-randomPW;
	}

	DecimalFormat df = new DecimalFormat("00000000");
	password = df.format(randomPW);
	
	sql= "insert into fztuser values('"+empno+"','"+password+"',sysdate)";
	stmt.executeUpdate(sql);
	resetPW rp = new resetPW(empno);
	rp.sendPassword(password);

	wl.updLog(sGetUsr, userip,userhost, "FZ310");

	out.print("<script>alert(\"帳號新增成功\");</script>");
	out.print("<p align=\"center\" >新增帳號成功!!<br><br>密碼已寄至該使用者的全員信箱。 </p>");

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
<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*,java.util.*,ci.db.ConnDB,java.io.*,java.text.*"%>
<%!
/*
 * Created on 2004/10/13
 *	Log of reset CIA Password 
*/
public class ResetCIAPwLog {
		
	public String writeLog(String empno,String userid){
		String msg = "0";

		 GregorianCalendar currentDate = new GregorianCalendar();
		 java.util.Date curDate = Calendar.getInstance().getTime();
		
		String writeLogTime = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss",Locale.UK).format(curDate);		
	
	try {
		FileWriter fw = null;
	    fw = new FileWriter("/apsource/csap/projfz/webap/Log/reset_cia_logOS.txt", true);
	    fw.write(empno+"\t"+userid+"\t\t"+writeLogTime+"\r\n");
	    fw.close();
	    
	} catch (Exception e) {
			msg = e.toString();
	}
	return msg;
	
	}
	
}

%>
<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
if (session.isNew()) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 

//aocitest
String empno = request.getParameter("empno");
ConnDB cn = new ConnDB();

Driver dbDriver = null;
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;	
String sql = null;
String cabin = (String)session.getAttribute("cabin");//Y:前艙,N後艙
String crewCabin = "";
try{
	
	cn.setAOCIPRODCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	/*
	cn.setORT1AOCITESTUser();
	java.lang.Class.forName(cn.getDriver());
	conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() ,
		cn.getConnPW());
	*/
	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);	

	//1.先區分為前艙或後艙	
sql = "select k.staff_num, p.fd_ind cabin from crew_rank_v k, rank_tp_v p "
	+"where p.display_rank_cd=k.rank_cd AND staff_num= '"+empno+"' ";
	rs = stmt.executeQuery(sql);
	
	
	
	while(rs.next()){
		crewCabin = rs.getString("cabin");
	}
	
	if(crewCabin.equals(cabin)){
		
	sql = "update user_login_v A set A.PASSWORD = "+
		"(select B.PASSWORD from user_login_v B where B.USER_ID = 'aircrews') "+
		"where A.USER_ID = '"+empno+"' ";
//	out.print(sql);
	stmt.executeQuery(sql);

	ResetCIAPwLog rw = new ResetCIAPwLog();
	rw.writeLog(empno,sGetUsr);
	
	fz.writeLog wl = new fz.writeLog();
	wl.updLog(sGetUsr, request.getRemoteAddr(),request.getRemoteHost(), "FZ334");

	
	}
	
}
catch (Exception e)
{
	 
	  out.print(e.toString());
}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>update Reset CIA Password</title>
<link href="menu.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
if(!crewCabin.equals(cabin)){
%>
無此組員：<%=empno%>!!
<%
}else{
%>

<div align="center">
    <span class="txtxred">Reset Password Success!!
    <br>
    Reset 後需稍待1~30分鐘系統同步.    <br>
    <a href="resetCIAPWOS.jsp" target="_self">Reset another</a></span>
</div>
<script>
	alert("Success!!");
</script>

<%
}
%>
</body>
</html>

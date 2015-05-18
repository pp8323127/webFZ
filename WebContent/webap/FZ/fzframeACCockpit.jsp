<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,fz.*,ci.tool.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%


String pw = (String)session.getAttribute("password");
	

PwCheck pwCheck = new PwCheck(pw);
if("Y".equals(request.getParameter("forceCheck")) &&!pwCheck.isValidPw() ){
%>
  <jsp:forward page="pwCheck.jsp" /> 
<%  
}else{


Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet rs = null;
int count = 0;
boolean t = false;
String ms = "";
String sql = null;
String errMsg = "";
try{

	dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
	conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
	
	stmt = conn.createStatement();
	sql = "select replace(Nvl(ms,'\r\n'),'<BR>',',') ms,to_char(chgdate,'mm/dd hh24:mi') chgdate, flag from fzthotn where flag='1'";
	
	
	rs = stmt.executeQuery(sql);
	if(rs != null){
		while(rs.next()){
			ms	=  "飛航組員注意事項:"+rs.getString("ms");
		
		}
	}
	
	if(ms.equals("\r\n")){
		ms="";
	}


}catch (Exception e){
	  t = true;
	  errMsg = e.toString();
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>
<html>
<head>
<title>China Airlines Cabin Crew Schedule Inquiry System</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<script Language="JavaScript"><!--
count = 0;
str = "                                                                                                                                "+    "<%=ms%>";
function moveText()
{
	status = str.substring(count++,str.length+1);
	count %= str.length;
	setTimeout("moveText()",300);
}
setTimeout("moveText()",300);
// --></script>

</head>

<frameset cols="185,*" frameborder="NO" border="0" framespacing="0" rows="*"> 
  <frame name="leftFrame" scrolling="AUTO" src="fscreenACCockpit.jsp">
  <frameset rows="50,*" frameborder="NO" border="0" framespacing="0" cols="*"> 
    <frame name="topFrame" scrolling="NO"  src="showmessage.jsp?" >
    <frame name="mainFrame" src="blank.htm">
  </frameset>
</frameset>
<noframes><body >

</body></noframes>
</html>
<%

if(t){
%>
      <jsp:forward page="err.jsp" /> 
<%
}
}//end of valid password
%>


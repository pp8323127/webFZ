<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,ci.db.*,java.net.URLEncoder" %>
<%
//刪除First Item
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("logout.jsp");
} 


String[] delItem = request.getParameterValues("itemno");
String delStr="";
for(int i=0;i<delItem.length;i++){
	if(i==0){
		delStr = "'"+delItem[i]+"'";
	}else{
		delStr +=",'"+delItem[i]+"'";
	}
}

Connection conn = null;
Statement stmt = null;
Statement stmt2 = null;
String sql = null;
String sql2 = null;
String forwardPage = null;
int hasItemCount = 0;
int resultCount = 0;
int resultCount2 = 0;

ConnDB cn = new ConnDB();
Driver dbDriver = null;

try{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
	stmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);	
						
						
	sql = "delete egtstfi where itemno in(" + delStr+")";	
	sql2 = "delete egtstsi where kin in(" + delStr+")";							
	resultCount = stmt.executeUpdate(sql);
	resultCount2 = stmt2.executeUpdate(sql2);
	
	if(resultCount !=0){
		forwardPage= "edItem.jsp";
	}
					
}catch(Exception e){
forwardPage= "showMessage.jsp?msg="+URLEncoder.encode("資料更新失敗<br>"+ e.toString()+"<br>")+
		"&link=back&linkto=javascript:history.back(-1);";

}finally{
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(stmt2 != null) stmt.close();}catch(SQLException e){}	
	try{if(conn != null) conn.close();}catch(SQLException e){}

}				
response.sendRedirect(forwardPage);

%>

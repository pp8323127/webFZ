<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*,ci.db.*,java.net.URLEncoder"%>
<%
//新增Firtst Item
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("../logout.jsp");
} 

String itemDsc = request.getParameter("addItemDsc");
String flag    = request.getParameter("addFlag");
String forwardPage = "";
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;
String max = "";
int resultCount = 0;
ConnDB cn = new ConnDB();
Driver dbDriver = null;

try{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
//抓max itemno
sql = "select LPAD(max,3,'0') max from (select (max(itemno)+1) max  from egtprcus)";					
rs = stmt.executeQuery(sql);
if(rs.next()){
	max = rs.getString("max");
}
rs.close();
//out.print(hasItemCount);


sql = "insert into egtprcus (itemno,itemdsc,flag) values('"+max+"','"+itemDsc+"', '"+flag+"')"  ;
resultCount = stmt.executeUpdate(sql);
	%>
				<script language=javascript>
				alert("Insert completed!!\n存入成功!!");
				</script>
	<%

	if(resultCount !=0){
		forwardPage= "edCusItem.jsp";
	}

	
}catch(Exception e){
	//out.println( e.toString());
forwardPage= "../showMessage.jsp?messagestring="+URLEncoder.encode("資料更新失敗<br>"+ e.toString()+"<br>")+"&messagelink=back&linkto=javascript:history.back(-1);";


}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}

}					

response.sendRedirect(forwardPage);

%>

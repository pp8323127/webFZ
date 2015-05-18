<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*,ci.db.*,java.net.URLEncoder"%>
<%
//新增 Add Remark Attribute Value
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("logout.jsp");
} 

String itemNo  = request.getParameter("addItemNo");
String itemDsc = request.getParameter("addItemDsc");

String forwardPage = "";
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;
int hasItemCount = 0;
int resultCount = 0;
ConnDB cn = new ConnDB();
Driver dbDriver = null;

try{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);


stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);

sql = "insert into egtstrm values(lpad('"+itemNo+"',3,'0'),'"+itemDsc+"')"  ;
resultCount = stmt.executeUpdate(sql);
	%>
				<script language=javascript>
				alert("Add completed!!\n新增成功!!");
				</script>
	<%

	if(resultCount !=0){
		forwardPage= "edRemark.jsp";
	}

	
}catch(Exception e){
forwardPage= "showMessage.jsp?messagestring="+URLEncoder.encode("資料更新失敗<br>"+ e.toString()+"<br>")+
	"&messagelink=back&linkto=javascript:history.back(-1);";


}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}

}					

response.sendRedirect(forwardPage);

%>

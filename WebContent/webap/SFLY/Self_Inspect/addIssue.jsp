<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*,ci.db.*,java.net.URLEncoder"%>
<%
//新增Self Inspection List Issue
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("../logout.jsp");
} 

String issueNo  = request.getParameter("addIssueNo");
String issueDsc = request.getParameter("addIssueDsc");
//String flag    = request.getParameter("addFlag");
String forwardPage = "";
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;
int hasIssueCount = 0;
int resultCount = 0;
ConnDB cn = new ConnDB();
Driver dbDriver = null;

try{

cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);

sql = "insert into egtstci (itemno, subject, flag) values(lpad('"+issueNo+"',3,'0'),'"+issueDsc+"','Y')"  ;
resultCount = stmt.executeUpdate(sql);
	%>
				<script language=javascript>
				alert("Add completed!!\n新增成功!!");
				</script>
	<%

	if(resultCount !=0){
		forwardPage= "edIssue.jsp";
	}

	
}catch(Exception e){
forwardPage= "../showMessage.jsp?messagestring="+URLEncoder.encode("資料更新失敗<br>"+ e.toString()+"<br>")+
	"&messagelink=back&linkto=javascript:history.back(-1);";


}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}

}					

response.sendRedirect(forwardPage);

%>

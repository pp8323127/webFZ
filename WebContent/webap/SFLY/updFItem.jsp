<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,ci.db.*,java.net.URLEncoder"%>
<%
//update First Item
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("logout.jsp");
} 

String oItemno  = request.getParameter("oItemno");//��l��itemno
String itemno 	= request.getParameter("itemno");//�ק�᪺itemno
String itemdsc  =  request.getParameter("itemdsc");//�ק�᪺itemdsc
String flag     =  request.getParameter("flag");//�ק�᪺flag

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;
ConnDB cn = new ConnDB();
int countItemno = 0;
int countUpdate =0;
String forwardPage = "";
Driver dbDriver = null;

try{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
					
//�����ҭק�᪺itemno�O�_�w�g�s�b,�Y�w�s�b�Ashow message
if(!itemno.equals(oItemno)){
	sql = "select count(*) count from egtstfi where itemno='"+ itemno+"'";
	rs = stmt.executeQuery(sql);
	while(rs.next()){
		countItemno = rs.getInt("count");
	}
	rs.close();

}

if(countItemno >0){
	forwardPage= "showMessage.jsp?messagestring="+URLEncoder.encode("ItemNo���ơA�Э��s��J<br>")+
		"&messagelink=back&linkto=javascript:history.back();";
}else{

	//update
	sql = "update egtstfi set itemno='"+itemno+"',itemdsc='"+itemdsc+"',flag='"+flag+"' "+
		"where itemno='"+oItemno+"'" ;
			
	countUpdate = stmt.executeUpdate(sql);
	
	if(countUpdate !=0){
		forwardPage= "close";
	}			
}



}catch(Exception e){
		forwardPage= "showMessage.jsp?messagestring="+URLEncoder.encode("��Ƨ�s����<br>"+ e.toString()+"<br>")+
	"&messagelink=back&linkto=javascript:history.back(-1);";
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
if("close".equals(forwardPage)){
%>
<script src="js/close.js"></script>
<script language="javascript">
	close_self('edItem.jsp');
</script>
<%
}else{
	response.sendRedirect(forwardPage);
}
%>
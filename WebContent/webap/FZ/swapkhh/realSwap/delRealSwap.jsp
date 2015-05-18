<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*"%>
<%
String userid= (String) session.getAttribute("userid");
String formno = request.getParameter("formno");

if(userid == null){
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
}else if(null == formno | "".equals(formno) ){
	out.print("刪除失敗!!");

}else{



Driver dbDriver = null;
Connection conn = null;
PreparedStatement pstmt = null;
boolean status = false;
String errMsg = "";
ci.db.ConnDB cn = new ci.db.ConnDB();



try{

cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
	
	
//有錯誤時rollback
 conn.setAutoCommit(false);
pstmt = conn.prepareStatement("delete fztrformf where station='KHH' and  formno = ?");

	
pstmt.setString(1,formno);

pstmt.executeUpdate();


	status = true;
	conn.commit();

//寫入log

fz.writeLog wl = new fz.writeLog();
wl.updLog(userid, request.getRemoteAddr(),request.getRemoteHost(), "FZ455K");


} catch (SQLException e) {
	//有錯誤時rollback
	try {conn.rollback();} catch (SQLException e1) {}
	errMsg = "更新失敗："+e.toString();
	
} catch (Exception e) {
	//有錯誤時rollback
	try {conn.rollback();} catch (SQLException e1) {}
	errMsg = "更新失敗："+e.toString();
} finally {
	if ( pstmt != null ) try {
		pstmt.close();
	} catch (SQLException e) {}
	if ( conn != null ) try {
		conn.close();
	} catch (SQLException e) {}

}



	if(!status){
	%>
	<div style="background-color:#99FFFF;
			color:#FF0000;
			font-family:Verdana;
			font-size:10pt;padding:5pt;
			text-align:center; "> 刪除失敗<br>
	ERROR:<%=errMsg%><br>
	<a href="javascript:history.back(-1);" target="_self">BACK</a></div>		
	<%
	}else{
	%>
	<script language="javascript" type="text/javascript">
		alert("刪除成功!!");
		self.location.href="realSwapAdm.jsp";
		parent.topFrame.location.href="../blank.htm";
		
	</script>
	
	
	<%
	}

}


%>

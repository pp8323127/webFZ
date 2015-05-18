<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*"%>

<%
String userid= (String) session.getAttribute("userid");

String year = request.getParameter("year");
String month = request.getParameter("month");
String aEmpno = request.getParameter("aempno").trim();
String aCount = request.getParameter("aCount");
String aComm = request.getParameter("aComm");
//if("".equals(aComm)){ aComm = null;}
String rEmpno = request.getParameter("rempno").trim();
String rCount = request.getParameter("rCount");
String rComm = request.getParameter("rComm");
//if("".equals(rComm)){ rComm = null;}

if(userid == null){
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
}else if(null == aEmpno | "".equals(aEmpno) ){
	out.print("請輸入換班者員工號!!");
}else if(null == rEmpno | "".equals(rEmpno) ){
	out.print("請輸入被換者員工號!!");
}else{



Driver dbDriver = null;
Connection conn = null;
PreparedStatement pstmt = null;
boolean status = false;
String errMsg = "";
ci.db.ConnDB cn = new ci.db.ConnDB();
String formno = "";


try{

cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
	
	
//有錯誤時rollback
 conn.setAutoCommit(false);
			
pstmt = conn.prepareStatement("INSERT INTO fztrformf VALUES "
	+"((SELECT 'R'||Nvl(Max(SubStr(formno,2)+1),?) nextFormNo FROM fztrformf WHERE station='KHH' and yyyy=? AND mm=?),"
	+"?,?,?,?,?,?,?,?,?,SYSDATE,'KHH')");
	
pstmt.setString(1,year+month+"0001");
pstmt.setString(2,year);
pstmt.setString(3,month);

pstmt.setString(4,year);
pstmt.setString(5,month);
pstmt.setString(6,aEmpno);
pstmt.setString(7,aCount);
pstmt.setString(8,aComm);
pstmt.setString(9,rEmpno);
pstmt.setString(10,rCount);
pstmt.setString(11,rComm);
pstmt.setString(12,userid);

pstmt.executeUpdate();


	status = true;
	conn.commit();

//寫入log

fz.writeLog wl = new fz.writeLog();
wl.updLog(userid, request.getRemoteAddr(),request.getRemoteHost(), "FZ450K");


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
				text-align:center; "> 新增失敗<br>
		ERROR:<%=errMsg%><br>
		<a href="javascript:history.back(-1);" target="_self">BACK</a></div>		
	<%
		
	
	}else{
	%>
		<script language="javascript" type="text/javascript">
			alert("新增成功!!");
			self.location.href="realSwapAdm.jsp";
			parent.topFrame.location.href="../blank.htm";
			
		</script>
	<%
		
	}

}


%>

<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*"%>

<%
String userid= (String) session.getAttribute("userid");
String formno = request.getParameter("formno");
String year = request.getParameter("year");
String month = request.getParameter("month");
String oYear =  request.getParameter("oYear");
String oMonth = request.getParameter("oMonth");
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
}else if(null == formno | "".equals(formno) ){
	out.print("更新失敗!!");
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



try{

cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
	
	
//有錯誤時rollback
 conn.setAutoCommit(false);
 
 //有更換年月,更換formno
 if(!(oYear+oMonth ).equals(year+month)){
	 pstmt = conn.prepareStatement("update fztrformf set yyyy=?,mm=?,aempno=?,acount=?,acomm= ?,"
		+"rempno=?,rcount=?,rcomm=?,chguser=?,chgdate=sysdate,"
		+"formno=(SELECT 'R'||Nvl(Max(SubStr(formno,2)+1),?)   FROM fztrformf WHERE station='KHH' and  yyyy=? AND mm=?) "
		+"where station='KHH' and formno = ?");
	
		
		pstmt.setString(1,year);
		pstmt.setString(2,month);
		pstmt.setString(3,aEmpno);
		pstmt.setString(4,aCount);
		pstmt.setString(5,aComm);
		pstmt.setString(6,rEmpno);
		pstmt.setString(7,rCount);
		pstmt.setString(8,rComm);
		pstmt.setString(9,userid);
		pstmt.setString(10,year+month+"0001");
		pstmt.setString(11,year);
		pstmt.setString(12,month);
		
		
		pstmt.setString(13,formno);
		
		pstmt.executeUpdate();
		status = true;
		conn.commit();
		
 }else{
	pstmt = conn.prepareStatement("update fztrformf set yyyy=?,mm=?,aempno=?,acount=?,acomm= ?,"
		+"rempno=?,rcount=?,rcomm=?,chguser=?,chgdate=sysdate where  station='KHH' and formno = ?");
	
		
	pstmt.setString(1,year);
	pstmt.setString(2,month);
	pstmt.setString(3,aEmpno);
	pstmt.setString(4,aCount);
	pstmt.setString(5,aComm);
	pstmt.setString(6,rEmpno);
	pstmt.setString(7,rCount);
	pstmt.setString(8,rComm);
	pstmt.setString(9,userid);
	pstmt.setString(10,formno);
	
	pstmt.executeUpdate();
	
	
		status = true;
		conn.commit();
		
 }

//寫入log

fz.writeLog wl = new fz.writeLog();
wl.updLog(userid, request.getRemoteAddr(),request.getRemoteHost(), "FZ453K");


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
				text-align:center; ">更新失敗<br>
		ERROR:<%=errMsg%><br>
		<a href="javascript:history.back(-1);" target="_self">BACK</a></div>		
	<%
		
	
	}else{
	%>
		<script language="javascript" type="text/javascript">
			alert("更新成功!!");
			self.location.href="realSwapAdm.jsp";
			parent.topFrame.location.href="../blank.htm";
			
		</script>
	<%
		
	}

}


%>

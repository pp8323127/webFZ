<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<%
String userid = (String)session.getAttribute("userid");
String errMsg = "";
boolean status = false;
if(userid == null){
	errMsg = "�����w�L��,�Э��s�n�J.";
}else{
	String kindSName = request.getParameter("kindSName");
	String kindFName  = request.getParameter("kindFName");
	String kindMbl = request.getParameter("kindMbl");
	String deleteCK_ind = request.getParameter("deleteCK_ind");//�R��AirCrews�����p���H���
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ci.db.ConnDB cn = new ci.db.ConnDB();
	ResultSet rs = null;
	Driver dbDriver = null;
	try {     
	
	cn.setORP3FZUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	conn.setAutoCommit(false);
	//���ˬd�O�_���|���ץX�����
	pstmt = conn.prepareStatement("select count(1) cnt from fztckind where empno=? and export_ind='N' "
	+"and ( delete_ind='N' OR delete_ind is NULL)");
	pstmt.setString(1,userid);
	rs = pstmt.executeQuery();
	boolean hasNonImportedData = false;
	while(rs.next()){
		if(rs.getInt("cnt") >0){
			hasNonImportedData = true;
		}
	}
	rs.close();
	

	if("Y".equals(deleteCK_ind) && !hasNonImportedData){

		
			//�Ndelete_ind�]��NULL
			pstmt = conn.prepareStatement("INSERT INTO fztckind"
				+"(empno,kindred_surname,kindred_first_name,kinddred_phone_num,apply_time,delete_ind) "
				+"VALUES(?,?,?,?,SYSDATE,'N') ");
	
			pstmt.setString(1,userid);
			pstmt.setString(2,kindSName);
			pstmt.setString(3,kindFName);
			pstmt.setString(4,kindMbl);			

			
	}	else if(hasNonImportedData){
		//���|���ץX�����=>��s���
		
			pstmt = conn.prepareStatement("update fztckind set kindred_surname=?,kindred_first_name=?,"
					+"kinddred_phone_num=?,apply_time=sysdate where empno=? and export_ind='N' and delete_ind='N'");
			pstmt.setString(1,kindSName);
			pstmt.setString(2,kindFName);
			pstmt.setString(3,kindMbl);
			pstmt.setString(4,userid);
		
	
	}else{
		pstmt = conn.prepareStatement("INSERT INTO fztckind"
				+"(empno,kindred_surname,kindred_first_name,kinddred_phone_num,apply_time) "
				+"VALUES(?,?,?,?,SYSDATE) ");
	
		pstmt.setString(1,userid);
		pstmt.setString(2,kindSName);
		pstmt.setString(3,kindFName);
		pstmt.setString(4,kindMbl);
	
	}
	pstmt.executeUpdate();
	conn.commit();

	status = true;
	
	}catch(Exception e){
		status = false;
		errMsg += e.getMessage();
	
		try {
		//�����~�� rollback
			conn.rollback();
		} catch (SQLException e1) {
			errMsg += e1.getMessage();
		}
	}  finally {
		if (rs != null)
			try {
				rs.close();
			} catch (SQLException e) {	errMsg += e.getMessage();}
		if (pstmt != null)
			try {
				pstmt.close();
			} catch (SQLException e) {	errMsg += e.getMessage();}
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
					errMsg += e.getMessage();
	
			}
			conn = null;
		}
	}

}

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="../../checkStyle1.css">
<link rel="stylesheet" type="text/css" href="../../lightColor.css">
<link rel="stylesheet" type="text/css" href="../../../style/kbd.css">
<title>��s���</title>
<style type="text/css">
.r{margin-right:0.5em;}
</style>
</head>

<body>
<%
if(!status){
%>
<div class="paddingTopBottom1 bgLYellow red center"><img src="../../images/messagebox_warning.png" align="top" class="r"><%=errMsg%></div>
<%
}else{



%>
<div class="paddingTopBottom1 bgLYellow red center"><img src="../../images/messagebox_info.png" align="top" class="r">�ӽи�Ƥw��s!!</div>
<script type="text/javascript" language="javascript">
alert("�ӽи�Ƥw��s!!");
self.location.href="editCrewKindred.jsp";
</script>
</body>
</html>
<%
}
%>
<%@ page contentType="text/html; charset=big5" language="java"   %>
<%@ page import="java.sql.*,fzac.crewkindred.*,java.text.*,ci.tool.*,ci.db.*"%>
<%
String userid  = (String)session.getAttribute("cs55.usr");
ArrayList dataAL = null;
dataAL = (ArrayList)session.getAttribute("crewLindAL");
String errMsg = "";
boolean  status = true;

if(userid == null){
	status = false;
	errMsg = "網頁已過期,請重新登入";

}else if(dataAL == null){
	status = false;
	errMsg = "無可更新的資料";

}else{

	//1. 匯入AirCrews
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	ConnDB cn = new ConnDB();

	Driver dbDriver = null;

	try {

		cn.setAOCIPRODCP();
		dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
		conn = dbDriver.connect(cn.getConnURL(), null);
		conn.setAutoCommit(false);
		
		for(int i=0;i<dataAL.size();i++){
			CrewKindredObj  obj = (CrewKindredObj)dataAL.get(i);
			pstmt = conn.prepareStatement("SELECT Count(*) cnt FROM crew_next_of_kin_v WHERE staff_num=?");
			pstmt.setString(1,obj.getEmpno());
			rs = pstmt.executeQuery();
			boolean hasData = false;
			if(rs.next()){
				if(rs.getInt("cnt")>0){
					hasData = true;
				}
			}
			rs.close();
			pstmt.close();
			
			if(obj.getDelete_ind() == null && hasData ){
				//申請刪除資料
				pstmt = conn.prepareStatement("UPDATE crew_next_of_kin_v SET surname=?,first_name=?,"
				+"contact_phone_num=?,delay_priority=1,sickness_priority=1,accident_priority=1 "
				+"WHERE staff_num=?");
				pstmt.setString(1, UnicodeStringParser.Big5ToUnicode(" "));
				pstmt.setString(2, UnicodeStringParser.Big5ToUnicode(" "));
				pstmt.setString(3,null);
				pstmt.setString(4,obj.getEmpno());
			}
			else if(hasData){
				//update 
				pstmt = conn.prepareStatement("UPDATE crew_next_of_kin_v SET surname=?,first_name=?,"
				+"contact_phone_num=?,delay_priority=1,sickness_priority=1,accident_priority=1 "
				+"WHERE staff_num=?");
				pstmt.setString(1, UnicodeStringParser.Big5ToUnicode(obj.getKindred_surName()));
				pstmt.setString(2, UnicodeStringParser.Big5ToUnicode(obj.getKindred_First_Name()));
				pstmt.setString(3,obj.getKinddred_Phone_Num());
				pstmt.setString(4,obj.getEmpno());
				
			}else{			
				//insert
				pstmt = conn.prepareStatement("INSERT  INTO  crew_next_of_kin_v(staff_num,surname,first_name "
					+",contact_phone_num,delay_priority, sickness_priority, accident_priority) "
					+" VALUES(?,?,?,?,1,1,1) ");

				pstmt.setString(1,obj.getEmpno());		  
			  	pstmt.setString(2, UnicodeStringParser.Big5ToUnicode(obj.getKindred_surName()));
				pstmt.setString(3, UnicodeStringParser.Big5ToUnicode(obj.getKindred_First_Name()));
				pstmt.setString(4,obj.getKinddred_Phone_Num());					 

			}
			pstmt.executeUpdate();
			pstmt.close(); 

			
		}
		
		conn.commit();
		conn.close();
		
	//2. udpate FZTCKIND 資料		
		cn.setORP3FZUserCP();		
		conn = dbDriver.connect(cn.getConnURL(), null);
		conn.setAutoCommit(false);
		for(int i=0;i<dataAL.size();i++){
			CrewKindredObj  obj = (CrewKindredObj)dataAL.get(i);
			pstmt = conn.prepareStatement("UPDATE fztckind SET export_ind='Y',"
				+"export_time=SYSDATE,export_empno=? "
				+"WHERE empno=? AND export_ind='N' AND ( delete_ind='N' or delete_ind is null)");
			pstmt.setString(1,userid);
			pstmt.setString(2,obj.getEmpno());
			pstmt.executeUpdate();	
			pstmt.close();
		}


		conn.commit();
		conn.close();		
		status = true;
		
	}catch (Exception e) {
			status = false;
		errMsg += e.getMessage();
		try {
		//有錯誤時 rollback
			conn.rollback();
		} catch (SQLException e1) {
			errMsg += e1.getMessage();
		}
	} finally {
		if (rs != null)
			try {
				rs.close();
			} catch (SQLException e) {}
		if (pstmt != null)
			try {
				pstmt.close();
			} catch (SQLException e) {}
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
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
<title>執行匯入資料動作</title>
<link rel="stylesheet" type="text/css" href="../../../style/style1.css">

<link rel="stylesheet" type="text/css" href="../../lightColor.css">
<link rel="stylesheet" type="text/css" href="../../../style/kbd.css">
<link rel="stylesheet" type="text/css" href="../../../style/loadingStatus.css">

</head>

<body>
<%
if(!status){

%>
<div class="paddingTopBottom bgLYellow red center"><%=errMsg%></div>
<%

}else{
%>
<div class="paddingTopBottom bgLYellow red center"><img src="../../images/messagebox_info.png" width="22" height="22" align="top">資料已轉入!!</div>
<%
}
%>
</body>
</html>

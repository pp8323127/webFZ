<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*"  %>
<%

String userid =(String)session.getAttribute("userid");
if(userid == null){
	response.sendRedirect("../sendredirect.jsp");
}else{

String seqno = null;
if( !"".equals(request.getParameter("seqno")) && null != request.getParameter("seqno")){
	seqno =  request.getParameter("seqno");
}

String fltd = null;
if( !"".equals(request.getParameter("fltd")) && null != request.getParameter("fltd")){
	 fltd = request.getParameter("fltd");
}

String fltno = null;
if( !"".equals(request.getParameter("fltno")) && null != request.getParameter("fltno")){
	fltno = request.getParameter("fltno");
}
String sect = null;
if( !"".equals(request.getParameter("sect")) && null != request.getParameter("sect")){
	sect = request.getParameter("sect");
}
String empno= null;
if( !"".equals(request.getParameter("empno")) && null != request.getParameter("empno")){
	empno =  request.getParameter("empno");
}

//取得ZC考評項目、敘述
fz.pracP.zc.EvaluationType evalType = new fz.pracP.zc.EvaluationType();
ArrayList evalTypeAL = evalType.getDataAL();

// 分數
ArrayList detailScoreAL = null;

if(evalTypeAL != null){
	for(int i=0;i<evalTypeAL.size();i++){
		fz.pracP.zc.EvaluationTypeObj evalObj = (fz.pracP.zc.EvaluationTypeObj)evalTypeAL.get(i);

		if(detailScoreAL == null){
			detailScoreAL = new ArrayList();
		}
		
		fz.pracP.zc.ZoneChiefEvalObj detailObj = new fz.pracP.zc.ZoneChiefEvalObj();
		
		detailObj.setScoreType( evalObj.getScoreType()  );//String
		detailObj.setScore(Integer.parseInt(request.getParameter("score"+evalObj.getScoreType())));//int 
		detailObj.setComm(request.getParameter("comm"+evalObj.getScoreType()));//String
		
		detailScoreAL.add(detailObj);
		
		
	}
}

boolean status = false;
String errMsg = "";


Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
ci.db.ConnDB cn = new ci.db.ConnDB();
Driver dbDriver = null;

try {

	cn.setORP3EGUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
conn.setAutoCommit(false);

//取得目前最大的seqno
String tempSeqno = "";
	pstmt = conn.prepareStatement("SELECT Max(seqno)+1 tempSeqno FROM egtzcdm");
	rs = pstmt.executeQuery();
	while(rs.next()){
		tempSeqno = rs.getString("tempSeqno");
	}
	
	rs.close();
	pstmt.close();	
	
if(seqno == null){// Insert

	//update egtzcdm
	pstmt = conn.prepareStatement("INSERT INTO egtzcdm VALUES(? , ?, To_Date(?,'yyyy/mm/dd'),?,?,?,SYSDATE,?)");
	pstmt.setString(1,tempSeqno);//seqno
	pstmt.setString(2, fz.pracP.GdYear.getGdYear(fltd));//gdyear
	pstmt.setString(3,fltd);//fltd
	pstmt.setString(4,fltno);//fltno
	pstmt.setString(5,sect);//sect
	pstmt.setString(6,empno);//empno
	pstmt.setString(7,userid);//userid
	
	pstmt.executeUpdate();
	pstmt.close();	
	
	//insert egtzcds



	for(int i=0;i<detailScoreAL.size();i++){
		fz.pracP.zc.ZoneChiefEvalObj detailObj = (fz.pracP.zc.ZoneChiefEvalObj)detailScoreAL.get(i);
		pstmt = conn.prepareStatement("INSERT INTO egtzcds VALUES (?,?,?,?)");
		pstmt.setString(1,tempSeqno);
		pstmt.setString(2,detailObj.getScoreType());
		pstmt.setInt(3,detailObj.getScore());
		pstmt.setString(4,detailObj.getComm());
		pstmt.executeUpdate();
		pstmt.close();	
	}	


	
}else{//Update
	
	//update egtzcdm
	pstmt = conn.prepareStatement("UPDATE egtzcdm SET upddate=SYSDATE,upduser=? WHERE seqno = ?");
	pstmt.setString(1,userid);
	pstmt.setString(2,seqno);

	pstmt.executeUpdate();
	pstmt.close();	
	
	//update egtzcds,先delete再insert

	pstmt = conn.prepareStatement("DELETE egtzcds WHERE seqno=?");
	pstmt.setString(1,seqno);

	pstmt.executeUpdate();
	pstmt.close();	

	for(int i=0;i<detailScoreAL.size();i++){
		fz.pracP.zc.ZoneChiefEvalObj detailObj = (fz.pracP.zc.ZoneChiefEvalObj)detailScoreAL.get(i);
		pstmt = conn.prepareStatement("INSERT INTO egtzcds VALUES (?,?,?,?)");
		pstmt.setString(1,seqno);
		pstmt.setString(2,detailObj.getScoreType());
		pstmt.setInt(3,detailObj.getScore());
		pstmt.setString(4,detailObj.getComm());
		pstmt.executeUpdate();
		pstmt.close();	
	}	


	
	
	
}


conn.commit();

status = true;

	

}catch(SQLException e){
	status = false;
	errMsg += e.getMessage();
	try {
	//有錯誤時 rollback
		conn.rollback();
	} catch (SQLException e1) {
		errMsg += e1.getMessage();
	}
		
}catch(Exception e){
	status = false;
	errMsg += e.getMessage();

	try {
	//有錯誤時 rollback
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

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>更新 Zone Chief Evaluation 資料</title>
<link rel="stylesheet" type="text/css" href="../errStyle.css">
</head>
<body>
<form name="form1" method="post" action="edZC.jsp">
	<input type="hidden" name="fltd" value="<%=fltd%>">
	<input type="hidden" name="fltno" value="<%=fltno%>">
	<input type="hidden" name="sect" value="<%=sect%>">
	<input type="hidden" name="empno" value="<%=empno%>">
</form>
<script language="javascript" type="text/javascript">
	function goEdit(){
		document.form1.submit();
	}
</script>
<%
if(!status){
%>
	<div class="errStyle1">
	<br>
	更新失敗!!<br>
	ERROR:<%=errMsg%><br>
	<a href="javascript:goEdit()">Back</a><br>

</div>
<%

}else{
%>
<script language="javascript" type="text/javascript">
	alert("更新成功!!");
	document.form1.submit();
</script>
<%
}
%>
</body>
</html>
<%
}
%>
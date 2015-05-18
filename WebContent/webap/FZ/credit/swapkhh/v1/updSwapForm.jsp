<%@page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,java.sql.*,swap3ackhh.*,ci.db.*"%>
<%

//�M��cache
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

String userid = (String) session.getAttribute("userid");
String aEmpno = request.getParameter("aEmpno");
String rEmpno = request.getParameter("rEmpno");
String year = request.getParameter("year");
String month = request.getParameter("month");
String errMsg = "";
swap3ackhh.ApplyCheck ac = new swap3ackhh.ApplyCheck(aEmpno,rEmpno,year,month);
if(ac.isUnCheckForm()){	//���ӽг�|���֥i�A���i�ӽ�
%>
<p style="color:red;text-align:center ">�ӽЪ�(<%=aEmpno%>)&nbsp;
			�γQ����(<%=rEmpno%>)&nbsp;���ӽг�|���gED�֥i, <br>		
�t�Τ����z����.</p>
<%
}else if (ac.getAApplyTimes() >=3 ){ // �ӽЪ̷��ӽЦ��ư���3���A���i�ӽ�
%>
<p style="color:red;text-align:center ">�ӽЪ�(<%=aEmpno%>)&nbsp; 
			���ӽЦ��Ƥw�W�L�T��, <br>		
			�t�Τ����z����.</p>
<%

}else if (ac.getRApplyTimes() >=3 ){ // �Q���̷��ӽЦ��ư���3���A���i�ӽ�
%>
<p style="color:red;text-align:center ">�Q����(<%=rEmpno%>)&nbsp; 
			���ӽЦ��Ƥw�W�L�T��, <br>		
			�t�Τ����z����.</p>
<%

}else if(ac.isALocked()){//�ӽЪ̯Z����w,(���`���p���Ӥ��|�o�͡A��w�̬ݤ��촫�Z���\��ﶵ)
%>
<p style="color:red;text-align:center ">�ӽЪ�(<%=rEmpno%>)&nbsp; 
			�Z����w���A, <br>		
			�t�Τ����z����.<br>
			�]���Z����ݳ]�w�Z���}�񪬺A,��i�ϥδ��Z�\��^.</p>
<%
}else if(ac.isRLocked()){//�Q���̯Z����w
%>
<p style="color:red;text-align:center ">�Q����(<%=rEmpno%>)&nbsp; 
			�Z����w���A, <br>		
			�t�Τ����z����.<br>
			�]���Z����ݳ]�w�Z���}�񪬺A,��i�ϥδ��Z�\��^.</p>
<%
}else if(aEmpno.equals(rEmpno)){
%>
<p style="color:red;text-align:center ">�Q����(<%=rEmpno%>)���u���L��!!</p>

<%
}else if(userid != null){



String aSern = request.getParameter("aSern");
String aCname = request.getParameter("aCname");
String aGrps = request.getParameter("aGrps");
String aApplyTimes = request.getParameter("aApplyTimes");
String aQual = request.getParameter("aQual");

String rSern  = request.getParameter("rSern");
String rCname = request.getParameter("rCname");
String rGrps  = request.getParameter("rGrps");
String rApplyTimes = request.getParameter("rApplyTimes");
String rQual = request.getParameter("rQual");
String aSwapHr = request.getParameter("aSwapHr");
String rSwapHr = request.getParameter("rSwapHr");
String aSwapDiff = request.getParameter("aSwapDiff");
String rSwapDiff = request.getParameter("rSwapDiff");
String aPrjcr = request.getParameter("aPrjcr");
String rPrjcr = request.getParameter("rPrjcr");
String aSwapCr = request.getParameter("aSwapCr");
String rSwapCr = request.getParameter("rSwapCr");
String comments = request.getParameter("comments");

String[] aFdate =null;
String[] aFltno= null;
String[] aTripno = null;
String[] aFlyHrs = null;
String[] rFdate =null;
String[] rFltno= null;
String[] rTripno = null;
String[] rFlyHrs = null;

aFdate = request.getParameterValues("aFdate");
aFltno = request.getParameterValues("aFltno");
aTripno = request.getParameterValues("aTripno");
aFlyHrs = request.getParameterValues("aFlyHrs");

rFdate = request.getParameterValues("rFdate");
rFltno = request.getParameterValues("rFltno");
rTripno = request.getParameterValues("rTripno");
rFlyHrs = request.getParameterValues("rFlyHrs");

boolean updStatus = false;
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
String sql = null;
ci.db.ConnDB cn = new ci.db.ConnDB();
Driver dbDriver = null;
int formno = 0;
try {

cn.setORP3FZUserCP();

dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL() ,null);


//���oformno 2006/01/10 �̥ӽФ�����o�渹
	pstmt = conn.prepareStatement("SELECT Nvl(Max(formno),'" + year
				+ month + "0000')+1 newFormNo "
				+ "FROM fztformf WHERE station='KHH' and  substr(to_char(formno),1,6)=?");
	
	pstmt.setString(1 ,year + month);
	
	rs = pstmt.executeQuery();
	
	if ( rs.next() ) {
		formno = rs.getInt("newFormNo");
	}
				
	//�����~��rollback
	 conn.setAutoCommit(false);

//��insert �ӽг�Dtable
	pstmt = conn.prepareStatement("INSERT INTO fztformf VALUES "
			+"(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,"
			+"null,null,?,null,null,?,sysdate,null,null,'KHH')");
	   pstmt.setInt(1,formno);
	pstmt.setString(2,aEmpno);
	pstmt.setString(3,aSern);
	pstmt.setString(4,aCname);
	pstmt.setString(5,aGrps);
	pstmt.setString(6,aApplyTimes);
	pstmt.setString(7,aQual);
	pstmt.setString(8,rEmpno);
	pstmt.setString(9,rSern);
	pstmt.setString(10,rCname);
	pstmt.setString(11,rGrps);
	pstmt.setString(12,rApplyTimes);
	pstmt.setString(13,rQual);
	pstmt.setString(14,"N");
	pstmt.setString(15,aSwapHr);
	pstmt.setString(16,rSwapHr);
	pstmt.setString(17,aSwapDiff);
	pstmt.setString(18,rSwapDiff);
	pstmt.setString(19,aPrjcr);
	pstmt.setString(20,rPrjcr);
	pstmt.setString(21,aSwapCr);
	pstmt.setString(22,rSwapCr);
	pstmt.setString(23,comments);
	pstmt.setString(24,userid);
	
	pstmt.executeUpdate();				

//insert �ӽг����
	pstmt = conn.prepareStatement("insert INTO fztaplyf (formno,therole,empno,tripno,fdate,fltno,fly_hr,station) "
	 +"VALUES ("+formno+",?,?,?,?,?,?,'KHH')");


pstmt.clearBatch();
if(aFdate != null){

	for(int i=0;i<aFdate.length;i++){
		pstmt.setString(1,"A");
		pstmt.setString(2,aEmpno);
		pstmt.setString(3,aTripno[i]);
		pstmt.setString(4,aFdate[i]);
		pstmt.setString(5,aFltno[i]);
		pstmt.setString(6,aFlyHrs[i]);

		pstmt.addBatch(); 
		
	}
	pstmt.executeBatch(); 

}
	pstmt.clearBatch();

if(rFdate != null){
	for(int i=0;i<rFdate.length;i++){
		pstmt.setString(1,"R");
		pstmt.setString(2,rEmpno);
		pstmt.setString(3,rTripno[i]);
		pstmt.setString(4,rFdate[i]);
		pstmt.setString(5,rFltno[i]);
		pstmt.setString(6,rFlyHrs[i]);
		pstmt.addBatch();
	}
	 pstmt.executeBatch();


}


	
pstmt.clearBatch();
conn.commit();
updStatus = true;
//�g�Jlog

fz.writeLog wl = new fz.writeLog();
wl.updLog(userid, request.getRemoteAddr(),request.getRemoteHost(), "FZ285K");

} catch (SQLException e) {
updStatus = false;
	//�����~��rollback
	errMsg += e.toString();
	try {conn.rollback();} catch (SQLException e1) {errMsg += e1.toString();}
//	System.out.print(new java.util.Date()+" �ӽг�"+formno+"��s���ѡG"+e.toString());

	ci.tool.WriteLog wl2 = new ci.tool.WriteLog("/apsource/csap/projfz/webap/Log/fzFormLogf.txt");
	wl2.WriteFile(new java.util.Date()+"\t"+userid+"\t �ӽг�"+formno+"��s���ѡG"+e.toString());
	
	
} catch (Exception e) {
updStatus = false;
errMsg += e.toString();
	//�����~��rollback
	try {conn.rollback();} catch (SQLException e1) {errMsg += e1.toString();}
	//System.out.print(e.toString());

	ci.tool.WriteLog wl2 = new ci.tool.WriteLog("/apsource/csap/projfz/webap/Log/fzFormLogf.txt");
	wl2.WriteFile(new java.util.Date()+"\t"+userid+"\t �ӽг�"+formno+"��s���ѡG"+e.toString());

} finally {
	if ( rs != null ) try {
		rs.close();
	} catch (SQLException e) {}
	if ( pstmt != null ) try {
		pstmt.close();
	} catch (SQLException e) {}
	if ( conn != null ) try {
		conn.close();
	} catch (SQLException e) {}

}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="swap.css" rel="stylesheet" type="text/css">
</head>
<body>
<div style="color:red;text-align:left;font-family:Verdana;font-size:10pt;background-color:#CCFFFF;padding:2pt;padding-left:50pt;line-height:2">
<%
if(updStatus){
%>
<br>
�ӽг榨�\�e�X!!<br>
<br>
  <span style="color:blue">1. �����Z�ӽг滼�X�ɶ��Y��17:00�e�A���Z�@�~�N���Ѥu�@�駹���A�Y��17:00�Ỽ�X�A�h���U�@�u�@��(�Ұ��餣��u�@��)�����C
  <br>
  <br>
  2. �L�ץӽг榨�\�P�_�A���������|�ǰe��T��ӤH�����H�c(�оA�ɫO���H�c�i�ήe�q)�A�b������q���e�A�L�k���X�ĤG���ӽг�C</span>  <br>
  <br>
  <a href="swapRd.jsp" style="text-decoration:underline "><span style="color:#0000FF">�d�ߥӽг�O��</span></a>
</span><br>

<%}else{
%>
�t�Φ��L���A�еy��A��<br>
<%
out.print(errMsg);
}
%>
</div>
</body>
</html>
<%
}//end of has session
else if(userid == null){
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
}
%>
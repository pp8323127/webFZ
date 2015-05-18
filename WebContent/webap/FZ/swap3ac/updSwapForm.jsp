<%@page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,java.sql.*,swap3ac.*,ci.db.*"%>
<%

//2011/12/07 因失常單 新增
response.setHeader("Pragma","no-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0); //prevents caching at the proxy server    
//2011/12/07 因失常單 新增

String userid = (String) session.getAttribute("userid");
String aEmpno = request.getParameter("aEmpno");
String rEmpno = request.getParameter("rEmpno");
String year = request.getParameter("year");
String month = request.getParameter("month");
/**換班當超過上限問題,由頁面再檢測一次20130325**/
boolean status = false;
swap3ac.ApplyCheck ac1 = new swap3ac.ApplyCheck();
ac1.SelectDateAndCount();
if( ac1.isLimitedDate())
{//非工作日
	status = false;
%>
	<p style="color:red;text-align:center ">系統目前不受理換班，請於<%=ac1.getLimitenddate()%>後開始遞件<BR>可能原因為：1.例假日2.緊急事故(颱風)
	</p>
<%
}
else if( ac1.isOverMax())
{ //超過處理上限
	status = false;
%>
	<p style="color:red;text-align:center ">已超過系統單日處理上限！</p>
<%	
}else{
	status = true;
}
//************************************
swap3ac.ApplyCheck ac = new swap3ac.ApplyCheck(aEmpno,rEmpno,year,month);
if(ac.isUnCheckForm()){	//有申請單尚未核可，不可申請
%>
<p style="color:red;text-align:center ">申請者(<%=aEmpno%>)&nbsp;
			或被換者(<%=rEmpno%>)&nbsp;有申請單尚未經ED核可, <br>		
系統不受理遞單.</p>
<%
}else if (ac.getAApplyTimes() >=3 ){ // 申請者當月申請次數高於3次，不可申請
%>
<p style="color:red;text-align:center ">申請者(<%=aEmpno%>)&nbsp; 
			當月申請次數已超過三次, <br>		
			系統不受理遞單.</p>
<%

}else if (ac.getRApplyTimes() >=3 ){ // 被換者當月申請次數高於3次，不可申請
%>
<p style="color:red;text-align:center ">被換者(<%=rEmpno%>)&nbsp; 
			當月申請次數已超過三次, <br>		
			系統不受理遞單.</p>
<%

}else if(ac.isALocked()){//申請者班表鎖定,(正常狀況應該不會發生，鎖定者看不到換班的功能選項)
%>
<p style="color:red;text-align:center ">申請者(<%=rEmpno%>)&nbsp; 
			班表為鎖定狀態, <br>		
			系統不受理遞單.<br>
			（換班雙方需設定班表為開放狀態,方可使用換班功能）.</p>
<%
}else if(ac.isRLocked()){//被換者班表鎖定
%>
<p style="color:red;text-align:center ">被換者(<%=rEmpno%>)&nbsp; 
			班表為鎖定狀態, <br>		
			系統不受理遞單.<br>
			（換班雙方需設定班表為開放狀態,方可使用換班功能）.</p>
<%
}else if(aEmpno.equals(rEmpno)){
%>
<p style="color:red;text-align:center ">被換者(<%=rEmpno%>)員工號無效!!</p>

<%
}else if(userid != null && status){



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
ConnDB cn = new ConnDB();
Driver dbDriver = null;
int formno = 0;
try {
	//                    User connection pool to FZ

cn.setORP3FZUserCP();

dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL() ,null);

/*
cn.setORT1FZUser();
java.lang.Class.forName(cn.getDriver());
conn = DriverManager.getConnection(cn.getConnURL(), "fzap",
	"FZ921002");
*/

//取得formno 2006/01/10 依申請月份取得單號
	pstmt = conn.prepareStatement("SELECT Nvl(Max(formno),'" + year
				+ month + "0000')+1 newFormNo "
				+ "FROM fztform WHERE substr(to_char(formno),1,6)=?");
	
	pstmt.setString(1 ,year + month);
	
	rs = pstmt.executeQuery();
	
	if ( rs.next() ) {
		formno = rs.getInt("newFormNo");
	}
				
	//有錯誤時rollback
	 conn.setAutoCommit(false);

//先insert 申請單主table
	pstmt = conn.prepareStatement("INSERT INTO fztform VALUES "
			+"(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,"
			+"null,null,?,null,null,?,sysdate,null,null,'TPE')");
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
	
//insert 申請單明細
	pstmt = conn.prepareStatement("insert INTO fztaply(formno,therole,empno,tripno,fdate,fltno,fly_hr) "
	 +"VALUES ("+formno+",?,?,?,?,?,?)");
//	 +"VALUES ("+formno+",therole,empno,tripno,fdate,fltno,fly_hr)");

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
//寫入log

fz.writeLog wl = new fz.writeLog();
wl.updLog(userid, request.getRemoteAddr(),request.getRemoteHost(), "FZ2851");

} catch (SQLException e) {
updStatus = false;
	//有錯誤時rollback
	try {conn.rollback();} catch (SQLException e1) {}
//	System.out.print(new java.util.Date()+" 申請單"+formno+"更新失敗："+e.toString());
	ci.tool.WriteLog wl2 = new ci.tool.WriteLog("/apsource/csap/projfz/webap/Log/fzFormLog.txt");
	wl2.WriteFile(new java.util.Date()+"\t"+userid+"\t 申請單"+formno+"更新失敗："+e.toString());
	
} catch (Exception e) {
updStatus = false;
	//有錯誤時rollback
	try {conn.rollback();} catch (SQLException e1) {}
	//System.out.print(e.toString());
	ci.tool.WriteLog wl2 = new ci.tool.WriteLog("/apsource/csap/projfz/webap/Log/fzFormLog.txt");
	wl2.WriteFile(new java.util.Date()+"\t"+userid+"\t 申請單"+formno+"更新失敗："+e.toString());
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
申請單成功送出!!<br>
<br>
  <span style="color:blue">1. 此換班申請單遞出時間若於16:00前，換班作業將於當天工作日完成，若於16:00後遞出，則為下一工作日(例假日不算工作日)完成。
  <br>
<!--   2. 因簽派系統(SBS)與班表資訊網為不同系統，換班資料需經由程式轉檔(至少3~4小時後)始能於班表資訊網中查詢換班後新任務。
 -->  <br>
  2. 無論申請單成功與否，派遣部均會傳送資訊於個人全員信箱(請適時保持信箱可用容量)，在未收到通知前，無法遞出第二次申請單。</span>  <br>
  <br>
  <a href="swapRd.jsp" style="text-decoration:underline "><span style="color:#0000FF">查詢申請單記錄</span></a>
</span><br>

<%}else{
%>
系統忙碌中，請稍後再試
<%

}
%>
</div>
</body>
</html>
<%
}//end of has session
else if(userid == null){
response.sendRedirect("../sendredirect.jsp");
}
%>
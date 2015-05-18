<%@page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,java.sql.*,swap3ac.*,ci.db.*"%>
<%

//清掉cache
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

String userid = (String) session.getAttribute("userid");
String aEmpno = request.getParameter("aEmpno"); 
String rEmpno = request.getParameter("rEmpno");
String year = request.getParameter("year");
String month = request.getParameter("month");
String asno = request.getParameter("asno");
String rsno = request.getParameter("rsno");
String source = request.getParameter("source");
String rcount = "Y";
String rcomm = "N/A";
//out.print("source >> "+ source+" aEmpno >>"+ aEmpno + " rEmpno >> "+ rEmpno + " year >> "+ year + " month >> "+ month+ " asno >> "+ asno +" rsno >> "+ rsno+"<br>");
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
//************************************************************************
String displaystr = "";
String r_isfullattendance = "";
if("normal".equals(source))
{
	//被換者選擇三次換班權利,需檢核是否全勤
	CheckFullAttendance rcs = new CheckFullAttendance(rEmpno, year+month);
	r_isfullattendance = rcs.getCheckMonth();
	if(!"Y".equals(r_isfullattendance))
	{
		displaystr = r_isfullattendance;
	}
}
//***********************************************************************

swap3ac.ApplyCheck ac = new swap3ac.ApplyCheck(aEmpno,rEmpno,year,month);
if(ac.isUnCheckForm())
{	//有申請單尚未核可，不可申請
%>
<p style="color:red;text-align:center ">申請者(<%=aEmpno%>)&nbsp;
			或被換者(<%=rEmpno%>)&nbsp;有申請單尚未經ED核可, <br>		
系統不受理遞單.</p>
<%
}
else if("normal".equals(source) && !"Y".equals(r_isfullattendance) )
{
%>
	<p  class="errStyle1"><%=displaystr%> </p>
<%
}
else if ("normal".equals(source) && ac.getRApplyTimes() >=3 )
{ // 被換者當月申請次數高於3次，不可申請
%>
<p style="color:red;text-align:center ">被換者(<%=rEmpno%>)&nbsp; 
			當月申請次數已超過三次, <br>		
			系統不受理遞單.</p>
<%
}
else if(aEmpno.equals(rEmpno))
{
%>
<p style="color:red;text-align:center ">被換者(<%=rEmpno%>)員工號無效!!</p>
<%
}
else if(userid != null && status)
{
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

if("credit".equals(source))
{
	rcount= "N";
	rcomm = rsno;
}
else
{
	rsno = "0";
}


boolean updStatus = false;
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
String sql = null;
Driver dbDriver = null;
int formno = 0;
try 
{
	ConnectionHelper ch = new ConnectionHelper();
    conn = ch.getConnection();  
	//有錯誤時rollback
	conn.setAutoCommit(false);
	//取得formno 2006/01/10 依申請月份取得單號
	pstmt = conn.prepareStatement("SELECT Nvl(Max(formno),'" + year
				+ month + "0000')+1 newFormNo "
				+ "FROM fztbform WHERE substr(to_char(formno),1,6)=?");
	
	pstmt.setString(1 ,year + month);
	
	rs = pstmt.executeQuery();
	
	if ( rs.next() )
	{
		formno = rs.getInt("newFormNo");
	}

	pstmt = null;
				
    //先insert 申請單主table
//sql = " INSERT INTO fztbform (formno,aempno,asern,acname,agroups,atimes,aqual,rempno,rsern,rcname,rgroups,rtimes,rqual,chg_all,aswaphr,rswaphr,aswapdiff,rswapdiff,apch,rpch,attlhr,rttlhr,overpay,over_hr,crew_comm,ed_check,comments,newuser,newdate,checkuser,checkdate,station,acount,acomm,rcount,rcomm) values ("+formno+",'"+aEmpno+"','"+aSern+"','"+aCname+"','"+aGrps+"',"+aApplyTimes+",'"+aQual+"','"+rEmpno+"','"+rSern+"','"+rCname+"','"+rGrps+"','"+rApplyTimes+"','"+rQual+"','N','"+aSwapHr+"','"+rSwapHr+"','"+aSwapDiff+"','"+rSwapDiff+"','"+aPrjcr+"','"+rPrjcr+"','"+aSwapCr+"','"+rSwapCr+"',null,null,'"+comments+"',null,null,'"+userid+"',sysdate,null,null,'TPE','N','"+asno+"','"+rcount+"','"+rcomm+"') ";

//out.print(sql+"<br>");

	sql = " INSERT INTO fzdb.fztbform (formno,aempno,asern,acname,agroups,atimes,aqual,rempno,rsern,rcname,rgroups,rtimes,rqual,chg_all,aswaphr,rswaphr,aswapdiff,rswapdiff,apch,rpch,attlhr,rttlhr,overpay,over_hr,crew_comm,ed_check,comments,newuser,newdate,checkuser,checkdate,station,acount,acomm,rcount,rcomm) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,null,null,?,null,null,?,sysdate,null,null,'TPE','N',?,?,?) ";

	pstmt = conn.prepareStatement(sql);	
	int j = 1;
	pstmt.setInt(j,formno);
	pstmt.setString(++j,aEmpno);
	pstmt.setString(++j,aSern);
	pstmt.setString(++j,aCname);
	pstmt.setString(++j,aGrps);
	pstmt.setString(++j,aApplyTimes);
	pstmt.setString(++j,aQual);
	pstmt.setString(++j,rEmpno);
	pstmt.setString(++j,rSern);
	pstmt.setString(++j,rCname);
	pstmt.setString(++j,rGrps);
	pstmt.setString(++j,rApplyTimes);
	pstmt.setString(++j,rQual);
	pstmt.setString(++j,"N");
	pstmt.setString(++j,aSwapHr);
	pstmt.setString(++j,rSwapHr);
	pstmt.setString(++j,aSwapDiff);
	pstmt.setString(++j,rSwapDiff);
	pstmt.setString(++j,aPrjcr);
	pstmt.setString(++j,rPrjcr);
	pstmt.setString(++j,aSwapCr);
	pstmt.setString(++j,rSwapCr);
	pstmt.setString(++j,comments);
	pstmt.setString(++j,userid);
	pstmt.setString(++j,asno);
	pstmt.setString(++j,rcount);
	pstmt.setString(++j,rcomm);	
	pstmt.executeUpdate();		
	pstmt.clearBatch();

	pstmt = null;
    //insert 申請單明細
	pstmt = conn.prepareStatement("insert INTO fzdb.fztbaply(formno,therole,empno,tripno,fdate,fltno,fly_hr) "
	 +"VALUES ("+formno+",?,?,?,?,?,?)");

	if(aFdate != null)
	{
		for(int i=0;i<aFdate.length;i++)
		{
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
	if(rFdate != null)
	{
		for(int i=0;i<rFdate.length;i++)
		{
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
	
	pstmt = null;
	//remark formno for egtcrdt
	sql = "update egdb.egtcrdt set formno = ?, used_ind = 'Y', upduser = 'SYS', upddate = sysdate where (sno = ? or sno = ?)";
	pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1,formno);
    pstmt.setInt(2,Integer.parseInt(asno));
    pstmt.setInt(3,Integer.parseInt(rsno));
	pstmt.executeUpdate(); 

	conn.commit();
	updStatus = true;
    //寫入log
	fz.writeLog wl = new fz.writeLog();
	wl.updLog(userid, request.getRemoteAddr(),request.getRemoteHost(), "FZ2852");
} 
catch (SQLException e) 
{
updStatus = false;
	//有錯誤時rollback
	try {conn.rollback();} catch (SQLException e1) {}
//	System.
out.print(new java.util.Date()+" 申請單"+formno+"更新失敗："+e.toString());
	ci.tool.WriteLog wl2 = new ci.tool.WriteLog("/apsource/csap/projfz/webap/Log/fzFormLog.txt");
	wl2.WriteFile(new java.util.Date()+"\t"+userid+"\t 積點申請單"+formno+"更新失敗："+e.toString());
	
} catch (Exception e) {
updStatus = false;
	//有錯誤時rollback
	try {conn.rollback();} catch (SQLException e1) {}
	//System.
	out.print(e.toString());
	ci.tool.WriteLog wl2 = new ci.tool.WriteLog("/apsource/csap/projfz/webap/Log/fzFormLog.txt");
	wl2.WriteFile(new java.util.Date()+"\t"+userid+"\t 積點申請單"+formno+"更新失敗："+e.toString());
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
  <a href="../../swap3ac/swapRd.jsp" style="text-decoration:underline "><span style="color:#0000FF">查詢申請單記錄</span></a>
</span><br>

<%
}
else
{
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
else if(userid == null)
{
response.sendRedirect("../../sendredirect.jsp");
}
%>
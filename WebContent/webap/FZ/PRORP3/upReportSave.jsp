<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*,
				fz.pr.orp3.*,
				ci.db.ConnDB,
				java.net.URLEncoder,ci.db.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
//座艙長報告--送出報告
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Send Report(存成草稿)</title>
<link href="style2.css" rel="stylesheet" type="text/css">
<script src="../../MT/js/subWindow.js" language="javascript" type="text/javascript"></script>

<script language="javascript" src="changeAction.js" type="text/javascript"></script>
<script  language="javascript"  type="text/javascript">
function warn(){
/*var msg = "報告送出前，請確認各組員的考評項目是否已經輸入。\n分數為粗體紅字者，一定要輸入考評項目。\n(請點選組員的序號或分數來評分)\n\n報告一經送出，即不得更改";
alert(msg);
*/
var msg = "請確認，本班次已無任何異常事項，並立即送出報告?\n\n";
msg +="1.若本班次無異常事項，請按「確定」，送出報告\n"
msg +="2.若本班次有任何異常事項，請按取消之後，點選Edit Flt Irregularity.\n";
	if( confirm(msg)){
		return true;
	}
	else{
			return false;

	}

}
</script>
</head>

<body>
<div align="center">
<%
String fdate = request.getParameter("fdate");
//取得考績年度
String GdYear = fz.pr.orp3.GdYear.getGdYear(fdate);

//String GdYear = "2005";//request.getParameter("GdYear");
String purserEmpno	= request.getParameter("purserEmpno");
String psrsern		= request.getParameter("psrsern");
String psrname		= request.getParameter("psrname");

String fltno = request.getParameter("fltno").trim();
String sect = request.getParameter("dpt").trim()+request.getParameter("arv").trim();
String acno = request.getParameter("acno");
String ispart2 = request.getParameter("ispart2");
//如果是Part 2 link過來則不須檢查
if(ispart2 == null){
	//新增判斷score = 1, 2, 3, 9, 10是否均已輸入GDDetail(考核項目)
	String[] sern = request.getParameterValues("sern");
	String[] score = request.getParameterValues("score");
	CheckGD cgd = new CheckGD();
	//return:0 OK, return:sern(20306) 有組員為記錄考核明細
	String chkr = cgd.doCheck(fdate,fltno,sect,sern,score);
	String astring = "組員序號 "+ chkr +" 須記錄考核項目 !";
	if(!chkr.equals("0")){
	%>
		<script>
			alert("<%=astring%>" );
			history.back(-1);
		</script>
	<%	
	}
	//判斷結束
}

String ModifyPage="edReportModify.jsp?fdate="+fdate+"&fltno="+fltno+"&dpt="+
				request.getParameter("dpt").trim()+"&arv="+request.getParameter("arv").trim()
				+"&GdYear="+GdYear;
				
String LingPar = "edFltIrr.jsp?fdate="+fdate+"&fltno="+fltno+"&dpt="+request.getParameter("dpt").trim()+"&arv="+request.getParameter("arv")+"&GdYear="+GdYear+"&acno="+acno;


Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet rs = null;
boolean t = false;
String goPage= "";
int rowcount = 0;
String sql = "";
String errMsg = "";
boolean status = false;
try{

ConnDB cn = new ConnDB();
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY); 
////查詢是否已經有資料，若有，則送出報告...若無，則回到 flightcrew.jsp
/*
sql = "SELECT Count(*) count FROM egtcflt WHERE fltd = To_Date('"+ fdate+"','yyyy/mm/dd') "+
	  "and fltno='"+fltno+"' and sect='"+sect+"'" ;
rs = stmt.executeQuery(sql);
if(rs.next()) rowcount = rs.getInt("count");
if(rowcount == 0) {
	goPage = "flightcrew.jsp?fyy="+fdate.substring(0,4)+"&fmm="+fdate.substring(5,7)+"&fdd="+
	fdate.substring(8)+"&fltno="+fltno+"&GdYear="+GdYear+"&acno=null";
}
*/
sql = "update egtcflt set upd='Y' where fltd=to_date('"+ fdate + "','yyyy/mm/dd')" +
      " and fltno='"+ fltno +"' and sect ='"+ sect +"' and psrempn ='" +purserEmpno +
	  "' and psrsern ='"+psrsern+"'" ;

stmt.executeQuery(sql);
status = true;

}
catch (Exception e)
{
	 errMsg = e.toString();
	  out.print(errMsg);
}
finally
{
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}


//TODO  update egtgddt
//檢查航班資料
fz.pr.orp3.CheckFltData cflt = new fz.pr.orp3.CheckFltData(fdate, fltno, sect,purserEmpno);
if( status ){
	
	
	try {
		cflt.RetrieveData();	
		status = true;
	} catch (SQLException e) {
		errMsg= e.toString() ;
		System.out.println(errMsg);
	} catch (Exception e) {
		errMsg= e.toString() ;
		System.out.println(errMsg);
	}
	
	if(cflt.isHasFltCrewData()){//有 Flight Crew資料
		goPage = "edReportModify.jsp?fdate="+fdate+"&fltno="+fltno+"&dpt="+
				request.getParameter("dpt").trim()+"&arv="+request.getParameter("arv").trim()
				+"&GdYear="+GdYear;
	}else{
		goPage = "flightcrew.jsp?fyy="+fdate.substring(0,4)+"&fmm="+fdate.substring(5,7)+"&fdd="+
		fdate.substring(8)+"&fltno="+fltno+"&GdYear="+GdYear+"&acno=null";	
	}
	
	
}else{
	out.println(errMsg);
}

%>
  <span class="purple_txt"><strong>報告已儲存，可再度修改。<br>
  <br>
 Report is Saved and can be modified!! <br>
  </strong></span>

  <form name="form1" method="post" action="upReportSendFltIrr.jsp"  onSubmit="return warn()">
    <blockquote>
      <blockquote>
        <blockquote>
          <blockquote>
            <blockquote>
              <blockquote>
                <blockquote>
                  <p align="left">

              <input name="Submit" type="button" class="addButton" value="Modify Report" onClick="preview('form1','<%=goPage%>')">

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br><br>
	                <input type="button" value="Edit Flt Irregularity" class="addButton" onClick="preview('form1','<%=LingPar%>')">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                <br><br>
					
					<input type="button" value="View Report" class="addButton" onClick="javascript:window.open('PURreport_print.jsp?fdate=<%=fdate%>&fltno=<%=fltno%>&section=<%=sect%>')" > <br><br>
	                <input type="submit" value="Send Report" class="delButon" >
					 <br><br>
                  </p>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
	<input type="hidden" name="fdate" value="<%=fdate%>">
    <input type="hidden" name="fltd" value="<%=fdate%>">
        <input type="hidden" name="fltno" value="<%=fltno%>">		
		<input type="hidden" name="section" value="<%=sect%>">
        <input type="hidden" name="dpt" value="<%=request.getParameter("dpt").trim()%>">		
		 <input type="hidden" name="arv" value="<%=request.getParameter("arv").trim()%>">	
 		 <input type="hidden" name="purserEmpno" value="<%=purserEmpno%>">	
		 <input type="hidden" name="psrname" value="<%=psrname%>">	
 		 <input type="hidden" name="psrsern" value="<%=psrsern%>">
		 <input type="hidden" name="pur" value="<%=purserEmpno%>">
		 	  </form>
  <span class="purple_txt"><strong> <br>
 <br>
  </strong></span></div>
</body>
</html>
<script>
<%
//if(!goPage.equals("")){
//egtcflt中尚未有紀錄....轉頁至flightcrew，進入PartI  Report
if(!cflt.isHasFltCrewData()){
	out.print("alert('報告尚未填寫完畢，不得送出!!\\n\\n請按「確定」進入PartI Report Edit');"
			+"self.location='"+ goPage+"';");
}
else{//egtcflt中已經有紀錄....
%>
alert("報告儲存成功!!");
<%
}
%>
</script>
<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*,fz.psfly.*,fz.projectinvestigate.*,	fz.pracP.*,ci.db.ConnDB,java.net.URLEncoder,ci.db.*,eg.flightcheckitem.*"%>
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
<style type="text/css">
body,form,input,select,textarea{
	font-family:Verdana, Arial, Helvetica, sans-serif;
	font-size:10pt;
}

</style>
<script src="../../MT/js/subWindow.js" language="javascript" type="text/javascript"></script>

<script language="javascript" src="changeAction.js" type="text/javascript"></script>

</head>

<body>
<%
String fdate = request.getParameter("fdate");
String stdDt 	= request.getParameter("stdDt");
//取得考績年度
String GdYear = fz.pracP.GdYear.getGdYear(fdate);

//String GdYear = "2005";//request.getParameter("GdYear");
String purserEmpno	= request.getParameter("purserEmpno");
String psrsern		= request.getParameter("psrsern");
String psrname		= request.getParameter("psrname");

String fltno = request.getParameter("fltno").trim();
String sect = request.getParameter("dpt").trim()+request.getParameter("arv").trim();
String acno = request.getParameter("acno");
String ispart2 = request.getParameter("ispart2");
String[] empno = request.getParameterValues("empno");
String[] duty = request.getParameterValues("duty");
String[] sern = request.getParameterValues("sern");
String[] score = request.getParameterValues("score");

//如果是Part 2 link過來則不須檢查
if(ispart2 == null)
{
	//新增判斷score = 1, 2, 3, 9, 10是否均已輸入GDDetail(考核項目)
	CheckGD cgd = new CheckGD();
	//return:0 OK, return:sern(20306) 有組員為記錄考核明細
	String chkr = cgd.doCheck(fdate,fltno,sect,sern,score);
	String astring = "組員序號 "+ chkr +" 須記錄考核項目 !";
	if(!chkr.equals("0"))
	{
	%>
		<script>
			alert("<%=astring%>" );
			history.back(-1);
		</script>
	<%	
	}
	//判斷結束

	//越洋線檢查是否有三名KPI分數
	/*
	if (!fltno.equals("0025") && !fltno.equals("0026") && !fltno.equals("0027") && !fltno.equals("0028") && fltno.substring(0,2).equals("00"))
	{
		int kpi_cnt = cgd.doKPICheck(fdate,fltno,sect);
		if(kpi_cnt<3)
		{
	*/
	%>
			<!--<script>
				alert("請於每趟抽問3位組員安全指標項目，並將執行結果誌入組員考核之KPI內。");
			</script>
			-->
	<%	
	/*
		}	
	}
	*/

	//判斷ZC
	fz.pracP.CheckZC chkZC = new fz.pracP.CheckZC(fdate,fltno,sect,purserEmpno,empno,duty);	
	chkZC.SelectData();
	
	if(chkZC.isHasZC())
	{	//本班有ZC
		if(!chkZC.isZCEvaluated())
		{
		%>
			<script>
				alert("必須輸入Zone Chief (員工號：<%=chkZC.getZcEmpno()%>) 之考評." );
				history.back(-1);
			</script>
		<%	
		}
	}
}

String ModifyPage="edReportModify.jsp?sect="+sect+"&fdate="+fdate+"&fltno="+fltno+"&dpt="+
				request.getParameter("dpt").trim()+"&arv="+request.getParameter("arv").trim()
				+"&GdYear="+GdYear;
				
String LingPar = "edFltIrr.jsp?sect="+sect+"&fdate="+fdate+"&fltno="+fltno+"&dpt="+request.getParameter("dpt").trim()+"&arv="+request.getParameter("arv")+"&GdYear="+GdYear+"&acno="+acno;

String LingPar3 = "edFltIrr_3.jsp?sect="+sect+"&fdate="+fdate+"&fltno="+fltno+"&dpt="+request.getParameter("dpt").trim()+"&arv="+request.getParameter("arv")+"&GdYear="+GdYear+"&acno="+acno;

String LingPar4 = "edFltIrr_4.jsp?sect="+sect+"&fdate="+fdate+"&fltno="+fltno+"&dpt="+request.getParameter("dpt").trim()+"&arv="+request.getParameter("arv")+"&GdYear="+GdYear+"&acno="+acno;

String LingPar5 = "edFltIrr_5.jsp?sect="+sect+"&fdate="+fdate+"&fltno="+fltno+"&dpt="+request.getParameter("dpt").trim()+"&arv="+request.getParameter("arv")+"&GdYear="+GdYear+"&acno="+acno;

String LingPar6 = "edFltIrr_6.jsp?sect="+sect+"&fdate="+fdate+"&fltno="+fltno+"&dpt="+request.getParameter("dpt").trim()+"&arv="+request.getParameter("arv")+"&GdYear="+GdYear+"&acno="+acno;




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
try
{

ConnDB cn = new ConnDB();
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY); 
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
fz.pracP.CheckFltData cflt = new fz.pracP.CheckFltData(fdate, fltno, sect,purserEmpno);
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
	}
	else
	{
		goPage = "flightcrewZ.jsp?sect="+sect+"&fyy="+fdate.substring(0,4)+"&fmm="+fdate.substring(5,7)+"&fdd="+fdate.substring(8)+"&fltno="+fltno+"&GdYear="+GdYear+"&acno="+acno;	
	}	
	
}
else
{
	out.println(errMsg);
}

//out.print(goPage);

//新增查核項目
eg.flightcheckitem.CheckItemKeyValue ckKey = new eg.flightcheckitem.CheckItemKeyValue();
	ckKey.setFltd(fdate);
	ckKey.setFltno(fltno);
	ckKey.setSector(sect);
	ckKey.setPsrEmpn(purserEmpno);
eg.flightcheckitem.CheckItemWithFlight ckhItemFlt = null;
ArrayList al = null;
try{
	ckhItemFlt = new eg.flightcheckitem.CheckItemWithFlight(ckKey);
	
	al = ckhItemFlt.getChkItemAL();
	
	
}catch(Exception e){}
//********************************************************************
//是否需填專案調查
boolean pjneedfill = false;
PRPJIssue pj = new PRPJIssue();
try
{
	pj.getPRProj_no(fdate, fltno, sect.substring(0,3), sect.substring(3),purserEmpno,"","") ;
	//pj.getPRProj_no("2008/11/25", "0006", "TPE", "TPE",sGetUsr,"","") ;
	//out.println((String)fdateAL.get(i)+"  "+fltnoAL.get(i)+"  "+((String)sectAL.get(i)).substring(0,3)+"  "+((String)sectAL.get(i)).substring(3)+"  "+sGetUsr);
	if(pj.getProj_noAL().size()>0)
	{
		pjneedfill = true;
	}
}
catch(Exception e){}
//********************************************************************
//是否需填自我督察
boolean needfill = false;
PRSFlyIssue psf = new PRSFlyIssue();
try
{
	psf.getPsflyTopic_no(fdate, fltno, sect.substring(0,3), sect.substring(3),purserEmpno,"","") ;
	//psf.getPsflyTopic_no("2008/11/25", "0006", "TPE", "TPE",sGetUsr,"","") ;
	//out.println((String)fdateAL.get(i)+"  "+fltnoAL.get(i)+"  "+((String)sectAL.get(i)).substring(0,3)+"  "+((String)sectAL.get(i)).substring(3)+"  "+sGetUsr);
	if(psf.getTopic_noAL().size()>0)
	{
		needfill = true;
	}
}
catch(Exception e){}
//********************************************************************
%>


  <form name="form1" method="post" action="upReportSendFltIrr.jsp"  onSubmit="return warn()">
  <table width="70%" cellpadding="0" cellspacing="1" style="border-collapse:collapse; " align="center">
<caption style="color:#FF0000;font-weight:bold;line-height:1;text-align:center;padding-bottom:0.5em;padding-top:0.5em;">
  報告已儲存，可再度修改。  <br>
 Report is Saved and can be modified!!<br>
</caption>
<tr>
  <td width="13%" height="35">&nbsp;</td>
	<td width="87%" style="text-align:left;"><span class="txtblue">組員相關 :</span> &nbsp;
	  <input name="Submit" type="button"  value="組員考核" onClick="preview('form1','<%=goPage%>')" style="background-color:#F0F8FF; ">&nbsp;&nbsp;&nbsp;<input type="button" value="組員事宜"  onClick="preview('form1','<%=LingPar3%>')" style="background-color:#F0F8FF; ">		
	</td>
</tr>
<tr>
  <td width="13%" height="35">&nbsp;</td>
	<td width="87%" style="text-align:left;"><span class="txtblue">客艙動態 : </span>&nbsp;
		<input type="button" value="班機經常事務"  onClick="preview('form1','<%=LingPar%>')" style="background-color:#F0F8FF; ">&nbsp;&nbsp;&nbsp;<input name="Submit" type="button"  value="設備\系統" onClick="preview('form1','<%=LingPar4%>')" style="background-color:#F0F8FF; ">&nbsp;&nbsp;&nbsp;<input name="Submit" type="button"  value="客艙服務" onClick="preview('form1','<%=LingPar5%>')" style="background-color:#F0F8FF; ">&nbsp;&nbsp;&nbsp;<input type="button" value="異常報告"  onClick="preview('form1','<%=LingPar6%>')" style="background-color:#F0F8FF; ">
	</td>
</tr>

<%
if(al != null | pjneedfill == true | needfill == true)
{
%>
<tr>
  <td height="33" >&nbsp;</td>
	<td style="background-color:#FFFFCC;text-align:left;color:#FF0000;font-weight:bold; ">
本班次有以下附加報告，需完成輸入才能繳交報告.
	</td>
</tr>
<%
}	

if(al != null)
{
%>
	<tr >
	  <td >&nbsp;</td>
		<td style="background-color:#FFFFCC;text-align:left; ">

<%

		for(int i=0;i<al.size();i++){
			eg.flightcheckitem.CheckMainItemObj obj 
					= (eg.flightcheckitem.CheckMainItemObj)al.get(i);
			StringBuffer str =new StringBuffer("輸入</span>");
			if(!obj.isHasCheckData()){
				str.insert(0,"<span style='color:red;'>尚未");
			}else{
				str.insert(0,"<span style='color:blue;'>已");
			}
		
%>
		<a href="javascript:editChkform('<%=obj.getSeqno()%>','<%=obj.getCheckRdSeq()%>',<%=obj.isHasCheckData()%>)">
		<img src="../images/layout_edit.gif" width="16" height="16" align="absmiddle" border="0" >&nbsp;<%=obj.getDescription()+" ("+str.toString()+") "%></a>
		<br>	
<%		
		}
%>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
	<a href="guide/chkItemInput.pdf" target="_blank"><img src="../images/folder_image.gif" width="16" height="16" border="0">(下載操作說明PDF檔)</a>
<%
	} 
%>
</td>
</tr>
<%
//專案調查/追蹤考核
if(pjneedfill == true)
{
	String proj_no = "";
	for(int k =0; k<pj.getProj_noAL().size(); k++)
	{
		proj_no = proj_no+","+pj.getProj_noAL().get(k);
	}

%>
	<tr>
	  <td >&nbsp;</td>
		<td style="background-color:#FFFFCC;text-align:left; ">
		 <a href="ProjInvestigation/edProj.jsp?sect=<%=sect%>&fltdt=<%=fdate%>&fltno=<%=fltno%>&proj_no=<%=proj_no.substring(1)%>&fleet=<%=pj.getFleet()%>&acno=<%=pj.getAcno()%>" target="_blank">
		 <img src="../images/layout_edit.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="Edit ProjInvestigation">專案調查/追蹤考核/事件回報/Safety Audit
		 </a>
</td>
</tr>
<%
}//if(pjneedfill == true)

if(needfill == true)
{
	String topic_no = "";
	for(int k =0; k<psf.getTopic_noAL().size(); k++)
	{
		topic_no = topic_no+","+psf.getTopic_noAL().get(k);
	}

%>
	<tr>
	  <td >&nbsp;</td>
		<td style="background-color:#FFFFCC;text-align:left; ">
		 <a href="PSFLY/edPSFLY.jsp?sect=<%=sect%>&fltdt=<%=fdate%>&fltno=<%=fltno%>&topic_no=<%=topic_no.substring(1)%>&fleet=<%=psf.getFleet()%>&acno=<%=psf.getAcno()%>" target="_blank">
		 <img src="../images/layout_edit.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="Edit PSFLY">自我督察
		 </a>
</td>
</tr>
<%
}//if(pjneedfill == true)
%>
<tr>
  <td height="51">&nbsp;</td>
	<td style="text-align:left;">
	<input type="button" value="View Report"   onClick="javascript:window.open('PURreport_print.jsp?fdate=<%=fdate%>&fltno=<%=fltno%>&section=<%=sect%>')"  style="background-color:#F0F8FF; ">
	</td>
</tr>    
<tr>
  <td>&nbsp;</td>
<td style="text-align:left;">
 <input type="submit" value="Send Report" style="background-color:#FFCCCC; " ></td>
</tr>  
</table>  
  <%
  //*****************************************************************************************
  %> 

		<input type="hidden" name="fdate" value="<%=fdate%>">
		<input type="hidden" name="stdDt" value="<%=stdDt%>">
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

<form name="chkForm"  method="post">
	<input type="hidden" name="seqno" id="seqno" >
	<input type="hidden" name="fltd" value="<%=fdate%>">
	<input type="hidden" name="fltno" value="<%=fltno%>">		
	<input type="hidden" name="sector" value="<%=sect%>">
	<input type="hidden" name="psrEmpn" value="<%=purserEmpno%>">	
	<input type="hidden" name="LingPar" value="<%=LingPar%>">
	<input type="hidden" name="goPage" value="<%=goPage%>">
	
	<input type="hidden" name="dpt" value="<%=request.getParameter("dpt").trim()%>">		
	<input type="hidden" name="arv" value="<%=request.getParameter("arv").trim()%>">	
	<input type="hidden" name="purserEmpno" value="<%=purserEmpno%>">	
	<input type="hidden" name="psrname" value="<%=psrname%>">	
	<input type="hidden" name="psrsern" value="<%=psrsern%>">
	<input type="hidden" name="pur" value="<%=purserEmpno%>">	
	<input type="hidden" name="checkRdSeq">

</form>

<script  language="javascript"  type="text/javascript">

function editChkform(seqno,checkRdSeq,edited)
{
	document.getElementById("seqno").value = seqno;
	if(edited)
	{
		document.chkForm.action="chkItem/ModChkItem.jsp";
		document.getElementById("checkRdSeq").value = checkRdSeq;
		
	}
	else
	{
		document.chkForm.action="chkItem/EditChkItem.jsp";
	}
	document.chkForm.target="_blank";
	document.chkForm.submit();
}

function warn()
{
	var msg = "請確認，本班次已無任何異常事項，並立即送出報告?\n\n";
	msg +="1.若本班次無異常事項，請按「確定」，送出報告\n"
	msg +="2.若本班次有任何異常事項，請按取消之後，點選Edit Flt Irregularity.\n";
	<%
	
	if(!ckhItemFlt.isHasCheckAllOrNoCheck())
	{
	%>
	alert("尚有查核項目未輸入,不得送出.");
	return false;
	<%	
	}
	else
	{
	%>
		if( confirm(msg))
		{
			return true;
		}
		else
		{
				return false;
		}	
	<%
	}
	%>	
}


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
</body>
</html>
<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*,fz.psfly.*,fz.projectinvestigate.*,	fz.pracP.*,ci.db.ConnDB,			java.net.URLEncoder,ci.db.*,eg.flightcheckitem.*,java.util.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
//�y�������i--�e�X���i
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Send Report(�s����Z)</title>
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
String stdDt = request.getParameter("stdDt");
out.println(stdDt);
//���o���Z�~��
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

//�p�G�OPart 2 link�L�ӫh�����ˬd
if(ispart2 == null)
{
	//�s�W�P�_score = 1, 2, 3, 9, 10�O�_���w��JGDDetail(�Үֶ���)
	CheckGD cgd = new CheckGD();
	//return:0 OK, return:sern(20306) ���խ����O���Ү֩���
	String chkr = cgd.doCheck(fdate,fltno,sect,sern,score);
	String astring = "�խ��Ǹ� "+ chkr +" ���O���Үֶ��� !";
	if(!chkr.equals("0"))
	{
	%>
		<script>
			alert("<%=astring%>" );
			history.back(-1);
		</script>
	<%	
	}
	//�P�_����

	//�V�v�u�ˬd�O�_���T�WKPI����
	/*
	if (!fltno.equals("0025") && !fltno.equals("0026") && !fltno.equals("0027") && !fltno.equals("0028") && fltno.substring(0,2).equals("00"))
	{
		int kpi_cnt = cgd.doKPICheck(fdate,fltno,sect);
		if(kpi_cnt<3)
		{
	*/
	%>
			<!--<script>
				alert("�Щ�C����3��խ��w�����ж��ءA�ñN���浲�G�x�J�խ��Ү֤�KPI���C");
			</script>
			-->
	<%	
	/*
		}	
	}
	*/

	//�P�_ZC
	fz.pracP.CheckZCData chkZC = new fz.pracP.CheckZCData(fdate,fltno,sect,purserEmpno,empno,duty);	
	chkZC.SelectData();
	
	if(chkZC.isHasZC())
	{	//���Z��ZC
		if(!chkZC.isZCEvaluated())
		{
		%>
			<script>
				alert("������JZone Chief (���u���G<%=chkZC.getZcEmpno()%>) ���ҵ�." );
				history.back(-1);
			</script>
		<%	
		}
	}

	//****************************************************************************
	fz.pracP.pa.CheckPAData chkPA = new fz.pracP.pa.CheckPAData(fdate,fltno,sect,purserEmpno,empno,duty);	
	chkPA.SelectData();
	
	if(chkPA.isHasPA())
	{	//���Z��PA
		if(!chkPA.isPAEvaluated())
		{
		%>
			<script>
				alert("������JPA�խ� (���u���G<%=chkPA.getPaEmpno()%>) ���ҵ�." );
				history.back(-1);
			</script>
		<%	
		}
	}

	//****************************************************************************	
}//if(ispart2 == null)

String ModifyPage="edReportModify.jsp?fdate="+fdate+"&fltno="+fltno+"&dpt="+
				request.getParameter("dpt").trim()+"&arv="+request.getParameter("arv").trim()
				+"&GdYear="+GdYear;
				
String LingPar = "edFltIrr.jsp?fdate="+fdate+"&fltno="+fltno+"&dpt="+request.getParameter("dpt").trim()+"&arv="+request.getParameter("arv")+"&GdYear="+GdYear+"&acno="+acno;

String LingPar3 = "edFltIrr_3.jsp?fdate="+fdate+"&fltno="+fltno+"&dpt="+request.getParameter("dpt").trim()+"&arv="+request.getParameter("arv")+"&GdYear="+GdYear+"&acno="+acno;

String LingPar4 = "edFltIrr_4.jsp?fdate="+fdate+"&fltno="+fltno+"&dpt="+request.getParameter("dpt").trim()+"&arv="+request.getParameter("arv")+"&GdYear="+GdYear+"&acno="+acno;

String LingPar5 = "edFltIrr_5.jsp?fdate="+fdate+"&fltno="+fltno+"&dpt="+request.getParameter("dpt").trim()+"&arv="+request.getParameter("arv")+"&GdYear="+GdYear+"&acno="+acno;

String LingPar6 = "edFltIrr_6.jsp?fdate="+fdate+"&fltno="+fltno+"&dpt="+request.getParameter("dpt").trim()+"&arv="+request.getParameter("arv")+"&GdYear="+GdYear+"&acno="+acno;

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
////�d�߬O�_�w�g����ơA�Y���A�h�e�X���i...�Y�L�A�h�^�� flightcrew.jsp
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

//�R���h�l��ZC���
fz.pracP.zc.DeleteErrorZCData delZC = new fz.pracP.zc.DeleteErrorZCData(fdate, fltno, sect,purserEmpno);
try
{
	delZC.job();
}
catch(Exception e)
{
}

//�R���h�l��PA���
//************************************************************************************
fz.pracP.pa.DeleteErrorPAData delPA = new fz.pracP.pa.DeleteErrorPAData(fdate, fltno, sect,purserEmpno);
try
{
	delPA.job();
}
catch(Exception e)
{
}
//************************************************************************************

//�ˬd��Z���
fz.pracP.CheckFltData cflt = new fz.pracP.CheckFltData(fdate, fltno, sect,purserEmpno);
if( status )
{
	
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
	
	if(cflt.isHasFltCrewData())
	{//�� Flight Crew���
		goPage = "edReportModify.jsp?fdate="+fdate+"&fltno="+fltno+"&dpt="+
				request.getParameter("dpt").trim()+"&arv="+request.getParameter("arv").trim()
				+"&GdYear="+GdYear;
	}
	else
	{
		goPage = "flightcrew.jsp?fyy="+fdate.substring(0,4)+"&fmm="+fdate.substring(5,7)+"&fdd="+
		fdate.substring(8)+"&fltno="+fltno+"&GdYear="+GdYear+"&acno=null";	
	}
	
}else{
	out.println(errMsg);
}


//�s�W�d�ֶ���
//********************************************************************
eg.flightcheckitem.CheckItemKeyValue ckKey = new eg.flightcheckitem.CheckItemKeyValue();
	ckKey.setFltd(fdate);
	ckKey.setFltno(fltno);
	ckKey.setSector(sect);
	ckKey.setPsrEmpn(purserEmpno);
eg.flightcheckitem.CheckItemWithFlight ckhItemFlt = null;
ArrayList al = null;
try
{
	ckhItemFlt = new eg.flightcheckitem.CheckItemWithFlight(ckKey);	
	al = ckhItemFlt.getChkItemAL();
}
catch(Exception e){}
//********************************************************************
//�O�_�ݶ�M�׽լd
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
//�O�_�ݶ�ۧڷ���
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
  ���i�w�x�s�A�i�A�׭ק�C  <br>
 Report is Saved and can be modified!!<br>
</caption>
<tr>
  <td width="13%" height="35">&nbsp;</td>
	<td width="87%" style="text-align:left;"><span class="txtblue">�խ����� :</span> &nbsp;
	  <input name="Submit" type="button"  value="�խ��Ү�" onClick="preview('form1','<%=goPage%>')" style="background-color:#F0F8FF; ">&nbsp;&nbsp;&nbsp;<input type="button" value="�խ��Ʃy"  onClick="preview('form1','<%=LingPar3%>')" style="background-color:#F0F8FF; ">		
	</td>
</tr>
<tr>
  <td width="13%" height="35">&nbsp;</td>
	<td width="87%" style="text-align:left;"><span class="txtblue">�ȿ��ʺA : </span>&nbsp;
		<input type="button" value="�Z���g�`�ư�"  onClick="preview('form1','<%=LingPar%>')" style="background-color:#F0F8FF; ">&nbsp;&nbsp;&nbsp;<input name="Submit" type="button"  value="�]��\�t��" onClick="preview('form1','<%=LingPar4%>')" style="background-color:#F0F8FF; ">&nbsp;&nbsp;&nbsp;<input name="Submit" type="button"  value="�ȿ��A��" onClick="preview('form1','<%=LingPar5%>')" style="background-color:#F0F8FF; ">&nbsp;&nbsp;&nbsp;<input type="button" value="���`���i"  onClick="preview('form1','<%=LingPar6%>')" style="background-color:#F0F8FF; ">
	</td>
</tr>

<%
if(al != null | pjneedfill == true | needfill == true)
{
%>
<tr>
  <td height="33" >&nbsp;</td>
	<td style="background-color:#FFFFCC;text-align:left;color:#FF0000;font-weight:bold; ">
���Z�����H�U���[���i�A�ݧ�����J�~��ú����i.
	</td>
</tr>
<%
}	

if(al != null)
{
%>
	<tr>
	  <td >&nbsp;</td>
		<td style="background-color:#FFFFCC;text-align:left; ">
<%
		for(int i=0;i<al.size();i++)
		{
			eg.flightcheckitem.CheckMainItemObj obj = (eg.flightcheckitem.CheckMainItemObj)al.get(i);
			StringBuffer str =new StringBuffer("��J</span>");
			if(!obj.isHasCheckData())
			{
				str.insert(0,"<span style='color:red;'>�|��");
			}
			else
			{
				str.insert(0,"<span style='color:blue;'>�w");
			}
		
%>
		<a href="javascript:editChkform('<%=obj.getSeqno()%>','<%=obj.getCheckRdSeq()%>',<%=obj.isHasCheckData()%>)">
		<img src="../images/layout_edit.gif" width="16" height="16" align="absmiddle" border="0" >&nbsp;<%=obj.getDescription()+" ("+str.toString()+") "%></a>
		<br>	
<%		
		}
%>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
	<a href="guide/chkItemInput.pdf" target="_blank"><img src="../images/folder_image.gif" width="16" height="16" border="0">(�U���ާ@����PDF��)</a>
<%
	} 
%>
</td></tr>
<%
//�M�׽լd/�l�ܦҮ�
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
		 <img src="../images/layout_edit.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="Edit ProjInvestigation">�M�׽լd/�l�ܦҮ�/�ƥ�^��/Safety Audit
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
		 <img src="../images/layout_edit.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="Edit PSFLY">�ۧڷ���
		 </a>
</td>
</tr>
<%
}//if(pjneedfill == true)
%>

<tr>
  <td height="51">&nbsp;</td>
	<td style="text-align:left;">
	<input type="button" value="View Report"  onClick="javascript:window.open('PURreport_print.jsp?fdate=<%=fdate%>&fltno=<%=fltno%>&section=<%=sect%>')"  style="background-color:#F0F8FF; ">
	</td>
</tr>    
<tr>
  <td>&nbsp;</td>
<td style="text-align:left;">
 <input type="submit" value="Send Report" style="background-color:#FFCCCC; " ></td>
</tr>  
</table>
		<input type="hidden" name="fdate" value="<%=fdate%>">
		<input type="hidden" name="stdDt" value="<%=stdDt%>">
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
	<input type="hidden" name="stdDt" value="<%=stdDt%>">
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
	var msg = "�нT�{�A���Z���w�L���󲧱`�ƶ��A�åߧY�e�X���i?\n\n";
	msg +="1.�Y���Z���L���`�ƶ��A�Ы��u�T�w�v�A�e�X���i\n"
	msg +="2.�Y���Z�������󲧱`�ƶ��A�Ы���������A�I��y�Z���g�`�ưȡz.\n";
	<%
	
	if(!ckhItemFlt.isHasCheckAllOrNoCheck())
	{
	%>
	alert("�|���d�ֶ��إ���J,���o�e�X.");
	return false;
	<%	
	}else{
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
//egtcflt���|��������....�୶��flightcrew�A�i�JPartI  Report
if(!cflt.isHasFltCrewData()){
	out.print("alert('���i�|����g�����A���o�e�X!!\\n\\n�Ы��u�T�w�v�i�JPartI Report Edit');"
			+"self.location='"+ goPage+"';");
}
else
{//egtcflt���w�g������....
	if(!"R".equals(request.getParameter("chk")))
%>
alert("���i�x�s���\!!");
<%
}
%>
</script>
</body>
</html>
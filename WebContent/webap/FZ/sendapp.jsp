<%@ page contentType="text/html; charset=Big5" language="java"  pageEncoding="Big5"%>
<%@page import="fz.*,java.sql.*,java.net.URLEncoder"%>
<%
//response.setHeader("Cache-Control","no-cache");
//response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
String redirectUrl = null;
boolean flag = false;
String xMessagestring = null;
String xMessagelink = null;
String xLinkto = null;
String xMsgCode = null;
if ( sGetUsr == null) 
{		//check user session start first or not login
	//response.sendRedirect("sendredirect.jsp");
	redirectUrl = "sendredirect.jsp";
} 
//applicant duty
String[] cp = request.getParameterValues("checkput");
//replace duty
String[] cp2 = request.getParameterValues("checkput2");
//�O�_������Z��
String comments = request.getParameter("comments");
String comm2 = request.getParameter("comm2");
String mymm = request.getParameter("mymm");
String rempno = request.getParameter("rempno");

if (cp == null && cp2 == null)
{
/****
	<jsp:forward page="showmessage.jsp">
	<jsp:param name="messagestring" value="Select Schedule to Apply !" />
	<jsp:param name="messagelink" value="Back to previous" />
	<jsp:param name="linkto" value="javascript:history.back(-2);" />
	</jsp:forward>
****/
	flag = true;
	//redirectUrl = "showmessage.jsp?messagestring=Select Schedule to Apply !&messagelink=Back to previous&linkto=applicant.jsp?empno="+rempno+"&fyy="+mymm.substring(0,4)+"&fmm="+mymm.substring(5,7);
	xMessagestring = "Select Schedule to Apply !";
	xMessagelink = "Back to previous";
	xLinkto = "empno="+rempno+"&fyy="+mymm.substring(0,4)+"&fmm="+mymm.substring(5,7);
	xMsgCode = "x1";
}
String[] fdate = null;
String[] tripno = null;
String[] fltno = null;
String[] cr = null;

String[] rfdate = null;
String[] rtripno = null;
String[] rfltno = null;
String[] cr2 = null;
if (cp != null)
{
	fdate = new String[cp.length];
	tripno = new String[cp.length];
	fltno = new String[cp.length];
	cr = new String[cp.length];
}
if (cp2 != null)
{
	rfdate = new String[cp2.length];
	rtripno = new String[cp2.length];
	rfltno = new String[cp2.length];
	cr2 = new String[cp2.length];
}

String cname=null;
String rcname = null;
String a = "0000";
String b = "0000";
int xam = 0;
int xbm = 0;

try{
applyForm af = new applyForm();

//apply empno and name of a & r
int limitdate = af.getLimitDate();
if (limitdate > 0){
/*********************
	<jsp:forward page="showmessage.jsp">
	<jsp:param name="messagestring" value="�t�Τ���Ȱ�����A�Щ�u�@��00:01�}�l����<BR>�i���]���G1.�Ұ���2.���ƬG(�䭷)" />
	<jsp:param name="messagelink" value="Back to previous" />
	<jsp:param name="linkto" value="javascript:history.back(-2);" />
	</jsp:forward>
**********************/
	flag = true;
	//redirectUrl = "showmessage.jsp?messagestring=�t�Τ���Ȱ�����A�Щ�u�@��00:01�}�l����<BR>�i���]���G1.�Ұ���2.���ƬG(�䭷)&messagelink=Back to previous&linkto=applicant.jsp?empno="+rempno+"&fyy="+mymm.substring(0,4)+"&fmm="+mymm.substring(5,7);
	xMessagestring = "�t�Τ���Ȱ�����A�Щ�u�@��00:01�}�l����<BR>�i���]���G1.�Ұ���2.���ƬG(�䭷)";
	xMessagelink = "Back to previous";
	xLinkto = "empno="+rempno+"&fyy="+mymm.substring(0,4)+"&fmm="+mymm.substring(5,7);
	xMsgCode = "x2";
}

if( !af.checkMax()){
/***************************
	<jsp:forward page="showmessage.jsp">
	<jsp:param name="messagestring" value="�w�W�L�t�γ��B�z�W���I" />
	<jsp:param name="messagelink" value="Back to previous" />
	<jsp:param name="linkto" value="javascript:history.back(-2);" />
	</jsp:forward>
******************************/
	flag = true;
	//redirectUrl = "showmessage.jsp?messagestring=�w�W�L�t�γ��B�z�W���I&messagelink=Back to previous&linkto=applicant.jsp?empno="+rempno+"&fyy="+mymm.substring(0,4)+"&fmm="+mymm.substring(5,7);
	xMessagestring = "�w�W�L�t�γ��B�z�W���I";
	xMessagelink = "Back to previous";
	xLinkto = "empno="+rempno+"&fyy="+mymm.substring(0,4)+"&fmm="+mymm.substring(5,7);
	xMsgCode = "x3";

}


//���P�_�O�_�w�W�L2��
int atimes = af.getApplyTimes(sGetUsr);//applicant
int rtimes = af.getApplyTimes(rempno);//replace
if ((atimes == 9 || rtimes == 9))
{
/************************************
	<jsp:forward page="showmessage.jsp">
	<jsp:param name="messagestring" value="�ӽЪ̩γQ���̦��ӽг楼�Q ED �T�{���i�A����" />
	<jsp:param name="messagelink" value="Back to previous" />
	<jsp:param name="linkto" value="javascript:history.back(-2);" />
	</jsp:forward>
************************************/
	flag = true;
	//redirectUrl = "showmessage.jsp?messagestring=�ӽЪ̩γQ���̦��ӽг楼�Q ED �T�{���i�A����&messagelink=Back to previous&linkto=applicant.jsp?empno="+rempno+"&fyy="+mymm.substring(0,4)+"&fmm="+mymm.substring(5,7);
	xMessagestring = "�ӽЪ̩γQ���̦��ӽг楼�Q ED �T�{���i�A����";
	xMessagelink = "Back to previous";
	xLinkto = "empno="+rempno+"&fyy="+mymm.substring(0,4)+"&fmm="+mymm.substring(5,7);
	xMsgCode = "x4";
}

if (cp != null)
{
	for (int i = 0; i < cp.length; i++)
	{
		fdate[i] = cp[i].substring(0, 10);
		tripno[i] = cp[i].substring(10, 14);
		fltno[i] = cp[i].substring(14);
		//out.println(fdate[i]+","+tripno[i]+","+fltno[i]);
	}
	//get applicant's fly hour array
	cr = af.getCreditHr(fdate, tripno);
}
if (cp2 != null)
{
	for (int x = 0; x < cp2.length; x++)
	{
		rfdate[x] = cp2[x].substring(0, 10);
		rtripno[x] = cp2[x].substring(10, 14);
		rfltno[x] = cp2[x].substring(20);
		//out.println(rfdate[x]+","+rtripno[x]+","+rfltno[x]);
	}
	//get replace's fly hour array
	cr2 = af.getCreditHr(rfdate, rtripno);
}

chkUser ck = new chkUser();

String rs = ck.findCrew(sGetUsr);

if (rs.equals("1"))
{
	cname = ck.getName()+ck.getSpcode();
}
rs = ck.findCrew(rempno);
if (rs.equals("1"))
{
	rcname = ck.getName()+ck.getSpcode();
}
//applicant base information
af.setCrewInfo(sGetUsr, mymm);//groups, qual
String agroups = af.getGroups();
String aqual = af.getQual();
String aprjcr = af.getPrjcr();
String sern = af.getSern();
//replace base information
af.setCrewInfo(rempno, mymm);
String rgroups = af.getGroups();
String rqual = af.getQual();
String rprjcr = af.getPrjcr();
String rsern = af.getSern();
//out.print(rcname+","+rgroups +"," + rsern);
%>
<html>
<head>
<title>Send Crew Duty</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="menu.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style1 {
	font-size: 16px;
	font-weight: bold;
}
.style2 {font-size: 12}
.style4 {color: #FF0000}
.style5 {font-size: 12; color: #FF0000; }

-->
</style>
<script language="JavaScript" type="text/JavaScript">

		function openwindow(){
		newopen=window.open('note.htm','note','height=250,width=500,top=100,left=200');

		}

	function disa(){
		document.form1.Send.disabled=1;
		return true;
	}
</script>

</head>
<body onLoad="openwindow()">
<form name="form1" method="post" action="upd_form.jsp" onsubmit="return disa()">
  <p align="center" class="style1">Swap Application Form</p>
    <table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr> 
      <td width="3%" height="110">&nbsp;</td>
      <td width="94%" class="font1 style2"><p class="style2 style4">The Applicant and the Substitute hereby
          agree to exchange the designated flights as outlined in this form,
          and duly represent the following, </p>
        <ul>
          <li class="style5">Full duty attendance for two consecutive calendar months
            prior to applying </li>
          <li class="style5">All contents present hereunder are in compliance with the applicable
            rules </li>
      </ul></td>
      <td width="3%">
        <div align="right"><a href="javascript:window.print()"> </a> 
        </div>
      </td>
    </tr>
  </table>
<br>
  <table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr> 
      <td width="5%">&nbsp;</td>
      <td width="90%" class="font1">&nbsp;</td>
      <td width="5%">
        <div align="right"><a href="javascript:window.print()"> <img src="images/print.gif" width="17" height="15" border="0" alt="�C�L"></a> 
        </div>
      </td>
    </tr>
  </table>
  <table width="90%"  border="1" cellpadding="0" cellspacing="1" align="center">
    <tr > 
      <td width="18%" class="tablehead2"> 
        <div align="center">�� �� </div>
      </td>
      <td width="38%" colspan="2" class="tablehead2"> 
        <div align="center"> <strong>Applicant </strong> </div>
      </td>
      <td width="44%" colspan="2" class="tablehead2"> 
        <div align="center"> <strong>Substitute </strong> </div>
      </td>
    </tr>
    <tr > 
      <td class="tablebody"><b><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
        Name / Section</font></b></td>
      <td class="tablebody"><%=cname%> 
        <input type="hidden" name="cname" value="<%=cname%>">
      </td>
      <td class="tablebody"><%=agroups%> 
        <input type="hidden" name="agroups" value="<%=agroups%>">
      </td>
      <td class="tablebody"><%=rcname%> 
        <input type="hidden" name="rcname" value="<%=rcname%>">
      </td>
      <td class="tablebody"><%=rgroups%> 
        <input type="hidden" name="rgroups" value="<%=rgroups%>">
      </td>
    </tr>
    <tr > 
      <td class="tablebody"><b><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
        ID. No. / Serial No </font></b></td>
      <td class="tablebody"><%=sGetUsr%> 
        <input type="hidden" name="sGetUsr" value="<%=sGetUsr%>">
      </td>
      <td class="tablebody"><%=sern%> 
        <input type="hidden" name="sern" value="<%=sern%>">
      </td>
      <td class="tablebody"><%=rempno%> 
        <input type="hidden" name="rempno" value="<%=rempno%>">
      </td>
      <td class="tablebody"><%=rsern%> 
        <input type="hidden" name="rsern" value="<%=rsern%>">
      </td>
    </tr>
    <tr > 
      <td class="tablebody"><b><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">Exchange Count</font></b></td>
      <td colspan="2" class="tablebody"><%=atimes%> 
        <input type="hidden" name="atimes" value="<%=atimes%>">
      </td>
      <td colspan="2" class="tablebody"><%=rtimes%> 
        <input type="hidden" name="rtimes" value="<%=rtimes%>">
      </td>
    </tr>
    <tr class="tablebody"> 
      <td class="tablebody"><b><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">Qualification</font></b></td>
      <td colspan="2" class="tablebody"><%=aqual%> 
        <input type="hidden" name="aqual" value="<%=aqual%>">
      </td>
      <td colspan="2" class="tablebody"><%=rqual%> 
        <input type="hidden" name="rqual" value="<%=rqual%>">
      </td>
    </tr>
  </table>
<br>
<%
if (cp != null)
{
%>
  <table width="90%"  border="1" cellpadding="0" cellspacing="1" align="center">
    <tr > 
      <td colspan="4" class="tablehead2"> 
        <div align="center"> <strong>Applicant </strong> </div>
      </td>
    </tr>
    <tr > 
      <td width="25%" class="tablehead2"> 
        <div align="center">TripNo</div>
      </td>
      <td class="tablehead2"> 
        <div align="center">Flight Date </div>
      </td>
      <td class="tablehead2"> 
        <div align="center">FlightNo</div>
      </td>
      <td class="tablehead2"> 
        <div align="center">Flying Time</div>
      </td>
    </tr>
    <%
    /***********************************************/
	
for (int i = 0; i < cp.length; i++)
{

%>
    <tr > 
      <td class="tablebody"><%=tripno[i]%> 
        <input type="hidden" name="tripno" value="<%=tripno[i]%>">
      </td>
      <td class="tablebody"><%=fdate[i]%> 
        <input type="hidden" name="fdate" value="<%=fdate[i]%>">
      </td>
      <td class="tablebody"><%=fltno[i]%> 
        <input type="hidden" name="fltno" value="<%=fltno[i]%>">
      </td>
      <td class="tablebody"><%=cr[i]%> 
        <input type="hidden" name="cr" value="<%=cr[i]%>">
      </td>
    </tr>
    <%
  
}

%>
  </table>
<%
}
%>
<br>
<%
if (cp2 != null)
{
%>
  <table width="90%"  border="1" cellpadding="0" cellspacing="1" align="center">
    <tr> 
      <td colspan="4" class="tablehead2"> 
        <div align="center"> <strong>Substitute </strong> </div>
      </td>
    </tr>
    <tr> 
      <td width="25%" class="tablehead2"> 
        <div align="center">TripNo</div>
      </td>
      <td class="tablehead2"> 
        <div align="center">Flight Date </div>
      </td>
      <td class="tablehead2"> 
        <div align="center">FlightNo</div>
      </td>
      <td class="tablehead2"> 
        <div align="center">Flying Time</div>
      </td>
    </tr>
    <%
    /***********************************************/
for (int x = 0; x < cp2.length; x++)
{
%>
    <tr > 
      <td class="tablebody"><%=rtripno[x]%> 
        <input type="hidden" name="rtripno" value="<%=rtripno[x]%>">
      </td>
      <td class="tablebody"><%=rfdate[x]%> 
        <input type="hidden" name="rfdate" value="<%=rfdate[x]%>">
      </td>
      <td class="tablebody"><%=rfltno[x]%> 
        <input type="hidden" name="rfltno" value="<%=rfltno[x]%>">
      </td>
      <td class="tablebody"><%=cr2[x]%> 
        <input type="hidden" name="cr2" value="<%=cr2[x]%>">
      </td>
    </tr>
    <%
  }
 %>
  </table>
<%
}
%>
<br>
<%
if (cp != null)
{
	a = af.getSwapHr(cr); //�ӽЪ̪������`����A
}

if (cp2 != null)
{
	b = af.getSwapHr(cr2); //�Q���̪������`����B
}

%>
  <table width="90%"  border="1" cellpadding="0" cellspacing="1" align="center">
    <tr> 
      <td width="23%" class="tablebody"> 
        <div align="center"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000FF">Total
            flying Hours for this Flight Exchange 
          </font></div>
      </td>
      <td class="txttitle"><b>A </b></td>
      <td class="tablebody"><%=a%> 
        <input type="hidden" name="aSwapHr" value="<%=a%>">
      </td>
      <td class="txttitle"><b>B </b></td>
      <td class="tablebody"><%=b%> 
        <input type="hidden" name="rSwapHr" value="<%=b%>">
      </td>
    </tr>
    <%
int am = 0;
int bm = 0;
if (a.length() == 5){
	am = Integer.parseInt(a.substring(0,3)) *60 + Integer.parseInt(a.substring(3,5));	//�NA.B�ন����
}
else{
	am = Integer.parseInt(a.substring(0,2)) *60 + Integer.parseInt(a.substring(2,4));	//�NA.B�ন����
}
if (b.length() == 5){
	bm = Integer.parseInt(b.substring(0,3)) *60 + Integer.parseInt(b.substring(3,5));	//�NA.B�ন����
}
else{
	bm = Integer.parseInt(b.substring(0,2)) *60 + Integer.parseInt(b.substring(2,4));	//�NA.B�ন����
}
//int am = Integer.parseInt(a.substring(0,2)) *60 + Integer.parseInt(a.substring(2,4));	//�NA.B�ন����
//int bm = Integer.parseInt(b.substring(0,2)) *60 + Integer.parseInt(b.substring(2,4));
xam = bm-am; //A�����ɮt�B�]�H�����p�^
xbm = am-bm;//B�����ɮt�B�]�H�����p�^

/*out.print("a :"+a+"<br>");
out.print("b :"+b+"<br>");
out.print("am :"+am+"<br>");
out.print("bm :"+bm+"<br>");
out.print("1.**********************************************"+xam);*/

if((Math.abs(xam/60) > 12 )){   //���ɮt�B�j��12�p��
	flag = true;
	
//	out.print("���ɮt�B�j��12�p��");
		//response.sendRedirect("showmessage.jsp?messagestring="+URLEncoder.encode("���ɮt�B���o�j��12�p�ɡI�I")+"&messagelink=Back to previous&linkto=javascript:history.back(-2);");
	//redirectUrl = "showmessage.jsp?messagestring="+URLEncoder.encode("���ɮt�B���o�j��12�p�ɡI�I")+"&messagelink=Back to previous&linkto=applicant.jsp?empno="+rempno+"&fyy="+mymm.substring(0,4)+"&fmm="+mymm.substring(5,7);
	//response.sendRedirect("showmessage.jsp");
	xMessagestring = URLEncoder.encode("���ɮt�B���o�j��12�p�ɡI�I");
	xMessagelink = "Back to previous";
	xLinkto = "empno="+rempno+"&fyy="+mymm.substring(0,4)+"&fmm="+mymm.substring(5,7);
	xMsgCode = "x5";
}
else{
	if((Math.abs(xam/60) == 12 ) && (Math.abs(xam%60) > 0 )){   //���ɮt�B�j��12�p��
		flag = true;
		redirectUrl = "showmessage.jsp?messagestring="+URLEncoder.encode("���ɮt�B���o�j��12�p�ɡI�I")+"&messagelink=Back to previous&linkto=applicant.jsp?empno="+rempno+"&fyy="+mymm.substring(0,4)+"&fmm="+mymm.substring(5,7);
		//out.print("���ɮt�B�j��12�p��");
		//response.sendRedirect("showmessage.jsp?messagestring="+URLEncoder.encode("���ɮt�B���o�j��12�p�ɡI�I")+"&messagelink=Back to previous&linkto=javascript:history.back(-2);");
		xMessagestring = URLEncoder.encode("���ɮt�B���o�j��12�p�ɡI�I");
		xMessagelink = "Back to previous";
		xLinkto = "empno="+rempno+"&fyy="+mymm.substring(0,4)+"&fmm="+mymm.substring(5,7);
		xMsgCode = "x6";
	}
}

String hh = null;  //A�����ɮt�B�]�ɡ^
String mm = null;  //A�����ɮt�B�]���^
String xa = null; 
String xb = null;
String hhb = null; //B�����ɮt�B�]�ɡ^
String mmb = null;//B�����ɮt�B�]���^

//�N���ɮt�B�������ƪ̸�0

	hh = String.valueOf(xam/60); //A����
	if(hh.equals("0") &&xam<0){hh="-0";}	//�p�ɼƬ�0&���t�ɡA�[�t��

	if(Math.abs(xam%60)< 10 ){	//A�����A�������Ƹ�0
		mm = "0" + String.valueOf(Math.abs(xam%60));
	}
	else{
		mm =  String.valueOf(Math.abs(xam%60));
	}	
	
	xa = hh + mm;
	
	
	hhb = String.valueOf(xbm/60); //B����
	if(hhb.equals("0") &&xbm<0){hhb="-0";}//�p�ɼƬ�0&���t�ɡA�[�t��

	if(Math.abs(xbm%60)< 10 ){	//B�����A�������Ƹ�0
		mmb = "0" + String.valueOf(Math.abs(xbm%60));
	}
	else{
		mmb =  String.valueOf(Math.abs(xbm%60));
	}		//out.print(hhb+","+mmb);
	
	xb = hhb + mmb;
/*xb = String.valueOf(xbm/60) + String.valueOf(Math.abs(xbm%60));*/

%>
    <tr> 
      <td width="23%" class="tablebody"> 
        <p align="center"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000FF">Flying Hour difference<br>
(x&lt;12hr)</font></p>      </td>
      <td class="txttitle"><b>A-B=X : </b></td>
      <td class="tablebody"><%=xa%> 
        <input type="hidden" name="afd" value="<%=xa%>">
      </td>
      <td class="txttitle"><b>A-B=X :</b></td>
      <td class="tablebody"><%=xb%> 
        <input type="hidden" name="rfd" value="<%=xb%>">
      </td>
    </tr>
    <tr> 
      <td class="tablebody"> 
        <div align="center"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000FF">Projected 
          Credit Hour </font></div>
      </td>
      <td class="txttitle"><b>Applicant:</b></td>
      <td class="tablebody"><%= aprjcr%> 
        <input type="hidden" name="aprjcr" value="<%= aprjcr%>">
      </td>
      <td class="txttitle"><b>Substitute:</b></td>
      <td class="tablebody"><%= rprjcr%> 
        <input type="hidden" name="rprjcr" value="<%= rprjcr%>">
      </td>
    </tr>
    <tr> 
      <td width="23%" class="tablebody"> 
        <div align="center"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000FF">Total
            monthly flying Hours after Flight Exchange 
          </font></div>
      </td>
      <td width="15%" class="txttitle"><b>C ��X=</b></td>
      <%
	int cx = 0;
	int dx = 0;
	String ea = null;
	String fb = null;
		int cam = Integer.parseInt(aprjcr.substring(0,3)) *60 + Integer.parseInt(aprjcr.substring(3,5));
				//A��Project Credit Hour�H�����p
      	 cx= cam+xam;	//A�������`���ɡA�H�����p
		if(cx%60 <10){	//A�������`���ɡA���������Y�������A��0
			ea = String.valueOf(cx/60) + "0"+String.valueOf(cx%60);
		}
		else{
			ea = String.valueOf(cx/60) + String.valueOf(cx%60);
		}
	
	/**********************************************************************/
	
		int cbm = Integer.parseInt(rprjcr.substring(0,3)) *60 + Integer.parseInt(rprjcr.substring(3,5));
				//B��Project Credit HOur�H�����p
      	 dx= cbm+xbm; //B�������`���ɡA�H�����p
		if(dx%60 <10){	//B�������`���ɡA���������Y�������A��0
			fb = String.valueOf(dx/60) + "0"+String.valueOf(dx%60);
		}
		else{
			fb = String.valueOf(dx/60) + String.valueOf(dx%60);
		}
   /**********************************************************************/
	
	
	

	%>
      <td width="20%" class="tablebody"><%= ea%> 
        <input type="hidden" name="attfly" value="<%= ea%>">
      </td>
      <td width="19%" class="txttitle"><b>D ��X=</b></td>
      <td width="23%" class="tablebody"><%=fb%> 
        <input type="hidden" name="rttfly" value="<%=fb%>">
      </td>
    </tr>
    <tr> 
      <td class="tablebody"> 
        <div align="center"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000FF">Extra Pay Hours</font></div>
      </td>
      <%
	  // �p��W�ɵ��I�ɡA�Y(�C�涵-75hrs)<0�A�h�H0�p��
   int e,f,c,d;	//efcd�O������
   e = cx-(75*60);
  	 if (e<0){e=0;}
   
   f = dx-(75*60);
 	  if(f<0){f=0;}

   c = cam-(75*60);
 	  if(c<0){c=0;}

   d = cbm-(75*60);
 	  if(d<0){d=0;}
   
   //�H�����p��swap
   float swapm = (e+f)-(c+d);
 
   //�����ɼ�
  float swap = (swapm/60);

 // out.print(swap);
/*
	e = (cx/60)-75;
    if ((cx/60)-75 <0){
	   e = 0;
	}

	f = (dx/60)-75 ;
	if ( (dx/60)-75  <0 ){
	     f = 0;
	}

	c=  (Integer.parseInt(aprjcr.substring(0,3)) *60) -75 ;
	if ( (Integer.parseInt(aprjcr.substring(0,3)) -75  <0 ){
	   c =0;
	}

	d=  (Integer.parseInt(rprjcr.substring(0,3)) *60)-75 ;
	if ( (Integer.parseInt(rprjcr.substring(0,3)) -75  <0 ){
	   d =0;
	}
*/

   if (swap > 5){	//����W�ɵ��I>5hrs�A���o�ӽ�
   
/****************************
      <jsp:forward page="showmessage.jsp"> 
      <jsp:param name="messagestring" value="���Z��W�ɵ��I�j�󤭤p�ɡA���o�ӽСC�Э��s��g���Z�ӽг�I<br>Extra Pay Hours over 5 hours!!" />
	  <jsp:param name="messagelink" value="Back to previous" />
	  <jsp:param name="linkto" value="javascript:history.back(-2);" />
      </jsp:forward>
***********************************/
	flag = true;
	//redirectUrl = "showmessage.jsp?messagestring=���Z��W�ɵ��I�j�󤭤p�ɡA���o�ӽСC�Э��s��g���Z�ӽг�I<br>Extra Pay Hours over 5 hours!!&messagelink=Back to previous&linkto=applicant.jsp?empno="+rempno+"&fyy="+mymm.substring(0,4)+"&fmm="+mymm.substring(5,7);
	xMessagestring = URLEncoder.encode("���Z��W�ɵ��I�j�󤭤p�ɡA���o�ӽСC�Э��s��g���Z�ӽг�I<br>Extra Pay Hours over 5 hours!!");
	xMessagelink = "Back to previous";
	xLinkto = "empno="+rempno+"&fyy="+mymm.substring(0,4)+"&fmm="+mymm.substring(5,7);
	xMsgCode = "x7";
}  
%> 

      <td colspan="4" class="tablebody"> 
        <%
	if (swap <=0){	//����W�ɵ��I<=0�A��ܶW�ɵ��I��No
	out.print("No");
	swap = 0;
	}

	
	if ( (swap>0) && (swap<=5) ){	//���� 0<�W�ɵ��I<=5�A��ܶW�ɵ��I���p��X�Ӫ��W�ɵ��I
	out.print("Yes&nbsp;total hours:"+Math.floor((swap+0.005)*100)/100);
	
	}
%>
        <input type="hidden" name="swap" value="<%=Math.floor((swap+0.005)*100)/100%>">
    </tr>
  </table>
  <br>
  <table width="90%"  border="1" cellpadding="0" cellspacing="1" align="center">
    <tr>
      <td width="24%" class="txttitle">
<div align="center">
          <p align="left"><b>Comments</b></p>
        </div></td>
    <td width="76%" class="tablebody">&nbsp;<%
	//�խ��ӽг�W���N��
	if (!comments.equals("")){
		out.print(comm2+"&nbsp;"+comments);	
	}
	else{
		out.print("No comments");
	}
	
	%>
      <input type="hidden" name="comments" value="<%=(comm2+comments)%>"></td>
  </tr>
</table><br>
<div align="center"><br>
<%
if(!flag){
%>
    <input name="Cancel" type="button" onClick="javascript:history.back(-2);" value="Cancel" class="btm">
    &nbsp;&nbsp;&nbsp;
    <input name="Send" type="submit" value="Send" class="btm">
<%
}
else{
	out.println("���ɮt�B���o�j��12�p�ɡI�I");
}
%>
    <input type="hidden" name="checkall" value="N">
</div>
</form>
<%
//if(flag){
	out.println("<form action='showmessage.jsp' method='post' name='catchError'>");
	out.println("<input type='hidden' name='messagestring' value='"+xMessagestring+"'>");
	out.println("<input type='hidden' name='msgcode' value='"+xMsgCode+"'>");
	out.println("<input type='hidden' name='messagelink' value='"+xMessagelink+"'>");
	out.println("<input type='hidden' name='linkto' value='applicant.jsp?"+xLinkto+"'>");
	out.println("</form >");
	
	
//}
%>
</body>
</html>
<script language="JavaScript" type="text/JavaScript">
function showmess(){
alert("Please Query Again�I�I\n�Э��s�d�ߡI");
self.location="blank.htm";
}
<%
//�ק�B
if(flag){
		//response.sendRedirect("showmessage.jsp?messagestring="+URLEncoder.encode("���ɮt�B���o�j��12�p�ɡI�I")+"&messagelink=Back to previous&linkto=javascript:history.back(-2);");
		//URLEncoder.encode('���ɮt�B���o�j��12�p�ɡI�I')
		//out.println("self.location='"+redirectUrl+"'");
		out.println("document.catchError.submit();");
	}
%>
</script>
<%
	
} catch(Exception e)
{
//e.printStackTrace();
out.println(e.toString());	  
}
%>
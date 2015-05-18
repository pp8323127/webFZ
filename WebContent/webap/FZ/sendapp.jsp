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
//是否換全月班表
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
	<jsp:param name="messagestring" value="系統今日暫停收件，請於工作日00:01開始遞件<BR>可能原因為：1.例假日2.緊急事故(颱風)" />
	<jsp:param name="messagelink" value="Back to previous" />
	<jsp:param name="linkto" value="javascript:history.back(-2);" />
	</jsp:forward>
**********************/
	flag = true;
	//redirectUrl = "showmessage.jsp?messagestring=系統今日暫停收件，請於工作日00:01開始遞件<BR>可能原因為：1.例假日2.緊急事故(颱風)&messagelink=Back to previous&linkto=applicant.jsp?empno="+rempno+"&fyy="+mymm.substring(0,4)+"&fmm="+mymm.substring(5,7);
	xMessagestring = "系統今日暫停收件，請於工作日00:01開始遞件<BR>可能原因為：1.例假日2.緊急事故(颱風)";
	xMessagelink = "Back to previous";
	xLinkto = "empno="+rempno+"&fyy="+mymm.substring(0,4)+"&fmm="+mymm.substring(5,7);
	xMsgCode = "x2";
}

if( !af.checkMax()){
/***************************
	<jsp:forward page="showmessage.jsp">
	<jsp:param name="messagestring" value="已超過系統單日處理上限！" />
	<jsp:param name="messagelink" value="Back to previous" />
	<jsp:param name="linkto" value="javascript:history.back(-2);" />
	</jsp:forward>
******************************/
	flag = true;
	//redirectUrl = "showmessage.jsp?messagestring=已超過系統單日處理上限！&messagelink=Back to previous&linkto=applicant.jsp?empno="+rempno+"&fyy="+mymm.substring(0,4)+"&fmm="+mymm.substring(5,7);
	xMessagestring = "已超過系統單日處理上限！";
	xMessagelink = "Back to previous";
	xLinkto = "empno="+rempno+"&fyy="+mymm.substring(0,4)+"&fmm="+mymm.substring(5,7);
	xMsgCode = "x3";

}


//不判斷是否已超過2次
int atimes = af.getApplyTimes(sGetUsr);//applicant
int rtimes = af.getApplyTimes(rempno);//replace
if ((atimes == 9 || rtimes == 9))
{
/************************************
	<jsp:forward page="showmessage.jsp">
	<jsp:param name="messagestring" value="申請者或被換者有申請單未被 ED 確認不可再遞單" />
	<jsp:param name="messagelink" value="Back to previous" />
	<jsp:param name="linkto" value="javascript:history.back(-2);" />
	</jsp:forward>
************************************/
	flag = true;
	//redirectUrl = "showmessage.jsp?messagestring=申請者或被換者有申請單未被 ED 確認不可再遞單&messagelink=Back to previous&linkto=applicant.jsp?empno="+rempno+"&fyy="+mymm.substring(0,4)+"&fmm="+mymm.substring(5,7);
	xMessagestring = "申請者或被換者有申請單未被 ED 確認不可再遞單";
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
        <div align="right"><a href="javascript:window.print()"> <img src="images/print.gif" width="17" height="15" border="0" alt="列印"></a> 
        </div>
      </td>
    </tr>
  </table>
  <table width="90%"  border="1" cellpadding="0" cellspacing="1" align="center">
    <tr > 
      <td width="18%" class="tablehead2"> 
        <div align="center">說 明 </div>
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
	a = af.getSwapHr(cr); //申請者的互換總飛時A
}

if (cp2 != null)
{
	b = af.getSwapHr(cr2); //被換者的互換總飛時B
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
	am = Integer.parseInt(a.substring(0,3)) *60 + Integer.parseInt(a.substring(3,5));	//將A.B轉成分鐘
}
else{
	am = Integer.parseInt(a.substring(0,2)) *60 + Integer.parseInt(a.substring(2,4));	//將A.B轉成分鐘
}
if (b.length() == 5){
	bm = Integer.parseInt(b.substring(0,3)) *60 + Integer.parseInt(b.substring(3,5));	//將A.B轉成分鐘
}
else{
	bm = Integer.parseInt(b.substring(0,2)) *60 + Integer.parseInt(b.substring(2,4));	//將A.B轉成分鐘
}
//int am = Integer.parseInt(a.substring(0,2)) *60 + Integer.parseInt(a.substring(2,4));	//將A.B轉成分鐘
//int bm = Integer.parseInt(b.substring(0,2)) *60 + Integer.parseInt(b.substring(2,4));
xam = bm-am; //A的飛時差額（以分鐘計）
xbm = am-bm;//B的飛時差額（以分鐘計）

/*out.print("a :"+a+"<br>");
out.print("b :"+b+"<br>");
out.print("am :"+am+"<br>");
out.print("bm :"+bm+"<br>");
out.print("1.**********************************************"+xam);*/

if((Math.abs(xam/60) > 12 )){   //飛時差額大於12小時
	flag = true;
	
//	out.print("飛時差額大於12小時");
		//response.sendRedirect("showmessage.jsp?messagestring="+URLEncoder.encode("飛時差額不得大於12小時！！")+"&messagelink=Back to previous&linkto=javascript:history.back(-2);");
	//redirectUrl = "showmessage.jsp?messagestring="+URLEncoder.encode("飛時差額不得大於12小時！！")+"&messagelink=Back to previous&linkto=applicant.jsp?empno="+rempno+"&fyy="+mymm.substring(0,4)+"&fmm="+mymm.substring(5,7);
	//response.sendRedirect("showmessage.jsp");
	xMessagestring = URLEncoder.encode("飛時差額不得大於12小時！！");
	xMessagelink = "Back to previous";
	xLinkto = "empno="+rempno+"&fyy="+mymm.substring(0,4)+"&fmm="+mymm.substring(5,7);
	xMsgCode = "x5";
}
else{
	if((Math.abs(xam/60) == 12 ) && (Math.abs(xam%60) > 0 )){   //飛時差額大於12小時
		flag = true;
		redirectUrl = "showmessage.jsp?messagestring="+URLEncoder.encode("飛時差額不得大於12小時！！")+"&messagelink=Back to previous&linkto=applicant.jsp?empno="+rempno+"&fyy="+mymm.substring(0,4)+"&fmm="+mymm.substring(5,7);
		//out.print("飛時差額大於12小時");
		//response.sendRedirect("showmessage.jsp?messagestring="+URLEncoder.encode("飛時差額不得大於12小時！！")+"&messagelink=Back to previous&linkto=javascript:history.back(-2);");
		xMessagestring = URLEncoder.encode("飛時差額不得大於12小時！！");
		xMessagelink = "Back to previous";
		xLinkto = "empno="+rempno+"&fyy="+mymm.substring(0,4)+"&fmm="+mymm.substring(5,7);
		xMsgCode = "x6";
	}
}

String hh = null;  //A的飛時差額（時）
String mm = null;  //A的飛時差額（分）
String xa = null; 
String xb = null;
String hhb = null; //B的飛時差額（時）
String mmb = null;//B的飛時差額（分）

//將飛時差額不足為數者補0

	hh = String.valueOf(xam/60); //A的時
	if(hh.equals("0") &&xam<0){hh="-0";}	//小時數為0&為負時，加負號

	if(Math.abs(xam%60)< 10 ){	//A的分，不足兩位數補0
		mm = "0" + String.valueOf(Math.abs(xam%60));
	}
	else{
		mm =  String.valueOf(Math.abs(xam%60));
	}	
	
	xa = hh + mm;
	
	
	hhb = String.valueOf(xbm/60); //B的時
	if(hhb.equals("0") &&xbm<0){hhb="-0";}//小時數為0&為負時，加負號

	if(Math.abs(xbm%60)< 10 ){	//B的分，不足兩位數補0
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
      <td width="15%" class="txttitle"><b>C ±X=</b></td>
      <%
	int cx = 0;
	int dx = 0;
	String ea = null;
	String fb = null;
		int cam = Integer.parseInt(aprjcr.substring(0,3)) *60 + Integer.parseInt(aprjcr.substring(3,5));
				//A的Project Credit Hour以分鐘計
      	 cx= cam+xam;	//A的換後總飛時，以分鐘計
		if(cx%60 <10){	//A的換後總飛時，分的部分若不足兩位，補0
			ea = String.valueOf(cx/60) + "0"+String.valueOf(cx%60);
		}
		else{
			ea = String.valueOf(cx/60) + String.valueOf(cx%60);
		}
	
	/**********************************************************************/
	
		int cbm = Integer.parseInt(rprjcr.substring(0,3)) *60 + Integer.parseInt(rprjcr.substring(3,5));
				//B的Project Credit HOur以分鐘計
      	 dx= cbm+xbm; //B的換後總飛時，以分鐘計
		if(dx%60 <10){	//B的換後總飛時，分的部分若不足兩位，補0
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
      <td width="19%" class="txttitle"><b>D ±X=</b></td>
      <td width="23%" class="tablebody"><%=fb%> 
        <input type="hidden" name="rttfly" value="<%=fb%>">
      </td>
    </tr>
    <tr> 
      <td class="tablebody"> 
        <div align="center"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000FF">Extra Pay Hours</font></div>
      </td>
      <%
	  // 計算超時給付時，若(每單項-75hrs)<0，則以0計算
   int e,f,c,d;	//efcd是分鐘數
   e = cx-(75*60);
  	 if (e<0){e=0;}
   
   f = dx-(75*60);
 	  if(f<0){f=0;}

   c = cam-(75*60);
 	  if(c<0){c=0;}

   d = cbm-(75*60);
 	  if(d<0){d=0;}
   
   //以分鐘計的swap
   float swapm = (e+f)-(c+d);
 
   //換成時數
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

   if (swap > 5){	//換後超時給付>5hrs，不得申請
   
/****************************
      <jsp:forward page="showmessage.jsp"> 
      <jsp:param name="messagestring" value="換班後超時給付大於五小時，不得申請。請重新填寫換班申請單！<br>Extra Pay Hours over 5 hours!!" />
	  <jsp:param name="messagelink" value="Back to previous" />
	  <jsp:param name="linkto" value="javascript:history.back(-2);" />
      </jsp:forward>
***********************************/
	flag = true;
	//redirectUrl = "showmessage.jsp?messagestring=換班後超時給付大於五小時，不得申請。請重新填寫換班申請單！<br>Extra Pay Hours over 5 hours!!&messagelink=Back to previous&linkto=applicant.jsp?empno="+rempno+"&fyy="+mymm.substring(0,4)+"&fmm="+mymm.substring(5,7);
	xMessagestring = URLEncoder.encode("換班後超時給付大於五小時，不得申請。請重新填寫換班申請單！<br>Extra Pay Hours over 5 hours!!");
	xMessagelink = "Back to previous";
	xLinkto = "empno="+rempno+"&fyy="+mymm.substring(0,4)+"&fmm="+mymm.substring(5,7);
	xMsgCode = "x7";
}  
%> 

      <td colspan="4" class="tablebody"> 
        <%
	if (swap <=0){	//換後超時給付<=0，顯示超時給付為No
	out.print("No");
	swap = 0;
	}

	
	if ( (swap>0) && (swap<=5) ){	//換後 0<超時給付<=5，顯示超時給付為計算出來的超時給付
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
	//組員申請單上的意見
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
	out.println("飛時差額不得大於12小時！！");
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
alert("Please Query Again！！\n請重新查詢！");
self.location="blank.htm";
}
<%
//修改處
if(flag){
		//response.sendRedirect("showmessage.jsp?messagestring="+URLEncoder.encode("飛時差額不得大於12小時！！")+"&messagelink=Back to previous&linkto=javascript:history.back(-2);");
		//URLEncoder.encode('飛時差額不得大於12小時！！')
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
<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*,java.sql.Date,fz.*,ci.auth.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first
	response.sendRedirect("sendredirect.jsp");
}else{ 

if( session.getAttribute("cabin") == null)
{
	session.setAttribute("cabin","N");
}

//���o�O�_��PowerUser
String  unidCD=  (String) session.getAttribute("fullUCD");	//get unit cd
fzAuth.UserID userID = new fzAuth.UserID(sGetUsr,null);
fzAuth.CheckPowerUser ck = new fzAuth.CheckPowerUser();
// ck.isHasPowerUserAccount()  ���ˬd�O�_���b���A���ˬd�K�X
//add by Betty ****************************************
ci.auth.GroupsAuth ga = new ci.auth.GroupsAuth(sGetUsr);
ga.initData();
//*******************************************************
boolean ifdispaly = false;
if("EDUser".equals(sGetUsr))
{
	ifdispaly = true;
}
%>
<html>
<head>
<title>Tsa Left Frame</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../menu.css" rel="stylesheet" type="text/css">
<style type="text/css">
body,a{
font-family:Verdana, Arial, Helvetica, sans-serif;font-size:10pt;}
</style>
<script language="JavaScript" type="text/JavaScript">
function load(w1,w2)
{
		parent.topFrame.location.href=w1;
		parent.mainFrame.location.href=w2;
}
</script>

<body bgcolor="#99ccff" >
<p><a href='javascript:load("dailycrew/dailyquery.htm","../blank.htm")'>Daily Check</a></p>
<p><a href='javascript:load("dailycrew/dailyqueryOpen.htm","../blank.htm")'>OPEN Flight List</a></p>
<p><a href="#" class="txtblue" onClick='load("../alienCrewSign/alienCrewSign_query.jsp","../blank.htm")'>�~���խ�ñ���</a></p>
<p><a href="#" class="txtblue" onClick='load("../payHr/payHr_querycond.jsp","../blank.htm")'>Pay Hour</a></p>
<%
if(ck.isHasPowerUserAccount() |  "190A".equals(unidCD) ){ %>
    <p><a href="#" class="txtblue" onClick='load("../payHr/dutyHr_querycond.jsp","../blank.htm")'>Duty Hour</a></p>
    <p><a href="#" class="txtblue" onClick='load("../payHr/dutyHr_emp_querycond.jsp","../blank.htm")'>Emp Duty Hour</a></p> <% 
}//if%>

<%
//KHH Daily Check,�����ŪA�A�����|�p, TPEED�i��
if("631A".equals(unidCD) || "635".equals(unidCD) || "190A".equals(unidCD)  ||ck.isHasPowerUserAccount() || ifdispaly == true ||  ga.isBelongThisGroup("CIIKHHGD"))
{
%>
<p><a href="javascript:load('dailycrew/KHHDailyCheckQuery.jsp','../blank.htm')" >KHH Daily Check</a></p>
<%
}

//***************************************
if("640790".equals(sGetUsr) || "643937".equals(sGetUsr) )
{
%>
<p><a href="javascript:load('../blank.htm','khhnobus/nobusMenu.jsp')" >�L�������O�@�~</a></p>
<%
}	
//***************************************
%>

<a href='javascript:load("../GD/gdQuery.jsp","../blank.htm")'>Web GD</a><br>
<hr>
<!-- 2009/10/14 -->
²��CrewList<br>
<a href="http://tpecsap03.china-airlines.com/outstn/GBCabinCrewListv2.aspx" target="mainFrame">Normal</a>
<a href="http://tpecsap04.china-airlines.com/outstn/GBCabinCrewListv2.aspx" target="mainFrame">Backup</a>
<a href="http://tpecsap03.china-airlines.com/fz/FZLogin.aspx" target="_blank">eMail OutStation</a>
<hr>
<p><a href='javascript:load("../apis/sendapisQuery.jsp","../apis/blank.htm")'>��ʵo�eAPIS</a></p>
<p><a href='javascript:load("../apis/apis_sentlog_query.jsp","../apis/blank.htm")'>APIS�o�e����</a></p>		  
<p><a href="javascript:load('../cta_app/app_au_cond.jsp','../blank.htm')">(AU) APP</a></p>
<p><a href="javascript:load('../cta_app/app_nz_cond.jsp','../blank.htm')">(NZ) APP</a></p>
<hr>
<a href='javascript:load("../acaodiff/acaodiff_query.jsp","../blank.htm")'>�ɶ����ů�Z</a>
<hr>
<%
if( "190A".equals(unidCD) || ck.isHasPowerUserAccount() || ifdispaly == true )
{
%>
<p><a href='javascript:load("../blank.htm","dailycrew/sbMenu.jsp")'>Standby Crew</a></p>
<p><a href="#" class="txtblue" onClick='load("../blank.htm","http://tpeweb03:9901/webeg/attendance/off/offsheet/offMenu.jsp?userid=<%=sGetUsr%>")'>�B�z����</a></p>

<%
}
else if(!"180B".equals(unidCD))
{
//�ŪA�|�p�A���Q���v Standby Crew�ﶵ
%>
<p><a href='javascript:load("dailycrew/SBquery.htm","../blank.htm")'>Standby Crew</a></p>
<%
}
%>

<% 
//CS40 2008/12/22
if (ck.isHasPowerUserAccount() || "190A".equals(unidCD) || "196".equals(unidCD) || "1811".equals(unidCD) || "1812".equals(unidCD) || "1813".equals(unidCD) || "631A".equals(unidCD) || "635".equals(unidCD) || "638716".equals(sGetUsr)){
   %><p><a href="#" class="txtblue" onClick='load("../extraACM/extraACM_query.jsp","../blank.htm")'>�u�ʬ����`�٭��[����</a></p><%
}//if

//SR2055 80% => DFA CS40 2012/3/2
if (ck.isHasPowerUserAccount() || "190A".equals(unidCD) || "638716".equals(sGetUsr)  ){
   %><p><a href="#" class="txtblue" onClick='load("../extraACM/dfa_query.jsp","../blank.htm")'>�u�ʬ���80%��DFA</a></p><%
}//if

//CS27 2011/12/23
if (ck.isHasPowerUserAccount() || "180B".equals(unidCD) || "190A".equals(unidCD) || "196".equals(unidCD) || "1811".equals(unidCD) || "1812".equals(unidCD) || "1813".equals(unidCD) || "631A".equals(unidCD) || "635".equals(unidCD) || "638716".equals(sGetUsr)){
   %><p><a href="#" class="txtblue" onClick='load("dailycrew/chkCopDuty.jsp","../blank.htm")'>TVL cop_duty_cd</a></p><%
}//if

//CS40 2011/10/03
if (ck.isHasPowerUserAccount() || "190A".equals(unidCD) || "196".equals(unidCD) || "1811".equals(unidCD) || "1812".equals(unidCD) || "1813".equals(unidCD) || "631A".equals(unidCD) || "635".equals(unidCD) || "638716".equals(sGetUsr)){
   %><p><a href="#" class="txtblue" onClick='load("../extraACM/ODpay_query.jsp","../blank.htm")'>OD Pay</a></p><%
}//if

%>

<p><a href='javascript:load("dailycrew/schQuery.jsp","../blank.htm")'>Schedule Query</a></p>
<p><a href='javascript:load("../blank.htm","dailycrew/crewListMenu.jsp")'>Crew List Query</a></p>
<p><a href="#" class="txtblue" onClick='load("../../FZ/crewshuttle/blank.html","../../FZ/crewshuttle/funcMenu.jsp")'>Crew Car</a></p>
<%
//************* set authorization to ���ؾ�,���R��,�ﷰ��,���Q�Z,�з��,���ڼ�,�L�q�S,������,���R��, ��d��,�d��P,������,���ŭ�,�}�d��//+�����z,�Q�f��,����
if (ck.isHasPowerUserAccount()  || "631931".equals(sGetUsr) || "631578".equals(sGetUsr) || "631711".equals(sGetUsr) || "634341".equals(sGetUsr) || "631255".equals(sGetUsr) || "634996".equals(sGetUsr) || "630131".equals(sGetUsr) || "642275".equals(sGetUsr) || "631714".equals(sGetUsr) || "628097".equals(sGetUsr) || "635023".equals(sGetUsr) || "638207".equals(sGetUsr) || "630162".equals(sGetUsr) || "628948".equals(sGetUsr) || "632970".equals(sGetUsr) || "632072".equals(sGetUsr) || "639088".equals(sGetUsr) || "635810".equals(sGetUsr) || "628653".equals(sGetUsr))
{
%>
<!--<p><a href="load('../../DF/pock/blank.htm','../../DF/pock/editAdjt.jsp')">�����u�ɽվ�  </a></p>-->
<p><a href="javascript:load('../../DF/pock/blank.htm','../../DF/pock/overtimeMenu.jsp')">�����u�ɥ\����@</a></p>
<%
}

//Start: 2009-10-14 CS40
// 190A: TPEED, 790A: KIXEM, 811: BKKEM, 8508: NRTEM
if(ck.isHasPowerUserAccount() |  "190A".equals(unidCD) | "790A".equals(unidCD) | "811".equals(unidCD) | "8508".equals(unidCD)){ %>
   <p><a href='javascript:load("dailycrew/crewListForPurQuery.htm","../blank.htm")'>Flight Crew List</a></p> <%
}//if
//End: 2009-10-14 CS40


/*
	20080214 ���ŪA��F�եN���A��181D�אּ 1811, 1812, 1813
	*/
//ED.EA.�i��
//EB 2009-11-27 CS40
if( ck.isHasPowerUserAccount() 	|  "190A".equals(unidCD)  | "1811".equals(unidCD) | "1812".equals(unidCD) | "1813".equals(unidCD) | "180B".equals(unidCD)){ %>
   
   <p><a href='javascript:load("../blank.htm","mealtaxi/mealtaxiMenu.jsp")'>�~�\/�~���@�~</a></p><%
   
   if ( !"180B".equals(unidCD) ) { %>
      <p><a href='javascript:load("../../FZ/blank.htm","ACUtil/ACUtilMenu.jsp")'>CIA �b���޲z</a></p>
      <!--  cs40  2006/06/28 -->
      <p><a href='javascript:load("../../FZ/blank.htm","../../FZ/mcl/mcl_cond.jsp")'>MCL</a></p>
      <p><a href='javascript:load("../../EG/rpt/crewPassQ.htm","../../FZ/blank.htm")'>Crew Passport</a></p><% 
      //�}��� 633248; ������634283; �}�Q�f638716; ���A�s627051, �Q�f��635810
      if (ck.isHasPowerUserAccount()  | "1812".equals(unidCD) | "1813".equals(unidCD) || "638716".equals(sGetUsr))
	  {
	      %><p><a href='javascript:load("../../EG/AC/EGInfoquery.jsp","../../FZ/blank.htm")'>AirCrews Import</a></p>
	    <!-- 2012-2-4 romoved by cs40 due WebAPIS go-live   <p><a href='javascript:load("../apis/apisQuery3.jsp","../apis/blank.htm")'>APIS check report III</a></p> -->
<%
	   }//if
	}//if
}//if

if (ck.isHasPowerUserAccount()  ||  "190A".equals(unidCD) ||  "189".equals(unidCD) || "195B".equals(unidCD) || "180B".equals(unidCD) | ga.isBelongThisGroup("EZEFOFFICE") | ga.isBelongThisGroup("EZEFKHH") | ifdispaly == true )
//if ("640790".equals(sGetUsr))
{
	if (ck.isHasPowerUserAccount()  ||  "190A".equals(unidCD)  || "195B".equals(unidCD) || "180B".equals(unidCD) | ga.isBelongThisGroup("EZEFREAD"))
	//if ("640790".equals(sGetUsr))
	{
	%>
	<!--���@�֩�/������ *************************************************************** -->
	<p><a href="#" class="txtblue" onClick='load("../blank.htm","../housing/adm/housingMenu.jsp")'>���@�֩�/������</a></p>
	<!--���@�֩�/������ *************************************************************** -->
	<%
	}
	%>
	<!--�n�I�ﴫ�Z *************************************************************** -->
	<p><a href="#" class="txtblue" onClick='load("../blank.htm","../credit/adm/creditMenu.jsp")'>����/�n�I�ﴫ�Z</a></p>
	<!--�n�I�ﴫ�Z *************************************************************** -->
<%
}
%>
<p><a href='javascript:load("AUH/crewlistquery.jsp","../blank.htm")'>�~�� Crew List</a></p>
<%
//ED�i��
if(ck.isHasPowerUserAccount() |  "190A".equals(unidCD) )
{
%>
<p><a href="#" class="txtblue" onClick='load("../blank.htm","../../FZ/aircrews_deadlock/aircrews_deadlock.jsp")'>AirCrews Deadlock</a></p>
<p><a href='javascript:load("../blank.htm","ACMList/segMenu_cabin.jsp")'>ACM List</a></p>
<p><a href='javascript:load("../../FH/fhquery.jsp","../blank.htm")'>��ɤ���</a></p>
<p><a href='javascript:load("../../FH/whquery.jsp","../blank.htm")'>�u�@�W��</a></p>
<p><a href='javascript:load("../../FZ/blank.htm","../../Log/msgAC.txt")'>CIA���զ^������</a> </p>
<p><a href='javascript:load("Italy/monQuery.jsp","../blank.htm")'>���q�j�Q�խ��W��</a></p>
<p><a href='javascript:load("SCH/crewSchequery.htm","../blank.htm")'>��Z��PROD</a></p>
<!-- <p><a href='javascript:load("AUH/crewlistquery.jsp","../blank.htm")'>�~�� Crew List</a></p> -->
<p><a href='javascript:load("dailycrew/flightPeriodQuery.jsp","../blank.htm")' >Flight Period Query </a></p>
<p><a href='javascript:load("../blank.htm","../../EG/AC/chkList.jsp")'>Check AL/XL</a></p>
<%
}

//ED & EF & KHH
//2008/12/23 CS40
if(ck.isHasPowerUserAccount() || "190A".equals(unidCD) || "195B".equals(unidCD) || "196".equals(unidCD) || "197".equals(unidCD) || "198".equals(unidCD) || "199".equals(unidCD) || "635".equals(unidCD)){ 
   %><p><a href='javascript:load("../blank.htm","../SMSAC/SMSQuery.jsp")'>²�T�q��</a></p><%
}


if(ifdispaly == true)
{
%>
<p><a href='javascript:load("dailycrew/crewListForPurQuery.htm","../blank.htm")'>Flight Crew List</a></p>
<p><a href='javascript:load("dailycrew/flightPeriodQuery.jsp","../blank.htm")' >Flight Period Query </a></p>
<p><a href='javascript:load("../blank.htm","../SMSAC/SMSQuery.jsp")'>²�T�q��</a></p>
<p><a href="#" class="txtblue" onClick='load("../blank.htm","eduserpwd/editeduserpwd.jsp")'>Change  PWD</a></p>

<%
}

if("635".equals(unidCD) | "811".equals(unidCD) | "837".equals(unidCD) | "827".equals(unidCD) | "850".equals(unidCD) | "8501".equals(unidCD) )
{
%>
<p><a href='javascript:load("../../EG/rpt/crewPassQ.htm","../../FZ/blank.htm")'>Crew Passport</a></p>
<p><a href='javascript:load("SCH/crewSchequery.htm","../blank.htm")'>��Z��PROD</a></p>
<p><a href='javascript:load("dailycrew/crewListForPurQuery.htm","../blank.htm")'>Flight Crew List</a></p>
<%
}

//�~���i�� [�~�� Crew List]
//SR7216
/*
�~��UnitCode,
SINEM�G837,SGNEM�G827,BKKEM�G811,NRTEM�G8501,TPEEA�G181D
*/
/*
	20080214 ���ŪA��F�եN���A��181D�אּ 1811, 1812, 1813
	*/
if("811".equals(unidCD) | "837".equals(unidCD) | "827".equals(unidCD) | "8501".equals(unidCD) | "1811".equals(unidCD) | "1812".equals(unidCD) |  "1813".equals(unidCD) )
{
%>
<p><a href='javascript:load("AUH/crewlistquery.jsp","../blank.htm")'>�~�� Crew List</a></p>
<%

}
//SINDM
if("830".equals(unidCD) | "790A".equals(unidCD) | "811".equals(unidCD) | "8508".equals(unidCD))
{
%>
<p><a href='javascript:load("dailycrew/crewListForPurQuery.htm","../blank.htm")'>Flight Crew List</a></p>
<%
}

if("190A".equals(unidCD) | "176D".equals(unidCD) )
{	
%>
<!-- Betty adds -->
<!-- 2012-2-4 romoved by cs40 due WebAPIS go-live <a href='javascript:load("../apis/apisQuery3.jsp","../apis/blank.htm")'>APIS check report III</a><br> -->
<%
}

//CS40 2009/2/04
//if (ck.isHasPowerUserAccount() || "189".equals(unidCD) || "638716".equals(sGetUsr)|| "626791".equals(sGetUsr)|| "629648".equals(sGetUsr) || "rick".equals(sGetUsr)){
   %>
   <p><a href="#" class="txtblue" onClick='load("../paraw2011/paraw_querycond.jsp","../blank.htm")'>PA Raw Score(2011��)</a></p>
   <p><a href="#" class="txtblue" onClick='load("../paraw2011/pa_rawline_querycond.jsp","../blank.htm")'>PA Raw+Line(2011��)</a></p>
   <!-- <p><a href="#" class="txtblue" onClick='load("../paraw/paraw_querycond.jsp","../blank.htm")'>PA Raw Score(2009)</a></p>  -->
   <!-- <p><a href="#" class="txtblue" onClick='load("../paraw/pa_rawline_querycond.jsp","../blank.htm")'>PA Raw+Line(2009)</a></p>  -->
   <%
//}//if

//CS40 2011/4/5
if (ck.isHasPowerUserAccount()  ||  "189".equals(unidCD) ){  %>
   
<p><a href="#" class="txtblue" onClick='load("../../R5XX/r5xx_querycond.jsp","../blank.htm")'>�ŰV�W��d��</a></p>
<%
}//if


if(sGetUsr.equals("632544") || sGetUsr.equals("638716") || sGetUsr.equals("633987") || sGetUsr.equals("631931") ||
   sGetUsr.equals("641090") ||sGetUsr.equals("633403")  || sGetUsr.equals("640515") ||
   sGetUsr.equals("634319") || sGetUsr.equals("640073") || sGetUsr.equals("640790"))
{
	%>
	<!-- cs40  2007/12/18 add--><p class="txtblue"><a href='javascript:load("../../FZ/loadleave/loadleave_querycond.jsp","../../FZ/blank.htm")'>Cabin Load Leave</a></p>
	<%
}//if

//�ŪA��F�i��,�խ�²�T�޲z�\��,SR8020
if( ck.isHasPowerUserAccount() 	 | "1811".equals(unidCD) | "1813".equals(unidCD) | "1812".equals(unidCD))
{
%>
<a href='javascript:load("../../FZ/blank.htm","../AC/crewKindred/AdmMenu.jsp")' class="txtblue" >�խ��a��²�T</a><br>
<%	 
}

if (ck.isHasPowerUserAccount() | "1811".equals(unidCD) | "1812".equals(unidCD) | "1813".equals(unidCD) | "190A".equals(unidCD)  | "197".equals(unidCD) | sGetUsr.equals("638716")){ 
   %><p><a href='javascript:load("dailycrew/out_stn_query.htm","../blank.htm")'>�ȶԦW��</a></p> 
     <p><a href="#" class="txtblue" onClick='load("../payHr/payHr_querycond.jsp","../blank.htm")'>Pay Hour</a></p><%
}

%><p><a href="#" class="txtblue" onClick='load("../payHr/onduty_querycond.jsp","../blank.htm")'>�C��խ��X�ԤH��</a></p><%

//EF , ED
if(ck.isHasPowerUserAccount() || "190A".equals(unidCD) || "195B".equals(unidCD)  || "199".equals(unidCD) || sGetUsr.equals("638716") ){ 
   %><p><a href="#" class="txtblue" onClick='load("../blank.htm","../../FZ/noef/noef.jsp")'>NO EF</a></p><%
}

if(ck.isHasPowerUserAccount() )
{
%>
<p><a href="#" class="txtblue" onClick='load("../blank.htm","eduserpwd/editeduserpwd.jsp")'>Change EDUser Password</a></p>
<p><a href="cspage.jsp" target="_top"><span style="color:#003333;background-color:#FFCCFF;padding:2pt; ">��ܵn�J����</span></a></p>
<%
}
%>

<%
//if("640790".equals(sGetUsr))
//{
%>
<hr><table><tr><td bgcolor="#990000"><font color="#FFFFFF">NGB��Ʀ���</font></td></tr></table>
<p><a href="#" class="txtblue" onClick='load("../blank.htm","../../FZ/ngbForm/mgt_ack.jsp")'>�խ�Ack</a></p>
<p><a href="#" class="txtblue" onClick='load("../blank.htm","../../FZ/ngbForm/mgt_select.jsp")'>�խ��w�^��</a></p>
<p><a href="#" class="txtblue" onClick='load("../blank.htm","../../FZ/ngbForm/mgt_notreply.jsp")'>�խ����^��</a></p>
<p><a href="#" class="txtblue" onClick='load("../blank.htm","../../FZ/ngbForm/mgt_acfile.jsp")'>AirCrewsImport���˵�</a></p>
<hr> <p><a href="http://tpecsap03/outstn/ChnNameEdit.aspx" target="mainFrame">²�餤��m�W���@</a></p>
<hr>  <%
	//}	
%>

<p><a href='javascript:load("../blank.htm","sendredirect.jsp")'>Logout</a></p>
</body>
</html>
<%
}//end of has session
%>
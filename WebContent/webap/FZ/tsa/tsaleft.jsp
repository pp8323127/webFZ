<%
/* ------------------------------------------------------------------------------------------------- 
source modify history
Ver   date       who  SRno. description  
V2701 2005/03/10 CS27       modify [CrewRec] sequence
                            mark item "Crew REC Edit"
							mark unidCD.equals("05") || unidCD.equals("06") <=���B�i edit CrewRec?
V0902 2009/7/17 CS27  mod new SIMCHK query report
                      mod menu.css
v???? 2009/08/25 cs57 add cs57 auth
-----------------------------------------------------------------------------------------------------
*/
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
String fullUCD = (String) session.getAttribute("fullUCD");//get full unit code
String  unidCD=  (String) session.getAttribute("unidCD");	//get unit cd
String FLEET340330 =  (String)session.getAttribute("340330FLEET"); //SR7048,340/330�����H��

//���o�O�_��PowerUser
fzAuth.UserID userID = new fzAuth.UserID(sGetUsr,null);
fzAuth.CheckPowerUser ck = new fzAuth.CheckPowerUser();
// ck.isHasPowerUserAccount()  ���ˬd�O�_���b���A���ˬd�K�X

if( session.getAttribute("cabin") == null){
	session.setAttribute("cabin","Y");
}

response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

if (session.isNew()) 
{		//check user session start first
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 
if (sGetUsr == null) 
{		//check if not login
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 
%>
<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*,java.sql.Date,fz.*"%>
<html>
<head>
<title>Tsa Left Frame</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link type="text/css" href="/webdz/css/jquery-ui-1.8.2.custom.css" rel="stylesheet" />
<link href="../menu.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
<!--
var sOgImpUrl = "/webdz/OG/vhdbquery.jsp?sGetUsr=<%=sGetUsr%>";

function fnOnLoad()  {
	//document.getElementById('userid').focus();
	var sMyURL = document.URL ;
	var sPort = location.port;
	var sPath = location.pathname ;
	var sCAL = ".china-airlines.com" ;
	var iCAL = sMyURL.indexOf(sCAL) ;
	var iPort = sMyURL.indexOf(sPort);
	var iPath = sMyURL.indexOf(sPath);

	var sOgImpPath = "/webdz/OG/vhdbquery.jsp?sGetUsr=<%=sGetUsr%>" ;
	if (iCAL==-1) {
		//"http://tpeweb03:9901/webdz/OG/vhdbquery.jsp?sGetUsr=<%=sGetUsr%>" 
		if (iPort==-1) { 
			sOgImpUrl = sMyURL.slice(0,iPath)+sCAL+sOgImpPath  ;  //if no port
		} else { 
			sOgImpUrl = sMyURL.slice(0,iPort-1)+sCAL+":"+sPort+sOgImpPath ;
		}
	}  /**/
	/*
	if (iCAL==-1) { 
			//alert(navigator.appName);
		if (navigator.appName=="Netscape") {
		         	window.location.replace(newUrl);	//FireFox
		} else { 	location.replace(newUrl);			//IE	
		}
		//alert(navigator.appName);
	} ;  /**/

	//window.resizeTo(screen.availWidth,screen.availHeight);
	//window.moveTo(0,0);
	//window.focus();
	//document.form1.userid.focus();
}

function fnOpenWinOgImp() {
	wOgImp = window.open(sOgImpUrl,"OGImport","location=0,width=800,height=600") ;
	//parent.document.getElementById(fid).setAttribute('rows', cols);
	return true;
}

function fnLoadOgImp() {
	//parent.document.getElementById(fid).setAttribute('rows', cols);
	//parent.document.getElementById('fr11').window.location.href = sOgImpUrl ;
	//window.parent.document.getElementById("fr11").innerHTML = sOgImpUrl ;
	//$("#fr11", window.parent.document).html(sOgImpUrl) ;
	//function changePage(strPage)
	parent.topFrame.location.href = sOgImpUrl; /*This line is the one that changes the baseFrame frame URL.  strPage can be substituded with a hardcoded string.*/
	return true;
}

function mmLoadMenus() {
  if (window.mm_menu_0507104828_0) return;
  window.mm_menu_0507104828_0 = new Menu("root",80,18,"",12,"#000000","#FFFFFF","#CCCCCC","#000084","left","middle",3,0,1000,-5,7,true,true,true,0,true,true);
  mm_menu_0507104828_0.addMenuItem("Query");
  mm_menu_0507104828_0.addMenuItem("Edit&nbsp;&&nbsp;Add","location='../../FLOG/edflogmenu.htm'");
   mm_menu_0507104828_0.hideOnMouseOut=true;
   mm_menu_0507104828_0.bgColor='#555555';
   mm_menu_0507104828_0.menuBorder=1;
   mm_menu_0507104828_0.menuLiteBgColor='#FFFFFF';
   mm_menu_0507104828_0.menuBorderBgColor='#777777';

   window.mm_menu_0507105401_0 = new Menu("root",80,18,"",12,"#000000","#FFFFFF","#CCCCCC","#000084","left","middle",3,0,1000,-5,7,true,true,true,0,true,true);
   mm_menu_0507105401_0.addMenuItem("Query","window.open('../../FLOG/Query/edfFlightQ.jsp', 'topFrame');");
   mm_menu_0507105401_0.addMenuItem("Edit&nbsp;&&nbsp;Add","window.open('../../FLOG/edflogmenu.htm', 'topFrame');");
   mm_menu_0507105401_0.addMenuItem("TravelHrs","window.open('../TravelHrs/query.htm', 'topFrame');");
   mm_menu_0507105401_0.hideOnMouseOut=true;
   mm_menu_0507105401_0.bgColor='#555555';
   mm_menu_0507105401_0.menuBorder=1;
   mm_menu_0507105401_0.menuLiteBgColor='#FFFFFF';
   mm_menu_0507105401_0.menuBorderBgColor='#777777';
   window.mm_menu_0507105618_0 = new Menu("root",118,18,"",12,"#000000","#FFFFFF","#CCCCCC","#000084","left","middle",3,0,1000,-5,7,true,true,true,0,true,true);
   //mm_menu_0507105618_0.addMenuItem("Crew&nbsp;REC Report","window.open('crewrecquery.htm', 'topFrame');");
<% //insert�PModify�\��A����H�U�X�ӤH�~��ݨ�A��LCrew info�ﶵ�A�Ҧ���ȳB���ҥi�ݨ�
  if (sGetUsr.equals("640412") || sGetUsr.equals("640354") || sGetUsr.equals("632357") || sGetUsr.equals("638716") || sGetUsr.equals("640073") || sGetUsr.equals("633007") || sGetUsr.equals("637299") || sGetUsr.equals("638736") || sGetUsr.equals("632283"))
  {	//640412:�d�q�� 640354:�i��� 632357:������ 638716:cs55 640073:cs66 633007:cs27

%>
  mm_menu_0507105618_0.addMenuItem("�i���q�eREC","window.open('CrewRdInsMenu.jsp', 'mainFrame');");
  mm_menu_0507105618_0.addMenuItem("Crew&nbsp;REC Edit","window.open('queryrecord.jsp', 'topFrame');");
  mm_menu_0507105618_0.addMenuItem("Crew&nbsp;insert","window.open('adddfcrew.jsp', 'mainFrame');");
  mm_menu_0507105618_0.addMenuItem("Crew&nbsp;Modify","window.open('dfcrewmod.htm', 'topFrame');");
  mm_menu_0507105618_0.addMenuItem("Edit&nbsp;License","window.open('http://tsaweb02:8099/LIC/edlicquery.htm', 'topFrame');");
  mm_menu_0507105618_0.addMenuItem("USA&nbsp;Station","window.open('station.jsp', 'mainFrame');");
  mm_menu_0507105618_0.addMenuItem("1000Hrs&nbsp;Check Save","window.open('../crewhr/1000hrqry.htm', 'topFrame');");
  mm_menu_0507105618_0.addMenuItem("Crew&nbsp;BLKhr(cLocal)","window.open('crewlocquery.htm', 'topFrame');");
  mm_menu_0507105618_0.addMenuItem("Crew&nbsp;BLKhr(Local)","window.open('topframe5.jsp', 'topFrame');");
<%

}
%>  
  //mm_menu_0507105618_0.addMenuItem("Crew&nbsp;BLKhr(OPS Edit)","window.open('crewopsquery.htm', 'topFrame');");
  mm_menu_0507105618_0.addMenuItem("Crew&nbsp;BLKhr(TPE)","window.open('topframe2.jsp', 'topFrame');");
  mm_menu_0507105618_0.addMenuItem("Crew&nbsp;BLKhr(Log)","window.open('topframe3.jsp', 'topFrame');");
//cs27 2005/01/14 mark for OS
  mm_menu_0507105618_0.addMenuItem("Crew&nbsp;PIChr(Log)","window.open('topframe4.jsp', 'topFrame');");
   mm_menu_0507105618_0.hideOnMouseOut=true;
   mm_menu_0507105618_0.bgColor='#555555';
   mm_menu_0507105618_0.menuBorder=1;
   mm_menu_0507105618_0.menuLiteBgColor='#FFFFFF';
   mm_menu_0507105618_0.menuBorderBgColor='#777777';

mm_menu_0507105618_0.writeMenus();
} // mmLoadMenus()
//-->
</script>
<script language="JavaScript" src="mm_menu.js"></script>
</head>
<script language="JavaScript" type="text/JavaScript">
function load(w1,w2){
		parent.topFrame.location.href=w1;
		parent.mainFrame.location.href=w2;
}
function change(id,pi){  //���h���[�c
	 if (document.all[id].style.display=="none") { //�Y������	  
		document.all[id].style.display=""  //�h�N�����
		document.all[pi].src="../images/open.gif"    //�X�{open�Ϯ�
	  }
	 else	  {
		document.all[id].style.display="none"  //���
		document.all[pi].src="../images/close.gif"		//�X�{close�Ϯ�
	  } 
}

function opWinJZ() { window.open("http://tpeweb03:5401/webjc/SR6041.jsp"); }
</script>

<body bgcolor="#99ccff" onload="fnOnLoad()">
OZ CII
<hr>
<script language="JavaScript1.2">mmLoadMenus();</script>
<div id="leftPane">
<font class="first">Crew Counter</font>
<a href="#" onClick='load("daily/dailyquery.htm","../blank.htm")'>Daily Check</a>

<a href="#" onClick='load("../GD/gdQuery.jsp","../blank.htm")'>Web GD</a> 
<!-- a href="#" onClick='load("ACMList/ACMListtop.html","ACMList/segMenu_cockpit.jsp")'>ACM �q��</a 
  2010/01 --> 
<a href="#" onClick='load("../blank.htm","checkInTime.jsp")'>CheckIn Time</a>
<!--<a href="#" onClick='load("tsaquery.htm","../blank.htm")'>TSA Schedule</a> -->

<%
//if( "634319".equals(sGetUsr) | "633182".equals(sGetUsr) | "634613".equals(sGetUsr) | "632283".equals(sGetUsr) | "643937".equals(sGetUsr)) { %>
<a href="#" onClick='load("../payHr/pilot_dp_fdp_block_credit_querycond.jsp","../blank.htm")'>DP/FDP/Block/Credit</a>
<!--<a href="#" onClick='load("../payHr/pilot_dp_querycond.jsp","../blank.htm")'>DP Hour</a>-->
<!--<a href="#" onClick='load("../payHr/pilot_ft_querycond.jsp","../blank.htm")'>FDP Hour</a>-->
<%//}%>

</div>
<!-- 2009/10/14 -->
<font size: 8pt>²��CrewList</font><br>
<a href="http://tpecsap03.china-airlines.com/outstn/GBCabinCrewListv2.aspx" target="mainFrame">Normal</a>
<a href="http://tpecsap04.china-airlines.com/live/outstn/GBCabinCrewListv2.aspx" target="mainFrame">Backup</a>

<!--<p><a href="#" class="txtblue" onClick='load("tsaquery_apis.htm","../blank.htm")'>TSA APIS</a> </p>-->
<br><a href="http://tpecsap03.china-airlines.com/fz/FZLogin.aspx" target="_blank">eMail OutStation</a>
<br><a href="http://tpecsap03/outstn/ChnNameEdit.aspx" target="mainFrame">²�餤��m�W���@</a>
<br><a href='javascript:load("../apis/sendapisQuery.jsp","../apis/blank.htm")'>��ʵo�eAPIS</a>
<br><a href='javascript:load("../apis/apis_sentlog_query.jsp","../apis/blank.htm")'>APIS�o�e����</a>
<br><a href="javascript:load('../cta_app/app_au_cond.jsp','../blank.htm')">(AU) APP</a>
<br><a href="javascript:load('../cta_app/app_nz_cond.jsp','../blank.htm')">(NZ) APP</a>	  
<br><a href="#" onClick='load("../../FZ/cta_app/blank.htm","../../FZ/cta_app/cta_cond.jsp")'>CTA</a>
<% if ( "634319".equals(sGetUsr) | "633182".equals(sGetUsr) ) { %> 
       <br><a href="javascript:load('../dealloc/dealloc_cond.jsp','../blank.htm')">De-Allocation</a>
<% } %>
 <hr>
<div id="leftPane">
OS Office
<%
if (!sGetUsr.equals("123456"))
{
%>
  <!--<p><a href="#" class="txtblue" onClick='load("tsaCrewInfoQ.htm","../blank.htm")'>TSA Crew Info</a><br></p>-->
  <a href="#" onClick='load("crewhrv2.html","../blank.htm")'>��ž��r�p���ɮ�</a> <a href="#" onClick='load("http://tpeweb03:9901/webdz/catiii/topframe.jsp","../blank.htm")'>CATII/III</a> 
  <a href="#" onClick='load("http://tpeweb03:9901/webdz/catiii/catiiQ_new.htm","../blank.htm")'>CATII/III report</a>
  <!-- <a href="#" onClick='load("http://tpeweb03:9901/webdz/catiii/catiiQ.htm","../blank.htm")'>CATII/III report</a> --->
     
  <%
if (sGetUsr.equals("640354") | sGetUsr.equals("640790") | sGetUsr.equals("633007") | sGetUsr.equals("638716")
    | sGetUsr.equals("632357") | sGetUsr.equals("637299") | sGetUsr.equals("632283") )
{
%>
  <a href="#" onClick='load("http://tpeweb03:9901/webdz/catiii/selFleet.htm","../blank.htm")'>Email 
  CATII/III Unqualified</a> 
  <%
}
%>
  <a href="#" class="txtblue" onClick='load("crewrecquery.htm","../blank.htm")'>CrewRec</a> 
  <%
if (fullUCD.equals("068D") || sGetUsr.equals("638716") | sGetUsr.equals("640073") | sGetUsr.equals("637299")){
//068D�G������
%>
  <a href="#" class="txtblue" onClick='load("crewmaxq.jsp","../blank.htm")'>ReqFltAL 
  Max</a> 
  <!--<p class="txtblue"><a href="#" onClick='load("http://tpesunap01:5001/webfz/FZ/tsa/SCH/schequery.htm","../../FZ/blank.htm")'>������Z��TEST</a></p>-->
  <%
}
//��쬰��ȳB�~�i�ϥ� 05%, 06% OZ
//638716:cs55 640073:cs66 633007:cs27 638736:cs57
if(unidCD.equals("05") || unidCD.equals("06") || sGetUsr.equals("640790") || sGetUsr.equals("640073") || sGetUsr.equals("633007") || sGetUsr.equals("634319") || sGetUsr.equals("637299") || sGetUsr.equals("638736") || sGetUsr.equals("632283")){
%>
  <a href="#" onMouseOver="MM_showMenu(window.mm_menu_0507105618_0,12,12,null,'image1')" onMouseOut="MM_startTimeout();"><img src="../images/close.gif" name="image1" width="15" height="15" border="0" align="baseline" id="image1">&nbsp;<span class="txtblue">Crew 
  Check</span></a> <a href="#" onClick='load("../crewhr/crewhrqry_tpe.htm","../blank.htm")'>100hrs 
  Chk TPE</a> 
  <%
	//640412:�d�q�� 634613:�L�F�a  PowerUser
	//634069 SHI-JER CHOU �P�K�N OS
	if ( sGetUsr.equals("640412") || sGetUsr.equals("634613") || ck.isHasPowerUserAccount() || sGetUsr.equals("637299") || sGetUsr.equals("638736")|| sGetUsr.equals("634069") ){
		%>
  <!--<p class="txtblue"><a href="#" onClick='load("../crewhr/crewhrqry_tpe.htm","../blank.htm")'>100Hrs Check TPE</a> </p>-->
  <a href="#" onClick='load("crewops.htm","../../FZ/blank.htm")'>1000hrs Chk</a> 
  <%
	}
	//068D�G������ cs55
	if(fullUCD.equals("068D") || ck.isHasPowerUserAccount() || sGetUsr.equals("637299") || sGetUsr.equals("638736"))
	{
		%>
<!--  <a href="#" onClick='load("7days_over32hrsquery.htm","../../FZ/blank.htm")'>7��32�p�ɭ���</a>  -->
  <%
	}

	//051�G��F�� cs55
	if(fullUCD.equals("051") || ck.isHasPowerUserAccount() || sGetUsr.equals("637299") || sGetUsr.equals("638736")){
		%>
  <!-- <a href="#" onClick='load("http://tpeweb03:9901/webdz/OG/vhdbquery.jsp?sGetUsr=<%=sGetUsr%>","../blank.htm")'> -->
  <a href="#" onClick="fnLoadOgImp()">OG Import</a> 
  <%
	}
}
%>
  <a href="#" onClick='load("querycrew.htm","../blank.htm")'>Crew Query </a> 
  <!--<p<p class="txtblue"><a href="#" onClick='load("../crewhr/crewhrqry.jsp","../blank.htm")'>100Hrs Check LOC</a> </p>-->
  <!--<p class="txtblue"><a href="#" onClick='load("../crewhr/crewhrqry_tpe.htm","../blank.htm")'>100Hrs Check TPE</a> </p>-->
  <a href="#" onClick='load("../crewhr_aircrews/crewhrqry.htm","../blank.htm")'>100Hrs 
  AirCrews</a> <a href="#" onClick='load("LIC/licquery.htm","../blank.htm")'>Licence 
  Check</a> 
  <!--<p class="txtblue"><a href="#" onClick='load("crewops.htm","../../FZ/blank.htm")'>1000Hrs Check</a></p>-->
  <!--<p class="txtblue"><a href="#" onClick='load("../blank.htm","../crewcar/crewcar_indate.jsp")'> Crew Car</a></p>-->
  <a href="#" onClick='load("../../FZ/crewshuttle/blank.html","../../FZ/crewshuttle/funcMenu.jsp")'> 
  Crew Car</a> <a href="#" onClick='load("ChkSche/blank.html","ChkSche/segMenu.jsp")'>Working 
  days check</a> <a href="#" onClick='load("SCH/schequery.htm","../../FZ/blank.htm")'>������Z��PROD</a> 
  <a href="#" onClick='load("SCH/schequery2.htm","../../FZ/blank.htm")'>ELO��Z��</a> 
  <a href="#" onClick='load("SCH/schequery3.jsp","../../FZ/blank.htm")'>�խ���Z��</a> 
  <a href="#" onClick='load("Days_Off_Q.htm","../../FZ/blank.htm")'>Days Off</a> 
  <a href="#" onClick='load("daysOff/daysOffQuery.jsp","../../FZ/blank.htm")'>Days Off �p��</a> 
  <a href="#" onClick='load("../blank.htm","../../FZ/aircrews_deadlock/aircrews_deadlock.jsp")'>AirCrews Deadlock</a>
  <a href='javascript:load("../acaodiff/acaodiff_query.jsp","../blank.htm")'>�ɶ����ů�Z</a>
  <a href='javascript:load("../acaodiff/acaodiff_actp_query.jsp","../blank.htm")'>�������ů�Z</a>
  <a href="#" onClick='load("crewqualification.jsp","../../FZ/blank.htm")'>Crew Qualifications</a>
  <% if (sGetUsr.equals("634319") | sGetUsr.equals("634069")){ %>
      <a href="#" onClick='load("crewqualification_new.jsp","../../FZ/blank.htm")'>Crew Qualifications(New)</a>
  <% } //if%>
  <a href="#" onClick='load("../crewmeal/double_meal_query.jsp","../blank.htm")'>�S�O�\����</a>
  <%
}
//****************************1.�|���}��user�ϥ�	**********start**************
if(ck.isHasPowerUserAccount()){//CSOZEZ
%>
<hr>
  <span class="txtxred">**���հ�**</span> <a href="cspage.jsp" target="_top"><span style="color:#003333;background-color:#FFCCFF;padding:2pt; ">Change Menu</span></a> 
  <a href="tsaframe.jsp?mypage=tsaleft_adm.jsp" target="_top"><span style="color:#000000;background-color:#FFFFCC;padding:2pt; ">Test Menu</span></a>
  <%//******************************************************************** end **************
//�~�׽ưVtest url in tpesunap01 http://tpesunap01:5001/webfz/OZTrn/Menu.jsp?userid=<%=sGetUsr
}
//061,063:��ȭp���o�i��, 634319:�B�ӱj, 633007:�U�Ӵ}, 632286:�J����, 640354:�i���, 631539:�B�ۭ�, 642288:�i�귩, 638736:�B�q��, 640790:�E�q��, 632283:������
if(fullUCD.equals("061") || fullUCD.equals("063") || sGetUsr.equals("634319") || sGetUsr.equals("633007") || sGetUsr.equals("632286") || sGetUsr.equals("640354") || sGetUsr.equals("631539") || sGetUsr.equals("637299") || sGetUsr.equals("642288") || sGetUsr.equals("638736")|| sGetUsr.equals("640790")|| sGetUsr.equals("632283")){
	%>
	<!--  cs47  2006/01/05 TEST--><!--<p class="txtblue"><a href="#" onClick='load("http://tpesunap01:7001/webdk/dk_top.html","http://tpesunap01:7001/webdk/dk_menu.jsp")'>DK System (Post Flight Analysis)</a></p>-->
	<!--  cs47  2006/07/05 LIVE-->
<hr>
Post Flight Analysis <a href="#" onClick='load("http://tpeweb03:7001/webdk/dk_top.html","http://tpeweb03:7001/webdk/dk_menu.jsp")'>DK 
  Menu</a> 
  <%
}
//628170:�L�z��, 635987:�\�q�z, 639404:���ʺa, 636119:�}�妿, 635904:�¨Ω�, 633007:�U�Ӵ}, 642288:�i�귩, 638736:�B�q��,640790:�E�q��, 632283:������,634319:�B�ӱj
if(sGetUsr.equals("628170") || sGetUsr.equals("635987") || sGetUsr.equals("639404") || sGetUsr.equals("636119") || sGetUsr.equals("635904") || sGetUsr.equals("633007") || sGetUsr.equals("637299") || sGetUsr.equals("642288") || sGetUsr.equals("638736") || sGetUsr.equals("640790") || sGetUsr.equals("634319") || sGetUsr.equals("632283")){
	%>
  <!--  cs47  2008/06/19 TEST-->
  <!--<p class="txtblue"><a href="#" onClick='load("http://tpesunap01:7001/webdk/dkjsp007.jsp?sGetUsr=<%=sGetUsr%>","../../FZ/blank.htm")'>DK Transfer</a></p>-->
  <!--  cs47  2008/06/19 LIVE-->
  <a href="#" onClick='load("http://tpeweb03:7001/webdk/dkjsp007.jsp?sGetUsr=<%//=sGetUsr%>","../../FZ/blank.htm")'>DK Transfer</a> 
  <%
}
//061:��ȭp���o�i��, 0632:��ȭp���o�i����U��, 633007:�U�Ӵ}, 642288:�i�귩, 638736:�B�q��, 640790:�E�q��, 632283:������,634319:�B�ӱj
if(fullUCD.equals("061") || fullUCD.equals("0632") || fullUCD.equals("063")
|| sGetUsr.equals("633007") || sGetUsr.equals("630641") || sGetUsr.equals("637299") || sGetUsr.equals("642288") || sGetUsr.equals("638736") || sGetUsr.equals("640790") || sGetUsr.equals("634319") || sGetUsr.equals("632283")){
	%>
	<!--  cs47  2008/06/17 TEST--><!--<p class="txtblue"><a href="#" onClick='load("http://tpesunap01:9901/webdz/manual/barcodeQuery.jsp?sGetUsr=<%//=sGetUsr%>","../../FZ/blank.htm")'>OO Book Query</a></p>-->
	<!--  cs47  2008/06/17 TEST--><!--<p class="txtblue"><a href="#" onClick='load("http://tpesunap01:9901/webdz/manual/holderQuery.jsp?sGetUsr=<%//=sGetUsr%>","../../FZ/blank.htm")'>OO Holder Query</a></p>-->
	<!--  cs47  2008/09/10 TEST--><!--<p class="txtblue"><a href="#" onClick='load("http://tpesunap01:9901/webdz/manual/fleetQuery.jsp?sGetUsr=<%//=sGetUsr%>","../../FZ/blank.htm")'>OO Fleet Query</a></p>-->
	<!--  cs47  2008/06/17 TEST--><!--<p class="txtblue"><a href="#" onClick='load("http://tpesunap01:9901/webdz/manual/checkQuery.jsp?sGetUsr=<%//=sGetUsr%>","../../FZ/blank.htm")'>OO Check Query</a></p>-->
	<!--  cs47  2008/10/14 TEST--><!--<p class="txtblue"><a href="#" onClick='load("http://tpesunap01:9901/webdz/manual/dailyFlightQuery.jsp?sGetUsr=<%//=sGetUsr%>","../../FZ/blank.htm")'>OO Daily Flight</a></p>-->
	<!--  cs47  2008/10/17 TEST--><!--<p class="txtblue"><a href="#" onClick='load("http://tpesunap01:9901/webdz/manual/manualBagQuery.jsp?sGetUsr=<%//=sGetUsr%>","../../FZ/blank.htm")'>OO Manual Bag</a></p>-->
	<!--  cs47  2008/11/10 TEST--><!--<p class="txtblue"><a href="#" onClick='load("http://tpesunap01:9901/webdz/manual/updateRecordQuery.jsp?sGetUsr=<%//=sGetUsr%>","../../FZ/blank.htm")'>OO Update Record</a></p>-->
	<!--  cs47  2008/06/17 LIVE-->
<hr>
  OO <a href="#" onClick='load("http://tpeweb03:9901/webdz/manual/barcodeQuery.jsp?sGetUsr=<%=sGetUsr%>","../../FZ/blank.htm")'> 
  Book Query</a> <a href="#" onClick='load("http://tpeweb03:9901/webdz/manual/holderQuery.jsp?sGetUsr=<%=sGetUsr%>","../../FZ/blank.htm")'> 
  Holder Query</a> <a href="#" onClick='load("http://tpeweb03:9901/webdz/manual/fleetQuery.jsp?sGetUsr=<%=sGetUsr%>","../../FZ/blank.htm")'> 
  Fleet Query</a> <a href="#" onClick='load("http://tpeweb03:9901/webdz/manual/checkQuery.jsp?sGetUsr=<%=sGetUsr%>","../../FZ/blank.htm")'> 
  Check Query</a> 
  <a href="#" onClick='load("http://tpeweb03:9901/webdz/manual/dailyFlightQuery.jsp?sGetUsr=<%=sGetUsr%>","../../FZ/blank.htm")'> Daily Flight</a> 
  <a href="#" onClick="opWinJZ()"> Carry-On bag label</a> 
  <a href="#" onClick='load("http://tpeweb03:9901/webdz/manual/dailyFlightQuery2.jsp?sGetUsr=<%=sGetUsr%>","../../FZ/blank.htm")'> Daily Flight v2</a> 
  <a href="#" onClick='load("http://tpeweb03:9901/webdz/manual/manualBagQuery.jsp?sGetUsr=<%=sGetUsr%>","../../FZ/blank.htm")'> Manual Bag</a> <a href="#" onClick='load("http://tpeweb03:9901/webdz/manual/updateRecordQuery.jsp?sGetUsr=<%=sGetUsr%>","../../FZ/blank.htm")'> 
  Update Record</a> 
  <hr>
  SIMCHK 
  <%
}
//0522:��ȸ굦��, 633007:�U�Ӵ}, 642288:�i�귩, 638736:�B�q��, 640790:�E�q��, 632283:������,634319:�B�ӱj
//if(fullUCD.equals("0522")){
if(sGetUsr.equals("630136") || sGetUsr.equals("629767") || sGetUsr.equals("629678") || sGetUsr.equals("626767") || sGetUsr.equals("637299") || sGetUsr.equals("633007") || sGetUsr.equals("642288") || sGetUsr.equals("638736")|| sGetUsr.equals("640790") || sGetUsr.equals("634319") || sGetUsr.equals("632283")){
	%>
  <a href="#" onClick='load("../blank.htm","http://tpeweb03:9901/webdz/SIM/dzsimck010_check_in_out.jsp")'>OV 
  Maintain</a> 
  <%  }  %>
<a href="#" onClick='load("../blank.htm","http://tpeweb03.china-airlines.com:9901/webdz/SIM/dzsimck010_check_in_out_1.jsp")'>Query SIM ck-in/out</a>
	<%
//0522:��ȸ굦�� 0656,0657,0658:��V����V�]�I�� 0640:��V��, 633007:�U�Ӵ}, 642288:�i�귩, 638736:�B�q�� 640790:�E�q��, 632283:������,634319:�B�ӱj
//0643: :��V��(2011-10-11�[�J)
if (fullUCD.equals("0522") || fullUCD.equals("0656") || fullUCD.equals("0657") || fullUCD.equals("0658") 
    || fullUCD.equals("0640") || fullUCD.equals("0643") || sGetUsr.equals("637299") || sGetUsr.equals("633007") 
	|| sGetUsr.equals("642288") || sGetUsr.equals("638736") || sGetUsr.equals("630136") || sGetUsr.equals("640790") || sGetUsr.equals("634319") || sGetUsr.equals("632283"))  {
	%>
	<!--  cs47  2005/12/21 TEST--><!--<p class="txtblue"><a href="#" onClick='load("../blank.htm","http://tpesunap01:9901/webdz/SIM/dzsimck008_maint_log.jsp")'>OQ Maint Log</a></p>-->
	<!--  cs47  2005/12/21 TEST--><!--<p class="txtblue"><a href="#" onClick='load("../blank.htm","http://tpesunap01:9901/webdz/SIM/dzsimck009_dd_item.jsp")'>OQ DD Item</a></p>-->
	<!--  cs47  2006/04/18 TEST--><!--<p class="txtblue"><a href="#" onClick='load("../blank.htm","http://tpesunap01:9901/webdz/SIM/dzsimck014_part.jsp")'>OQ Part</a></p>-->
	<!--  cs47  2006/02/15 TEST--><!--<p class="txtblue"><a href="#" onClick='load("../blank.htm","http://tpesunap01:9901/webdz/SIM/dzsimck013_bulletin.jsp")'>OQ Bulletin</a></p>-->
	<!--  cs47  2006/09/26 TEST--><!--<p class="txtblue"><a href="#" onClick='load("../blank.htm","http://tpesunap01:9901/webdz/SIM/dzsimck017_check_list.jsp")'>OQ Check List</a></p>-->
	<!--  cs47  2006/05/11 TEST--><!--<p class="txtblue"><a href="#" onClick='load("../blank.htm","http://tpesunap01:9901/webdz/SIM/dzsimck015_total_using_time_list.jsp")'>OQ SIM Total Using Time</a></p>-->
<hr>
OQ<br>
  <a href="#" onClick='load("../blank.htm","http://tpeweb03:9901/webdz/SIM/dzsimck008_maint_log.jsp?sGetUsr=<%=sGetUsr%>")'> 
  Maint Log</a> 
<%
if("640790".equals(sGetUsr))	 
{
%>  
  <a href="#" onClick='load("../blank.htm","http://tpeweb03:9901/webdz/signin/signinQuery.jsp?sGetUsr=<%=sGetUsr%>")'> 
  Signin</a> 
<%
}	
%>
  
  <a href="#" onClick='load("../blank.htm","http://tpeweb03:9901/webdz/SIM/dzsimck009_dd_item.jsp")'> 
  DD Item</a> <a href="#" onClick='load("../blank.htm","http://tpeweb03:9901/webdz/SIM/dzsimck014_part.jsp")'> 
  Part</a> <a href="#" onClick='load("../blank.htm","http://tpeweb03:9901/webdz/SIM/dzsimck013_bulletin.jsp")'> 
  Bulletin</a> <a href="#" onClick='load("../blank.htm","http://tpeweb03:9901/webdz/SIM/dzsimck017_check_list.jsp")'> 
  Check List</a> <a href="#" onClick='load("../blank.htm","http://tpeweb03:9901/webdz/SIM/dzsimck015_total_using_time_list.jsp")'> 
  SIM Total Using Time</a> 
  <hr>
	<%
}
//0512:��ȷ|�p��, 633007:�U�Ӵ}, 642288:�i�귩, 638736:�B�q��
if (fullUCD.equals("0512") || sGetUsr.equals("630136") || sGetUsr.equals("629767") || sGetUsr.equals("629678") 
   || sGetUsr.equals("637299") || sGetUsr.equals("633007") || sGetUsr.equals("642288") || sGetUsr.equals("638736") || sGetUsr.equals("632283")) {
	%>
  <!--  cs47  2006/10/11 TEST-->
  <!--<p class="txtblue"><a href="#" onClick='load("../blank.htm","http://tpesunap01:9901/webdz/SIM/dzsimck019_instructor_hour.jsp")'>Instructor Hour</a></p>-->
  <a href="#" onClick='load("../blank.htm","http://tpeweb03:9901/webdz/SIM/dzsimck019_instructor_hour.jsp")'>Instructor 
  Hour</a> 
  <%
}

if(fullUCD.equals("0512") || fullUCD.equals("0522") || fullUCD.equals("066C") || fullUCD.equals("067D") || fullUCD.equals("068D") ||sGetUsr.equals("638716") || sGetUsr.equals("640073") || sGetUsr.equals("633007") || sGetUsr.equals("634319") || sGetUsr.equals("637299") || sGetUsr.equals("638736") || sGetUsr.equals("632283")){
// �խ��b�x���x�ѼƲέp    0512:�|�p��  0522:��ȸ굦��  066C: �լ���  067D�G�έp��  068D�G������
%>
  <a href="#" onClick='load("outTW/outTWQuery.jsp","outTW/outTW.htm")'>�b�x���x�Ѽ�</a> 
  <a href="#" onClick='load("../blank.htm","OZTrn/Menu.jsp")'>�~�׽ưV</a> <a href="#" onClick='load("http://tpeweb03:9901/webdz/training/showTrainQ.jsp","../blank.htm")'>Training 
  Record</a> 
  <%
}

if(fullUCD.equals("0522") | fullUCD.equals("176D")){	//100Hrs�ˬd��log
%>
  <a href="#" class="txtblue" onClick='load("100hrLogQuery.jsp","../blank.htm")'>100Hrs 
  Check Log</a> 
  <%
}

if(fullUCD.equals("0522") | fullUCD.equals("068D") | fullUCD.equals("067D") | fullUCD.equals("176D"))
//if(fullUCD.equals("176D"))
{	
%>
  <!-- Betty adds -->
  <!--<a href="#" class="txtblue" onClick='load("../apis/apisQuery.jsp","../apis/blank.htm")'>APIS check report</a><br>-->
  <!-- 2012-2-4 romoved by cs40 due WebAPIS go-live <a href="#" onClick='load("../apis/apisQuery3.jsp","../apis/blank.htm")'>APIS check report III</a> -->
  <%
}
%>
  <a href="#" onClick='load("LIC/querycrew.htm","../blank.htm")'>License</a> 
  <!-- <p class="txtblue"><a href="#" onClick='load("training/trainQ.jsp","../blank.htm")'>Training Record</a> </p>-->
  <a href="#" class="txtblue" onClick='load("logquery.jsp","../blank.htm")'>ViewLog</a> 
  <a href="#" onClick='load("../../FZ/tsa/venue/venue_querycond.jsp","../../FZ/blank.htm")'>Venue</a> 
  <!--cs40  2006/5/2 <p class="txtblue"><a href="#" onClick='load("http://tpesunap01:5001/webfz/FZ/tsa/cicoweb/cico_querycond.jsp","../../FZ/blank.htm")'>Duty change</a></p>-->
  <a href="#" onClick='load("../../FZ/pr_interface/simchk_querycond.jsp","../../FZ/blank.htm")'>SIM 
  Check</a> 
  <a href="#" onClick='load("../../FZ/pr_interface/routechk_querycond.jsp","../../FZ/blank.htm")'>Route 
  Check</a>
  <a href="#" onClick='load("../../FZ/blank.htm","../../FZ/mcl/mcl_cond.jsp")'>MCL</a> 
  <a href="#" onClick='load("../../FZ/othnat/othnat_top.htm","../../FZ/othnat/othnat_select.jsp")'>Other 
  Nationality</a> <a href="#" onClick='load("../../FZ/crxx/crxx_top.htm","../../FZ/crxx/crxx_select.jsp")'>FE/OE/PO/LD/EM</a> 
  <a href="#" onClick='load("../../FZ/senioritycode/senioritycode_cond.jsp","../../FZ/senioritycode/senioritycode_blank.jsp")'>Seniority code</a> 
<!--  <a href="#" onClick='load("../../FZ/blank.htm","../../Log/msgAC.txt")'>CIA���զ^������</a>  -->
  <a href="#" onClick='load("dailycrew/schQuery.jsp","../blank.htm")'>Schedule 
  Query</a> <a href="#" onClick='load("../blank.htm","dailycrew/crewListMenu.jsp")'>Crew 
  List Query</a> 
  <!-- 2008/1/14 CS40 <p><a href="#" class="txtblue" onClick='load("AUH/crewlistquery.jsp","../blank.htm")'>�~�� Crew List</a></p> -->
  <a href="#" class="txtblue" onClick='load("AUH/crewlistquery.jsp","../blank.htm")'>�~�� 
  Crew List</a> 
  <%
//CSOZEZ .��Ȧ�F 051 �B���ñ���� 068D�B�ŪAñ�� 190A �B�ŪA��F 181D .�i�ϥ�AirCrews�b���޲z�\��
//�����ȯ�ȥi�[�ݡA�G�ȭ����ȧY�i. �ŪA���v���]�w��tsaleft_ed.jsp
//�s�W340/330 �����H���i�ϥ�SR7048
//�s�W���� 2011-2-21 CS40
if(ck.isHasPowerUserAccount() | "067D".equals(fullUCD) | "068D".equals(fullUCD) | "051".equals(fullUCD) | "Y".equals(FLEET340330) | sGetUsr.equals("629678")){
%>
  <a href="#" onClick='load("../../FZ/blank.htm","ACUtil/ACUtilMenu.jsp")'>CIA 
  �b���޲z</a> 
  <%
}

%><p><a href='javascript:load("dailycrew/crewListForPurQuery.htm","../blank.htm")'>Flight Crew List</a></p> <%
%>
</div>
<br>
<br><a href="#" class="txtblue" onClick='load("../blank.htm","sendredirect.jsp")'>Logout</a><br>

</body>

<script type="text/javascript" src="/webdz/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="/webdz/js/jquery-ui-1.8.2.custom.min.js"></script>

</html>
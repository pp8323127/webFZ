<%
/* source modify history
Ver   date       who  SRno. description  
V2701 2005/03/10 CS27       modify [CrewRec] sequence
                            mark item "Crew REC Edit"
							mark unidCD.equals("05") || unidCD.equals("06") <=全處可 edit CrewRec?
*/

String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
String fullUCD = (String) session.getAttribute("fullUCD");//get full unit code
String  unidCD=  (String) session.getAttribute("unidCD");	//get unit cd
String FLEET340330 =  (String)session.getAttribute("340330FLEET"); //SR7048,340/330機隊人員

//取得是否為PowerUser
fzAuth.UserID userID = new fzAuth.UserID(sGetUsr,null);
fzAuth.CheckPowerUser ck = new fzAuth.CheckPowerUser();
// ck.isHasPowerUserAccount()  僅檢查是否有帳號，不檢查密碼


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
<link href="../menu.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
<!--
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
<% //insert與Modify功能，限制以下幾個人才能看到，其他Crew info選項，所有航務處單位皆可看到
  if (sGetUsr.equals("640412") || sGetUsr.equals("640354") || sGetUsr.equals("632357") || sGetUsr.equals("638716") || sGetUsr.equals("640073") || sGetUsr.equals("633007") || sGetUsr.equals("637299"))
  {	//640412:康益全 640354:張國彥 632357:王正美 638716:cs55 640073:cs66 633007:cs27

%>
  mm_menu_0507105618_0.addMenuItem("進公司前REC","window.open('CrewRdInsMenu.jsp', 'mainFrame');");
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
function change(id,pi){  //階層式架構
	 if (document.all[id].style.display=="none") { //若為隱藏	  
		document.all[id].style.display=""  //則將其顯示
		document.all[pi].src="../images/open.gif"    //出現open圖案
	  }
	 else	  {
		document.all[id].style.display="none"  //顯示
		document.all[pi].src="../images/close.gif"		//出現close圖案
	  } 
}
</script>

<body bgcolor="#99ccff" >
<script language="JavaScript1.2">mmLoadMenus();</script>
<p class="txtblue"><a href="#" onClick='load("daily/dailyquery.htm","../blank.htm")'>Daily Check</a></p>
<p class="txtblue"><a href="#" onClick='load("../GD/gdQuery.jsp","../blank.htm")'>Web GD</a> </p>
<p class="txtblue"><a href="#" onClick='load("ACMList/ACMListtop.html","ACMList/segMenu_cockpit.jsp")'>ACM 訂位</a> </p>
<p class="txtblue"><a href="#" onClick='load("../blank.htm","checkInTime.jsp")'>CheckIn Time</a></p>
<p><a href="#" class="txtblue" onClick='load("tsaquery.htm","../blank.htm")'>TSA Schedule</a></p>
<!--<p><a href="#" class="txtblue" onClick='load("tsaquery_apis.htm","../blank.htm")'>TSA APIS</a> </p>-->
<%
if (!sGetUsr.equals("123456"))
{
%>
<!--<p><a href="#" class="txtblue" onClick='load("tsaCrewInfoQ.htm","../blank.htm")'>TSA Crew Info</a><br></p>-->
<p><a href="#" class="txtblue" onClick='load("crewhrquery.htm","../blank.htm")'>航空器駕駛員檔案</a><br></p>
<p><a href="#" class="txtblue" onClick='load("http://tpeweb03:9901/webdz/catiii/topframe.jsp","../blank.htm")'>CATII/IIIa</a></p>
<p><a href="#" class="txtblue" onClick='load("http://tpeweb03:9901/webdz/catiii/catiiQ.htm","../blank.htm")'>CATII/IIIa report</a></p>

<%
if (sGetUsr.equals("640354") | sGetUsr.equals("640790") | sGetUsr.equals("633007") | sGetUsr.equals("638716")
    | sGetUsr.equals("632357") | sGetUsr.equals("637299") )
{
%>
<p><a href="#" class="txtblue" onClick='load("http://tpeweb03:9901/webdz/catiii/selFleet.htm","../blank.htm")'>Email CATII/IIIa Unqualified</a></p>
<%
}
%>

<p><a href="#" class="txtblue" onClick='load("crewrecquery.htm","../blank.htm")'>CrewRec</a></p>
<%
if (fullUCD.equals("068D") || sGetUsr.equals("638716") | sGetUsr.equals("640073") | sGetUsr.equals("637299")){
//068D：派遣部
%>
<p><a href="#" class="txtblue" onClick='load("crewmaxq.jsp","../blank.htm")'>ReqFltAL Max</a></p>
<!--<p class="txtblue"><a href="#" onClick='load("http://tpesunap01:5001/webfz/FZ/tsa/SCH/schequery.htm","../../FZ/blank.htm")'>機隊月班表TEST</a></p>-->
<%
}
//單位為航務處才可使用 05%, 06% OZ
//638716:cs55 640073:cs66 633007:cs27
if(unidCD.equals("05") || unidCD.equals("06") || sGetUsr.equals("640790") || sGetUsr.equals("640073") || sGetUsr.equals("633007") || sGetUsr.equals("634319") || sGetUsr.equals("637299")){
%>
<a href="#" onMouseOver="MM_showMenu(window.mm_menu_0507105618_0,12,12,null,'image1')" onMouseOut="MM_startTimeout();"><img src="../images/close.gif" name="image1" width="15" height="15" border="0" align="baseline" id="image1">&nbsp;<span class="txtblue">Crew Check</span></a>
<p class="txtblue"><a href="#" onClick='load("../crewhr/crewhrqry_tpe.htm","../blank.htm")'>100Hrs Check TPE</a> </p>
<%
	//640412:康益全 634613:林東榮  PowerUser
	if(sGetUsr.equals("640412") || sGetUsr.equals("634613") || ck.isHasPowerUserAccount() || sGetUsr.equals("637299")){
		%>
		<!--<p class="txtblue"><a href="#" onClick='load("../crewhr/crewhrqry_tpe.htm","../blank.htm")'>100Hrs Check TPE</a> </p>-->
		<p class="txtblue"><a href="#" onClick='load("crewops.htm","../../FZ/blank.htm")'>1000Hrs Check</a></p>
		<%
	}
	//068D：派遣部 cs55
	if(fullUCD.equals("068D") || ck.isHasPowerUserAccount() || sGetUsr.equals("637299"))
	{
		%>
		<p class="txtblue"><a href="#" onClick='load("7days_over32hrsquery.htm","../../FZ/blank.htm")'>7天32小時限制</a></p>
		<%
	}

	//051：行政部 cs55
	if(fullUCD.equals("051") || ck.isHasPowerUserAccount() || sGetUsr.equals("637299")){
		%>
		<p class="txtblue"><a href="#" onClick='load("http://tpeweb03:9901/webdz/OG/vhdbquery.jsp?sGetUsr=<%=sGetUsr%>","../blank.htm")'>OG Import</a></p>
		<%
	}
}
%>
<p class="txtblue" ><a href="#" onClick='load("querycrew.htm","../blank.htm")'>Crew Query </a></p>
<!--<p<p class="txtblue"><a href="#" onClick='load("../crewhr/crewhrqry.jsp","../blank.htm")'>100Hrs Check LOC</a> </p>-->
<!--<p class="txtblue"><a href="#" onClick='load("../crewhr/crewhrqry_tpe.htm","../blank.htm")'>100Hrs Check TPE</a> </p>-->
<p class="txtblue"><a href="#" onClick='load("../crewhr_aircrews/crewhrqry.htm","../blank.htm")'>100Hrs AirCrews</a> </p>
<p class="txtblue"><a href="#" onClick='load("LIC/licquery.htm","../blank.htm")'>Licence Check</a></p>
<!--<p class="txtblue"><a href="#" onClick='load("crewops.htm","../../FZ/blank.htm")'>1000Hrs Check</a></p>-->
<!--<p class="txtblue"><a href="#" onClick='load("../blank.htm","../crewcar/crewcar_indate.jsp")'> Crew Car</a></p>-->
<p class="txtblue"><a href="#" onClick='load("../../FZ/crewshuttle/blank.html","../../FZ/crewshuttle/funcMenu.jsp")'> Crew Car</a></p>

<p class="txtblue"><a href="#" onClick='load("ChkSche/blank.html","ChkSche/segMenu.jsp")'>Working days check</a> </p>
<p class="txtblue"><a href="#" onClick='load("SCH/schequery.htm","../../FZ/blank.htm")'>機隊月班表PROD</a></p>
<p class="txtblue"><a href="#" onClick='load("SCH/schequery2.htm","../../FZ/blank.htm")'>ELO月班表</a></p>
<p class="txtblue"><a href="#" onClick='load("Days_Off_Q.htm","../../FZ/blank.htm")'>Days Off</a></p>
<p class="txtblue"><a href="#" onClick='load("daysOff/daysOffQuery.jsp","../../FZ/blank.htm")'>Days Off 計算</a></p>
<%
}
//****************************1.尚未開放user使用	**********start**************
if(ck.isHasPowerUserAccount()){//CSOZEZ
%>
<span class="txtxred">**測試區**</span><br>
<p><a href="cspage.jsp" target="_top"><span style="color:#003333;background-color:#FFCCFF;padding:2pt; ">選擇登入頁面</span></a></p>
<p><a href="tsaframe.jsp?mypage=tsaleft_adm.jsp" target="_top"><span style="color:#000000;background-color:#FFFFCC;padding:2pt; ">測試功能選項</span></a></p>
<span class="txtxred">********</span><br>
<%//******************************************************************** end **************
//年度複訓test url in tpesunap01 http://tpesunap01:5001/webfz/OZTrn/Menu.jsp?userid=<%=sGetUsr
}
//061,063:航務計劃發展部, 633011:游偉林, 633007:顧志揆, 632286:胡中興, 640354:張國彥, 631539:劉桂香
if(fullUCD.equals("061") || fullUCD.equals("063") || sGetUsr.equals("633011") || sGetUsr.equals("633007") || sGetUsr.equals("632286") || sGetUsr.equals("640354") || sGetUsr.equals("631539") || sGetUsr.equals("637299")){
	%>
	<!--  cs47  2006/01/05 TEST--><!--<p class="txtblue"><a href="#" onClick='load("http://tpesunap01:7001/webdk/dk_top.html","http://tpesunap01:7001/webdk/dk_menu.jsp")'>DK System (Post Flight Analysis)</a></p>-->
	<!--  cs47  2006/07/05 LIVE--><p class="txtblue"><a href="#" onClick='load("http://tpeweb03:7001/webdk/dk_top.html","http://tpeweb03:7001/webdk/dk_menu.jsp")'>DK System (Post Flight Analysis)</a></p>
	<%
}
//628170:汪慧玲, 635987:許秀慧, 639404:莊晉榮, 636119:徐文江, 635904:謝佳延, 633007:顧志揆
if(sGetUsr.equals("628170") || sGetUsr.equals("635987") || sGetUsr.equals("639404") || sGetUsr.equals("636119") || sGetUsr.equals("635904") || sGetUsr.equals("633007") || sGetUsr.equals("637299")){
	%>
	<!--  cs47  2008/06/19 TEST--><!--<p class="txtblue"><a href="#" onClick='load("http://tpesunap01:7001/webdk/dkjsp007.jsp?sGetUsr=<%=sGetUsr%>","../../FZ/blank.htm")'>DK Transfer</a></p>-->
	<!--  cs47  2008/06/19 LIVE--><p class="txtblue"><a href="#" onClick='load("http://tpeweb03:7001/webdk/dkjsp007.jsp?sGetUsr=<%//=sGetUsr%>","../../FZ/blank.htm")'>DK Transfer</a></p>
	<%
}
//061:航務計劃發展部, 0632:航務計劃發展部手冊組, 633007:顧志揆
if(fullUCD.equals("061") || fullUCD.equals("0632") || sGetUsr.equals("633007") || sGetUsr.equals("630641") || sGetUsr.equals("637299")){
	%>
	<!--  cs47  2008/06/17 TEST--><!--<p class="txtblue"><a href="#" onClick='load("http://tpesunap01:9901/webdz/manual/barcodeQuery.jsp?sGetUsr=<%//=sGetUsr%>","../../FZ/blank.htm")'>OO Book Query</a></p>-->
	<!--  cs47  2008/06/17 TEST--><!--<p class="txtblue"><a href="#" onClick='load("http://tpesunap01:9901/webdz/manual/holderQuery.jsp?sGetUsr=<%//=sGetUsr%>","../../FZ/blank.htm")'>OO Holder Query</a></p>-->
	<!--  cs47  2008/09/10 TEST--><!--<p class="txtblue"><a href="#" onClick='load("http://tpesunap01:9901/webdz/manual/fleetQuery.jsp?sGetUsr=<%//=sGetUsr%>","../../FZ/blank.htm")'>OO Fleet Query</a></p>-->
	<!--  cs47  2008/06/17 TEST--><!--<p class="txtblue"><a href="#" onClick='load("http://tpesunap01:9901/webdz/manual/checkQuery.jsp?sGetUsr=<%//=sGetUsr%>","../../FZ/blank.htm")'>OO Check Query</a></p>-->
	<!--  cs47  2008/10/14 TEST--><!--<p class="txtblue"><a href="#" onClick='load("http://tpesunap01:9901/webdz/manual/dailyFlightQuery.jsp?sGetUsr=<%//=sGetUsr%>","../../FZ/blank.htm")'>OO Daily Flight</a></p>-->
	<!--  cs47  2008/10/17 TEST--><!--<p class="txtblue"><a href="#" onClick='load("http://tpesunap01:9901/webdz/manual/manualBagQuery.jsp?sGetUsr=<%//=sGetUsr%>","../../FZ/blank.htm")'>OO Manual Bag</a></p>-->
	<!--  cs47  2008/11/10 TEST--><!--<p class="txtblue"><a href="#" onClick='load("http://tpesunap01:9901/webdz/manual/updateRecordQuery.jsp?sGetUsr=<%//=sGetUsr%>","../../FZ/blank.htm")'>OO Update Record</a></p>-->
	<!--  cs47  2008/06/17 LIVE--><p class="txtblue"><a href="#" onClick='load("http://tpeweb03:9901/webdz/manual/barcodeQuery.jsp?sGetUsr=<%=sGetUsr%>","../../FZ/blank.htm")'>OO Book Query</a></p>
	<!--  cs47  2008/06/17 LIVE--><p class="txtblue"><a href="#" onClick='load("http://tpeweb03:9901/webdz/manual/holderQuery.jsp?sGetUsr=<%=sGetUsr%>","../../FZ/blank.htm")'>OO Holder Query</a></p>
	<!--  cs47  2008/09/10 LIVE--><p class="txtblue"><a href="#" onClick='load("http://tpeweb03:9901/webdz/manual/fleetQuery.jsp?sGetUsr=<%=sGetUsr%>","../../FZ/blank.htm")'>OO Fleet Query</a></p>
	<!--  cs47  2008/06/17 LIVE--><p class="txtblue"><a href="#" onClick='load("http://tpeweb03:9901/webdz/manual/checkQuery.jsp?sGetUsr=<%=sGetUsr%>","../../FZ/blank.htm")'>OO Check Query</a></p>
	<!--  cs47  2008/10/14 LIVE--><p class="txtblue"><a href="#" onClick='load("http://tpeweb03:9901/webdz/manual/dailyFlightQuery.jsp?sGetUsr=<%=sGetUsr%>","../../FZ/blank.htm")'>OO Daily Flight</a></p>
	<!--  cs47  2008/10/17 LIVE--><p class="txtblue"><a href="#" onClick='load("http://tpeweb03:9901/webdz/manual/manualBagQuery.jsp?sGetUsr=<%=sGetUsr%>","../../FZ/blank.htm")'>OO Manual Bag</a></p>
	<!--  cs47  2008/11/10 LIVE--><p class="txtblue"><a href="#" onClick='load("http://tpeweb03:9901/webdz/manual/updateRecordQuery.jsp?sGetUsr=<%=sGetUsr%>","../../FZ/blank.htm")'>OO Update Record</a></p>
<%
}
//0522:航務資策部
//if(fullUCD.equals("0522")){
if(sGetUsr.equals("630136") || sGetUsr.equals("629767") || sGetUsr.equals("629678") || sGetUsr.equals("626767") || sGetUsr.equals("637299")){
	%>
	<!--  cs47  2005/12/30 TEST--><!--<p class="txtblue"><a href="#" onClick='load("../blank.htm","http://tpesunap01:9901/webdz/SIM/dzsimck010_check_in_out.jsp")'>OV Maintain Function</a></p>-->
	<!--  cs47  2006/06/26 LIVE--><p class="txtblue"><a href="#" onClick='load("../blank.htm","http://tpeweb03:9901/webdz/SIM/dzsimck010_check_in_out.jsp")'>OV Maintain Function</a></p>
	<%
}
//0522:航務資策部 0656,0657,0658:航訓部航訓設施組 0640:航訓部
if(fullUCD.equals("0522") || fullUCD.equals("0656") || fullUCD.equals("0657") || fullUCD.equals("0658") || fullUCD.equals("0640") || sGetUsr.equals("637299")){
	%>
	<!--  cs47  2005/12/21 TEST--><!--<p class="txtblue"><a href="#" onClick='load("../blank.htm","http://tpesunap01:9901/webdz/SIM/dzsimck008_maint_log.jsp")'>OQ Maint Log</a></p>-->
	<!--  cs47  2005/12/21 TEST--><!--<p class="txtblue"><a href="#" onClick='load("../blank.htm","http://tpesunap01:9901/webdz/SIM/dzsimck009_dd_item.jsp")'>OQ DD Item</a></p>-->
	<!--  cs47  2006/04/18 TEST--><!--<p class="txtblue"><a href="#" onClick='load("../blank.htm","http://tpesunap01:9901/webdz/SIM/dzsimck014_part.jsp")'>OQ Part</a></p>-->
	<!--  cs47  2006/02/15 TEST--><!--<p class="txtblue"><a href="#" onClick='load("../blank.htm","http://tpesunap01:9901/webdz/SIM/dzsimck013_bulletin.jsp")'>OQ Bulletin</a></p>-->
	<!--  cs47  2006/09/26 TEST--><!--<p class="txtblue"><a href="#" onClick='load("../blank.htm","http://tpesunap01:9901/webdz/SIM/dzsimck017_check_list.jsp")'>OQ Check List</a></p>-->
	<!--  cs47  2006/05/11 TEST--><!--<p class="txtblue"><a href="#" onClick='load("../blank.htm","http://tpesunap01:9901/webdz/SIM/dzsimck015_total_using_time_list.jsp")'>OQ SIM Total Using Time</a></p>-->
	<!--  cs47  2006/06/26 LIVE--><p class="txtblue"><a href="#" onClick='load("../blank.htm","http://tpeweb03:9901/webdz/SIM/dzsimck008_maint_log.jsp?sGetUsr=<%=sGetUsr%>")'>OQ Maint Log</a></p>
	<!--  cs47  2006/06/26 LIVE--><p class="txtblue"><a href="#" onClick='load("../blank.htm","http://tpeweb03:9901/webdz/SIM/dzsimck009_dd_item.jsp")'>OQ DD Item</a></p>
	<!--  cs47  2006/06/26 LIVE--><p class="txtblue"><a href="#" onClick='load("../blank.htm","http://tpeweb03:9901/webdz/SIM/dzsimck014_part.jsp")'>OQ Part</a></p>
	<!--  cs47  2006/06/26 LIVE--><p class="txtblue"><a href="#" onClick='load("../blank.htm","http://tpeweb03:9901/webdz/SIM/dzsimck013_bulletin.jsp")'>OQ Bulletin</a></p>
	<!--  cs47  2006/09/26 LIVE--><p class="txtblue"><a href="#" onClick='load("../blank.htm","http://tpeweb03:9901/webdz/SIM/dzsimck017_check_list.jsp")'>OQ Check List</a></p>
	<!--  cs47  2006/06/26 LIVE--><p class="txtblue"><a href="#" onClick='load("../blank.htm","http://tpeweb03:9901/webdz/SIM/dzsimck015_total_using_time_list.jsp")'>OQ SIM Total Using Time</a></p>
	<%
}
//0512:航務會計組
if(fullUCD.equals("0512") || sGetUsr.equals("630136") || sGetUsr.equals("629767") || sGetUsr.equals("629678") || sGetUsr.equals("637299")){
	%>
	<!--  cs47  2006/10/11 TEST--><!--<p class="txtblue"><a href="#" onClick='load("../blank.htm","http://tpesunap01:9901/webdz/SIM/dzsimck019_instructor_hour.jsp")'>Instructor Hour</a></p>-->
	<!--  cs47  2006/10/11 LIVE--><p class="txtblue"><a href="#" onClick='load("../blank.htm","http://tpeweb03:9901/webdz/SIM/dzsimck019_instructor_hour.jsp")'>Instructor Hour</a></p>
	<%
}

if(fullUCD.equals("0512") || fullUCD.equals("0522") || fullUCD.equals("066C") || fullUCD.equals("067D") || fullUCD.equals("068D") ||sGetUsr.equals("638716") || sGetUsr.equals("640073") || sGetUsr.equals("633007") || sGetUsr.equals("634319") || sGetUsr.equals("637299")){
// 組員在台離台天數統計    0512:會計組  0522:航務資策部  066C: 組派部  067D：統計組  068D：派遣部
%>
<a href="#" onClick='load("outTW/outTWQuery.jsp","outTW/outTW.htm")'>在台離台天數</a><br>
<p><a href="#" class="txtblue" onClick='load("../blank.htm","OZTrn/Menu.jsp")'>年度複訓</a></p>
<p class="txtblue"><a href="#" onClick='load("http://tpeweb03:9901/webdz/training/showTrainQ.jsp","../blank.htm")'>Training Record</a> </p>
<%
}

if(fullUCD.equals("0522") | fullUCD.equals("176D")){	//100Hrs檢查的log
%>
<p><a href="#" class="txtblue" onClick='load("100hrLogQuery.jsp","../blank.htm")'>100Hrs Check Log</a></p>
<%
}

if(fullUCD.equals("0522") | fullUCD.equals("068D") | fullUCD.equals("067D") | fullUCD.equals("176D"))
//if(fullUCD.equals("176D"))
{	
%>
<!-- Betty adds -->
<p>
<!--<a href="#" class="txtblue" onClick='load("../apis/apisQuery.jsp","../apis/blank.htm")'>APIS check report</a><br>-->
<a href="#" class="txtblue" onClick='load("../apis/apisQuery3.jsp","../apis/blank.htm")'>APIS check report III</a><br>
</p>
<%
}
%>
<p><a href="#" class="txtblue" onClick='load("LIC/querycrew.htm","../blank.htm")'>License</a></p>
<!-- <p class="txtblue"><a href="#" onClick='load("training/trainQ.jsp","../blank.htm")'>Training Record</a> </p>-->
<p><a href="#" class="txtblue" onClick='load("logquery.jsp","../blank.htm")'>ViewLog</a></p>
<!--cs40  2005/7/15 --><p class="txtblue"><a href="#" onClick='load("../../FZ/tsa/venue/venue_querycond.jsp","../../FZ/blank.htm")'>Venue</a> </p>
<!--cs40  2006/5/2 <p class="txtblue"><a href="#" onClick='load("http://tpesunap01:5001/webfz/FZ/tsa/cicoweb/cico_querycond.jsp","../../FZ/blank.htm")'>Duty change</a></p>-->
<!--cs40  2005/12/02 --><p class="txtblue"><a href="#" onClick='load("../../FZ/pr_interface/simchk_querycond.jsp","../../FZ/blank.htm")'>SIM Check</a> </p>
<!--cs40  2005/12/02 --><p class="txtblue"><a href="#" onClick='load("../../FZ/pr_interface/routechk_querycond.jsp","../../FZ/blank.htm")'>Route Check</a> </p>
<!--cs40  2006/06/28 --><p class="txtblue"><a href="#" onClick='load("../../FZ/blank.htm","../../FZ/mcl/mcl_cond.jsp")'>MCL</a></p>
<!--cs40  2006/10/03-->
<p class="txtblue"><a href="#" onClick='load("../../FZ/othnat/othnat_top.htm","../../FZ/othnat/othnat_select.jsp")'>Other 
  Nationality</a></p>

<!--  cs40  2006/10/02 -->
<p class="txtblue"><a href="#" onClick='load("../../FZ/crxx/crxx_top.htm","../../FZ/crxx/crxx_select.jsp")'>FE/OE/PO/LD/EM</a></p>
<!--cs40  2007/01/09 -->
<p class="txtblue"><a href="#" onClick='load("../../FZ/senioritycode/senioritycode_cond.jsp","../../FZ/senioritycode/senioritycode_blank.jsp")'>Seniority code</a></p>
<p class="txtblue"><a href="#" onClick='load("../../FZ/blank.htm","../../Log/msgAC.txt")'>CIA測試回報紀錄</a> </p>
<p><a href="#" class="txtblue" onClick='load("dailycrew/schQuery.jsp","../blank.htm")'>Schedule Query</a></p>
<p><a href="#" class="txtblue" onClick='load("../blank.htm","dailycrew/crewListMenu.jsp")'>Crew List Query</a></p>

<!-- 2008/1/14 CS40 <p><a href="#" class="txtblue" onClick='load("AUH/crewlistquery.jsp","../blank.htm")'>外站 Crew List</a></p> -->
<p><a href="#" class="txtblue" onClick='load("AUH/crewlistquery.jsp","../blank.htm")'>外站 Crew List</a></p>

<br>
<%
//CSOZEZ .航務行政 051 、航務簽派組 068D、空服簽派 190A 、空服行政 181D .可使用AirCrews帳號管理功能
//本頁僅航務可觀看，故僅限制航務即可. 空服之權限設定於tsaleft_ed.jsp
//新增340/330 機隊人員可使用SR7048
if(ck.isHasPowerUserAccount() |  "068D".equals(fullUCD) 	|  "051".equals(fullUCD) | "Y".equals(FLEET340330)){
%>
<p><a href="#" onClick='load("../../FZ/blank.htm","ACUtil/ACUtilMenu.jsp")'>CIA 帳號管理</a></p>
<%
}
%>


<br>


<p><a href="#" class="txtblue" onClick='load("../blank.htm","sendredirect.jsp")'>Logout</a></p>
</body>
</html>

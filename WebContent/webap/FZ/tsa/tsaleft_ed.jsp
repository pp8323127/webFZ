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

//取得是否為PowerUser
String  unidCD=  (String) session.getAttribute("fullUCD");	//get unit cd
fzAuth.UserID userID = new fzAuth.UserID(sGetUsr,null);
fzAuth.CheckPowerUser ck = new fzAuth.CheckPowerUser();
// ck.isHasPowerUserAccount()  僅檢查是否有帳號，不檢查密碼
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
<p><a href="#" class="txtblue" onClick='load("../alienCrewSign/alienCrewSign_query.jsp","../blank.htm")'>外站組員簽到表</a></p>
<p><a href="#" class="txtblue" onClick='load("../payHr/payHr_querycond.jsp","../blank.htm")'>Pay Hour</a></p>
<%
if(ck.isHasPowerUserAccount() |  "190A".equals(unidCD) ){ %>
    <p><a href="#" class="txtblue" onClick='load("../payHr/dutyHr_querycond.jsp","../blank.htm")'>Duty Hour</a></p>
    <p><a href="#" class="txtblue" onClick='load("../payHr/dutyHr_emp_querycond.jsp","../blank.htm")'>Emp Duty Hour</a></p> <% 
}//if%>

<%
//KHH Daily Check,高雄空服，高雄會計, TPEED可看
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
<p><a href="javascript:load('../blank.htm','khhnobus/nobusMenu.jsp')" >無公車車費作業</a></p>
<%
}	
//***************************************
%>

<a href='javascript:load("../GD/gdQuery.jsp","../blank.htm")'>Web GD</a><br>
<hr>
<!-- 2009/10/14 -->
簡體CrewList<br>
<a href="http://tpecsap03.china-airlines.com/outstn/GBCabinCrewListv2.aspx" target="mainFrame">Normal</a>
<a href="http://tpecsap04.china-airlines.com/outstn/GBCabinCrewListv2.aspx" target="mainFrame">Backup</a>
<a href="http://tpecsap03.china-airlines.com/fz/FZLogin.aspx" target="_blank">eMail OutStation</a>
<hr>
<p><a href='javascript:load("../apis/sendapisQuery.jsp","../apis/blank.htm")'>手動發送APIS</a></p>
<p><a href='javascript:load("../apis/apis_sentlog_query.jsp","../apis/blank.htm")'>APIS發送紀錄</a></p>		  
<p><a href="javascript:load('../cta_app/app_au_cond.jsp','../blank.htm')">(AU) APP</a></p>
<p><a href="javascript:load('../cta_app/app_nz_cond.jsp','../blank.htm')">(NZ) APP</a></p>
<hr>
<a href='javascript:load("../acaodiff/acaodiff_query.jsp","../blank.htm")'>時間不符航班</a>
<hr>
<%
if( "190A".equals(unidCD) || ck.isHasPowerUserAccount() || ifdispaly == true )
{
%>
<p><a href='javascript:load("../blank.htm","dailycrew/sbMenu.jsp")'>Standby Crew</a></p>
<p><a href="#" class="txtblue" onClick='load("../blank.htm","http://tpeweb03:9901/webeg/attendance/off/offsheet/offMenu.jsp?userid=<%=sGetUsr%>")'>處理假單</a></p>

<%
}
else if(!"180B".equals(unidCD))
{
//空服會計，未被授權 Standby Crew選項
%>
<p><a href='javascript:load("dailycrew/SBquery.htm","../blank.htm")'>Standby Crew</a></p>
<%
}
%>

<% 
//CS40 2008/12/22
if (ck.isHasPowerUserAccount() || "190A".equals(unidCD) || "196".equals(unidCD) || "1811".equals(unidCD) || "1812".equals(unidCD) || "1813".equals(unidCD) || "631A".equals(unidCD) || "635".equals(unidCD) || "638716".equals(sGetUsr)){
   %><p><a href="#" class="txtblue" onClick='load("../extraACM/extraACM_query.jsp","../blank.htm")'>彈性派遣節省飛加報表</a></p><%
}//if

//SR2055 80% => DFA CS40 2012/3/2
if (ck.isHasPowerUserAccount() || "190A".equals(unidCD) || "638716".equals(sGetUsr)  ){
   %><p><a href="#" class="txtblue" onClick='load("../extraACM/dfa_query.jsp","../blank.htm")'>彈性派遣80%轉DFA</a></p><%
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
//************* set authorization to 隋建勳,陳靜美,潘楣恩,蕭淑娥,田瑞瑩,廖芳瑩,林秀娟,楊雅玲,任靜��, 何苓儀,吳曉星,李梅翰,董倩倩,徐康莉//+郭玟慧,鄒惠珍,池文
if (ck.isHasPowerUserAccount()  || "631931".equals(sGetUsr) || "631578".equals(sGetUsr) || "631711".equals(sGetUsr) || "634341".equals(sGetUsr) || "631255".equals(sGetUsr) || "634996".equals(sGetUsr) || "630131".equals(sGetUsr) || "642275".equals(sGetUsr) || "631714".equals(sGetUsr) || "628097".equals(sGetUsr) || "635023".equals(sGetUsr) || "638207".equals(sGetUsr) || "630162".equals(sGetUsr) || "628948".equals(sGetUsr) || "632970".equals(sGetUsr) || "632072".equals(sGetUsr) || "639088".equals(sGetUsr) || "635810".equals(sGetUsr) || "628653".equals(sGetUsr))
{
%>
<!--<p><a href="load('../../DF/pock/blank.htm','../../DF/pock/editAdjt.jsp')">延長工時調整  </a></p>-->
<p><a href="javascript:load('../../DF/pock/blank.htm','../../DF/pock/overtimeMenu.jsp')">延長工時功能維護</a></p>
<%
}

//Start: 2009-10-14 CS40
// 190A: TPEED, 790A: KIXEM, 811: BKKEM, 8508: NRTEM
if(ck.isHasPowerUserAccount() |  "190A".equals(unidCD) | "790A".equals(unidCD) | "811".equals(unidCD) | "8508".equals(unidCD)){ %>
   <p><a href='javascript:load("dailycrew/crewListForPurQuery.htm","../blank.htm")'>Flight Crew List</a></p> <%
}//if
//End: 2009-10-14 CS40


/*
	20080214 更改空服行政組代號，原181D改為 1811, 1812, 1813
	*/
//ED.EA.可看
//EB 2009-11-27 CS40
if( ck.isHasPowerUserAccount() 	|  "190A".equals(unidCD)  | "1811".equals(unidCD) | "1812".equals(unidCD) | "1813".equals(unidCD) | "180B".equals(unidCD)){ %>
   
   <p><a href='javascript:load("../blank.htm","mealtaxi/mealtaxiMenu.jsp")'>誤餐/誤車作業</a></p><%
   
   if ( !"180B".equals(unidCD) ) { %>
      <p><a href='javascript:load("../../FZ/blank.htm","ACUtil/ACUtilMenu.jsp")'>CIA 帳號管理</a></p>
      <!--  cs40  2006/06/28 -->
      <p><a href='javascript:load("../../FZ/blank.htm","../../FZ/mcl/mcl_cond.jsp")'>MCL</a></p>
      <p><a href='javascript:load("../../EG/rpt/crewPassQ.htm","../../FZ/blank.htm")'>Crew Passport</a></p><% 
      //徐櫻瑛 633248; 蕭雲芳634283; 徐淑惠638716; 李翠連627051, 鄒惠珍635810
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
	<!--自願併房/放棄住房 *************************************************************** -->
	<p><a href="#" class="txtblue" onClick='load("../blank.htm","../housing/adm/housingMenu.jsp")'>自願併房/放棄住房</a></p>
	<!--自願併房/放棄住房 *************************************************************** -->
	<%
	}
	%>
	<!--積點選換班 *************************************************************** -->
	<p><a href="#" class="txtblue" onClick='load("../blank.htm","../credit/adm/creditMenu.jsp")'>全勤/積點選換班</a></p>
	<!--積點選換班 *************************************************************** -->
<%
}
%>
<p><a href='javascript:load("AUH/crewlistquery.jsp","../blank.htm")'>外站 Crew List</a></p>
<%
//ED可看
if(ck.isHasPowerUserAccount() |  "190A".equals(unidCD) )
{
%>
<p><a href="#" class="txtblue" onClick='load("../blank.htm","../../FZ/aircrews_deadlock/aircrews_deadlock.jsp")'>AirCrews Deadlock</a></p>
<p><a href='javascript:load("../blank.htm","ACMList/segMenu_cabin.jsp")'>ACM List</a></p>
<p><a href='javascript:load("../../FH/fhquery.jsp","../blank.htm")'>休時不足</a></p>
<p><a href='javascript:load("../../FH/whquery.jsp","../blank.htm")'>工作超時</a></p>
<p><a href='javascript:load("../../FZ/blank.htm","../../Log/msgAC.txt")'>CIA測試回報紀錄</a> </p>
<p><a href='javascript:load("Italy/monQuery.jsp","../blank.htm")'>飛義大利組員名單</a></p>
<p><a href='javascript:load("SCH/crewSchequery.htm","../blank.htm")'>月班表PROD</a></p>
<!-- <p><a href='javascript:load("AUH/crewlistquery.jsp","../blank.htm")'>外站 Crew List</a></p> -->
<p><a href='javascript:load("dailycrew/flightPeriodQuery.jsp","../blank.htm")' >Flight Period Query </a></p>
<p><a href='javascript:load("../blank.htm","../../EG/AC/chkList.jsp")'>Check AL/XL</a></p>
<%
}

//ED & EF & KHH
//2008/12/23 CS40
if(ck.isHasPowerUserAccount() || "190A".equals(unidCD) || "195B".equals(unidCD) || "196".equals(unidCD) || "197".equals(unidCD) || "198".equals(unidCD) || "199".equals(unidCD) || "635".equals(unidCD)){ 
   %><p><a href='javascript:load("../blank.htm","../SMSAC/SMSQuery.jsp")'>簡訊通報</a></p><%
}


if(ifdispaly == true)
{
%>
<p><a href='javascript:load("dailycrew/crewListForPurQuery.htm","../blank.htm")'>Flight Crew List</a></p>
<p><a href='javascript:load("dailycrew/flightPeriodQuery.jsp","../blank.htm")' >Flight Period Query </a></p>
<p><a href='javascript:load("../blank.htm","../SMSAC/SMSQuery.jsp")'>簡訊通報</a></p>
<p><a href="#" class="txtblue" onClick='load("../blank.htm","eduserpwd/editeduserpwd.jsp")'>Change  PWD</a></p>

<%
}

if("635".equals(unidCD) | "811".equals(unidCD) | "837".equals(unidCD) | "827".equals(unidCD) | "850".equals(unidCD) | "8501".equals(unidCD) )
{
%>
<p><a href='javascript:load("../../EG/rpt/crewPassQ.htm","../../FZ/blank.htm")'>Crew Passport</a></p>
<p><a href='javascript:load("SCH/crewSchequery.htm","../blank.htm")'>月班表PROD</a></p>
<p><a href='javascript:load("dailycrew/crewListForPurQuery.htm","../blank.htm")'>Flight Crew List</a></p>
<%
}

//外站可看 [外站 Crew List]
//SR7216
/*
外站UnitCode,
SINEM：837,SGNEM：827,BKKEM：811,NRTEM：8501,TPEEA：181D
*/
/*
	20080214 更改空服行政組代號，原181D改為 1811, 1812, 1813
	*/
if("811".equals(unidCD) | "837".equals(unidCD) | "827".equals(unidCD) | "8501".equals(unidCD) | "1811".equals(unidCD) | "1812".equals(unidCD) |  "1813".equals(unidCD) )
{
%>
<p><a href='javascript:load("AUH/crewlistquery.jsp","../blank.htm")'>外站 Crew List</a></p>
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
   <p><a href="#" class="txtblue" onClick='load("../paraw2011/paraw_querycond.jsp","../blank.htm")'>PA Raw Score(2011版)</a></p>
   <p><a href="#" class="txtblue" onClick='load("../paraw2011/pa_rawline_querycond.jsp","../blank.htm")'>PA Raw+Line(2011版)</a></p>
   <!-- <p><a href="#" class="txtblue" onClick='load("../paraw/paraw_querycond.jsp","../blank.htm")'>PA Raw Score(2009)</a></p>  -->
   <!-- <p><a href="#" class="txtblue" onClick='load("../paraw/pa_rawline_querycond.jsp","../blank.htm")'>PA Raw+Line(2009)</a></p>  -->
   <%
//}//if

//CS40 2011/4/5
if (ck.isHasPowerUserAccount()  ||  "189".equals(unidCD) ){  %>
   
<p><a href="#" class="txtblue" onClick='load("../../R5XX/r5xx_querycond.jsp","../blank.htm")'>空訓名單查詢</a></p>
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

//空服行政可看,組員簡訊管理功能,SR8020
if( ck.isHasPowerUserAccount() 	 | "1811".equals(unidCD) | "1813".equals(unidCD) | "1812".equals(unidCD))
{
%>
<a href='javascript:load("../../FZ/blank.htm","../AC/crewKindred/AdmMenu.jsp")' class="txtblue" >組員家屬簡訊</a><br>
<%	 
}

if (ck.isHasPowerUserAccount() | "1811".equals(unidCD) | "1812".equals(unidCD) | "1813".equals(unidCD) | "190A".equals(unidCD)  | "197".equals(unidCD) | sGetUsr.equals("638716")){ 
   %><p><a href='javascript:load("dailycrew/out_stn_query.htm","../blank.htm")'>值勤名單</a></p> 
     <p><a href="#" class="txtblue" onClick='load("../payHr/payHr_querycond.jsp","../blank.htm")'>Pay Hour</a></p><%
}

%><p><a href="#" class="txtblue" onClick='load("../payHr/onduty_querycond.jsp","../blank.htm")'>每月組員出勤人次</a></p><%

//EF , ED
if(ck.isHasPowerUserAccount() || "190A".equals(unidCD) || "195B".equals(unidCD)  || "199".equals(unidCD) || sGetUsr.equals("638716") ){ 
   %><p><a href="#" class="txtblue" onClick='load("../blank.htm","../../FZ/noef/noef.jsp")'>NO EF</a></p><%
}

if(ck.isHasPowerUserAccount() )
{
%>
<p><a href="#" class="txtblue" onClick='load("../blank.htm","eduserpwd/editeduserpwd.jsp")'>Change EDUser Password</a></p>
<p><a href="cspage.jsp" target="_top"><span style="color:#003333;background-color:#FFCCFF;padding:2pt; ">選擇登入頁面</span></a></p>
<%
}
%>

<%
//if("640790".equals(sGetUsr))
//{
%>
<hr><table><tr><td bgcolor="#990000"><font color="#FFFFFF">NGB資料收集</font></td></tr></table>
<p><a href="#" class="txtblue" onClick='load("../blank.htm","../../FZ/ngbForm/mgt_ack.jsp")'>組員Ack</a></p>
<p><a href="#" class="txtblue" onClick='load("../blank.htm","../../FZ/ngbForm/mgt_select.jsp")'>組員已回報</a></p>
<p><a href="#" class="txtblue" onClick='load("../blank.htm","../../FZ/ngbForm/mgt_notreply.jsp")'>組員未回報</a></p>
<p><a href="#" class="txtblue" onClick='load("../blank.htm","../../FZ/ngbForm/mgt_acfile.jsp")'>AirCrewsImport檔檢視</a></p>
<hr> <p><a href="http://tpecsap03/outstn/ChnNameEdit.aspx" target="mainFrame">簡體中文姓名維護</a></p>
<hr>  <%
	//}	
%>

<p><a href='javascript:load("../blank.htm","sendredirect.jsp")'>Logout</a></p>
</body>
</html>
<%
}//end of has session
%>
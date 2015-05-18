<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,java.util.*,ci.db.*,java.text.DateFormat"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login

if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 

String password = (String) session.getAttribute("password");
String auth = (String) session.getAttribute("auth"); //get user id if already login
String occu = (String) session.getAttribute("occu");
String locked = (String) session.getAttribute("locked");//N : 不鎖定/開放, Y : 鎖定/不開放

//add by cs55 2004/08/05
String userip = request.getRemoteAddr();
String aladdress = null;

if(userip.substring(0,3).equals("192")) {
	aladdress = "http://tpeweb03:9901/webfz/AL/chkuser.jsp?userid="+sGetUsr+"&password="+password;
}
else{

	aladdress = "http://tpeweb02.china-airlines.com/webfz/AL/chkuser.jsp?userid="+sGetUsr+"&password="+password;
}
//Get UTC & TPE Time

Calendar cal = Calendar.getInstance() ;
java.util.Date date = (java.util.Date)cal.getTime() ;
Locale lcTW = Locale.TAIWAN ;
Locale lcUK = Locale.UK ;
TimeZone tz    = TimeZone.getDefault() ;
TimeZone tzUTC = TimeZone.getTimeZone("UTC") ; 
DateFormat dfD = DateFormat.getDateInstance(DateFormat.SHORT,lcTW) ;
DateFormat dfT = DateFormat.getTimeInstance(DateFormat.SHORT,lcUK) ; //use 24Hrs UK timestyle
String stTPE = dfD.format (date) + " " + dfT.format (date) ;

dfD.setTimeZone(tzUTC);
dfT.setTimeZone(tzUTC);
String stUTC = dfD.format (date) + " " + dfT.format (date) ;

Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet myResultSet = null;
boolean t = false;

try{
//dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
//conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
ConnDB cn = new ConnDB();
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement();

String counter = null;
String sql ="select FZQLOGIN.nextval counter from dual";
myResultSet = stmt.executeQuery(sql);
%>
<html>
<head>
<title>function screen</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" href="menu.css" type="text/css">

<script type="text/javascript" language="JavaScript">
function load(w1,w2){
		/*top.topFrame.location.href=w1;
		top.mainFrame.location.href=w2;*/
		parent.topFrame.location.href=w1;
		parent.mainFrame.location.href=w2;

}

function getdate(){	//設定選單預設值
	nowdate = new Date();	//現在時間
	var y,m,d
	y = nowdate.getYear();
	m = nowdate.getMonth()+1;
	d = nowdate.getDate();

	
	if ( d >= 25 ) {			//若超過25號，預設為下個月的班表
		if ( m == 12){
			y = y + 1;
			m = 0;		//若為12/25，則年份加1
		}
		m = m + 1;
	}
	
	if (m < 10)	{		//若月份<10，則前面加一個0
		m= "0"+ m;
	}
	parent.topFrame.location.href="schquery.jsp";
	parent.mainFrame.location.href="showsche2.jsp?syear="+y+"&smonth="+m+"&empno=";
}

function logout(){	//登出

	//top.location.href="sendredirect.jsp";
	self.location="sendredirect.jsp";	
}

    function change(id,pi){  //階層式架構
		 if (document.getElementById(id).style.display=="none") { //若為隱藏	  
			document.getElementById(id).style.display=""  //則將其顯示
			document.getElementById(pi).src="images/open.gif"    //出現open圖案
			//開啟一item則將其他item關閉
			if (id != "txt1" && document.getElementById("txt1") != null){
				document.getElementById("txt1").style.display="none"  //隱藏
				document.getElementById("pic1").src="images/close.gif"		//出現close圖案
			}
			if (id != "txt2" && document.getElementById("txt2") != null){
				document.getElementById("txt2").style.display="none"  //隱藏
				document.getElementById("pic2").src="images/close.gif"		//出現close圖案
			}
			if (id != "txt3" && document.getElementById("txt3") != null){
				document.getElementById("txt3").style.display="none"  //隱藏
				document.getElementById("pic3").src="images/close.gif"		//出現close圖案
			}
			if (id != "txt4" && document.getElementById("txt4") != null){
				document.getElementById("txt4").style.display="none"  //隱藏
				document.getElementById("pic4").src="images/close.gif"		//出現close圖案
			}
			if (id != "txt5" && document.getElementById("txt5") != null){
				document.getElementById("txt5").style.display="none"  //隱藏
				document.getElementById("pic5").src="images/close.gif"		//出現close圖案
			}
		  }
		 else	  {
			document.getElementById(id).style.display="none"  //隱藏
			document.getElementById(pi).src="images/close.gif"		//出現close圖案
		  } 
			
	}
	
	function prn(){
		window.open('PRTrn/prframe.jsp');
		
	}
	
	
	
</script>

<style type="text/css">
<!--

BODY{margin:0px;}
.e4 {	background-color: #edf3fe;
	color: #000000;
	text-align: center;
}
/*內容貼緊網頁邊界*/
-->
</style>
</head>



<body bgcolor="#CCCCCC" text="#000000"  oncontextmenu="window.event.returnValue=false" onselectstart="event.returnValue=false" ondragstart="window.event.returnValue=false">
<table width="100%" cellpadding="0" cellspacing="0" >
	<%
	if(myResultSet != null){
		while(myResultSet.next()){
			counter = myResultSet.getString("counter");
	%>
	  <tr>
		<td colspan="2"><div align="left"><span class="txtblue">Total Visit:</span><span class="txtxred"><%=counter%> </span></div></td>
	  </tr>
	  <tr>
	    <td colspan="2" ><span class="txtblue">TPE:<%=stTPE%></span><br>
	     <span class="txtblue">UTC:<%= stUTC%></span></td>
  </tr>
    <%
		}
	}
	%>
</table>
<br>
<br>
<table width="100%"  border="0">

<tr>
 <td height="46" colspan="3" align="right" valign="middle">
   <div align="left">
     <input type="button"  onClick="javascript:self.location='fscreenAC.jsp';top.topFrame.location='blank.htm';top.mainFrame.location='blank.htm';" value="使用新版功能"  style="background-color:#FFFFFF;color:#000000 " >
   </div>
 </td>
</tr>
</table>

<%
	if (locked.equals("Y")){
	%>
<table width="100%"  border="0">
        <tr>
          <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
          <td width="3%" align="right" valign="middle"><img src="images/p3.gif" width="21" height="21"></td>
          <td width="95%"><a href="#"  onClick="javascript:getdate()">班表查詢<br>Schedule Query</a></td>
        </tr>
</table>
<%
}
else{

%>
<span style=cursor:hand onclick=change("txt1","pic1") >
 <img src="images/close.gif" width="16" height="16" id="pic1">&nbsp;<span class="txtblue">查詢班表(Query) </span>

<p> 
</span> 
<div style=background-color:#BBEBF0;display:none id="txt1"> 


<table width="100%"  border="0">
  <tr>
  <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
    <td width="5%" height="46" align="right" valign="middle"><img src="images/p3.gif" width="21" height="21"></td>
    <td width="95%"><a href="#"  onClick="javascript:getdate()">班表查詢<br>Schedule Query</a></td>
  </tr>
  <tr>
  <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
    <td height="49" align="right" valign="middle"><img src="images/cr.gif" width="22" height="22"></td>
    <td>      <a href="#" onClick='javascript:load("crquery.htm","blank.htm")'>飛時查詢<br>Flying Time Query</a></td>
  </tr>
  <tr>
  <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
    <td height="49" align="right" valign="middle"><img src="images/da.gif" width="22" height="22"></td>
    <td>      <a href="#" onClick='javascript:load("fltquery.htm","blank.htm")'>航班查詢<br>Flight Query</a></td>
  </tr>
  <tr>
  <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
    <td height="45" align="right" valign="middle"><img src="images/compare.gif" width="22" height="22"></td>
    <td><a href="#"  onClick='javascript:load("compquery.htm","blank.htm")'>比對班表<br>Schedule Compare</a></td>
  </tr>
  <tr>
  <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
    <td height="49" align="right" valign="middle"><img src="images/offcrew.gif" width="22" height="22"></td>
    <td>      <a href="#" onClick='javascript:load("offquery.jsp","blank.htm")'>Off 組員查詢<br>Off Crew Query</a></td>
  </tr>
   <!-- <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
    <td height="49" align="right" valign="middle"><img src="images/loglist.gif" width="22" height="22"></td>
    <td> <a href="#" onClick="load('blank.htm','http://tpeweb02.china-airlines.com/webfz/FZ/tsa/cicoweb/cico_query_socketclient.jsp')">任務變更 <br>Duty Change</a></td>  -->
  </tr>  

</table>
</div>
	
		<%
		}
		if(occu.equals("FA") || occu.equals("FS") || occu.equals("PR") || occu.equals("CM")){
			if (locked.equals("N") ){
	%>
	
<br>

<span style=cursor:hand onclick=change("txt2","pic2") >
<img src="images/close.gif" width="16" height="16" id="pic2">&nbsp;<span class="txtblue">換班專區(Transfer)</span> 
<p>
</span>
	<div style=background-color:#BBEBF0;display:none id="txt2"> 
<table width="100%" height="244"  border="0">
  <tr>
  <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
    <td width="3%" align="right" valign="middle"><img src="images/p2.gif" width="21" height="21" border="0"></td>
    <td width="97%"><a href="#"  onClick='javascript:load("putquery.jsp","blank.htm")'>欲換班表<br>Put Schedule</a></td>
  </tr>
  <tr>
  <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
    <td align="right" valign="middle"="2"><img src="images/search3.gif" width="22" height="22" border="0"></td>
    <td><a href="#" onClick='javascript:load("psquery.jsp","blank.htm")'>查詢可換班表<br>Put Schedule Query</a></td>
  </tr>
  <tr>
  <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
    <td align="right" valign="middle"><img src="images/i.gif" width="21" height="21" border="0"></td>
    <td><a href="#"  onClick='javascript:load("blank.htm","showbook.jsp")'>我的丟班資訊<br>Put Schedule Record</a></td>
  </tr>
  <tr>
    <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
    <td height="39" align="right" valign="middle"><img src="images/list.gif" width="22" height="22"></td>
<!--     <td><a href="#"  onClick='javascript:load("appquery.htm","blank.htm")'>填申請單<br>Make Application</a></td>
 -->
  <td><a href="#"  onClick='load("blank.htm","swap3/step0.jsp")'>填申請單<br>Make Application</a></td>
   </tr>
  <tr>
	<td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
    <td align="right" valign="middle"><img src="images/p.gif" width="22" height="22"></td>
    <td><a href="#"  onClick='javascript:load("apply_query.htm","applyquery.jsp")'>申請單記錄<br>Check Application</a></td>
  </tr>
  <tr>
	<td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
    <td align="right" valign="middle"><img src="images/d2.gif" width="22" height="22"></td>
    <td><a href="#"  onClick='javascript:load("uploadquery.jsp","blank.htm")'>下載選班資訊<br>Download File</a></td>
  </tr>
</table>


	</div>

	<%
		}	//↑後艙及開放班表者可看
	}	//↑後艙可看
	


	%>
	

<br>
<%
if(!occu.equals("ED")){
%>
<span style=cursor:hand onclick=change("txt3","pic3") >
<img src="images/close.gif" width="16" height="16" id="pic3">&nbsp;<span class="txtblue">個人資料(Personal)</span>
<p>
</span>
	<div style=background-color:#BBEBF0;display:none id="txt3"> 
<table width="100%" height="196"  border="0">
        <tr>
			  <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
			  <td width="3%" align="right" valign="middle"><img src="images/edit.gif" border="0" width="20" height="20"></td>
			  <td width="97%"><a href="#"  onClick='load("blank.htm","editcrewinfo.jsp")'>組員個人資料<br>Crew Information</a></td>
        </tr>
        <tr>
			  <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
			  <td width="3%" align="right" valign="middle"><img src="images/ed3.gif" width="22" height="22"></td>
			  <td width="97%"><a href="#"  onClick='load("blank.htm","chgPw.jsp")'><font color="red">變更本系統密碼<br>Change Password</font></a></td>
        </tr>		


		
		<%
			if( occu.equals("FA") || occu.equals("FS") || occu.equals("PR")|| occu.equals("CM") ) {
		
		%>
        <tr>
			<td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
	        <td align="right" valign="middle"="2"><img src="images/fa.gif" width="22" height="22"></td>
            <td><a href="#"  onClick='load("blank.htm","favorflt.jsp")'>自訂最愛航班<br> Favorite  Flight</a>&nbsp;</td>
        </tr>
		<tr>
		  <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
			<td align="right" valign="middle"><img src="images/favrquery.gif" width="21" height="21" border="0"></td>
			<td><a href="#"  onClick='javascript:load("blank.htm","favrquery.jsp")'>喜好航班查詢<br>Favorite  Flight Query</a></td>
		</tr>
		<tr>
			<td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
	        <td align="right" valign="middle"="2"><img src="images/friend.gif" width="22" height="22"></td>
            <td><a href="#"  onClick='javascript:load("blank.htm","goodfriend.jsp")'>自訂好友名單<br> Friend List</a>&nbsp;</td>
        </tr>
		<tr>
			  <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
			  <td align="right" valign="middle"><img src="images/h1.gif" width="22" height="22"></td>
			  <td><a href="#"  onClick='javascript:load("blank.htm","<%=aladdress%>")'>年假輸入/查詢<br> AL Offsheet</a></td>

        </tr>
		<tr>
			  <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
			  <td align="right" valign="middle"><img src="images/fixpay.gif" width="22" height="22"></td>
			  <td><a href="#"  onClick='javascript:load("reqFixpayQuery.htm","blank.htm")'>定額飛加<br> Fixed FlyPay</a></td>

        </tr>
		
 		<tr>
			<td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
			<td align="right" valign="middle"="2"><img src="images/award.gif" width="22" height="22"></td>
			<td><a href="#" onClick='javascript:load("reqAwdListQuery.jsp","blank.htm")'><span class="txtxred">獎懲通報<br> Award List</span> </a>&nbsp;</td>
		</tr>		
		<%
			}	//↑後艙可看
		%>
		<tr>
			<td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
			<td align="right" valign="middle"="2"><img src="images/flypay.gif" width="22" height="22"></td>
			<!-- <td><a href="#"  onClick='javascript:load("ccflypayquery.htm","blank.htm")'>飛加清單<br> Flypay List</a>&nbsp;</td> -->
			<td><a href="#"  onClick='javascript:load("flyPayQuery.htm","blank.htm")'>飛加清單<br> Flypay List</a>&nbsp;</td>
		</tr>
		<tr>
			<td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
			<td align="right" valign="middle"="2"><img src="images/loglist.gif" width="22" height="22"></td>
			<td><a href="#" onClick='javascript:load("loglistquery.htm","blank.htm")'>飛航記錄<br> Crew Log List</a>&nbsp;</td>
		</tr>
        <tr>
			  <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
			  <td height="39" align="right" valign="middle"><img src="images/lock.gif" width="22" height="22"></td>
			  <td><a href="#"  onClick='javascript:load("blank.htm","lock.jsp")'>鎖定/開放班表<br>Set Schedule Status</a></td>
        </tr>
		<tr>
			  <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
			  <td height="39" align="right" valign="middle"><img src="images/ed3.gif" width="22" height="22"></td>
			  <td><a href="#"  onClick='javascript:load("blank.htm","resetCIAPW.jsp")'><font color="red">重設CIA密碼<br>Reset CIA Password</font></a></td>
        </tr>
      </table>
</div>
	<%
}	//↑非ED的才可看~(ED不可看)
if(locked.equals("N") || occu.equals("ED")){

%>
<br>
<span style=cursor:hand onclick=change("txt4","pic4") >
<img src="images/close.gif" width="16" height="16" id="pic4">&nbsp;<span class="txtblue">其他功能(Others)</span> 
<p>
</span>
	<div style=background-color:#BBEBF0;display:none id="txt4"> 	
<table width="100%" height="141"  border="0">
  <tr>
  <td width="2%" height="48" align="right" valign="middle">&nbsp;</td>
    <td width="3%" align="right" valign="middle"><img src="images/search2.gif" width="21" height="21" border="0"></td>
    <td width="97%"><a href="#"  onClick='load("cwquery.htm","blank.htm")'>查詢組員電話<br>寄送班表</a></td>
  </tr>
  <tr>
  <td width="2%" height="42" align="right" valign="middle">&nbsp;</td>
    <td align="right" valign="middle"><img src="images/efmail.gif" width="22" height="22"></td>
    <td><a href="#" onClick='load("efmail.htm","blank.htm")'>意見信箱<br>Contact EF</a></td>
  </tr>
</table>
</div>	

<%
}
%>
<br>

	<%
	if(occu.equals("ED") || occu.equals("O")){
	%>
<span style=cursor:hand onclick=change("txt5","pic5") >
<img src="images/close.gif" width="16" height="16" id="pic5">&nbsp;<span class="txtblue">管理功能(Admin)</span>
<p>
</span>
	<div style=background-color:#BBEBF0;display:none id="txt5"> 

		<img src="images/list.gif" width="22" height="22"><a href="#"  onClick='javascript:load("confquery.jsp","blank.htm")'>申請單查詢</a><br><br>
	<%
	}
	//曹sir, 王文樺
	// 廖家昇 "633988".equals(sGetUsr) mark by cs66 2005/10/19
	if("629678".equals(sGetUsr) ||  "626914".equals(sGetUsr)){
	%>
		<img src="images/search2.gif" width="22" height="22" align="absmiddle"><a href="#"  onClick='javascript:load("blank.htm","edHotNews.jsp")'>編輯最新消息</a><br><br>
	<%
	}
	if (occu.equals("ED")){
	%>
		<img src="images/ed2.gif" width="22" height="22" align="absmiddle"><a href="#"  onClick='javascript:load("formquery.htm","blank.htm")'>申請單處理</a><br><br>
		<img src="images/ed1.gif" width="21" height="21" align="absmiddle"><a href="#"  onClick='javascript:load("blank.htm","max.jsp")'>更動受理數量</a><br><br>
	 	<img src="images/ed1.gif" width="21" height="21" align="absmiddle"><a href="#"  onClick='javascript:load("chgSwapFromQuery.jsp","chgSwapFromMenu.htm")'><span class="txtxred">更新申請單狀態</span></a><br><br>		
	 	
	  <img src="images/ed4.gif" width="21" height="21" align="absmiddle"><a href="#"  onClick='javascript:load("blank.htm","comm.jsp")'>更動審核意見</a><br>
		<br>
		<img src="images/ed3.gif" width="21" height="21" align="absmiddle"><a href="#" onClick='javascript:load("blank.htm","setdate.jsp")'>自訂不受理日</a><br><br>
		<img src="images/crewcomm.gif" width="22" height="22" align="absmiddle"><a href="#" onClick='javascript:load("blank.htm","crewcomm.jsp")'>自訂組員申請附註</a><br><br>
		<img src="images/mail2.gif" width="20" height="20" align="absmiddle"><a href="#" onClick='javascript:load("mailsche.jsp","blank.htm")'>寄送月班表</a><br><br>
		<img src="images/cmailsche.gif" width="22" height="22" align="absmiddle"><a href="#" onClick='javascript:load("blank.htm","/webfz/sendlog.txt")'>寄送月班表確認</a><br><br>
		<img src="images/cmailsche.gif" width="22" height="22" align="absmiddle">
<a href="#" onClick='javascript:load("log/batchMailScheLogQuery.jsp","blank.htm")'>Batch寄送月班表確認</a><br><br>
		<img src="images/uploadWord.gif" width="16" height="16" align="absmiddle"><a href="#" onClick='javascript:load("blank.htm","uploadfile.htm")'>上傳檔案</a><br><br>
		<img src="images/d2.gif" width="22" height="22" align="absmiddle"><a href="#"  onClick='javascript:load("uploadquery.jsp","blank.htm")'>查詢選班資訊</a><br><br>
		<img src="images/search2.gif" width="22" height="22" align="absmiddle"><a href="#"  onClick='javascript:load("blank.htm","edHotNews.jsp")'>編輯最新消息</a><br><br>
		<img src="images/userlist.gif" width="22" height="22" align="absmiddle"><a href="#"  onClick='javascript:load("blank.htm","SMS/SMSQuery.jsp")'>Cabin eSMS<br>&nbsp;&nbsp;&nbsp;&nbsp;緊急簡訊通報</a><br><br>

  </tr>
	<%
	}
	%>
	</div>
<%
//**********************************************************
//test 簡訊,座艙長報告,Hotnews!!
//可使用者:cs55,cs66,cs27,cs40,cs71,cs73
//occu.equals("PR") ||
if( occu.equals("PR") || occu.equals("CM")||sGetUsr.equals("638716") ||sGetUsr.equals("640073") ||sGetUsr.equals("633007") ||sGetUsr.equals("634319") ||sGetUsr.equals("640790")||sGetUsr.equals("640792") ||sGetUsr.equals("627018") ||sGetUsr.equals("630208")||sGetUsr.equals("629019")||sGetUsr.equals("625384")||sGetUsr.equals("627536")
    || sGetUsr.equals("811006") ||  sGetUsr.equals("837165") || sGetUsr.equals("850045")  || sGetUsr.equals("827061")  || sGetUsr.equals("628363") 
	|| sGetUsr.equals("626914") ||  sGetUsr.equals("850368")
	//add by cs66 trainning 座艙長需交正式報告 2005/9/6
//	|| sGetUsr.equals("631201") ||  sGetUsr.equals("631611") |  sGetUsr.equals("630230") ){
|| sGetUsr.equals("629562")	/* || sGetUsr.equals("980274")	*/
||sGetUsr.equals("827069")	//SGNEM 2006/02/15

){
%>

	
	<img src="images/crewcomm.gif" width="22" height="22" border="0" align="absmiddle"><a href="#"  onClick='load("blank.htm","PRORP3/PRSel.jsp")'>Purser Report</a><br><br>
<!-- 	<img src="images/crewcomm.gif" width="22" height="22" border="0" align="absmiddle"><a href="#"  onClick='load("blank.htm","Stop.htm")'>Purser Report</a> -->
<%
}

//座艙長報告受訓名單,
//加上 628946 陳致君,630166 吉鎮麗,631255 潘媚恩,631578 陳靜美,625296 汪駿聲,
//640073,638716
/*
 {"630153","630230","630326","630328","630341","630342","630536","630614","630723","630732","630849","630933","630937","631201","631212","626394","626387","627293","628588","631611","629562","630393","632309",
 
String[] prTrn ={"628946","630166","631578","631255","625296","640073","638716","630153","630230","630326","630328","630341","630342","630536","630614","630723","630732","630849","630933","630937","631201","631212","626394","626387","627293","628588","631611","629562","630393","632309"};
*/

//新增帳號
if(sGetUsr.equals("638716") ||sGetUsr.equals("640073") ||sGetUsr.equals("633007") ||sGetUsr.equals("634319") ||sGetUsr.equals("640790")){

%>
<HR>
<img src="images/friend.gif" width="22" height="22" border="0" align="absmiddle">
<a href="#"  onClick='load("blank.htm","adminAccount.jsp")'>帳號管理</a>  <br>
<img src="images/crewcomm.gif" width="22" height="22" border="0" align="absmiddle"><a href="#"  onClick='load("blank.htm","PRORP3/PRSel.jsp")'>Purser Report</a><br>

<img src="images/userlist.gif" width="22" height="22" align="absmiddle"><a href="#"  onClick='javascript:load("blank.htm","SMS/SMSQuery.jsp")'>Cabin eSMS<br>&nbsp;&nbsp;&nbsp;&nbsp;緊急簡訊通報</a><br><br>
<a href="#"  onClick='javascript:load("blank.htm","SMSAC/SMSQuery.jsp")'>eSMS AirCrews Edition</a>

<!--
<img src="images/crewcomm.gif" width="22" height="22" border="0" align="absmiddle">
  <a href="#"  onClick='load("blank.htm","PR/PRSel.jsp")'>座艙長報告Test環境</a>
 
<a href="#"  onClick='load("blank.htm","http://tpesunap01:5001/webfz/FZ/PR/PRSel.jsp")'>cs71 test<br></a><br><br>
<br> 
 <img src="images/userlist.gif" width="22" height="22" align="absmiddle"><a href="#"  onClick='javascript:load("blank.htm","SMS/SMSQuery.jsp")'>Cabin eSMS</a><br> 
&nbsp;&nbsp;&nbsp;&nbsp;-->
<!-- 
<a href="PRTrn/prframe.jsp" target="_top" ><img src="images/crewcomm.gif" width="22" height="22" border="0" align="absmiddle">座艙長報告Training</a> -->
<HR>
<%
}

%>

	<table width="100%"  border="0">
	<tr>
		<td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
          <td height="46" align="right" valign="middle"><img src="images/userlist.gif" width="21" height="21" border="0"></td>
          <td><a href="#"  onClick='javascript:load("blank.htm","UserList.jsp")'>線上使用者<br>
          Online User List</a></td>
      </tr>
    <tr>
		<td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
          <td width="5%" height="46" align="right" valign="middle"><img src="images/qa.gif" width="20" height="20" border="0" align="middle"></td>
          <td width="95%"><a href="#"  onClick='javascript:load("blank.htm","qa.htm")'>使用說明&nbsp;  <br>
User's Guide</a></td>
      </tr>
     <tr>
		<td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
          <td width="5%" height="46" align="right" valign="middle"><img src="images/qa2.gif" width="22" height="22" border="0" align="middle"></td>
          <td width="95%"><a href="#" onClick='javascript:load("blank.htm","apply_readme.htm")' class="bu" >如何填申請單</a></td>
      </tr>
	  <%
	  if("C".equals((String)session.getAttribute("auth"))){	//組員
	  %>
       <tr>
		<td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
          <td height="46" align="right" valign="middle"><a href="#"  onClick='javascript:load("blank.htm","tsaForm/editTSA.jsp")'><span style="color:#9900CC;font-size:12px "><strong>★</strong></span></a></td>
          <td><a href="#"  onClick='javascript:load("blank.htm","tsaForm/editTSA.jsp")'><span style="color:#9900CC;font-size:12px "><strong>編輯 MCL &nbsp;<br>
Edit MCL</strong></span></a></td>
      </tr>		  
	  <%
	  }
	  %>
         <tr>
         <td height="46" align="right" valign="middle">&nbsp;</td>
         <td height="46" align="right" valign="middle">&nbsp;</td>
         <td><a href="#" onClick="load('blank.htm','http://tpesunap01:5001/webfz/FZ/tsa/cicoweb/cico_query_socketclient.jsp?userid=<%=sGetUsr%>')">任務異動通知<br>
(Duty Change)</a></td>
       </tr> 
       <tr>
         <td height="46" align="right" valign="middle">&nbsp;</td>
         <td height="46" align="right" valign="middle">&nbsp;</td>
         <td><a href="http://ch.e-go.com.tw/" target="mainFrame"><span class="txtxred">報到接車查詢</span></a><br>
          <span class="txtxred"> (Internet Only)</span> </td>
       </tr>
       <tr>
         <td height="46" align="right" valign="middle">&nbsp;</td>
         <td height="46" align="right" valign="middle">&nbsp;</td>
         <td><a href="#" onClick="load('blank.htm','msgAC.jsp')" ><span class="txtxred">AirCrews CIA<br>
           測試回報</span></a><br>
          <span class="txtxred"> CIA Report Back</span>
         </td>
       </tr>

       <tr>
         <td height="46" align="right" valign="middle">&nbsp;</td>
         <td height="46" align="right" valign="middle"><img src="images/logout.gif" width="21" height="21" border="0"></td>
         <td><a href="#"  onClick="logout()">登出系統&nbsp;Logout</a></td>
       </tr>
	   
	  
<!--         <tr>
         <td height="46" align="right" valign="middle">&nbsp;</td>
         <td height="46" align="right" valign="middle">&nbsp;</td>
         <td><a href="#" onClick="load('blank.htm','http://tpesunap01:5001/webfz/FZ/tsa/cicoweb/cico_query_socketclient.jsp?userid=<%=sGetUsr%>')">.</a></td>
       </tr>	 -->
</table>  	

</body>

</html>
<%
}
catch (Exception e)
{
	  t = true;
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
if(t)
{
%>
      <jsp:forward page="err.jsp" /> 
<%
}
%>
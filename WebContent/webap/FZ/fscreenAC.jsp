<%@page contentType="text/html; charset=big5" language="java" %>
 
<%@page import="fz.*,java.sql.*,java.util.*,java.text.DateFormat,ci.db.*"%>

<%
/********************!測試環境!*************************/
response.setHeader("Cache-Control","no-cache");

response.setDateHeader ("Expires", 0);

String userid = (String) session.getAttribute("userid") ; //get user id if already login
String cock = (String)session.getAttribute("COCKPITCREW");


if (session.isNew() || userid == null) 
{

	response.sendRedirect("sendredirect.jsp");

} 
else
{



// EG status, 1=在職

String egStatus = (String)session.getAttribute("EGStatus");



String password = (String) session.getAttribute("password");

String auth = (String) session.getAttribute("auth"); //get user id if already login

String occu = (String) session.getAttribute("occu");

String locked = (String) session.getAttribute("locked");//N : 不鎖定/開放, Y : 鎖定/不開放

String userip = request.getRemoteAddr();

String aladdress = null;

boolean ifdispaly = false;

if("EDUser".equals(userid))

{

	ifdispaly = true;

}



//if(userip.substring(0,3).equals("192")) 

if("192.168".equals(userip.substring(0,7)) | "10.16".equals(userip.substring(0,5)))

{

	aladdress = "http://hdqweb03:9901/webfz/AL/chkuser.jsp?userid="+userid+"&password="+password;

}

else

{

	aladdress = "http://tpeweb02.china-airlines.com/webfz/AL/chkuser.jsp?userid="+userid+"&password="+password;

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
//***2013-01-01啟用****//
boolean newName = false;

Calendar calendar = Calendar.getInstance();

String thisY = Integer.toString(calendar.get(Calendar.YEAR));//

if(Integer.parseInt(thisY) > 2012){
	
	newName=true;
	
}
//**********************//

Connection conn = null;

Driver dbDriver = null;

Statement stmt = null;

ResultSet rs = null;

boolean t = false;

String counter = null;

ConnDB cn = new ConnDB();

try{



cn.setORP3FZUserCP();

dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();

conn = dbDriver.connect(cn.getConnURL(), null);



stmt = conn.createStatement();





rs = stmt.executeQuery("select FZQLOGIN.nextval counter from dual");

	while(rs.next()){

		counter = rs.getString("counter");

	

	}



}catch (Exception e){

	  t = true;

}

finally

{

	try{if(rs != null) rs.close();}catch(SQLException e){}

	try{if(stmt != null) stmt.close();}catch(SQLException e){}

	try{if(conn != null) conn.close();}catch(SQLException e){}

}





// 隸屬FZPUR群組者，可使用 Cabin Report 功能
// 2013/06/13新增代理CM-->FZMC  
ci.auth.GroupsAuth ga = new ci.auth.GroupsAuth(userid);

try {

	ga.initData(); //取得userid 所屬群組資料



} catch (ClassNotFoundException e) {

	System.out.println(" Error:"+e.toString());

} catch (SQLException e) {

	System.out.println(" Error:"+e.toString());

}	

//****************************************************



%>

<html>

<head>

<title>function screen(AC)</title>

<meta http-equiv="Content-Type" content="text/html; charset=big5">

<SCRIPT Language="JavaScript" type="text/javascript">



//控制樹狀選單

function change(id,pi){  

	//該節點原本為隱藏，就將資料夾打開，並變更為開啟圖案

	if(document.getElementById("txt"+id).style.display == "none"){

		document.getElementById("txt"+id).style.display="";

		document.getElementById(pi).src="img2/open.gif";

	//隱藏其他資料夾,若新增節點，需變更i的值

	for(var i=1;i<6;i++){			

		if(i != id && document.getElementById("txt"+i) != null){

			document.getElementById("txt"+i).style.display ="none";				

			document.getElementById("pic"+i).src="img2/close.gif";

		}

	}



	}else{//關閉資料夾

		document.getElementById("txt"+id).style.display="none";

		document.getElementById(pi).src="img2/close.gif";		

	}



}

function load(w1,w2){

		parent.topFrame.location.href=w1;

		parent.mainFrame.location.href=w2;

}

function logout(){	

	top.location.href="sendredirect.jsp";

}





</script>

<SCRIPT Language="JavaScript" type="text/javascript" src="Language.js"></script>

<style type="text/css">

body,table,input {

	font-family: Verdana;

	font-size: 10pt;

}

body{

	background-color:#B1D3EC	;

	margin:2pt;

}

.n{

	display:inline;

}

.e4 {

	background-color: #edf3fe;

	color: #000000;

	text-align: center;

}



a:link,a:visited {  color: blue; text-decoration: none;}

a:hover,a:active {  color: #FFFFFF ;background-color: #0066B2	;  text-decoration: none; }

img{

	border:0pt;

}
</style>



</head>







<body >

<table width="100%" cellpadding="0" cellspacing="0" border="0" >

	  <tr>

		<td colspan="2"><div align="left"><span class="txtblue">Total Visit:</span><span class="txtxred"><%=counter%> </span></div></td>

	  </tr>

	  <tr>

	    <td colspan="2" ><span class="txtblue">TPE:<%=stTPE%></span><br>

	     <span class="txtblue">UTC:<%= stUTC%></span></td>

  </tr>

</table>

<br>

<%

if ("FA".equals(occu) | "FS".equals(occu) | "ZC".equals(occu) | "PR".equals(occu)  |"PU".equals(occu) |"CM".equals(occu) ) //ZC=PU &PR=CM   

{

%>

<br>

&nbsp;&nbsp;&nbsp;<input type="button" class="e4" id="chgL" onClick="chgLanguage()" value="ENGLISH">

<br>

	<img src="img2/Security.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("blank.htm","resetCIAPW.jsp")'><div class="n"id="n23">重設 CIA 密碼</div></a><br>

<%

}	

%>



<%

if ( "N".equals(locked) && ("FA".equals(occu) | "FS".equals(occu) | "ZC".equals(occu) | "PR".equals(occu)  ) |"PU".equals(occu) |"CM".equals(occu)  )

{

%>

<span style="cursor:pointer" onclick='change("1","pic1")' >

	<img src="img2/close.gif" width="24" height="24" id="pic1"><div class="n" id="n1">【換班&amp;選班專區】</div>

</span>

<div id="txt1" style="display:none;background-color:#ECF2F6	;" >

<table border="0" cellpadding="0" cellspacing="0" width="185">

    <tr>

      <td colspan="2">

	  	  <img height="16" src="img2/we.gif" width="16">&nbsp;<a href="#" onClick='load("blank.htm","CheckCrewBaseForCalcCr.jsp")'><div class="n"id="n18">換班飛時試算</div></a><br>

		  <img src="img2/Search.gif" width="16" height="16" >&nbsp;<a href="#"  onClick='load("AC/flyHrQuery.jsp","blank.htm")'><div class="n"id="n11">飛時查詢</div></a><br>

<!--		  <img src="img2/Table 1.gif" width="16" height="16" >&nbsp;<a href="#"  onClick='load("AC/putquery.jsp","blank.htm")'><div class="n" id="n12">欲換班表</div></a><br> -->

		  <img src="img2/Table 1.gif" width="16" height="16" >&nbsp;<a href="#"  onClick='load("AC/putSkjQuery.jsp","blank.htm")'><div class="n" id="n12">欲換班表/我的丟班資訊</div></a><br>		  

<!-- 		  <img src="img2/Browse 3.gif" width="16" height="16" >&nbsp;<a href="#" onClick='load("AC/psquery.jsp","blank.htm")'><div class="n"id="n13">查詢可換班表</div></a><br> -->

		  <img src="img2/Browse 3.gif" width="16" height="16" >&nbsp;<a href="#" onClick='load("AC/swapQuery.jsp","blank.htm")'><div class="n"id="n13">查詢可換班表</div></a><br>

<img src="img2/sup.gif" width="16" height="16" >&nbsp;<a href="#" onClick='load("AC/otherDutyQuery.jsp","blank.htm")'><div class="n" id="n13a">非飛行任務查詢</div></a><br>

<!-- 		  <img src="img2/View Doc.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","AC/showbook.jsp")'><div class="n"id="n14">我的丟班資訊</div></a><br> -->

<!-- 		  <img src="img2/Write.gif" width="16" height="16" >&nbsp;<a href="#"  onClick='load("blank.htm","swap3ac/step0.jsp")'><div class="n"id="n15">填申請單</div></a><br>

		  <img src="img2/rdoc.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("swap3ac/swapRdQuery.jsp","swap3ac/swapRd.jsp")'><div class="n"id="n16">申請單記錄</div></a><br>

 -->		

 <%

GregorianCalendar cal1 = new GregorianCalendar();

GregorianCalendar cal2 = new GregorianCalendar();

GregorianCalendar cal3 = new GregorianCalendar();//now



//stop_start  2009/02/11 08:30

cal1.set(Calendar.YEAR,2012);

cal1.set(Calendar.MONTH,9-1);

cal1.set(Calendar.DATE,11);

cal1.set(Calendar.HOUR_OF_DAY,8);

cal1.set(Calendar.MINUTE,1);



//stop_end  2009/02/11 10:30

cal2.set(Calendar.YEAR,2012);

cal2.set(Calendar.MONTH,9-1);

cal2.set(Calendar.DATE,11);

cal2.set(Calendar.HOUR_OF_DAY,10);

cal2.set(Calendar.MINUTE,30);	



if(cal1.before(cal3) && cal2.after(cal3))

{

%>

 	<img src="img2/Write.gif" width="16" height="16" >&nbsp;<div class="n"id="n15">填申請單(資料轉檔中)</div><br>

     <%

	if(("TPE".equals((String) session.getAttribute("base")) | "KHH".equals((String) session.getAttribute("base"))) && "1".equals(egStatus))

	{

	 %>

		  <img src="img2/rdoc.gif" width="16" height="16">&nbsp;<div class="n">全勤/積點選換班(資料轉檔中)</div><br>

	 <%

	}

}

else

{

%> 

 	<img src="img2/Write.gif" width="16" height="16" >&nbsp;<a href="#"  onClick='load("blank.htm","CheckCrewBase.jsp")'><div class="n"id="n15">填申請單</div></a><br>

<%

	  //out.print((String)session.getAttribute("base") );

	 //*******************************************************************************

	 //Add by Betty

	 //SX8028 全勤/積點選換班

	if(("TPE".equals((String) session.getAttribute("base")) | "KHH".equals((String) session.getAttribute("base"))) && "1".equals(egStatus))

	{

	 %>

		  <img src="img2/rdoc.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","credit/seloptions.html")'><div class="n">全勤/積點選換班</div></a><br>

	 <%

	}

	 //*******************************************************************************

}

%>

		 <img src="img2/rdoc.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","CheckCrewBaseForSwapRd.jsp")'><div class="n"id="n16">申請單記錄</div></a><br>



 <%

 //*******************************************************************************

 %>



 <%

 if("TPE".equals(   (String)session.getAttribute("base") ))

 {

 %>

 		  <img src="img2/download.gif" width="16" height="16" >&nbsp;<a href="#"  onClick='load("uploadquery.jsp","blank.htm")'><div class="n"id="n17">下載選班資訊</div></a>

  <%

  }

  %>

	  </td>

    </tr>

</table>

</div><br>

<%

}



//非簽派、辦公室才可看個人資料

if(!"ED".equals(occu) && !"O".equals(occu) && ifdispaly == false )

{

	//if(!occu.equals("FA") && !occu.equals("FS") && !occu.equals("PR") && !occu.equals("ZC"))

	if(!"FA".equals(occu) && !"FS".equals(occu) && !"PR".equals(occu) && !"ZC".equals(occu) && !"PU".equals(occu) && !"CM".equals(occu))

	{

%>

&nbsp;&nbsp;&nbsp;<input type="button" class="e4" id="chgL2" onClick="chgLanguage2()" value="ENGLISH"><br>

	<img src="img2/Security.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("blank.htm","resetCIAPW.jsp")'><div class="n"id="n23">重設 CIA 密碼</div></a><br>



<%

	}

%>



<span style="cursor:pointer" onclick='change("2","pic2")' >

	<img src="img2/close.gif" width="24" height="24" id="pic2"><div class="n" id="n2">【個人資料】</div>

</span>

<div id="txt2" style="display:none;background-color:#ECF2F6	;">



<table border="0" cellpadding="0" cellspacing="0" width="185">

      <tr>

        <td colspan="2">

<!-- 前後艙均可-->

	<img src="img2/notepad.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","editcrewinfo.jsp")'><div class="n"id="n21">組員個人資料</div></a><br>

<%



if(!"Y".equals(session.getAttribute("COCKPITCREW")) | "Y".equals((String)session.getAttribute("powerUser")))

{

//後艙才可使用

	%>

	<img src="img2/notepad.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","crewdoc/viewcrewdoc.jsp")'><div class="n"id="n21">組員証照資訊</div></a><br>



	<img src="img2/user2.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","AC/crewKindred/editCrewKindred.jsp")'><div class="n"id="n21a">組員家屬資料</div></a><br>

	<%

}

%>

	<img src="img2/cp.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("blank.htm","chgPw.jsp")'><div class="n"id="n22">變更系統密碼</div></a><br>

<!-- 	<img src="img2/Security.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("blank.htm","resetCIAPW.jsp")'><div class="n"id="n23">重設 CIA 密碼</div></a><br>

 -->	<img src="img2/01.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("flyPayQuery.htm","blank.htm")'><div class="n"id="n292">飛加清單</div></a><br>

	<img src="img2/doc3.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("loglistquery.htm","blank.htm")'><div class="n"id="n293">飛航記錄</div></a><br>
	
		<img src="img2/doc3.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("perFTDPQuery.jsp","blank.htm")'><div class="n"id="n21">個人飛時及執勤期間查詢</div></a><br>
	

	<img src="img2/spell.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","lock.jsp")'><div class="n"id="n28">鎖定開放班表</div></a><br>

	<img src="img2/doc.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("pay/sbmealQuery.jsp","blank.htm")'><div class="n" id="n40">待命誤餐費明細</div></a><br>

	<img src="img2/doc.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("pay/nobusQuery.jsp","blank.htm")'><div class="n" id="n41">無公車時段車費明細</div></a><br>
<%
if("Y".equals(cock))
{//前艙才可看
%>

	<img src="img2/doc.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("standbyquery.htm","blank.htm")'><div class="n" id="n42">待命逾時明細</div></a><br>
<%
}		
%>	



<%

//後艙才可看

//if(occu.equals("FA") | occu.equals("FS") | occu.equals("PR") | occu.equals("ZC") )

if("FA".equals(occu) | "FS".equals(occu) | "PR".equals(occu) | "ZC".equals(occu)  | "PU".equals(occu) |"CM".equals(occu))

{



 if("TPE".equals(   (String)session.getAttribute("base") ))

{

	//TPE Base 組員才可使用變更報到地點

%>



	<img src="img2/cp.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("blank.htm","chgCheckin.jsp")'><div class="n"id="n22a">變更報到地點</div></a><br>
	<img src="img2/Go.gif" width="16" height="16">&nbsp;<a href="crewshuttle/pickup.jsp" target="mainFrame"><div class="n">接車異動申請</div></a><br>

<%

}

%>	

	<img src="img2/Bookmarks 1.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","favorflt.jsp")'><div class="n"id="n24">自訂最愛航班</div></a><br>

	<img src="img2/Myv.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","AC/favrquery.jsp")'><div class="n"id="n25">喜好航班查詢</div></a><br>

	<img src="img2/sup.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","AC/goodfriend.jsp")'><div class="n"id="n26">自訂好友名單</div></a><br>
	

<!--<img src="img2/we.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","../AL/ALLoginCheck.jsp")'><div class="n"id="n27">客艙組員網路特休假申請系統</div></a><br>-->

<!--******************************************************************************************-->

<%

if("TPE".equals(   (String)session.getAttribute("base") ) | "KHH".equals(   (String)session.getAttribute("base") ))

{

if("1".equals(egStatus))

{	

%>

<hr>

<img src="img2/we.gif" width="16" height="16">&nbsp;組員請休假<br>

<li><a href="#"  onClick='load("blank.htm","../off/offsheetQuery.jsp")'><div class="n"id="n27">Enquery off records</div></a><br>

<li><a href="#"  onClick='load("blank.htm","../off/AL/aloffsheet.jsp")'><div class="n"id="n27">AL/XL off-sheet</div></a><br>

<li><a href="#"  onClick='load("blank.htm","../off/AL/alquotacount.jsp")'><div class="n"id="n27">AL Quota</div></a><br>



<%

	//if("192.168".equals(userip.substring(0,7)) | "10.18".equals(userip.substring(0,5)))  ---CS40 modified 2010/3/14

	if("192.168".equals(userip.substring(0,7)) | "10.16".equals(userip.substring(0,5))) 

	{	

%>		

        <li><a href="#"  onClick='load("blank.htm","../off/Leave/leaveoffsheet.jsp")'><div class="n"id="n27">SL/PL/EL/WL/FL/LSW</div></a><br>

		<li><a href="#"  onClick='load("../off/Leave/offEmpno.jsp","blank.htm")'><div class="n"id="n27">代填假單</div></a><br> 

<%

	}	


%>

<hr>

<%

}//if("1".equals(egStatus))	

else

{

%>	

	<img src="img2/we.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","noALMessage.htm")'><div class="n"id="n27">組員請休假</div></a><br>

<%

}



}// if("TPE".equals(   (String)session.getAttribute("base") ))



%>

<!--******************************************************************************************-->

	<img src="img2/doc.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("reqFixpayQuery.htm","blank.htm")'><div class="n"id="n29">定額飛加</div></a><br>

	<img src="img2/doc.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("overTimeQuery.jsp","blank.htm")'><div class="n"id="n29b">加班費明細</div></a><br>

	<img src="img2/Floppy.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("reqAwdListQuery.jsp","blank.htm")'><div class="n"id="n291">獎懲通報</div></a><br>

	

<%

}

if("FA".equals(occu) | "FS".equals(occu) | "PR".equals(occu) | "ZC".equals(occu) | "PU".equals(occu) |"CM".equals(occu))
{
%>
<img src="img2/01.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("EC/reportquery.htm","blank.htm")'><div class="n" id="n294">免稅品扣補</div></a><br>

<img src="img2/01.gif" width="16" height="16">&nbsp;<a href="#"  onClick="window.open('http://dfgir.china-airlines.com','wname','left=100,top=100,width=800,height=600,toolbar=yes,scrollbars=yes,resizable=yes,location=yes,directories=yes,menubar=yes,status=yes')"><div class="n" id="n294">免稅品異常報告系統</div></a><br>

<img src="img2/01.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("PRAC/crewEval/crewScoreQuery.jsp","blank.htm")'><div class="n" id="n295">任務評分</div></a><br>
<%
}
%>
        </td>
    </tr>
</table>
</div><br>

<%

}

//開放班表，及簽派，可看「其他功能」

if("N".equals(locked) | "ED".equals(occu) | ifdispaly == true | "180A".equals(occu)  | "U".equals(occu))
{

%>

<span style=cursor:pointer onclick='change("3","pic3")' >

	<img src="img2/close.gif" width="24" height="24" id="pic3"><div class="n"id="n3">【其他功能】</div>

</span>

<div id="txt3" style="display:none;background-color:#ECF2F6	;">

<table border="0" cellpadding="0" cellspacing="0" width="185">

  <tr>

    <td colspan="2">

		<img src="img2/notice.jpg" width="16" height="16">&nbsp;<a href="#" onClick='load("PRAC/blank.htm","notice/FSMenu.jsp")'><div class="n" id="n33">公告資訊</div></a><br>

		<img src="img2/Get Mail.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("AC/crewInfoQueryPage.htm","blank.htm")'><div class="n" id="n31">查詢組員電話</div></a><br>

		<img src="img2/02.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("efmail.htm","blank.htm")'><div class="n" id="n32">意見信箱</div></a>
	</td>

  </tr>

  </table>

</div><br>
<%
}

//開放班表，及簽派，可看「公告資訊」

if("FA".equals(occu) | "FS".equals(occu) | "PR".equals(occu) | "ZC".equals(occu)  | "PU".equals(occu) |"CM".equals(occu))
{
	boolean hasnew = false;
	String shownew = "";
	eg.propAganda.PropAganda pad =  new eg.propAganda.PropAganda();
    pad.getunConfirmPropAgandaList(userid);
	ArrayList objAL4 = pad.getObjAL();
	if(objAL4.size() > 0)
	{
		shownew = "<em><font size=\"4\" color=\"#FF0000\"><strong>New</strong></font></em> ";
	}
	eg.css.PURCSSConfirm ccr =  new eg.css.PURCSSConfirm();
    ccr.getConfirmCSS(userid);
	ArrayList objALCSS = ccr.getObjAL();
    if(objALCSS.size()>0)
	{
		shownew = "<em><font size=\"4\" color=\"#FF0000\"><strong>New</strong></font></em> ";
	}

%>
<span style=cursor:pointer onclick='change("5","pic5")' >

	<img src="img2/close.gif" width="24" height="24" id="pic4"><div class="n" id="n5">【公告資訊】<%=shownew%></div>

</span>

<div id="txt5" style="display:none;background-color:#ECF2F6	;">

<table border="0" cellpadding="0" cellspacing="0" width="185">
  <tr>
    <td colspan="2">
		<img src="img2/notice.jpg" width="16" height="16">&nbsp;<a href="#" onClick='load("PRAC/blank.htm","notice/FSMenu.jsp")'><div class="n" id="n51">公告資訊</div></a><br>
	</td>	
  </tr>
  <tr>
    <td colspan="2">
	<img src="img2/notice.jpg" width="16" height="16">&nbsp;<a href="#" onClick='load("PRAC/blank.htm","notice/CSS/cssMenu.jsp")'><div class="n" id="n51">旅客來函</div></a>

	</td>	
  </tr>
</table>

</div><br>
<%

}


//取得人事資料

fzAuthP.UserID usr = new fzAuthP.UserID(userid,null);

fzAuthP.CheckHR ckHr = new fzAuthP.CheckHR();

fzAuthP.HRObj hrObj = ckHr.getHrObj ();



//

/*

簽派及本team,Office,空服組長(postcd=192G)可看「申請單查詢」

OV 曹經理,EF王文樺可使用「編輯最新消息」

193G(空標部-于堯)

*/

//if("ED".equals(occu)| "Y".equals((String)session.getAttribute("powerUser")) |  "O".equals(auth) | "192G".equals(hrObj.getPostcd()) | "193G".equals(hrObj.getPostcd()) | ifdispaly == true )

	
if("ED".equals(occu) | "Y".equals((String)session.getAttribute("powerUser")) |  ("O".equals(auth) && !"811".equals( hrObj.getUnitcd())) | "192G".equals(hrObj.getPostcd()) | "193G".equals(hrObj.getPostcd()) | ifdispaly == true | "180A".equals(occu))
{
%>

<span style="cursor:pointer" onclick='change("4","pic4")' >

	<img src="img2/close.gif" width="24" height="24" id="pic4">【管理功能】

</span>

<div id="txt4" style="display:none;background-color:#ECF2F6	;">

<table border="0" cellpadding="0" cellspacing="0">

    <td colspan="2">

		<img src="img2/notepad.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("confquery.jsp","blank.htm")'>申請單查詢</A><br>

		<img src="img2/p1.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","SMSAC/SMSQuery.jsp")'>簡訊通報<a/><br>

<%

	//if("192.168".equals(userip.substring(0,7)) | "10.18".equals(userip.substring(0,5)))  --cs40 modified 2010/3/14

	if("192.168".equals(userip.substring(0,7)) | "10.16".equals(userip.substring(0,5))) 

	{

		if(ga.isBelongThisGroup("EZEFOFFICE") | ga.isBelongThisGroup("EZEGBLINS") | ga.isBelongThisGroup("EZOFFAM") | "Y".equals((String)session.getAttribute("powerUser")) )

		{ 

%>

		<img src="img2/doc5.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("../off/Leave/offEmpno.jsp","blank.htm")'><div class="n"id="n27">代填假單</div></a><br> 

<%

		}

	}	

%>

<!--**************************************************************************-->



<%

if("ED".equals(occu) | "Y".equals((String)session.getAttribute("powerUser")) )

{

%>

	<img src="img2/cp.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("formquery.jsp","blank.htm")'>申請單處理</a><BR>

	<img src="img2/doc3.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","max.jsp")'>設定受理數量</a><BR>

	<img src="img2/04.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("chgSwapFromQuery.jsp","chgSwapFromMenu.htm")'>更新申請單狀態</a><br>

	<img src="img2/doc.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","comm.jsp")'>設定審核意見</a><br>

	<img src="img2/rdoc.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("blank.htm","setdate.jsp")'>設定不受理日</a><br>
	
<%
	//李昌隆(632544), 耿俊元(641090), 徐淑惠(638716), 
	if("632544".equals(userid) | "641090".equals(userid) | "638716".equals(userid) | "Y".equals((String)session.getAttribute("powerUser")) )	
	{
%>	
	

	<img src="img2/cal.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("blank.htm","AC/pubSkj.jsp")'>設定班表公布日期</a><br>
<%
	}	
%>	

	<img src="img2/sup.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("blank.htm","crewcomm.jsp")'>設定組員申請附註</a><br>
	<!--<img src="img2/sup.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("blank.htm","alparaset.jsp")'>設定AL相關參數</a><br> WEBEG -->
	<img src="img2/sup.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("blank.htm","AC/resthrset.jsp")'>設定特殊航班休時</a><br>
	

	<!--<img src="img2/Reply.gif" width="16" height="16">&nbsp;寄送月班表<br>

	<img src="img2/doc4.gif" width="16" height="16">&nbsp;寄送月班表確認<br>

	<img src="img2/File.gif" width="16" height="16">&nbsp;批次寄送月班表確認<br>

	-->

	<img src="img2/c2.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("blank.htm","uploadfile.htm")'>上傳檔案</a><br>

	<img src="img2/download.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("uploadquery.jsp","blank.htm")'>查詢選班資訊</a><br>

	<img src="img2/d1.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","edHotNews.jsp")'>編輯最新消息</a><br>



	<img src="img2/user2.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("blank.htm","AC/retireEmp.jsp")'>屆退人員名單維護<a/><br>

	<img src="img2/we.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("blank.htm","realSwap/realSwapAdm.jsp")'>實體換班記錄</a><br>		

	<img src="img2/Fav.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","adm/ciiRptMenu.jsp")'>CII Report</a><BR>

	<img src="img2/we.gif"  width="16"height="16">&nbsp;<a href="#"  onClick='load("blank.htm","swapkhh/swapkhhMenu.jsp")'>KHH換班管理</a><BR>		

		<%

		//SR6310 申請單處理統計,此功能僅開放ED 經理、副理、助理使用,管理者請從 「管理及功能測試」選項進入



		if("190A".equals( hrObj.getUnitcd()) )

		{	//ED

			if("547E".equals(hrObj.getPostcd()) //經理

			 | "401F".equals(hrObj.getPostcd()) //副理

			 | "491".equals(hrObj.getPostcd())  //助理

			 )

		     {

		%>

		<img src="img2/doc3.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("blank.htm","formRpt/formRptMenu.jsp")'>申請單處理數量統計</a>		

		<%

		     }

        }

}



if(ifdispaly == true)

{

%>

	<img src="img2/cp.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("formquery.jsp","blank.htm")'>申請單處理</a><BR>

	<img src="img2/doc3.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","max.jsp")'>設定受理數量</a><BR>

	<img src="img2/04.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("chgSwapFromQuery.jsp","chgSwapFromMenu.htm")'>更新申請單狀態</a><br>

	<img src="img2/c2.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("blank.htm","uploadfile.htm")'>上傳檔案</a><br>

	<img src="img2/download.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("uploadquery.jsp","blank.htm")'>查詢選班資訊</a><br>

	<img src="img2/d1.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","edHotNews.jsp")'>編輯最新消息</a><br>

	<img src="img2/we.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("blank.htm","realSwap/realSwapAdm.jsp")'>實體換班記錄</a><br>		

	<img src="img2/Fav.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","adm/ciiRptMenu.jsp")'>CII Report</a><BR>

<%

}		



if("180A".equals(occu))
{
%>
	<img src="img2/Fav.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","adm/ciiRptMenu.jsp")'>CII Report</a><br>
<%
}	

//功能 : CII Report - Daily Check, Standby Crew, Schedule Query, Crew List Query, ACM List

//人員 : 628933-呂國粹  628930-文郁久  625384 -彭永銓  628997-潘文琮  625303-羅申  631210-劉君祥
/*
任靜嫻  634341
吳曉星  631711
李寧馨  625554
楊宜貞  630162
董倩倩  632970
鄒惠珍  635810
潘媚恩  631255
鄭芳如  636149
*/
if("628933".equals(userid) | "628930".equals(userid) | "628997".equals(userid) | 

   "625303".equals(userid) | "625384".equals(userid) | "634341".equals(userid) | "631711".equals(userid) | "625554".equals(userid) | "630162".equals(userid) | "632970".equals(userid) | "635810".equals(userid) | "631255".equals(userid) | "636149".equals(userid) | "631210".equals(userid) | 

   "Y".equals((String)session.getAttribute("powerUser")))

{

  %>

  <img src="img2/doc3.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","adm/ciiRptMenu_ef.jsp")'>EF-CII Report</a><br>

  <%

}//if



//OV 曹經理,EF王文樺可使用「編輯最新消息」

if("629678".equals(userid) ||  "626914".equals(userid))

{

%>		

        <img src="img2/d1.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","edHotNews.jsp")'>編輯最新消息</a><br>

<%

}



//空一組可用 OD Import 功能
//20130204改組後-各組助理OD Import
if("Y".equals((String)session.getAttribute("powerUser")) || "196".equals(hrObj.getUnitcd()) || "197".equals(hrObj.getUnitcd()) || "198".equals(hrObj.getUnitcd()) || "199".equals(hrObj.getUnitcd())|| "199A".equals(hrObj.getUnitcd())  || "195B".equals(hrObj.getUnitcd()) )
{

%>

<img src="images/database_save.gif" width="16" height="16">&nbsp;<a href="#" onClick="load('PRAC/ODDuty/odImportQuery.jsp','PRAC/ODDuty/ODImportMenu.htm')">OD Import</a><br>

<img src="images/database_save.gif" width="16" height="16">&nbsp;<a href="#" onClick="load('PRAC/ODDuty/acmImportQuery.jsp','PRAC/ODDuty/ACMImportMenu.htm')">ACM Import</a><br>

<%

}





//空訓.空服行政可用匯入新進組員帳號功能 SR7242

if( "189".equals(hrObj.getUnitcd()) ||   "1813".equals(hrObj.getUnitcd()) ||  "1812".equals(hrObj.getUnitcd()) || "181D".equals(hrObj.getUnitcd()) || "Y".equals((String)session.getAttribute("powerUser")) )

{

%>

<img src="images/database_save.gif" width="16" height="16">&nbsp;<a href="#" onClick="load('newCrew/boxQuery.jsp','blank.htm')">Import New Crew</a><br>



<%

}

%>

	</td>

  </tr>

  </table>

</div><br>

<%

}

%>



<table border="0" cellpadding="0" cellspacing="0" width="185">

  <tr>

    <td>&nbsp;</td>

	

    <td>

<%
  
/*ZC有acting-MC or Special=J可寫Cabin report*/
if( "CM".equals(occu) | "PR".equals(occu) | "Y".equals((String)session.getAttribute("powerUser"))| ga.isBelongThisGroup("FZPUR") 
|"ZC".equals(occu) |"PU".equals(occu) |"Y".equals((String)session.getAttribute("ZC"))) 
{		
	if(newName){
%>
		
		<img src="img2/doc5.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","PRAC_old/PRSel.jsp")'>Cabin Report</a><br><br>

		<img src="img2/doc5.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","PRAC/PRSel.jsp")'>Cabin Report new</a><br><br>


		<!-- CS40 2008/12/05 --><!--<img src="img2/doc5.gif" width="16" height="16">&nbsp;<a href="http://tsaweb02.china-airlines.com/outstn/GBCabinCrewList.aspx" target="mainFrame"><div class="n"id="n93">簡體版crew list</div></a><br><br>-->
<%
		
	}else{
		
%>

		<img src="img2/doc5.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","PRAC/PRSel.jsp")'>Purser Report</a><br><br>

		<img src="img2/doc5.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","PRAC/PRSel.jsp")'>Purser Report new</a><br><br>


		<!-- CS40 2008/12/05 --><!--<img src="img2/doc5.gif" width="16" height="16">&nbsp;<a href="http://tsaweb02.china-airlines.com/outstn/GBCabinCrewList.aspx" target="mainFrame"><div class="n"id="n93">簡體版crew list</div></a><br><br>-->
<%		
	}

}


//ZC 助理座艙長

//out.print("if ZC "+session.getAttribute("ZC"));

if("Y".equals((String)session.getAttribute("powerUser")) | ga.isBelongThisGroup("FZPUR") |"ZC".equals(occu) |"PU".equals(occu) |"Y".equals((String)session.getAttribute("ZC"))){	
	if(newName){
%>
	<img src="img2/doc5.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","PRAC/ZC/zcMenu.jsp")'>Purser Report</a><br><br>
<%			
		
	}else{
%>
		<img src="img2/doc5.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","PRAC/ZC/zcMenu.jsp")'>Zone Chief Report</a><br><br>

<%		
	}


}

if("Y".equals((String)session.getAttribute("powerUser"))) 

{

%>

<img src="img2/user2.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","adm/admMenu.jsp")'>管理及功能測試</a>

		<br>

		  		



<%

}

%>		

	</td>

  </tr>

  <tr>

    <td>&nbsp;</td>

    <td>

<%

if("Y".equals(cock))
{//前艙

%>

<img src="img2/doc.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("pr_interface/simchk_querycond.jsp","blank.htm")'>SIM Check </a><br>

<%

}



if("C".equals((String)session.getAttribute("auth")) | "Y".equals((String)session.getAttribute("powerUser")))

{	//組員

	

	

	%>

<!--<hr><img src="img2/doc.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","ngbForm/editNGB.jsp")'><div class="n"id="n91">台胞證資料輸入</div></a><br> 

	<hr>-->

	<img src="img2/doc.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","tsaForm/editTSA.jsp")'><div class="n"id="n91">編輯MCL</div></a><br>
	<img src="img2/Go.gif" width="16" height="16">&nbsp;<a href="http://ch.e-go.com.tw/" target="mainFrame"><div class="n"id="n93">報到接車查詢</div></a><br>

	<%


}
		

 if("ED".equals(occu) | ("TPE".equals( (String)session.getAttribute("base")) && ("FA".equals(occu) | "FS".equals(occu) | "ZC".equals(occu) | "PR".equals(occu) | "PU".equals(occu) | "CM".equals(occu))))

{

%>		

		<!--<img src="img2/doc3.gif" width="16" height="16">&nbsp;<div class="n"id="n92">任務異動通知</div><br> -->

		<img src="img2/Go.gif" width="16" height="16">&nbsp;<a href="crewshuttle/pickup.jsp" target="mainFrame"><div class="n">接車異動申請</div></a><br>

<%

}

%>		

		<!-- <img src="img2/Send.gif" width="16" height="16">&nbsp;<a href="#" onClick="load('blank.htm','msgAC.jsp')" ><div class="n"id="n94">CIA 測試回報</div></a> <br>-->

		<img src="img2/p2.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","AC/UserList.jsp")'><div class="n"id="n95">線上使用者</div></a><br>

		<!--<img src="img2/doc2.gif" width="16" height="16">&nbsp;<div class="n"id="n96">使用說明</div><br>

		<img src="img2/pen.gif" width="16" height="16">&nbsp;<div class="n"id="n97">申請單填寫說明</div><br> -->

		<img src="img2/Security.gif" width="16" height="16">&nbsp;<a href="#"  onClick="logout()"><div class="n" id="n0">登出</div></a><br>
	</td>

  </tr>

</table>

<br>

<hr width="100%">

&nbsp;&nbsp;&nbsp;<input type="button"  class="e4" onClick="javascript:window.open('http://cia.china-airlines.com');" value=" CIA 班表查詢"  >

<!-- <input type="button" id="oldversion" name="oldversion" class="e4" onClick="javascript:self.location='fscreen.jsp';top.topFrame.location='blank.htm';top.mainFrame.location='blank.htm';" value="使用舊版功能"  > -->

<br>







</body>



</html>

<%
//out.print(newName);

out.print(occu);

}


%>
<%@page contentType="text/html; charset=big5" language="java" %>

<%@page import="fz.*,java.sql.*,java.util.*,java.text.DateFormat,ci.db.*"%>

<%

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



// EG status, 1=�b¾

String egStatus = (String)session.getAttribute("EGStatus");



String password = (String) session.getAttribute("password");

String auth = (String) session.getAttribute("auth"); //get user id if already login

String occu = (String) session.getAttribute("occu");

String locked = (String) session.getAttribute("locked");//N : ����w/�}��, Y : ��w/���}��

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





// ����FZPUR�s�ժ̡A�i�ϥ� Purser Report �\��

ci.auth.GroupsAuth ga = new ci.auth.GroupsAuth(userid);

try {

	ga.initData(); //���ouserid ���ݸs�ո��



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



//����𪬿��

function change(id,pi){  

	//�Ӹ`�I�쥻�����áA�N�N��Ƨ����}�A���ܧ󬰶}�ҹϮ�

	if(document.getElementById("txt"+id).style.display == "none"){

		document.getElementById("txt"+id).style.display="";

		document.getElementById(pi).src="img2/open.gif";

	//���è�L��Ƨ�,�Y�s�W�`�I�A���ܧ�i����

	for(var i=1;i<5;i++){			

		if(i != id && document.getElementById("txt"+i) != null){

			document.getElementById("txt"+i).style.display ="none";				

			document.getElementById("pic"+i).src="img2/close.gif";

		}

	}



	}else{//������Ƨ�

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

.style1 {color: #B1D3EC}
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

if ("FA".equals(occu) | "FS".equals(occu) | "ZC".equals(occu) | "PR".equals(occu)  )  

{

%>

<br>

&nbsp;&nbsp;&nbsp;<input type="button" class="e4" id="chgL" onClick="chgLanguage()" value="ENGLISH">

<br>

	<img src="img2/Security.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("blank.htm","resetCIAPW.jsp")'><div class="n"id="n23">���] CIA �K�X</div></a><br>

<%

}	

%>



<%

if ( "N".equals(locked) && ("FA".equals(occu) | "FS".equals(occu) | "ZC".equals(occu) | "PR".equals(occu)  )   )

{

%>

<span style="cursor:pointer" onclick='change("1","pic1")' >

	<img src="img2/close.gif" width="24" height="24" id="pic1"><div class="n" id="n1">�i���Z&amp;��Z�M�ϡj</div>

</span>

<div id="txt1" style="display:none;background-color:#ECF2F6	;" >

<table border="0" cellpadding="0" cellspacing="0" width="185">

    <tr>

      <td colspan="2">

	  	  <img height="16" src="img2/we.gif" width="16">&nbsp;<a href="#" onClick='load("blank.htm","CheckCrewBaseForCalcCr.jsp")'><div class="n"id="n18">���Z���ɸպ�</div></a><br>

		  <img src="img2/Search.gif" width="16" height="16" >&nbsp;<a href="#"  onClick='load("AC/flyHrQuery.jsp","blank.htm")'><div class="n"id="n11">���ɬd��</div></a><br>

<!--		  <img src="img2/Table 1.gif" width="16" height="16" >&nbsp;<a href="#"  onClick='load("AC/putquery.jsp","blank.htm")'><div class="n" id="n12">�����Z��</div></a><br> -->

		  <img src="img2/Table 1.gif" width="16" height="16" >&nbsp;<a href="#"  onClick='load("AC/putSkjQuery.jsp","blank.htm")'><div class="n" id="n12">�����Z��/�ڪ���Z��T</div></a><br>		  

<!-- 		  <img src="img2/Browse 3.gif" width="16" height="16" >&nbsp;<a href="#" onClick='load("AC/psquery.jsp","blank.htm")'><div class="n"id="n13">�d�ߥi���Z��</div></a><br> -->

		  <img src="img2/Browse 3.gif" width="16" height="16" >&nbsp;<a href="#" onClick='load("AC/swapQuery.jsp","blank.htm")'><div class="n"id="n13">�d�ߥi���Z��</div></a><br>

<img src="img2/sup.gif" width="16" height="16" >&nbsp;<a href="#" onClick='load("AC/otherDutyQuery.jsp","blank.htm")'><div class="n" id="n13a">�D������Ȭd��</div></a><br>

<!-- 		  <img src="img2/View Doc.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","AC/showbook.jsp")'><div class="n"id="n14">�ڪ���Z��T</div></a><br> -->

<!-- 		  <img src="img2/Write.gif" width="16" height="16" >&nbsp;<a href="#"  onClick='load("blank.htm","swap3ac/step0.jsp")'><div class="n"id="n15">��ӽг�</div></a><br>

		  <img src="img2/rdoc.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("swap3ac/swapRdQuery.jsp","swap3ac/swapRd.jsp")'><div class="n"id="n16">�ӽг�O��</div></a><br>

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

 	<img src="img2/Write.gif" width="16" height="16" >&nbsp;<div class="n"id="n15">��ӽг�(������ɤ�)</div><br>

     <%

	if(("TPE".equals((String) session.getAttribute("base")) | "KHH".equals((String) session.getAttribute("base"))) && "1".equals(egStatus))

	{

	 %>

		  <img src="img2/rdoc.gif" width="16" height="16">&nbsp;<div class="n">����/�n�I�ﴫ�Z(������ɤ�)</div><br>

	 <%

	}

}

else

{

%> 

 	<img src="img2/Write.gif" width="16" height="16" >&nbsp;<a href="#"  onClick='load("blank.htm","CheckCrewBase.jsp")'><div class="n"id="n15">��ӽг�</div></a><br>

<%

	  //out.print((String)session.getAttribute("base") );

	 //*******************************************************************************

	 //Add by Betty

	 //SX8028 ����/�n�I�ﴫ�Z

	if(("TPE".equals((String) session.getAttribute("base")) | "KHH".equals((String) session.getAttribute("base"))) && "1".equals(egStatus))

	{

	 %>

		  <img src="img2/rdoc.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","credit/seloptions.html")'><div class="n">����/�n�I�ﴫ�Z</div></a><br>

	 <%

	}

	 //*******************************************************************************

}

%>

		 <img src="img2/rdoc.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","CheckCrewBaseForSwapRd.jsp")'><div class="n"id="n16">�ӽг�O��</div></a><br>



 <%

 //*******************************************************************************

 %>



 <%

 if("TPE".equals(   (String)session.getAttribute("base") ))

 {

 %>

 		  <img src="img2/download.gif" width="16" height="16" >&nbsp;<a href="#"  onClick='load("uploadquery.jsp","blank.htm")'><div class="n"id="n17">�U����Z��T</div></a>

  <%

  }

  %>

	  </td>

    </tr>

</table>

</div><br>

<%

}



//�Dñ���B�줽�Ǥ~�i�ݭӤH���

if(!"ED".equals(occu) && !"O".equals(occu) && ifdispaly == false )

{

	//if(!occu.equals("FA") && !occu.equals("FS") && !occu.equals("PR") && !occu.equals("ZC"))

	if(!"FA".equals(occu) && !"FS".equals(occu) && !"PR".equals(occu) && !"ZC".equals(occu))

	{

%>

&nbsp;&nbsp;&nbsp;<input type="button" class="e4" id="chgL2" onClick="chgLanguage2()" value="ENGLISH"><br>

	<img src="img2/Security.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("blank.htm","resetCIAPW.jsp")'><div class="n"id="n23">���] CIA �K�X</div></a><br>



<%

	}

%>



<span style="cursor:pointer" onclick='change("2","pic2")' >

	<img src="img2/close.gif" width="24" height="24" id="pic2"><div class="n" id="n2">�i�ӤH��ơj</div>

</span>

<div id="txt2" style="display:none;background-color:#ECF2F6	;">



<table border="0" cellpadding="0" cellspacing="0" width="185">

      <tr>

        <td colspan="2">

<!-- �e�῵���i-->

	<img src="img2/notepad.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","editcrewinfo.jsp")'><div class="n"id="n21">�խ��ӤH���</div></a><br>

<%



if(!"Y".equals(session.getAttribute("COCKPITCREW")) | "Y".equals((String)session.getAttribute("powerUser")))

{

//�῵�~�i�ϥ�

	%>

	<img src="img2/notepad.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","crewdoc/viewcrewdoc.jsp")'><div class="n"id="n21">�խ����Ӹ�T</div></a><br>



	<img src="img2/user2.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","AC/crewKindred/editCrewKindred.jsp")'><div class="n"id="n21a">�խ��a�ݸ��</div></a><br>

	<%

}

%>

	<img src="img2/cp.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("blank.htm","chgPw.jsp")'><div class="n"id="n22">�ܧ�t�αK�X</div></a><br>

<!-- 	<img src="img2/Security.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("blank.htm","resetCIAPW.jsp")'><div class="n"id="n23">���] CIA �K�X</div></a><br>

 -->	<img src="img2/01.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("flyPayQuery.htm","blank.htm")'><div class="n"id="n292">���[�M��</div></a><br>

	<img src="img2/doc3.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("loglistquery.htm","blank.htm")'><div class="n"id="n293">����O��</div></a><br>

	<img src="img2/spell.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","lock.jsp")'><div class="n"id="n28">��w�}��Z��</div></a><br>

	<img src="img2/doc.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("pay/sbmealQuery.jsp","blank.htm")'><div class="n" id="n40">�ݩR�~�\�O����</div></a><br>

	<img src="img2/doc.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("pay/nobusQuery.jsp","blank.htm")'><div class="n" id="n41">�L�����ɬq���O����</div></a><br>
<%
if("Y".equals(cock))
{//�e���~�i��
%>

	<img src="img2/doc.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("standbyquery.htm","blank.htm")'><div class="n" id="n42">�ݩR�O�ɩ���</div></a><br>
<%
}		
%>	



<%

//�῵�~�i��

//if(occu.equals("FA") | occu.equals("FS") | occu.equals("PR") | occu.equals("ZC") )

if("FA".equals(occu) | "FS".equals(occu) | "PR".equals(occu) | "ZC".equals(occu))

{



 if("TPE".equals(   (String)session.getAttribute("base") ))

{

	//TPE Base �խ��~�i�ϥ��ܧ����a�I

%>



	<img src="img2/cp.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("blank.htm","chgCheckin.jsp")'><div class="n"id="n22a">�ܧ����a�I</div></a><br>
	<img src="img2/Go.gif" width="16" height="16">&nbsp;<a href="crewshuttle/pickup.jsp" target="mainFrame"><div class="n">�������ʥӽ�</div></a><br>

<%

}

%>	

	<img src="img2/Bookmarks 1.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","favorflt.jsp")'><div class="n"id="n24">�ۭq�̷R��Z</div></a><br>

	<img src="img2/Myv.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","AC/favrquery.jsp")'><div class="n"id="n25">�ߦn��Z�d��</div></a><br>

	<img src="img2/sup.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","AC/goodfriend.jsp")'><div class="n"id="n26">�ۭq�n�ͦW��</div></a><br>
	

<!--<img src="img2/we.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","../AL/ALLoginCheck.jsp")'><div class="n"id="n27">�ȿ��խ������S�𰲥ӽШt��</div></a><br>-->

<!--******************************************************************************************-->

<%

if("TPE".equals(   (String)session.getAttribute("base") ) | "KHH".equals(   (String)session.getAttribute("base") ))

{

if("1".equals(egStatus))

{	

%>

<hr>

<img src="img2/we.gif" width="16" height="16">&nbsp;�խ��Х�<br>

<li><a href="#"  onClick='load("blank.htm","../off/offsheetQuery.jsp")'><div class="n"id="n27">Enquery off records</div></a><br>

<li><a href="#"  onClick='load("blank.htm","../off/AL/aloffsheet.jsp")'><div class="n"id="n27">AL/XL off-sheet</div></a><br>

<li><a href="#"  onClick='load("blank.htm","../off/AL/alquotacount.jsp")'><div class="n"id="n27">AL Quota</div></a><br>



<%

	//if("192.168".equals(userip.substring(0,7)) | "10.18".equals(userip.substring(0,5)))  ---CS40 modified 2010/3/14

	if("192.168".equals(userip.substring(0,7)) | "10.16".equals(userip.substring(0,5))) 

	{	

%>		

        <li><a href="#"  onClick='load("blank.htm","../off/Leave/leaveoffsheet.jsp")'><div class="n"id="n27">SL/PL/EL/WL/FL/LSW</div></a><br>

		<li><a href="#"  onClick='load("../off/Leave/offEmpno.jsp","blank.htm")'><div class="n"id="n27">�N�񰲳�</div></a><br> 

<%

	}	

%>

<hr>

<%

}//if("1".equals(egStatus))	

else

{

%>	

	<img src="img2/we.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","noALMessage.htm")'><div class="n"id="n27">�խ��Х�</div></a><br>

<%

}



}// if("TPE".equals(   (String)session.getAttribute("base") ))



%>

<!--******************************************************************************************-->

	<img src="img2/doc.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("reqFixpayQuery.htm","blank.htm")'><div class="n"id="n29">�w�B���[</div></a><br>

	<img src="img2/doc.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("overTimeQuery.jsp","blank.htm")'><div class="n"id="n29b">�[�Z�O����</div></a><br>

	<img src="img2/Floppy.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("reqAwdListQuery.jsp","blank.htm")'><div class="n"id="n291">���g�q��</div></a><br>

	

<%

}

if("FA".equals(occu) | "FS".equals(occu) | "PR".equals(occu) | "ZC".equals(occu))
{
%>
<img src="img2/01.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("EC/reportquery.htm","blank.htm")'><div class="n" id="n294">�K�|�~����</div></a><br>

<img src="img2/01.gif" width="16" height="16">&nbsp;<a href="#"  onClick="window.open('http://dfgir.china-airlines.com','wname','left=100,top=100,width=800,height=600,toolbar=yes,scrollbars=yes,resizable=yes,location=yes,directories=yes,menubar=yes,status=yes')"><div class="n" id="n294">�K�|�~���`���i�t��</div></a><br>

<img src="img2/01.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("PRAC/crewEval/crewScoreQuery.jsp","blank.htm")'><div class="n" id="n295">���ȵ���</div></a><br>
<%
}
%>
        </td>
    </tr>
</table>
</div><br>

<%

}

//�}��Z���A��ñ���A�i�ݡu��L�\��v

if("N".equals(locked) | "ED".equals(occu) | ifdispaly == true | "180A".equals(occu)  | "U".equals(occu))
{

%>

<span style=cursor:pointer onclick='change("3","pic3")' >

	<img src="img2/close.gif" width="24" height="24" id="pic3"><div class="n"id="n3">�i��L�\��j</div>

</span>

<div id="txt3" style="display:none;background-color:#ECF2F6	;">

<table border="0" cellpadding="0" cellspacing="0" width="185">

  <tr>

    <td colspan="2">

		<img src="img2/Get Mail.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("AC/crewInfoQueryPage.htm","blank.htm")'><div class="n"id="n31">�d�߲խ��q��</div></a><br>

		<img src="img2/02.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("efmail.htm","blank.htm")'><div class="n"id="n32">�N���H�c</div></a>

	</td>

  </tr>

  </table>

</div><br>
<%

}





//���o�H�Ƹ��

fzAuthP.UserID usr = new fzAuthP.UserID(userid,null);

fzAuthP.CheckHR ckHr = new fzAuthP.CheckHR();

fzAuthP.HRObj hrObj = ckHr.getHrObj ();



//

/*

ñ���Υ�team,Office,�ŪA�ժ�(postcd=192G)�i�ݡu�ӽг�d�ߡv

OV ��g�z,EF�����i�ϥΡu�s��̷s�����v

193G(�żг�-�_��)

*/

//if("ED".equals(occu)| "Y".equals((String)session.getAttribute("powerUser")) |  "O".equals(auth) | "192G".equals(hrObj.getPostcd()) | "193G".equals(hrObj.getPostcd()) | ifdispaly == true )

	
if("ED".equals(occu) | "Y".equals((String)session.getAttribute("powerUser")) |  ("O".equals(auth) && !"811".equals( hrObj.getUnitcd())) | "192G".equals(hrObj.getPostcd()) | "193G".equals(hrObj.getPostcd()) | ifdispaly == true | "180A".equals(occu))
{
%>

<span style="cursor:pointer" onclick='change("4","pic4")' >

	<img src="img2/close.gif" width="24" height="24" id="pic4">�i�޲z�\��j

</span>

<div id="txt4" style="display:none;background-color:#ECF2F6	;">

<table border="0" cellpadding="0" cellspacing="0">

    <td colspan="2">

		<img src="img2/notepad.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("confquery.jsp","blank.htm")'>�ӽг�d��</A><br>

		<img src="img2/p1.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","SMSAC/SMSQuery.jsp")'>²�T�q��<a/><br>

<%

	//if("192.168".equals(userip.substring(0,7)) | "10.18".equals(userip.substring(0,5)))  --cs40 modified 2010/3/14

	if("192.168".equals(userip.substring(0,7)) | "10.16".equals(userip.substring(0,5))) 

	{

		if(ga.isBelongThisGroup("EZEFOFFICE") | ga.isBelongThisGroup("EZEGBLINS") | ga.isBelongThisGroup("EZOFFAM") | "Y".equals((String)session.getAttribute("powerUser")) )

		{ 

%>

		<img src="img2/doc5.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("../off/Leave/offEmpno.jsp","blank.htm")'><div class="n"id="n27">�N�񰲳�</div></a><br> 

<%

		}

	}	

%>

<!--**************************************************************************-->



<%

if("ED".equals(occu) | "Y".equals((String)session.getAttribute("powerUser")) )

{

%>

	<img src="img2/cp.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("formquery.jsp","blank.htm")'>�ӽг�B�z</a><BR>

	<img src="img2/doc3.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","max.jsp")'>�]�w���z�ƶq</a><BR>

	<img src="img2/04.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("chgSwapFromQuery.jsp","chgSwapFromMenu.htm")'>��s�ӽг檬�A</a><br>

	<img src="img2/doc.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","comm.jsp")'>�]�w�f�ַN��</a><br>

	<img src="img2/rdoc.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("blank.htm","setdate.jsp")'>�]�w�����z��</a><br>
	
<%
	//������(632544), �իT��(641090), �}�Q�f(638716), 
	if("632544".equals(userid) | "641090".equals(userid) | "638716".equals(userid) | "Y".equals((String)session.getAttribute("powerUser")) )	
	{
%>	
	

	<img src="img2/cal.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("blank.htm","AC/pubSkj.jsp")'>�]�w�Z���������</a><br>
<%
	}	
%>	

	<img src="img2/sup.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("blank.htm","crewcomm.jsp")'>�]�w�խ��ӽЪ���</a><br>
	<!--<img src="img2/sup.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("blank.htm","alparaset.jsp")'>�]�wAL�����Ѽ�</a><br> WEBEG -->
	<img src="img2/sup.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("blank.htm","AC/resthrset.jsp")'>�]�w�S����Z���</a><br>
	

	<!--<img src="img2/Reply.gif" width="16" height="16">&nbsp;�H�e��Z��<br>

	<img src="img2/doc4.gif" width="16" height="16">&nbsp;�H�e��Z���T�{<br>

	<img src="img2/File.gif" width="16" height="16">&nbsp;�妸�H�e��Z���T�{<br>

	-->

	<img src="img2/c2.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("blank.htm","uploadfile.htm")'>�W���ɮ�</a><br>

	<img src="img2/download.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("uploadquery.jsp","blank.htm")'>�d�߿�Z��T</a><br>

	<img src="img2/d1.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","edHotNews.jsp")'>�s��̷s����</a><br>



	<img src="img2/user2.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("blank.htm","AC/retireEmp.jsp")'>���h�H���W����@<a/><br>

	<img src="img2/we.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("blank.htm","realSwap/realSwapAdm.jsp")'>���鴫�Z�O��</a><br>		

	<img src="img2/Fav.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","adm/ciiRptMenu.jsp")'>CII Report</a><BR>

	<img src="img2/we.gif"  width="16"height="16">&nbsp;<a href="#"  onClick='load("blank.htm","swapkhh/swapkhhMenu.jsp")'>KHH���Z�޲z</a><BR>		

		<%

		//SR6310 �ӽг�B�z�έp,���\��ȶ}��ED �g�z�B�Ʋz�B�U�z�ϥ�,�޲z�̽бq �u�޲z�Υ\����աv�ﶵ�i�J



		if("190A".equals( hrObj.getUnitcd()) )

		{	//ED

			if("547E".equals(hrObj.getPostcd()) //�g�z

			 | "401F".equals(hrObj.getPostcd()) //�Ʋz

			 | "491".equals(hrObj.getPostcd())  //�U�z

			 )

		     {

		%>

		<img src="img2/doc3.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("blank.htm","formRpt/formRptMenu.jsp")'>�ӽг�B�z�ƶq�έp</a>		

		<%

		     }

        }

}



if(ifdispaly == true)

{

%>

	<img src="img2/cp.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("formquery.jsp","blank.htm")'>�ӽг�B�z</a><BR>

	<img src="img2/doc3.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","max.jsp")'>�]�w���z�ƶq</a><BR>

	<img src="img2/04.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("chgSwapFromQuery.jsp","chgSwapFromMenu.htm")'>��s�ӽг檬�A</a><br>

	<img src="img2/c2.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("blank.htm","uploadfile.htm")'>�W���ɮ�</a><br>

	<img src="img2/download.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("uploadquery.jsp","blank.htm")'>�d�߿�Z��T</a><br>

	<img src="img2/d1.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","edHotNews.jsp")'>�s��̷s����</a><br>

	<img src="img2/we.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("blank.htm","realSwap/realSwapAdm.jsp")'>���鴫�Z�O��</a><br>		

	<img src="img2/Fav.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","adm/ciiRptMenu.jsp")'>CII Report</a><BR>

<%

}		



if("180A".equals(occu))
{
%>
	<img src="img2/Fav.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","adm/ciiRptMenu.jsp")'>CII Report</a><br>
<%
}	

//�\�� : CII Report - Daily Check, Standby Crew, Schedule Query, Crew List Query, ACM List

//�H�� : 628933-�f���  628930-�孧�[  625384 -�^�û�  628997-����z  625303-ù��  631210-�B�g��
/*
���R�_  634341
�d��P  631711
������  625554
���y�s  630162
���ŭ�  632970
�Q�f��  635810
��A��  631255
�G�ڦp  636149
*/
if("628933".equals(userid) | "628930".equals(userid) | "628997".equals(userid) | 

   "625303".equals(userid) | "625384".equals(userid) | "634341".equals(userid) | "631711".equals(userid) | "625554".equals(userid) | "630162".equals(userid) | "632970".equals(userid) | "635810".equals(userid) | "631255".equals(userid) | "636149".equals(userid) | "631210".equals(userid) | 

   "Y".equals((String)session.getAttribute("powerUser")))

{

  %>

  <img src="img2/doc3.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","adm/ciiRptMenu_ef.jsp")'>EF-CII Report</a><br>

  <%

}//if



//OV ��g�z,EF�����i�ϥΡu�s��̷s�����v

if("629678".equals(userid) ||  "626914".equals(userid))

{

%>		

        <img src="img2/d1.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","edHotNews.jsp")'>�s��̷s����</a><br>

<%

}



//�Ť@�եi�� OD Import �\��

if("Y".equals((String)session.getAttribute("powerUser")) || "196".equals(hrObj.getUnitcd()))

{

%>

<img src="images/database_save.gif" width="16" height="16">&nbsp;<a href="#" onClick="load('PRAC/ODDuty/odImportQuery.jsp','PRAC/ODDuty/ODImportMenu.htm')">OD Import</a><br>

<img src="images/database_save.gif" width="16" height="16">&nbsp;<a href="#" onClick="load('PRAC/ODDuty/acmImportQuery.jsp','PRAC/ODDuty/ACMImportMenu.htm')">ACM Import</a><br>

<%

}





//�ŰV.�ŪA��F�i�ζפJ�s�i�խ��b���\�� SR7242

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

if( "PR".equals(occu) | "Y".equals((String)session.getAttribute("powerUser"))

	| ga.isBelongThisGroup("FZPUR") )
{	
%>

		<img src="img2/doc5.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","PRAC/PRSel.jsp")'>Purser Report</a><br><br>

		<img src="img2/doc5.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","PRAC_new/PRSel.jsp")'>Purser Report new</a><br><br>


		<!-- CS40 2008/12/05 --><!--<img src="img2/doc5.gif" width="16" height="16">&nbsp;<a href="http://tsaweb02.china-airlines.com/outstn/GBCabinCrewList.aspx" target="mainFrame"><div class="n"id="n93">²�骩crew list</div></a><br><br>-->
<%
}


//ZC �U�z�y����

//out.print("if ZC "+session.getAttribute("ZC"));

if( "Y".equals((String)session.getAttribute("ZC")) )

{	

%>

		<img src="img2/doc5.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","PRAC/ZC/zcMenu.jsp")'>Zone Chief Report</a><br><br>



<%

}





if("Y".equals((String)session.getAttribute("powerUser"))) 

{

%>

<img src="img2/user2.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","adm/admMenu.jsp")'>�޲z�Υ\�����</a>

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
{//�e��

%>

<img src="img2/doc.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("pr_interface/simchk_querycond.jsp","blank.htm")'>SIM Check </a><br>

<%

}



if("C".equals((String)session.getAttribute("auth")) | "Y".equals((String)session.getAttribute("powerUser")))

{	//�խ�

	

	

	%>

<!--<hr><img src="img2/doc.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","ngbForm/editNGB.jsp")'><div class="n"id="n91">�x�M�Ҹ�ƿ�J</div></a><br> 

	<hr>-->

	<img src="img2/doc.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","tsaForm/editTSA.jsp")'><div class="n"id="n91">�s��MCL</div></a><br>
	<img src="img2/Go.gif" width="16" height="16">&nbsp;<a href="http://ch.e-go.com.tw/" target="mainFrame"><div class="n"id="n93">���챵���d��</div></a><br>

	<%

}
		

 if("ED".equals(occu) | ("TPE".equals( (String)session.getAttribute("base")) && ("FA".equals(occu) | "FS".equals(occu) | "ZC".equals(occu) | "PR".equals(occu) )))

{

%>		

		<!--<img src="img2/doc3.gif" width="16" height="16">&nbsp;<div class="n"id="n92">���Ȳ��ʳq��</div><br> -->

		<img src="img2/Go.gif" width="16" height="16">&nbsp;<a href="crewshuttle/pickup.jsp" target="mainFrame"><div class="n">�������ʥӽ�</div></a><br>

<%

}

%>		

		<!-- <img src="img2/Send.gif" width="16" height="16">&nbsp;<a href="#" onClick="load('blank.htm','msgAC.jsp')" ><div class="n"id="n94">CIA ���զ^��</div></a> <br>-->

		<img src="img2/p2.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","AC/UserList.jsp")'><div class="n"id="n95">�u�W�ϥΪ�</div></a><br>

		<!--<img src="img2/doc2.gif" width="16" height="16">&nbsp;<div class="n"id="n96">�ϥλ���</div><br>

		<img src="img2/pen.gif" width="16" height="16">&nbsp;<div class="n"id="n97">�ӽг��g����</div><br> -->

		<img src="img2/Security.gif" width="16" height="16">&nbsp;<a href="#"  onClick="logout()"><div class="n" id="n0">�n�X</div></a><br>
	</td>

  </tr>

</table>

<br>

<hr width="100%">

&nbsp;&nbsp;&nbsp;<input type="button"  class="e4" onClick="javascript:window.open('http://cia.china-airlines.com');" value=" CIA �Z���d��"  >

<!-- <input type="button" id="oldversion" name="oldversion" class="e4" onClick="javascript:self.location='fscreen.jsp';top.topFrame.location='blank.htm';top.mainFrame.location='blank.htm';" value="�ϥ��ª��\��"  > -->

<br>







</body>



</html>

<%

}

%>
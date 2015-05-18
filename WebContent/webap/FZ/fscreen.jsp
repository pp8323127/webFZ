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
String locked = (String) session.getAttribute("locked");//N : ����w/�}��, Y : ��w/���}��

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

function getdate(){	//�]�w���w�]��
	nowdate = new Date();	//�{�b�ɶ�
	var y,m,d
	y = nowdate.getYear();
	m = nowdate.getMonth()+1;
	d = nowdate.getDate();

	
	if ( d >= 25 ) {			//�Y�W�L25���A�w�]���U�Ӥ몺�Z��
		if ( m == 12){
			y = y + 1;
			m = 0;		//�Y��12/25�A�h�~���[1
		}
		m = m + 1;
	}
	
	if (m < 10)	{		//�Y���<10�A�h�e���[�@��0
		m= "0"+ m;
	}
	parent.topFrame.location.href="schquery.jsp";
	parent.mainFrame.location.href="showsche2.jsp?syear="+y+"&smonth="+m+"&empno=";
}

function logout(){	//�n�X

	//top.location.href="sendredirect.jsp";
	self.location="sendredirect.jsp";	
}

    function change(id,pi){  //���h���[�c
		 if (document.getElementById(id).style.display=="none") { //�Y������	  
			document.getElementById(id).style.display=""  //�h�N�����
			document.getElementById(pi).src="images/open.gif"    //�X�{open�Ϯ�
			//�}�Ҥ@item�h�N��Litem����
			if (id != "txt1" && document.getElementById("txt1") != null){
				document.getElementById("txt1").style.display="none"  //����
				document.getElementById("pic1").src="images/close.gif"		//�X�{close�Ϯ�
			}
			if (id != "txt2" && document.getElementById("txt2") != null){
				document.getElementById("txt2").style.display="none"  //����
				document.getElementById("pic2").src="images/close.gif"		//�X�{close�Ϯ�
			}
			if (id != "txt3" && document.getElementById("txt3") != null){
				document.getElementById("txt3").style.display="none"  //����
				document.getElementById("pic3").src="images/close.gif"		//�X�{close�Ϯ�
			}
			if (id != "txt4" && document.getElementById("txt4") != null){
				document.getElementById("txt4").style.display="none"  //����
				document.getElementById("pic4").src="images/close.gif"		//�X�{close�Ϯ�
			}
			if (id != "txt5" && document.getElementById("txt5") != null){
				document.getElementById("txt5").style.display="none"  //����
				document.getElementById("pic5").src="images/close.gif"		//�X�{close�Ϯ�
			}
		  }
		 else	  {
			document.getElementById(id).style.display="none"  //����
			document.getElementById(pi).src="images/close.gif"		//�X�{close�Ϯ�
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
/*���e�K��������*/
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
     <input type="button"  onClick="javascript:self.location='fscreenAC.jsp';top.topFrame.location='blank.htm';top.mainFrame.location='blank.htm';" value="�ϥηs���\��"  style="background-color:#FFFFFF;color:#000000 " >
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
          <td width="95%"><a href="#"  onClick="javascript:getdate()">�Z��d��<br>Schedule Query</a></td>
        </tr>
</table>
<%
}
else{

%>
<span style=cursor:hand onclick=change("txt1","pic1") >
 <img src="images/close.gif" width="16" height="16" id="pic1">&nbsp;<span class="txtblue">�d�߯Z��(Query) </span>

<p> 
</span> 
<div style=background-color:#BBEBF0;display:none id="txt1"> 


<table width="100%"  border="0">
  <tr>
  <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
    <td width="5%" height="46" align="right" valign="middle"><img src="images/p3.gif" width="21" height="21"></td>
    <td width="95%"><a href="#"  onClick="javascript:getdate()">�Z��d��<br>Schedule Query</a></td>
  </tr>
  <tr>
  <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
    <td height="49" align="right" valign="middle"><img src="images/cr.gif" width="22" height="22"></td>
    <td>      <a href="#" onClick='javascript:load("crquery.htm","blank.htm")'>���ɬd��<br>Flying Time Query</a></td>
  </tr>
  <tr>
  <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
    <td height="49" align="right" valign="middle"><img src="images/da.gif" width="22" height="22"></td>
    <td>      <a href="#" onClick='javascript:load("fltquery.htm","blank.htm")'>��Z�d��<br>Flight Query</a></td>
  </tr>
  <tr>
  <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
    <td height="45" align="right" valign="middle"><img src="images/compare.gif" width="22" height="22"></td>
    <td><a href="#"  onClick='javascript:load("compquery.htm","blank.htm")'>���Z��<br>Schedule Compare</a></td>
  </tr>
  <tr>
  <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
    <td height="49" align="right" valign="middle"><img src="images/offcrew.gif" width="22" height="22"></td>
    <td>      <a href="#" onClick='javascript:load("offquery.jsp","blank.htm")'>Off �խ��d��<br>Off Crew Query</a></td>
  </tr>
   <!-- <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
    <td height="49" align="right" valign="middle"><img src="images/loglist.gif" width="22" height="22"></td>
    <td> <a href="#" onClick="load('blank.htm','http://tpeweb02.china-airlines.com/webfz/FZ/tsa/cicoweb/cico_query_socketclient.jsp')">�����ܧ� <br>Duty Change</a></td>  -->
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
<img src="images/close.gif" width="16" height="16" id="pic2">&nbsp;<span class="txtblue">���Z�M��(Transfer)</span> 
<p>
</span>
	<div style=background-color:#BBEBF0;display:none id="txt2"> 
<table width="100%" height="244"  border="0">
  <tr>
  <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
    <td width="3%" align="right" valign="middle"><img src="images/p2.gif" width="21" height="21" border="0"></td>
    <td width="97%"><a href="#"  onClick='javascript:load("putquery.jsp","blank.htm")'>�����Z��<br>Put Schedule</a></td>
  </tr>
  <tr>
  <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
    <td align="right" valign="middle"="2"><img src="images/search3.gif" width="22" height="22" border="0"></td>
    <td><a href="#" onClick='javascript:load("psquery.jsp","blank.htm")'>�d�ߥi���Z��<br>Put Schedule Query</a></td>
  </tr>
  <tr>
  <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
    <td align="right" valign="middle"><img src="images/i.gif" width="21" height="21" border="0"></td>
    <td><a href="#"  onClick='javascript:load("blank.htm","showbook.jsp")'>�ڪ���Z��T<br>Put Schedule Record</a></td>
  </tr>
  <tr>
    <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
    <td height="39" align="right" valign="middle"><img src="images/list.gif" width="22" height="22"></td>
<!--     <td><a href="#"  onClick='javascript:load("appquery.htm","blank.htm")'>��ӽг�<br>Make Application</a></td>
 -->
  <td><a href="#"  onClick='load("blank.htm","swap3/step0.jsp")'>��ӽг�<br>Make Application</a></td>
   </tr>
  <tr>
	<td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
    <td align="right" valign="middle"><img src="images/p.gif" width="22" height="22"></td>
    <td><a href="#"  onClick='javascript:load("apply_query.htm","applyquery.jsp")'>�ӽг�O��<br>Check Application</a></td>
  </tr>
  <tr>
	<td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
    <td align="right" valign="middle"><img src="images/d2.gif" width="22" height="22"></td>
    <td><a href="#"  onClick='javascript:load("uploadquery.jsp","blank.htm")'>�U����Z��T<br>Download File</a></td>
  </tr>
</table>


	</div>

	<%
		}	//���῵�ζ}��Z��̥i��
	}	//���῵�i��
	


	%>
	

<br>
<%
if(!occu.equals("ED")){
%>
<span style=cursor:hand onclick=change("txt3","pic3") >
<img src="images/close.gif" width="16" height="16" id="pic3">&nbsp;<span class="txtblue">�ӤH���(Personal)</span>
<p>
</span>
	<div style=background-color:#BBEBF0;display:none id="txt3"> 
<table width="100%" height="196"  border="0">
        <tr>
			  <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
			  <td width="3%" align="right" valign="middle"><img src="images/edit.gif" border="0" width="20" height="20"></td>
			  <td width="97%"><a href="#"  onClick='load("blank.htm","editcrewinfo.jsp")'>�խ��ӤH���<br>Crew Information</a></td>
        </tr>
        <tr>
			  <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
			  <td width="3%" align="right" valign="middle"><img src="images/ed3.gif" width="22" height="22"></td>
			  <td width="97%"><a href="#"  onClick='load("blank.htm","chgPw.jsp")'><font color="red">�ܧ󥻨t�αK�X<br>Change Password</font></a></td>
        </tr>		


		
		<%
			if( occu.equals("FA") || occu.equals("FS") || occu.equals("PR")|| occu.equals("CM") ) {
		
		%>
        <tr>
			<td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
	        <td align="right" valign="middle"="2"><img src="images/fa.gif" width="22" height="22"></td>
            <td><a href="#"  onClick='load("blank.htm","favorflt.jsp")'>�ۭq�̷R��Z<br> Favorite  Flight</a>&nbsp;</td>
        </tr>
		<tr>
		  <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
			<td align="right" valign="middle"><img src="images/favrquery.gif" width="21" height="21" border="0"></td>
			<td><a href="#"  onClick='javascript:load("blank.htm","favrquery.jsp")'>�ߦn��Z�d��<br>Favorite  Flight Query</a></td>
		</tr>
		<tr>
			<td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
	        <td align="right" valign="middle"="2"><img src="images/friend.gif" width="22" height="22"></td>
            <td><a href="#"  onClick='javascript:load("blank.htm","goodfriend.jsp")'>�ۭq�n�ͦW��<br> Friend List</a>&nbsp;</td>
        </tr>
		<tr>
			  <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
			  <td align="right" valign="middle"><img src="images/h1.gif" width="22" height="22"></td>
			  <td><a href="#"  onClick='javascript:load("blank.htm","<%=aladdress%>")'>�~����J/�d��<br> AL Offsheet</a></td>

        </tr>
		<tr>
			  <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
			  <td align="right" valign="middle"><img src="images/fixpay.gif" width="22" height="22"></td>
			  <td><a href="#"  onClick='javascript:load("reqFixpayQuery.htm","blank.htm")'>�w�B���[<br> Fixed FlyPay</a></td>

        </tr>
		
 		<tr>
			<td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
			<td align="right" valign="middle"="2"><img src="images/award.gif" width="22" height="22"></td>
			<td><a href="#" onClick='javascript:load("reqAwdListQuery.jsp","blank.htm")'><span class="txtxred">���g�q��<br> Award List</span> </a>&nbsp;</td>
		</tr>		
		<%
			}	//���῵�i��
		%>
		<tr>
			<td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
			<td align="right" valign="middle"="2"><img src="images/flypay.gif" width="22" height="22"></td>
			<!-- <td><a href="#"  onClick='javascript:load("ccflypayquery.htm","blank.htm")'>���[�M��<br> Flypay List</a>&nbsp;</td> -->
			<td><a href="#"  onClick='javascript:load("flyPayQuery.htm","blank.htm")'>���[�M��<br> Flypay List</a>&nbsp;</td>
		</tr>
		<tr>
			<td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
			<td align="right" valign="middle"="2"><img src="images/loglist.gif" width="22" height="22"></td>
			<td><a href="#" onClick='javascript:load("loglistquery.htm","blank.htm")'>����O��<br> Crew Log List</a>&nbsp;</td>
		</tr>
        <tr>
			  <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
			  <td height="39" align="right" valign="middle"><img src="images/lock.gif" width="22" height="22"></td>
			  <td><a href="#"  onClick='javascript:load("blank.htm","lock.jsp")'>��w/�}��Z��<br>Set Schedule Status</a></td>
        </tr>
		<tr>
			  <td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
			  <td height="39" align="right" valign="middle"><img src="images/ed3.gif" width="22" height="22"></td>
			  <td><a href="#"  onClick='javascript:load("blank.htm","resetCIAPW.jsp")'><font color="red">���]CIA�K�X<br>Reset CIA Password</font></a></td>
        </tr>
      </table>
</div>
	<%
}	//���DED���~�i��~(ED���i��)
if(locked.equals("N") || occu.equals("ED")){

%>
<br>
<span style=cursor:hand onclick=change("txt4","pic4") >
<img src="images/close.gif" width="16" height="16" id="pic4">&nbsp;<span class="txtblue">��L�\��(Others)</span> 
<p>
</span>
	<div style=background-color:#BBEBF0;display:none id="txt4"> 	
<table width="100%" height="141"  border="0">
  <tr>
  <td width="2%" height="48" align="right" valign="middle">&nbsp;</td>
    <td width="3%" align="right" valign="middle"><img src="images/search2.gif" width="21" height="21" border="0"></td>
    <td width="97%"><a href="#"  onClick='load("cwquery.htm","blank.htm")'>�d�߲խ��q��<br>�H�e�Z��</a></td>
  </tr>
  <tr>
  <td width="2%" height="42" align="right" valign="middle">&nbsp;</td>
    <td align="right" valign="middle"><img src="images/efmail.gif" width="22" height="22"></td>
    <td><a href="#" onClick='load("efmail.htm","blank.htm")'>�N���H�c<br>Contact EF</a></td>
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
<img src="images/close.gif" width="16" height="16" id="pic5">&nbsp;<span class="txtblue">�޲z�\��(Admin)</span>
<p>
</span>
	<div style=background-color:#BBEBF0;display:none id="txt5"> 

		<img src="images/list.gif" width="22" height="22"><a href="#"  onClick='javascript:load("confquery.jsp","blank.htm")'>�ӽг�d��</a><br><br>
	<%
	}
	//��sir, �����
	// ���a�@ "633988".equals(sGetUsr) mark by cs66 2005/10/19
	if("629678".equals(sGetUsr) ||  "626914".equals(sGetUsr)){
	%>
		<img src="images/search2.gif" width="22" height="22" align="absmiddle"><a href="#"  onClick='javascript:load("blank.htm","edHotNews.jsp")'>�s��̷s����</a><br><br>
	<%
	}
	if (occu.equals("ED")){
	%>
		<img src="images/ed2.gif" width="22" height="22" align="absmiddle"><a href="#"  onClick='javascript:load("formquery.htm","blank.htm")'>�ӽг�B�z</a><br><br>
		<img src="images/ed1.gif" width="21" height="21" align="absmiddle"><a href="#"  onClick='javascript:load("blank.htm","max.jsp")'>��ʨ��z�ƶq</a><br><br>
	 	<img src="images/ed1.gif" width="21" height="21" align="absmiddle"><a href="#"  onClick='javascript:load("chgSwapFromQuery.jsp","chgSwapFromMenu.htm")'><span class="txtxred">��s�ӽг檬�A</span></a><br><br>		
	 	
	  <img src="images/ed4.gif" width="21" height="21" align="absmiddle"><a href="#"  onClick='javascript:load("blank.htm","comm.jsp")'>��ʼf�ַN��</a><br>
		<br>
		<img src="images/ed3.gif" width="21" height="21" align="absmiddle"><a href="#" onClick='javascript:load("blank.htm","setdate.jsp")'>�ۭq�����z��</a><br><br>
		<img src="images/crewcomm.gif" width="22" height="22" align="absmiddle"><a href="#" onClick='javascript:load("blank.htm","crewcomm.jsp")'>�ۭq�խ��ӽЪ���</a><br><br>
		<img src="images/mail2.gif" width="20" height="20" align="absmiddle"><a href="#" onClick='javascript:load("mailsche.jsp","blank.htm")'>�H�e��Z��</a><br><br>
		<img src="images/cmailsche.gif" width="22" height="22" align="absmiddle"><a href="#" onClick='javascript:load("blank.htm","/webfz/sendlog.txt")'>�H�e��Z��T�{</a><br><br>
		<img src="images/cmailsche.gif" width="22" height="22" align="absmiddle">
<a href="#" onClick='javascript:load("log/batchMailScheLogQuery.jsp","blank.htm")'>Batch�H�e��Z��T�{</a><br><br>
		<img src="images/uploadWord.gif" width="16" height="16" align="absmiddle"><a href="#" onClick='javascript:load("blank.htm","uploadfile.htm")'>�W���ɮ�</a><br><br>
		<img src="images/d2.gif" width="22" height="22" align="absmiddle"><a href="#"  onClick='javascript:load("uploadquery.jsp","blank.htm")'>�d�߿�Z��T</a><br><br>
		<img src="images/search2.gif" width="22" height="22" align="absmiddle"><a href="#"  onClick='javascript:load("blank.htm","edHotNews.jsp")'>�s��̷s����</a><br><br>
		<img src="images/userlist.gif" width="22" height="22" align="absmiddle"><a href="#"  onClick='javascript:load("blank.htm","SMS/SMSQuery.jsp")'>Cabin eSMS<br>&nbsp;&nbsp;&nbsp;&nbsp;���²�T�q��</a><br><br>

  </tr>
	<%
	}
	%>
	</div>
<%
//**********************************************************
//test ²�T,�y�������i,Hotnews!!
//�i�ϥΪ�:cs55,cs66,cs27,cs40,cs71,cs73
//occu.equals("PR") ||
if( occu.equals("PR") || occu.equals("CM")||sGetUsr.equals("638716") ||sGetUsr.equals("640073") ||sGetUsr.equals("633007") ||sGetUsr.equals("634319") ||sGetUsr.equals("640790")||sGetUsr.equals("640792") ||sGetUsr.equals("627018") ||sGetUsr.equals("630208")||sGetUsr.equals("629019")||sGetUsr.equals("625384")||sGetUsr.equals("627536")
    || sGetUsr.equals("811006") ||  sGetUsr.equals("837165") || sGetUsr.equals("850045")  || sGetUsr.equals("827061")  || sGetUsr.equals("628363") 
	|| sGetUsr.equals("626914") ||  sGetUsr.equals("850368")
	//add by cs66 trainning �y�����ݥ楿�����i 2005/9/6
//	|| sGetUsr.equals("631201") ||  sGetUsr.equals("631611") |  sGetUsr.equals("630230") ){
|| sGetUsr.equals("629562")	/* || sGetUsr.equals("980274")	*/
||sGetUsr.equals("827069")	//SGNEM 2006/02/15

){
%>

	
	<img src="images/crewcomm.gif" width="22" height="22" border="0" align="absmiddle"><a href="#"  onClick='load("blank.htm","PRORP3/PRSel.jsp")'>Purser Report</a><br><br>
<!-- 	<img src="images/crewcomm.gif" width="22" height="22" border="0" align="absmiddle"><a href="#"  onClick='load("blank.htm","Stop.htm")'>Purser Report</a> -->
<%
}

//�y�������i���V�W��,
//�[�W 628946 ���P�g,630166 �N���R,631255 ��A��,631578 ���R��,625296 �L�@�n,
//640073,638716
/*
 {"630153","630230","630326","630328","630341","630342","630536","630614","630723","630732","630849","630933","630937","631201","631212","626394","626387","627293","628588","631611","629562","630393","632309",
 
String[] prTrn ={"628946","630166","631578","631255","625296","640073","638716","630153","630230","630326","630328","630341","630342","630536","630614","630723","630732","630849","630933","630937","631201","631212","626394","626387","627293","628588","631611","629562","630393","632309"};
*/

//�s�W�b��
if(sGetUsr.equals("638716") ||sGetUsr.equals("640073") ||sGetUsr.equals("633007") ||sGetUsr.equals("634319") ||sGetUsr.equals("640790")){

%>
<HR>
<img src="images/friend.gif" width="22" height="22" border="0" align="absmiddle">
<a href="#"  onClick='load("blank.htm","adminAccount.jsp")'>�b���޲z</a>  <br>
<img src="images/crewcomm.gif" width="22" height="22" border="0" align="absmiddle"><a href="#"  onClick='load("blank.htm","PRORP3/PRSel.jsp")'>Purser Report</a><br>

<img src="images/userlist.gif" width="22" height="22" align="absmiddle"><a href="#"  onClick='javascript:load("blank.htm","SMS/SMSQuery.jsp")'>Cabin eSMS<br>&nbsp;&nbsp;&nbsp;&nbsp;���²�T�q��</a><br><br>
<a href="#"  onClick='javascript:load("blank.htm","SMSAC/SMSQuery.jsp")'>eSMS AirCrews Edition</a>

<!--
<img src="images/crewcomm.gif" width="22" height="22" border="0" align="absmiddle">
  <a href="#"  onClick='load("blank.htm","PR/PRSel.jsp")'>�y�������iTest����</a>
 
<a href="#"  onClick='load("blank.htm","http://tpesunap01:5001/webfz/FZ/PR/PRSel.jsp")'>cs71 test<br></a><br><br>
<br> 
 <img src="images/userlist.gif" width="22" height="22" align="absmiddle"><a href="#"  onClick='javascript:load("blank.htm","SMS/SMSQuery.jsp")'>Cabin eSMS</a><br> 
&nbsp;&nbsp;&nbsp;&nbsp;-->
<!-- 
<a href="PRTrn/prframe.jsp" target="_top" ><img src="images/crewcomm.gif" width="22" height="22" border="0" align="absmiddle">�y�������iTraining</a> -->
<HR>
<%
}

%>

	<table width="100%"  border="0">
	<tr>
		<td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
          <td height="46" align="right" valign="middle"><img src="images/userlist.gif" width="21" height="21" border="0"></td>
          <td><a href="#"  onClick='javascript:load("blank.htm","UserList.jsp")'>�u�W�ϥΪ�<br>
          Online User List</a></td>
      </tr>
    <tr>
		<td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
          <td width="5%" height="46" align="right" valign="middle"><img src="images/qa.gif" width="20" height="20" border="0" align="middle"></td>
          <td width="95%"><a href="#"  onClick='javascript:load("blank.htm","qa.htm")'>�ϥλ���&nbsp;  <br>
User's Guide</a></td>
      </tr>
     <tr>
		<td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
          <td width="5%" height="46" align="right" valign="middle"><img src="images/qa2.gif" width="22" height="22" border="0" align="middle"></td>
          <td width="95%"><a href="#" onClick='javascript:load("blank.htm","apply_readme.htm")' class="bu" >�p���ӽг�</a></td>
      </tr>
	  <%
	  if("C".equals((String)session.getAttribute("auth"))){	//�խ�
	  %>
       <tr>
		<td width="2%" height="46" align="right" valign="middle">&nbsp;</td>
          <td height="46" align="right" valign="middle"><a href="#"  onClick='javascript:load("blank.htm","tsaForm/editTSA.jsp")'><span style="color:#9900CC;font-size:12px "><strong>��</strong></span></a></td>
          <td><a href="#"  onClick='javascript:load("blank.htm","tsaForm/editTSA.jsp")'><span style="color:#9900CC;font-size:12px "><strong>�s�� MCL &nbsp;<br>
Edit MCL</strong></span></a></td>
      </tr>		  
	  <%
	  }
	  %>
         <tr>
         <td height="46" align="right" valign="middle">&nbsp;</td>
         <td height="46" align="right" valign="middle">&nbsp;</td>
         <td><a href="#" onClick="load('blank.htm','http://tpesunap01:5001/webfz/FZ/tsa/cicoweb/cico_query_socketclient.jsp?userid=<%=sGetUsr%>')">���Ȳ��ʳq��<br>
(Duty Change)</a></td>
       </tr> 
       <tr>
         <td height="46" align="right" valign="middle">&nbsp;</td>
         <td height="46" align="right" valign="middle">&nbsp;</td>
         <td><a href="http://ch.e-go.com.tw/" target="mainFrame"><span class="txtxred">���챵���d��</span></a><br>
          <span class="txtxred"> (Internet Only)</span> </td>
       </tr>
       <tr>
         <td height="46" align="right" valign="middle">&nbsp;</td>
         <td height="46" align="right" valign="middle">&nbsp;</td>
         <td><a href="#" onClick="load('blank.htm','msgAC.jsp')" ><span class="txtxred">AirCrews CIA<br>
           ���զ^��</span></a><br>
          <span class="txtxred"> CIA Report Back</span>
         </td>
       </tr>

       <tr>
         <td height="46" align="right" valign="middle">&nbsp;</td>
         <td height="46" align="right" valign="middle"><img src="images/logout.gif" width="21" height="21" border="0"></td>
         <td><a href="#"  onClick="logout()">�n�X�t��&nbsp;Logout</a></td>
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
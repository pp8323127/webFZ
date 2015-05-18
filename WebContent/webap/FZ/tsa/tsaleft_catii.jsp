<%
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
   
  mm_menu_0507105401_0.writeMenus();
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

function opWinJZ() { window.open("http://tpeweb03:5401/webjc/SR6041.jsp"); }
</script>

<body bgcolor="#99ccff" onload="fnOnLoad()">
<div id="leftPane"> 
  <p><a href="#" onClick='load("http://tpeweb03:9901/webdz/catiii/topframe.jsp","../blank.htm")'>CATII/III</a></p>
  <p> <a href="#" onClick='load("http://tpeweb03:9901/webdz/catiii/catiiQ_new.htm","../blank.htm")'>CATII/III 
    report</a> </p>
</div>
<a href="#" class="txtblue" onClick='load("../blank.htm","sendredirect.jsp")'>Logout</a><br>

</body>

<script type="text/javascript" src="/webdz/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="/webdz/js/jquery-ui-1.8.2.custom.min.js"></script>

</html>

<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*,java.sql.Date,fz.*"%>
<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
//Betty add
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

if (session.isNew() || sGetUsr == null) 
{		//check user session start first
	response.sendRedirect("sendredirect.jsp");
} 
%>
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
  mm_menu_0507105618_0.addMenuItem("Crew&nbsp;Record","window.open('queryrecord.jsp', 'topFrame');");
  mm_menu_0507105618_0.addMenuItem("Crew&nbsp;insert","window.open('adddfcrew.jsp', 'mainFrame');");
  mm_menu_0507105618_0.addMenuItem("Crew&nbsp;Modify","window.open('dfcrewmod.htm', 'topFrame');");
  mm_menu_0507105618_0.addMenuItem("Crew&nbsp;BLKhr(OPS)","window.open('topframe2.jsp', 'topFrame');");
  mm_menu_0507105618_0.addMenuItem("Crew&nbsp;BLKhr(Log)","window.open('topframe3.jsp', 'topFrame');");
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
<p><a href="#" class="txtblue" onClick='load("../blank.htm", "http://eip63.china-airlines.com/DIP/DIP_OZ/OZ31/SelectData.aspx?SysId=CII")'>航務手冊</a></p> 
<p><a href="#" class="txtblue" onClick='load("http://tpeweb03:9901/webdz/catiii/topframe.jsp","../blank.htm")'>CATII/IIIa</a></p>
<!--<p class="txtblue"><a href="#" onClick='load("../crewhr/crewhrqry_tpe.htm","../blank.htm")'>100Hrs Check TPE</a> </p>-->
<!--<p class="txtblue"><a href="#" onClick='load("../crewhr_aircrews/crewhrqry.htm","../blank.htm")'>100Hrs AirCrews</a> </p>-->
<p><a href="#" class="txtblue" onClick='load("dailycrew/schQuery.jsp","../blank.htm")'>Schedule Query</a></p>
<p><a href="#" class="txtblue" onClick='load("../blank.htm","dailycrew/crewListMenu2.jsp")'>Crew List Query</a></p>
<p class="txtblue"><a href="#" onClick='load("../../FZ/pr_interface/simchk_querycond.jsp","../../FZ/blank.htm")'>SIM Check</a> </p>
<p><a href="#" class="txtblue" onClick='load("http://tpeweb03:9901/webdz/TrainCheck/simViewQuery.jsp?flag=<%=sGetUsr%>","../blank.htm")'>SIM/LINE-check view</a></p>
<!--<p><a href="#" class="txtblue" onClick='load("crProfileQuery.jsp","../blank.htm")'>Crew Profile</a></p>
<p><a href="#" class="txtblue" onClick='load("crewrecquery.htm","../blank.htm")'>CrewRec</a></p>-->
<p><a href="#" class="txtblue" onClick='load("LIC/querycrew.htm","../blank.htm")'>License</a></p>
<p class="txtblue"><a href="#" onClick='load("../GD/gdQuery.jsp","../blank.htm")'>Web GD</a> </p>

<p><a href="#" class="txtblue" onClick='load("../blank.htm","sendredirect.jsp")'>Logout</a></p>
</body>
</html>
<div align="left">‧<a href="#" onClick="load('simViewQuery.jsp','../blank.html')">View (檢視)</a></div>
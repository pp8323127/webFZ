<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*,java.sql.Date,fz.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
if( session.getAttribute("cabin") == null){
	session.setAttribute("cabin","N");
}

if (session.isNew() || sGetUsr == null) 
{		//check user session start first
	response.sendRedirect("sendredirect.jsp");
}else{ 
//取得是否為PowerUser
String  unidCD=  (String) session.getAttribute("fullUCD");	//get unit cd
fzAuth.UserID userID = new fzAuth.UserID(sGetUsr,null);
fzAuth.CheckPowerUser ck = new fzAuth.CheckPowerUser();



%>
<html>
<head>
<title>Tsa Left Frame</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../menu.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
function load(w1,w2){
		parent.topFrame.location.href=w1;
		parent.mainFrame.location.href=w2;
}
</script>

<body bgcolor="#CCFFFF" >
<%

if(!ck.isHasPowerUserAccount()){
out.print("您無權使用此功能!!");

}else{
%>

<p class="txtxred">**功能測試區**
</p>
<!-- <a href="#" name="link2" id="link1" onMouseOver="MM_showMenu(window.mm_menu_0507105401_0,29,10,null,'image2')" onMouseOut="MM_startTimeout();" ><img src="../images/close.gif" name="image2" width="15" height="15" border="0" align="baseline" id="image2" > <span class="txtblue">FLOG</span></a><br> -->
<!--  cs55  2005/11/03<p class="txtblue"><a href="#" onClick='load("http://tpesunap01:5001/webfz/FZ/tsa/SCH/schequery.htm","../../FZ/blank.htm")'>機隊月班表</a></p>-->
<!--  cs55  2005/11/03--><p class="txtblue"><a href="#" onClick='load("7days_over32hrsquery.htm","../../FZ/blank.htm")'>7天32小時限制</a></p>
<!--  cs47  2006/07/05--><p class="txtblue"><a href="#" onClick='load("http://tpeweb03:7001/webdk/dk_top.html","http://tpeweb03:7001/webdk/dk_menu.jsp")'>DK System (Post Flight Analysis)</a></p>
<!--  cs47  2005/12/30--><p class="txtblue"><a href="#" onClick='load("../blank.htm","http://tpeweb03:7001/webdz/SIM/dzsimck010_check_in_out.jsp")'>OV Maintain Function</a></p>
<!--  cs47  2005/12/21--><p class="txtblue"><a href="#" onClick='load("../blank.htm","http://tpeweb03:7001/webdz/SIM/dzsimck008_maint_log.jsp")'>OQ Maint Log</a></p>
<!--  cs47  2005/12/21--><p class="txtblue"><a href="#" onClick='load("../blank.htm","http://tpeweb03:7001/webdz/SIM/dzsimck009_dd_item.jsp")'>OQ DD Item</a></p>
<!--  cs47  2006/04/18--><p class="txtblue"><a href="#" onClick='load("../blank.htm","http://tpeweb03:7001/webdz/SIM/dzsimck014_part.jsp")'>OQ Part</a></p>
<!--  cs47  2006/02/15--><p class="txtblue"><a href="#" onClick='load("../blank.htm","http://tpeweb03:7001/webdz/SIM/dzsimck013_bulletin.jsp")'>OQ Bulletin</a></p>
<!--  cs47  2006/09/26--><p class="txtblue"><a href="#" onClick='load("../blank.htm","http://tpeweb03:7001/webdz/SIM/dzsimck017_check_list.jsp")'>OQ Check List</a></p>
<!--  cs47  2006/05/11--><p class="txtblue"><a href="#" onClick='load("../blank.htm","http://tpeweb03:7001/webdz/SIM/dzsimck015_total_using_time_list.jsp")'>OQ SIM Total Using Time</a></p>
<!--  cs47  2006/10/11--><p class="txtblue"><a href="#" onClick='load("../blank.htm","http://tpeweb03:7001/webdz/SIM/dzsimck019_instructor_hour.jsp")'>Instructor Hour</a></p>
<!--  cs55  2006/05/08--><p class="txtblue"><a href="#" onClick='load("LIC/licquery.htm","../blank.htm")'>Licence Check</a></p>
<!--  cs55  2006/06/19--><p class="txtblue"><a href="#" onClick='load("http://tpeweb03:7001/webdz/OG/vhdbquery.htm","../blank.htm")'>OG Import</a></p>
<p class="txtblue"><a href="#" onClick='load("ChkSche2/selDay.jsp","ChkSche2/desc.html")'>###Working days check v1</a> </p>
<p class="txtblue"><a href="#" onClick='load("ChkSche2/selDay2.jsp","ChkSche2/desc.html")'>###Working 
  days check v2</a> </p>
<!--<p><a href="#" class="txtblue" onClick='load("http://tsaweb02:8099/CATII/selFleet.htm","../blank.htm")'>Email CATII/IIIa UnQualified</a></p>-->
<!--<p class="txtblue"><a href="#" onClick='load("../../FZ/apis/apis_cond.jsp","../../FZ/blank.htm")'>APIS</a></p> -->
<!--cs40  2006/10/12 --><p class="txtblue"><a href="#" onClick='load("../../FZ/apis/apis_cond.jsp","../../FZ/apis/apis_blank.jsp")'>APIS</a></p>
<!--cs40  2007/3/20 --><p class="txtblue"><a href="#" onClick='load("../../FZ/apis/apis_log_cond.jsp","../../FZ/blank.htm")'>APIS Log</a> </p>

<p class="txtblue"><a href="#" onClick='load("../../FZ/blank.htm","adm/cs66Menu.jsp")'>CS66測試</a></p>
<p><a href="cspage.jsp" target="_top"><span style="color:#003333;background-color:#FFCCFF;padding:2pt; ">選擇登入頁面</span></a></p>
<br>
<a href="#" onClick='load("../../FZ/blank.htm","dailycrew/sbMenu.jsp")'>Standby Test</a>
<p><a href="#" onClick='load("../blank.htm","adm/admF1.jsp")'><span style="color:#003333;background-color:#FFFFCC;padding:2pt; ">登入測試</span></a></p>
<p><a href="#" class="txtblue" onClick='load("../blank.htm","sendredirect.jsp")'>Logout</a></p>
<%
}
%>
</body>
</html>
<%
}
%>

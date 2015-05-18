<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,fz.pracP.*"%>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
} 



String fdate = request.getParameter("fdate");
String fltno = request.getParameter("fltno");
String dpt = request.getParameter("dpt");
String arv =request.getParameter("arv");

GetFltInfo ft = new GetFltInfo(fdate, fltno);
FlightCrewList fcl = new FlightCrewList(ft,dpt+arv);
fzac.CrewInfoObj caObj = null;
fz.prObj.FltObj fltObj 	= null;
fzac.CrewInfoObj purObj = null;
ArrayList crewObjList = null;
String bcolor = "";
String errMsg = "";
boolean status = false;
try{
	fcl.RetrieveData();

	caObj =  fcl.getCAObj(); //CA 資料
	fltObj= fcl.getFltObj();	//航班資料
	purObj = fcl.getPurCrewObj();	//Purser資料
	crewObjList = fcl.getCrewObjList();//組員名單
	if(fltObj == null){
		
		errMsg="查無該航班，請重新查詢!!";
	}/*else if("N".equals((String)session.getAttribute("powerUser")) &&!purObj.getEmpno().equals(sGetUsr)){
		
		errMsg="非本班機座艙長，請重新輸入";
	}*/else if(crewObjList == null){
		errMsg = "本班次目前尚無組員名單";
	}else{
		status = true;
	}
	
	
	if(caObj == null){
		caObj = new fzac.CrewInfoObj();
		caObj.setEmpno(" ");
		caObj.setCname(" ");
		caObj.setEname(" ");
	}
}catch(NullPointerException e){
	errMsg = "此班次 Purser 為Open,目前無法產生報表.";
} catch (Exception e) {
	errMsg = e.toString();
	//System.out.print(errMsg);
	
}
int rCount =0;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="../../errStyle.css">
<title></title>
<style type="text/css">
<!--
body{
font-family:Arial;
font-size:10pt;
color:#000000;
}
th{
background-color:#CCCCCC;
font-weight:bold;
}
.bgGray{
background-color:#CCCCCC;
}
td{
text-align:center;
}
.left{
text-align:left;
padding-left:0.5em;
}
.right{
text-align:right;
padding-right:0.5em;
}

-->
</style>
</head>
<body>
<%
if(!status){
%>
<div class="errStyle1"><%=errMsg%></div>
<%
}else{
%>

  <div align="center"> <span style="font-size:larger;font-weight:bold; ">CABIN CREW DIVISION<br>
    <span style="font-size:medium;font-weight:bold; ">PURSER'S TRIP REPORT (PART I)</span>
</span>

</div>

  <table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td colspan="3"><div align="right"><a href="javascript:window.print()"><img src="print.gif"  border="0" alt="列印"></a></div></td>
    </tr>
    <tr >
      <td class="left">Purser : <%=purObj.getCname()%></td>
      <td class="left">Group : <%=purObj.getGrp()%></td>
      <td class="left">Serial No : <%=purObj.getSern()%></td>
    </tr>
    <tr >
      <td class="left">Zone Chief : <%=(String)session.getAttribute("cname")%></td>
      <td class="left">Group : <%=(String)session.getAttribute("groups")%></td>
      <td class="left">Serial No : <%=(String)session.getAttribute("sern")%></td>
    </tr>
    <tr>
      <td class="left">Date : <%=fdate%></td>
      <td class="left">CI<%=fltno%>&nbsp;&nbsp;<%=dpt%> / <%=arv%></td>
      <td class="right">Capt&nbsp;&nbsp;<%=caObj.getCname()%>&nbsp;&nbsp;A/C&nbsp;<%=fltObj.getAcno()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Pax F : <%=fltObj.getActualF()%>&nbsp;C : <%=fltObj.getActualC()%>&nbsp;Y : <%=fltObj.getActualY()%></td>
    </tr>
  </table>
  <table width="100%"  border="1" align="center" cellpadding="0" cellspacing="0" >
    <tr >
      <th width="7%">Duty</th>
      <th width="7%">S.No</th>
      <th width="10%">Name</th>
      <th width="6%">GRP</th>
      <th width="8%">Qual</th>
      <th width="9%">GRD</th>
      <th width="6%">Duty</th>
      <th width="13%">S.No</th>
      <th width="12%">Name</th>
      <th width="6%">GRP</th>
      <th width="7%">Qual</th>
      <th width="9%">GRD</th>
    </tr>
<%
for(int i=0; i<20; i++){
	rCount++;
	if(rCount > 2 ){
		rCount = 1;
	}
	if(rCount == 1){
%>
		<tr>
<%
	}
	if(i<crewObjList.size()){
		fzac.CrewInfoObj cobj = (fzac.CrewInfoObj)crewObjList.get(i);
%>
      <td height="26" class="bgGray">&nbsp;</td>
      <td height="26"><%=cobj.getSern()%></td>
      <td height="26"><%=cobj.getCname()%></td>
      <td height="26"><%=cobj.getGrp()%></td>
      <td height="26"><%=cobj.getOccu()%></td>
      <td height="26">&nbsp;</td>
      <%
	}
	else{
%>
      <td height="26" class="bgGray">&nbsp;</td>
      <td height="26">&nbsp;</td>
      <td height="26">&nbsp;</td>
      <td height="26">&nbsp;</td>
      <td height="26">&nbsp;</td>
      <td height="26">&nbsp;</td>
      <%
	}
	if(rCount == 3){
		
%>
		</tr>
<%
	}
}
%>
</table>
<br>
  <table width="100%" height="354"  border="1" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td height="37" class="left" style="font-weight:bold; ">II.The Best Performance : F : _________________ C : _________________ Y : _________________</td>
    </tr>
    <tr>
      <td height="315" class="left" style="font-weight:bold;vertical-align:top;padding-top:0.5em; ">III.Crew Evaluation/Flt Irregularity : </td>
    </tr>
</table>
  
<%
}
%>
</body>
</html>

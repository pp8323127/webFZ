<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,fz.pracP.*"%>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) {		//check user session start first or not login
	//response.sendRedirect("../sendredirect.jsp");
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
<title></title>
<link href="../style2.css" rel="stylesheet" type="text/css">

<style type="text/css">
<!--

.style5 {
	font-size: x-small;
	font-weight: bold;
}
.style6 {font-size: small}
.style8 {color: #000000}
.style10 {font-size: small; font-weight: bold; color: #000000; }
-->
</style>
</head>
<body>
  <div align="center">
  </div>
  <div align="center">
  <span  style="font-size: x-large;font-weight: bold; ">CABIN CREW DIVISION</span><BR>
  <span  style="font-size: medium; ">PURSER'S TRIP REPORT (PART I)
  </span></div>
  <table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
	  <td colspan="3"><div align="right"><a href="javascript:window.print()"><img src="print.gif"  border="0" alt="列印"></a></div></td>
    </tr>
    <tr>
      <td>Pur : <%=purObj.getCname()%></td>
	  <td><div align="center">Group : <%=purObj.getGrp()%></div></td>
	  <td><div align="center">Serial No : <%=purObj.getSern()%></div></td>
    </tr>
    <tr>
      <td>Zone Chief : <%=(String)session.getAttribute("cname")%></td>
	  <td><div align="center">Group : <%=(String)session.getAttribute("groups")%></div></td>
	  <td><div align="center">Serial No : <%=(String)session.getAttribute("sern")%></div></td>
    </tr>	
    <tr>
      <td>Date : <%=fdate%></td>
	  <td>CI<%=fltno%>&nbsp;&nbsp;<%=dpt%> / <%=arv%></td>
	  <td><div align="right">Capt&nbsp;&nbsp;<%=caObj.getCname()%>&nbsp;&nbsp;A/C&nbsp;<%=fltObj.getAcno()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Pax F : <%=fltObj.getActualF()%>&nbsp;C : <%=fltObj.getActualC()%>&nbsp;Y : <%=fltObj.getActualY()%></div></td>
    </tr>
</table>
  <table width="100%"  border="1" align="center" cellpadding="0" cellspacing="0" >
    <tr bgcolor="#CCCCCC">
      <td width="7%"><div align="center" class="style5 style6 style8">Duty</div></td>
      <td width="7%"><div align="center" class="style10">S.No</div></td>
      <td width="10%"><div align="center" class="style10">Name</div></td>
      <td width="6%"><div align="center" class="style10">GRP</div></td>
	  <td width="8%"><div align="center" class="style10">Qual</div></td>
      <td width="9%"><div align="center" class="style10">GRD</div></td>
	  <td width="6%"><div align="center" class="style10">Duty</div></td>
      <td width="13%"><div align="center" class="style10">S.No</div></td>
      <td width="12%"><div align="center" class="style10">Name</div></td>
      <td width="6%"><div align="center" class="style10">GRP</div></td>
	  <td width="7%"><div align="center" class="style10">Qual</div></td>
      <td width="9%"><div align="center" class="style10">GRD</div></td>
    </tr>
<%
for(int i=0; i<21; i++){
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
      <td height="26" bgcolor="#CCCCCC"><div align="center" style="font-size: medium;">&nbsp;</div></td>
      <td height="26"><div align="center" style="font-size: medium;"><%=cobj.getSern()%></div></td>
      <td height="26"><div align="center" style="font-size: medium;"><%=cobj.getCname()%></div></td>
      <td height="26"><div align="center" style="font-size: medium;"><%=cobj.getGrp()%></div></td>
	  <td height="26"><div align="center" style="font-size: medium;"><%=cobj.getOccu()%></div></td>
      <td height="26"><div align="center" style="font-size: medium;">&nbsp;</div></td>
<%
	}
	else{
%>
      <td height="26" bgcolor="#CCCCCC"><div align="center" style="font-size: medium;">&nbsp;</div></td>
      <td height="26"><div align="center" style="font-size: medium;">&nbsp;</div></td>
      <td height="26"><div align="center" style="font-size: medium;">&nbsp;</div></td>
      <td height="26"><div align="center" style="font-size: medium;">&nbsp;</div></td>
      <td height="26"><div align="center" style="font-size: medium;">&nbsp;</div></td>
	  <td height="26"><div align="center" style="font-size: medium;">&nbsp;</div></td>
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
      <td height="37" valign="middle"><p><strong>II.The Best Performance : F : _________________ C : _________________ Y : _________________</strong></p>      </td>
    </tr>
    <tr>
      <td height="315" valign="top"><strong>III.Crew Evaluation/Flt Irregularity : </strong></td>
    </tr>
</table>
 
</body>
</html>

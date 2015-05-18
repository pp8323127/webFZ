<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.pracP.*,fz.pracP.dispatch.*,java.net.URLEncoder"%>

<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 


String GdYear = request.getParameter("GdYear");

String addSernList = "";
ArrayList OSernAList = new ArrayList();	//存入航班中原本的組員
ArrayList crewObjList = new ArrayList();
String fdate = request.getParameter("fdate");
String fltno = request.getParameter("fltno").trim();
String dpt = request.getParameter("dpt");
String arv =request.getParameter("arv");

String stdDt = null;
if("".equals(request.getParameter("stdDt")) 
	| null == request.getParameter("stdDt")
	| "null".equalsIgnoreCase(request.getParameter("stdDt")) ){
	stdDt = null;
	
}else{
	stdDt = request.getParameter("stdDt");
	
}

GetFltInfo ft = new GetFltInfo(fdate, fltno);

//FlightCrewList fcl = new FlightCrewList(ft,dpt+arv);
FlightCrewList fcl = new FlightCrewList(ft,dpt+arv,stdDt);

fzac.CrewInfoObj caObj = null;
fz.prObj.FltObj fltObj 	= null;
fzac.CrewInfoObj purObj = new fzac.CrewInfoObj();
purObj.setGrp(request.getParameter("pgroups"));
purObj.setCname(request.getParameter("purname"));
purObj.setEmpno(request.getParameter("purserEmpno"));
purObj.setSern(request.getParameter("pursern"));

//****************************************************************
//If 彈派
FlexibleDispatch fd = new FlexibleDispatch();
boolean iflessdisp = true;
iflessdisp = fd.ifFlexibleDispatch(fdate,fltno, dpt+arv,sGetUsr);
String tempfltno = "";
String tempfleet = fd.getFleetCd();
if(fltno.length()>= 4)
{
	tempfltno = fltno.substring(1,4);
}
else
{
	tempfltno = fltno;
}

/*
if("626725".equals(sGetUsr))
{
out.print("iflessdisp is "+ iflessdisp+" <br>");
}
*/
/*
FlexibleDispatch fd = new FlexibleDispatch();
fd.getLong_range(fdate,fltno, dpt+arv,sGetUsr) ;
tempfleet = fd.getFleetCd();
if("Y".equals(fd.getLongRang()))
{
	iflessdisp = false;
}    
else if ("73A".equals(fd.getFleetCd()))
{
	iflessdisp = false;
}
else  if ("738".equals(fd.getFleetCd()) && ( "791".equals(tempfltno) | "792".equals(tempfltno) | "112".equals(tempfltno) | "113".equals(tempfltno) | "731".equals(tempfltno) | "732".equals(tempfltno) | "751".equals(tempfltno) | "752".equals(tempfltno) | "721".equals(tempfltno) | "722".equals(tempfltno)))
{
	iflessdisp = false;
}
else if ("N".equals(fd.getLongRang()) && ("HKG".equals(dpt) | "HKG".equals(arv)))
{//區域行線台港線不彈派 SR9019
	iflessdisp = false;
}
*/
//****************************************************************
String bcolor = "";
String errMsg = "";
boolean status = false;
try{

	fcl.RetrieveData();

	OSernAList = fcl.getCrewSernList();	//組員序號名單
	crewObjList = fcl.getCrewObjList();	//組員資料名單
	session.setAttribute("crewObjList",crewObjList);
	
	caObj =  fcl.getCAObj(); //CA 資料
	fltObj= fcl.getFltObj();	//航班資料
	//purObj = fcl.getPurCrewObj();	//Purser資料
	
	if(fltObj == null){
		
		errMsg="查無該航班，請重新查詢!!";
	}/*else if("N".equals((String)session.getAttribute("powerUser")) &&!purObj.getEmpno().equals(sGetUsr)){
		
		errMsg="非本班機座艙長"+purObj.getEmpno()+"，請重新輸入";
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
	System.out.print("EDCREW"+errMsg);
	
}



//將sern串成OsernList ,format: '#####','#####'

fz.pracP.ChangeType cht = new fz.pracP.ChangeType();
String OsernList = cht.ArrayListToStirng(OSernAList);		//原始組員清單

%> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>編輯座艙長報告</title>
<link href="style2.css" rel="stylesheet" type="text/css">
<script language="javascript" src="checkDel.js" type="text/javascript"></script>
<script language="javascript" src="changeAction.js" type="text/javascript"></script>

</head>
<body >
<%
if(!status){
%>
<div class="txtxred" style="text-align:center "><%=errMsg%></div>
<%
}else{
%>

<form name="form1" method="post" action="edCrewDel.jsp" target="_self" onSubmit="return del('form1','delSern')">
  <table width="579" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td colspan="3" valign="middle">
        <div align="center" class="txtred"></div>
      
        <span class="txtblue">Purser's Report&nbsp;       <strong>&nbsp;</strong></span><span class="txtxred"><strong> Step1.Select Crew List(Add or Delete Crew List) </strong></span></td>
    </tr>
    <tr>
      <td colspan="2" valign="middle" class="txtblue"> FDate:<span class="txtred"><%=fdate%>&nbsp;</span>&nbsp;Fltno:<span class="txtred"><%=fltno%>&nbsp;&nbsp;</span>Sector:<span class="txtred"><%=dpt%><%=arv%></span> </td>
      <td width="62" valign="middle">&nbsp;</td>
    </tr>
    <tr>
      <td colspan="3" valign="middle" class="txtblue">Purser:<span class="txtred"><%=purObj.getCname()%>&nbsp;<%=purObj.getSern()%>&nbsp;<%=purObj.getEmpno()%></span>&nbsp;CA&nbsp;:<span class="txtred"><%=caObj.getEmpno()+"&nbsp;"+caObj.getCname()+"&nbsp;"+caObj.getEname()%></span></td>
    </tr>
</table>
  <table width="604"  border="0" align="center" cellpadding="2" cellspacing="0" >
    <tr class="tablehead3">
	 <td width="70">Select</td>
      <td width="123">Name</td>
      <td width="247">EName</td>
      <td width="51">Sern</td>
      <td width="58">Empno</td>
      <td width="31">Occu</td>
     
    </tr>
	<%
	for(int i=0;i<crewObjList.size();i++){
		fzac.CrewInfoObj o =(fzac.CrewInfoObj)crewObjList.get(i);
		if(i%2 ==0){
			bcolor="#99CCFF";
		}else{
			bcolor="#FFFFFF";
		}
	%>
  <tr bgcolor="<%=bcolor%>">
   <td valign="middle" class="tablebody">
        <input name="delSern" type="checkbox"  value="<%=o.getSern()%>">
      </td>
      <td align="center" valign="middle" class="tablebody">&nbsp;
	  <input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="12" value="<%=o.getCname()%> <%=o.getSpCode()%>" name="cname"></td>
      <td valign="middle" class="tablebody">
        <div align="left">&nbsp;
		<input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="30" value="<%=o.getEname()%>" name="ename"></div>
      </td>
      <td valign="middle" class="tablebody">
		<input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="6" value="<%=o.getSern()%>" name="sern">
	  </td>
      <td valign="middle" class="tablebody">
		<input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="6" value="<%=o.getEmpno()%>" name="empno">
	  </td>
      <td valign="middle" class="tablebody">
	  <input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="2" value="<%=o.getOccu()%>" name="occu" >
	  </td>
     

    </tr>
	<%
	}
	%>
  </table>

  <table width="528" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td width="43" height="53">&nbsp;</td>
      <td width="228">
        <div align="left" class="txtblue">Total:<%=crewObjList.size()%>        </div>
      </td>
      <td width="561"><span class="txttitletop">
        <input type="button" name="Score" value="Score (Next)" onClick="this.disabled=1;preview('form1','edReportScore.jsp')" class="addButton">
        &nbsp;&nbsp;&nbsp;
        <input type="submit" name="delEmpno2" value="Delete Selected" class="delButon" >
        <span class="txtblue">
		  <input type="hidden" name="dpt" value="<%=dpt%>">
		  <input type="hidden" name="arv" value="<%=arv%>">
		  <input type="hidden" name="fltno" value="<%=fltno%>">
		  <input type="hidden" name="fdate" value="<%=fdate%>">
		  <input type="hidden" name="OsernList" value="<%=OsernList%>">
		  <input type="hidden" name="addSernList" value="<%=addSernList%>">
		  <input type="hidden" name="CA" value="<%=caObj.getEmpno()+"&nbsp;"+caObj.getCname()+"&nbsp;"+caObj.getEname()%>">
		  <input type="hidden" name="acno" value="<%=fltObj.getAcno()%>">
  		  <input type="hidden" name="CACName" value="<%=caObj.getCname()%>">
   		  <input type="hidden" name="CAEmpno" value="<%=caObj.getEmpno()%>">
		  <input type="hidden" name="total" value="<%=crewObjList.size()%>">
		  <input type="hidden" name="fleet" value="<%=tempfleet%>">
<%
if (iflessdisp== true)
{
%>
		  <input type="hidden" name="ShowPeople" value="0">
  		  <input type="hidden" name="f" value="0">
   		  <input type="hidden" name="c" value="0">
		  <input type="hidden" name="y" value="0">
<%
}			
else
{
%>
		  <input type="hidden" name="ShowPeople" value="<%=fltObj.getBook_total()%>">
  		  <input type="hidden" name="f" value="<%=fltObj.getActualF()%>">
   		  <input type="hidden" name="c" value="<%=fltObj.getActualC()%>">
		  <input type="hidden" name="y" value="<%=fltObj.getActualY()%>">
<%
}	
%>
		  <input type="hidden" name="purserEmpno" value="<%=purObj.getEmpno()%>">
		  <input type="hidden" name="psrsern" value="<%=purObj.getSern()%>">
		  <input type="hidden" name="psrname" value="<%=purObj.getCname()%>">
		  <input type="hidden" name="pgroups" value="<%=purObj.getGrp()%>">
		  <input type="hidden" name="GdYear" value="<%=GdYear%>">
        </span> </span></td>
      <td width="44">
      </td>
    </tr>
</table>

  <table width="528" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td width="5%">&nbsp;</td>
      <td width="90%">
        <div align="left" class="txtblue">Insert Crew's Sern：
          <input type="text" name="addSern" size="5" maxlength="5">
     	   <input type="button" name="Submit2" value="Add"  onClick="checkAdd('form1','addSern','edCrewAdd.jsp')">
        <span class="txttitletop">&nbsp;&nbsp;&nbsp;        </span></div>
      </td>
      <td width="5%">
      </td>
    </tr>
</table>

</form>

<%
}//end of no exeception
%>
</body>
</html>
<SCRIPT type="text/javascript" language="JavaScript">
  addFocus();
  function addFocus()
  {
        //  document.getElementById('addSernSub').focus();
      }
</SCRIPT>


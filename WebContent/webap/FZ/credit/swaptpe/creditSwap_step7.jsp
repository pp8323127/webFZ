<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,java.util.*,swap3ac.*,java.text.*"%>
<%
/*
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
*/
String aEmpno = request.getParameter("aEmpno"); // (String) session.getAttribute("aEmpno") ;
String rEmpno = request.getParameter("rEmpno");
String year = request.getParameter("year");
String month = request.getParameter("month");
String asno = request.getParameter("asno");
String rsno = request.getParameter("rsno");
String source = request.getParameter("source");

int aALtimes =  0;
int rALtimes =  0;
DecimalFormat df = new DecimalFormat("0000");

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>確認申請更換之班表</title>
<link href="menu.css" rel="stylesheet" type="text/css">

<style type="text/css">
<!--
.b1 {
	font-family: Verdana;
	font-weight: bold;
	font-size:10pt;
}
.b2{
padding-left:2pt;
font-family:Verdana;
color:#0000FF;
font-size:10pt;
}
.b3{
padding-left:2pt;
font-family:"細明體";
color:#0000FF;
font-size:10pt;}

.bt{
	background-color:#99CCFF;color:#000000;font-family:Verdana;border:1pt solid #000000; 
}
.bt2{
		background-color:#CCCCCC;color:#000000;font-family:Verdana;border:1pt solid #000000; 
}

-->
</style>
<script language="JavaScript" type="text/JavaScript">

function showPop()
{
	newopen=window.open('../../note.htm','note','height=250,width=500,top=100,left=200');

}

function disa()
{
	document.form1.Send.disabled=1;
	document.form1.Cancel.disabled=1;
	return true;
}
</script>

</head>
<body>
<%

//out.print("source >> "+ source+" aEmpno >>"+ aEmpno + " rEmpno >> "+ rEmpno + " year >> "+ year + " month >> "+ month+ " asno >> "+ asno +" rsno >> "+ rsno+"<br>");

//************************************************************************
String displaystr = "";
String r_isfullattendance = "";
if("normal".equals(source))
{
	//被換者選擇三次換班權利,需檢核是否全勤
	CheckFullAttendance rcs = new CheckFullAttendance(rEmpno, year+month);
	r_isfullattendance = rcs.getCheckMonth();
	if(!"Y".equals(r_isfullattendance))
	{
		displaystr = r_isfullattendance;
	}
}
//***********************************************************************
swap3ac.ApplyCheck ac = new swap3ac.ApplyCheck(aEmpno,rEmpno,year,month);

if(ac.isUnCheckForm())
{	//有申請單尚未核可，不可申請
%>
<p style="color:red;text-align:center ">申請者(<%=aEmpno%>)&nbsp;
			或被換者(<%=rEmpno%>)&nbsp;有申請單尚未經ED核可, <br>		
系統不受理遞單.</p>
<%
//***********************************************************************
}
else if("normal".equals(source) && !"Y".equals(r_isfullattendance) )
{
%>
	<p style="color:red;text-align:center "><%=displaystr%> </p>
<%
}
else if ("normal".equals(source) && ac.getRApplyTimes() >=3 )
{ // 被換者選擇三次換班權利而且當月申請次數高於3次，不可申請
%>
<p style="color:red;text-align:center ">被換者(<%=rEmpno%>)&nbsp; 
			當月申請次數已超過三次, <br>		
			系統不受理遞單.</p>
<%
}
else if(aEmpno.equals(rEmpno))
{
%>
<p style="color:red;text-align:center ">被換者(<%=rEmpno%>)員工號無效!!</p>
<%
}
else
{
String[] aSwapSkj = request.getParameterValues("aSwapSkj");//申請者勾選的班
String[] rSwapSkj = request.getParameterValues("rSwapSkj");//被換者勾選的班
String comments = request.getParameter("comments");
String comm2 = request.getParameter("comm2");
String aCname = null;
String rCname = null;



CrewSwapSkj csk = new CrewSwapSkj(aEmpno, rEmpno, year, month);

CrewInfoObj aCrewInfoObj = null; //申請者的組員個人資料
CrewInfoObj rCrewInfoObj = null;//被換者的組員個人資料
ArrayList commItemAL = new ArrayList();
ArrayList aSwapSkjAL = new ArrayList();
ArrayList rSwapSkjAL = new ArrayList();

try 
{
	csk.SelectData();
	aCrewInfoObj =csk.getACrewInfoObj();
	rCrewInfoObj =csk.getRCrewInfoObj();		
	commItemAL = csk.getCommItemAL();
	if(aCrewInfoObj != null)
	{ 
		aCname = aCrewInfoObj.getCname();
	}

	if(rCrewInfoObj != null)
	{ 
		rCname =rCrewInfoObj.getCname();
	}

} 
catch (SQLException e) 
{
	System.out.println(e.toString());	
}
catch(Exception e)
{
	System.out.println(e.toString());
}
%>

<%

CalcSwapHrs cSHrs = new CalcSwapHrs();
if(!cSHrs.job(aCrewInfoObj,rCrewInfoObj,csk.getACrewSkjAL(),csk.getRCrewSkjAL(),aSwapSkj,rSwapSkj))
{
	out.print("<body>尚未選擇班次<br>");
}
else
{
	//out.print("申請者換前飛時："+aCrewInfoObj.getPrjcr()+"<br>被換者換前飛時："+rCrewInfoObj.getPrjcr()+"<BR>");
	//out.print("申請者換後飛時："+cSHrs.getACrAfterSwap()+"<br>被換者換後飛時："+cSHrs.getRCrAfterSwap()+"<BR>");
	
	aSwapSkjAL = cSHrs.getASwapSkjAL();
	rSwapSkjAL = cSHrs.getRSwapSkjAL();

	//SwapCheck sc = new SwapCheck(aCrewInfoObj.getPrjcr(),rCrewInfoObj.getPrjcr(),cSHrs.getACrAfterSwap(),cSHrs.getRCrAfterSwap());
	SwapCheck sc = new SwapCheck(aCrewInfoObj.getPrjcr(),rCrewInfoObj.getPrjcr(),cSHrs.getACrAfterSwap(),cSHrs.getRCrAfterSwap(),year,month);

	//***************************************************************
	CheckValidCNVisa cnv = new CheckValidCNVisa();
	boolean ifpasscnvisa = cnv.job(aCrewInfoObj,rCrewInfoObj,csk.getACrewSkjAL(),csk.getRCrewSkjAL(),aSwapSkj,rSwapSkj);
	//***************************************************************	
	//1. 只有換 2 月 及  3  月份的班 需call 此功能  test:12.1.2.3
	//2. 試算及換班都要call 此功能
	//3. 只有台北Crew 需Call 此功能
	String ulrFlightStr = "";
	if("02".equals(month) || "03".equals(month)){
		ULRFlightCheck s = new ULRFlightCheck(year,month,aEmpno,rEmpno,csk.getACrewSkjAL(),csk.getRCrewSkjAL(),aSwapSkj, rSwapSkj);
	    ulrFlightStr = s.setSwapSeries();
	    if("Y".equals(ulrFlightStr))
	    {
	        ulrFlightStr = s.CheckULRFlight(year,month); 
	    }   
    }else{
    	ulrFlightStr = "Y";
    }
    //System.out.println(return_str);
	//***************************************************************
	if(!sc.isExchangeable())
	{	//不可換班
%>
<div style="color:red;text-align:center;font-family:Verdana;font-size:10pt;background-color:#CCFFFF;padding:2pt;"><span style="color:#000000 "><br>
  申請換班條件不符，不可換班。原因為：</span><br>
  <%=sc.getErrorMsg()%><br>
  <a href="javascript:history.back(-1)" style="text-decoration:underline ">重新選擇更換班次</a><br>
</div>
<%	
}
else if (ifpasscnvisa == false)
{
%>
<body>
<div style="color:red;text-align:center;font-family:Verdana;font-size:10pt;background-color:#CCFFFF;padding:2pt;"><span style="color:#000000 "><br>
  申請換班條件不符，不可換班。原因為：</span><br>申請者或被換者台胞証效期已逾期<br>
  <a href="javascript:history.back(-1)" style="text-decoration:underline ">重新選擇更換班次</a><br>
</div>
<%
}
else if (!"Y".equals(ulrFlightStr))
{
%>
<body>
<div style="color:red;text-align:center;font-family:Verdana;font-size:10pt;background-color:#CCFFFF;padding:2pt;"><span style="color:#000000 "><br>
  申請換班條件不符，不可換班。原因為：</span><br><%=ulrFlightStr%><br>
  <a href="javascript:history.back(-1)" style="text-decoration:underline ">重新選擇更換班次</a><br>
</div>
<%
	}
else
{	// 符合換班條件
%>
<body onLoad="showPop()">
    <form name="form1" action="credit_updSwapForm.jsp" method="post" onsubmit="return disa()">
	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr> 
      <td width="3%" height="16">&nbsp;</td>
      <td width="94%">
        <div align="center" class="b1">Swap Application Form</div>
      </td>
      <td width="3%">
        
      </td>
    </tr>
    <tr>
      <td height="91">&nbsp;</td>
      <td >
        <span class="txtxred">The Applicant and the Substitute hereby agree to exchange the designated flights as outlined in this form, and duly represent the following,</span>
        <ul>
          <li class="txtxred">Full duty attendance for two consecutive calendar months prior to applying </li>
          <li class="txtxred">All contents present hereunder are in compliance with the applicable rules </li>
        </ul>
      </td>
      <td>&nbsp;</td>
    </tr>
  </table>
<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr> 
      <td width="5%">&nbsp;</td>
      <td width="90%" class="font1">&nbsp;</td>
      <td width="5%">
        <div align="right"><a href="javascript:window.print()"> <img src="print.gif" width="17" height="15" border="0" alt="列印"></a> 
        </div>
      </td>
    </tr>
</table>
  <table width="90%"  border="1" cellpadding="1" cellspacing="0" align="center">
    <tr > 
      <td width="18%" class="tablehead2"> 
        <div align="center">說 明 </div>
      </td>
      <td width="38%" colspan="2" class="tablehead2"> 
        <div align="center"> <strong>Applicant </strong> </div>
      </td>
      <td width="44%" colspan="2" class="tablehead2"> 
        <div align="center"> <strong>Substitute </strong> </div>
      </td>
    </tr>
    <tr > 
      <td class="tablebody"><b><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
        Name / Section</font></b></td>
      <td class="tablebody"><%=aCname%> 
        <input type="hidden" name="aCname" value="<%=aCname%>">
      </td>
      <td class="tablebody"><%=aCrewInfoObj.getGrps()%> 
        <input type="hidden" name="aGrps" value="<%=aCrewInfoObj.getGrps()%>">
      </td>
      <td class="tablebody"><%=rCname%> 
        <input type="hidden" name="rCname" value="<%=rCname%>">
      </td>
      <td class="tablebody"><%=rCrewInfoObj.getGrps()%> 
        <input type="hidden" name="rGrps" value="<%=rCrewInfoObj.getGrps()%>">
      </td>
    </tr>
    <tr > 
      <td class="tablebody"><b><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
        ID. No. / Serial No </font></b></td>
      <td class="tablebody"><%=aEmpno%> 
	 <input type="hidden" name="aEmpno" value="<%=aEmpno%>">
      </td>
      <td class="tablebody"><%=aCrewInfoObj.getSern()%> 
        <input type="hidden" name="aSern" value="<%=aCrewInfoObj.getSern()%>">
      </td>
      <td class="tablebody"><%=rEmpno%> 
        <input type="hidden" name="rEmpno" value="<%=rEmpno%>">
      </td>
      <td class="tablebody"><%=rCrewInfoObj.getSern()%> 
        <input type="hidden" name="rSern" value="<%=rCrewInfoObj.getSern()%>">
      </td>
    </tr>
    <tr > 
      <td class="tablebody"><b><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">Exchange Count</font></b></td>
      <td colspan="2" class="tablebody"><%=Integer.parseInt((String)session.getAttribute("aApplyTimes"))%> 
	  <input type="hidden" name="aApplyTimes" value="<%=Integer.parseInt((String)session.getAttribute("aApplyTimes"))%>">
      </td>
<%
if("normal".equals(source))
{		  
%>
      <td colspan="2" class="tablebody"><%=Integer.parseInt((String)session.getAttribute("rApplyTimes"))+1%> 
	  <input type="hidden" name="rApplyTimes" value="<%=Integer.parseInt((String)session.getAttribute("rApplyTimes"))+1%>">
      </td>
<%
}
else
{
%>
      <td colspan="2" class="tablebody"><%=Integer.parseInt((String)session.getAttribute("rApplyTimes"))%> 
	  <input type="hidden" name="rApplyTimes" value="<%=Integer.parseInt((String)session.getAttribute("rApplyTimes"))%>">
      </td>
<%
}
%>
    </tr>
    <tr class="tablebody"> 
      <td class="tablebody"><b><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">Qualification</font></b></td>
      <td colspan="2" class="tablebody"><%=aCrewInfoObj.getQual()%> 
        <input type="hidden" name="aQual" value="<%=aCrewInfoObj.getQual()%>">
      </td>
      <td colspan="2" class="tablebody"><%=rCrewInfoObj.getQual()%> 
        <input type="hidden" name="rQual" value="<%=rCrewInfoObj.getQual()%>">
      </td>
    </tr>
  </table>

  <p>&nbsp;</p>
  <table width="90%"  border="1" cellpadding="1" cellspacing="0" align="center">
    <tr > 
      <td colspan="4" class="tablehead2"> 
        <div align="center"> <strong>Applicant </strong> </div>
      </td>
    </tr>
    <tr > 
      <td width="25%" class="tablehead2"> 
        <div align="center">TripNo</div>
      </td>
      <td class="tablehead2"> 
        <div align="center">Flight Date </div>
      </td>
      <td class="tablehead2"> 
        <div align="center">FlightNo</div>
      </td>
      <td class="tablehead2"> 
        <div align="center">Flying Time</div>
      </td>
    </tr>
	<%
	if(aSwapSkj != null)
	{
		//for(int i=0;i<aSwapSkj.length;i++){
//			CrewSkjObj obj = (CrewSkjObj)aCrewSkjAL.get(Integer.parseInt(aSwapSkj[i]));
		for(int i=0;i<aSwapSkjAL.size();i++)
			{
			CrewSkjObj obj = (CrewSkjObj)aSwapSkjAL.get(i);
	%>
    <tr > 
      <td class="tablebody"><%=obj.getTripno()%> 
        <input type="hidden" name="aTripno" value="<%=obj.getTripno()%>">
      </td>
      <td class="tablebody"><%=obj.getFdate()%> 
        <input type="hidden" name="aFdate" value="<%=obj.getFdate()%>">        
      </td>
      <td class="tablebody"><%=obj.getDutycode()%> <%if("77W".equals(obj.getActp())){out.print("&nbsp;"+obj.getActp());}%>
        <input type="hidden" name="aFltno" value="<%=obj.getDutycode()%>">        
        <input type="hidden" name="aActp" value="<%=obj.getActp()%>">
      </td>
      <!--<td class="tablebody"><%=obj.getCr()%> 
        <input type="hidden" name="aFlyHrs" value="<%=obj.getCr()%>">
        <input type="hidden" name="aIdx" value="<%=i%>">
      </td>-->
<%
if("AL".equals(obj.getDutycode()))	
{
	aALtimes++; 
%>
	  <td class="tablebody">0000 
        <input type="hidden" name="aFlyHrs" value="0000">
        <input type="hidden" name="aIdx" value="<%=i%>">
      </td>

<%
}
else
{
%>
      <td class="tablebody"><%=obj.getCr()%> 
        <input type="hidden" name="aFlyHrs" value="<%=obj.getCr()%>">
        <input type="hidden" name="aIdx" value="<%=i%>">
      </td>

<%
}
%>
    </tr>
<%
		}
	}
%>
  </table>
  


  <p>&nbsp;</p>
  <table width="90%"  border="1" cellpadding="1" cellspacing="0" align="center">
    <tr > 
      <td colspan="4" class="tablehead2"> 
        <div align="center"> <strong>Substitute</strong> </div>
      </td>
    </tr>
    <tr > 
      <td width="25%" class="tablehead2"> 
        <div align="center">TripNo</div>
      </td>
      <td class="tablehead2"> 
        <div align="center">Flight Date </div>
      </td>
      <td class="tablehead2"> 
        <div align="center">FlightNo</div>
      </td>
      <td class="tablehead2"> 
        <div align="center">Flying Time</div>
      </td>
    </tr>
	<%
	if(rSwapSkj != null){
		//for(int i=0;i<rSwapSkj.length;i++){
//			CrewSkjObj obj = (CrewSkjObj)rCrewSkjAL.get(Integer.parseInt(rSwapSkj[i]));
		for(int i=0;i<rSwapSkjAL.size();i++){
			CrewSkjObj obj = (CrewSkjObj)rSwapSkjAL.get(i);

	%>
    <tr > 
      <td class="tablebody"><%=obj.getTripno()%> 
        <input type="hidden" name="rTripno" value="<%=obj.getTripno()%>">
      </td>
      <td class="tablebody"><%=obj.getFdate()%> 
        <input type="hidden" name="rFdate" value="<%=obj.getFdate()%>">
       
        
      </td>
      <td class="tablebody"><%=obj.getDutycode()%>  <%if("77W".equals(obj.getActp())){out.print("&nbsp;"+obj.getActp());}%>
        <input type="hidden" name="rFltno" value="<%=obj.getDutycode()%>">
        <input type="hidden" name="rActp" value="<%=obj.getActp()%>">
      </td>
      <!--<td class="tablebody"><%=obj.getCr()%> 
        <input type="hidden" name="rFlyHrs" value="<%=obj.getCr()%>">
		<input type="hidden" name="rIdx" value="<%=i%>">
      </td>-->

<%
if("AL".equals(obj.getDutycode()))	
{
	rALtimes++; 
%>
	  <td class="tablebody">0000 
        <input type="hidden" name="rFlyHrs" value="0000">
        <input type="hidden" name="rIdx" value="<%=i%>">
      </td>

<%
}
else
{
%>
      <td class="tablebody"><%=obj.getCr()%> 
        <input type="hidden" name="rFlyHrs" value="<%=obj.getCr()%>">
        <input type="hidden" name="rIdx" value="<%=i%>">
      </td>

<%
}
%>
    </tr>
<%
		}
	}
%>
  </table>
    
  <P> </P>
  <table width="90%"  border="1" cellpadding="1" cellspacing="0" align="center">
    <tr>
      <td width="41%" class="tablebody">
        <div align="center" class="b2">
          <div align="left">Total flying Hours for this Flight Exchange <br>
            <span class="b3">互換班次之總飛時</span>
          </div>
        </div>
      </td>
      <td class="txttitle"><b>A </b></td>
      <td class="tablebody"><%=cSHrs.getASwapTotalCr()%>
          <input type="hidden" name="aSwapHr" value="<%=cSHrs.getASwapTotalCr()%>">
      </td>
      <td class="txttitle"><b>B </b></td>
      <td class="tablebody"><%=cSHrs.getRSwapTotalCr()%>
          <input type="hidden" name="rSwapHr" value="<%=cSHrs.getRSwapTotalCr()%>">
      </td>
    </tr>
    <tr>
      <td width="41%" class="tablebody">
        <p align="left" class="b2">Flying Hour difference<br>
          <span class="b3">互換班次飛時差額</span>          <br>
        </p>
      </td>
      <td class="txttitle"><b>A-B=X : </b></td>
      <td class="tablebody"><%=cSHrs.getASwapDiffCr()%>
          <input type="hidden" name="aSwapDiff" value="<%=cSHrs.getASwapDiffCr()%>">
      </td>
      <td class="txttitle"><b>A-B=X :</b></td>
      <td class="tablebody"><%=cSHrs.getRSwapDiffCr()%>
          <input type="hidden" name="rSwapDiff" value="<%=cSHrs.getRSwapDiffCr()%>">
      </td>
    </tr>
    <tr>
      <td class="tablebody">
        <div align="center" class="b2">
          <div align="left">Projected Credit Hour <br>
            <span class="b3">換班前時數</span> </div>
        </div>
      </td>
      <td class="txttitle"><b>Applicant:</b></td>
      <td class="tablebody"><%= aCrewInfoObj.getPrjcr()%>
          <input type="hidden" name="aPrjcr" value="<%= aCrewInfoObj.getPrjcr()%>">
      </td>
      <td class="txttitle"><b>Substitute:</b></td>
      <td class="tablebody"><%= rCrewInfoObj.getPrjcr()%>
          <input type="hidden" name="rPrjcr" value="<%= rCrewInfoObj.getPrjcr()%>">
      </td>
    </tr>
    <tr>
      <td class="tablebody">
        <div align="center" class="b2">
          <div align="left">Total abandon AL CR<br>
            <span class="b3">放棄AL時數</span> </div>
        </div>
      </td>
      <td class="txttitle"><b>AL</b></td>
      <td class="tablebody">-<%= df.format(200 * aALtimes)%>  </td>
      <td class="txttitle"><b>AL</b></td>
      <td class="tablebody">-<%= df.format(200 * rALtimes)%>  </td>
    </tr>
    <tr>
      <td width="41%" class="tablebody">
        <div align="center" class="b2">
          <div align="left">Total monthly flying Hours after Flight Exchange <br>
            <span class="b3">換班後時數</span> </div>
        </div>
      </td>
      <td width="11%" class="txttitle"><b>C ±X +AL=</b></td>
      <td width="18%" class="tablebody"><%= cSHrs.getACrAfterSwap()%>
          <input type="hidden" name="aSwapCr" value="<%= cSHrs.getACrAfterSwap()%>">
      </td>
      <td width="12%" class="txttitle"><b>D ±X +AL=</b></td>
      <td width="18%" class="tablebody"><%=cSHrs.getRCrAfterSwap()%>
          <input type="hidden" name="rSwapCr" value="<%=cSHrs.getRCrAfterSwap()%>">
      </td>
    </tr>
  </table>
  <br>
  <table width="90%"  border="1" cellpadding="1" cellspacing="0" align="center">
    <tr>
      <td width="24%" class="txttitle">
<div align="center">
          <p align="left"><b>Comments</b></p>
        </div></td>
    <td width="76%" class="tablebody">&nbsp;<%=comm2+"&nbsp;"+comments%>
      <input type="hidden" name="comments" value="<%=(comm2+comments)%>"></td>
  </tr>
    <tr>
      <td colspan="2" class="txttitle">
        <div align="center">
  <input name="Cancel" type="button" onClick="javascript:history.back(-2);" value="Cancel" class="bt2">
&nbsp;&nbsp;&nbsp;
  <input name="Send" type="submit" value="Send" class="bt">
        </div>
      </td>
      </tr>
</table>
<input type="hidden" name="year"  value="<%=year%>">
<input type="hidden" name="month" value="<%=month%>">
<input type="hidden" name="aEmpno" value="<%=aEmpno%>">
<input type="hidden" name="rEmpno" value="<%=rEmpno%>">
<input type="hidden" name="asno" value="<%=asno%>">
<input type="hidden" name="rsno" value="<%=rsno%>">
<input type="hidden" name="source" value="<%=source%>">
</form>
<%
	}//end of 可換班
}//end of 有選擇班次
%>
</body>
</html>
<%
}
%>
<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,java.util.*,swap3ac.*,java.text.*"%>
<%
/*
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
*/
String aEmpno =  request.getParameter("aEmpno");
String rEmpno = request.getParameter("rEmpno");
String year = request.getParameter("year");
String month = request.getParameter("month");
int aALtimes =  0;
int rALtimes =  0;
DecimalFormat df = new DecimalFormat("0000");

String[] aSwapSkj = request.getParameterValues("aSwapSkj");//申請者勾選的班
String[] rSwapSkj = request.getParameterValues("rSwapSkj");//被換者勾選的班

String aCname = null;
String rCname = null;

//取得換班次數
swap3ac.ApplyCheck ac = new swap3ac.ApplyCheck(aEmpno,rEmpno,year,month);

CrewCrossCr csk = new CrewCrossCr(aEmpno, rEmpno, year, month);

CrewInfoObj aCrewInfoObj = null; //申請者的組員個人資料
CrewInfoObj rCrewInfoObj = null;//被換者的組員個人資料

ArrayList aSwapSkjAL = null;
ArrayList rSwapSkjAL = null;


try 
{
	csk.SelectData();
	aCrewInfoObj =csk.getACrewInfoObj();
	rCrewInfoObj =csk.getRCrewInfoObj();	

if(aCrewInfoObj != null){ 
	/*aCname = new String(ci.tool.UnicodeStringParser.removeExtraEscape(
			aCrewInfoObj.getCname()).getBytes(), "Big5");
			*/
	aCname = aCrewInfoObj.getCname();			
}

if(rCrewInfoObj != null){ 
	/*rCname =new String(ci.tool.UnicodeStringParser.removeExtraEscape(
			rCrewInfoObj.getCname()).getBytes(), "Big5");*/
rCname = rCrewInfoObj.getCname();					
}

} catch (SQLException e) {
	System.out.println(e.toString());	
}catch(Exception e){
	System.out.println(e.toString());
}


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>換班飛時試算</title>
<link href="../menu.css" rel="stylesheet" type="text/css">
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


</head>


<%

CalcSwapHrs cSHrs = new CalcSwapHrs();
if(!cSHrs.job(aCrewInfoObj,rCrewInfoObj,csk.getACrewSkjAL(),csk.getRCrewSkjAL(),aSwapSkj,rSwapSkj)){
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
	//1. 只有換 2 月 及  3  月份的班 需call 此功能  test:12.1.2.3
	//2. 試算及換班都要call 此功能
	//3. 只有台北Crew 需Call 此功能
	String ulrFlightStr = "";
	if( "02".equals(month) || "03".equals(month)){
		ULRFlightCheck s = new ULRFlightCheck(year,month,aEmpno,rEmpno,csk.getACrewSkjAL(),csk.getRCrewSkjAL(),aSwapSkj, rSwapSkj);
	    ulrFlightStr = s.setSwapSeries();
	    if("Y".equals(ulrFlightStr))
	    {
	        ulrFlightStr = s.CheckULRFlight(year,month); 
			//out.println("1.:"+ulrFlightStr);
	    }   
    }else{
    	ulrFlightStr = "Y";
    }
	//out.println("2.:"+ulrFlightStr);
	//***************************************************************
	if(!sc.isExchangeable())
	{	//不可換班
%>
<body>
<div style="color:red;text-align:center;font-family:Verdana;font-size:10pt;background-color:#CCFFFF;padding:2pt;"><span style="color:#000000 "><br>
  勾選試算班次，不符申請換班條件。原因為：</span><br>
  <%=sc.getErrorMsg()%><br>
  <a href="javascript:history.back(-1)" style="text-decoration:underline ">重新選擇試算班次</a><br>
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
	}else{	// 符合換班條件
	

%>
<body > 
	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr> 
      <td width="3%" height="25">&nbsp;</td>
      <td width="94%">
        <div style="text-align:center;color:#003399;font-size:14pt;font-weight:bold;font-family:Verdana;">換班飛時試算</div>   
      </td>
      <td width="3%">
        
      </td>
    </tr>
  </table>
<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr> 
      <td> 
        <div align="left" class="txtxred">試算日期:
          <%
		java.util.Date curDate = java.util.Calendar.getInstance().getTime();
		out.print(new java.text.SimpleDateFormat("yyyy/MM/dd EEE HH:mm:ss ",Locale.UK).format(curDate));
		%>
        </div>
      </td>
      <td width="5%">
        <div align="right"><a href="javascript:window.print()"> <img src="../images/print.gif" width="17" height="15" border="0" alt="列印"></a> 
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
      <td class="tablebody"><%=aCname%>      </td>
      <td class="tablebody"><%=aCrewInfoObj.getGrps()%>      </td>
      <td class="tablebody"><%=rCname%>      </td>
      <td class="tablebody"><%=rCrewInfoObj.getGrps()%>      </td>
    </tr>
    <tr > 
      <td class="tablebody"><b><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
        ID. No. / Serial No </font></b></td>
      <td class="tablebody"><%=aEmpno%>      </td>
      <td class="tablebody"><%=aCrewInfoObj.getSern()%>      </td>
      <td class="tablebody"><%=rEmpno%>      </td>
      <td class="tablebody"><%=rCrewInfoObj.getSern()%>      </td>
    </tr>
    <tr > 
      <td class="tablebody"><b><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">Exchange Count</font></b></td>
      <td colspan="2" class="tablebody"><%=ac.getAApplyTimes()+1%>      </td>
      <td colspan="2" class="tablebody"><%=ac.getRApplyTimes()+1%>      </td>
    </tr>
    <tr class="tablebody"> 
      <td class="tablebody"><b><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">Qualification</font></b></td>
      <td colspan="2" class="tablebody"><%=aCrewInfoObj.getQual()%>      </td>
      <td colspan="2" class="tablebody"><%=rCrewInfoObj.getQual()%>      </td>
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
      <td class="tablebody"><%=obj.getTripno()%>      </td>
      <td class="tablebody"><%=obj.getFdate()%>      </td>
      <td class="tablebody"><%=obj.getDutycode()%>      </td>
      <!--<td class="tablebody"><%=obj.getCr()%></td>-->
<%
if("AL".equals(obj.getDutycode()))	
{
	aALtimes++; 
%>
      <td class="tablebody">0000</td>
<%
}
else
{
%>
      <td class="tablebody"><%=obj.getCr()%></td>
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
      <td class="tablebody"><%=obj.getTripno()%>      </td>
      <td class="tablebody"><%=obj.getFdate()%>      </td>
      <td class="tablebody"><%=obj.getDutycode()%>      </td>
<%
if("AL".equals(obj.getDutycode()))	
{
		rALtimes++; 
%>
      <td class="tablebody">0000</td>
<%
}
else
{
%>
      <td class="tablebody"><%=obj.getCr()%></td>
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
      <td class="tablebody"><%=cSHrs.getASwapTotalCr()%>      </td>
      <td class="txttitle"><b>B </b></td>
      <td class="tablebody"><%=cSHrs.getRSwapTotalCr()%>      </td>
    </tr>
    <tr>
      <td width="41%" class="tablebody">
        <p align="left" class="b2">Flying Hour difference<br>
          <span class="b3">互換班次飛時差額</span>          <br>
        </p>
      </td>
      <td class="txttitle"><b>A-B=X : </b></td>
      <td class="tablebody"><%=cSHrs.getASwapDiffCr()%>      </td>
      <td class="txttitle"><b>A-B=X :</b></td>
      <td class="tablebody"><%=cSHrs.getRSwapDiffCr()%>      </td>
    </tr>
    <tr>
      <td class="tablebody">
        <div align="center" class="b2">
          <div align="left">Projected Credit Hour <br>
            <span class="b3">換班前時數</span> </div>
        </div>
      </td>
      <td class="txttitle"><b>Applicant:</b></td>
      <td class="tablebody"><%= aCrewInfoObj.getPrjcr()%>      </td>
      <td class="txttitle"><b>Substitute:</b></td>
      <td class="tablebody"><%= rCrewInfoObj.getPrjcr()%>      </td>
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
      <td width="18%" class="tablebody"><%= cSHrs.getACrAfterSwap()%>      </td>
      <td width="12%" class="txttitle"><b>D ±X +AL=</b></td>
      <td width="18%" class="tablebody"><%= cSHrs.getRCrAfterSwap()%>      </td>
    </tr>
  </table>
  
<br>
<div style="text-align:justify;font-family:Verdana;font-size:10pt;padding-left:150pt;width:500;color:#FF0000;padding-bottom:2pt;padding-top:2pt;margin-left:50pt;line-height:1.3" align="center">
**註：本功能僅提供換班前飛時試算，<br>
  不檢查換班雙方是否有申請單尚未經ED處理，<br>
  或該月換班次數超過3次不得換班之情況.</div>

  <%
	}//end of 可換班
}//end of 有選擇班次
%>
</body>
</html>
<%
//}
%>
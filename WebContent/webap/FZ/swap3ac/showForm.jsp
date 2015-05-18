<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,ci.db.*,swap3ac.*,java.text.*"%>
<%
//2011/12/07 因失常單 新增
response.setHeader("Pragma","no-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0); //prevents caching at the proxy server    
//2011/12/07 因失常單 新增

String fromno = request.getParameter("formno");
if(fromno == null){
out.print("查無資料");
}else{
ShowSwapForm sform = new ShowSwapForm(fromno);
SwapFormObj obj = sform.getSwapFormObj();
ArrayList aSwapSkjAL = obj.getASwapSkjAL();
ArrayList rSwapSkjAL =  obj.getRSwapSkjAL();

int aALtimes =  0;
int rALtimes =  0;
DecimalFormat df = new DecimalFormat("0000");
%>

<html>
<head>
<title>Show Apply Form</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" href="../menu.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<p align="center"><b>客艙組員任務互換申請單 </b></p>
<p align="center"><span class="font1"><font color="#FF0000"><strong>本人及互換者相互同意換班並保證： 
  <br>
  1. 本申請日前兩個曆月內全勤。 2. 本申請單內填寫內容均符合申請規定無誤。 </strong></font></span></p>
<br>
<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
  <tr> 
    <td><font face="Arial, Helvetica, sans-serif" size="2"><b>Form No : <%=obj.getFormno()%></b></font> 
    <td><font face="Arial, Helvetica, sans-serif" size="2"><b>ApplyDate :</b></font> 
      <font face="Arial, Helvetica, sans-serif" size="2"><b><%=obj.getNewdate()%></b></font></td>
    <td> 
      <div align="right"><a href="javascript:window.print()"> <img src="print.gif" width="17" height="15" border="0" alt="列印"></a> 
      </div>
    </td>
  </tr>
</table>
<div align="center"></div>
<table width="90%"  border="1" cellpadding="0" cellspacing="0" align="center">
  <tr > 
    <td width="18%" class="tablehead2"> 
      <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">說 
        明 </font></b></div>
    </td>
    <td width="38%" colspan="2" class="tablehead2"> 
      <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Applicant</font></b></div>
    </td>
    <td width="44%" colspan="2" class="tablehead2"> 
      <div align="center"><b><font face="Arial, Helvetica, sans-serif">Substitute</font></b></div>
    </td>
  </tr>
  <tr > 
    <td class="t1"> 
      <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Name/Group</font></b></div>
    </td>
    <td class="tablebody"> 
      <div align="center"><%=obj.getACname()%></div>
    </td>
    <td class="tablebody"> 
      <div align="center"><%=obj.getAGrps()%> </div>
    </td>
    <td class="tablebody"> 
      <div align="center"><%=obj.getRCname()%> </div>
    </td>
    <td class="tablebody"> 
      <div align="center"><%=obj.getRGrps()%> </div>
    </td>
  </tr>
  <tr > 
    <td class="t1"> 
      <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Empno/Serial</font></b></div>
    </td>
    <td class="tablebody"> 
      <div align="center"><%=obj.getAEmpno()%> </div>
    </td>
    <td class="tablebody"> 
      <div align="center"><%=obj.getASern()%> </div>
    </td>
    <td class="tablebody"> 
      <div align="center"><%=obj.getREmpno()%> </div>
    </td>
    <td class="tablebody"> 
      <div align="center"><%=obj.getRSern()%> </div>
    </td>
  </tr>
  <tr > 
    <td class="t1"> 
      <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Times</font></b></div>
    </td>
    <td colspan="2" class="tablebody"> 
      <div align="center"><%=obj.getAApplyTimes()%> </div>
    </td>
    <td colspan="2" class="tablebody"> 
      <div align="center"><%=obj.getRApplyTimes()%> </div>
    </td>
  </tr>
  <tr > 
    <td class="t1"> 
      <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Count</font></b></div>
    </td>
    <td colspan="2" class="tablebody"> 
      <div align="center"><%=obj.getAcount()%> </div>
    </td>
    <td colspan="2" class="tablebody"> 
      <div align="center"><%=obj.getRcount()%> </div>
    </td>
  </tr>
  <tr class="tablebody"> 
    <td class="t1"> 
      <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Qual</font></b></div>
    </td>
    <td colspan="2" class="tablebody"> 
      <div align="center"><%=obj.getAQual()%> </div>
    </td>
    <td colspan="2" class="tablebody"> 
      <div align="center"><%=obj.getRQual()%> </div>
    </td>
  </tr>
</table>
<br>

<table width="90%"  border="1" cellpadding="0" cellspacing="0" align="center">
  <tr > 
    <td colspan="4" class="tablehead2"> 
      <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Applicant</font></b></div>
    </td>
  </tr>
  <tr > 
    <td width="25%" class="tablehead2"> 
      <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">TripNo</font></b></div>
    </td>
    <td class="tablehead2"> 
      <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Flight 
        Date </font></b></div>
    </td>
    <td class="tablehead2"> 
      <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">FlightNo</font></b></div>
    </td>
    <td class="tablehead2"> 
      <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Fly 
        Hour </font></b></div>
    </td>
  </tr>
  <%
if(aSwapSkjAL != null){
	for(int i=0;i<aSwapSkjAL.size();i++){
		CrewSkjObj2 skjObj = (CrewSkjObj2)aSwapSkjAL.get(i);
		if("AL".equals(skjObj.getDutycode()))	
		{
			aALtimes++; 
		}
%>
  <tr > 
    <td class="tablebody"> 
      <div align="center"><%=skjObj.getTripno()%> </div>
    </td>
    <td class="tablebody"> 
      <div align="center"><%=skjObj.getFdate()%> </div>
    </td>
    <td class="tablebody"> 
      <div align="center"><%=skjObj.getDutycode()%> </div>
    </td>
    <td class="tablebody"> 
      <div align="center"><%=skjObj.getCr()%> </div>
    </td>
  </tr>
  <%
	}
}
%>
</table>
<br>
<table width="90%"  border="1" cellpadding="0" cellspacing="0" align="center">
  <tr> 
    <td colspan="4" class="tablehead2"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif">Substitute</font></div>
    </td>
  </tr>
  <tr> 
    <td width="25%" class="tablehead2"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif">TripNo</font></div>
    </td>
    <td class="tablehead2"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif">Flight Date 
        </font></div>
    </td>
    <td class="tablehead2"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif">FlightNo</font></div>
    </td>
    <td class="tablehead2"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif">Fly Hour </font></div>
    </td>
  </tr>
  <%
if(rSwapSkjAL != null){
	for(int i=0;i<rSwapSkjAL.size();i++){
		CrewSkjObj2 skjObj = (CrewSkjObj2)rSwapSkjAL.get(i);
		if("AL".equals(skjObj.getDutycode()))	
		{
			rALtimes++; 
		}
%>
  <tr > 
    <td class="tablebody"> 
      <div align="center"><%=skjObj.getTripno()%> </div>
    </td>
    <td class="tablebody"> 
      <div align="center"><%=skjObj.getFdate()%> </div>
    </td>
    <td class="tablebody"> 
      <div align="center"><%=skjObj.getDutycode()%> </div>
    </td>
    <td class="tablebody"> 
      <div align="center"><%=skjObj.getCr()%> </div>
    </td>
  </tr>
  <%
	}
}
%>
</table>

<br>
<table width="90%"  border="1" cellpadding="0" cellspacing="0" align="center">

  <tr> 
    <td width="23%" class="t1"> 
      <div align="center">互換班次之總飛時 </div>
    </td>
    <td class="txttitle"><b><font face="Arial, Helvetica, sans-serif" size="2">A 
      </font></b></td>
    <td class="tablebody"> 
      <div align="center"><%=obj.getASwapHr()%> </div>
    </td>
    <td class="txttitle"><b><font size="2">B </font></b></td>
    <td class="tablebody"> 
      <div align="center"><%=obj.getRSwapHr()%> </div>
    </td>
  </tr>
  <tr> 
    <td width="23%" class="t1"> 
      <p align="center">互換班次飛時差額        </p>
    </td>
    <td class="txttitle"><b><font face="Arial, Helvetica, sans-serif" size="2">A-B=X :
      </font></b></td>
    <td class="tablebody"> 
      <div align="center"><%=obj.getASwapDiff()%> </div>
    </td>
    <td class="txttitle"><b><font size="2">A-B=X :</font></b></td>
    <td class="tablebody"> 
      <div align="center"><%=obj.getRSwapDiff()%> </div>
    </td>
  </tr>
  <tr> 
    <td class="t1"> 
      <div align="center">Projected Credit Hour <br>
        換班前時數
      </div>
    </td>
    <td class="txttitle"><b><font face="Arial, Helvetica, sans-serif" size="2">Applicant:</font></b></td>
    <td class="tablebody"> 
      <div align="center"><%= obj.getAPrjcr()%> </div>
    </td>
    <td class="txttitle"><b><font size="2">Substitute:</font></b></td>
    <td class="tablebody"> 
      <div align="center"><%=  obj.getRPrjcr()%> </div>
    </td>
  </tr>
  <tr>
      <td width="23%" class="t1">
        <div align="center">放棄AL時數
		</div>
      </td>
      <td class="txttitle"><b><font face="Arial, Helvetica, sans-serif" size="2">AL</font></b></td>
      <td class="tablebody">-<%= df.format(200 * aALtimes)%>  </td>
      <td class="txttitle"><b><font face="Arial, Helvetica, sans-serif" size="2"></font>AL</b></td>
      <td class="tablebody">-<%= df.format(200 * rALtimes)%>  </td>
  </tr>
  <tr> 
    <td width="23%" class="t1"> 
      <div align="center">換班後時數</div>
    </td>
    <td width="15%" class="txttitle"><b><font face="Arial, Helvetica, sans-serif" size="2">C 
      ±X +AL=</font></b></td>
    <td width="20%" class="tablebody"> 
      <div align="center"><%=obj.getASwapCr()%> </div>
    </td>
    <td width="19%" class="txttitle"><b><font size="2">D ±X +AL=</font></b></td>
    <td width="23%" class="tablebody"> 
      <div align="center"><%=obj.getRSwapCr()%> </div>
    </td>
  </tr>
</table>
<br>
<table width="90%"  border="1" cellpadding="0" cellspacing="0" align="center">
  <tr> 
    <td width="23%" class="txtblue"> 
      <div align="left"><b>Crew Comments</b></div>
    </td>
    <td class="tablebody" colspan="3">
      <div align="left"><%=obj.getCrew_comm()%> </div>
    </td>
  </tr>
  <tr> 
    <td class="txtblue"><b>ED Confirm</b></td>
    <td width="15%" class="tablebody">
      <div align="left"><%=obj.getEd_check()%>&nbsp;</div>
    </td>
    <td width="13%" class="txtblue"><b>Confirm Date</b></td>
    <td width="49%" class="tablebody">
      <div align="left"><%=obj.getCheckdate()%>&nbsp;</div>
    </td>
  </tr>
  <tr>
    <td class="txtblue"> 
      <div align="left"><b>ED Comments</b></div>
    </td>
    <td class="tablebody" colspan="3">
      <div align="left"><%=obj.getComments()%>&nbsp;</div>
    </td>
  </tr>
</table>
<br>
<table width="90%"  border="1" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="23%" class="txtblue"> 
      <div align="left"><b>Check By EF</b></div>
    </td>
    <td width="77%" colspan="3" class="tablebody">
      <div align="left">&nbsp;</div>
    </td>
  </tr>
</table>

</body>
</html>
<% }
%>
<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,java.util.*,swap3ac.*"%>
<%
/*
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
*/
String aEmpno =  (String) session.getAttribute("aEmpno") ;//request.getParameter("aEmpno");
String rEmpno = request.getParameter("rEmpno");
String year = request.getParameter("year");
String month = request.getParameter("month");

swap3ac.ApplyCheck ac = new swap3ac.ApplyCheck(aEmpno,rEmpno,year,month);


if(ac.isUnCheckForm()){	//���ӽг�|���֥i�A���i�ӽ�
%>
<p style="color:red;text-align:center ">�ӽЪ�(<%=aEmpno%>)&nbsp;
			�γQ����(<%=rEmpno%>)&nbsp;���ӽг�|���gED�֥i, <br>		
�t�Τ����z����.</p>
<%
}else if (ac.getAApplyTimes() >=3 ){ // �ӽЪ̷��ӽЦ��ư���3���A���i�ӽ�
%>
<p style="color:red;text-align:center ">�ӽЪ�(<%=aEmpno%>)&nbsp; 
			���ӽЦ��Ƥw�W�L�T��, <br>		
			�t�Τ����z����.</p>
<%

}else if (ac.getRApplyTimes() >=3 ){ // �Q���̷��ӽЦ��ư���3���A���i�ӽ�
%>
<p style="color:red;text-align:center ">�Q����(<%=rEmpno%>)&nbsp; 
			���ӽЦ��Ƥw�W�L�T��, <br>		
			�t�Τ����z����.</p>
<%

}else if(ac.isALocked()){//�ӽЪ̯Z����w,(���`���p���Ӥ��|�o�͡A��w�̬ݤ��촫�Z���\��ﶵ)
%>
<p style="color:red;text-align:center ">�ӽЪ�(<%=rEmpno%>)&nbsp; 
			�Z����w���A, <br>		
			�t�Τ����z����.<br>
			�]���Z����ݳ]�w�Z���}�񪬺A,��i�ϥδ��Z�\��^.</p>
<%
}else if(ac.isRLocked()){//�Q���̯Z����w
%>
<p style="color:red;text-align:center ">�Q����(<%=rEmpno%>)&nbsp; 
			�Z����w���A, <br>		
			�t�Τ����z����.<br>
			�]���Z����ݳ]�w�Z���}�񪬺A,��i�ϥδ��Z�\��^.</p>
<%
}else if(aEmpno.equals(rEmpno)){
%>
<p style="color:red;text-align:center ">�Q����(<%=rEmpno%>)���u���L��!!</p>

<%
}


else{


String[] aSwapSkj = request.getParameterValues("aSwapSkj");//�ӽЪ̤Ŀ諸�Z
String[] rSwapSkj = request.getParameterValues("rSwapSkj");//�Q���̤Ŀ諸�Z
String comments = request.getParameter("comments");
String comm2 = request.getParameter("comm2");
String aCname = null;
String rCname = null;




CrewSwapSkj csk = new CrewSwapSkj(aEmpno, rEmpno, year, month);

CrewInfoObj aCrewInfoObj = null; //�ӽЪ̪��խ��ӤH���
CrewInfoObj rCrewInfoObj = null;//�Q���̪��խ��ӤH���
ArrayList commItemAL = null;
ArrayList aSwapSkjAL = null;
ArrayList rSwapSkjAL = null;


try {
	csk.SelectData();
	aCrewInfoObj =csk.getACrewInfoObj();
	rCrewInfoObj =csk.getRCrewInfoObj();		
	commItemAL = csk.getCommItemAL();
if(aCrewInfoObj != null){ 
	//aCname = new String(ci.tool.UnicodeStringParser.removeExtraEscape(
//			aCrewInfoObj.getCname()).getBytes(), "Big5");
aCname = aCrewInfoObj.getCname();
}

if(rCrewInfoObj != null){ 
//	rCname =new String(ci.tool.UnicodeStringParser.removeExtraEscape(
//			rCrewInfoObj.getCname()).getBytes(), "Big5");
rCname =rCrewInfoObj.getCname();
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
<title>�T�{�ӽЧ󴫤��Z��</title>
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
font-family:"�ө���";
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

function showPop(){
	newopen=window.open('../note.htm','note','height=250,width=500,top=100,left=200');

}

function disa(){
	document.form1.Send.disabled=1;
	document.form1.Cancel.disabled=1;
	return true;
}
</script>

</head>


<%

CalcSwapHrs cSHrs = new CalcSwapHrs();
if(!cSHrs.job(aCrewInfoObj,rCrewInfoObj,csk.getACrewSkjAL(),csk.getRCrewSkjAL(),aSwapSkj,rSwapSkj)){
	out.print("<body>�|����ܯZ��<br>");
}else{
	//out.print("�ӽЪ̴��e���ɡG"+aCrewInfoObj.getPrjcr()+"<br>�Q���̴��e���ɡG"+rCrewInfoObj.getPrjcr()+"<BR>");
	//out.print("�ӽЪ̴��᭸�ɡG"+cSHrs.getACrAfterSwap()+"<br>�Q���̴��᭸�ɡG"+cSHrs.getRCrAfterSwap()+"<BR>");
	
	aSwapSkjAL = cSHrs.getASwapSkjAL();
	rSwapSkjAL = cSHrs.getRSwapSkjAL();

	RetireSwapCheck sc = new RetireSwapCheck(aCrewInfoObj.getPrjcr(),rCrewInfoObj.getPrjcr(),
						cSHrs.getACrAfterSwap(),cSHrs.getRCrAfterSwap());
	sc.setEmploy(aEmpno,rEmpno);	
	if(!sc.isExchangeable()){	//���i���Z
%>
<body>
<div style="color:red;text-align:center;font-family:Verdana;font-size:10pt;background-color:#CCFFFF;padding:2pt;"><span style="color:#000000 "><br>
  �ӽд��Z���󤣲šA���i���Z�C��]���G</span><br>
  <%=sc.getErrorMsg()%><br>
  <a href="javascript:history.back(-1)" style="text-decoration:underline ">���s��ܧ󴫯Z��</a><br>
</div>
<%	

	}else{	// �ŦX���Z����

%>
<body onLoad="showPop()">
    <form name="form1" action="updSwapForm.jsp" method="post" onsubmit="return disa()">
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
        <div align="right"><a href="javascript:window.print()"> <img src="print.gif" width="17" height="15" border="0" alt="�C�L"></a> 
        </div>
      </td>
    </tr>
</table>
  <table width="90%"  border="1" cellpadding="1" cellspacing="0" align="center">
    <tr > 
      <td width="18%" class="tablehead2"> 
        <div align="center">�� �� </div>
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
      <td colspan="2" class="tablebody"><%=Integer.parseInt((String)session.getAttribute("aApplyTimes"))+1%> 
	  <input type="hidden" name="aApplyTimes" value="<%=Integer.parseInt((String)session.getAttribute("aApplyTimes"))+1%>">
      </td>
      <td colspan="2" class="tablebody"><%=Integer.parseInt((String)session.getAttribute("rApplyTimes"))+1%> 
	  <input type="hidden" name="rApplyTimes" value="<%=Integer.parseInt((String)session.getAttribute("rApplyTimes"))+1%>">
      </td>
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
	if(aSwapSkj != null){
		//for(int i=0;i<aSwapSkj.length;i++){
//			CrewSkjObj obj = (CrewSkjObj)aCrewSkjAL.get(Integer.parseInt(aSwapSkj[i]));
		for(int i=0;i<aSwapSkjAL.size();i++){
			CrewSkjObj obj = (CrewSkjObj)aSwapSkjAL.get(i);
	%>
    <tr > 
      <td class="tablebody"><%=obj.getTripno()%> 
        <input type="hidden" name="aTripno" value="<%=obj.getTripno()%>">
      </td>
      <td class="tablebody"><%=obj.getFdate()%> 
        <input type="hidden" name="aFdate" value="<%=obj.getFdate()%>">
      </td>
      <td class="tablebody"><%=obj.getDutycode()%> 
        <input type="hidden" name="aFltno" value="<%=obj.getDutycode()%>">
      </td>
      <td class="tablebody"><%=obj.getCr()%> 
        <input type="hidden" name="aFlyHrs" value="<%=obj.getCr()%>">
        <input type="hidden" name="aIdx" value="<%=i%>">
      </td>
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
      <td class="tablebody"><%=obj.getDutycode()%> 
        <input type="hidden" name="rFltno" value="<%=obj.getDutycode()%>">
      </td>
      <td class="tablebody"><%=obj.getCr()%> 
        <input type="hidden" name="rFlyHrs" value="<%=obj.getCr()%>">
		<input type="hidden" name="rIdx" value="<%=i%>">
      </td>
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
            <span class="b3">�����Z�����`����</span>
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
          <span class="b3">�����Z�����ɮt�B</span>          <br>
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
            <span class="b3">���Z�e�ɼ�</span> </div>
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
      <td width="41%" class="tablebody">
        <div align="center" class="b2">
          <div align="left">Total monthly flying Hours after Flight Exchange <br>
            <span class="b3">���Z��ɼ�</span> </div>
        </div>
      </td>
      <td width="11%" class="txttitle"><b>C ��X=</b></td>
      <td width="18%" class="tablebody"><%= cSHrs.getACrAfterSwap()%>
          <input type="hidden" name="aSwapCr" value="<%= cSHrs.getACrAfterSwap()%>">
      </td>
      <td width="12%" class="txttitle"><b>D ��X=</b></td>
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
<input type="hidden" name="year" value="<%=year%>">
<input type="hidden" name="month" value="<%=month%>">
    </form>
<%
	}//end of �i���Z
}//end of ����ܯZ��
%>
</body>
</html>
<%
}
%>
<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,java.util.*,swap3ackhh.*"%>
<%
/*
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
*/
String aEmpno =  request.getParameter("aEmpno");
String rEmpno = request.getParameter("rEmpno");
String year = request.getParameter("year");
String month = request.getParameter("month");




String[] aSwapSkj = request.getParameterValues("aSwapSkj");//�ӽЪ̤Ŀ諸�Z
String[] rSwapSkj = request.getParameterValues("rSwapSkj");//�Q���̤Ŀ諸�Z

String aCname = null;
String rCname = null;

//���o���Z����
swap3ackhh.ApplyCheck ac = new swap3ackhh.ApplyCheck(aEmpno,rEmpno,year,month);




CrewCrossCr csk = new CrewCrossCr(aEmpno, rEmpno, year, month);

CrewInfoObj aCrewInfoObj = null; //�ӽЪ̪��խ��ӤH���
CrewInfoObj rCrewInfoObj = null;//�Q���̪��խ��ӤH���

ArrayList aSwapSkjAL = null;
ArrayList rSwapSkjAL = null;


try {
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
<title>���Z���ɸպ�</title>
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

	SwapCheck sc = new SwapCheck(aCrewInfoObj.getPrjcr(),rCrewInfoObj.getPrjcr(),
						cSHrs.getACrAfterSwap(),cSHrs.getRCrAfterSwap());
	
	if(!sc.isExchangeable()){	//���i���Z
%>
<body>
<div style="color:red;text-align:center;font-family:Verdana;font-size:10pt;background-color:#CCFFFF;padding:2pt;"><span style="color:#000000 "><br>
  �Ŀ�պ�Z���A���ťӽд��Z����C��]���G</span><br>
  <%=sc.getErrorMsg()%><br>
  <a href="javascript:history.back(-1)" style="text-decoration:underline ">���s��ܸպ�Z��</a><br>
</div>
<%	

	}else{	// �ŦX���Z����
	

%>
<body > 
	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr> 
      <td width="3%" height="25">&nbsp;</td>
      <td width="94%">
        <div style="text-align:center;color:#003399;font-size:14pt;font-weight:bold;font-family:Verdana;">KHH ���Z���ɸպ�</div>   
      </td>
      <td width="3%">
        
      </td>
    </tr>
  </table>
<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr> 
      <td> 
        <div align="left" class="txtxred">�պ���:
          <%
		java.util.Date curDate = java.util.Calendar.getInstance().getTime();
		out.print(new java.text.SimpleDateFormat("yyyy/MM/dd EEE HH:mm:ss ",Locale.UK).format(curDate));
		%>
        </div>
      </td>
      <td width="5%">
        <div align="right"><a href="javascript:window.print()"> <img src="../images/print.gif" width="17" height="15" border="0" alt="�C�L"></a> 
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
	if(aSwapSkj != null){
		//for(int i=0;i<aSwapSkj.length;i++){
//			CrewSkjObj obj = (CrewSkjObj)aCrewSkjAL.get(Integer.parseInt(aSwapSkj[i]));
		for(int i=0;i<aSwapSkjAL.size();i++){
			CrewSkjObj obj = (CrewSkjObj)aSwapSkjAL.get(i);
	%>
    <tr > 
      <td class="tablebody"><%=obj.getTripno()%>      </td>
      <td class="tablebody"><%=obj.getFdate()%>      </td>
      <td class="tablebody"><%=obj.getDutycode()%>      </td>
      <td class="tablebody"><%=obj.getCr()%>      </td>
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
      <td class="tablebody"><%=obj.getCr()%>      </td>
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
      <td class="tablebody"><%=cSHrs.getASwapTotalCr()%>      </td>
      <td class="txttitle"><b>B </b></td>
      <td class="tablebody"><%=cSHrs.getRSwapTotalCr()%>      </td>
    </tr>
    <tr>
      <td width="41%" class="tablebody">
        <p align="left" class="b2">Flying Hour difference<br>
          <span class="b3">�����Z�����ɮt�B</span>          <br>
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
            <span class="b3">���Z�e�ɼ�</span> </div>
        </div>
      </td>
      <td class="txttitle"><b>Applicant:</b></td>
      <td class="tablebody"><%= aCrewInfoObj.getPrjcr()%>      </td>
      <td class="txttitle"><b>Substitute:</b></td>
      <td class="tablebody"><%= rCrewInfoObj.getPrjcr()%>      </td>
    </tr>
    <tr>
      <td width="41%" class="tablebody">
        <div align="center" class="b2">
          <div align="left">Total monthly flying Hours after Flight Exchange <br>
            <span class="b3">���Z��ɼ�</span> </div>
        </div>
      </td>
      <td width="11%" class="txttitle"><b>C ��X=</b></td>
      <td width="18%" class="tablebody"><%= cSHrs.getACrAfterSwap()%>      </td>
      <td width="12%" class="txttitle"><b>D ��X=</b></td>
      <td width="18%" class="tablebody"><%=cSHrs.getRCrAfterSwap()%>      </td>
    </tr>
  </table>
  
<br>
<div style="text-align:justify;font-family:Verdana;font-size:10pt;padding-left:150pt;width:500;color:#FF0000;padding-bottom:2pt;padding-top:2pt;margin-left:50pt;line-height:1.3" align="center">
**���G���\��ȴ��Ѵ��Z�e���ɸպ�A<br>
  ���ˬd���Z����O�_���ӽг�|���gKHHEF�B�z�A<br>
  �θӤ봫�Z���ƶW�L3�����o���Z�����p.</div>

  <%
	}//end of �i���Z
}//end of ����ܯZ��
%>
</body>
</html>
<%
//}
%>
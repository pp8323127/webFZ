<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,java.util.ArrayList"%>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 

String fdate 	= request.getParameter("fdate");
String stdDt 	= request.getParameter("stdDt");
if(null == stdDt || "".equals(stdDt)){
		stdDt = fdate + " 00:00";
		//out.println(stdDt);
}
//out.println(stdDt);
//���o���Z�~��
String GdYear = fz.pracP.GdYear.getGdYear(fdate);

String fltno 	= request.getParameter("fltno").trim();
String dpt 		= request.getParameter("dpt").trim();
String arv 		= request.getParameter("arv").trim();
 
String CA 		= request.getParameter("CA").trim();
String CAEmpno = request.getParameter("CAEmpno").trim();
String CACName = request.getParameter("CACName").trim();
String ShowPeople = request.getParameter("ShowPeople");
String total 	= request.getParameter("total");

String f = request.getParameter("f");//F���H��
String c = request.getParameter("c");//C���H��
String y = request.getParameter("y");//C���H��

String acno 	= request.getParameter("acno").trim();
String fleet 	= request.getParameter("fleet");

String[] cname	= request.getParameterValues("cname");
String[] ename 	= request.getParameterValues("ename");
String[] empno 	= request.getParameterValues("empno");


String[] sern	= request.getParameterValues("sern");
String[] scoreShow	= {"X","1","2","3","4","5","6","7","8","9","10"};
String[] score	= {"0","1","2","3","4","5","6","7","8","9","10"};
String[] occu 	= request.getParameterValues("occu");
String[] lshiftShow = {"X","1","2","3","4"};
String[] lshift = {"0","1","2","3","4"};
int shiftTime = 4;
String bcolor="";
//String fontcolor = "";




//purser��empno,sern,name,group
String purserEmpno	= request.getParameter("purserEmpno");
String psrsern		= request.getParameter("psrsern");
String psrname		= request.getParameter("psrname");
String pgroups   	= request.getParameter("pgroups");
String mp_empn		= request.getParameter("mp_empn");
String mpname 		= request.getParameter("mpname");

if(mpname == null) mpname = "";
if(mp_empn == null) mp_empn="";
//out.print(purserEmpno+"<HR>"+psrsern+"<HR>"+psrname+"<HR>"+pgroups+"<HR>");


%> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>�s��ȿ����i</title>
<link href="style2.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" media="all" type="text/css" href="jquery-ui-timepicker-addon.css" />
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
<script type="text/javascript" src="jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="jquery-ui-sliderAccess.js"></script>
<script src="changeAction.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript">
$(function(){
	var shiftTimes = 4;
	for(var i=0; i<shiftTimes; i++){
		$('#shst'+(i+1)).datetimepicker({
		controlType: 'select',
		dateFormat: 'yy/mm/dd',
		timeFormat: 'HH:mm'
		});
		$('#shet'+(i+1)).datetimepicker({
		controlType: 'select',
		dateFormat: 'yy/mm/dd',
		timeFormat: 'HH:mm'
		});
	}
});
function disableSubmit()
{
	var temp_f = document.form1.f.value;
	var temp_c = document.form1.c.value;
	var temp_y = document.form1.y.value;
	var temp_inf = document.form1.inf.value;
	var temp_ttl = parseInt(temp_f)+parseInt(temp_c)+parseInt(temp_y)+parseInt(temp_inf);
	var odnum = 0;
	for(var i=0; i<document.form1.duty.length; i++)
	{
		if(document.form1.duty[i].value =="OD")
		{
			odnum++;
		}
	}

	if(parseInt(temp_ttl) <=0 && odnum <=0)
	{
		 alert("�п�J��ڮȫȤH��!!\n�Y��Ferry Flt,�п�ܥ��u�խ�(Duty code OD).");
		 document.form1.f.focus();
		 return false;
	} 
	else if(parseInt(temp_ttl) <=0 && odnum != 2 )
	{
		 alert("�п�J��ڮȫȤH��!!\n�Y��Ferry Flt,�ݿ�ܨ�쥴�u�խ�(Duty code OD).");
		 document.form1.f.focus();
		 return false;
	}
	else if(!document.form1.shY.checked && !document.form1.shN.checked)
	{
		alert("�п�ܥ��Z���O�_����");
		return false;
	}
	else
	{
		var a = checkTime();
		if(a){
			a = checkShCrew();
			if(a){
				a = checkOneBa();
				document.form1.GiveComments.disabled=1;
				document.form1.delButton.disabled=1;
			}			
		}
		return a;
	}
}
function checkNUM(col){
	eval("data = document.form1."+col+".value.match(/[^0-9]/g);");
	if(data)
	{
		alert("�����u���J�b�μƦr");
		eval("document.form1."+col+".value='';");
		return false;
	}
	else
	{
		var temp_f = document.form1.f.value;
		var temp_c = document.form1.c.value;
		var temp_y = document.form1.y.value;
		var temp_inf = document.form1.inf.value;
		document.form1.ttl.value = parseInt(temp_f)+parseInt(temp_c)+parseInt(temp_y)+parseInt(temp_inf);
		return true;
	}
}

function checkOneBa()
{
	var cnt = 0;
	for(var i=0; i<document.form1.ba.length; i++){
		if(document.getElementById("ba["+i+"]").checked){
			cnt ++;
		}
	}
	if(cnt >= 2){
		alert("�C�ӯ�q�̨ΪA���u�i��@��C");
		return false;
	}else{
		return true;
	}
}

function showSh(flag)
{
	if("1" == flag)
	{	//Y�ݶ�g���Z detail
		var time = document.getElementById("stdDt").value ;		
		document.getElementById("shRec").style.display="";
		document.form1.shst1.value = time;
		document.form1.shet1.value = time;
		document.form1.shst2.value = time;
		document.form1.shet2.value = time;
		/*document.form1.shst3.value = time;
		document.form1.shet3.value = time;
		document.form1.shst4.value = time;
		document.form1.shet4.value = time;*/
	}
	else
	{	//N���ݶ�g
		document.getElementById("shRec").style.display="none";
		document.form1.shst1.value = "";
		document.form1.shet1.value = "";
		document.form1.shst2.value = "";
		document.form1.shet2.value = "";
		document.form1.shst3.value = "";
		document.form1.shet3.value = "";
		document.form1.shst4.value = "";
		document.form1.shet4.value = "";		
		document.form1.sh_cm.value = "0";
		document.form1.sh_mp.value = "0";	
	}
}

function checkTime(){
	//alert("YES");
	var shiftTimes = 4;
	var s = new Array(shiftTimes);
	var e = new Array(shiftTimes);
	var sD = new Array(shiftTimes);
	var eD = new Array(shiftTimes);
	var fdate = document.getElementById("fdate").value;
	var fdateD = new Date(fdate);
	var flag = false;
	for(var i=0; i<shiftTimes; i++){
		//alert(document.getElementById("shst"+(i+1)).value);
		s[i] = document.getElementById("shst"+(i+1)).value;
		e[i] = document.getElementById("shet"+(i+1)).value;
		sD[i] = new Date(s[i]);
		eD[i] = new Date(e[i]);
			
	}
	//1~2�q���ˮ�
	for(var i=0; i<shiftTimes-2; i++){
		if(document.form1.shY.checked && (s[i] == "" || e[i] == "" )){
			alert("����ɶ����i�ť�");
			flag = false;
			break;
		}else if (sD[i] < fdateD){
			alert("�}�l�ɶ����i�����Z���");
			flag = flase;
			break;
		}else if((eD[i] < sD[i])){
			alert("����}�l�ɶ����~");
			flag = false;
			break;
		}else if((eD[i]-sD[i]) <0 ){
			alert("��ܿ��~,�`�ɶ����i���t��");
			flag = false;
			break;
		}else if(((eD[i]-sD[i])/60/60/1000) >=6){
			alert("��ܿ��~,�`��ɤ��i�W�L6�p��");
			flag = false;
			break;
		}else{
			flag = true;
		}
	}
	for(var i=2; i<shiftTimes; i++){
		if(document.form1.shY.checked && (!s[i] == "" || !e[i] == "" )){
			if((!s[i] == "" && e[i] == "") || (s[i] == "" && !e[i] == "")){
				alert("��"+[i+1]+"�q�Y������ɶ��ݶ�_��");
				flag = false;
				break;
			}else if (sD[i] < fdateD){
				alert("�}�l�ɶ����i�����Z���");
				flag = flase;
				break;
			}else if((eD[i] < sD[i])){
				alert("����}�l�ɶ����~");
				flag = false;
				break;
			}else if((eD[i]-sD[i]) <0 ){
				alert("��ܿ��~,�`�ɶ����i���t��");
				flag = false;
				break;
			}else if(((eD[i]-sD[i])/60/60/1000) >=6){
					alert("��ܿ��~,�`��ɤ��i�W�L6�p��");
				flag = false;
				break;
			}else{
				flag = true;
			}				
		}else{
			flag = true;
		}
	}
	return flag;
	//�ܤֶ�@�q����
	/*if( (s1 != "" && e1!="" ) || (s2 != "" && e2!="" ) 	
	|| (!document.form1.shY.checked &&  s1 == "" && e1==""  && s2 == "" && e2=="" ) ){
	
		if (sD1 < fdateD | sD2 < fdateD){
			alert("�}�l�ɶ����i�����Z���");
			return false;
		}else if(eD1 <= sD1 | eD2 <= sD2 ){
			alert("�����ɶ��ݤj��}�l�ɶ�");
			return false;
		}else if((eD1 <= sD1) || (eD2 <= sD2)){
			alert("����}�l�ɶ����~");
			return false;
		//}else if(sD2 < eD1){
		//	alert("�ĤG�q����}�l�ɶ����~");
		//	return false;
		}else if((eD1-sD1) <=0 || (eD2-sD2)<=0 ){
			alert("��ܿ��~,�`�ɶ����i���t��");
			return false;
		}else if(((eD1-sD1)/60/60/1000) >=6 || ((eD2-sD2)/60/60/1000) >=6 ){
			alert("��ܿ��~,�`��ɤ��i�W�L6�p��");
			return false;
		}else{
			return true;
		}
	}else{
		alert("�Y������п�ܮɶ�");
		return false;
	}*/
}

function checkShCrew(){
	if(document.form1.shY.checked){
		if(document.getElementById("sh_cm").value == "0"){
			alert("�п��CM����覸");
			return false;
		}
		for(var i=0; i<document.form1.sh_crew.length; i++){
			if((document.getElementById("sh_crew["+i+"]").value == "X" | document.getElementById("sh_crew["+i+"]").value == "0")&& (document.getElementById("duty["+i+"]").value != "X")){
				alert("�п��Crew����覸");
				return false;
			}
		}		
		if(document.getElementById("sh_mp").value == "0"){
			alert("�п��MP����覸");
			return false;
		}
	}else{
		return true;
	}
}
</script>
</head>
<body onload="javascript:alert('�C�@��q����A�i�����PPA �խ��F��{�i�ҥΦܤT�W�C');">
<%
//modify by cs66 at 2005/02/17 �ˬd�խ��H��
if(empno.length >20){
%>
<script language="javascript">
	alert("�խ��H�ƶW�L20�H�A�ЧR��ACM�խ�");
	self.location = "javascript:history.back(-2)";
</script>
<%

}else{


%>
  <form name="form1" method="post" action="edReportComm.jsp" target="_self" onSubmit="return disableSubmit();">
    <table width="579" border="0" cellpadding="0" cellspacing="0" align="center">
      <tr>
        <td colspan="3" valign="middle">
          <div align="center" class="txtred"></div>
          <span class="txtblue">Cabin  Report&nbsp; &nbsp;</span><span class="purple_txt"><strong> Step2.To score each crew and modify number of passengers</strong></span></td>
      </tr>
      <tr>
        <td colspan="2" valign="middle" class="txtblue"> FDate:<span class="txtred"><%=fdate%>&nbsp;</span>&nbsp;Fltno:<span class="txtred"><%=fltno%>&nbsp;&nbsp;</span>Sector:<span class="txtred"><%=dpt%><%=arv%></span>&nbsp;Fleet:<span class="txtred"><%=fleet%></span> </td>
        <td width="56" valign="middle">&nbsp;</td>
      </tr>
      <tr>
        <td colspan="2" valign="middle" class="txtblue">Cabin Manager:<span class="txtred"><%=psrname%>&nbsp;<%=psrsern%>&nbsp;<%=purserEmpno%></span>&nbsp;
        CA&nbsp;:<span class="txtred"><%=CA%></span>
        <%if(null != mp_empn && !"".equals(mp_empn)){ %>
        <br>MP:&nbsp;<span class="txtred"><%=mpname%>&nbsp;<%=mp_empn %>&nbsp;</span>
        <%} %>
        </td>
        <td valign="middle">&nbsp;</td>
        
      </tr>
      <tr>
        <td width="381" valign="middle"  class="txtblue">A/C:<span class="txtred">
          <input type="text" name="acno" value="<%=acno%>" size="5" maxlength="5">
        </span></td>
        <td width="142" valign="middle">&nbsp; </td>
        <td valign="middle" align="right"></td>
      </tr>
      <tr>
        <td valign="middle"  class="txtblue"> F:
            <input type="text" name="f" size="3"  value="<%=f%>" onkeyup="return checkNUM('f')" >
C:
<input type="text" name="c" size="3" value="<%=c%>"   onkeyup="return checkNUM('c')" >
Y:
<input type="text" name="y" size="3" value="<%=y%>"   onkeyup="return checkNUM('y')" >
INF:
<input type="text" name="inf" size="3"  value="0" onkeyup="return checkNUM('inf')" >
&nbsp; Pax:<input type="text" class="txtred" name="ttl" id="ttl" style="background-color:<%=bcolor%> ;border:0pt" tabindex="999" value="<%=ShowPeople%>" readonly></td>
        <td valign="middle"><span class="txtred">GradeYear�G<%=GdYear%></span></td>
        <td valign="middle" align="right"><a href="javascript:window.print()"><img src="../images/print.gif" width="17" height="15" border="0" alt="�C�L"></a></td>
      </tr>
    </table>
	<!-- ************************************ -->
<div align="center">
<fieldset style="width:80%; border-color: #FF0000;"  >
<legend class="txttitletop2">Crew Shift Records</legend>
	<table align="center"  width="90%">
	<tr>  
	  <td align="left"><span class="txtxred">���Z���O�_�������G
	      <label>
	      	<input type="radio" name="shift" value="Y"  onClick="showSh(1);" id="shY">
	      	<span class="txtxred">Yes</span>
	      </label>
	      <label>
	      	<input type="radio" name="shift" value="N" onClick="showSh(2);" id="shN">
	      	<span class="txtblue">No</span>
	      </label>
		  </span>
		  <span id="shNote" class="txtblue">Notes:
			<input type="text" name="shreason" maxlength="2000" size="50" id="shreason" >
		  </span>
		  
		  <span style="display:none " id="shRec" class="txtxred" ><br>
		  <% for(int i=0;i<shiftTime;i++){ %>
		  	<span class="txtblue">��<%=i+1%>������ɶ�--�}�l�G</span>
		  	<input name="shst<%=i+1%>" id="shst<%=i+1%>" type="text" size="20" maxlength="20" class="txtblue" readonly="true"> 			
		  	<span class="txtblue">~�����G
		 	<input name="shet<%=i+1%>" id="shet<%=i+1%>" type="text" size="20" maxlength="20" class="txtblue" readonly="true">
		 	</span>
			<br>		
		  <% } %> 
		  <span class="txtblue">CM����覸�G</span>
		  <select name="sh_cm" id="sh_cm">
          <%  	  	for(int j=0;j<=shiftTime;j++){	  %>
          <option value="<%=lshift[j]%>"><%=lshiftShow[j]%></option>
          <%		}	  					  %>
        </select>
		<br>
		<%if(null != mp_empn && !"".equals(mp_empn) ){ %>
		<span class="txtblue">MP����覸�G</span>
		  <select name="sh_mp" id="sh_mp">
         <%  	  	for(int j=0;j<=shiftTime;j++){	  %>
          <option value="<%=lshift[j]%>"><%=lshiftShow[j]%></option>
         <%}	  	
         }				 
         %>
        </select>
		</span>
	  </td>
	</tr>	
</table>
</fieldset>
</div>    
<!-- ************************************ -->    
<br>    
    <table width="604"  border="0" align="center" cellpadding="2" cellspacing="0" >
    <tr class="tablehead3">
      <td width="86">Name</td>
      <td width="212">EName</td>
      <td width="47">Sern</td>
      <td width="68">Empno</td>
      <td width="49">Duty</td>
      <td width="39">Score</td>
      <td width="75">�̨ΪA��</td>
      <td width="75">�̨ΪA��</td>
      <td width="75">����覸</td>
    </tr>
	<%


for(int i=0;i<empno.length;i++){

		if (i%2 == 0){
			bcolor = "#99CCFF";
		}
		else{
			bcolor = "#FFFFFF";
		}		
%>
  <tr bgcolor="<%=bcolor%>">
      <td class="tablebody">
	  <input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="12" value="<%=cname[i]%>" name="cname" tabindex="999">
	  </td>
      <td class="tablebody">
        <div align="left">
		<input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="30" value="<%=ename[i]%>" name="ename" tabindex="999">
        </div>
      </td>
      <td class="tablebody">
	  <input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="6" value="<%=sern[i]%>" name="sern"  tabindex="999"> </td>
      <td class="tablebody"><input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="6" value="<%=empno[i]%>" name="empno" tabindex="999"> </td>
      <td class="tablebody">
	  	<select name="duty"  tabindex="<%=(1+i)%>" id="duty[<%=i%>]">
			<jsp:include page="purDuty.htm"/>
		</select>
	  </td>
      <td class="tablebody">
        <select name="score"  tabindex="<%=(51+i)%>">
          <%  	  	for(int j=0;j<=10;j++){	  %>
          <option value="<%=score[j]%>"><%=scoreShow[j]%></option>
          <%		}	  					  %>
        </select>
</td>
      <td class="tablebody">
        <input type="checkbox" name="gs" value="<%=empno[i]+sern[i]%>">
      </td>
      <td class="tablebody">
        <input type="checkbox" name="ba" value="<%=empno[i]+sern[i]%>" id = "ba[<%=i %>]"  onclick="checkOneBa();">
      </td>
      <td class="tablebody">
	  	<select name="sh_crew"  tabindex="<%=(1+i)%>" id="sh_crew[<%=i%>]">
          <%  	  	for(int j=0;j<=4;j++){	  %>
          <option value="<%=lshift[j]%>"><%=lshiftShow[j]%></option>
          <%		}	  					  %>
        </select>
	  </td>
  </tr>
  <%
	}
%>	
  </table>
  <table width="604" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td width="10">&nbsp;</td>
      <td width="148">
        <div align="left" class="txtblue">Total:<%=total%>        </div>
      </td>
      <td width="353"><span class="txttitletop">
        <input name="GiveComments" type="submit" class="addButton" value="Save ( Next ) " tabindex="<%=(total+2)%>">
        &nbsp;&nbsp;&nbsp;
        
&nbsp;&nbsp;&nbsp;
<input type="button" name="back" value="   Back  " onClick="javascript:history.back(-1)">  
&nbsp;&nbsp;&nbsp;  
<input type="reset" name="reset" value="Reset" onclick="document.form1.GiveComments.disabled=0;	">
<span class="txtblue">
	<input type="hidden" name="dpt" id="dpt" value="<%=dpt%>">
	<input type="hidden" name="arv" id="arv" value="<%=arv%>">
	<input type="hidden" name="fltno" id="fltno" value="<%=fltno%>">
	<input type="hidden" name="fdate" id="fdate" value="<%=fdate%>">
	<input type="hidden" name="stdDt" id="stdDt" value="<%=stdDt%>">
	<input type="hidden" name="CA" id="CA" value="<%=CA%>">
	<input type="hidden" name="ShowPeople" id="ShowPeople" value="<%=ShowPeople%>">
	<input type="hidden" name="CACName" id="CACName" value="<%=CACName%>">
	<input type="hidden" name="CAEmpno" id="CAEmpno" value="<%=CAEmpno%>"> 
	<input type="hidden" name="purserEmpno"  id="purserEmpno" value="<%=purserEmpno%>">
	<input type="hidden" name="psrsern" id="psrsern" value="<%=psrsern%>">
	<input type="hidden" name="psrname" id="psrname" value="<%=psrname%>">
	<input type="hidden" name="pgroups" id="pgroups" value="<%=pgroups%>">
	<input type="hidden" name="total" id="total" value="<%=total%>">
	<input type="hidden" name="GdYear" id="GdYear" value="<%=GdYear%>">		
	<input type="hidden" name="fleet" id="fleet" value="<%=fleet%>">		
	<input type="hidden" name="mp_empn" id="mp_empn" value="<%=mp_empn%>">
	<input type="hidden" name="mpname" id="mpname" value="<%=mpname%>">
</span></td>
			<!--ZC-->
		<%
			eg.zcrpt.ZCReport zcrt = new eg.zcrpt.ZCReport();
			zcrt.getZCFltListForPR(fdate,fltno,dpt+arv,purserEmpno);
			ArrayList zcAL = zcrt.getObjAL();
			if(zcAL.size()>0)
			{
				eg.zcrpt.ZCReportObj zcobj = (eg.zcrpt.ZCReportObj) zcAL.get(0);
				if("Y".equals(zcobj.getIfsent()))
				{//�w�e�X
			  
		%>
			  <td>
				<input type="button" name="viewzc" value="PR Report" class="bu" Onclick="javascript:window.open ('ZC/ZCreport_print.jsp?idx=0&fdate=<%=fdate%>&fltno=<%=fltno%>&port=<%=dpt%><%=arv%>&purempn=<%=purserEmpno%>','zcreport','height=800, width=800, toolbar=no, menubar=no, scrollbars=yes, resizable=yes');" >
			  </td>
		<%
				}//�w�e�Xif("Y".equals(zcobj.getIfsent()))
			}//if(zcAL.size()>0)			
		%>
			<!--ZC-->
    </tr>
</table>
</form>
<%
}
%>
</body>
</html>

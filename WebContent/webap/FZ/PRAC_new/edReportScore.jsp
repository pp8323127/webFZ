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
//取得考績年度
String GdYear = fz.pracP.GdYear.getGdYear(fdate);

String fltno 	= request.getParameter("fltno").trim();
String dpt 		= request.getParameter("dpt").trim();
String arv 		= request.getParameter("arv").trim();
 
String CA 		= request.getParameter("CA").trim();
String CAEmpno = request.getParameter("CAEmpno").trim();
String CACName = request.getParameter("CACName").trim();
String ShowPeople = request.getParameter("ShowPeople");
String total 	= request.getParameter("total");

String f = request.getParameter("f");//F艙人數
String c = request.getParameter("c");//C艙人數
String y = request.getParameter("y");//C艙人數

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




//purser的empno,sern,name,group
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
<title>編輯客艙報告</title>
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
		 alert("請輸入實際旅客人數!!\n若為Ferry Flt,請選擇打工組員(Duty code OD).");
		 document.form1.f.focus();
		 return false;
	} 
	else if(parseInt(temp_ttl) <=0 && odnum != 2 )
	{
		 alert("請輸入實際旅客人數!!\n若為Ferry Flt,需選擇兩位打工組員(Duty code OD).");
		 document.form1.f.focus();
		 return false;
	}
	else if(!document.form1.shY.checked && !document.form1.shN.checked)
	{
		alert("請選擇本班次是否輪休");
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
		alert("本欄位只能輸入半形數字");
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
		alert("每個航段最佳服儀只可選一位。");
		return false;
	}else{
		return true;
	}
}

function showSh(flag)
{
	if("1" == flag)
	{	//Y需填寫輪班 detail
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
	{	//N不需填寫
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
	//1~2段全檢核
	for(var i=0; i<shiftTimes-2; i++){
		if(document.form1.shY.checked && (s[i] == "" || e[i] == "" )){
			alert("輪休時間不可空白");
			flag = false;
			break;
		}else if (sD[i] < fdateD){
			alert("開始時間不可早於航班日期");
			flag = flase;
			break;
		}else if((eD[i] < sD[i])){
			alert("輪休開始時間錯誤");
			flag = false;
			break;
		}else if((eD[i]-sD[i]) <0 ){
			alert("選擇錯誤,總時間不可為負值");
			flag = false;
			break;
		}else if(((eD[i]-sD[i])/60/60/1000) >=6){
			alert("選擇錯誤,總休時不可超過6小時");
			flag = false;
			break;
		}else{
			flag = true;
		}
	}
	for(var i=2; i<shiftTimes; i++){
		if(document.form1.shY.checked && (!s[i] == "" || !e[i] == "" )){
			if((!s[i] == "" && e[i] == "") || (s[i] == "" && !e[i] == "")){
				alert("第"+[i+1]+"段若有輪休時間需填起迄");
				flag = false;
				break;
			}else if (sD[i] < fdateD){
				alert("開始時間不可早於航班日期");
				flag = flase;
				break;
			}else if((eD[i] < sD[i])){
				alert("輪休開始時間錯誤");
				flag = false;
				break;
			}else if((eD[i]-sD[i]) <0 ){
				alert("選擇錯誤,總時間不可為負值");
				flag = false;
				break;
			}else if(((eD[i]-sD[i])/60/60/1000) >=6){
					alert("選擇錯誤,總休時不可超過6小時");
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
	//至少填一段輪休
	/*if( (s1 != "" && e1!="" ) || (s2 != "" && e2!="" ) 	
	|| (!document.form1.shY.checked &&  s1 == "" && e1==""  && s2 == "" && e2=="" ) ){
	
		if (sD1 < fdateD | sD2 < fdateD){
			alert("開始時間不可早於航班日期");
			return false;
		}else if(eD1 <= sD1 | eD2 <= sD2 ){
			alert("結束時間需大於開始時間");
			return false;
		}else if((eD1 <= sD1) || (eD2 <= sD2)){
			alert("輪休開始時間錯誤");
			return false;
		//}else if(sD2 < eD1){
		//	alert("第二段輪休開始時間錯誤");
		//	return false;
		}else if((eD1-sD1) <=0 || (eD2-sD2)<=0 ){
			alert("選擇錯誤,總時間不可為負值");
			return false;
		}else if(((eD1-sD1)/60/60/1000) >=6 || ((eD2-sD2)/60/60/1000) >=6 ){
			alert("選擇錯誤,總休時不可超過6小時");
			return false;
		}else{
			return true;
		}
	}else{
		alert("若有輪休請選擇時間");
		return false;
	}*/
}

function checkShCrew(){
	if(document.form1.shY.checked){
		if(document.getElementById("sh_cm").value == "0"){
			alert("請選擇CM輪休梯次");
			return false;
		}
		for(var i=0; i<document.form1.sh_crew.length; i++){
			if((document.getElementById("sh_crew["+i+"]").value == "X" | document.getElementById("sh_crew["+i+"]").value == "0")&& (document.getElementById("duty["+i+"]").value != "X")){
				alert("請選擇Crew輪休梯次");
				return false;
			}
		}		
		if(document.getElementById("sh_mp").value == "0"){
			alert("請選擇MP輪休梯次");
			return false;
		}
	}else{
		return true;
	}
}
</script>
</head>
<body onload="javascript:alert('每一航段往返，可有不同PA 組員；單程可啟用至三名。');">
<%
//modify by cs66 at 2005/02/17 檢查組員人數
if(empno.length >20){
%>
<script language="javascript">
	alert("組員人數超過20人，請刪除ACM組員");
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
        <td valign="middle"><span class="txtred">GradeYear：<%=GdYear%></span></td>
        <td valign="middle" align="right"><a href="javascript:window.print()"><img src="../images/print.gif" width="17" height="15" border="0" alt="列印"></a></td>
      </tr>
    </table>
	<!-- ************************************ -->
<div align="center">
<fieldset style="width:80%; border-color: #FF0000;"  >
<legend class="txttitletop2">Crew Shift Records</legend>
	<table align="center"  width="90%">
	<tr>  
	  <td align="left"><span class="txtxred">本班次是否執行輪休：
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
		  	<span class="txtblue">第<%=i+1%>次輪休時間--開始：</span>
		  	<input name="shst<%=i+1%>" id="shst<%=i+1%>" type="text" size="20" maxlength="20" class="txtblue" readonly="true"> 			
		  	<span class="txtblue">~結束：
		 	<input name="shet<%=i+1%>" id="shet<%=i+1%>" type="text" size="20" maxlength="20" class="txtblue" readonly="true">
		 	</span>
			<br>		
		  <% } %> 
		  <span class="txtblue">CM輪休梯次：</span>
		  <select name="sh_cm" id="sh_cm">
          <%  	  	for(int j=0;j<=shiftTime;j++){	  %>
          <option value="<%=lshift[j]%>"><%=lshiftShow[j]%></option>
          <%		}	  					  %>
        </select>
		<br>
		<%if(null != mp_empn && !"".equals(mp_empn) ){ %>
		<span class="txtblue">MP輪休梯次：</span>
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
      <td width="75">最佳服務</td>
      <td width="75">最佳服儀</td>
      <td width="75">輪休梯次</td>
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
				{//已送出
			  
		%>
			  <td>
				<input type="button" name="viewzc" value="PR Report" class="bu" Onclick="javascript:window.open ('ZC/ZCreport_print.jsp?idx=0&fdate=<%=fdate%>&fltno=<%=fltno%>&port=<%=dpt%><%=arv%>&purempn=<%=purserEmpno%>','zcreport','height=800, width=800, toolbar=no, menubar=no, scrollbars=yes, resizable=yes');" >
			  </td>
		<%
				}//已送出if("Y".equals(zcobj.getIfsent()))
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


<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="eg.off.*, eg.*,java.util.*,fz.chkUserSession"%>
<%
response.setHeader("Pragma","no-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0); //prevents caching at the proxy server

String userid = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || userid == null) 
{		//check user session start first
	response.sendRedirect("../login.jsp");
} 
/************************/
String sessStatus = (String) session.getAttribute("sessStatus");//get dbsession 
chkUserSession sess = new chkUserSession();
//out.println(sessStatus);
//out.println(sess.chkUserSess(userid, sessStatus));
if(!sess.chkUserSess(userid, sessStatus)){//��LPC���s���ۦPuser�n�J,�簣���s�u
	%>
		<script language="javascript" type="text/javascript">
		alert('�z�w�b��L��m�n�J,���b���N�Q�n�X!');
		top.location.href="../login.jsp";
//		window.location.href="../login.jsp";	
		</script>
	<%
}
/************************/
String bc = "";
GregorianCalendar cal = new GregorianCalendar(); 
String gdyear = Integer.toString(cal.get(Calendar.YEAR));
int undeduct = 0;
boolean hasdelete = false;
//***************************************
OffRecordList orl = new OffRecordList();
orl.getOffRecord(userid,"ALL",gdyear);
//out.println(orl.getSQL());
ArrayList objAL = new ArrayList();
objAL = orl.getObjAL();
undeduct = orl.getALUndeduct(userid);
//out.println(orl.getSQL());
//***************************************
ALPeriod oys = new ALPeriod();      
oys.getALPeriod(userid);
ArrayList alperiodAL = oys.getObjAL();
//***************************************
EGInfo egi = new EGInfo(userid);
ArrayList objAL2 = new ArrayList();
objAL2 = egi.getObjAL();
EgInfoObj obj2 = new EgInfoObj();
if(objAL2.size()>0)
{
	obj2 = (EgInfoObj) objAL2.get(0);
}       
//***************************************
OffType offtype = new OffType();
offtype.offData();
//***************************************
int sheetNum = 6;//������ƶq
int sheetCount =0;
%>
<html>
<head>
<script language="JavaScript">
var sheetNum = eval("document.form1.sheetNum.value");
function getCalendar(obj)
{    
	eval("wincal=window.open('../Calendar.htm','" + obj +"','width=350,height=200')");
}

function getDays(para)
{
	var sDate1 = eval("document.form1.validfrm_"+para+".value");// sDate1 format"2002/01/10"
	var sDate2 = eval("document.form1.validto_"+para+".value");
	var iDays;
	if((sDate1 == "" || sDate2 == "") && document.form1.validfrm_1.value == "" && document.form1.validto_1.value == "")//�ܤ֭n��@�i��
	{
		alert("Please select the off-date period !!");
		return;
	}

	if(sDate1 > sDate2 )
	{
		alert("Please check the off-date period !!");
		return;
	}
	
	//alert("getYear "+Number(sDate1.substring(0,4)) );
	//alert("getMonth "+Number(sDate1.substring(5,7)) );
	//alert("getDate "+Number(sDate1.substring(8,10)) );
	fday = new Date(Number(sDate1.substring(0,4)),Number(sDate1.substring(5,7))-1,Number(sDate1.substring(8,10)));//Date(2011,9,1)
	tday = new Date(Number(sDate2.substring(0,4)),Number(sDate2.substring(5,7))-1,Number(sDate2.substring(8,10)));
	dayms = 24*60*60*1000;
	if(sDate1 != "" && sDate2 != "") {
		iDays = Math.floor((tday.getTime()-fday.getTime())/dayms)+1;
	}else{
		iDays = 0;
	}
	
	//��ۮt���@���ഫ���Ѽ� 
	document.form1.elements["tdays_"+para].value =  iDays;
	//document.form1.tdays.value = iDays;
	//document.form1.totdays.value = iDays;
	
	if(iDays > 6){
		alert("��AL���i�W�L�s�򤻤�!");
		return false;
	}
	
	
	if(sDate1.substr(0,4)!= sDate2.substr(0,4))
	{
		alert("��~����Ф��}�ӽ�!!");
	}

	var off_type = document.form1.off_type.value;

	if(off_type=="16" && sDate2>"2011/12/31")
	{
		alert("XL�B�~���Ұ��ϥδ����Ȧ�2011/12/31!!");
	}
	
	var temp_tdays = eval("document.form1.tdays_"+para+".value");
	if(off_type=="16" &&  temp_tdays != "3")
	{
		alert("XL�B�~���Ұ��ݤ@���ϥΧ���!!");
	}
	
}

function f_submit()
{  
	document.form1.Submit.disabled=1;	
	for(var i=1;i<=sheetNum;i++){
		var sDate1 = eval("document.form1.validfrm_"+i+".value");// sDate1 format"2002/01/10"
		var sDate2 = eval("document.form1.validto_"+i+".value");
		var iDays;

		if((sDate1 == "" || sDate2 == "") && document.form1.validfrm_1.value == "" && document.form1.validto_1.value == "")//�ܤ֭n��@�i��
		{
			alert("Please select the off-date period !!");
			return false;
		}
	
		if(sDate1.substr(0,4)!= sDate2.substr(0,4))
		{
			alert("��~����Ф��}�ӽ�!!");
			return false;
		}
	
		var off_type = document.form1.off_type.value;
	
		if(off_type=="16" && sDate2>="2011/12/31")

		{
			alert("XL�B�~���Ұ��ϥδ����Ȧ�2011/12/31!!");
			return false;
		}
	
		if(off_type=="16" && document.form1.tdays.value != "3")
		{
			alert("XL�B�~���Ұ��ݤ@���ϥΧ���!!");
			return false;
		}
	
		fday = new Date(Number(sDate1.substring(0,4)),Number(sDate1.substring(5,7))-1,Number(sDate1.substring(8,10)));//Date(2011,9,1)
		tday = new Date(Number(sDate2.substring(0,4)),Number(sDate2.substring(5,7))-1,Number(sDate2.substring(8,10)));
		dayms = 24*60*60*1000;
		//��ۮt���@���ഫ���Ѽ� 
		if(sDate1 != "" && sDate2 != "") {
			iDays = Math.floor((tday.getTime()-fday.getTime())/dayms)+1;
		}else{
			iDays = 0;
		}
		if(iDays > 6){
			alert("��AL���i�W�L����!");
			return false;
		}
		
		//�խ����Х�(�t�w���e��)�W�L15�Ѫ̡A�t��message box�����T���p�U�G
		//���ŦX�k�W�A�ЦA���T�{ETS��SS�V�m�������A�ۦ汱�ޥ𰲤ѼơC
		 if(iDays +1 >14)
		 {
			alert("���ŦX�k�W�A�ЦA���T�{ETS��SS�V�m�������A�ۦ汱�ޥ𰲤ѼơC");
		 }
	
		 if(confirm("Send the AL/XL Request ?"))
		 {
			return true;
		 }
		 else
		 {
			document.getElementById("Submit").disabled=0;
			return false;
		 }
		 	
	}
}

function lock_input(){
	var getOffType = document.form1.off_type.value;	
	if(getOffType == '16'){
		for(var i=2;i<=sheetNum;i++){//����L5�i��disabled
			//document.form1.elements["validfrm_"+para].setAttribute("DISABLED","disabled");
			document.getElementById("validfrm_"+i).setAttribute("DISABLED","disabled");			
			document.getElementById("validto_"+i).setAttribute("DISABLED","disabled");
			document.getElementById("validfrm_"+i).setAttribute("STYLE","background-color:'#a9a9a9';");
			document.getElementById("validto_"+i).setAttribute("STYLE","background-color:'#a9a9a9';");
		}
	}	
}

</script>
<title>Input aloffsheet</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
<link href="menu.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="calendar2.js" ></script>
<style type="text/css">
.no_border
{  
border-bottom: 1.5px solid #808080 ;
border-top: 0px solid #FFFFFF ;
border-left: 0px solid #FFFFFF ;
border-right: 0px solid #FFFFFF ;
font-weight: bold;
font-size: 9pt;
}
.style1 {color: #FF0000}
</style>
</head>
<body bgcolor="#FFFFFF" text="#000000" >
<div align="center"> 
  <!--<p><font face="Comic Sans MS" color="#003399">Input AL offsheet </font></p>-->
  <table width="80%" border="1">
    <tr> 
      <td width="25%" class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>Dept</b></font></td>
      <td width="25%" class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>Name</b></font></td>
	  <td width="25%" class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>EmpNo</b></font></td>
      <td width="25%" class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>SerNo</b></font></td>
	</tr> 
	<tr class="txtblue"> 
      <td width="25%" align= "center"><font face="Arial, Helvetica, sans-serif" size="2"><b><%=obj2.getDeptno()%></b> </font></td>     
      <td width="25%" align= "center"><font face="Arial, Helvetica, sans-serif" size="2"><b><%=obj2.getCname()%></b></font></td>
	  <td width="25%" align= "center"><font face="Arial, Helvetica, sans-serif" size="2"><b><%=obj2.getEmpn()%></b> </font></td>      
	  <td width="25%" align= "center"><font face="Arial, Helvetica, sans-serif" size="2"><b><%=obj2.getSern()%></b></font></td>
    </tr>
    <tr> 
      <td width="25%" class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>AL effective Date</b></font></td>

	  <td width="80%" colspan ="3" rowspan="4" valign="top">
		  <table width="100%" border="0">
		  <tr>
			<td width="40%"  class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>AL/XL valid period</b></font></td>
			<td width="20%"  class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>�i���Ѽ�</b></font></td>
			<td width="20%"  class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>�i�ΤѼ�</b></font></td>
			<td width="20%"  class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>�w�ϥΤѼ�</b></font></td>
		  </tr>
		 <%
			
			for(int i=0; i<alperiodAL.size(); i++)
			{
				String tempbgcolor = "";
				if(i%2==0)
				{
					tempbgcolor = "#CCCCCC";
				}
				else
				{
					tempbgcolor = "#FFFFFF";
				}
				ALPeriodObj obj = (ALPeriodObj) alperiodAL.get(i);
		 %>
		 
		       <tr align="center" bgcolor="<%=tempbgcolor%>" class="txtblue">
		        <td>(<%=offtype.getOffDesc(obj.getOfftype()).offtype%>)<%=obj.getEff_dt()%> ~ <%=obj.getExp_dt()%></td>
				<td><%
					
					if(null!=obj.getOrigdays() && !"".equals(obj.getOrigdays())) {
						out.println(obj.getOrigdays());
					} else {
						out.println(obj.getOffquota());
					} 
					
				%></td>
				<td><%=obj.getOffquota()%></td>
				<td><%=obj.getUseddays()%></td>
	        </tr>
		 <%
			}
		 %>	  
	    </table>
	  </td>
	</tr> 
    <tr valign="top" class="txtxred"> 
      <td width="25%" align= "center" valign="middle"><font face="Arial, Helvetica, sans-serif" size="2"><%=obj2.getAldate()%></font></b></td>     
    </tr>
    <tr valign="top" class="txtblue"> 
	  <td width="25%"  class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>�������S���`�Ѽ�</b></font></td>
   </tr>
    <tr valign="top" class="txtxred"> 
      <td width="25%" align= "center" valign="middle"><font face="Arial, Helvetica, sans-serif" size="2"><%=undeduct%></font></b></td>     
    </tr>
  </table> 
  <!--********************************************************-->
  <!--<hr noshade color="#003366" width="80%"  size="2" align="center">-->
  <iframe src="alquotacount.jsp" width="100%" height="300" align="middle" frameborder="0" scrolling="auto"></iframe>
  <!--<hr noshade color="#003366" width="80%"  size="2" align="center">-->
  <!--********************************************************-->
  <br><br>
  <!-- 
  <fieldset style="width:80%;text-align:center;margin-left:0pt; ">
  <legend class="txttitletop">�~���ӽг� AL/XL offsheet </legend>
  <br>
  <form name="form1" method="post" action="<%=response.encodeURL("updal.jsp")%>" onSubmit="return f_submit();">
  <table width="80%" border="0" cellpadding="0" cellspacing="1">
	<tr valign="bottom" class="txtblue"> 
		<td><font face="Arial, Helvetica, sans-serif" size="2"><b>OFF Type</b></font></td>
		<td><font face="Arial, Helvetica, sans-serif" size="2">
		    <select name="off_type">
				<option value="0">AL �S��</option>
<%
if("637674".equals(userid)| "633020".equals(userid))
{
%>
				<option value="16">XL �B�~���Ұ�</option>
<%
}	
%>
			</select></font>
		</td>
    </tr>
	<tr valign="bottom" class="txtblue"> 
		<td><font face="Arial, Helvetica, sans-serif" size="2"><b>OFF Period</b></font></td>
		<td><font face="Arial, Helvetica, sans-serif" size="2"><b>From : </b></font>
		  <span onclick ="cal1.popup();" style="cursor:pointer">
		  <input maxlength="10" type="text" name="validfrm" id="validfrm" class="text" size="15" onFocus="this.blur()"  style="cursor:pointer"><img src="../../FZ/images/p2.gif" width="22" height="22"> </span>
		 <font face="Arial, Helvetica, sans-serif" size="2"><b>To : </b></font>
		 <span onclick ="cal2.popup();" style="cursor:pointer">
		 <input maxlength="10" type="text" name="validto" id="validto" class="text" size="15" onFocus="this.blur()"  style="cursor:pointer">
		 <img src="../../FZ/images/p2.gif" width="22" height="22"></span>
		</td>
	</tr>
	<tr valign="bottom" class="txtblue"> 
		<td><font face="Arial, Helvetica, sans-serif" size="2"><b>OFF Days</b></font></td>
		<td><font face="Arial, Helvetica, sans-serif" size="2">
			<input maxlength="5" type="text" name="tdays" id="tdays" class="text" size="5" onFocus ="getDays();"/>
			
			</font>
		</td>
	</tr>

    </table>
	<p class="txtxred"><strong>���@�������Ѽ� + �w�а��Ѽ� ���i�j��30��</strong></p>
	<p class="txtxred"><strong>���@AL���i�гs�򤻤ѥH�W,�s��а��Ф��q����</strong></p>
    </fieldset>
    -->
   
<!-- 2013���h�i�� -->
  <fieldset style="width:80%;text-align:center;margin-left:0pt; ">
  <legend class="txttitletop">�~���ӽг� AL/XL offsheet </legend>
  <br>
<form name="form1" method="post" action="<%=response.encodeURL("updal.jsp")%>" onSubmit="return f_submit();">
<input type="hidden" name="sheetNum" id="sheetNum" value="<%=sheetNum%>">
<font face="Arial, Helvetica, sans-serif" size="2">
	<select name="off_type" onChange="lock_input();" >
		<option value="0">AL �S��</option>
<%
if("637674".equals(userid))//|"633020".equals(userid)
{		
%>
		<option value="16">XL �B�~���Ұ�</option>
<%
}
%>
</select></font>
 <table width="80%" border="0" cellpadding="0" cellspacing="1">
    <tr> 
      <td class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>NO.</b></font></td>
      <td class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>OFF Period</b></font></td>
	  <td class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>OFF DAYS</b></font></td>      
    </tr>
<%
if(sheetNum>0)
{
	for(int i=0; i<sheetNum; i++)
	{
		String tempbgcolor="";
			if(sheetCount ==0)
			{
				tempbgcolor = "#f0e68c";
			}
			else if(sheetCount%2==0)
			{
				tempbgcolor = "#FFFFFF";
			}
			else
			{
				tempbgcolor = "#CCCCCC";
			}
			sheetCount ++;
%>
 	<tr align="center" valign="top" bgcolor="<%=tempbgcolor%>" class="txtblue"> 	
 		<td>
			#<%=sheetCount%>
			<input type ="hidden" name="num" id="num" value="<%=sheetCount%>" ></input>
			
		</td>	
		<td><font face="Arial, Helvetica, sans-serif" size="2"><b>From : </b></font>
		  	<span onclick ="cal1[<%=sheetCount%>].popup();">
		  	<input maxlength="10" type="text" name="validfrm_<%=sheetCount %>" id="validfrm_<%=sheetCount %>" class="text" size="15" onFocus="this.blur()" ><!-- style="cursor:pointer" -->
		  	<img src="../../FZ/images/p2.gif" width="22" height="22"> </span>
		 	<font face="Arial, Helvetica, sans-serif" size="2"><b>To : </b></font>
		 	<span onclick ="cal2[<%=sheetCount%>].popup();">
		 	<input maxlength="10" type="text" name="validto_<%=sheetCount %>" id="validto_<%=sheetCount %>" class="text" size="15" onFocus="this.blur()" ><!-- style="cursor:pointer" -->
		 	<img src="../../FZ/images/p2.gif" width="22" height="22"></span>
		</td>
		<td><font face="Arial, Helvetica, sans-serif" size="2">
			<input maxlength="5" type="text" name="tdays_<%=sheetCount %>" id="tdays_<%=sheetCount %>" class="text" size="5" onFocus ="getDays(<%=sheetCount%>);"/>			
			</font>
		</td>
 	</tr>
 
<%
	}//for(int i=0; i<sheetNum; i++)
}// if(sheetNum>0)
 
%>

</table>
	<p class="txtxred"><strong>���@�������Ѽ� + �w�а��Ѽ� ���i�j��30��</strong></p>
	<p class="txtxred"><strong>���@AL�C���s�򤣱o�W�L����A�ⵧ�����ܤֶ��j�@��C</strong></p>
</fieldset>
	<p align = "center">		
      <input type="submit" name="Submit" id="Submit" value="Send" >
      <input type="reset" name="Submit2" id="Submit2" value="Reset" onClick="document.form1.Submit.disabled=0;">
    </p>
</form>

</div>
</body>
</html>

<script type="text/javascript" language="javascript">
var sheetNum = 6;
	var cal1 = new Array();
	for (var i = 1; i <= sheetNum; i++) {
    	cal1[i] = new calendar2(document.forms[0].elements['validfrm_'+i]);
		cal1[i].year_scroll = true;
		cal1[i].time_comp = false;
	}
	
	var cal2 = new Array();
	for (var i = 1; i <= sheetNum; i++) {
    	cal2[i] = new calendar2(document.forms[0].elements['validto_'+i]);
		cal2[i].year_scroll = true;
		cal2[i].time_comp = false;
	}
	
/* 	var cal1 = new calendar2(document.forms[0].elements['validfrm_'+i]);
	cal1.year_scroll = true;
	cal1.time_comp = false;

	var cal2 = new calendar2(document.forms[0].elements['validto_'+num]);
	cal2.year_scroll = true;
	cal2.time_comp = false; */
	
</script>

<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="eg.off.*, eg.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String userid = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || userid == null) 
{		//check user session start first
	response.sendRedirect("../login.jsp");
} 

String empno = request.getParameter("empno");
String bc = "";
GregorianCalendar cal = new GregorianCalendar();
String gdyear = Integer.toString(cal.get(Calendar.YEAR));
int undeduct = 0;
boolean hasdelete = false;
//***************************************
EGInfo egi = new EGInfo(empno);
ArrayList objAL2 = new ArrayList();
objAL2 = egi.getObjAL();
EgInfoObj obj2 = new EgInfoObj();
if(objAL2.size()>0)
{
	obj2 = (EgInfoObj) objAL2.get(0);
	empno = obj2.getEmpn();
}   

//***************************************
OffRecordList orl = new OffRecordList();
orl.getOffRecord(empno,"ALL",gdyear);
//out.println(orl.getSQL());
ArrayList objAL = new ArrayList();
objAL = orl.getObjAL();
undeduct = orl.getALUndeduct(empno);
//***************************************
ALPeriod oys = new ALPeriod();      
oys.getALPeriod(empno);
ArrayList alperiodAL = oys.getObjAL();
//***************************************
OffType offtype = new OffType();
offtype.offData();
//***************************************
// 隸屬FZPUR群組者，可使用 Purser Report 功能
ci.auth.GroupsAuth ga = new ci.auth.GroupsAuth(userid);
try 
{
	ga.initData(); //取得userid 所屬群組資料
} catch (ClassNotFoundException e) {
	System.out.println(" Error:"+e.toString());
} catch (Exception e) {
	System.out.println(" Error:"+e.toString());
}	


//Get3days g3d = new Get3days();
//g3d.get3daysAL();
//ArrayList daysAL = g3d.getDaysAL();
//***************************************
%>
<html>
<head>
<script language="JavaScript">
function getCalendar(obj)
{    
	eval("wincal=window.open('../Calendar.htm','" + obj +"','width=350,height=200')");
}

function getDays()
{
	var sDate1 = document.form1.validfrm.value;// sDate1 format"2002-1-10"
	var sDate2 = document.form1.validto.value;
	var iDays  
	if(sDate1 == "" || sDate2 == "")
	{
		alert("Please select the off-date period !!");
		return;
	}

	if(sDate1 > sDate2 )
	{
		alert("Please check the off-date period !!");
		return;
	}
	
	var iDays  
	fday = new Date(Number(sDate1.substring(0,4)),Number(sDate1.substring(5,7))-1,Number(sDate1.substring(8,10)));//Date(2011,9,1)
	tday = new Date(Number(sDate2.substring(0,4)),Number(sDate2.substring(5,7))-1,Number(sDate2.substring(8,10)));
	dayms = 24*60*60*1000;
	iDays = Math.floor((tday.getTime()-fday.getTime())/dayms)+1;

	//把相差的毫秒轉換為天數 
	document.form1.tdays.value = iDays;
}

function f_submit()
{  
	document.form1.Submit.disabled=1;	
	getDays();
	var ttlday = document.form1.tdays.value;
	var fltno = document.form1.fltno.value;
	var offtypeid = document.form1.offtype.value;
	var offtype = document.form1.offtype[form1.offtype.selectedIndex].text;
	if(offtypeid == "3")
	{
		document.getElementById("occurdate").value = "";
		document.getElementById("relation").value = "";

		if(parseInt(ttlday) > 7)
		{
			alert("SL 網路申請限連請7天 !!");
			document.getElementById("Submit").disabled=0;
			return false;
		}
	}

	if(offtypeid == "12")
	{
		document.getElementById("occurdate").value = "";
		document.getElementById("relation").value = "";

		if(parseInt(ttlday) > 1)
		{
			alert("PL 限請1天 !!");
			document.getElementById("Submit").disabled=0;
			return false;
		}
	}

	if(offtypeid == "5")
	{
		document.getElementById("occurdate").value = "";
		document.getElementById("relation").value = "";

		if(parseInt(ttlday) > 5)
		{
			alert("EL 限連請5天 !!");
			document.getElementById("Submit").disabled=0;
			return false;
		}
	}

	if(offtypeid == "1")
	{
		var sDate1 = document.getElementById("occurdate").value;
		var sDate2 = document.form1.validto.value;
		var iDays  

		fday = new Date(Number(sDate1.substring(0,4)),Number(sDate1.substring(5,7))-1,Number(sDate1.substring(8,10)));//Date(2011,9,1)
		tday = new Date(Number(sDate2.substring(0,4)),Number(sDate2.substring(5,7))-1,Number(sDate2.substring(8,10)));
		dayms = 24*60*60*1000;
		iDays = Math.floor((tday.getTime()-fday.getTime())/dayms)+1;
	
		//把相差的毫秒轉換為天數 
		//document.form1.tdays.value = iDays;

		if(parseInt(iDays) > 93)
		{
			alert("WL 必須於結婚當日起三個月內實施完畢 !!");
			document.getElementById("Submit").disabled=0;
			return false;
		}

		if(parseInt(ttlday) > 8)
		{
			alert("WL 限請8天 !!");
			document.getElementById("Submit").disabled=0;
			return false;
		}
	}

	if(offtypeid == "2")
	{
	    var sDate1 = document.getElementById("occurdate").value;
		var sDate2 = document.form1.validto.value;
		var iDays  
		fday = new Date(Number(sDate1.substring(0,4)),Number(sDate1.substring(5,7))-1,Number(sDate1.substring(8,10)));//Date(2011,9,1)
		tday = new Date(Number(sDate2.substring(0,4)),Number(sDate2.substring(5,7))-1,Number(sDate2.substring(8,10)));
		dayms = 24*60*60*1000;
		iDays = Math.floor((tday.getTime()-fday.getTime())/dayms)+1;
	
		//把相差的毫秒轉換為天數 
		//document.form1.tdays.value = iDays;

		if(parseInt(iDays) > 100)
		{
			alert("FL 必須於親屬喪亡日起一百日內實施完畢 !!");
			document.getElementById("Submit").disabled=0;
			return false;
		}

	    var relation = document.form1.relation.value;
		if((relation == "22" | relation == "23" | relation == "24" | relation == "25" | relation == "26" | relation == "27") && parseInt(ttlday) > 3)
		{
			alert("FL ("+document.form1.relation[form1.relation.selectedIndex].text+"喪亡)限請3天 !!");
			document.getElementById("Submit").disabled=0;
			return false;
		} 
		else if((relation == "1" | relation == "2" | relation == "3" | relation == "4" | relation == "5" | relation == "6" | relation == "7" ) && parseInt(ttlday) > 8)
		{
			alert("FL ("+document.form1.relation[form1.relation.selectedIndex].text+"喪亡)限請8天 !!");
			document.getElementById("Submit").disabled=0;
			return false;
		}
		else if((relation == "8" | relation == "9" | relation == "10" | relation == "11" | relation == "12" | relation == "13" | relation == "14" | relation == "15" | relation == "16" | relation == "17" | relation == "18" | relation == "19" | relation == "20" | relation == "21" ) && parseInt(ttlday) > 6)
		{
			alert("FL ("+document.form1.relation[form1.relation.selectedIndex].text+"喪亡)限請6天 !!");
			document.getElementById("Submit").disabled=0;
			return false;
		}
	}

	if(offtypeid == "1" | offtypeid == "2")
	{
		var occurdate = document.getElementById("occurdate").value;
		if(occurdate == null | occurdate == "")
		{
			alert("請輸入發生日!!");
			document.getElementById("Submit").disabled=0;
			return false;
		}
	}

	if(offtypeid == "2")
	{
		var relation = document.getElementById("relation").value;
		if(relation == null | relation == "")
		{
			alert("請輸入親屬關係!!");
			document.getElementById("Submit").disabled=0;
			return false;
		}
	}

	// BL網路限一天
	if(offtypeid == "6")
	{
		if(parseInt(ttlday) > 1)
		{
			alert("BL 網路遞單限請1天 !!");
			document.getElementById("Submit").disabled=0;
			return false;
		}
	}


	//若請假月份有班表,則必須輸入原任務
	if(offtypeid != "6" && offtypeid != "17")
	{
		var sdate = document.form1.validfrm.value;	
		window.open("getIfskjpub.jsp?sdate="+sdate,"w","left=1,top=1,width=1,height=1","");
		window.open("getIfskjpub.jsp?sdate="+sdate,"w","left=1,top=1,width=1,height=1","");
		var skjpub = document.form1.spub.value;
		if(skjpub == "Y")
		{
			if (fltno == "")
			{
				alert("請輸入原任務 !!");
				document.getElementById("Submit").disabled=0;
				return false;
			}
		}
	}


	if(offtypeid != "1" && offtypeid != "2")
	{
		document.getElementById("occurdate").value = "";
		document.getElementById("relation").value = "";
	}
	else if(offtypeid == "1")
	{
		document.getElementById("relation").value = "";
	}

	 if(confirm("Send the "+offtype+" Request ?"))
	 {
		//SR9409 ********************************************************
		if(parseInt(ttlday)>=2)
		{
			alert("請立即傳真證明文件，證明文件正本需於兩週內繳交!!");
		}
		//SR9409 ********************************************************

		return true;
	 }
	 else
	 {
		document.getElementById("Submit").disabled=0;
		return false;
	 }
}

function setdata()
{
	var offtype = document.getElementById("offtype").value;

	//SR9409 ********************************************************
	if(offtype=="5")
	{
		alert("『事假』請休需先向管理單位報核!!");
	}
	//SR9409 ********************************************************

	if(offtype=="1")
	{
		divoccur.style.display='';
		divrelation.style.display='none';
	}
	else if(offtype=="2")
	{
		divoccur.style.display='';
		divrelation.style.display='';
	}
	else
	{
		divoccur.style.display='none';
		divrelation.style.display='none';
	}
}	
</script>
<title>Input leaveoffsheet</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
<link href="menu.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="calendar2.js" ></script>
<script src="../js/subWindow.js"></script>
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
<body bgcolor="#FFFFFF" text="#000000" onload="setdata();">
<div align="center"> 
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
			<td width="46%"  class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>AL/XL valid period</b></font></td>
			<td width="27%"  class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>Initial Days</b></font></td>
			<td width="27%"  class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>Usage Days</b></font></td>
		  </tr>
		 <%
			for(int i=0; i<alperiodAL.size(); i++)
			{
				String tempbgcolor = "";
				if(i%2==0)
				{
					tempbgcolor = "#FFFFFF";
				}
				else
				{
					tempbgcolor = "#CCCCCC";
				}
				ALPeriodObj obj = (ALPeriodObj) alperiodAL.get(i);
		 %>
		       <tr align="center" bgcolor="<%=tempbgcolor%>" class="txtblue">
		        <td>(<%=offtype.getOffDesc(obj.getOfftype()).offtype%>)<%=obj.getEff_dt()%> ~ <%=obj.getExp_dt()%></td>
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
	  <td width="25%"  class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>未扣除特休假總天數</b></font></td>
   </tr>
    <tr valign="top" class="txtxred"> 
      <td width="25%" align= "center" valign="middle"><font face="Arial, Helvetica, sans-serif" size="2"><%=undeduct%></font></b></td>     
    </tr>
  </table> 
<br>
  <fieldset style="width:80%;text-align:center;margin-left:0pt; ">
  <legend class="txttitletop">請假申請單 EL/SL/LSW/PL/WL/FL offsheet </legend>
  <br>
  <form name="form1" method="post" action="<%=response.encodeURL("insleave_agency.jsp")%>" onSubmit="return f_submit();">
  <input type="hidden" name="spub" id="spub" value="">
  <input type="hidden" name="empno" id="empno" value="<%=empno%>">
  <table width="80%" border="0" cellpadding="0" cellspacing="1">
	<tr valign="bottom" class="txtblue"> 
		<td width="20%" align = "left"><font face="Arial, Helvetica, sans-serif" size="2"><b>假別</b></font></td>
		<td width="80%" align = "left">
		    <select name="offtype" id="offtype" onchange="setdata();">
				<option value="3" selected>SL 病假</option>
				<option value="12">PL 生理假</option>
				<option value="5">EL 事假</option>
				<option value="1">WL 婚假</option>
				<option value="2">FL 喪假</option>
<%
GregorianCalendar cal1 = new GregorianCalendar();
GregorianCalendar cal2 = new GregorianCalendar();//now
//2012/03/25 00:01 才開放
cal1.set(Calendar.YEAR,2012);
cal1.set(Calendar.MONTH,3-1);
cal1.set(Calendar.DATE,25);
cal1.set(Calendar.HOUR_OF_DAY,0);
cal1.set(Calendar.MINUTE,1);

if(cal1.before(cal2))
{
%>
				<option value="27">LSW 特休不給薪(能申請換班)</option>
<%
}
%>
			</select>
		</td>
	</tr>
  </table>
  <div id="divoccur" style="display:none"> 
  <table width="80%" border="0" cellpadding="0" cellspacing="1">
	<tr valign="bottom" class="txtblue"> 
		<td width="20%" align = "left"><font face="Arial, Helvetica, sans-serif" size="2"><b>發生日</b></font></td>
		<td width="80%" align = "left"><span onclick ="getCalendar('occurdate')" style="cursor:pointer">
			  <input maxlength="10" type="text" name="occurdate" id="occurdate" class="text" size="15" onFocus="this.blur()"  style="cursor:pointer"><img src="../../FZ/images/p2.gif" width="22" height="22"> </span>
		</td>
	</tr>
  </table>
  </div>
  <div id="divrelation" style="display:none"> 
  <table width="80%" border="0" cellpadding="0" cellspacing="1">
  <tr valign="bottom" class="txtblue"> 
		<td width="20%" align = "left"><font face="Arial, Helvetica, sans-serif" size="2"><b>親屬關係</b></font></td>
		<td width="80%" align = "left"><select name="relation" id="relation" >
				<jsp:include page="relation.html" />		
			</select>
		</td>
  </tr>
  </table>
  </div>
  <table width="80%" border="0" cellpadding="0" cellspacing="1">
	<tr valign="bottom" class="txtblue"> 
		<td width="20%" align = "left"><font face="Arial, Helvetica, sans-serif" size="2"><b>請假區間</b></font></td>
		<td width="80%" align = "left"><font face="Arial, Helvetica, sans-serif" size="2"><b>From : </b></font>
		  <span onclick ="cal1.popup();" style="cursor:pointer">
		  <input maxlength="10" type="text" name="validfrm" id="validfrm" class="text" size="15" onFocus="this.blur()"  style="cursor:pointer"><img src="../../FZ/images/p2.gif" width="22" height="22"> </span>
		 <font face="Arial, Helvetica, sans-serif" size="2"><b>To : </b></font>
		 <span onclick ="cal2.popup();" style="cursor:pointer">
		 <input maxlength="10" type="text" name="validto" id="validto" class="text" size="15" onFocus="this.blur()"  style="cursor:pointer">
		 <img src="../../FZ/images/p2.gif" width="22" height="22"></span>
		</td>
	</tr>
	<tr valign="bottom" class="txtblue"> 
		<td width="20%" align = "left"><font face="Arial, Helvetica, sans-serif" size="2"><b>請假天數</b></font></td>
		<td width="80%" align = "left"><font face="Arial, Helvetica, sans-serif" size="2">
			<input maxlength="10" type="text" name="tdays" id="tdays" class="text" size="10" onFocus ="getDays();">
			</font>
		</td>
	</tr>
	<tr valign="bottom" class="txtblue"> 
		<td width="20%" align = "left"><font face="Arial, Helvetica, sans-serif" size="2"><b>原任務</b></font></td>
		<td width="80%" align = "left"><input maxlength="10" type="text" name="fltno" id="fltno" class="text" size="10" onkeyup="javascript:this.value=this.value.toUpperCase();"></td>
	</tr>
    </table>
	<br>
    </fieldset>
  <!--********************************************************-->
    <p align = "center">
      <input type="submit" name="Submit" id="Submit" value="Send">
      <input type="reset" name="Submit2" id="Submit2" value="Reset">
    </p>
  </form>
 <table width="80%" border="0" cellpadding="0" cellspacing="1">
	<tr valign="bottom" class="txtblue"> 
	 <td colspan = "2">網路請假規則:<td>
	</tr>
	<tr class="txtblue">
	 <td>* SL </td><td>至多限連請7天,一年和PL合併不得超過30天</td>
	</tr>
	<tr class="txtblue">
	 <td>* PL </td><td>一個月限請一天,一年和SL合併不得超過30天</td>
	</tr>
	<tr class="txtblue">
	 <td>* EL </td><td>至多限連請5天,一年不得超過14天</td>
	</tr>
	<tr class="txtblue">
	 <td>* WL </td><td>至多限連請8天</td>
	</tr>
	<tr class="txtblue">
	 <td>&nbsp;</td><td>結婚當日(發生日)起三個月內實施完畢</td>
	</tr>
	<tr class="txtblue">
     <td>* FL </td><td>員工之父母、養父母、繼父母、配偶喪亡,至多限請8天</td>
	</tr>
	<tr class="txtblue">
<td>&nbsp;</td><td>員工之祖父母、外祖父母、子女、<br>員工配偶之祖父母、父母、養父母或繼父母喪亡,至多限請6天</td>
	</tr>
	<tr class="txtblue">
	 <td>&nbsp;</td><td>員工之曾祖父母、員工之兄弟姐妹、員工配偶之外祖父母喪亡,至多限請3天</td>
	</tr>
	<tr class="txtblue">
	 <td>&nbsp;</td><td>親屬喪亡之日(發生日)起一百日(含)實施完畢</td>
	</tr>
	<tr class="txtblue">
     <td>* LSW </td><td>前一曆年或當年度需全勤,每一曆年僅限抵5日年假</td>
	</tr>
	<tr class="txtblue">
		<td>&nbsp;</td><td>限非<span align="center" class="style1" onClick="subwin('../viewLSWNoDate.jsp','LSW')" style="text-decoration:underline;text-decoration:red;cursor:hand "><u>管制請假日</u></span>得以申請</td>
	</tr>
	<tr class="txtblue">
		<td>&nbsp;</td><td>遞單時即自動扣除AL</td>
	</tr>
 </table>
</div>
</body>
</html>

<script  type="text/javascript" language="javascript">
	var cal1 = new calendar2(document.forms[0].elements['validfrm']);
	cal1.year_scroll = true;
	cal1.time_comp = false;

	var cal2 = new calendar2(document.forms[0].elements['validto']);
	cal2.year_scroll = true;
	cal2.time_comp = false;
</script>

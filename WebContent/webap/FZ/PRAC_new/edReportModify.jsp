<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.pracP.*,fz.pracP.dispatch.*,java.sql.*,ci.db.ConnDB,java.net.URLEncoder,ci.db.*,java.util.ArrayList"%>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>修改客艙報告</title>

<link href="style2.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" media="all" type="text/css" href="jquery-ui-timepicker-addon.css" />
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>

<script type="text/javascript" src="jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="jquery-ui-sliderAccess.js"></script>
<script language="javascript" src="changeAction.js" type="text/javascript"></script>
<script>
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
	else if(parseInt(temp_ttl) <=0 && odnum != 2)
	{
		 alert("請輸入實際旅客人數!!\n若為Ferry Flt,最多選擇兩位打工組員(Duty code OD).");
		 document.form1.f.focus();
		 return false;
	}else if(!document.form1.shY.checked && !document.form1.shN.checked)
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

function checkNUM(col)
{
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
function comfirmDel()
{
		if(confirm("刪除報表，會將此份報表所有資料清除。\n確定要刪除？")){
			
			preview('form1','delReport.jsp')
			return true;
		}
		else{
			
			return false;
		}
}

function checkOneBa(){
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
	{	
		//Y需填寫輪班 detail
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
	}else if ("11" == flag){//初始化
		document.getElementById("shRec").style.display="";
		
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

function initSh(){//初始化輪休資訊
	if(document.getElementById("shY").checked){
		showSh(11);
	}else{
		showSh(2);
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
	var flag = true;
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
<body onLoad="initSh()">
<%
String fdate 	= null;
String fltno 	= null; 
String dpt		= null;
String arv		= null;
String GdYear 	= null;
String stdDt 	= null;
try
{
	fdate 	= request.getParameter("fdate");
	fltno 	= request.getParameter("fltno").trim();
	stdDt 	= request.getParameter("stdDt");
	if(null == stdDt || "".equals(stdDt)){
		stdDt = fdate + " 00:00";
		//out.println(stdDt);
	}
	
	dpt		= request.getParameter("dpt").trim();
	arv		= request.getParameter("arv").trim();
	//取得考績年度
	 GdYear = fz.pracP.GdYear.getGdYear(fdate);

}catch (Exception e)
{
	  out.print(e.toString()+"-->"+fdate+","+fltno+","+dpt+","+arv+","+GdYear+","+GdYear);
}
String sect		= dpt+arv;

String cpname = null;
String cpno = null;
String psrempn = null;
String psrsern = null;
String psrname = null;
String pgroups = null;
String acno = null;
String[] empn = new String[20];
String[] sern = new String[20];
String[] crew = new String[20];
String[] score = new String[20];
String[] duty = new String[20];
String[] shift = new String[20];//
String book_f = null;
String book_c = null;
String book_y = null;
String pxac = null;
String inf = null;
String upd = null;

//輪休梯次
String[] lshiftShow = {"X","1","2","3","4"};
String[] lshift = {"0","1","2","3","4"};
int shiftTime = 4;
String[] sh_staTime = new String[shiftTime];
String[] sh_endTime = new String[shiftTime];
//String sh_staTime2 = null;//
//String sh_endTime2 = null;//
String sh_remark = null;//
String isShift = null;//
String sh_cm = null;//
String mp_empn = null;//組長
String sh_mp = null;//
String mpname = null;
//****************************************************************
String fleet="";
FlexibleDispatch fd = new FlexibleDispatch();
fd.getLong_range(fdate,fltno, dpt+arv,sGetUsr) ;
fleet = fd.getFleetCd();
//****************************************************************
String[] lscore	= {"0","1","2","3","4","5","6","7","8","9","10"};
String[] lscoreShow =  {"X","1","2","3","4","5","6","7","8","9","10"};


String bcolor="";
int cCount = 0;
ArrayList gsEmpno = new ArrayList();//服務
ArrayList baEmpno = new ArrayList();//服儀

Driver dbDriver = null;
Connection conn = null;
Statement stmt = null;
ResultSet myResultSet = null;

try{

ConnDB cn = new ConnDB();
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
	
String sql = "SELECT FLTD, FLTNO, SECT, CPNAME, CPNO, ACNO, PSREMPN, PSRSERN, PSRNAME, PGROUPS, "+
" EMPN1, SERN1, CREW1, SCORE1, EMPN2, SERN2, CREW2, SCORE2, EMPN3, SERN3, CREW3, SCORE3, EMPN4, SERN4, CREW4, SCORE4, EMPN5, SERN5, CREW5, SCORE5, EMPN6, SERN6, CREW6, SCORE6, EMPN7, SERN7, CREW7, SCORE7, EMPN8, SERN8, CREW8, SCORE8, EMPN9, SERN9, CREW9, SCORE9, EMPN10, SERN10, CREW10, SCORE10, EMPN11, SERN11, CREW11, SCORE11, EMPN12, SERN12, CREW12, SCORE12, EMPN13, SERN13, CREW13, SCORE13, EMPN14, SERN14, CREW14, SCORE14, EMPN15, SERN15, CREW15, SCORE15, EMPN16, SERN16, CREW16, SCORE16, EMPN17, SERN17, CREW17, SCORE17, EMPN18, SERN18, CREW18, SCORE18, EMPN19, SERN19, CREW19, SCORE19, EMPN20, SERN20, CREW20, SCORE20, CHGUSER, CHGDATE, REMARK, BOOK_F, BOOK_C, BOOK_Y, PXAC, UPD, INF, DUTY1, DUTY2, DUTY3, DUTY4, DUTY5, DUTY6, DUTY7, DUTY8, DUTY9, DUTY10, DUTY11, DUTY12, DUTY13, DUTY14, DUTY15, DUTY16, DUTY17, DUTY18, DUTY19, DUTY20,"+
" REJECT, REJECT_DT, REPLY, BDOT, BDTIME, BDREASON, "+
" to_char(sh_st1,'yyyy/mm/dd hh24:mi') SH_ST1, to_char(sh_et1,'yyyy/mm/dd hh24:mi') SH_ET1,"+
" to_char(sh_st2,'yyyy/mm/dd hh24:mi') SH_ST2, to_char(sh_et2,'yyyy/mm/dd hh24:mi') SH_ET2, "+
" to_char(sh_st3,'yyyy/mm/dd hh24:mi') SH_ST3, to_char(sh_et3,'yyyy/mm/dd hh24:mi') SH_ET3, "+
" to_char(sh_st4,'yyyy/mm/dd hh24:mi') SH_ST4, to_char(sh_et4,'yyyy/mm/dd hh24:mi') SH_ET4, "+
" SH_CREW1, SH_CREW2, SH_CREW3, SH_CREW4, SH_CREW5, SH_CREW6, SH_CREW7, SH_CREW8, SH_CREW9, SH_CREW10, SH_CREW11, SH_CREW12, SH_CREW13, SH_CREW14, SH_CREW15, SH_CREW16, SH_CREW17, SH_CREW18, SH_CREW19, SH_CREW20,"+ 
" SH_REMARK, SHIFT,SH_CM,SH_MP,MP_EMPN"+
" FROM egtcflt WHERE fltd=to_date('"+fdate+"','yyyy/mm/dd') AND fltno='"+fltno+"' AND sect ='"+sect+"'";
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY); 

myResultSet = stmt.executeQuery(sql); 
 
if(myResultSet.next())
{
	cpname = myResultSet.getString("cpname");
	if(cpname == null) cpname = "";
	cpno = myResultSet.getString("cpno");
	if(cpno == null) cpno = "";
	psrempn = myResultSet.getString("psrempn");
	if(psrempn == null) psrempn = "";
	psrsern = myResultSet.getString("psrsern");
	if(psrsern == null) psrsern = "";
	psrname = myResultSet.getString("psrname");
	if(psrname == null) psrname = "";
	pgroups	= myResultSet.getString("pgroups");
	if(pgroups == null) pgroups = "";
	acno = myResultSet.getString("acno");
	if(acno == null) acno = "";
	for(int i=0; i<empn.length; i++){
		empn[i] = myResultSet.getString("empn"+String.valueOf(i+1));
		if(empn[i] == null) empn[i] = "000000";
		sern[i] = myResultSet.getString("sern"+String.valueOf(i+1));
		crew[i] = myResultSet.getString("crew"+String.valueOf(i+1));
		if(crew[i] == null) crew[i] = "";
		score[i] = myResultSet.getString("score"+String.valueOf(i+1));
		if(score[i] == null) score[i] = "0";
		duty[i] = myResultSet.getString("duty"+String.valueOf(i+1));
		if(duty[i] == null) duty[i] = "X";
		shift[i] = myResultSet.getString("SH_CREW"+String.valueOf(i+1));
		if(shift[i] == null) shift[i] = "X";
		if(!empn[i].equals("000000")) cCount++;		
	}
	book_f = myResultSet.getString("book_f");
	if(book_f == null) book_f = "0";
	book_c = myResultSet.getString("book_c");
	if(book_c == null) book_c = "0";
	book_y = myResultSet.getString("book_y");
	if(book_y == null) book_y = "0";
	pxac = myResultSet.getString("pxac");
	if(pxac == null) pxac = "0";
	inf = myResultSet.getString("inf");
	if(inf == null) inf = "0";
	upd = myResultSet.getString("upd");
	if(upd == null) upd = "";
	for(int i=0; i<sh_staTime.length; i++){
		sh_staTime[i]=myResultSet.getString("SH_ST"+String.valueOf(i+1));
		if(sh_staTime[i] == null) sh_staTime[i] = "";
		sh_endTime[i]=myResultSet.getString("SH_ET"+String.valueOf(i+1));
		if(sh_endTime[i] == null) sh_endTime[i] = "";
	}
	sh_remark = myResultSet.getString("SH_REMARK");
	if(sh_remark == null) sh_remark = "";
	isShift = myResultSet.getString("SHIFT");//Y,N
	if(isShift == null) isShift = "";
	sh_cm = myResultSet.getString("sh_cm");
	if(sh_cm == null) sh_cm = "0";
	mp_empn = myResultSet.getString("mp_empn");//組長
	if(mp_empn == null) mp_empn = "";
	sh_mp = myResultSet.getString("sh_mp");
	if(sh_mp == null) sh_mp = "0";
	
}
else
{
	response.sendRedirect("../showMessage.jsp?messagestring="+URLEncoder.encode("No Record Found !") );
}
//組長-----
if(null != mp_empn && !"".equals(mp_empn)){
	myResultSet.close();
	sql = "Select cname from egtcbas where trim(empn) = trim('"+mp_empn+"')";
	myResultSet= stmt.executeQuery(sql);
	if(myResultSet!= null){
		while(myResultSet.next()){
			mpname = myResultSet.getString("cname");
		}
	}
}

myResultSet.close();

sql = "SELECT trim(empn) empn ,gdtype FROM egtgddt WHERE gdyear='"+GdYear+"' "+
	"AND fltd=to_date('"+fdate+"','yyyy/mm/dd') AND fltno='"+fltno+"' AND gdtype in ('GD1','GD2')";

myResultSet= stmt.executeQuery(sql);
if(myResultSet!= null){
	while(myResultSet.next()){
		if(myResultSet.getString("gdtype").equals("GD1")){
			gsEmpno.add(myResultSet.getString("empn"));
		}else if(myResultSet.getString("gdtype").equals("GD2")){
			baEmpno.add(myResultSet.getString("empn"));
		}
	}
}

//add by cs66 2005/03/02  duty選單,22個選項,
String[] dutySelItem = {"X","Z1","1L","1LA","1R","1RA","Z2","2L","2LA","2R","2RA","UDZ","UDR","UDL","UDA","Z3","3L","3LA","3R","3RA","4L","4LA","4R","4RA","5L","5R","ZC","OD","PA","ACM","DFA"};
%>
   <form name="form1" method="post" action="edReportM_upd.jsp" target="_self" onSubmit="return disableSubmit();">
    <table width="75%" border="0" cellpadding="0" cellspacing="0" align="center">
      <tr>
        <td colspan="3" valign="left">
          <div align="left" class="txtred"></div>
          <span class="txtblue">Cabin  Report&nbsp; &nbsp;</span><span class="red12"><strong> Modify In-Flight Service Grade</strong></span></td>
      </tr><!-- purser -->
      <tr>
        <td colspan="2" valign="middle" class="txtblue"> 
          <div align="left">FDate:<span class="txtred"><%=fdate%>&nbsp;</span>&nbsp;Fltno:<span class="txtred"><%=fltno%>&nbsp;&nbsp;</span>Sector:<span class="txtred"><%=sect%></span>&nbsp;Fleet:<span class="txtred"><%=fleet%></span></div>
        </td>
        <td width="37" valign="middle">&nbsp;</td>
      </tr>
      <tr>
        <td colspan="2" valign="middle" class="txtblue">
          <div align="left">Cabin Manager:<span class="txtred"><%=psrname%>&nbsp;<%=psrsern%>&nbsp;<%=psrempn%></span>&nbsp;CA&nbsp;:<span class="txtred"><%=cpname%></span></div>
        	<%if(null != mp_empn && !"".equals(mp_empn) ){ %>
        	MP:&nbsp;<span class="txtred"><%=mpname%>&nbsp;<%=mp_empn %>&nbsp;</span>
        	<%} %>
        </td><!-- purser -->
        <td valign="middle">&nbsp;</td>
      </tr>
      <tr>
        <td width="359" valign="middle"  class="txtblue">
          <div align="left">A/C:<span class="txtred">
            <input type="text" name="acno" value="<%=acno%>" size="5" maxlength="5">
          </span></div>
        </td>
        <td width="154" valign="middle"><input type="button" value="Delete Report" class="delButon" onClick="return comfirmDel()" name="delButton"> </td>
        <td valign="middle" align="right"></td>
      </tr>
      <tr>
        <td valign="middle"  class="txtblue"> 
          <div align="left">F:<span class="txtred">
            <input name="f" type="text" id="f" value="<%=book_f%>" size="3" maxlength="3"  onkeyup="return checkNUM('f')">
            </span>C:<span class="txtred">
		    <input name="c" type="text" id="c" value="<%=book_c%>" size="3" maxlength="3" onkeyup="return checkNUM('c')">
			</span>Y:<span class="txtred">
			<input name="y" type="text" id="y" value="<%=book_y%>" size="3" maxlength="3" onkeyup="return checkNUM('y')">
			</span>INF:<span class="txtred">
			<input name="inf" type="text" id="inf" value="<%=inf%>" size="3" maxlength="3" onkeyup="return checkNUM('inf')">
			</span>

&nbsp; Pax:
<input type="text" class="txtred" name="ttl" id="ttl" size="5" maxlength="5" style="background-color:<%=bcolor%> ;border:0pt" tabindex="999" value="<%=pxac%>" readonly>
          </div></td>
        <td valign="middle"><span class="txtred">GradeYear：<%=GdYear%></span></td>
        <td valign="middle" align="right"><a href="javascript:window.print()"><img src="../images/print.gif" width="17" height="15" border="0" alt="列印"></a></td>
      </tr>
    </table>
    <br>
	<!-- ************************************ -->
<div align="center" >
<fieldset style="width:80%; border-color: #FF0000;" >
<legend class="txttitletop2">Crew Shift Records</legend>
		<table align="center"  width="90%">
	<tr>  
	  <td align="left">
		<span class="txtxred">本班次是否執行輪休：
	      <label>
	      	<input type="radio" name="shift" value="Y"  onClick="showSh(1);" id="shY"
	      		<%if(isShift.equals("Y")){out.println("checked");} %>>
	      	<span class="txtxred">Yes</span>	      </label>
	      <label>
	      	<input type="radio" name="shift" value="N" onClick="showSh(2);" id="shN"
	      		<%if(isShift.equals("N")){out.println("checked");} %>>
	      	<span class="txtblue">No</span>	      </label>
		</span>
		<span  id="shNote" class="txtblue">Notes:
		  <input type="text" name="shreason" maxlength="2000" size="50" id="shreason" value ="<%=sh_remark%>">
		</span>
		<span style="display:none" id="shRec" class="txtxred"><br>
			<% for(int i=0;i<shiftTime;i++){ %>
			<span class="txtblue">第<%=i+1%>次輪休時間--開始：
				<input name="shst<%=i+1%>" id="shst<%=i+1%>" type="text" size="20" maxlength="20" class="txtblue" readonly="true" value="<%if("".equals(sh_staTime[i]) && i<2) out.print(stdDt);else out.print(sh_staTime[i]);%>"> 			
				</span>
				<span class="txtblue">~結束：
				<input name="shet<%=i+1%>" id="shet<%=i+1%>" type="text" size="20" maxlength="20" class="txtblue" readonly="true" onClick ="displayCalendar(document.forms[0].shet<%=i+1%>,'yyyy/mm/dd hh:ii',this,true);" value="<%if("".equals(sh_endTime[i]) && i<2 ) out.print(stdDt);else out.print(sh_endTime[i]);%>" ">
				<!--<input type="text" onclick="checkTime()">-->
			</span>
			<br>		
			<% } %> 
		<span class="txtblue">CM輪休梯次</span>
		<select name="sh_cm"  id="sh_cm">
          <option value="<%=sh_cm%>"><%if("0".equals(sh_cm)) out.print("X");else out.print(sh_cm);%></option>
          <% for(int j=0;j<=shiftTime;j++){	  %>
			<option value="<%=lshift[j]%>"><%=lshiftShow[j]%></option>
          <%}	  					  %>
        </select>
        <br>
        <%if(null!= mp_empn && !"".equals(mp_empn)){%>
        <span class="txtblue">MP輪休梯次</span>
		<select name="sh_mp"  id="sh_mp">
          <option value="<%=sh_mp%>"><%if("0".equals(sh_mp)) out.print("X");else out.print(sh_mp);%></option>
          <%for(int j=0;j<=shiftTime;j++){	  %>
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
    <table width="75%"  border="0" align="center" cellpadding="2" cellspacing="0" >
    <tr class="tablehead3">
      <td>Name</td>
      <td>EmpNo</td>
      <td>S.No</td>
	  <td>Duty</td>
      <td>Score</td>
      <td>最佳服務</td>
      <td>最佳服儀</td>
      <td>輪休梯次</td>
    </tr>
<%

//for(int i=0;i<empn.length;i++){
for(int i=0;i<cCount;i++){
	if (i%2 == 0){
		bcolor = "#99CCFF";
	}
	else{
		bcolor = "#FFFFFF";
	}	

  		
%>
	<tr bgcolor="<%=bcolor%>">
		<td class="tablebody">
			<input name="crew" type="text" id="crew" style="background-color:<%=bcolor%> ;border:0pt" tabindex="999" value="<%=crew[i]%>"  size="12" readonly>
		</td>
		<td class="tablebody">
			<div align="center">
			  <input name="empn" type="text" id="empn" style="background-color:<%=bcolor%> ;border:0pt" tabindex="999" value="<%=empn[i]%>"  size="6" readonly>
			</div>
		</td>
		<td class="tablebody">
			<input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="6" value="<%=sern[i]%>" name="sern"  tabindex="999"> </td>
		<td class="tablebody">
		<select name="duty" id="duty[<%=i%>]" tabindex="<%=(i+2)%>">
<%
//add by cs66 2005/03/02
	for(int j=0;j<dutySelItem.length;j++)
	{
		if(dutySelItem[j].equals(duty[i]))
		{
			out.print("<option value=\""+dutySelItem[j]+"\" selected>"+dutySelItem[j]+"</option>");
		}
		else
		{
			out.print("<option value=\""+dutySelItem[j]+"\">"+dutySelItem[j]+"</option>");
		}
	}
%>	  
	</select>	  
		</td>
		<td class="tablebody">
	      <select name="score"  tabindex="<%=(1+i)%>">
          <option value="<%=score[i]%>"><%if("0".equals(score[i])) out.print("X");else out.print(score[i]);%></option>
          <%for(int j=0;j<=10;j++){	  %>
			<option value="<%=lscore[j]%>"><%=lscoreShow[j]%></option>
          <%}	  					  %>
        </select></td>
		<%
		%>
		<td class="tablebody"><input type="checkbox" name="gs" value="<%=empn[i]+sern[i]%>"
		<%
	  	for(int j=0;j<gsEmpno.size();j++){	//若有最佳服務，則checked 
			if(((String)gsEmpno.get(j)).equals(empn[i]) ){
				out.print("checked");
			}
		}
		%>
		></td>
		 <td class="tablebody"><input type="checkbox" name="ba" value="<%=empn[i]+sern[i]%>" id = "ba[<%=i %>]" onclick="checkOneBa();"
		<%
		for(int j=0;j<baEmpno.size();j++){	//若有最佳服儀，則checked 
			if(((String)baEmpno.get(j)).equals(empn[i]) ){
				out.print("checked");
			}
		}
		%>
		></td> 
		<td class="tablebody">
			<select name="sh_crew"  tabindex="<%=(1+i)%>" id="sh_crew[<%=i %>]">
			<option value="<%=shift[i]%>"><%if("0".equals(shift[i])) out.print("X");else out.print(shift[i]);%></option>
			<%for(int j=0;j<=shiftTime;j++){%>
			<option value="<%=lshift[j]%>"><%=lshiftShow[j]%></option>
			<%}	  					%>
			</select>
		</td>
	</tr>
	<%
  		//if(empn[i+1].equals("000000")) i = 99;
	}
%>	
</table>
<table width="75%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td width="29">&nbsp;</td>
      <td width="63" valign="top">
         <div align="left" class="txtblue">Total:<%=cCount%></div>
      </td>
      <td width="500"><span class="txttitletop">
        <input name="GiveComments" type="submit" class="addButton" value="Save ( Next ) " tabindex="<%=(cCount+2)%>">  
		&nbsp;&nbsp;&nbsp;
		<input type="button" name="back" value="   Back  " onClick="javascript:history.back(-1)">  
		&nbsp;&nbsp;&nbsp;
		<input type="reset" name="reset" value="Reset" onClick="document.form1.GiveComments.disabled=0;document.form1.delButton.disabled=0;">
	<!--ZC-->
<%
	eg.zcrpt.ZCReport zcrt = new eg.zcrpt.ZCReport();
    zcrt.getZCFltListForPR(fdate,fltno,dpt+arv,psrempn);
	ArrayList zcAL = zcrt.getObjAL();
	if(zcAL.size()>0)
	{
		eg.zcrpt.ZCReportObj zcobj = (eg.zcrpt.ZCReportObj) zcAL.get(0);
		if("Y".equals(zcobj.getIfsent()))
		{//已送出
%>
		&nbsp;&nbsp;&nbsp;
		<!-- ZC改PR -->
		<input type="button" name="viewzc" value="PR Report" class="bu" Onclick="javascript:window.open ('ZC/ZCreport_print.jsp?idx=0&fdate=<%=fdate%>&fltno=<%=fltno%>&port=<%=dpt%><%=arv%>&purempn=<%=psrempn%>','zcreport','height=600, width=800, toolbar=no, menubar=no, scrollbars=yes, resizable=yes');" >
<%
		}//已送出if("Y".equals(zcobj.getIfsent()))
	}//if(zcAL.size()>0)			
%>
	<!--ZC-->
		  <input type="hidden" name="dpt" id="dpt" value="<%=dpt%>">
		  <input type="hidden" name="arv" id="arv" value="<%=arv%>">
		  <input type="hidden" name="fltno" id="fltno" value="<%=fltno%>">
		  <input type="hidden" name="fdate" id="fdate" value="<%=fdate%>">
		  <input type="hidden" name="stdDt" id="stdDt" value="<%=stdDt%>">
		  <input type="hidden" name="CA" id="CA" value="<%=cpno%>&nbsp;<%=cpname%>">
          <input type="hidden" name="CACName" id="CACName" value="<%=cpname%>">   		
          <input type="hidden" name="CAEmpno" id="CAEmpno" value="<%=cpno%>"> 
		  <input type="hidden" name="purserEmpno" id="purserEmpno" value="<%=psrempn%>">
		  <input type="hidden" name="psrsern" id="psrsern" value="<%=psrsern%>">
		  <input type="hidden" name="psrname" id="psrname" value="<%=psrname%>">
		  <input type="hidden" name="pgroups" id="pgroups" value="<%=pgroups%>">
		  <input type="hidden" name="total" id="total" value="<%=cCount%>">
		  <input type="hidden" name="GdYear" id="GdYear" value="<%=GdYear%>">		
		  <input type="hidden" name="fleet" id="fleet" value="<%=fleet%>">		
		  <input type="hidden" name="mp_empn" id="mp_empn" value="<%=mp_empn%>">
		  <input type="hidden" name="mpname" id="mpname" value="<%=mpname%>">
     </td>
    </tr>
</table>
</form>
</body>
</html>
<jsp:scriptlet>
}
catch (Exception e)
{
	  out.print(e.toString());
		//  response.sendRedirect("../showMessage.jsp?messagestring="+URLEncoder.encode("系統忙碌中，請稍後再試"));
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
</jsp:scriptlet>


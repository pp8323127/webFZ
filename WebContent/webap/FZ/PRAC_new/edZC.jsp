<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*"  %>
<%
String userid = (String)session.getAttribute("userid");
if(userid == null){
	response.sendRedirect("../sendredirect.jsp");
}else{
String fltd = null;
if( !"".equals(request.getParameter("fltd")) && null != request.getParameter("fltd")){
	 fltd = request.getParameter("fltd");
}

String fltno = null;
if( !"".equals(request.getParameter("fltno")) && null != request.getParameter("fltno")){
	fltno = request.getParameter("fltno");
}
String sect = null;
if( !"".equals(request.getParameter("sect")) && null != request.getParameter("sect")){
	sect = request.getParameter("sect");
}
String empno= null;
if( !"".equals(request.getParameter("empno")) && null != request.getParameter("empno")){
	empno =  request.getParameter("empno");
}
String cname = "";

boolean status = false;
String errMsg = "";

//取得基本資料
fzac.CrewInfo c = new fzac.CrewInfo(empno);
fzac.CrewInfoObj o = c.getCrewInfo();

if (c.isHasData()) {
	cname=o.getCname();
}


//取得ZC考評項目、敘述
fz.pracP.zc.EvaluationType evalType = new fz.pracP.zc.EvaluationType();
ArrayList evalTypeAL = evalType.getDataAL();
status = true;

//取得ZC考評資料
fz.pracP.zc.ZoneChiefEvalData zcData = new fz.pracP.zc.ZoneChiefEvalData(fltd,fltno,sect,empno);
ArrayList evalScoreDataAL = null;
try{
	zcData.SelectData();
	evalScoreDataAL = zcData.getDataAL();
	status = true;
	
}catch(Exception e){
	status = false;
	errMsg = e.toString();
}



%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Zone Chief Evaluation Score</title>
<link rel="stylesheet" type="text/css" href="../errStyle.css">
<link rel="stylesheet" type="text/css" href="ZC/style.css">
<link rel="stylesheet" type="text/css" href="../kbd.css">
<script type="text/javascript" src="alttxt.js"></script> 
<script language="javascript" type="text/javascript">
function disableButton(){
		document.getElementById("exitButton").disabled=1;
		document.getElementById("resetButton").disabled=1;
		if(document.getElementById("delButton") != null){
			document.getElementById("delButton").disabled=1;
		}
		document.getElementById("SaveButton").disabled=1;			
}
function goDel(){
	if(confirm("確定要刪除此筆資料？")){
		document.form1.action="delZC.jsp";
		document.form1.submit();
		disableButton();
		return true;
	}else{
		return false;
	}	
}

function compose_note(colname)
{
	var c_value = "";
	for (var i=0; i < eval("document.form1.str_"+colname+".length"); i++)
	{
		if (eval("document.form1.str_"+colname+"[i].checked"))
		{
			c_value = c_value+" "+ eval("document.form1.str_"+colname+"[i].value") ;
		}
	}

	document.getElementById("comm"+colname).value = c_value ;
}



</script>
</head>

<body class="center">
<%
if(!status)
{
%>
<div class="errStyle1"><%=errMsg%></div>
<%
}
else
{
	if(evalTypeAL != null){
%>
<center>
<div class="blue"><span style="font-size:large;font-weight:bold; " >Purser Evaluation Score</span><br>
<%=fltd%> <%=fltno%> / <%=sect%> <%=empno%> <%=cname%></div>
<form name="form1" action="updZC.jsp" method="post" onSubmit="return checkForm()">
<table cellpadding="0" cellspacing="2" class="tableBorder1">
	<tr class="tableInner3">
    <td >Evaluation Item</td>
    <td >Score<br>(1~10)</td>
	<td >Comments</td>	
	<td>Template</td>	
	</tr>
<%
for(int i=0;i<evalTypeAL.size();i++)
{
	fz.pracP.zc.EvaluationTypeObj evalObj = (fz.pracP.zc.EvaluationTypeObj)evalTypeAL.get(i);
	String classType = "";
	if(i%2 == 0)
	{
		classType ="";
	}
	else
	{
		classType = "class='tableInner2'";
	}
%>
<tr <%=classType%>>
	<td valign="top"><%=evalObj.getScoreDesc()%>
	<img title="<%=evalObj.getDescDetail()%>"  src="../images/qa2.gif" style="vertical-align:text-top;" width="22" height="22">	
	<!--<a href="#" onmouseover="writetxt('<%=evalObj.getDescDetail()%>')" onmouseout="writetxt(0)"><img src="../images/qa2.gif" width="22" height="22" border="0"></a>-->
	</td>
	<!--<div id="navtxt" class="navtext" style="position:absolute; color:red; top:100px; left:100px; visibility:hidden">
	</div>-->
	<td valign="top">
	<select name="score<%=evalObj.getScoreType()%>" id="score<%=evalObj.getScoreType()%>" >
	<option value="">請選擇</option>
	<%
	for( int sel=10;sel>0;sel--)
	{
		out.print("<option value=\""+sel+"\">"+sel+"</option>");
	}
	%>
	</select>
	</td>
	<td class="left" valign="top">	
	 <textarea name="comm<%=evalObj.getScoreType()%>" id="comm<%=evalObj.getScoreType()%>" cols="30" rows="3"></textarea>
	</td>
	<td class="left">
<%
	if("領導統御".equals(evalObj.getScoreDesc()))		
	{
%>
		<input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="具組織力與決斷力" onclick="compose_note('<%=evalObj.getScoreType()%>')">具組織力與決斷力&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="溝通協調能力佳" onclick="compose_note('<%=evalObj.getScoreType()%>')">溝通協調能力佳<br>
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="判斷力與決斷力不足" onclick="compose_note('<%=evalObj.getScoreType()%>')">判斷力與決斷力不足&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="缺乏溝通技巧" onclick="compose_note('<%=evalObj.getScoreType()%>')">缺乏溝通技巧<br>
<%	
	}

	if("團隊合作".equals(evalObj.getScoreDesc()))		
	{
%>
		<input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="善用人物資源" onclick="compose_note('<%=evalObj.getScoreType()%>')">善用人物資源&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="團隊工作績效佳" onclick="compose_note('<%=evalObj.getScoreType()%>')">團隊工作績效佳<br>
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="自我意識強、無法善用人物資源" onclick="compose_note('<%=evalObj.getScoreType()%>')">自我意識強、無法善用人物資源<br>
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="團隊工作績效差" onclick="compose_note('<%=evalObj.getScoreType()%>')">團隊工作績效差<br>
<%	
	}

	if("作業認知".equals(evalObj.getScoreDesc()))		
	{
%>
		<input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="具客艙安全作業職能" onclick="compose_note('<%=evalObj.getScoreType()%>')">具客艙安全作業職能&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="落實服務程序" onclick="compose_note('<%=evalObj.getScoreType()%>')">落實服務程序<br>
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="判斷力與決斷力不足" onclick="compose_note('<%=evalObj.getScoreType()%>')">判斷力與決斷力不足&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="缺乏溝通技巧" onclick="compose_note('<%=evalObj.getScoreType()%>')">缺乏溝通技巧<br>
<%	
	}
%>	


<%
	if("顧客導向".equals(evalObj.getScoreDesc()))		
	{
%>
		<input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="能掌握旅客資訊" onclick="compose_note('<%=evalObj.getScoreType()%>')">能掌握旅客資訊&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="能滿足顧客期待" onclick="compose_note('<%=evalObj.getScoreType()%>')">能滿足顧客期待<br>
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="無法正確掌握旅客資訊" onclick="compose_note('<%=evalObj.getScoreType()%>')">無法正確掌握旅客資訊&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="缺乏服務熱忱" onclick="compose_note('<%=evalObj.getScoreType()%>')">缺乏服務熱忱<br>
<%	
	}
%>	


<%
	if("語言能力".equals(evalObj.getScoreDesc()))		
	{
%>
		<input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="外語表達能力佳" onclick="compose_note('<%=evalObj.getScoreType()%>')">外語表達能力佳&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="表達能力佳、掌握溝通技巧" onclick="compose_note('<%=evalObj.getScoreType()%>')">表達能力佳、掌握溝通技巧<br>
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="外語表達能力弱" onclick="compose_note('<%=evalObj.getScoreType()%>')">外語表達能力弱&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="表達、應對須加強" onclick="compose_note('<%=evalObj.getScoreType()%>')">表達、應對須加強<br>
<%	
	}
%>	

<%
	if("情感模式".equals(evalObj.getScoreDesc()))		
	{
%>
		<input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="情緒管理佳" onclick="compose_note('<%=evalObj.getScoreType()%>')">情緒管理佳&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="具同理心  □具親和力" onclick="compose_note('<%=evalObj.getScoreType()%>')">具同理心、具親和力<br>
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="情緒管理須加強" onclick="compose_note('<%=evalObj.getScoreType()%>')">情緒管理須加強&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="冷淡、不易融入人群" onclick="compose_note('<%=evalObj.getScoreType()%>')">冷淡、不易融入人群<br>
<%	
	}
%>	

<%
	if("危機處理".equals(evalObj.getScoreDesc()))		
	{
%>
		<input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="從容應變、事件掌控能力佳" onclick="compose_note('<%=evalObj.getScoreType()%>')">從容應變、事件掌控能力佳&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="警覺性高" onclick="compose_note('<%=evalObj.getScoreType()%>')">警覺性高<br>
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="慌亂、缺乏應變能力" onclick="compose_note('<%=evalObj.getScoreType()%>')">慌亂、缺乏應變能力&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="情境警覺不足" onclick="compose_note('<%=evalObj.getScoreType()%>')">情境警覺不足<br>
<%	
	}
%>	

<%
	if("外顯行為".equals(evalObj.getScoreDesc()))		
	{
%>
		<input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="服儀整潔" onclick="compose_note('<%=evalObj.getScoreType()%>')">服儀整潔&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="笑容親切  □謙恭有禮" onclick="compose_note('<%=evalObj.getScoreType()%>')">笑容親切、謙恭有禮&nbsp;&nbsp;
		<input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="缺乏笑容" onclick="compose_note('<%=evalObj.getScoreType()%>')">缺乏笑容<br>
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="服儀不符儀容規定" onclick="compose_note('<%=evalObj.getScoreType()%>')">服儀不符儀容規定&nbsp;&nbsp;	    
		<input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="態度散漫、紀律不足" onclick="compose_note('<%=evalObj.getScoreType()%>')">態度散漫、紀律不足<br>
<%	
	}

	if("人格特質".equals(evalObj.getScoreDesc()))		
	{
%>
		<input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="樂觀進取" onclick="compose_note('<%=evalObj.getScoreType()%>')">樂觀進取&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="認真負責" onclick="compose_note('<%=evalObj.getScoreType()%>')">認真負責&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="投機取巧" onclick="compose_note('<%=evalObj.getScoreType()%>')">投機取巧<br>
		<input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="察言觀色、進退有節" onclick="compose_note('<%=evalObj.getScoreType()%>')">察言觀色、進退有節&nbsp;&nbsp;
		<input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="無法信賴" onclick="compose_note('<%=evalObj.getScoreType()%>')">無法信賴&nbsp;&nbsp;<br>
<%	
	}

	if("專業素養".equals(evalObj.getScoreDesc()))		
	{
%>
		<input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="跨部作業整合能力佳" onclick="compose_note('<%=evalObj.getScoreType()%>')">跨部作業整合能力佳&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="具飛航安全相關知識" onclick="compose_note('<%=evalObj.getScoreType()%>')">具飛航安全相關知識<br>
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="具空服專業知識" onclick="compose_note('<%=evalObj.getScoreType()%>')">具空服專業知識&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="服務技巧純熟" onclick="compose_note('<%=evalObj.getScoreType()%>')">服務技巧純熟<br>
		<input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="跨部作業整合能力薄弱" onclick="compose_note('<%=evalObj.getScoreType()%>')">跨部作業整合能力薄弱&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="缺乏飛航安全知識" onclick="compose_note('<%=evalObj.getScoreType()%>')">缺乏飛航安全知識<br>
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="空服專業知識不足" onclick="compose_note('<%=evalObj.getScoreType()%>')">空服專業知識不足&nbsp;&nbsp;
	    <input type="checkbox" name="str_<%=evalObj.getScoreType()%>" value="服務技巧不足" onclick="compose_note('<%=evalObj.getScoreType()%>')">服務技巧不足<br>

<%	
	}
%>	

	</td>
</tr>
<%
}
%>	
<tr>
  <td colspan="4">
<input type="submit" name="SaveButton" id="SaveButton" value="Save (儲存)" class="kbd">
&nbsp;&nbsp;&nbsp;
<%
if(evalScoreDataAL != null){
	fz.pracP.zc.ZoneChiefEvalObj obj = (fz.pracP.zc.ZoneChiefEvalObj)evalScoreDataAL.get(0);
	
%>
<input name="resetButton" type="button" class="kbd" id="resetButton" onClick="initData()" value="Reset (清除重寫)">
&nbsp;&nbsp;&nbsp;
<input name="delButton" type="button" class="kbd" id="delButton"  onClick="return goDel()" value="Delete (刪除)">  
&nbsp;&nbsp;&nbsp;
<input type="hidden" name="seqno" value="<%=obj.getSeqno()%>">
<%
}else{
%>
<input type="reset" class="kbd" id="resetButton" value="Reset (清除重寫)">
&nbsp;&nbsp;&nbsp;
<input type="hidden" name="seqno" value="">
<%
}
%>
<input name="exitButton" type="button" class="kbd" id="exitButton"  onClick="javascript:self.close()" value="Exit (離開)">  

<input type="hidden" name="fltd" value="<%=fltd%>">
<input type="hidden" name="fltno" value="<%=fltno%>">
<input type="hidden" name="sect" value="<%=sect%>">
<input type="hidden" name="empno" value="<%=empno%>">

  </td>
</tr>
<tr class="r">
  <td colspan="4" class="left">*各項考評分數均需填寫，不得空白.<br>
    *各考評項目詳細說明，可將滑鼠移至<img src="../images/qa2.gif"  width="22" height="22" style="vertical-align:text-top; " > 圖示檢視.</td>
</tr>

</table>
</form>
<script language="javascript" type="text/javascript">
	function checkForm(){
<%
for(int i=0;i<evalTypeAL.size();i++){
	fz.pracP.zc.EvaluationTypeObj evalJSObj = (fz.pracP.zc.EvaluationTypeObj)evalTypeAL.get(i);
		
%>
	if(document.getElementById("score<%=evalJSObj.getScoreType()%>").value ==""){
		alert("請選擇 [<%=evalJSObj.getScoreDesc()%>] 項目之分數");
		document.getElementById("score<%=evalJSObj.getScoreType()%>").focus();
		return false;
	}
<%
}
%>			
	disableButton();

	return true;
	}
</script>
<%
if(evalScoreDataAL != null){
%>
<script language="javascript" type="text/javascript">
	function initData(){
	<%
		for(int index = 0;index < evalScoreDataAL.size(); index ++){
			fz.pracP.zc.ZoneChiefEvalObj obj = (fz.pracP.zc.ZoneChiefEvalObj)evalScoreDataAL.get(index);
			
	%>
			document.getElementById("score<%=obj.getScoreType()%>").value = "<%=Integer.toString(obj.getScore())%>";
			document.getElementById("score<%=obj.getScoreType()%>")[document.getElementById("score<%=obj.getScoreType()%>").selectedIndex].style.color = "#FF0000";
			document.getElementById("comm<%=obj.getScoreType()%>").value = "<%=obj.getComm()%>";

	<%	
		}
	%>										
	}
	initData();
</script>

<%
} //end of has Eval Data and initial it.

	}//end of evalTypeAL != null
	else{
%>
<div class="errStyle1">資料庫連線失敗，請稍後再試.</div>
<%	
	}
}//end of status = true;
%>
</center>
</body>
</html>
<%
}
%>
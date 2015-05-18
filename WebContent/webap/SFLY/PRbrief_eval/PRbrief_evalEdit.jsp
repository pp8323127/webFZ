<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.util.*,eg.prfe.*" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("../logout.jsp");
}

String empno	= request.getParameter("empno");
String sdate	= request.getParameter("sdate");
String purname  = "";
String pursern  = "";
String time_hh  = "";
String time_mi  = "";
String newname = "";
String newuser = "";

//被查核人
empno = eg.GetEmpno.getEmpno(empno);
eg.EGInfo egi = new eg.EGInfo(empno);
eg.EgInfoObj purobj = egi.getEGInfoObj(empno); 
if(purobj !=null)
{
	empno   = purobj.getEmpn();
	pursern = purobj.getSern();
	purname = purobj.getCname();
}
//查核人
eg.HRInfo hr = new eg.HRInfo(userid);
newname = hr.getCname(userid);
newuser = userid;

PRBriefEval prbe = new PRBriefEval();
prbe.getPRBriefEval(sdate,sdate,empno);
ArrayList objAL = new ArrayList();
objAL = prbe.getObjAL();
PRBriefEvalObj obj = new PRBriefEvalObj();
if(objAL.size()>0)
{
	obj = (PRBriefEvalObj) objAL.get(0);  
	fz.splitString p = new fz.splitString();
    String[] str = p.doSplit(obj.getBrief_time(),":");
    if(str.length >=2)
	{
		time_hh = str[0];
		time_mi = str[1];
	}		
	newname = obj.getNewname();
	newuser = obj.getNewuser();
}
%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>客艙經理/事務長任務簡報表現</title>
<link href="../style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="alttxt.js"></script> 
<script LANGUAGE="JavaScript">
function chkRequest()
{
	var brief_hh = eval("document.form1.brief_hh.value");
	var brief_mi = eval("document.form1.brief_mi.value");
	var fltno = eval("document.form1.fltno.value");
	var chk1 = eval("document.form1.chk1.value");
	var chk2 = eval("document.form1.chk2.value");
	var chk3 = eval("document.form1.chk3.value");
	var chk4 = eval("document.form1.chk4.value");
	var chk5 = eval("document.form1.chk5.value");
	
	 if(brief_hh =="")
	 {
		alert("請輸入報到時間!!");
		document.form1.brief_hh.focus();
		return false;
	 }
	 else if(brief_mi =="")
	 {
		alert("請輸入報到時間!!");
		document.form1.brief_mi.focus();
		return false;
	 }
	 else if(fltno =="")
	 {
		alert("請輸入任務班號!!");
		document.form1.fltno.focus();
		return false;
	 }
	 else if(chk1 == "" | chk1 == null | parseInt(chk1) >20 | parseInt(chk1) <0  )
	 {
		alert("分數需介於 0~20!!");
		document.form1.chk1.focus();
		return false;
	 }
	 else if(chk2 == "" | chk2 == null |parseInt(chk2) >20 | parseInt(chk2) <0  )
	 {
		alert("分數需介於 0~20!!");
		document.form1.chk2.focus();
		return false;
	 }
	 else if(chk3 == "" | chk3 == null | parseInt(chk3) >20 | parseInt(chk3) <0  )
	 {
		alert("分數需介於 0~20!!");
		document.form1.chk3.focus();
		return false;
	 }
	 else if(chk4 == "" | chk4 == null | parseInt(chk4) >20 | parseInt(chk4) <0  )
	 {
		alert("分數需介於 0~20!!");
		document.form1.chk4.focus();
		return false;
	 }
	 else if(chk5 == "" | chk5 == null | parseInt(chk5) >20 | parseInt(chk5) <0  )
	 {
		alert("分數需介於 0~20!!");
		document.form1.chk5.focus();
		return false;
	 }
	 else
	 {
		document.form1.Submit.disabled=1;
		return true;
	 }
}
</script>
<style type="text/css">
<!--
.style3 {color: #000000}
.style4 {
	font-size: 12px;
	font-weight: bold;
}
.navtext 
{ 
width:200px; 
font-size:8pt; 
border: 1px solid #fff; 
background-color:#FFCCFF;
color:#39c; 
} 
-->
</style>

</head>

<body>
<form name="form1" method="post" action="insPRBE.jsp"  Onsubmit = " return chkRequest();">
<input name="empno" type="hidden" value="<%=empno%>">
<input name="sdate" type="hidden" value="<%=sdate%>">
<table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0">
  <tr>
    <td>
      <div align="center"><span class="txttitletop">客艙經理/事務長任務簡報表現評量 </span></div>
    </td>
  </tr>
</table>
<table width="90%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr class="txtblue">
	  	<td width="20%" align="center" class="tablehead3"><strong>任務日期</strong></div></td>
		<td width="20%"><div align="center" class="tablehead3"><strong>報到時間</strong></div></td>
    	<td width="20%"><div align="center" class="tablehead3"><strong>任務班號</strong></div></td>
    	<td width="20%" align="center" class="tablehead3"><strong>客艙經理/事務長</strong></div></td>
    	<td width="20%" align="center" class="tablehead3"><strong>查核人</strong></div></td>
  	</tr> 
	<tr class="txtblue">
	  	<td width="20%" align="center"><%=sdate%></td>
	  	<td width="20%" align="center" ><input name="brief_hh" id="brief_hh" type="text" value="<%=time_hh%>"  size="2" maxlength="2">:<input name="brief_mi" id="brief_mi" type="text" value="<%=time_mi%>"  size="2" maxlength="2"></td>
		<td width="20%" align="center" ><input name="fltno" id="fltno" type="text" value="<%=obj.getFltno()%>"  size="5" maxlength="5"></td>
		<td width="20%" align="center"><%=empno%>/<%=pursern%>/<%=purname%></td>
		<td width="20%" align="center"><%=newname%></td>
  	</tr> 
</table>
<table width="90%" border="1" align="center" cellpadding="1" cellspacing="1" class="fortable">
  	<tr>
	   <td align="center" class="tablehead3"><a href="#" onmouseover="writetxt('1.人員掌控是否得宜<br>2.簡報時間是否運用得宜<br>3.能否有效激勵現場士氣<br>4.能否有效創造現場氣氛')" onmouseout="writetxt(0)"><span class="tablehead3"><strong>現場環境<br>掌控能力</strong></span></a></td>
		<div id="navtxt" class="navtext" style="position:absolute; top:-100px; left:10px; visibility:hidden"></div>
   	   <td align="center" class="tablehead3"><a href="#" onmouseover="writetxt('1.是否具備執行該航段必備之Safety&Service知識<br>2.是否了解即時最新公告並正確傳達<br>3.是否宣達本月份飛安與有關服務之宣達事項<br>4.飛安提問是否掌握重點-Check knowledge避免reteach<br>')" onmouseout="writetxt(0)"><span class="tablehead3"><strong>專業知識<br>運用能力</strong></span></a></td>
   	   <td align="center" class="tablehead3"><a href="#" onmouseover="writetxt('1.與組員互動關心的幅度<br>2.能創造合理活潑關係')" onmouseout="writetxt(0)"><span class="tablehead3"><strong>人際關係<br>認知能力</strong></span></a></td>
       <td align="center" class="tablehead3"><a href="#" onmouseover="writetxt('1.是否使用適當語言<br>2.是否能把握要點，做結構性說明<br>3.表達是否清晰、要求明確')" onmouseout="writetxt(0)"><span class="tablehead3"><strong>口語表達<br>溝通能力</strong></span></a></td>
   	   <td align="center" class="tablehead3"><a href="#" onmouseover="writetxt('1.是否確實執行簡報必要項目<br>a.General-Check & Inform<br>-証照<br>-服裝儀容<br>-個人裝備〈手電筒、絲襪〉<br>-組員介紹、任務分配<br>-旅客資訊〈如mvc及旅客預報〉<br>b.A/C General<br>-利用機種投影片，做重點介紹<br>或以Q&A方式詢問相關組員<br>c.Flt Safety Issue<br>  -以一對一Q&A方式進行，詢問<br>飛安宣導議題或ETS當月有關<br>A/C、General Part、Safety之內容<br>詢問主題以Procedure之完整性為佳<br>d.航班服務重點提示<br>-如CI-065注意酒精性飲料提供，<br>以免旅客酗酒滋擾<br>-CIQ相關規定<br>-手提行李處理、推車服務走道淨 <br> 空、避免工作傷害<br>e.座艙長之期許<br>-如何激勵同仁<br>-團隊合作，資源及資訊分享<br>-自我期許<br>2.是否給予正確的工作指導<br>3.是否達到簡報預期效果<br>4.是否有能力改善現場缺失')" onmouseout="writetxt(0)"><span class="tablehead3"><strong>任務簡報<br>管理能力</strong></span></a></td>
    </tr>

	 <tr>
       <td align="center" valign="middle"><input name="chk1" id="chk1" type="text" value="<%=obj.getChk1_score()%>"  size="2" maxlength="2"></td>
      <td align="center" valign="middle"><input name="chk2" id="chk2" type="text" value="<%=obj.getChk2_score()%>"  size="2" maxlength="2"></td>
	  <td align="center" valign="middle"><input name="chk3" id="chk3" type="text" value="<%=obj.getChk3_score()%>"  size="2" maxlength="2"></td>
	  <td align="center" valign="middle"><input name="chk4" id="chk4" type="text" value="<%=obj.getChk4_score()%>"  size="2" maxlength="2"></td>
	  <td align="center" valign="middle"><input name="chk5" id="chk5" type="text" value="<%=obj.getChk5_score()%>"  size="2" maxlength="2"></td>
  	</tr>
</table>
<table width="90%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr class="txtblue">
	  	<td width="25%" align="center" class="tablehead3">General Comment</td>
	  	<td width="75%" align="center"><textarea name="comm" id="comm" cols= "50" rows = "10"><%=obj.getComm()%></textarea></td>
  	</tr> 
</table>
<%
if(purname == null | "".equals(purname))
{
%>
<p class = "txtred" align="center">請確認被查核人員是否正確!!</p>
<%
}
%>

<%
String ifallowupdate = "disabled";
if(userid.equals(newuser))
{
	ifallowupdate = "";
}
%>
<table width="90%"  border="0" align="center"> 
	<tr><td align= "center"><br><input name="Submit" type="Submit" value=" SUBMIT " <%=ifallowupdate%>></td></tr>
</table>
</form>
</body>
</html>
<%
session.setAttribute("objAL", objAL);
%>

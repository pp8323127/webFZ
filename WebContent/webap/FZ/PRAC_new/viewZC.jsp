<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*"  %>
<%
String userid = (String)session.getAttribute("userid");
/*if(userid == null){
// response.sendRedirect("");
}else{*/
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
	if(evalTypeAL != null)
	{
%>
<center>
<div class="blue"><span style="font-size:large;font-weight:bold; " >Purser Evaluation Score</span><br>
<%=fltd%> <%=fltno%> / <%=sect%> <%=empno%> <%=cname%></div>
<table width="667" cellpadding="0" cellspacing="2" class="tableBorder1">
  <tr class="tableInner3">
    <td width="132">Evaluation Item</td>
    <td width="89">Score<br>
    (1~10)</td>
	<td width="436">Comments</td>	
  </tr>
<%
for(int index = 0;index < evalScoreDataAL.size(); index ++){
	fz.pracP.zc.ZoneChiefEvalObj obj = (fz.pracP.zc.ZoneChiefEvalObj)evalScoreDataAL.get(index);
	fz.pracP.zc.EvaluationTypeObj evalJSObj = (fz.pracP.zc.EvaluationTypeObj)evalTypeAL.get(index);
	
	
	String classType = "";
	if(index%2 == 0){
		classType ="";
	}else{
		classType = "class='tableInner2'";
	}
%>
<tr <%=classType%>>
	<td><%= evalJSObj.getScoreDesc()%><img title="<%=evalJSObj.getDescDetail()%>"  src="../images/qa2.gif" style="vertical-align:text-top;" width="22" height="22">	
	</td>
	<td><%=Integer.toString(obj.getScore())%>
	</td>
	<td class="left"><%=obj.getComm()%> </td>
</tr>

<%

}

%>	
<tr>
  <td colspan="3">
<input name="exitButton" type="button" class="kbd" id="exitButton" onClick="javascript:self.close()" value="Exit (離開)"> </td>
</tr>
<tr class="r">
  <td colspan="3" class="left">    *各考評項目詳細說明，可將滑鼠移至<img src="../images/qa2.gif"  width="22" height="22" style="vertical-align:text-top; " > 圖示檢視.</td>
</tr>

</table>


<%
} //end of has Eval Data and initial it.

	//end of evalTypeAL != null
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
//}
%>
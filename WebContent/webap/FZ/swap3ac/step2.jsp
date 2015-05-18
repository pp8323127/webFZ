<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,swap3ac.*" %>
<%
//session.setAttribute("aPrjcr","0");
//session.setAttribute("rPrjcr","0");
session.setAttribute("aEmpno",null);
session.setAttribute("rEmpno",null);
session.setAttribute("aApplyTimes",null);
session.setAttribute("rApplyTimes",null);

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>AirCrews3次換班申請Step2</title>
<script language="javascript" type="text/javascript" src="../js/showDate.js"></script>
<link href="swap.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="../errStyle.css">
</head>
<body >
<%

//String aEmpno = (String)session.getAttribute("userid"); //request.getParameter("aEmpno");
String aEmpno = (String)request.getParameter("aEmpno");
String rEmpno = (String)request.getParameter("rEmpno");
String year   = request.getParameter("year");
String month   = request.getParameter("month");
session.setAttribute("aEmpno",aEmpno);
session.setAttribute("rEmpno",rEmpno);

swap3ac.ApplyCheck ac1 = new swap3ac.ApplyCheck();
ac1.SelectDateAndCount();

if( ac1.isLimitedDate()){//非工作日
%>
  <p  class="errStyle1">系統目前不受理換班，請於<%=ac1.getLimitenddate()%>後開始遞件<BR>
可能原因為：1.例假日2.緊急事故(颱風)</p>
<%

}else if( ac1.isOverMax()){ //超過處理上限
%>
<p  class="errStyle1">已超過系統單日處理上限！</p>
<%	
}

//檢查班表是否公布
swap3ac.PublishCheck pc = new swap3ac.PublishCheck(year, month);
swap3ac.ApplyCheck ac = new swap3ac.ApplyCheck(aEmpno,rEmpno,year,month);
//add by Betty on 20080512
//***********************************************************************
//申請者是否全勤
CheckFullAttendance acs = new CheckFullAttendance(aEmpno, year+month);
String a_isfullattendance = acs.getCheckMonth();
//被換者是否全勤
CheckFullAttendance rcs = new CheckFullAttendance(rEmpno, year+month);
String r_isfullattendance = rcs.getCheckMonth();
String displaystr = "";
if(!"Y".equals(a_isfullattendance))
{
	displaystr = a_isfullattendance;
}
if(!"Y".equals(r_isfullattendance))
{
	displaystr = r_isfullattendance;
}
//***********************************************************************
if(ac.isUnCheckForm()){	//有申請單尚未核可，不可申請
%>
<p  class="errStyle1">申請者(<%=aEmpno%>)&nbsp;
			或被換者(<%=rEmpno%>)&nbsp;有申請單尚未經ED核可, <br>		
系統不受理遞單.</p>
<%
//add by Betty on 20080512
//***********************************************************************
}
else if (!"Y".equals(a_isfullattendance) | !"Y".equals(r_isfullattendance) )
{
%>
<p  class="errStyle1"><%=displaystr%> </p>
<%
//***********************************************************************
}
else if (ac.getAApplyTimes() >=3 )
{ // 申請者當月申請次數高於3次，不可申請
%>
<p  class="errStyle1">申請者(<%=aEmpno%>)&nbsp; 
			 <%=year+"/"+month %>申請次數已超過三次, <br>		
			系統不受理遞單.</p>
<%

}else if (ac.getRApplyTimes() >=3 ){ // 被換者當月申請次數高於3次，不可申請
%>
<p  class="errStyle1">被換者(<%=rEmpno%>)&nbsp; 
			 <%=year+"/"+month %>申請次數已超過三次, <br>		
			系統不受理遞單.</p>
<%

}else if(ac.isALocked()){//申請者班表鎖定,(正常狀況應該不會發生，鎖定者看不到換班的功能選項)
%>
<p class="errStyle1">申請者(<%=rEmpno%>)&nbsp; 
			班表為鎖定狀態, <br>		
			系統不受理遞單.<br>
			（換班雙方需設定班表為開放狀態,方可使用換班功能）.</p>
<%
}else if(ac.isRLocked()){//被換者班表鎖定
%>
<p  class="errStyle1">被換者(<%=rEmpno%>)&nbsp; 
			班表為鎖定狀態, <br>		
			系統不受理遞單.<br>
			（換班雙方需設定班表為開放狀態,方可使用換班功能）.</p>
<%
}
//班表是否公布
else if(!pc.isPublished()){
%>
<p  class="errStyle1"><%=year+"/"+month%> 班表尚未正式公布，系統不受理遞單.</p>
<%
}

else
{

//設定已換次數
session.setAttribute("aApplyTimes",Integer.toString(ac.getAApplyTimes()));
session.setAttribute("rApplyTimes",Integer.toString(ac.getRApplyTimes()));

/*response.sendRedirect("applicant.jsp?aEmpno="+aEmpno+"&rEmpno="+rEmpno+"&year="
			  +year+"&month="+month);
*/
response.sendRedirect("checkRetire.jsp?aEmpno="+aEmpno+"&rEmpno="+rEmpno+"&year="
			  +year+"&month="+month);

}

%>

</body>
</html>
<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,swap3ackhh.*" %>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

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
//三次換班
//Crew A 使用積點申請, Crew B 使用三次換班申請
String aEmpno = (String)session.getAttribute("userid");//request.getParameter("aEmpno");
String rEmpno = request.getParameter("rEmpno");
String year   = request.getParameter("year");
String month   = request.getParameter("month");
String asno   = request.getParameter("asno");
String source   = request.getParameter("source");
//out.print("source >> "+ source+" aEmpno >>"+ aEmpno + " rEmpno >> "+ rEmpno + " year >> "+ year + " month >> "+ month+ " asno >> "+ asno +"<br>");
session.setAttribute("aEmpno",aEmpno);
session.setAttribute("rEmpno",rEmpno);

//檢查班表是否公布
PublishCheck pc = new PublishCheck(year, month);
//***********************************************************************
//被換者選擇三次換班權利,需檢核是否全勤
swap3ac.CheckFullAttendance rcs = new swap3ac.CheckFullAttendance(rEmpno, year+month);
String r_isfullattendance = rcs.getCheckMonth();
String displaystr = "";
if(!"Y".equals(r_isfullattendance))
{
	displaystr = r_isfullattendance;
}
//out.println("displaystr >>"+displaystr+"<br>");
//***********************************************************************
ApplyCheck ac = new ApplyCheck(aEmpno,rEmpno,year,month);
if(ac.isUnCheckForm())
{	//有申請單尚未核可，不可申請
%>
<p  class="errStyle1">申請者(<%=aEmpno%>)&nbsp;
			或被換者(<%=rEmpno%>)&nbsp;有申請單尚未經ED核可, <br>		
系統不受理遞單.</p>
<%
//***********************************************************************
}
else if (!"Y".equals(r_isfullattendance) )
{
%>
<p  class="errStyle1"><%=displaystr%> </p>
<%
//***********************************************************************
}
else if (ac.getRApplyTimes() >=3 ){ // 被換者當月申請次數高於3次，不可申請
%>
<p  class="errStyle1">被換者(<%=rEmpno%>)&nbsp; 
			 <%=year+"/"+month %>申請次數已超過三次, <br>		
			系統不受理遞單.</p>
<%

}
//班表是否公布
else if(!pc.isPublished())
{
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
response.sendRedirect("creditSwap_step6_checkRetire.jsp?aEmpno="+aEmpno+"&rEmpno="+rEmpno+"&year="
			  +year+"&month="+month+"&asno="+asno+"&source="+source);
//out.println(Integer.toString(ac.getRApplyTimes())+"<br>done");
}
%>

</body>
</html>
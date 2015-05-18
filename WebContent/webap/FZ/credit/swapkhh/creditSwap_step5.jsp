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
<title>積點換班申請step2</title>
<script language="javascript" type="text/javascript" src="../js/showDate.js"></script>
<link href="swap.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="../errStyle.css">
</head>
<body >
<%
//Crew A 使用積點申請, Crew B 不扣點數也不影響換班次數
String aEmpno = (String)session.getAttribute("userid");//request.getParameter("aEmpno");
String rEmpno = request.getParameter("rEmpno");
String year   = request.getParameter("year");
String month   = request.getParameter("month");
String asno   = request.getParameter("asno");
session.setAttribute("aEmpno",aEmpno);
session.setAttribute("rEmpno",rEmpno);

//檢查班表是否公佈
PublishCheck pc = new PublishCheck(year, month);
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
//積點換班不影響三次換班次數
session.setAttribute("aApplyTimes",Integer.toString(ac.getAApplyTimes()));
session.setAttribute("rApplyTimes",Integer.toString(ac.getRApplyTimes()));

//out.println((String) session.getAttribute("aApplyTimes"));
//out.println((String) session.getAttribute("rApplyTimes"));

response.sendRedirect("creditSwap_step6_checkRetire.jsp?aEmpno="+aEmpno+"&rEmpno="+rEmpno+"&year="
			  +year+"&month="+month+"&asno="+asno);
}
%>

</body>
</html>
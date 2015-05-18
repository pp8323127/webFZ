<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,swap3.*" %>
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
<title>3次換班申請Step2</title>
<script language="javascript" type="text/javascript" src="../js/showDate.js"></script>
<link href="swap.css" rel="stylesheet" type="text/css">
</head>
<body >
<%
//String userid = (String) session.getAttribute("userid") ; 

String aEmpno = (String) session.getAttribute("userid");//request.getParameter("aEmpno");
String rEmpno = request.getParameter("rEmpno");
String year   = request.getParameter("year");
String month   = request.getParameter("month");
session.setAttribute("aEmpno",aEmpno);
session.setAttribute("rEmpno",rEmpno);


swap3.ApplyCheck ac = new swap3.ApplyCheck(aEmpno,rEmpno,year,month);
if(ac.isUnCheckForm()
){	//有申請單尚未核可，不可申請
%>
<p style="color:red;text-align:center ">申請者(<%=aEmpno%>)&nbsp;
			或被換者(<%=rEmpno%>)&nbsp;有申請單尚未經ED核可, <br>		
系統不受理遞單.</p>
<%
}else if (ac.getAApplyTimes() >=3 ){ // 申請者當月申請次數高於3次，不可申請
%>
<p style="color:red;text-align:center ">申請者(<%=aEmpno%>)&nbsp; 
			當月申請次數已超過三次, <br>		
			系統不受理遞單.</p>
<%

}else if (ac.getRApplyTimes() >=3 ){ // 被換者當月申請次數高於3次，不可申請
%>
<p style="color:red;text-align:center ">被換者(<%=rEmpno%>)&nbsp; 
			當月申請次數已超過三次, <br>		
			系統不受理遞單.</p>
<%

}else if(ac.isALocked()){//申請者班表鎖定,(正常狀況應該不會發生，鎖定者看不到換班的功能選項)
%>
<p style="color:red;text-align:center ">申請者(<%=rEmpno%>)&nbsp; 
			班表為鎖定狀態, <br>		
			系統不受理遞單.<br>
			（換班雙方需設定班表為開放狀態,方可使用換班功能）.</p>
<%
}else if(ac.isRLocked()){//被換者班表鎖定
%>
<p style="color:red;text-align:center ">被換者(<%=rEmpno%>)&nbsp; 
			班表為鎖定狀態, <br>		
			系統不受理遞單.<br>
			（換班雙方需設定班表為開放狀態,方可使用換班功能）.</p>
<%
}


else{

//設定已換次數
session.setAttribute("aApplyTimes",Integer.toString(ac.getAApplyTimes()));
session.setAttribute("rApplyTimes",Integer.toString(ac.getRApplyTimes()));


response.sendRedirect("applicant.jsp?rEmpno="+rEmpno+"&year="
			  +year+"&month="+month);
}
%>
</body>
</html>
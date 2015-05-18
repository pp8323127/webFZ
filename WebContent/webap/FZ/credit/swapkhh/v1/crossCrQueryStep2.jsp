<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,swap3ackhh.*" %>
<%
//session.setAttribute("aPrjcr","0");
//session.setAttribute("rPrjcr","0");


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>飛時試算Step2</title>
<script language="javascript" type="text/javascript" src="../js/showDate.js"></script>
<link href="swap.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="../errStyle.css">
</head>
<body >
<%

String aEmpno = (String)session.getAttribute("userid");////request.getParameter("aEmpno");
String rEmpno = request.getParameter("rEmpno");
String year   = request.getParameter("year");
String month   = request.getParameter("month");


//檢查班表是否公布
swap3ackhh.PublishCheck pc = new swap3ackhh.PublishCheck(year, month);

swap3ackhh.ApplyCheck ac = new swap3ackhh.ApplyCheck(aEmpno,rEmpno,year,month);
if(ac.isALocked()){//申請者班表鎖定,(正常狀況應該不會發生，鎖定者看不到換班的功能選項)
%>
<p class="errStyle1">申請者(<%=rEmpno%>)&nbsp; 
			班表為鎖定狀態, 		
			不得查詢.<br>
			（雙方需設定班表為開放狀態,方可使用飛時試算查詢功能）.</p>
<%
}else if(ac.isRLocked()){//被換者班表鎖定
%>
<p  class="errStyle1">被換者(<%=rEmpno%>)&nbsp; 
			班表為鎖定狀態, 		
			不得查詢.<br>
			（雙方需設定班表為開放狀態,方可使用飛時試算查詢功能）.</p>
<%
}
//班表是否公布
else if(!pc.isPublished()){
%>
<p  class="errStyle1"><%=year+"/"+month%> 班表尚未正式公布，不得查詢.</p>
<%
}

else{


response.sendRedirect("crossCr.jsp?rEmpno="+rEmpno+"&year="
			  +year+"&month="+month);

}

%>

</body>
</html>
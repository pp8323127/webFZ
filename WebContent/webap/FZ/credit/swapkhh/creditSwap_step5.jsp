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
<title>縩翴传痁ビ叫step2</title>
<script language="javascript" type="text/javascript" src="../js/showDate.js"></script>
<link href="swap.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="../errStyle.css">
</head>
<body >
<%
//Crew A ㄏノ縩翴ビ叫, Crew B ぃΙ翴计ぃ紇臫传痁Ω计
String aEmpno = (String)session.getAttribute("userid");//request.getParameter("aEmpno");
String rEmpno = request.getParameter("rEmpno");
String year   = request.getParameter("year");
String month   = request.getParameter("month");
String asno   = request.getParameter("asno");
session.setAttribute("aEmpno",aEmpno);
session.setAttribute("rEmpno",rEmpno);

//浪琩痁琌そ
PublishCheck pc = new PublishCheck(year, month);
//***********************************************************************
ApplyCheck ac = new ApplyCheck(aEmpno,rEmpno,year,month);
if(ac.isUnCheckForm())
{	//Τビ叫虫﹟ゼぃビ叫
%>
<p  class="errStyle1">ビ叫(<%=aEmpno%>)&nbsp;
	┪砆传(<%=rEmpno%>)&nbsp;Τビ叫虫﹟ゼ竒ED, <br>		
    ╰参ぃ瞶患虫.</p>
<%
//***********************************************************************
}
//痁琌そガ
else if(!pc.isPublished())
{
%>
<p  class="errStyle1"><%=year+"/"+month%> 痁﹟ゼタΑそガ╰参ぃ瞶患虫.</p>
<%
}
else
{
//砞﹚传Ω计
//縩翴传痁ぃ紇臫Ω传痁Ω计
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
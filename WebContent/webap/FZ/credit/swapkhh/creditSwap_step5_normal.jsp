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
<title>AirCrews3�����Z�ӽ�Step2</title>
<script language="javascript" type="text/javascript" src="../js/showDate.js"></script>
<link href="swap.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="../errStyle.css">
</head>
<body >
<%
//�T�����Z
//Crew A �ϥοn�I�ӽ�, Crew B �ϥΤT�����Z�ӽ�
String aEmpno = (String)session.getAttribute("userid");//request.getParameter("aEmpno");
String rEmpno = request.getParameter("rEmpno");
String year   = request.getParameter("year");
String month   = request.getParameter("month");
String asno   = request.getParameter("asno");
String source   = request.getParameter("source");
//out.print("source >> "+ source+" aEmpno >>"+ aEmpno + " rEmpno >> "+ rEmpno + " year >> "+ year + " month >> "+ month+ " asno >> "+ asno +"<br>");
session.setAttribute("aEmpno",aEmpno);
session.setAttribute("rEmpno",rEmpno);

//�ˬd�Z��O�_����
PublishCheck pc = new PublishCheck(year, month);
//***********************************************************************
//�Q���̿�ܤT�����Z�v�Q,���ˮ֬O�_����
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
{	//���ӽг�|���֥i�A���i�ӽ�
%>
<p  class="errStyle1">�ӽЪ�(<%=aEmpno%>)&nbsp;
			�γQ����(<%=rEmpno%>)&nbsp;���ӽг�|���gED�֥i, <br>		
�t�Τ����z����.</p>
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
else if (ac.getRApplyTimes() >=3 ){ // �Q���̷��ӽЦ��ư���3���A���i�ӽ�
%>
<p  class="errStyle1">�Q����(<%=rEmpno%>)&nbsp; 
			 <%=year+"/"+month %>�ӽЦ��Ƥw�W�L�T��, <br>		
			�t�Τ����z����.</p>
<%

}
//�Z��O�_����
else if(!pc.isPublished())
{
%>
<p  class="errStyle1"><%=year+"/"+month%> �Z��|�����������A�t�Τ����z����.</p>
<%
}
else
{
//�]�w�w������
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
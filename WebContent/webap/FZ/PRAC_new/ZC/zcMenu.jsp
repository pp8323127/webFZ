<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login
String auth = (String)session.getAttribute("auth");
//取得人事資料
fzAuthP.UserID usr = new fzAuthP.UserID(userid,null);
fzAuthP.CheckHR ckHr = new fzAuthP.CheckHR();
fzAuthP.HRObj hrObj = ckHr.getHrObj ();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5"
><link rel="stylesheet" type="text/css" href = "style.css">
<title>事 務 長</title>
</head>

<body>
<p>&nbsp;</p>
<table width="350"  align="center" border="0" cellspacing="2" class="tableBorder1">
  <tr>
    <td height="35" colspan="2" class="tableh5" align="center" >事 務 長 </td>
  </tr>
</table>
<br>
<center>
<table width="350" border="0" cellspacing="2">
  <tr class="tableInner2">
  <td valign="middle">
  <div align="left"><li>
  <a href="#" onClick="top.topFrame.location.href='../ZCprev/zcReportQuery.jsp';self.location.href='../../blank.htm'" >任務組員名單列印<img src="print.gif" width="16" height="16" border="0"></a></div></td> 
  </tr>
  <tr class="tableInner2">
   <td valign="middle"><div align="left"><li>
   <a href="#" onClick="top.topFrame.location.href='zcReportQuery.jsp';self.location.href='../../blank.htm'" >
   事務長報告</a>&nbsp;&nbsp;&nbsp;
   <img src="../../images/help-browser.png" width="16" height="16" align="top" >
   <a href="../guide/ZCReportGuide.doc" target="_blank">事務長報告操作使用說明</a></div></td>
  </tr>
  <%
  
  if("Y".equals((String)session.getAttribute("powerUser")) || 
	  "631210".equals(userid) || "628997".equals(userid) ||  
	  "628539".equals(userid) || "625303".equals(userid) || "628933".equals(userid) || "628930".equals(userid) || "O".equals(auth) )
	  {
	  %>
	  <tr class="tableInner2">
	  <td valign="middle"><div align="left"><li>
      <img src="../../images/blue_view.gif" width="16" height="16" align="top" ><a href="zcRptListQuery_office.jsp" target="topFrame">View Report(Authorized Personnel Only) </a>  
	  </li>
	  </div>
	  </td>
	  </tr>
	  <%
	  }
	  
  
  %>
</table>
</center>
</body>
</html>

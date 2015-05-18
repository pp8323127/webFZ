<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*, sch.crewMonthlySch" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
/*String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first
	response.sendRedirect("../sendredirect.jsp");
} */
%>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Monthly Schedule</title>
<link href="../../menu.css" rel="stylesheet" type="text/css">
</head>
<body>
<div align="center">
<%
String yy = request.getParameter("yy");
String mm = request.getParameter("mm");
String base = request.getParameter("base");
String rank = request.getParameter("rank");
String sk = request.getParameter("sk");

String filename = yy + mm + base + rank + sk;
//out.println(yy + "," + mm + "," + fleet + "," + rank);

String fltdate 	=request.getParameter("yy")+"/"+ request.getParameter("mm")+"/"+request.getParameter("dd");
String fullUCD = (String) session.getAttribute("fullUCD");
out.print(fullUCD);
//檢查班表是否公布
swap3ac.PublishCheck pc = new swap3ac.PublishCheck(fltdate.substring(0,4), fltdate.substring(5,7));
if((!"190A".equals(fullUCD) && !"068D".equals(fullUCD) && !"176D".equals(fullUCD) ) && !pc.isPublished() ){
   //非航務、空服簽派者，才檢查班表是否公佈
   %><div style="background-color:#99FFFF;text-align:center;color:#FF0000;font-family:Verdana;font-size:10pt; ">
		<%=fltdate.substring(0,7)%>班表尚未正式公佈!! </div><%
}else{
   crewMonthlySch ms = new crewMonthlySch();
   String rs = ms.schFile(yy+mm, base, rank, sk);
   if("0".equals(rs)){ %>
     <p class="txttitletop">檔案下載/Download File</p>
     <p><a href="../../sample6.jsp?filename=<%=filename%>.csv"><img src="../../images/floder2.gif" width="31" height="27" border="0"><%=filename%> download</a></p> <%
   }else{ %>
     <p class="txttitletop">檔案製作失敗 : <%=rs%></p> <%
   }//if
}// 檢查班表是否公布
%>
</div></body></html>

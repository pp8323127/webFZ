<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*"  %>
<%
String empno = request.getParameter("empno");
String year = request.getParameter("year");
String month = request.getParameter("month");
fzac.CrewMonthSkj cs = new fzac.CrewMonthSkj(year,month,empno);

ArrayList aCrewSkjAL = null;
boolean status = false;
String  errMsg = "";
try {
	cs.SelectData();
	aCrewSkjAL = cs.getCrewSkjAL();
	status = true;
} catch (ClassNotFoundException e) {	
	errMsg = e.toString();
} catch (SQLException e) {
	errMsg = e.toString();
} catch (Exception e) {
	errMsg = e.toString();
}

//檢查班表是否公布
swap3ac.PublishCheck pc = new swap3ac.PublishCheck(year, month);

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="../errStyle.css">
<link rel="stylesheet" type="text/css" href="../style2.css">
<script type="text/javascript" language="javascript" src="../js/color.js"></script>
<script language="javascript" src="../js/subWindow.js" type="text/javascript"></script>

<title>查詢組員班表</title>
</head>

<body onLoad="stripe('t1')">
<%
//班表是否公布
 if(!pc.isPublished()){
%>
<p  class="errStyle1"><%=year+"/"+month%> 班表尚未正式公布，不得查詢.</p>
<%
}
else if(status && aCrewSkjAL != null) {
%>
<div style="color:#FF0000;font-family:Verdana;font-size:10pt;text-align:center " >Schedule: <%=empno%>&nbsp;&nbsp;<%=year+"/"+month%></div>
<table width="70%"   border="0" cellspacing="0" cellpadding="0" align="center" id="t1">
  <tr class="sel3">
    <td width="20%">Start Fdate<br>
    (Local)</td>
    <td width="18%">End Fdate<br>
  (Local)</td>
    <td width="15%">Fltno</td>
    <td width="12%">Dpt</td>
    <td width="11%">Arv</td>
    <td width="12%">SpCode</td>
    <td width="12%">Rank</td>
  </tr>
  <%
  	for (int i = 0; i < aCrewSkjAL.size(); i++) {
		fzac.CrewMonthSkjObj obj = (fzac.CrewMonthSkjObj) aCrewSkjAL.get(i);

  %>
  <tr>
    <td height="24"><%=obj.getStrFdate()%></td>
    <td><%=obj.getEndFdate()%></td>
    <td><%=obj.getFltno()%></td>
    <td><%=obj.getDpt()%></td>
    <td><%=obj.getArv()%></td>
    <td><%=obj.getSpCode()%></td>
    <td><%=obj.getActing_rank()%></td>
  </tr>
  <%
  }
  %>
</table>



<%

} else if(aCrewSkjAL == null){
	out.print("<div class=\"errStyle1\">NO SCHEDULE!!</div>");

}else{
	out.print("<div class=\"errStyle1\">"+errMsg+"</div>");
}

%>

</body>
</html>

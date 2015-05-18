<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,swap3ackhh.smsacP.*,java.util.ArrayList"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
//顯示當日全部航班，可刪除航班
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
/*response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);*/

if (session.isNew() || sGetUsr == null) 
{		//check user session start first
response.sendRedirect("../sendredirect.jsp");
} 
session.setAttribute("smsObj",null);

String y = request.getParameter("yy");
String m = request.getParameter("mm");
String d = request.getParameter("dd");
String requestFdate = y+"/"+m+"/"+d;

swap3ackhh.smsacP.CrewPhoneListAllFlt cflt = new swap3ackhh.smsacP.CrewPhoneListAllFlt(y, m, d);
String hh = null;
String mm = null;
String hourRang = null;
String errMsg = "";
String bcolor = "";
if(!"".equals(request.getParameter("hh")) && null != request.getParameter("hh")){
	hh = request.getParameter("hh");
	mm = request.getParameter("mi");
	hourRang= request.getParameter("inHour");	
}

ArrayList al = null;
try {

	if(hh == null){
		cflt.initFLYData();
	}else{
		cflt.initFLYData2(hh, mm, hourRang);
	}	

	al = cflt.getDataAL();

} catch (SQLException e) {
	errMsg = e.toString();
} catch (Exception e) {
	errMsg = e.toString();
}

out.print(errMsg);
%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Show flt</title>
<link rel="stylesheet" type="text/css" href="style2.css">
<script src="../../js/subWindow.js" language="javascript" type="text/javascript"></script>
<script language="JavaScript"  src="Auth.js" type="text/JavaScript"></script>
<script language="JavaScript"  src="../js/checkDel.js" type="text/JavaScript"></script>

<link rel="stylesheet" type="text/css" href="../../errStyle.css">
</head>

<body>
<p>
</p>
<%
if(al.size() == 0){
out.print("<div class=\"errStyle1\">NO DATA!!</div>");
}else{

session.setAttribute("smsObj",al);
%>

<table width="80%"  border="0" align="center" cellpadding="2" cellspacing="0"  >
  <tr >
    <td class="txtblue" >
      <form name="form1" method="post" action="SMSFile.jsp">
        <div align="center"> 
         <input type="submit" name="Submit" value="Make File"  class="btm" >
        </div>
      </form>
    </td>
  </tr>
</table>
<form name="form2" action="ShowFltDel.jsp" target="_self" method="post" onSubmit="return checkDel('form2')">
<table width="80%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
  <tr class="tablehead3">
    <td width="17%">
      <div align="center">Date(Taipei)</div>
    </td>
    <td width="10%">
      <div align="center">Flt</div>
    </td>
    <td width="11%">Dpt</td>
    <td width="14%">Arv</td>
    <td width="15%">BTime</td>
    <td width="15%">ETime</td>
    <td width="9%">
      <div align="center">Crew</div>
    </td>
    <td width="9%">Delete</td>
  </tr>
<%
	for(int i=0;i<al.size();i++){		
		SMSFlightObj o = (SMSFlightObj) al.get(i);
		if (i%2 == 0){
			bcolor = "#99CCFF";
		}
		else{
			bcolor = "#FFFFFF";
		}
  
  %>
  <tr bgcolor="<%=bcolor%>">
    <td class="tablebody"><%=o.getFdate()%></td>
    <td class="tablebody"><%=o.getFltno()%></td>
    <td class="tablebody"><%=o.getDpt()%></td>
    <td class="tablebody"><%=o.getArv()%></td>
    <td class="tablebody"><%=o.getBtime()%></td>
    <td class="tablebody"><%=o.getEtime()%></td>
    <td class="tablebody"><a href="#" onClick="subwinXY('Show1FltCrew.jsp?idx=<%=i%>','showFlt','750','500')" ><img src="../../img2/p1.gif" width="16" height="16" border="0"></a></td>
    <td class="tablebody"><input type="checkbox" name="delSeries" value="<%=o.getSeries_num()%>"> </td>
  </tr>
  <%
  		}
	
   %>
</table>
<table width="80%"  border="0" align="center" cellpadding="2" cellspacing="0" >
<tr>
	<td colspan="3">
	  <div align="center">
	    <input type="submit" value="Delete" class="delButon">
	    <br>
	    </div>
	</td>
</tr>
<tr>
  <td width="29%">&nbsp;</td>
  <td width="49%">
    <p class="txtxred">註：此處不提供修改單一航班組員名單， 若欲更動，請<br>
取消此航班，另行於輸入Fltno後顯示的組員名單中增刪。</p>
    </td>
  <td width="22%">&nbsp;</td>
</tr>
</table>
</form>
<table width="80%"  border="0" align="center" cellpadding="2" cellspacing="0" >
  <tr >
    <td class="txtblue" >Total Flight：<%=al.size()%> </td>
  </tr>
  <tr >
    <td class="txtblue" >
      <form name="form3" method="post" action="SMSFile.jsp">
        <div align="center"> 
         <input type="submit" name="Submit" value="Make File" class="btm" >
        </div>
      </form>
    </td>
  </tr>
</table>
<%
}
%>
</body>
</html>

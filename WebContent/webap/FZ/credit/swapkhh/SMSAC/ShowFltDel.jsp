<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,swap3ackhh.smsacP.*"  %>
<%
String[] delSeries = request.getParameterValues("delSeries");
ArrayList dataAL = (ArrayList)session.getAttribute("smsObj");
String requestFdate = request.getParameter("requestFdate");

for(int i=0;i<dataAL.size();i++){
		SMSFlightObj o = (SMSFlightObj) dataAL.get(i);
		for(int j=0;j<delSeries.length;j++){
			
			if(o.getSeries_num().equals(delSeries[j])){
				dataAL.remove(i);
				if(i != 0){
					i--;
				}
			}
			
		}
}

session.setAttribute("smsObj",dataAL);
String bcolor = "";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title></title>
</head>
<link rel="stylesheet" type="text/css" href="style2.css">
<link rel="stylesheet" type="text/css" href="../../errStyle.css">
<script src="../../js/subWindow.js" language="javascript" type="text/javascript"></script>

<script language="JavaScript"  src="Auth.js" type="text/JavaScript"></script>
<script language="JavaScript"  src="../js/checkDel.js" type="text/JavaScript"></script>

<body>
<%
if(dataAL.size() == 0){
out.print("<div class='errStyle1'>NO DATA!!</div>");
}else{


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
<form name="form2" action="ShowFltDel.jsp?requestFdate=<%=requestFdate%>" target="_self" method="post" onSubmit="return checkDel('form2')">
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
	for(int i=0;i<dataAL.size();i++){		
		SMSFlightObj o = (SMSFlightObj) dataAL.get(i);
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
    <td class="tablebody"><a href="#" onClick="subwinXY('Show1FltCrew.jsp?idx=<%=i%>','showFlt','750','500')" ><img src="../../img2/p1.gif" border="0"></a></td>
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
    <td class="txtblue" >Total Flight：<%=dataAL.size()%> </td>
  </tr>
  <tr >
    <td class="txtblue" >
      <form name="form3" method="post" action="SMSFile">
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

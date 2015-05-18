<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,swap3ackhh.smsacP.*" %>
<%

ArrayList dataAL = (ArrayList)session.getAttribute("smsObj");
int idx = Integer.parseInt(request.getParameter("idx"));
SMSFlightObj obj = (SMSFlightObj) dataAL.get(idx);
ArrayList crewList = obj.getCrewPhoneList();
String bcolor = "";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Show flt</title>
<link rel="stylesheet" type="text/css" href="style2.css">

<script language="JavaScript"  src="Auth.js" type="text/JavaScript"></script>

</head>

<body>
<%
if(crewList == null){
out.print("no data");
}else{

%>
  <table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
    <tr class="tablehead3">
      <td width="13%">
        <div align="center">Date(Taipei)</div>
      </td>
      <td width="10%">
        <div align="center">Flt</div>
      </td>
      <td width="15%">
        <div align="center">Crew</div>
      </td>
      <td width="16%">Empno</td>
      <td width="11%">
        <div align="center">Occu</div>
      </td>
      <td width="18%">
        <div align="center">MobilPhone</div>
      </td>
    </tr>
    <%
	for (int i = 0; i < crewList.size(); i++) {
		swap3ackhh.smsacP.CrewPhoneListObj o = (swap3ackhh.smsacP.CrewPhoneListObj) crewList.get(i);
 
		if (i%2 == 0){
			bcolor = "#99CCFF";
		}
		else{
			bcolor = "#FFFFFF";
		}
  
  %>
    <tr bgcolor="<%=bcolor%>">
      <td   class="tablebody"><%=obj.getFdate()%></td>
      <td class="tablebody"><%=obj.getFltno()%></td>
      <td class="tablebody"><%=o.getCname()%></td>
      <td class="tablebody"><%=o.getEmpno()%></td>
      <td class="tablebody"><%=o.getRank()%></td>
      <td class="tablebody">&nbsp;<%=o.getMphone()%></td>
    </tr>
    <%
  		}

  
  %>
  </table>
  <table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0" >
    <tr>
      <td width="100%">
        <div align="center">
          <input type="button" name="closeWindow" value="Close" onClick="self.close()" >
          <br>
        </div>
      </td>
    </tr>
  </table>
 

<%
}
%>
</body>
</html>

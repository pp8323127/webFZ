<%@ page contentType="text/html; charset=big5" language="java"   %>
<%@ page import="java.sql.*,ci.db.*,da.PTPC.*,java.util.*"%>
<%
String fleet = request.getParameter("fleet");
String clstype = request.getParameter("clstype");


RetrieveNewEmpPC rn = new RetrieveNewEmpPC(clstype,fleet);

ArrayList al = rn.RetrieveData();
//ArrayList al = rn.compareTrn();

int rowCount =0;

String bgColor = "";

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>無PC訓練記錄者</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script src="CheckAll.js" language="javascript" type="text/javascript"></script>
<script src="checkDel.js" language="javascript" type="text/javascript"></script>
<script src="color.js" language="javascript" type="text/javascript"></script>
<style type="text/css">
	<!--

	/* style of selected cell */
	#t1 tbody tr.selected td {	
		background-color: #CCFFFF;
		color:#FFFFFF;
		font-weight: bold;
		font-family:Verdana, "細明體"; font-size: 10pt; font-weight: bold;
	}
	
body{overflow:auto;}


-->
</style>

</head>

<body onload="stripe('t1','#FFFFFF','#FFFFCC');">
<%
if(al.size()==0 ){
	out.print("No DATA!!");
}else{
%>
<form name="form1" method="post">

<table width="70%"  border="0" cellpadding="1" cellspacing="1" bordercolor="#CCCCCC" align="center">
<tr>
  <td><div align="center">
  <%
  if(!"ALL".equals(fleet)){
  out.print("Fleet: <span style=\"color:#FF0000 \">"+ fleet+"</span>&nbsp;");
  }
  
if(!"ALL".equals(clstype)){
  %>
  新進人員無 <span style="color:#FF0000 "><%= clstype%> </span>訓練記錄者
  <%
  }
  %>
  </div>
</td></tr>
</table>

<table width="70%"  border="1" cellpadding="1" cellspacing="1" bordercolor="#CCCCCC" align="center" id="t1">
  <tr class="tablehead4">

    <td width="9%">&nbsp;</td>

    <td width="11%">
      <div align="center">Fleet</div>
    </td>
    <td width="10%">
      <div align="center">Rank</div>
    </td>
    <td width="12%">
      <div align="center">Empno</div>
    </td>
    <td width="15%">
      <div align="center">Name</div>
    </td>
    <td width="28%">EName</td>
    <td width="15%">
      <div align="center">進公司日</div>
    </td>
  </tr>
  <%
	for (int i = 0; i < al.size(); i++) {
		NewEmpObj neObj = (NewEmpObj) al.get(i);
		
		/*if(i%2 ==0)	{
			bgColor="#FFFFFF";
		}else{
			bgColor="#FFFFCC";
		}
		*/
		
rowCount++;
%>
  <tr >

    <td >
      <div align="right">
        <%//=i%>
		<%=rowCount%>
        </div>
    </td>
	
    <td>
      <div align="center"><%=neObj.getFleet() %></div>
    </td>
    <td>
      <div align="center"><%=neObj.getRank() %></div>
    </td>
    <td>
      <div align="center"><%=neObj.getEmpno()%></div>
    </td>
    <td>
      <div align="left">&nbsp;<%=neObj.getCname()%></div>
    </td>
    <td><div align="left">&nbsp;<%=neObj.getEname() %></div>
</td>
    <td>
      <div align="center"><%=neObj.getInDate() %></div>
    </td>
  </tr>
  <%

}
%>
</table></form>
<p>&nbsp;</p>
<%
}//end of has data
%>
</body>
</html>

<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page  import="java.sql.*,swap3ackhh.*"%>
<%
String tripno =request.getParameter("tripno");

TripInfo ti = new TripInfo(tripno);
ArrayList dataAL = null;
String bgColor= "";
try{

	ti.SelectData();
	dataAL = ti.getTripnoAL();
	
}catch(Exception e){
	System.out.print(e.toString());
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Trip Info</title>
<link href="swap.css" rel="stylesheet" type="text/css">
</head>

<body>
<%
if(dataAL == null){
%>
<div class="r">
  <div align="center"><br>
    No Data!!<br>
    <br>
  </div>
</div>
<%
}else{
%>
<p align="center">Tripno : <%=tripno%><br>
  <span class="w">班表時間為起訖站當地時間</span>
</p>
<table width="562"  border="0" align="center" cellpadding="1" cellspacing="0">
  <tr class="selected">
    <td width="80">Fdate</td>
    <td width="52">Fltno</td>
    <td width="46">dpt</td>
    <td width="33">Arv</td>
    <td width="142">Btime</td>
    <td width="142">Etime</td>
    <td width="50">Cr<br>
    (HHMM)</td>
  </tr>
  <%
  for(int i=0;i<dataAL.size();i++){
  	 TripInfoObj obj = (TripInfoObj)dataAL.get(i);
	 if(i%2 == 0){
		 bgColor="#FFFFFF";
	 }else{
		bgColor = "#FFFFCC";
	 }
  %>
  <tr bgcolor="<%=bgColor%>"  >
    <td ><%=obj.getFdate()%></td>
    <td><%=obj.getDuty()%></td>
    <td><%=obj.getDpt()%></td>
    <td><%=obj.getArv()%></td>
    <td><%=obj.getBtime()%></td>
    <td><%=obj.getEtime()%></td>
    <td><%=obj.getCrInHHMM()%></td>
  </tr>
  <%
  }
  %>
</table>
<div  style="color:red;text-align:center ">
  註：跨月班次之飛時，僅計算至當月底.  <br>
  <input type="button"  style="background-color:#99CCFF;font-family:Verdana; " onClick="javascript:self.close();" value="Close">
</div>  
  <%
}
%>
	
</body>
</html>

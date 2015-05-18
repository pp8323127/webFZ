<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*"  %>
<%
String rank = request.getParameter("rank");
String fleet	 = request.getParameter("fleet");
String checkType = request.getParameter("checkType");
ArrayList dataAL = new ArrayList();
String errMsg = "";
boolean status = false;
da.PTPC.RecurrentRecord rt = new da.PTPC.RecurrentRecord(fleet, rank, checkType);
try{
	rt.LoadFunction();
	dataAL = rt.getDataAL();
	status = true;
} catch (ClassNotFoundException e) {
	errMsg = e.toString();
} catch (SQLException e) {
	errMsg = e.toString();
} catch (InstantiationException e) {
	errMsg = e.toString();
} catch (IllegalAccessException e) {
	errMsg = e.toString();
}

//取得組員中文姓名 
aircrew.CrewInfo cc = new aircrew.CrewInfo();

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>無標題文件</title>
<style type="text/css">
body{
font-family:Verdana;
font-size:10pt;
line-height:1.3;
}
th{
	text-align:center;
	background-color:#6699CC;
	color:#FFFFFF;
}
table{
	border-collapse:collapse;
	border:1pt solid #CCCCCC;	
}

.o{
	background-color:#C2EFFC;
}
.l{
	text-align:left;
	padding-left:2pt;
}
.r{
	text-align:right;
	padding-right:2pt;
}

</style>
</head>

<body>
<%
if(!status){
	out.print(errMsg);
}else if(null == dataAL){
	out.print("NO DATA!!");
}else{



%>
<div align="center">
  <table width="70%" border="0" cellpadding="0" cellspacing="1" style="border:0pt; " >
    <tr>
      <td colspan="2"><div align="center"><%="FLEET:"+fleet+"&nbsp;RANK:"+rank+"&nbsp;CheckType:"+checkType%>&nbsp;&nbsp;受訓記錄</div></td>
    </tr>
    <tr>
        <%
  java.util.Date curDate = Calendar.getInstance().getTime();
  %>
    <td><div align="left">RUN DATE:<%=new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm").format(curDate)%></div></td>

      <td width="5%"><div align="right"><a href="javascript:window.print()"><img src="../../images/print.gif" border="0"></a></div></td>
    </tr>
  </table>
<table cellpadding="0" cellspacing="1" border="1" width="70%" >
	<tr>
		<th width="13%">Empno</th>
		<th width="29%">Name</th>
		<th width="12%">Licence<br> 
	    到期日</th>
		<th width="17%">上次受訓日</th>
		<th width="10%">距今月數</th>
		<th width="19%">建議下次<br>
	    施訓月份</th>

	</tr>
	<%
	for(int i=0;i<dataAL.size();i++){
		da.PTPC.TrainingRecordObj obj = (da.PTPC.TrainingRecordObj)dataAL.get(i);

	%>
	<tr <%if(i%2 == 1){out.print("class=\"o\"");}%>>
	  <td height="24"><%=obj.getEmpno()%></td>
	  <td  class="l"><%=cc.getCname(obj.getEmpno())%></td>
	  <td><%=obj.getLicenceExpireDate()%></td>
	  <td>
	  <%
	  out.print(obj.getLastTrainingDate());
	  if("PC".equals(checkType)){
	  	out.print("&nbsp;"+obj.getTrainingType());
	  }
	  %>
	  
	  </td>
	  <td class="r"><%=obj.getMonthFromLastTraining()%></td>
	  <td><%=obj.getRecommandTrainingDate()%></td>
  </tr>
  <%
  }
  %>
</table>
<table width="70%" border="0" cellpadding="0" cellspacing="1" style="border:0pt; " >
  <tr>
    <td><div align="left">*受訓資料來源：DZ<br>
  *Fleet/Rank/Licence相關資料來源：AirCrews <br>
  *建議
下次施訓月份：PT/PC為上次施訓日後4-8月,其餘為上次施訓日後1 年</div>
</td>
    </tr>
  <tr>
  </tr>
</table>
<%
}
%>
</div>
</body>
</html>

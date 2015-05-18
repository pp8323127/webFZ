<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,apis_new.*,java.util.*,java.text.*" %>
<html>
<head>
<title>Send APIS</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
String fullUCD = (String) session.getAttribute("fullUCD");//登入CII時，取得之登入者單位代碼
String userid = (String) session.getAttribute("userid") ; //get user id if already login
String idx = (String) request.getParameter("idx") ; 
String exphr = (String) request.getParameter("exphr") ; 
ArrayList apisfltAL = (ArrayList) session.getAttribute("apisfltAL");
APISObj obj = (APISObj) apisfltAL.get(Integer.parseInt(idx));

APISSkjJob c = new APISSkjJob();
ArrayList da13AL = new ArrayList();
da13AL = c.getAPISFltDetail_DA13(obj.getFltno(), obj.getStr_port_local(), exphr, obj.getDpt());
//out.println(da13AL.size());
//out.println("<br>"+c.getSql());
//check da13 sql
if(da13AL.size()>0)
{
%>
	<table width="600" border="1" cellspacing="0" cellpadding="0" align="center">
<%
	if(da13AL.size()<=0)
	{
		DA13Obj da13obj = (DA13Obj) da13AL.get(0);	
	}
	else
	{
		for(int i=0; i<da13AL.size(); i++)
		{
			DA13Obj da13obj = (DA13Obj) da13AL.get(i);	
			if(i==0)
			{
%>
				 <tr class="tablehead">
				  <td align="center">Flt date(Actual Local) from Aircrews</td>
				  <td align="center">Flt date(Actual Local) from Airops</td>
				  <td align="center">Fltno</td>
				  <td align="center">Sector</td>
				 </tr>
<%		
			}
%>
				<tr class="txtblue">
				  <!--<td align="center"><%=obj.getStdtpe()%></td>-->
				  <td align="center"><%=obj.getStr_port_local()%></td>
				  <td align="center">
				  <a href="sendapisList.jsp?idx=<%=idx%>&ftime=<%=da13obj.getDa13_atdl()%>" target="_self"><span  class="txtxred"><%=da13obj.getDa13_atdl()%></span>
				  </a>
				  </td>
				  <td align="center"><%=da13obj.getDa13_fltno()%></td>
				  <td align="center"><%=da13obj.getDa13_fm_sector()%>/<%=da13obj.getDa13_to_sector()%></td>
			  </tr>
<%
		}	
	}
%>
  </table>
  <p>
  <div width="600" align="center"><span class="txtblue">比對欄位:AirCrews(str_dt_tm_loc) 與 AirOps(da13_etdl)</span></div>
<%
}
else
{
%>
	<div width="600" align="center" style="background-color:#FFCCFF"><span class="style2">No data found!! &nbsp;<a href="javascript:history.back()">回上一頁</a>
</span>
<%
}
%>
</body>
</html>
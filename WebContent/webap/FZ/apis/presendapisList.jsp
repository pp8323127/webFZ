<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,apis_new.*,java.util.*" %>
<html>
<head>
<title>Send APIS</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="style.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE="JavaScript">
function btn_click(idxnum)
{
	var exphr =eval("document.form1.exphr"+idxnum+".value");
	document.form1.target="_self";
	document.form1.action="presendapisList2.jsp?idx="+idxnum+"&exphr="+exphr;
	document.form1.submit();
	
}

</SCRIPT>
<style type="text/css">
body
{
font-size: 9pt;
font-family: Courier;
}

input.st1
{
	border-bottom: 1.5px solid #808080 ;
	border-top: 0px solid #FFFFFF ;
	border-left: 0px solid #FFFFFF ;
	border-right: 0px solid #FFFFFF ;
	vertical-align: bottom;
	font-size: 9pt;
}

input.st2
{
	border-bottom: 0px solid #FFFFFF ;
	border-top: 0px solid #FFFFFF ;
	border-left: 0px solid #FFFFFF ;
	border-right: 0px solid #FFFFFF ;
	vertical-align: bottom;
	font-size: 9pt;
}
.style2 {
	font-size: 12;
	color: #FF0000;
}
</style>
</head>
<body>
<form name="form1" method="post" class="txtblue" >
<%
String fltdt = (String) request.getParameter("fltdt") ; 
String fltno = (String) request.getParameter("fltno") ; 
String dpt = (String) request.getParameter("dpt") ; 

APISSkjJob c = new APISSkjJob();
c.getAPISFlt(fltdt,fltno,dpt);
ArrayList apisfltAL = new ArrayList();
apisfltAL = c.getAPISFltAL();

//out.println(c.getSql());

session.setAttribute("apisfltAL",apisfltAL);
if(apisfltAL.size()>1 | apisfltAL.size()<1)
{	
	if(apisfltAL.size()<1)
	{		
	%>
		<div width="600" align="center" style="background-color:#FFCCFF"><span class="style2">No data found!!</span>
	<%
	}
	else
	{
	%>
	<table width="600" border="1" cellspacing="0" cellpadding="0" align="center">
<%
		for(int i=0; i<apisfltAL.size(); i++)
		{
			APISObj obj = (APISObj) apisfltAL.get(i);			
			ArrayList da13AL = obj.getDa13AL();
			if(da13AL.size()>0)
			{
				if(i==0)
				{
		%>
					 <tr class="tablehead">
					  <td align="center">Flt date(TPE)</td>
					  <td align="center">Flt date(Local)</td>
					  <td align="center">Fltno</td>
					  <td align="center">Sector</td>
					 </tr>
		<%		
				}
		%>
				<tr class="txtblue">
				  <td align="center"><%=obj.getStdtpe()%></td>
				  <td align="center">
				  <a href="sendapisList.jsp?idx=<%=i%>" target="_self"><span  class="txtxred"><%=obj.getStr_port_local()%></span>
				  </a>
				  </td>
				  <td align="center"><%=obj.getFltno()%></td>
				  <td align="center"><%=obj.getDpt()%>/<%=obj.getArv()%></td>
			  </tr>
<%
			}
			else//da13 not mapping
			{
			%>
				<div width="600" align="center" style="background-color:#FFCCFF"><span class="style2"><%=obj.getStr_port_local()%>&nbsp;&nbsp;<%=obj.getFltno()%>&nbsp;&nbsp;<%=obj.getDpt()%>/<%=obj.getArv()%> 航班資訊無法對應!! <br> 擴大對應範圍至前後 
		<input name="exphr<%=i%>" id="exphr<%=i%>" type="text" size="2" maxlength="2">小時<br>
		<input name="btn<%=i%>" type="button" class="button6" value="Query" OnClick="btn_click(<%=i%>);" ></span>
			<%
			}
		}//for(int i=0; i<objAL.size(); i++)
%>
  </table>
<%
	}
}
else
{
	APISObj obj = (APISObj) apisfltAL.get(0);
	ArrayList da13AL = obj.getDa13AL();
	if(da13AL.size()>0)
	{
%>
	<SCRIPT LANGUAGE="JavaScript">
	document.form1.target="_self";
	document.form1.action="sendapisList.jsp?idx=0";
	document.form1.submit();
	</SCRIPT>
<%
	}
	else//da13 not mapping
	{
	%>
		<div width="600" align="center" style="background-color:#FFCCFF"><span class="style2"><%=obj.getStr_port_local()%>&nbsp;&nbsp;<%=obj.getFltno()%>&nbsp;&nbsp;<%=obj.getDpt()%>/<%=obj.getArv()%> 航班資訊無法對應!! <br> 擴大對應範圍至前後
		<input name="exphr0" id="exphr0" type="text" size="3" maxlength="3">小時 &nbsp;&nbsp;
		<input name="btn0" type="button" class="button6" value="Query" OnClick="btn_click('0');" ></span>
	<%
	}
}
%>
</form>
</body>
</html>

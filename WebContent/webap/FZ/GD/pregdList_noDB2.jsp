<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,fz.gd.*,java.util.*" %>
<html>
<head>
<title>GD</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="style.css" rel="stylesheet" type="text/css">
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
String yyyy = (String) request.getParameter("sel_year") ; 
String mm = (String) request.getParameter("sel_mon") ; 
String dd = (String) request.getParameter("sel_dd") ; 
String fltno = (String) request.getParameter("fltno") ; 
String dpt = (String) request.getParameter("dpt") ; 
String version = (String) request.getParameter("version") ; 
PreWebGd we = new PreWebGd();
we.getWebEgData(yyyy+"/"+mm+"/"+dd,fltno,dpt);
ArrayList objAL = new ArrayList();
objAL= we.getObjAL();
String str = we.getStr();
if(objAL.size()>1 | objAL.size()<1)
{	
	if(!"Y".equals(str) || objAL.size() < 1)
	{
		if(!"Y".equals(str))
		{
	%>
		<div width="600" align="center" style="background-color:#FFCCFF"><span class="style2"><%=str%></span>
	<%
		}
		else
		{
	%>
		<div width="600" align="center" style="background-color:#FFCCFF"><span class="style2">No data found!!</span>
	<%
		}
	}
	else
	{
	%>
	<table width="600" border="1" cellspacing="0" cellpadding="0" align="center">
<%
		for(int i=0; i<objAL.size(); i++)
		{
			WebGdObj obj = (WebGdObj) objAL.get(i);

		if(i==0)
		{
%>
		 <tr class="tablehead">
		  <td align="center">Flt date</td>
		  <td align="center">Flt time</td>
		  <td align="center">Fltno</td>
		  <td align="center">Sector</td>
	  </tr>
<%		
		}
%>
		<tr class="txtblue">
		  <td align="center"><%=obj.getFdate().substring(0,10)%></td>
		  <td align="center">
<%
			if ("G".equals(version)) {	
			     %><a href="gdList.jsp?sel_year=<%=yyyy%>&sel_mon=<%=mm%>&sel_dd=<%=dd%>&fltno=<%=fltno%>&dpt=<%=dpt%>&ftime=<%=obj.getFdate().substring(11)%>" target="_blank"><span  class="txtxred"><%=obj.getFdate().substring(11)%></span></a><%
			}else if ("J".equals(version))	{			  
                 %><a href="gdList_J.jsp?sel_year=<%=yyyy%>&sel_mon=<%=mm%>&sel_dd=<%=dd%>&fltno=<%=fltno%>&dpt=<%=dpt%>&ftime=<%=obj.getFdate().substring(11)%>" target="_blank"><span  class="txtxred"><%=obj.getFdate().substring(11)%></span></a><%
			}else if ("N".equals(version)) {
                 %><a href="gdList_noDB2.jsp?sel_year=<%=yyyy%>&sel_mon=<%=mm%>&sel_dd=<%=dd%>&fltno=<%=fltno%>&dpt=<%=dpt%>&ftime=<%=obj.getFdate().substring(11)%>" target="_blank"><span  class="txtxred"><%=obj.getFdate().substring(11)%></span></a><%	
			}else if ("C".equals(version))	{
                 %><a href="gdList_cname_noDB2.jsp?sel_year=<%=yyyy%>&sel_mon=<%=mm%>&sel_dd=<%=dd%>&fltno=<%=fltno%>&dpt=<%=dpt%>&ftime=<%=obj.getFdate().substring(11)%>" target="_blank"><span  class="txtxred"><%=obj.getFdate().substring(11)%></span></a><%		
			}else{ 
			     %><a href="gdList_J_noDB2.jsp?sel_year=<%=yyyy%>&sel_mon=<%=mm%>&sel_dd=<%=dd%>&fltno=<%=fltno%>&dpt=<%=dpt%>&ftime=<%=obj.getFdate().substring(11)%>" target="_blank"><span  class="txtxred"><%=obj.getFdate().substring(11)%></span></a><%				
			} //if
%>
		  </td>
		  <td align="center"><%=obj.getFltno()%></td>
		  <td align="center"><%=obj.getDpt()%>/<%=obj.getArv()%></td>
	  </tr>
<%
		}//for(int i=0; i<objAL.size(); i++)
%>
  </table>
<%
	}
}else{
	WebGdObj obj = (WebGdObj) objAL.get(0);
	if("G".equals(version)) {
        %>
		<SCRIPT LANGUAGE="JavaScript">
		document.form1.target="_blank";
		document.form1.action="gdList.jsp?sel_year=<%=yyyy%>&sel_mon=<%=mm%>&sel_dd=<%=dd%>&fltno=<%=fltno%>&dpt=<%=dpt%>&ftime=<%=obj.getFdate().substring(11)%>";
		document.form1.submit();
	    </SCRIPT>
        <%
	}else if("J".equals(version))	{
        %>
		<SCRIPT LANGUAGE="JavaScript">
		document.form1.target="_blank";
		document.form1.action="gdList_J.jsp?sel_year=<%=yyyy%>&sel_mon=<%=mm%>&sel_dd=<%=dd%>&fltno=<%=fltno%>&dpt=<%=dpt%>&ftime=<%=obj.getFdate().substring(11)%>";
		document.form1.submit();
	    </SCRIPT>
        <%
	}else if("N".equals(version))	{	
	    %>
		<SCRIPT LANGUAGE="JavaScript">
		document.form1.target="_blank";
		document.form1.action="gdList_noDB2.jsp?sel_year=<%=yyyy%>&sel_mon=<%=mm%>&sel_dd=<%=dd%>&fltno=<%=fltno%>&dpt=<%=dpt%>&ftime=<%=obj.getFdate().substring(11)%>";
		document.form1.submit();
	    </SCRIPT>	
        <%
	}else if("C".equals(version))	{	
	    %>
		<SCRIPT LANGUAGE="JavaScript">
		document.form1.target="_blank";
		document.form1.action="gdList_cname_noDB2.jsp?sel_year=<%=yyyy%>&sel_mon=<%=mm%>&sel_dd=<%=dd%>&fltno=<%=fltno%>&dpt=<%=dpt%>&ftime=<%=obj.getFdate().substring(11)%>";
		document.form1.submit();
	    </SCRIPT>	
        <%		
    }else{
	    %>
		<SCRIPT LANGUAGE="JavaScript">
		document.form1.target="_blank";
		document.form1.action="gdList_J_noDB2.jsp?sel_year=<%=yyyy%>&sel_mon=<%=mm%>&sel_dd=<%=dd%>&fltno=<%=fltno%>&dpt=<%=dpt%>&ftime=<%=obj.getFdate().substring(11)%>";
		document.form1.submit();
	    </SCRIPT>
        <%	
	} //if
}

%>
</form>
</body>
</html>

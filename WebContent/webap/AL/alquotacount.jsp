<%@page contentType="text/html; charset=big5" language="java"%>
<%@page import="tool.*"%>
<jsp:useBean id="alcount" scope="page" class="al.AlQuotaCount"/>
<jsp:useBean id="ai" scope="page" class="al.ALInfo"/>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first
	response.sendRedirect("login.jsp");
} 
%>
<html>
<head>
<title>AL Quota Count</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<div align="center"> 
<%
int[] alquota;
int thequota = 0;
alquota = new int[31];

String year = request.getParameter("year");
String month = request.getParameter("month");
String jobitem = request.getParameter("jobitem");
String myday = year + "-" + month;

int keepvalue = 0;
String wcolor = "";
String qitem = "";
String station = null;

try
{
	ai.setCrewInfo(sGetUsr);
	station = ai.getStation();

	if (station.equals("TPE"))
	{
		if (jobitem.equals("PUR"))
		{
			//thequota = pur;
			qitem = "TPE PUR";
		}
		else if (jobitem.equals("FS"))
		{
			//thequota = fs;
			qitem = "TPE FS";
		}
		else if (jobitem.equals("FA"))
		{
			//thequota = fa;
			qitem = "TPE FA";
		}
		else if (jobitem.equals("TYO_CREW"))//日語組組員
		{
			//thequota = tyo_crew;
			qitem = "TPE TYO";
		}
		else if (jobitem.equals("KOR_CREW"))//韓語組組員 add by cs55 2004/08/10
		{
			//thequota = kor_crew;
			qitem = "TPE KOR";
		}
		else if (jobitem.equals("ZC"))//zone chief add by cs71 2007/03/29
		{
			//thequota = kor_crew;
			qitem = "TPE ZC";
		}
	}
	else//KHH
	{
		if (jobitem.equals("PUR"))
		{
			qitem = "KHH PUR";
		}		
		else if (jobitem.equals("ZC"))//zone chief add by cs71 2007/03/29
		{
			qitem = "KHH CREW";
		}
		else//All crew, FS、FA
		{
			qitem = "KHH CREW";
		}

	}
	alquota = alcount.quotacount(jobitem, myday, qitem, station);//date format 'yyyy-mm-dd'
}
catch(Exception e){
	out.println("Error : " + e.toString());
}
%>
<p><font face="Comic Sans MS" color="#003399"><%=jobitem%> <%=myday%> AL Quota <%=alcount.getQuota()%></font></p>
  <table width="60%" border="1" cellspacing="0" cellpadding="0">
<%
for (int i = 1; i < 5; i++)
{
	for (int t = keepvalue + 1; t <= keepvalue + 10; t++)
	{
		/*************************** Start ************************/
		String tstr = "";
		if((t)<10)
		{
			tstr = DateTool.getDay2(year+"/"+month+"/0"+Integer.toString(t));
		}
		else
		{
			tstr = DateTool.getDay2(year+"/"+month+"/"+Integer.toString(t));
		}
		String tcolor = "";
		if("六".equals(tstr) | "日".equals(tstr))
		{
			tcolor = "red";
		}
		else
		{
			tcolor = "blue";
		}

		/*************************** End ************************/
%>
      <td width="10%" bgcolor = "#C9C9C9"> 
        <div align="center"><em><font color="#333333"><font face="Arial, Helvetica, sans-serif"><%=t%><font color = "<%=tcolor%>" size="1" >(<%=tstr%>)</font></font></em></div>
      </td>
      
<%
		if (t == 31) {t = 99;}
	}
%>
<tr>
<%	
	for (int r = keepvalue + 1; r <= keepvalue + 10; r++)
	{
		thequota = alquota[r - 1];
		if(thequota <= 0){
			wcolor = "#FF0033";
			thequota = 0;
		}
		else{
			wcolor = "#0000FF";
		}
%>
	  <td width="10%"> 
        <div align="center"><font color="<%=wcolor%>"><b><font face="Arial, Helvetica, sans-serif"><%=thequota%></font></b></font></div>
      </td>
<%
		if (r == 31) {r = 99;}
	}
%>
</tr>
<%	
	keepvalue = keepvalue + 10;
}
%>
  </table>
  <br>
<br>
<table width="60%"  border="0">
  <tr>
    <td width="27%"><font face="Comic Sans MS" size="2"><A HREF='selectpage.jsp'><strong>Select Page</strong></A></font></td>
    <td width="51%"><div align="center"><font face="Comic Sans MS" size="2"><a href="inputal.jsp"><b>Input AL offsheet</b></a></font></div></td>
    <td width="22%"><div align="right"><font face="Comic Sans MS" size="2"><a href="sendredirect.jsp"><b>Logout</b></a></font></div></td>
  </tr>
  <tr>
    <td height="36" colspan="3"><div align="center"><strong><font color="#FF0000" size="2">*本系統僅供查詢，Quota以實際遞單為準。</font></strong></div></td>
    </tr>
</table>

  <br>
  <p></p>
  <p></p>
  <p align="right"><img src="logo2.gif" width="165" height="35"></p>
</div>
</body>
</html>
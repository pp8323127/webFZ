<%@page contentType="text/html; charset=big5" language="java" import="eg.off.quota.*, eg.*,tool.*"%>
<%
response.setHeader("Pragma","no-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0); //prevents caching at the proxy server
String userid = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || userid == null) 
{		//check user session start first
	response.sendRedirect("../login.jsp");
} 
%>
<html>
<head>
<title>AL Quota Count</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="menu.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style1 {color: #FF0000}
-->
</style></head>
<body bgcolor="#FFFFFF" text="#000000">
<div align="center"> 
<%
String year = request.getParameter("year");
String month = request.getParameter("month");
String jobtype = GetJobType.getEmpJobType(userid) ;
//String Qjobtype = "";
//if (jobtype.equals("TPE PR")){
//	Qjobtype = "TPE PU";
//}
java.util.Date now = new java.util.Date();
int syear	= now.getYear() + 1900;
int mm      = now.getMonth() + 1;
String mymm = Integer.toString(mm);
if (mymm.length() == 1)
{
	mymm = "0" + mymm;
}
/*
if(year == null | month == null | "".equals(year) | "".equals(month))
{
	year = Integer.toString(syear);
	month = mymm;
}
*/
ALQuota aq = new ALQuota(year, month, jobtype);
aq.getQuota() ;
aq.setUsedQuota() ;
aq.setReleaseQuota() ;
ArrayList quotaAL = aq.getObjAL();
%>
  <table width="85%" border="0" cellspacing="0" cellpadding="0">
  <tr valign="top">
	<td colspan = "5" align="left">
	<font face="Comic Sans MS" color="#003399"><%=jobtype%>&nbsp; <%=year%>-<%=month%> AL Quota (Total/Left(Release))</font><br>
	<font class="txtxred">*此表僅供查詢，Quota以實際遞單為準。</font><br>
	<font class="txtxred">*當AL Quota為零，每月遞單截止日前五天22:00~遞單截止日23:59期間，<br>	&nbsp;&nbsp;禁止上網取銷退回已申請之AL，其餘時段正常作業。</font><br>
	<font class="txtxred">*每月遞單截止日前五天23:00，可自行上網申請釋放出額度之AL。</font>
	</td>
	<td colspan = "2">
	<!--<font face="Comic Sans MS" color="#003399">-->
	<form name="form1" method="post" action="alquotacount.jsp">
		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
		<tr class="table_no_border">
		<td align="right"><!--<span class="txtblue">年/月:</span>-->
		<select name="year">
		 <%
			for (int i=syear+1; i>=syear; i--) 
			{    
		  %>
			 <option value="<%=i%>" selected><%=i%></option>
		  <%
			}
		  %>
		</select>/
		<select name="month">
		<option value="<%= mymm %>" SELECTED><font face="Arial, Helvetica, sans-serif" size="2"><%= mymm %></font></option>
		<option value="01"><font face="Arial, Helvetica, sans-serif" size="2">01</font></option>
		<option value="02"><font face="Arial, Helvetica, sans-serif" size="2">02</font></option>
		<option value="03"><font face="Arial, Helvetica, sans-serif" size="2">03</font></option>
		<option value="04"><font face="Arial, Helvetica, sans-serif" size="2">04</font></option>
		<option value="05"><font face="Arial, Helvetica, sans-serif" size="2">05</font></option>
		<option value="06"><font face="Arial, Helvetica, sans-serif" size="2">06</font></option>
		<option value="07"><font face="Arial, Helvetica, sans-serif" size="2">07</font></option>
		<option value="08"><font face="Arial, Helvetica, sans-serif" size="2">08</font></option>
		<option value="09"><font face="Arial, Helvetica, sans-serif" size="2">09</font></option>
		<option value="10"><font face="Arial, Helvetica, sans-serif" size="2">10</font></option>
		<option value="11"><font face="Arial, Helvetica, sans-serif" size="2">11</font></option>
		<option value="12"><font face="Arial, Helvetica, sans-serif" size="2">12</font></option>
		</select>
		<input type="submit" name="Submit" value="Query">
		</font>
		</td>
		</tr>
		</table>
	</form>
	</font>
  </td>
  </tr>
<%
if(quotaAL.size()>0)
{
%>
	<tr height ="20">
	  <td class="tablehead3" align="center">SUN</td>
	  <td class="tablehead3" align="center">MON</td>
	  <td class="tablehead3" align="center">TUE</td>
	  <td class="tablehead3" align="center">WED</td>
	  <td class="tablehead3" align="center">THU</td>
	  <td class="tablehead3" align="center">FRI</td>
	  <td class="tablehead3" align="center">SAT</td>
	</tr>
	<tr>
<%
	int tempday = DateTool.getDay3(year+"/"+month+"/01");
	for (int i=0; i<tempday-1 ; i++)
	{
%>
		<td width="14%"> 
		<table width= "100%" border="1" cellspacing="0" cellpadding="0">
			<tr align="center" bgcolor = "#C9C9C9">
				<td height ="20" class="tablehead2">&nbsp;
				</td>
			<tr>
			<tr align="center">
				<td class="txtblue">&nbsp;</td>
			<tr>
	    </table>
		</td>
<%	
	}

	for(int i=0; i<quotaAL.size(); i++ )
	{
		String tempdate = "";
		if((i+1)<10)
		{
			tempdate = year+"/"+month+"/0"+(i+1);
		}
		else
		{
			tempdate = year+"/"+month+"/"+(i+1);
		}


		ALQuotaObj obj = (ALQuotaObj) quotaAL.get(i);
		if(DateTool.getDay3(tempdate)==1)
		{	
			out.print("<tr>");
		}

		String tempbgcolor = "";
		if(DateTool.getDay3(tempdate)==1 | DateTool.getDay3(tempdate)==7)
		{
			//tempbgcolor ="bgcolor = '#FFCCFF'";
			tempbgcolor ="class='txtxred'";
		}
		else
		{
			//tempbgcolor ="bgcolor = '#C9C9C9'";
			tempbgcolor ="class='txtblue'";
		}
%>
		<td width="14%"> 
			<table width= "100%" border="1" cellspacing="0" cellpadding="0">
				<tr align="center">
				<td height ="20" class="tablehead2"><strong><font <%=tempbgcolor%>><%=i+1%></font></strong>
				</td>
				<tr>
				<tr align="center">
<%
			   if (Integer.parseInt(obj.getQuota_left())<=0)
			   {
%>				
				<td bgcolor="#FFCCFF" class="txtblue"><%=obj.getQuota()%>/0 (<%=obj.getQuota_release()%>)</td>
<%
			   }
			   else
			   {
%>
				<td class="txtblue"><%=obj.getQuota()%>/<%=obj.getQuota_left()%></td>
<%
			   }
%>				
				<tr>
	      </table>
		</td>
<%
		if(DateTool.getDay3(tempdate)==7)
		{	
			out.print("</tr>");
		}
	}	
%>
	</tr>
<%
}
%>
</table>
</body>
</html>
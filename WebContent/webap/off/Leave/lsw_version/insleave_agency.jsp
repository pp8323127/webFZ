<link href="../FZ/menu.css" rel="stylesheet" type="text/css">
<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="eg.off.*,eg.*, java.net.URLEncoder,java.io.*,java.util.*,java.text.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String userid = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || userid == null) 
{		//check user session start first
	response.sendRedirect("../login.jsp");
} 

String empno = request.getParameter("empno");
String offtype = request.getParameter("offtype");
String occurdate = request.getParameter("occurdate");//yyyy-mm-dd
String relation = request.getParameter("relation");
if(!"2".equals(offtype))
{
	relation = "";
}
String offsdate = request.getParameter("validfrm");//yyyy-mm-dd
String offedate = request.getParameter("validto");//yyyy-mm-dd
String tdays = request.getParameter("tdays");
String fltno = request.getParameter("fltno");
String vieqofftype = "c";
if("3".equals(offtype) | "5".equals(offtype) | "12".equals(offtype) | "13".equals(offtype) | "14".equals(offtype) | "22".equals(offtype) | "23".equals(offtype) | "25".equals(offtype) | "26".equals(offtype))
{
	vieqofftype = "b";
}

occurdate = occurdate.replaceAll("-", "/");//yyyy/mm/dd
offsdate = offsdate.replaceAll("-", "/");//yyyy/mm/dd
offedate = offedate.replaceAll("-", "/");//yyyy/mm/dd

//LeaveProgress lp = new LeaveProgress(empno, offdate,offdate,offtype,fltno,userid);
LeaveProgress lp = new LeaveProgress(empno, offsdate, offedate, offtype, occurdate, relation, fltno, userid);

String str = lp.crewLeaveCheck();
if("Y".equals(str))
{
    String str2 = "";
	str2 = lp.insLeaveRequest();
	if("Y".equals(str2))
	{
		String gdyear = "";
		if(Integer.parseInt(offsdate.substring(5,7))<10)
		{
			gdyear = offsdate.substring(0,4);
		}
		else
		{
			gdyear = Integer.toString(Integer.parseInt(offsdate.substring(0,4))+1);
		}

		if("N".equals(lp.needDoc()))
		{
			String alert_str = "";
			if("2".equals(offtype))
			{
				alert_str = "請儘速於百日內至組上補繳證明文件";
			}
			else //if(!"6".equals(offtype))
			{
				alert_str = "請儘速於七日內至組上補繳證明文件";
			}
%>
		<SCRIPT LANGUAGE="JavaScript">
			alert("<%=alert_str%>!!");
			location.replace("viewleavesheet_agency.jsp?offyear=<%=offsdate.substring(0,4)%>&offtype=<%=vieqofftype%>&empno=<%=empno%>");
		</SCRIPT>
<%
		}
		else
		{
%>
		<SCRIPT LANGUAGE="JavaScript">
			location.replace("viewleavesheet_agency.jsp?offyear=<%=offsdate.substring(0,4)%>&offtype=<%=vieqofftype%>&empno=<%=empno%>");
		</SCRIPT>
<%
		}
	}
	else
	{
		//Record Error Log
		//*************************************************************************************
		String filename = "offErrorLog.txt";	 	
		String path = "/apsource/csap/projfz/txtin/off/";
		FileWriter fwlog = new FileWriter(path+filename,true);
		try
		{
			java.util.Date runDate1 = Calendar.getInstance().getTime();
			String time1 = new SimpleDateFormat("yyyy/MM/dd EEE HH:mm:ss a").format(runDate1);
			fwlog.write("Userid : "+userid+" Runtime: "+time1+" Empno : "+empno+" Offdate : "+offsdate+"~"+offedate+" Fltno : "+fltno+" Offtype : "+offtype+"  Error Msg : "+str2+"  \r\n");
			fwlog.write("*************************************** \r\n");	
					
		}
		catch (Exception e)
		{
			System.out.println(e.toString());
		} 
		finally
		{
			fwlog.close();	
		}
		//*************************************************************************************
		String str1 ="The request failed!!<br> Msg: "+str2+"!!<br><a href='javascript:history.back(-1)'>back</a>";
		response.sendRedirect("sm.jsp?messagestring="+URLEncoder.encode(str1));
	}
}
else
{
	//Record Error Log
	//*************************************************************************************
	String filename = "offErrorLog.txt";	 	
	String path = "/apsource/csap/projfz/txtin/off/";
	FileWriter fwlog = new FileWriter(path+filename,true);
	try
	{
		java.util.Date runDate1 = Calendar.getInstance().getTime();
		String time1 = new SimpleDateFormat("yyyy/MM/dd EEE HH:mm:ss a").format(runDate1);
		fwlog.write("Userid : "+userid+" Runtime: "+time1+" Empno : "+empno+" Offdate : "+offsdate+"~"+offedate+" Fltno : "+fltno+" Offtype : "+offtype+"  Error Msg : "+str+"  \r\n");
		fwlog.write("*************************************** \r\n");	
				
	}
	catch (Exception e)
	{
		System.out.println(e.toString());
	} 
	finally
	{
		fwlog.close();	
	}
	//*************************************************************************************

	String str1 ="The request failed!!<br> Msg: "+str+"!!<br><a href='javascript:history.back(-1)'>back</a>";
	response.sendRedirect("sm.jsp?messagestring="+URLEncoder.encode(str1));
}
%>
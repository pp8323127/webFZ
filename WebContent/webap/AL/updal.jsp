<link href="../FZ/menu.css" rel="stylesheet" type="text/css">
<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="al.*, java.net.URLEncoder"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first
	response.sendRedirect("login.jsp");
} 
%>
<%
String sern = request.getParameter("sern");
String station = request.getParameter("station");

String offsdate = request.getParameter("validfrm");//yyyy-mm-dd
String offedate = request.getParameter("validto");//yyyy-mm-dd

String gradeyear = offedate.substring(0, 4); //yyyy-mm-dd
String str = null;
String rs = null;
String sumoff = "N";

CheckUpdateAl cua = null;
out.println(offsdate + "," + offedate + "," + sGetUsr + "," + sern);
try{
	cua = new CheckUpdateAl();
	rs = cua.handleOff(offsdate, offedate, sGetUsr, sern);
	
	//if have Exception return string start with "Error"
	if("E".equals(rs.substring(0, 1))){
		str = "系統忙碌中, 請稍後再試................";
	}
	else{
		str = rs;
	}
	
	if(!"0".equals(rs)){
		String m1 = "假單輸入失敗 !!";
		response.sendRedirect("showmessage.jsp?message1="+URLEncoder.encode(m1)+"&message2="+URLEncoder.encode(str)+"&gdyear="+gradeyear+"&empn="+sGetUsr);
	}
	else{
	//2006/01/04
	//組員當月請休假(含預遞送單)超過15天者，系統message box提醒訊息如下：
	//為符合法規，請再次確認ETS及SS訓練到期月份，自行控管休假天數。
		if(cua.getOverOff(sern, offsdate.substring(0, 7)) > 14){
			sumoff = "Y";
		}
		//out.println("success !!");
		response.sendRedirect("viewoffsheet.jsp?f="+offsdate+" to "+offedate+"&offyear="+gradeyear+"&sumoff="+sumoff);
	}
}
catch(Exception e){
	out.println(e.toString());
}
%>
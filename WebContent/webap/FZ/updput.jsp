<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,ci.tool.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
 %>
 <jsp:forward page="sendredirect.jsp" /> 
<%
} 

String[] cp = request.getParameterValues("checkput");
String[] comm = request.getParameterValues("comm");
for(int i=0;i<comm.length;i++){
	comm[i] = ReplaceAllFor1_3.replace(comm[i],"'","''");
}
if (cp == null)
{
	%>
	<jsp:forward page="showmessage.jsp">
	<jsp:param name="messagestring" value="No Schedule been Putting !" />
	</jsp:forward>
	<%
}

String[] rowid = new String[cp.length];
//String[] rowid = request.getParameterValues("rowid");
String[] fdate = new String[cp.length];
String[] tripno = new String[cp.length];
String[] fltno = new String[cp.length];
String mm = null;

for (int i = 0; i < cp.length; i++)
{
	rowid[i] = cp[i].substring(0, 2);
	fdate[i] = cp[i].substring(2, 12);
	tripno[i] = cp[i].substring(12, 16);
	fltno[i] = cp[i].substring(16);
	mm = cp[i].substring(2, 9);
	//out.println(fdate[i]+","+fltno[i]+","+rowid[i]);
}

putSche ps = new putSche();
String rs = ps.doPut(sGetUsr, fdate, fltno, tripno, rowid, comm);

if (!rs.equals("0"))
{
	%>
	<jsp:forward page="showmessage.jsp">
	<jsp:param name="messagestring" value="<%=rs%>" />
	</jsp:forward>
   <% 
}else{
%>
<jsp:forward page="dutyput.jsp">
<jsp:param name="mydate" value="<%=mm%>" />
<jsp:param name="pyy" value="" />
</jsp:forward>
<%
}
%>
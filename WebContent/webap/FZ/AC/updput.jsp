<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="java.sql.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null ) {
	response.sendRedirect("../sendredirect.jsp");
} else{
String year = request.getParameter("year");
String month = request.getParameter("month");

 if( null == request.getParameterValues("year") |	null == request.getParameterValues("month")
	| "".equals(request.getParameterValues("year")) | "".equals(request.getParameterValues("month"))){
%>
<p  style="background-color:#99FFFF;color:#FF0000;font-family:Verdana;font-size:10pt;padding:5pt;text-align:center;">請選擇年/月</p>

<%

} else
if(null == request.getParameterValues("checkput") ){

%>
<script>
	alert("請勾選欲丟出的班!!");
	self.location="dutyput.jsp?year=<%=year%>&month=<%=month%>";
</script>
<%

}else{


String[] cp = request.getParameterValues("checkput");
String[] comm = request.getParameterValues("comm");

fzac.CrewPutSkjObj cpObj = (fzac.CrewPutSkjObj)session.getAttribute("putSkjObj");

ArrayList al = new ArrayList();

for(int i=0;i<cp.length;i++){
	int idxx = Integer.parseInt(cp[i]);
	al.add(comm[idxx]);
	
}
cpObj.setCommentAL(al);


fzac.UpdatePutSkj upd = new fzac.UpdatePutSkj(cpObj,cp);
try{
	upd.UpdateData();
	
}catch(SQLException e){
//out.print(e.toString());
}catch(Exception e){
//out.print(e.toString());
}

//寫入log
fz.writeLog wl = new fz.writeLog();
wl.updLog(sGetUsr, request.getRemoteAddr(),request.getRemoteHost(), "FZ430");


response.sendRedirect("dutyput.jsp?year="+year+"&month="+month);
}
}
%>
<%@page contentType="text/html; charset=big5" language="java" import=""%>
<%
String sdate = request.getParameter("sdate");
eg.off.LeaveRules lr = new eg.off.LeaveRules(sdate);
String ifskjpub = lr.hasSkj();
%>
<script type="text/javascript">	
window.opener.document.getElementById("spub").value='<%=ifskjpub%>';	
this.window.close();
</script>


<%@ page contentType="text/html; charset=big5" language="java" import="apis.*,java.sql.*,ci.db.*,java.util.*,java.io.*, java.text.*,java.math.*" %>
<jsp:useBean id="apisInsert" class="fz.ApisInsert" />
<%!
String[] apisRow = new String[39];
%>
<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ;
if (session.isNew() || sGetUsr == null) {		//check user session start first
    %> <jsp:forward page="../sendredirect.jsp" /> <%
}//if
String status = "";
String pk = "";
String carrier = request.getParameter("carrier"); 
String fltyyyy = request.getParameter("fltyyyy"); 
String fltyy   = fltyyyy.substring(2,4);
String fltmm   = request.getParameter("fltmm"); 
String fltdd   = request.getParameter("fltdd"); 
String fltno   = request.getParameter("fltno");
String empno   = request.getParameter("empno"); 
String lname   = request.getParameter("lname"); 
String fname   = request.getParameter("fname"); 
String depart  = request.getParameter("depart"); 
String dest    = request.getParameter("dest"); 
String nation  = request.getParameter("nation"); 
String birthyyyy = request.getParameter("birthyyyy");
String birthyy = birthyyyy.substring(2,4);
String birthmm = request.getParameter("birthmm");
String birthdd = request.getParameter("birthdd");
String birthcity = request.getParameter("birthcity"); 
String birthcountry = request.getParameter("birthcountry"); 
String resicountry  = request.getParameter("resicountry"); 
String resiaddr1 = request.getParameter("resiaddr1"); if (resiaddr1 == null) resiaddr1 = ""; 
String resiaddr2 = request.getParameter("resiaddr2"); if (resiaddr2 == null) resiaddr2 = ""; 
String resiaddr3 = request.getParameter("resiaddr3"); if (resiaddr3 == null) resiaddr3 = ""; 
String resiaddr4 = request.getParameter("resiaddr4"); if (resiaddr4 == null) resiaddr4 = ""; 
String resiaddr5 = request.getParameter("resiaddr5"); if (resiaddr5 == null) resiaddr5 = ""; 
String passport  = request.getParameter("passport"); 
String doctype   = request.getParameter("doctype"); 
String passcountry  = request.getParameter("passcountry"); 
String passyyyy = request.getParameter("passyyyy");
String passyy   = passyyyy.substring(2,4);
String passmm   = request.getParameter("passmm");
String passdd   = request.getParameter("passdd");
String gender   = request.getParameter("gender"); 
String gdorder  = request.getParameter("gdorder");
String occu     = request.getParameter("occu"); 
String tvlstatus = request.getParameter("tvlstatus"); 
String dh       = request.getParameter("dh");       if (dh == null)   dh   = "";
String meal     = request.getParameter("meal");     if (meal == null) meal = "";
String certno   = request.getParameter("certno");   if (certno == null) certno = "";
String certctry = request.getParameter("certctry"); if (certctry == null) certctry = "";
String certdoctype  = request.getParameter("certdoctype"); if (certdoctype == null) certdoctype = "";
String certyyyy  = request.getParameter("certyyyy"); if (certyyyy == null) certyyyy = "";
String certyy;
if (certyyyy.length() == 4) certyy = certyyyy.substring(2,4);	   
else certyy = "";     
String certmm = request.getParameter("certmm"); if (certmm == null) certmm = "";
String certdd = request.getParameter("certdd"); if (certdd == null) certdd = "";

apisRow[0]  = pk; 
apisRow[1]  = carrier; 
apisRow[2]  = fltno; 
apisRow[3]  = fltyy+fltmm+fltdd;
apisRow[4]  = empno;
apisRow[5]  = lname; 
apisRow[6]  = ""; //mname
apisRow[7]  = fname;
apisRow[8]  = nation; 
apisRow[9]  = ""; //issue 
apisRow[10] = birthyy+birthmm+birthdd; 
apisRow[11] = passport; 
apisRow[12] = gender; 
apisRow[13] = dest; 
apisRow[14] = depart;
apisRow[15] = gdorder; 
apisRow[16] = sGetUsr;
apisRow[17] = occu;
apisRow[18] = dh; 
apisRow[19] = meal; 
apisRow[20] = certno; 
apisRow[21] = certctry; 
apisRow[22] = ""; //flag1
apisRow[23] = ""; //flag2
apisRow[24] = ""; //flag3
apisRow[25] = passcountry; 
apisRow[26] = doctype;
apisRow[27] = birthcity;
apisRow[28] = birthcountry; 
apisRow[29] = resicountry; 
apisRow[30] = resiaddr1; 
apisRow[31] = resiaddr2; 
apisRow[32] = resiaddr3; 
apisRow[33] = resiaddr4; 
apisRow[34] = resiaddr5;
apisRow[35] = tvlstatus; 
apisRow[36] = passyy+passmm+passdd;
apisRow[37] = certdoctype;
apisRow[38] = certyy + certmm + certdd;
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title></title>
<style type="text/css">
<!--
.invisibleButton {border:0; background-color:white;}
-->
</style>
<script language=javascript>
function apisSelect(){  	   
   document.form1.target = "_self";
   document.form1.action = "apis_select.jsp";
   document.form1.submit();	
}//function
</script>
</head>
<body>
<form name="form1" method="post">
    <input name="sel_year" type="hidden" value=<%=fltyyyy%> >
    <input name="sel_mon"  type="hidden" value=<%=fltmm%>   >
    <input name="sel_dd"   type="hidden" value=<%=fltdd%>   >
    <input name="fltno"    type="hidden" value=<%=fltno%>   >
    <input class="invisibleButton" name="submit"   type="submit" value="" onClick="apisSelect()"> 
</form>
<%
status = apisInsert.insert(apisRow);
session.setAttribute("seStatus", status);
pageContext.removeAttribute("apisInsert");
%><script language="javascript">	   
document.form1.submit.click();
</script><%   
%>

</body>
</html>

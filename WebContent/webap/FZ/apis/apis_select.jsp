<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="apis.*,java.sql.*,java.util.*,ci.db.*" %>
<jsp:useBean id="apisSelect" class="fz.ApisSelect" />
<%!
ArrayList ArrCarrier  = null; 
ArrayList ArrFltno    = null; 
ArrayList ArrFdate    = null; 
ArrayList ArrEmpno    = null; 
ArrayList ArrLname    = null; 
ArrayList ArrFname    = null; 
ArrayList ArrNation   = null; 
ArrayList ArrBirth    = null; 
ArrayList ArrPassport = null; 
ArrayList ArrGender   = null; 
ArrayList ArrDest     = null;
ArrayList ArrDepart   = null;
ArrayList ArrRemark   = null; 
ArrayList ArrGdorder = null; 
ArrayList ArrOccu = null; 
ArrayList ArrDh   = null; 
ArrayList ArrMeal = null;
ArrayList ArrCertno      = null;
ArrayList ArrCertctry    = null;
ArrayList ArrPasscountry = null;
ArrayList ArrDoctype     = null;
ArrayList ArrBirthcity   = null;
ArrayList ArrBirthcountry = null;
ArrayList ArrResicountry  = null;
ArrayList ArrTvlstatus  = null;
ArrayList ArrPassexp    = null;
ArrayList ArrCertdoctype  = null;
ArrayList ArrCertexp = null;

String fltyyyy, fltyy, fltmm, fltdd, fdate, fltno;
HashMap hm;
int i;
%>

<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //Check if logined
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
if (session.isNew() || sGetUsr == null) {		//check user session start first
    %> <jsp:forward page="../sendredirect.jsp" /> <%
}//if
if (sGetUsr.equals("630973") || sGetUsr.equals("626542") || sGetUsr.equals("640354")){
   //
}else if (sGetUsr.equals("633007") || sGetUsr.equals("634319") || sGetUsr.equals("637299") || sGetUsr.equals("638716") || sGetUsr.equals("640073") || sGetUsr.equals("640790")) {
   //
}else{	
   session.setAttribute("errMsg", "You are not authorized."); 
  %> <jsp:forward page="apis_error.jsp" /> <% 
}//if

String status= (String) session.getAttribute("seStatus"); 
if (status == null){
   status = "Ready.";
   session.setAttribute("seStatus", status);
}//if 

ArrCarrier  = new ArrayList(); 
ArrFltno    = new ArrayList(); 
ArrFdate    = new ArrayList(); 
ArrEmpno    = new ArrayList(); 
ArrLname    = new ArrayList(); 
ArrFname    = new ArrayList(); 
ArrNation   = new ArrayList(); 
ArrBirth    = new ArrayList(); 
ArrPassport = new ArrayList(); 
ArrGender   = new ArrayList(); 
ArrDest     = new ArrayList();
ArrDepart   = new ArrayList();
ArrRemark   = new ArrayList(); 
ArrGdorder  = new ArrayList(); 
ArrOccu     = new ArrayList(); 
ArrDh       = new ArrayList(); 
ArrMeal     = new ArrayList();
ArrCertno   = new ArrayList();
ArrCertctry = new ArrayList();
ArrPasscountry  = new ArrayList();
ArrDoctype      = new ArrayList();
ArrBirthcity    = new ArrayList();
ArrBirthcountry = new ArrayList();
ArrResicountry  = new ArrayList();
ArrTvlstatus = new ArrayList();
ArrPassexp   = new ArrayList();
ArrCertdoctype  = new ArrayList();
ArrCertexp = new ArrayList();

fltyyyy = request.getParameter("sel_year");
if (fltyyyy == null){
   fltyyyy = "";
   fltyy = "";
}else{   
   fltyy = fltyyyy.substring(2,4);
}//if

fltmm = request.getParameter("sel_mon"); 
if (fltmm == null) {
   fltmm ="";
}//if
   
fltdd = request.getParameter("sel_dd");  
if (fltdd == null) {
   fltdd ="";
}//if

fltno = request.getParameter("fltno");   
if (fltno == null){
   fltno ="";
}//if

String errMsg = "";
fdate = fltyy + fltmm + fltdd;
hm = apisSelect.select(fdate,fltno);
ArrCarrier  = (ArrayList)hm.get("carrier"); 
ArrFltno    = (ArrayList)hm.get("fltno"); 
ArrFdate    = (ArrayList)hm.get("fdate"); 
ArrEmpno    = (ArrayList)hm.get("empno"); 
ArrLname    = (ArrayList)hm.get("lname"); 
ArrFname    = (ArrayList)hm.get("fname"); 
ArrNation   = (ArrayList)hm.get("nation"); 
ArrBirth    = (ArrayList)hm.get("birth"); 
ArrPassport = (ArrayList)hm.get("passport"); 
ArrGender   = (ArrayList)hm.get("gender"); 
ArrDest     = (ArrayList)hm.get("dest");
ArrDepart   = (ArrayList)hm.get("depart");
ArrRemark   = (ArrayList)hm.get("remark"); 
ArrGdorder  = (ArrayList)hm.get("gdorder"); 
ArrOccu     = (ArrayList)hm.get("occu"); 
ArrDh       = (ArrayList)hm.get("dh"); 
ArrMeal     = (ArrayList)hm.get("meal");
ArrCertno   = (ArrayList)hm.get("certno");
ArrCertctry = (ArrayList)hm.get("certctry");
ArrPasscountry  = (ArrayList)hm.get("passcountry");
ArrDoctype      = (ArrayList)hm.get("doctype");
ArrBirthcity    = (ArrayList)hm.get("birthcity");
ArrBirthcountry = (ArrayList)hm.get("birthcountry");
ArrResicountry  = (ArrayList)hm.get("resicountry");
ArrTvlstatus    = (ArrayList)hm.get("tvlstatus");
ArrPassexp      = (ArrayList)hm.get("passexp");
ArrCertdoctype  = (ArrayList)hm.get("certdoctype");
ArrCertexp      = (ArrayList)hm.get("certexp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>APIS Select</title>
<link href="../style2.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
function apisModify(formName){
    eval("document."+formName+".chgtype.value='modify'");
	eval("document."+formName+".target = '_self'");
	eval("document."+formName+".action = 'apis_fillform.jsp'");
	eval("document."+formName+".submit()");
}//function
          
function apisInsert(formName){
    eval("document."+formName+".chgtype.value='insert'");
	eval("document."+formName+".insertwho.value='unknown'");
	eval("document."+formName+".target = '_self'");
	eval("document."+formName+".action = 'apis_fillform.jsp'");
	eval("document."+formName+".submit()");
}//function

function apisDelete(formName){
	//eval("document."+formName+".target = '_blank'");	
	flag = confirm("Are you sure to delete the record ?");
	if (flag == true){	    
		eval("document."+formName+".action = 'apis_delete.jsp'");
		eval("document."+formName+".submit()");
	}//if	
}//function
</script>
</head>
<body>
<table width="130%"  border="0" align="center"><tr><td>
    <div align="right"><a href="javascript:window.print()"> <img src="../images/print.gif" width="17" height="15" border="0" alt="Printing"></a> 
    </div>
</td></tr>
</table>
<table width="130%"  border="0" align="center">
  <tr bgcolor="#FFFF11"> 
     <td colspan="29"> <div align="left"><%=status%> </div></td>
  </tr>
</table>
<table width="100%"  border="1" align="center">
  <tr>
    <td colspan="2" bgcolor="#DAFCD1"> 
   <form name="forminsert" method="post">
      <input name="chgtype" type="hidden">
	  <input name="insertwho" type="hidden">
      <input name="insert" type="button" value="Insert" onClick="apisInsert('forminsert')">
   </form>
   </td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Ca-<br>rrier</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Flt<br>num</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Flt<br>date</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Empno</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Last<br>name</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">First<br>name</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Dep</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Arv</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Nat-<br>ion</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Birth<br>date</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Birth<br>city</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Birth<br>ctry</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Resi-<br>dent<br>ctry</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Pass<br>num</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Pass<br>ctry</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Pass<br>doc<br>type</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Pass<br>expiry</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Sex</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">GD<br>order</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Occu</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Tvl<br>sta-<br>tus</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">DH</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Meal</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">2nd<br>doc<br>num</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">2nd<br>doc<br>ctry</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">2nd<br>doc<br>type</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">2nd<br>doc<br>expiry</td>
    <td class="FontSizeEngB" bgcolor="#CCCCCC">Change<br>date</td>

<% 

String bcolor = "";
for (i = 0; i < ArrEmpno.size(); i++){ 
       if((i % 2) == 0) bcolor = "";
       else bcolor = "#DAFCD1";
       %>	
       <form name="form<%=i%>" method="post">   
           <input name="chgtype" type="hidden">
     	   <input name="carrier"      type="hidden" value="<%=ArrCarrier.get(i)%>"> 
   	       <input name="fltno"        type="hidden" value="<%=ArrFltno.get(i)%>"> 
   	       <input name="fdate"        type="hidden" value="<%=ArrFdate.get(i)%>"> 
   	       <input name="empno"        type="hidden" value="<%=ArrEmpno.get(i)%>"> 
   	       <input name="lname"        type="hidden" value="<%=ArrLname.get(i)%>"> 
   	       <input name="fname"        type="hidden" value="<%=ArrFname.get(i)%>"> 
   	       <input name="depart"       type="hidden" value="<%=ArrDepart.get(i)%>"> 
   	       <input name="dest"         type="hidden" value="<%=ArrDest.get(i)%>"> 
   	       <input name="nation"       type="hidden" value="<%=ArrNation.get(i)%>"> 
   	       <input name="birth"        type="hidden" value="<%=ArrBirth.get(i)%>"> 
   	       <input name="birthcity"    type="hidden" value="<%=ArrBirthcity.get(i)%>"> 
   	       <input name="birthcountry" type="hidden" value="<%=ArrBirthcountry.get(i)%>"> 
   	       <input name="resicountry"  type="hidden" value="<%=ArrResicountry.get(i)%>"> 
   	       <input name="passport"     type="hidden" value="<%=ArrPassport.get(i)%>"> 
   	       <input name="passcountry"  type="hidden" value="<%=ArrPasscountry.get(i)%>"> 
   	       <input name="doctype"      type="hidden" value="<%=ArrDoctype.get(i)%>"> 
   	       <input name="passexp"      type="hidden" value="<%=ArrPassexp.get(i)%>"> 
     	   <input name="gender"       type="hidden" value="<%=ArrGender.get(i)%>"> 
   	       <input name="gdorder"      type="hidden" value="<%=ArrGdorder.get(i)%>"> 
   	       <input name="occu"         type="hidden" value="<%=ArrOccu.get(i)%>"> 
   	       <input name="tvlstatus"    type="hidden" value="<%=ArrTvlstatus.get(i)%>"> 
   	       <input name="dh"           type="hidden" value="<%=ArrDh.get(i)%>"> 
   	       <input name="meal"         type="hidden" value="<%=ArrMeal.get(i)%>"> 
   	       <input name="certno"       type="hidden" value="<%=ArrCertno.get(i)%>"> 
   	       <input name="certctry"     type="hidden" value="<%=ArrCertctry.get(i)%>"> 
   	       <input name="certdoctype"  type="hidden" value="<%=ArrCertdoctype.get(i)%>"> 
   	       <input name="certexp"      type="hidden" value="<%=ArrCertexp.get(i)%>"> 
   	       <input name="remark"       type="hidden" value="<%=ArrRemark.get(i)%>"> 
	  
   	       <tr bgcolor="<%=bcolor%>"> 
	       <td bordercolor="#DAFCD1"> 
		   <input name="modify" type="button" value="Modify" onClick="apisModify('form<%=i%>')"> </td>
           <td>		    
	       <input name="delete" type="button" value="Delete" onClick="apisDelete('form<%=i%>')"> </td>
   	       <td class="FontSizeEngB"><%=ArrCarrier.get(i)%></td>
   	       <td class="FontSizeEngB"><%=ArrFltno.get(i)%></td>
   	       <td class="FontSizeEngB"><%=ArrFdate.get(i)%></td>
   	       <td class="FontSizeEngB"><%=ArrEmpno.get(i)%></td>
   	       <td class="FontSizeEngB"><%=ArrLname.get(i)%></td>
   	       <td class="FontSizeEngB"><%=ArrFname.get(i)%></td>
     	   <td class="FontSizeEngB"><%=ArrDepart.get(i)%></td>
    	   <td class="FontSizeEngB"><%=ArrDest.get(i)%></td>
    	   <td class="FontSizeEngB"><%=ArrNation.get(i)%></td>
    	   <td class="FontSizeEngB"><%=ArrBirth.get(i)%></td>
    	   <td class="FontSizeEngB"><%=ArrBirthcity.get(i)%></td>
           <td class="FontSizeEngB"><%=ArrBirthcountry.get(i)%></td>
    	   <td class="FontSizeEngB"><%=ArrResicountry.get(i)%></td>
   	       <td class="FontSizeEngB"><%=ArrPassport.get(i)%></td>
   	       <td class="FontSizeEngB"><%=ArrPasscountry.get(i)%></td>
    	   <td class="FontSizeEngB"><%=ArrDoctype.get(i)%></td>
    	   <td class="FontSizeEngB"><%=ArrPassexp.get(i)%></td>
    	   <td class="FontSizeEngB"><%=ArrGender.get(i)%></td>
    	   <td class="FontSizeEngB"><%=ArrGdorder.get(i)%></td>
   	       <td class="FontSizeEngB"><%=ArrOccu.get(i)%></td>
   	       <td class="FontSizeEngB"><%=ArrTvlstatus.get(i)%></td>
   	       <td class="FontSizeEngB"><%=ArrDh.get(i)%></td>
   	       <td class="FontSizeEngB"><%=ArrMeal.get(i)%></td>
   	       <td class="FontSizeEngB"><%=ArrCertno.get(i)%></td>
    	   <td class="FontSizeEngB"><%=ArrCertctry.get(i)%></td>
   	       <td class="FontSizeEngB"><%=ArrCertdoctype.get(i)%></td>
   	       <td class="FontSizeEngB"><%=ArrCertexp.get(i)%></td>
   	       <td class="FontSizeEngB"><%=ArrRemark.get(i)%></td>
   	      </tr>	   
       </form>
       <%
} //for
%> 
</table>
<p>
<table width="100%"  border="0">
   <tr><td><p align="left"> * 2nd document: Pilot certificate or cabin crew green card.</p></td></tr>
</table>
</p>
</body>
</html>
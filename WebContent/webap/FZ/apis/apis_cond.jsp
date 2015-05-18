<%@ page contentType="text/html; charset=big5" language="java" import="ci.db.*,java.util.*,java.sql.*,fz.UnicodeStringParser" errorPage=""%>
<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //Check if logined
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
if (session.isNew() || sGetUsr == null) {		//check user session start first
    %> <jsp:forward page="../sendredirect.jsp" /> <%
}//if

String authority = null;
if (sGetUsr.equals("630973") || sGetUsr.equals("626542") || sGetUsr.equals("640354")){
   //authority = "pilot";
}else if ( sGetUsr.equals("628152") || sGetUsr.equals("633248")) {
   //authority = "cabin";
}else if (sGetUsr.equals("633007") || sGetUsr.equals("634319") || sGetUsr.equals("637299") || sGetUsr.equals("638716") || sGetUsr.equals("640073") || sGetUsr.equals("640790")) {
   //authority = "all";
}else{	
   session.setAttribute("errMsg", "You are not authorized."); 
  %> <jsp:forward page="mcl_error.jsp" /> <% 
}//if

Calendar cal = new GregorianCalendar();
cal.setTime(new java.util.Date()); 
String syear   = "" + cal.get(Calendar.YEAR);        
int iyear = Integer.parseInt(syear);
String smonth  = "" + (cal.get(Calendar.MONTH)+1);   if (Integer.parseInt(smonth)  < 10) smonth  = "0" + smonth;
String sdate   = "" + cal.get(Calendar.DATE);        if (Integer.parseInt(sdate)   < 10) sdate   = "0" + cal.get(Calendar.DATE);
//String shour   = "" + cal.get(Calendar.HOUR_OF_DAY); if (Integer.parseInt(shour)   < 10) shour   = "0" + cal.get(Calendar.HOUR_OF_DAY);
//String sminute = "" + cal.get(Calendar.MINUTE);      if (Integer.parseInt(sminute) < 10) sminute = "0" + cal.get(Calendar.MINUTE);
//String ssecond = "" + cal.get(Calendar.SECOND);      if (Integer.parseInt(ssecond) < 10) ssecond = "0" + cal.get(Calendar.MINUTE);
%>
<html>
<head>
<title>APIS</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../menu.css" rel="stylesheet" type="text/css">
<script language=javascript>
function getValue(){
    document.form1.sel_year.value = "<%=syear%>";
    document.form1.sel_mon.value  = "<%=smonth%>";
    document.form1.sel_dd.value   = "<%=sdate%>";		 	  
} //function

function apisFind(formName){  
    eval("document."+formName+".sel_year.value='" + document.form1.sel_year.value +"'");	  
	eval("document."+formName+".sel_mon.value='"  + document.form1.sel_mon.value  +"'");
	eval("document."+formName+".sel_dd.value='"   + document.form1.sel_dd.value   +"'"); 
	eval("document."+formName+".fltno.value='"    + document.form1.fltno.value    +"'");
	eval("document."+formName+".target = 'mainFrame'");
	eval("document."+formName+".action = 'apis_select.jsp'");
	eval("document."+formName+".submit()");
}//function

function apisTransfer(formName){
    flttype = document.form1.fltno.value;
	if (flttype == ""){
	   flttype = "all";    
	}//if
	 
	if (flttype=="all" && document.form1.sel_crewtype.value != "all"){	   
	   alert("You can only select all crew when transfer all flights!");
	   return false;
	}//if	
	
    if(document.form1.sel_year.value == "") {
	 	alert("flt year can not be empty!!");
		eval("document.form1.sel_year.focus()");
		return false;
	}//fltyyyy
	
	if(document.form1.sel_mon.value == "") {
	 	alert("flt month can not be empty!!");
		eval("document.form1.sel_mon.focus()");
		return false;
	}//fltmm	
	
	if(document.form1.sel_dd.value == "") {
	 	alert("flt day can not be empty!!");
		eval("document.form1.sel_dd.focus()");
		return false;
	}//fltdd

	flag = confirm("Transfer the following data? \n\n\n"+
	               "Flight date: "+document.form1.sel_year.value+"/"+document.form1.sel_mon.value+"/"+document.form1.sel_dd.value+"\n\n"+
				   "Flight number: " + flttype +"\n\n"+
				   "Crew type: "+document.form1.sel_crewtype.value);
	if (!flag){
	   return false;	
    }//if

    eval("document."+formName+".sel_crewtype.value='" + document.form1.sel_crewtype.value +"'");
	eval("document."+formName+".sel_year.value='" + document.form1.sel_year.value +"'");	  
	eval("document."+formName+".sel_mon.value='"  + document.form1.sel_mon.value  +"'");
	eval("document."+formName+".sel_dd.value='"   + document.form1.sel_dd.value   +"'"); 
	eval("document."+formName+".fltno.value='"    + document.form1.fltno.value    +"'");
	eval("document."+formName+".target = 'mainFrame'");
	eval("document."+formName+".action = 'apis_transfer.jsp'");
	eval("document."+formName+".submit()");
}//function
</script>
</head>
<body onload='getValue();'>
<table><tr>
<td>
<form name="form1" method="post" class="txtblue" target="mainFrame">
APIS&nbsp;
    <select name="sel_crewtype">
      <option value="all">All</option>
      <option value="pilot">Pilot</option>
      <option value="cabin">Cabin</option>
    </select>  &nbsp;
	
    <select name="sel_year">
    <%
	for (int i=iyear-1; i<iyear+2; i++) {    
        %> <option value="<%=i%>"><%=i%></option> <%
	}//for
    %>
    </select>
    / 
    <select name="sel_mon">
    <%
	for (int j=1; j<13; j++) {    
	    if (j<10 ){
           %> <option value="0<%=j%>">0<%=j%></option> <%
		}else{
           %> <option value="<%=j%>"><%=j%></option> <%
		}//if
	}//for
    %>
    </select>
    / 
    <select name="sel_dd">
    <%
	for (int j=1; j<32; j++) 	{    
        if (j<10 ){
             %><option value="0<%=j%>">0<%=j%></option>   <%
	    }else	{
             %> <option value="<%=j%>"><%=j%></option> <%
		}//if
    }//for
    %>
    </select>&nbsp;
	 Fltno  
	 <input name="fltno" type="text" size="5" maxlength="5" >
        (ex.0006) 
      </form>
  </td>  
  <td>
  <form name="formtransfer" method="post">
     <input name="sel_crewtype" type="hidden">
     <input name="sel_year" type="hidden">
     <input name="sel_mon"  type="hidden">
     <input name="sel_dd"   type="hidden">
	 <input name="fltno"    type="hidden">
     <input name="transfer" type="button" value="Transfer" onClick="apisTransfer('formtransfer')">
  </form>
  </td>
  
  <td>
  <form name="formfind" method="post">
     <input name="sel_year" type="hidden">
     <input name="sel_mon"  type="hidden">
     <input name="sel_dd"   type="hidden">
	 <input name="fltno"    type="hidden">
     <input name="find"     type="button" value="Find" onClick="apisFind('formfind')">
  </form>
  </td>
  </table>
</body>
</html>
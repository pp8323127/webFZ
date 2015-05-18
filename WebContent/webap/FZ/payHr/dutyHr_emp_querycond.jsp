<%@ page contentType="text/html; charset=big5" language="java" import="ci.db.*,java.util.*,java.sql.*,java.text.*,fz.UnicodeStringParser" errorPage=""%>
<%!
GregorianCalendar currCal;
String currYear,currMonth,currDate,currHour,currMinute;
%>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login
if (userid == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} //if
%>
<html>
<head>
<title>Cabin crew duty hour</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../menu.css" rel="stylesheet" type="text/css">
<script src="payHr_showDate.js"></script>
<script language="JavaScript">
function func_slist(){   
    //flag = confirm("Are you sure ?");
	//if (flag == true){	    
		//eval("document."+formName+".action = 'othnat_delete.jsp'");
		//eval("document."+formName+".submit()");
	//}
	eval("document.form1.target = 'mainFrame'");
	eval("document.form1.action = 'dutyHr_emp_queryresult.jsp'");
	eval("document.form1.submit()");
}//function

/*
function func_plist(){
	eval("document.form1.target = 'mainFrame'");
	eval("document.form1.action = 'paraw_pass.jsp'");
	eval("document.form1.submit()");
}//function   

function func_flist(){
	eval("document.form1.target = 'mainFrame'");
	eval("document.form1.action = 'paraw_fail.jsp'");
	eval("document.form1.submit()");
}//function    

function func_alist(){
	eval("document.form1.target = 'mainFrame'");
	eval("document.form1.action = 'paraw_all.jsp'");
	eval("document.form1.submit()");
}//function  

function func_import(){
    std = document.form1.sel_year2.value + document.form1.sel_mon2.value + document.form1.sel_dd2.value + "1700";
    now = document.form1.now.value;
	//alert("std:"+std+"     now:"+now);
	if (std > now){
	    flag = confirm("Import students list?");
	 	if (flag) {
	        eval("document.form1.target = 'mainFrame'");
	        eval("document.form1.action = 'paraw_import.jsp'");
	        eval("document.form1.submit()");
	    }else{ 
	        return false;
	    }//if
	}else{
	   alert("The course is closed, you can only import future data");
	   return false;
	} 
}//function  
*/
</script>
</head>
<body onLoad="showPrevYM('form1','sel_year1','sel_mon1');">
<form name="form1" method="post" class="txttitletop">
  Emp Duty Hour 
  <select name="sel_year1">
    <%
	java.util.Date now1 = new java.util.Date();
	int syear1	=	now1.getYear() + 1900;
	for (int i=2009; i<syear1 + 2; i++) {    
         %><option value="<%=i%>"><%=i%></option><%
	}
    %>
    </select>
    <span class="txtblue">/</span> 
    <select name="sel_mon1">
    <%
	for (int j=1; j<13; j++) {    
	     if (j<10 ){
             %><option value="0<%=j%>">0<%=j%></option><%
		 }else{
             %><option value="<%=j%>"><%=j%></option><%
		}
	}
    %>
  </select>
  &nbsp; &nbsp;
  <select name="sel_base">
    <option value="TPE" slected>TPE</option>
	<option value="KHH">KHH</option>
	<option value="NRT">NRT</option>
	<option value="KIX">KIX</option>
    <option value="BKK">BKK</option>
	<option value="SGN">SGN</option>
	<option value="DEL">DEL</option>
  </select>
 &nbsp;&nbsp;&nbsp;
  <select name="sel_rank">
    <option value="PR" slected>PR</option>
	<option value="FC">FC</option>
	<option value="FF">FF</option>
	<option value="MF">MF</option>
    <option value="MC">MC</option>
	<option value="FY">FY</option>
	<option value="MY">MY</option>
  </select>
 &nbsp;&nbsp;
  員工號 <input name="txt_emp" type="text" size="6" maxlength="6">
  &nbsp;Duty Hour 
  <select name="sel_gtlt">
    <option value="1">大於</option>
    <option value="2">小於</option>
  </select>
  <input name="txt_hr" type="text" value="30"   size="3" maxlength="3">
  小時
  &nbsp;&nbsp;&nbsp;
  <input name="slist"   type="button" value="Submit" onClick="func_slist()">
</form>
</body>
</html>

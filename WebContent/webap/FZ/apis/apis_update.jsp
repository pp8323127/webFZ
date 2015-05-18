<%@ page contentType="text/html; charset=big5" language="java" import="apis.*,java.sql.*,ci.db.*,java.util.*,java.io.*, java.text.*,java.math.*" %>
<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ;
if (session.isNew() || sGetUsr == null) {		//check user session start first
    %> <jsp:forward page="../sendredirect.jsp" /> <%
}//if

String carrier   = request.getParameter("carrier"); 
String fdate     = request.getParameter("fdate");    
String fltyyyy   = request.getParameter("fltyyyy"); 
String fltyy     = fltyyyy.substring(2,4);
String fltmm     = request.getParameter("fltmm"); 
String fltdd     = request.getParameter("fltdd"); 	 
String fltno     = request.getParameter("fltno");
String empno     = request.getParameter("empno"); 
String lname     = request.getParameter("lname"); 
String fname     = request.getParameter("fname"); 
String depart    = request.getParameter("depart"); 
String dest      = request.getParameter("dest"); 
String nation    = request.getParameter("nation"); 
String birthyyyy = request.getParameter("birthyyyy");
String birthyy   = birthyyyy.substring(2,4);
String birthmm   = request.getParameter("birthmm");
String birthdd   = request.getParameter("birthdd");
String birthcity = request.getParameter("birthcity"); 
String birthcountry = request.getParameter("birthcountry"); 
String resicountry  = request.getParameter("resicountry"); 
String passport     = request.getParameter("passport"); 
String doctype      = request.getParameter("doctype"); 
String passcountry  = request.getParameter("passcountry"); 
String passyyyy     = request.getParameter("passyyyy");
String passyy       = passyyyy.substring(2,4);
String passmm       = request.getParameter("passmm");
String passdd       = request.getParameter("passdd");
String gender       = request.getParameter("gender"); 
String gdorder      = request.getParameter("gdorder"); 
String occu         = request.getParameter("occu"); 
String tvlstatus    = request.getParameter("tvlstatus"); 
String dh           = request.getParameter("dh");       if (dh == null) dh = "";
String meal         = request.getParameter("meal");     if (meal == null) meal = "";
String certno       = request.getParameter("certno");   if (certno == null) certno = "";
String certctry     = request.getParameter("certctry"); if (certctry == null) certctry = "";
String certdoctype  = request.getParameter("certdoctype"); if (certdoctype == null) certdoctype = "";
String certyyyy     = request.getParameter("certyyyy"); if (certyyyy == null) certyyyy = "";
String certyy;
if (certyyyy.length() == 4) certyy = certyyyy.substring(2,4);	   
else certyy = "";     
String certmm   = request.getParameter("certmm"); if (certmm == null) certmm = "";
String certdd   = request.getParameter("certdd"); if (certdd == null) certdd = "";
String remark = "";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>APIS: Auto submit</title>
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
</body>
</html>
<%
Calendar cal   = new GregorianCalendar();
String smonth  = null;
String syear   = null;
String sdate   = null;
String shour   = null;
String sminute = null;
String ssecond = null;

int resultCount =0;

Connection conn = null;
Statement stmt  = null;
ResultSet rs = null;
DB2Conn cn = new DB2Conn();
PreparedStatement pstmt = null;
Driver dbDriver = null;
String sql = null;

try{
	cn.setDB2UserCP();	
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);	
	stmt = conn.createStatement();
	
	sql = "UPDATE cal.dftapis " + 
	       "SET carrier = ?," +
		       "lname = ?,"   +
		       "fname = ?,"   +
		       "depart = ?,"  +		  
	    	   "dest = ?,"    +
		       "nation = ?,"  +
	    	   "birth = ?,"   +
		       "birthcity = ?," + 
    		   "birthcountry = ?," + 
	    	   "resicountry = ?,"  + 
	    	   "passport = ?," + 
	    	   "doctype = ?,"  + 
		       "passcountry = ?," +  
		       "passexp = ?," + 
		       "gender = ?,"   +  
		       "gdorder = ?,"  +  
		       "occu = ?," +  
		       "tvlstatus = ?," +  
		       "dh = ?," +  
		       "meal = ?,"   +  
		       "certno = ?," +  
		       "certctry = ?," +  
		       "certdoctype = ?," +  
		       "certexp = ?," + 	
		       "remark = ? "   +
		  "WHERE fltno='" + fltno + "' "  +
		  "AND   fdate='" + fltyy + fltmm + fltdd +"' " +
		  "AND   empno='" + empno +"'";
    /*
    out.println("<BR>sql="+ sql);
	out.println("<BR>carrier="+carrier);
	out.println("<BR>fltno="+fltno); 
	out.println("<BR>fltyy="+fltyy); 
	out.println("<BR>fltmm="+fltmm ); 
	out.println("<BR>fltdd="+fltdd );
	out.println("<BR>empno="+empno);	
	out.println("<BR>lname="+lname);  
	out.println("<BR>fname="+fname);  
	out.println("<BR>depart="+depart);  
	out.println("<BR>dest="+dest);  
	out.println("<BR>nation="+nation);  
	out.println("<BR>birthyy="+birthyy); 
	out.println("<BR>birthmm="+birthmm ); 
	out.println("<BR>birthdd="+birthdd ); 
	out.println("<BR>birthcity="+birthcity);  
	out.println("<BR>birthcountry="+birthcountry);  
	out.println("<BR>resicountry="+resicountry);  
	out.println("<BR>passport="+passport);  
	out.println("<BR>doctype="+doctype);  
	out.println("<BR>passcountry="+passcountry);  
	out.println("<BR>passyy="+passyy); 
	out.println("<BR>passmm="+passmm); 
	out.println("<BR>passdd="+passdd); 
	out.println("<BR>gender="+gender);  
	out.println("<BR>gdorder="+gdorder);  
	out.println("<BR>occu="+occu);  
	out.println("<BR>tvlstatus="+tvlstatus);  
	out.println("<BR>dh="+dh);  
	out.println("<BR>meal="+meal);  
	out.println("<BR>certno="+certno);  
	out.println("<BR>certctry="+certctry);  
	out.println("<BR>certdoctype="+certdoctype);  
	out.println("<BR>certyy="+certyy); 
	out.println("<BR>certmm="+certmm); 
	out.println("<BR>certdd="+certdd); 
	out.println("<BR>remark="+remark);  
	*/

	pstmt = conn.prepareStatement(sql);
	int j = 1;

	pstmt.setString(j, carrier); 
	pstmt.setString(++j, lname);  
	pstmt.setString(++j, fname);  
	pstmt.setString(++j, depart);  
	pstmt.setString(++j, dest);  	
	pstmt.setString(++j, nation);  
	
	pstmt.setString(++j, birthyy + birthmm + birthdd); 
	pstmt.setString(++j, birthcity);  
	pstmt.setString(++j, birthcountry);  
	pstmt.setString(++j, resicountry);  
	pstmt.setString(++j, passport); 
	 
	pstmt.setString(++j, doctype);  
	pstmt.setString(++j, passcountry);  
	pstmt.setString(++j, passyy + passmm + passdd); 
	pstmt.setString(++j, gender);  
	pstmt.setString(++j, gdorder);  
	
	pstmt.setString(++j, occu);  
	pstmt.setString(++j, tvlstatus);  
	pstmt.setString(++j, dh);  
	pstmt.setString(++j, meal);  
	pstmt.setString(++j, certno);  
	
	pstmt.setString(++j, certctry);  	
	pstmt.setString(++j, certdoctype);  
	pstmt.setString(++j, certyy + certmm + certdd); 	
	
    cal.setTime(new java.util.Date()); 
    syear   = "" + cal.get(Calendar.YEAR);       
    smonth  = "" + (cal.get(Calendar.MONTH)+1);   if (Integer.parseInt(smonth)  < 10) smonth  = "0" + smonth;
    sdate   = "" + cal.get(Calendar.DATE);        if (Integer.parseInt(sdate)   < 10) sdate   = "0" + cal.get(Calendar.DATE);
    shour   = "" + cal.get(Calendar.HOUR_OF_DAY); if (Integer.parseInt(shour)   < 10) shour   = "0" + cal.get(Calendar.HOUR_OF_DAY);
    sminute = "" + cal.get(Calendar.MINUTE);      if (Integer.parseInt(sminute) < 10) sminute = "0" + cal.get(Calendar.MINUTE);
    ssecond = "" + cal.get(Calendar.SECOND);      if (Integer.parseInt(ssecond) < 10) ssecond = "0" + cal.get(Calendar.SECOND);
	pstmt.setString(++j, syear+"/"+smonth+"/"+sdate+" "+shour+":"+sminute+":"+ssecond+" (manual) by " + sGetUsr);      	

	resultCount=pstmt.executeUpdate();	   
		
	if(resultCount != 0){	
	   session.setAttribute("seStatus", "Modify "+ empno +" "+ carrier+fltno + " "+fltyyyy+"/"+fltmm+"/"+fltdd+ " data successfully.");		      	   
	   %><script language="javascript">	   
	   document.form1.submit.click();
	   </script><%   
	}//if		   
}catch(Exception e){
	if(resultCount == 0){	
   	   session.setAttribute("seStatus", "<font color='#FF0000'><strong>Modify "+ empno + " data failed.</strong></font>");
	   %><script language="javascript">	   
	   document.form1.submit.click();
	   </script><% 	   	   
	}//if
	out.print(e.toString());
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}	
	try{if(conn != null) conn.close();}catch(SQLException e){}	
}//try
%>



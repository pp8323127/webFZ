<%@ page contentType="text/html; charset=big5" language="java" import="apis.*,java.sql.*,ci.db.*,java.util.*,java.io.*, java.text.*,java.math.*" %>
<jsp:useBean id="apisDelete"   class="fz.ApisDelete" />
<jsp:useBean id="apisInsert"   class="fz.ApisInsert" />
<jsp:useBean id="apisCrewList" class="fz.ApisCrewList" />
<jsp:useBean id="apisPersonal" class="fz.ApisPersonal" />
<%!
String[] apisRow = new String[39];
String crewtype;
String fltyyyy;
String fltyy;
String fltmm;
String fltdd;
String fltno;
String delStatus = "";
Vector crewListRs = new Vector();

String lname;  	   				 
String fname;   			 
String nation;   	   
String birth;   
String passport; 				 
String gender;  	   				 
String gdorder; 
String occu;    				 
String meal;      
String certno;   	   
String certctry; 	   
String passcountry; 	   
String doctype;     				 
String birthcity;    				 
String birthcountry; 	   
String resicountry; 	   
String resiaddr1;    	   
String resiaddr2 ; 				 
String resiaddr3 ;			 
String resiaddr4 ; 				 
String resiaddr5 ;	   	
String tvlstatus ;	 	 
String passexp; 
String certdoctype;
String certexp;
%>
<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ;
if (session.isNew() || sGetUsr == null) {		//check user session start first
    %> <jsp:forward page="../sendredirect.jsp" /> <%
}//if

crewtype = request.getParameter("sel_crewtype");

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

fltno = request.getParameter("fltno").trim();   
if (fltno == null) fltno = "";

//============================
// Delete DB2 existed flights 
//============================

if (fltno == null || fltno.equals("")){ //All flights
   delStatus = apisDelete.delete(fltyy+fltmm+fltdd);
}else{
   if (crewtype.equals("all")){  
      delStatus = apisDelete.delete(fltyy+fltmm+fltdd, fltno); 
   }else{
      delStatus = apisDelete.delete(fltyy+fltmm+fltdd, fltno, crewtype, true);
   }//if
}//if


//===================================================
// Get AirCrews crew list &  prepare records for DB2
//===================================================
crewListRs = apisCrewList.getCrewList(fltyyyy+fltmm+fltdd, fltno);

for (int recno = 0; recno < crewListRs.size(); recno++) {
    //=========================
    // Get AirCrews crew list
	//=========================
    Vector crewListRow = (Vector)crewListRs.get(recno);  
	/*  out.println("<BR>");
	for (int i=0; i<5; i++){	    
		String aaa = (String)crewListRow.get(i);
		out.println("==>"+aaa +"#");
	}//for	*/
	if (crewListRow.get(0) != null) apisRow[1]  = ((String)crewListRow.get(0)).trim(); //carrier    
	if (crewListRow.get(1) != null) apisRow[2]  = ((String)crewListRow.get(1)).trim(); //fltno    
    if (crewListRow.get(2) != null) apisRow[14] = ((String)crewListRow.get(2)).trim(); //dep            
    if (crewListRow.get(3) != null) apisRow[13] = ((String)crewListRow.get(3)).trim(); //arv
	if (crewListRow.get(4) != null) apisRow[4]  = ((String)crewListRow.get(4)).trim(); //empno
    if (crewListRow.get(5) != null) apisRow[18] = ((String)crewListRow.get(5)).trim(); //dh  
	
	//===========================
    // Prepare records for DB2
    //===========================	
	String[] p = null;	       
	p = apisPersonal.getApisPersonal(apisRow[4]);   
	apisRow[0]  = "";    //pk	
    apisRow[3]  = fltyy+fltmm+fltdd; //fdate  	
    apisRow[5]  = p[0];  //lname 
    apisRow[6]  = "";    //mname
    apisRow[7]  = p[1];  //fname
    apisRow[8]  = p[2];  //nation 
    apisRow[9]  = "";    //issue 
    apisRow[10] = p[3];  //birth; 
    apisRow[11] = p[4];  //passport 	
    apisRow[12] = p[5];  //gender	
    apisRow[15] = p[6];  //gdorder 
    apisRow[16] = sGetUsr;
    apisRow[17] = p[7];  //occu	
    apisRow[19] = p[8];  //meal 
    apisRow[20] = p[9];  //certno 
    apisRow[21] = p[10]; //certctry 
    apisRow[22] = "";    //flag1
    apisRow[23] = "";    //flag2
    apisRow[24] = "";    //flag3	
    apisRow[25] = p[11]; //passcountry
    apisRow[26] = p[12]; //doctype
    apisRow[27] = p[13]; //birthcity
    apisRow[28] = p[14]; //birthcountry 
    apisRow[29] = p[15]; //resicountry
    apisRow[30] = p[16]; //resiaddr1 
    apisRow[31] = p[17]; //resiaddr2 
    apisRow[32] = p[18]; //resiaddr3 
    apisRow[33] = p[19]; //resiaddr4 
    apisRow[34] = p[20]; //resiaddr5
    apisRow[35] = p[21]; //tvlstatus 
    apisRow[36] = p[22]; //passexp	
    apisRow[37] = p[23]; //certdoctype
    apisRow[38] = p[24]; //certexp	
	out.println("<hr>");
	for (int i=0; i<39; i++){			    
		out.println("| "+apisRow[i]+" |");
	}//for 	
}//for
out.println("</table>");

/*
=======================================================================================
	   String[] p;	       
	   p = apisPersonal.getApisPersonal(empno);   
	  
	   lname    = p[0];	   				 
       fname    = p[1];				 
       nation   = p[2];	 	   
	   birth    = p[3]; 
	   if (birth.length() == 6){	  	   
	      if (birth.substring(0,1) == "0" || birth.substring(0,1) == "1") birthyyyy = "20"+birth.substring(0,2);
          else birthyyyy = "19"+birth.substring(0,2);
	      birthmm  = birth.substring(2,4);
          birthdd  = birth.substring(4,6);	  
       }else{
	      birthyyyy = "";
		  birthmm = "";
		  birthdd = ""; 
	   }//if
	    	   				 
	   passport = p[4]; 				 
	   gender   = p[5];	   				 
	   gdorder  = p[6];
	   occu     = p[7];				 
	   meal     = p[8]; 
	   certno   = p[9];	   
	   certctry = p[10];	   
	   passcountry  = p[11];	   
	   doctype      = p[12];  				 
	   birthcity    = p[13];				 
	   birthcountry = p[14];	   
	   resicountry  = p[15];	   
	   resiaddr1    = p[16];	   
	   resiaddr2    = p[17]; 				 
	   resiaddr3    = p[18];			 
	   resiaddr4    = p[19]; 				 
	   resiaddr5    = p[20];	   	
	   tvlstatus    = p[21];	 	 
	   passexp      = p[22]; 
	   if (passexp.length() == 6){
	      passyyyy = "20"+passexp.substring(0,2);
          passmm   = passexp.substring(2,4);
          passdd   = passexp.substring(4,6);	   
	   }else{
	      passyyyy = "";
		  passmm   = "";
		  passdd   = "";
	   }//if 
	   certdoctype  = p[23];
	   certexp      = p[24];
	   if (certexp.length() == 6){
   	      certyyyy  = "20"+certexp.substring(0,2);
          certmm    = certexp.substring(2,4);
          certdd    = certexp.substring(4,6);
	   }else{
	      certyyyy = "";
		  certmm   = "";
		  certdd   = "";	   
	   }//if	     
=======================================================================================
*/


/*
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
*/





//==================================
// Insert into DB2 flight by flight
//==================================

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
//function apisSelect(){  	   
//   document.form1.target = "_self";
//   document.form1.action = "apis_select.jsp";
//   document.form1.submit();	
//}//function
</script>
</head>
<body>
<!--
<form name="form1" method="post">
    <input name="sel_year" type="hidden" value=<%//=fltyyyy%> >
    <input name="sel_mon"  type="hidden" value=<%//=fltmm%>   >
    <input name="sel_dd"   type="hidden" value=<%//=fltdd%>   >
    <input name="fltno"    type="hidden" value=<%//=fltno%>   >
    <input class="invisibleButton" name="submit"   type="submit" value="" onClick="apisSelect()"> 
</form>
-->
<%
//status = apisDelete.delete(fdate, fltno, empno);
//status = apisInsert.insert(apisRow);
//session.setAttribute("seStatus", status);
//pageContext.removeAttribute("apisInsert");
%><script language="javascript">	   
//document.form1.submit.click();
</script><%   
%>

</body>
</html>

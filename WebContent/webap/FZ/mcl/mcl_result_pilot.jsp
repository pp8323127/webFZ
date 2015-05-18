<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*, java.util.*, javax.sql.DataSource,javax.naming.InitialContext,java.io.*, java.text.*, ci.db.*, org.apache.poi.hssf.usermodel.*, fz.*" %>
<jsp:useBean id="unicodeStringParser" class="cs40javabean.UnicodeStringParser" />
<jsp:useBean id="mclFormat" class="fz.MclFormat" />
<jsp:useBean id="countryCode" class="fz.CountryCode" />
<html>
<head>
<title>Master Crew List</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>
<%!
String srcEmpno = "empno............AirCrews: crew_v";
String srcLname  = "last name............AirCrews: crew_v.other_surname(single nation);DFTPASS.lname(double nation)";
String srcFname  =  "first name............AirCrews: crew_v.other_first_name(single nation);DFTPASS.fname(double nation)";
String srcMname =  "middle name............(not use)";
String srcSex   =  "sex............AirCrews: crew_v";
String srcBirth = "birthday..............AirCrews: crew_v";
String srcBctry = "birth country...........AirCrews: crew_v";
String srcPassno   = "passport number...............AirCrews: crew_passport_v(single nation);DFTPASS.passno(double nation)";
String srcPassexp = "passport expiry date...........AirCrews: crew_passport_v(single nation);DFTPASS.expdate(double nation)";
String srcNation   = "nationality..........................AirCrews: crew_v.nationality_cd(single nation);	DFTPASS.issuectry(double nation)";
String srcTvlstatus = "travel status.....................CR1(pilot); CR3(supervisor)";
String srcMode = "mode..................................(G,H,I)";
String srcDoctype = "document type...................(P=PPT)";
String srcCertno = "pilot certificate number...........AirCrews: crew_licence_v, licence code='RAT'";
String srcCerteff   = "pilot certificate issue date........AirCrews: crew_licence_v, licence code='RAT'";
String srcCertexp  = "pilot certificate expiry date.........AirCrews: crew_licence_v, licence code='RAT'";
String srcCertctry  = "pilot certificate issue country.......TWN";
String srcResictry  = "resident country.................DFTTSA.resicity";
String srcResiaddr = " resident address.................DFTTSA.resiaddr1~5";
String srcBirthcity  = "birth city............................DFTTSA.birthcity";

ArrayList ArrEmpno = null;
//ArrayList ArrEname = null;
ArrayList ArrLname = null;
ArrayList ArrFname = null;
ArrayList ArrSex      = null;
ArrayList ArrBirth    = null;
ArrayList ArrBctry    = null;
ArrayList ArrPassno   = null;
ArrayList ArrPassexp = null;
ArrayList ArrNation   = null;
ArrayList ArrDoctype   = null;
ArrayList ArrResictry    = null;
ArrayList ArrResiaddr1 = null;
ArrayList ArrResiaddr2 = null;
ArrayList ArrResiaddr3 = null;
ArrayList ArrResiaddr4 = null;
ArrayList ArrResiaddr5 = null;
ArrayList ArrBirthcity   = null;
ArrayList ArrCertno     = null;
ArrayList ArrCertctry   = null;

String ghi = null;
String crewtype = null;
String nat = null;
String empnoString = null;
String path = null;
//String[] EmpnoTokens  = null;
//StringTokenizer tokens = null;
int i;
%>
<%
//String ename;
String surname;
String firstname;
String nation;
String certno;
crewtype = (String)session.getAttribute("crewtype");
path = "/apsource/csap/projfz/webap/FZ/mcl/" + crewtype + "/";
PrintWriter prMcl=new PrintWriter(new BufferedWriter(new FileWriter(path+"manifest.txt")));

ArrEmpno = new ArrayList();
//ArrEname = new ArrayList();
ArrLname = new ArrayList();
ArrFname = new ArrayList();
ArrSex   = new ArrayList();
ArrBirth = new ArrayList();
ArrBctry = new ArrayList();
ArrPassno   = new ArrayList();
ArrPassexp = new ArrayList();
ArrNation   = new ArrayList();
ArrDoctype   = new ArrayList();
ArrResictry    = new ArrayList();
ArrResiaddr1 = new ArrayList();
ArrResiaddr2 = new ArrayList();
ArrResiaddr3 = new ArrayList();
ArrResiaddr4 = new ArrayList();
ArrResiaddr5 = new ArrayList();
ArrBirthcity   = new ArrayList();
ArrCertno      = new ArrayList();
ArrCertctry    = new ArrayList();

empnoString = request.getParameter("txa_empnolist");
ghi = request.getParameter("sel_ghi");
crewtype = request.getParameter("sel_crewtype");
nat = request.getParameter("sel_nat");

if (empnoString.trim().length() < 6) {
   session.setAttribute("errMsg", "The employee number(" + empnoString + ") is not valid."); 
  %> <jsp:forward page="mcl_error.jsp" /> <% 
}//if

//Tokenize empno list
String[] empnoTokens = new String[100];  // Empno array size set to 100
StringTokenizer tokens = new StringTokenizer(empnoString);            
String empnoQuery = "";
for (i = 0; tokens.hasMoreTokens(); i++) {
      empnoTokens[i] = tokens.nextToken();
	  if (i > 0)  empnoQuery += (",");
	  empnoQuery += ("'"+empnoTokens[i]+"'");		
}// for
tokens = null;
String bcolor = "";
Driver dbDriver = null;
Connection conn = null;
Statement stmt = null;
ResultSet myResultSet = null;
ConnDB cn = new ConnDB();
String sql = null;
DataSource ds = null; 
try{
       //DataSource 2009-6-18
	   InitialContext initialcontext = new InitialContext();
	   ds = (DataSource) initialcontext.lookup("CAL.FZDS02");
	   conn = ds.getConnection();
	   conn.setAutoCommit(false);
	   
	   //cn. setAOCIPRODCP();
	   /*
	   cn. setDFUserCP();
       dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
       conn = dbDriver.connect(cn.getConnURL(), null);
	   */
       stmt = conn.createStatement();	  
	   if (nat.equals("S")){ //Single nationality
	       sql = "select a.staff_num empno, " + 
	                     "trim(a.other_surname) surname, " + 
						 "trim(a.other_first_name) firstname, " + 
						 "a.sex sex, " + 
						 "to_char(a.birth_dt,'yymmdd') birth, " + 
						 "a.birth_country bctry, " + 
						 "trim(b.passport_num) passno, " +
						 "to_char(b.exp_dt,'yymmdd') passexp, " +
						 "a.nationality_cd nation, " +
						 "'P'  doctype, " +
						 "d.resicity resictry, "+
                         "trim(d.birthcity) birthcity, "+
				         "trim(d.resiaddr1) resiaddr1, "+
						 "trim(d.resiaddr2) resiaddr2, "+
						 "trim(d.resiaddr3) resiaddr3, "+
						 "trim(d.resiaddr4) resiaddr4 ,"+
						 "trim(d.resiaddr5) resiaddr5, "+
						 "NVL(c.licence_num,'') certno " +
	            "from fzdb.crew_v a, fzdb.crew_passport_v b, fzdb.crew_licence_v c, dfdb.dfttsa d  " +
				"where  trim(a.staff_num)=trim(b.staff_num) and trim(a.staff_num)=trim(c.staff_num(+)) and trim(a.staff_num)=d.empno and "+				          
				           "c.licence_cd(+)='RAT' and "+
				           "trim(a.staff_num) in (" + empnoQuery + ") "+
						   "and trim(a.staff_num) NOT IN "+ 
					       "(select empno from dfdb.dftpass "+  /*SR0437 2011-1-3*/
					       "where doctype='P' and issuectry in ('USA','CAN') "+
						   "and empno in (" + empnoQuery + ") "+
						   "and (expdate is null or expdate > sysdate)"+
						   ")" ;
		}//if		
		if (nat.equals("D")){ //Double nationality
			sql = "select a.staff_num empno, " + 
	                      "trim(b.lname) surname, " + 
		     	          "trim(b.fname) firstname, " + 
			      		   "a.sex sex, " + 
			    		   "to_char(a.birth_dt,'yymmdd') birth, " + 
				    	   "a.birth_country bctry, " + 
					       "trim(b.passno) passno, " +
		    			   "to_char(b.expdate,'yymmdd') passexp, " +
			    		   "b.issuectry nation, " +
				    	   "b.doctype  doctype, " +  
				     	   "d.resicity resictry, "+
                           "trim(d.birthcity) birthcity, "+
				           "trim(d.resiaddr1) resiaddr1, "+
					       "trim(d.resiaddr2) resiaddr2, "+
			               "trim(d.resiaddr3) resiaddr3, "+
					       "trim(d.resiaddr4) resiaddr4 ,"+
					       "trim(d.resiaddr5) resiaddr5, "+
					       "NVL(c.licence_num,'') certno " +
	                 "from fzdb.crew_v a, dfdb.dftpass b, fzdb.crew_licence_v c, dfdb.dfttsa d  " +
				     "where  trim(a.staff_num)=trim(b.empno) and trim(a.staff_num)=trim(c.staff_num(+)) and trim(a.staff_num)=d.empno and "+				          
				                  "c.licence_cd(+)='RAT' and "+
				                   "trim(a.staff_num) in (" + empnoQuery + ")";
		}//if

       myResultSet = stmt.executeQuery(sql); 
	   if(myResultSet != null){
	       while (myResultSet.next()){
	           ArrEmpno.add(myResultSet.getString("empno"));
			   
			   surname = myResultSet.getString("surname"); 
			   surname = surname.replace('-',' ');				   
			   ArrLname.add(surname);			   
			   
			   firstname = myResultSet.getString("firstname"); 
			   firstname = firstname.replace('-',' ');
			   ArrFname.add(firstname);
			   		   
			   ArrSex.add(myResultSet.getString("sex"));
			   ArrBirth.add(myResultSet.getString("birth"));
               ArrBctry.add(myResultSet.getString("bctry"));
			   ArrPassno.add(myResultSet.getString("passno"));
		       ArrPassexp.add(myResultSet.getString("passexp"));
			   
			   nation = myResultSet.getString("nation"); if (nation == null) {nation = "";}
			   
			   if (nation.length() == 2){
			      nation = countryCode.getCode(nation);
			   }//if
			   ArrNation.add(nation);
			   
			   ArrDoctype.add(myResultSet.getString("doctype"));
			   ArrResictry.add(myResultSet.getString("resictry"));
               ArrResiaddr1.add(myResultSet.getString("resiaddr1"));
               ArrResiaddr2.add(myResultSet.getString("resiaddr2"));
               ArrResiaddr3.add(myResultSet.getString("resiaddr3"));
               ArrResiaddr4.add(myResultSet.getString("resiaddr4"));
               ArrResiaddr5.add(myResultSet.getString("resiaddr5"));
               ArrBirthcity.add(myResultSet.getString("birthcity"));
			   
			   certno = myResultSet.getString("certno"); if (certno == null) {certno = "";}
			   ArrCertno.add(certno); 
			   
			   ArrCertctry.add("TWN");	
	       }//while
	    }//if
}catch (SQLException e){
      out.println("SQL Exception Error : " + sql+ "\r\n" + e.toString());
}catch (Exception e){
      out.println("Exception Error : " + sql+ "\r\n" + e.toString());
}finally{
  	try{
	     if(myResultSet != null) myResultSet.close();
	}catch(SQLException e){out.println("Erron in myResultSet.close() <BR> " + e.toString());}
	
	try{
	     if(stmt != null) stmt.close();   
	}catch(SQLException e){out.println("Erron in  stmt.close() <BR>  " + e.toString());}
		
	try{
	      if(conn != null){
		     %> <p align="center" class="HeaderNav">Right click mouse to download manifest.txt. <% 
		     conn.close(); 			 
			 %> &nbsp;Please read MCL legend to know the data meaning.</p> <% 					 
	       }//if
	}catch(SQLException e){ out.println("Error in conn.close()" + e.toString());}
}//try
%>
<body>
<table width="100%"  border="0" align="center"><tr><td>
<div align="right"><a href="javascript:window.print()"><img src="../images/print.gif" width="17" height="15" border="0" alt="Printing"></a>  </div>
</td></tr> </table> 
<%  
if (ArrEmpno.size() == 0){
out.println("Imcomplete MCL data! Please check the following columns:<hr>");
out.println(srcEmpno + "<br>");
out.println(srcLname + "<br>");
out.println(srcFname + "<br>");      
out.println(srcSex + "<br>");
out.println(srcBirth + "<br>");
out.println(srcBctry + "<br>");
out.println(srcPassno + "<br>");
out.println(srcPassexp + "<br>");
out.println(srcNation + "<br>");
out.println(srcCertno + "<br>");
out.println(srcCertctry + "<br>");
out.println(srcResictry + "<br>");
out.println(srcResiaddr + "<br>");
out.println(srcBirthcity + "<br>");

}else{   %>   
       <p align="center"  class="HeaderNav">Master Crew List - <%= (ghi +" ("+ crewtype + ")") %> - 
	   <% if (nat.equals("S")) out.print("Single nationality"); %>
	   <% if (nat.equals("D")) out.print("Double nationality"); %>	   
	   <br>
  *** 持有美/加有效護照者不處理 ***
<table width="100%"  border="1" align="center"> 
       <tr>
	   <td  class="FontSizeEngB" bgcolor="#CCCCCC">Empno</td>
	   <td  class="FontSizeEngB" bgcolor="#CCCCCC">Last Name</td>
       <td  class="FontSizeEngB" bgcolor="#CCCCCC">First Name</td>
	   <td  class="FontSizeEngB" bgcolor="#CCCCCC">Sex</td>
	   <td  class="FontSizeEngB" bgcolor="#CCCCCC">Birthday</td>
	   <td  class="FontSizeEngB" bgcolor="#CCCCCC">Birth<BR>Country</td>	 
       <td  class="FontSizeEngB" bgcolor="#CCCCCC">Passport<BR>Number</td>
       <td  class="FontSizeEngB" bgcolor="#CCCCCC">Passport<BR>Expiry Date</td>
	   <td  class="FontSizeEngB" bgcolor="#CCCCCC">Nation<BR>(Passport<br>country)</td>
	   <td  class="FontSizeEngB" bgcolor="#CCCCCC">Doc<br>type</td>
	   <td  class="FontSizeEngB" bgcolor="#CCCCCC">Resident<BR>country</td>
	   <td  class="FontSizeEngB" bgcolor="#CCCCCC">Resident<BR>address1<BR>(Number and street)</td>
       <td  class="FontSizeEngB" bgcolor="#CCCCCC">Resident<BR>address2<BR>(City)</td>
	  <td  class="FontSizeEngB" bgcolor="#CCCCCC">Resident<BR>address3<BR>(Sub-entity)</td>
      <td  class="FontSizeEngB" bgcolor="#CCCCCC">Resident<BR>address4<BR>(Postal code)</td> 
      <td  class="FontSizeEngB" bgcolor="#CCCCCC">Resident<BR>address5<BR>(Country)</td>
      <td  class="FontSizeEngB" bgcolor="#CCCCCC">Birth<BR>City</td>
	  <td  class="FontSizeEngB" bgcolor="#CCCCCC">Pilot<BR>Certificate<BR>Number</td>
      <td  class="FontSizeEngB" bgcolor="#CCCCCC">Pilot<BR>Certificate<BR>Country</td>
      </tr>
     <% 
	  for(i = 0; i < ArrEmpno.size(); i++){ 
		          if((i % 2) == 0)  bcolor = "";
		          else bcolor = "#FFFFCC";
                  %>	
	              <tr bgcolor="<%=bcolor%>"> 
                  <td class="FontSizeEngB"><%=ArrEmpno.get(i)%></td>
				  <td class="FontSizeEngB"><%=ArrLname.get(i)%></td>
		          <td class="FontSizeEngB"><%=ArrFname.get(i)%></td>
			      <td class="FontSizeEngB"><%=ArrSex.get(i)%></td>
				  <td class="FontSizeEngB"><%=ArrBirth.get(i)%></td>
				  <td class="FontSizeEngB"><%=ArrBctry.get(i)%></td>
				  <td class="FontSizeEngB"><%=ArrPassno.get(i)%></td>
	              <td class="FontSizeEngB"><%=ArrPassexp.get(i)%></td>
				  <td class="FontSizeEngB"><%=ArrNation.get(i)%></td>
				  <td class="FontSizeEngB"><%=ArrDoctype.get(i)%></td>				  
				  <td class="FontSizeEngB"><%=ArrResictry.get(i)%></td>
				  <td class="FontSizeEngB"><%=ArrResiaddr1.get(i)%></td>
				  <td class="FontSizeEngB"><%=ArrResiaddr2.get(i)%></td>
				  <td class="FontSizeEngB"><%=ArrResiaddr3.get(i)%></td>
				  <td class="FontSizeEngB"><%=ArrResiaddr4.get(i)%></td>
				  <td class="FontSizeEngB"><%=ArrResiaddr5.get(i)%></td>
				  <td class="FontSizeEngB"><%=ArrBirthcity.get(i)%></td>				  
				  <td class="FontSizeEngB"><%=ArrCertno.get(i)%></td>
				  <td class="FontSizeEngB"><%=ArrCertctry.get(i)%></td>
                 </tr>	   
                 <% 
	} //for
	%> 
    </table>
   
    <%    			   
    StringBuffer mclText = new  StringBuffer(); 		 
	
    mclText =  mclFormat.getMclText(crewtype,
														   ghi,
                                                          ArrEmpno, 
								  				          ArrLname, 
						          						  ArrFname, 
								  				          ArrSex, 
						          						  ArrBirth,
        				                                  ArrBctry, 
								  				          ArrPassno, 
					          							  ArrPassexp, 
						          						  ArrNation, 
														  ArrDoctype, 
						          						  ArrResictry, 
						          						  ArrResiaddr1, 
						          						  ArrResiaddr2, 
					          							  ArrResiaddr3, 
				          								  ArrResiaddr4, 
						          						  ArrResiaddr5, 
							          					  ArrBirthcity, 
						          						  ArrCertno, 
					          							  ArrCertctry);  														  
	try{
	        prMcl.print(mclText);
	}catch(Exception e){out.println("Error in prMcl print: "+e.toString()+ "<BR>");}	
}//if 

//close file
try{
      prMcl.close();
}catch(Exception e){ out.println("prMcl close error:" + e.toString() + "<BR>");}

//session close
session.invalidate();
%>
<!--<p align="center"> <a href= '<% /*= (crewtype+"/manifest.xls") */%> '><strong>Excel Download</strong></a> </p> -->
<p align="center"><a href= '<%=  crewtype+"/manifest.txt" %>'><strong><font size="6" color="#0000FF">manifest.txt</font></strong></a></p>
<p align="center" class="HeaderNav">MCL Legend<br>
<table align="center" border="0"><tr><td><img border="1" src='<%= "mcl_legend_"+crewtype+".gif" %>' ></td></tr></table></p>
</body>
</html>

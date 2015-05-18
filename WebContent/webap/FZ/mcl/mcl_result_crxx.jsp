<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*, javax.sql.DataSource,javax.naming.InitialContext,java.util.*, java.io.*, java.text.*, ci.db.*, org.apache.poi.hssf.usermodel.*, fz.*" %>
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
String[] empnoTokens = new String[250];  // Empno array size set to 250
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
	   ds = (DataSource) initialcontext.lookup("CAL.DFDS01");
	   conn = ds.getConnection();
	   conn.setAutoCommit(false);	   
	   	   
	   //cn. setAOCIPRODCP();
	   /*
	   cn. setDFUserCP();
       dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
       conn = dbDriver.connect(cn.getConnURL(), null);
	   */
       stmt = conn.createStatement();	  
	   sql = "select empno empno, " +  
                    "trim(lname) surname, " +
                    "trim(fname) firstname, " +
		            "gender sex, " +
		            "to_char(birthdate,'yymmdd') birth,  " + 
		            "birthcountry bctry,   " +
		            "trim(passno) passno,  " +
		            "to_char(expdate,'yymmdd') passexp,  " +
		            "nation nation,  " +
		            "doctype doctype,  " +
		            "resicountry resictry, " +
                    "trim(birthcity) birthcity, " +
	                "'' resiaddr1, " +
	                "'' resiaddr2, " +
	                "'' resiaddr3, " +
	                "'' resiaddr4 , " +
	                "'' resiaddr5, " +
	                "'' certno  " +
             "from dftcrxx  " +
             "where doctype='P' and "+
		     "trim(empno) in (" + empnoQuery + ")";

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
			   
			   ArrCertno.add(""); 			   
			   ArrCertctry.add("");	
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
}else{   %>   
       <p align="center"  class="HeaderNav">Master Crew List - <%= (ghi +" ("+ crewtype + ")") %> - 
	   <% if (nat.equals("S")) out.print("Single nationality"); %>
	   <% if (nat.equals("D")) out.print("Double nationality"); %>	   
	   <br>
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

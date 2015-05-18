<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,javax.sql.DataSource,javax.naming.InitialContext, java.util.*, java.io.*, java.text.*, ci.db.*, org.apache.poi.hssf.usermodel.*, fz.*" %>
<jsp:useBean id="unicodeStringParser" class="cs40javabean.UnicodeStringParser" />
<jsp:useBean id="enameParser" class="fz.EnameParser" />
<jsp:useBean id="mclFormat" class="fz.MclFormat" />
<jsp:useBean id="egNationCode" class="fz.EgNationCode" />
<html>
<head>
<title>Master Crew List</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>
<%!
/* MCL columns
      empno.................................EG
      last name.............................EG
      first name............................EG
      middle name.......................(not use)
      sex......................................EG
      birthday..............................EG
	  birth country.......................EG
      passport number.................EG
      passport expiry date...........EG
      nationality..........................EG
	  doctype..............................EG
      travel status........................(cabin=CR2)
      mode..................................(G,H,I)
      document type...................(P=PPT)
      resident country.................DFTTSA
	  resident address.................DFTTSA
	  birth city............................DFTTSA
*/
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
String ename;
String[] subEname;
String nation;
String nationNum;
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
	   
       /*
	   //cn.setORP3EGUserCP();
	   cn. setDFUserCP();
       dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
       conn = dbDriver.connect(cn.getConnURL(), null);
       */
	   stmt = conn.createStatement();	  
	   if (nat.equals("S")){ //Single nationality
	        sql = "select trim(a.empn) empno, " + 
	                     "trim(a.ename) ename, " + 
						 "a.sex sex, " + 
						 "to_char(a.birth,'yymmdd') birth, " + 
						 "a.bplace_en bctry, " + 
						 "trim(a.passport) passno, " +
						 "to_char(a.passdate,'yymmdd') passexp, " +
						 "a.nation nation, " +
						 "'P' doctype, " +
						 "b.resicity resictry, "+
                         "trim(b.birthcity) birthcity, "+
				         "trim(b.resiaddr1) resiaddr1, "+
						 "trim(b.resiaddr2) resiaddr2, "+
						 "trim(b.resiaddr3) resiaddr3, "+
						 "trim(b.resiaddr4) resiaddr4 ,"+
						 "trim(b.resiaddr5) resiaddr5 "+
	            "from egdb.egtcbas a, dfdb.dfttsa b " +
				"where trim(a.empn)=b.empno and "+
				       "trim(a.empn) in (" + empnoQuery + ") and " +
				       "trim(a.empn) NOT IN "+
					       "(select empno from egdb.egtpass "+ /*SR0437 2011-1-3*/
					       "where doc_tp='P' and issue_nation in ('USA','CAN') "+
						   "and empno in (" + empnoQuery + ") "+
						   "and (exp_date is null or exp_date > sysdate)"+
						   ")";
		}//if
		if (nat.equals("D")){ //Double nationality
	        sql = "select trim(a.empn) empno, " + 
	                     "trim(c.ename) ename, " + 
						 "a.sex sex, " + 
						 "to_char(a.birth,'yymmdd') birth, " + 
						 "a.bplace_en bctry, " + 
						 "trim(c.pass_no) passno, " +
						 "to_char(c.exp_date,'yymmdd') passexp, " +
						 "c.issue_nation nation, " +
						 "c.doc_tp doctype, " +
						 "b.resicity resictry, "+
                         "trim(b.birthcity) birthcity, "+
				         "trim(b.resiaddr1) resiaddr1, "+
						 "trim(b.resiaddr2) resiaddr2, "+
						 "trim(b.resiaddr3) resiaddr3, "+
						 "trim(b.resiaddr4) resiaddr4 ,"+
						 "trim(b.resiaddr5) resiaddr5 "+
	            "from egdb.egtcbas a, dfdb.dfttsa b, egdb.egtpass c " +
				"where trim(a.empn)=b.empno and "+
				          "trim(a.empn)=c.empno and "+
				          "trim(a.empn) in (" + empnoQuery + ")";
		}//if		
		
       myResultSet = stmt.executeQuery(sql); 
	   if(myResultSet != null){
	       while (myResultSet.next()){
	           ArrEmpno.add(myResultSet.getString("empno"));
			   			   
			   ename = myResultSet.getString("ename"); 
			   subEname = enameParser.parseEname(ename);
			   
			   ArrLname.add(subEname[0]);
			   ArrFname.add(subEname[1]);
			   //ArrEname.add(myResultSet.getString("ename"));			   
			   
			   ArrSex.add(myResultSet.getString("sex"));
			   ArrBirth.add(myResultSet.getString("birth"));
               ArrBctry.add(myResultSet.getString("bctry"));
			   ArrPassno.add(myResultSet.getString("passno"));
		       ArrPassexp.add(myResultSet.getString("passexp"));
			   
			    if (nat.equals("S")){ //Single nationality
				    nationNum = myResultSet.getString("nation");
					nation = egNationCode.getCode(nationNum);
					ArrNation.add(nation);
				}//if
				if (nat.equals("D")){ //Double nationality
			       ArrNation.add(myResultSet.getString("nation"));
    		   }//if
    
			   
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
        out.println("Imcomplete MCL data.");
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
	   <td  class="FontSizeEngB" bgcolor="#CCCCCC">Doc<BR>Type</td>
	   <td  class="FontSizeEngB" bgcolor="#CCCCCC">Resident<BR>country</td>
	   <td  class="FontSizeEngB" bgcolor="#CCCCCC">Resident<BR>address1<BR>(Number and street)</td>
       <td  class="FontSizeEngB" bgcolor="#CCCCCC">Resident<BR>address2<BR>(City)</td>
	  <td  class="FontSizeEngB" bgcolor="#CCCCCC">Resident<BR>address3<BR>(Sub-entity)</td>
      <td  class="FontSizeEngB" bgcolor="#CCCCCC">Resident<BR>address4<BR>(Postal code)</td> 
      <td  class="FontSizeEngB" bgcolor="#CCCCCC">Resident<BR>address5<BR>(Country)</td>
      <td  class="FontSizeEngB" bgcolor="#CCCCCC">Birth<BR>City</td>	  
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

				  <%/*				  
				  String cname = (String)ArrCname.get(i); if (cname == null) {cname = "";}
                  String tempCname = unicodeStringParser.removeExtraEscape(cname);
                  String big5Cname = new String(tempCname.getBytes(), "Big5");
				  cname = big5Cname;                  	
				  */%>				  	 				  	
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

<% /* Excel Download backup
short rownum;
try{ 
   FileOutputStream outx = new FileOutputStream("//apsource//csap//projfz//webap//FZ//pr_interface//"+ (String)session.getAttribute("cs55.usr")+ "simchk.xls"); // create file
   HSSFWorkbook wb = new HSSFWorkbook(); // create workbook
   HSSFSheet s = wb.createSheet(); // create sheet
   HSSFRow r = null; // declare row        
   HSSFCell c = null; // declare cell		
   
    // create 3 cell styles
    HSSFCellStyle cs1 = wb.createCellStyle();		
    HSSFCellStyle cs2 = wb.createCellStyle();
    HSSFCellStyle cs3 = wb.createCellStyle();
    HSSFDataFormat df = wb.createDataFormat();
		
    // create 2 font objects
    HSSFFont f1 = wb.createFont();
    HSSFFont f2 = wb.createFont();

    f1.setFontHeightInPoints((short)12); //set font1 to 12 points; deafult font is Ariel
    f1.setColor((short)0xc); //set font1 to blue
    f1.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD); //set font1 bold

    f2.setFontHeightInPoints((short)10); //set font2 to 10 points; deafult font is Ariel
    f2.setColor((short)HSSFFont.COLOR_RED); //set font2 to red
    f2.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD); //set font2 bold

    f2.setStrikeout(true); //set cancel line

    cs1.setFont(f1); //set cell style
    cs1.setDataFormat(df.getFormat("#, ##0.0")); //set cell format
		
    cs2.setBorderBottom(cs2.BORDER_THIN); //set thin border
    cs2.setFillPattern((short)HSSFCellStyle.SOLID_FOREGROUND); //fill w fg fill color
    cs2.setDataFormat(HSSFDataFormat.getBuiltinFormat("text")); //set cell format to text see HSSFDataFormat for a full list
    cs2.setFont(f2); //set font

    //wb.setSheetName(0, "\u7b2c1\u5f35Excel\u5de5\u4f5c\u9801", HSSFWorkbook.ENCODING_UTF_16); //set sheet name
    
	//=== Set Excel header === 
	r = s.createRow(0); //create header row
	for (short headernum = (short) 0; headernum < 12; headernum++){
           c = r.createCell(headernum); //create header cell			   
		   if (headernum == 0){			   
		       c.setCellValue("Start (TPE time)"); 
		   }else if (headernum == 1){			      
		       c.setCellValue("End (TPE time)");				 
		   }else if (headernum == 2){
		       c.setCellValue("Empno");
		   }else if (headernum == 3){
              c.setCellValue("Name");				
		   }else if (headernum == 4){			  
			   c.setCellValue("Acting rank");				  
			}else if (headernum == 5){			
			     c.setCellValue("Instruct empno");
			}else if (headernum == 6){
			   c.setCellValue("Instruct name");				  
			 }else if (headernum == 7){			
			     c.setCellValue("Trg function");
			 }else if (headernum == 8){			
			     c.setCellValue("Trg code desc");
			 }else if (headernum == 9){			
			      c.setCellValue("SIM venue type");
			 }else if (headernum == 10){			
			      c.setCellValue("Duty code");
			 }else if (headernum == 11){			
			      c.setCellValue("Trg code");				  				  				  				  				  				  
			 }//if
			 s.setColumnWidth(headernum, (short)((50 * 6) / ((double)1/20))); //set column bigger wider
	}//for
	
	//=== Set Excel content === 
	for(rownum = (short) 0; rownum < ArrStaTpe.size(); rownum++){ 
        r = s.createRow(rownum+1); //create content row        		
        for (short cellnum = (short) 0; cellnum < 12; cellnum++){
               c = r.createCell(cellnum); //create content cell			   
			   if (cellnum == 0){			   
			       c.setCellValue(ArrStaTpe.get(rownum).toString()); 
			  }else if (cellnum == 1){			      
			       c.setCellValue(ArrEndTpe.get(rownum).toString());				 
			  }else if (cellnum == 2){
			      c.setCellValue(ArrEmpno.get(rownum).toString());
			  }else if (cellnum == 3){
			   	  c.setEncoding(HSSFCell.ENCODING_UTF_16);
				  String CnameInArray = ArrCname.get(rownum).toString();
				  String CnameToExcel = unicodeStringParser.removeExtraEscape(CnameInArray);
                  c.setCellValue(CnameToExcel);				
			  }else if (cellnum == 4){			  
			      c.setCellValue(ArrActRank.get(rownum).toString());				  
			  }else if (cellnum == 5){			
			      c.setCellValue(ArrInstEmpno.get(rownum).toString());
			  }else if (cellnum == 6){
			     String InstNameInArray = ArrInstName.get(rownum).toString();
				 String InstNameToExcel = unicodeStringParser.removeExtraEscape(InstNameInArray);
			      c.setCellValue(InstNameToExcel);	
			  }else if (cellnum == 7){			
			      c.setCellValue(ArrTrgFunc.get(rownum).toString());
			  }else if (cellnum == 8){			
			      c.setCellValue(ArrTrgDesc.get(rownum).toString());
			  }else if (cellnum == 9){			
			      c.setCellValue(ArrVenueName.get(rownum).toString());
			  }else if (cellnum == 10){			
			      c.setCellValue(ArrDutyCd.get(rownum).toString());
			  }else if (cellnum == 11){			
			      c.setCellValue(ArrTrgCd.get(rownum).toString());				  				  				  				  				  				  
			  }//if
			  s.setColumnWidth(cellnum, (short)((50 * 6) / ((double)1/20))); //set column bigger wider
           }//for	
    }//for	
    wb.write(outx); //write to file
    outx.close(); //colse file
}catch(IOException e){
   out.println("IOException: " + e.toString());
}catch(Exception e){
   out.println("Exception: " + e.toString());  
}//try 
*/
%>

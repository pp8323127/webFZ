<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*, java.util.*, java.io.*, ci.db.*, fz.*, org.apache.poi.hssf.usermodel.*"  %>
<jsp:useBean id="countryCode"  class="fz.CountryCode"  />
<jsp:useBean id="egNationCode" class="fz.EgNationCode" />
<%!
ArrayList ArrFullname  = null;
ArrayList ArrOccu      = null;
ArrayList ArrNation    = null;
ArrayList ArrBirthdate = null;
ArrayList ArrAddress   = null;
ArrayList ArrEmpno     = null;
ArrayList ArrPassno    = null;
ArrayList ArrIndt      = null;
int i;
String fullname = null;
String nation   = null;
%>
<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //Check if logined
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
if (session.isNew() || sGetUsr == null) {		//check user session start first
    %> <jsp:forward page="../sendredirect.jsp" /> <%
}//if

if (sGetUsr.equals("635084")|| sGetUsr.equals("632482")){
   // TPEUA, TPEUC users
}else if (sGetUsr.equals("634319") || sGetUsr.equals("640073") || sGetUsr.equals("640790")) {
   // TPECS 
}else{	
   session.setAttribute("errMsg", "You are not authorized."); 
  %> <jsp:forward page="india_error.jsp" /> <% 
}//if

ArrFullname  = new ArrayList();
ArrOccu      = new ArrayList();
ArrNation    = new ArrayList();
ArrBirthdate = new ArrayList();
ArrAddress   = new ArrayList();
ArrEmpno     = new ArrayList();
ArrPassno    = new ArrayList();
ArrIndt      = new ArrayList();

Connection conn = null;
Statement stmt  = null;
ResultSet rs = null;
ConnDB cn = new ConnDB();
Driver dbDriver = null;
String sql = null;
String errMsg = "";

try {	
	cn.setDFUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);	
	stmt = conn.createStatement();	 
	
	//Pilot	
	sql = "SELECT a.other_surname||' '||a.other_first_name fullname, " +
		       "c.rank_cd occu, " +
			   "a.nationality_cd nation, " +          
		       "to_char(a.birth_dt,'yyyy/mm/dd') birthdate, " +  		                        
		       "e.resiaddr1||' '||e.resiaddr2||' '||e.resiaddr3||' '||e.resiaddr4||' '||e.resiaddr5 address, " +  
	           "a.staff_num empno, " +           
	           "d.passport_num passno, " + 
	  	       "to_char(b.indt,'yyyy/mm/dd') indt " +  
          "FROM dfdb.crew_v a, " +
		       "hrdb.hrvegemploy b, " +
			   "dfdb.crew_rank_v c, " + 
               "dfdb.crew_passport_v d, " +
			   "dfttsa e " + 
          "WHERE b.exstflg='Y' " + 
		       "AND a.staff_num=b.employid " +  
               "AND a.staff_num=c.staff_num " +
               "AND (sysdate >= c.eff_dt AND (c.exp_dt >= sysdate OR c.exp_dt is null)) " + 
			   "AND c.rank_cd in ('CA', 'RP', 'FO', 'FE', 'FDT') " +
               "AND a.staff_num=d.staff_Num " +
               "AND (d.exp_dt >= sysdate or d.exp_dt is null) " + 
               "AND a.staff_num=e.empno " +               			   
	 "UNION " +  
	 "SELECT a.ename fullname, " +
	           "c.rank_cd occu, " +
		       "a.nation nation, " +          
		       "to_char(a.birth,'yyyy/mm/dd') birthdate, " +  		                        
		       "d.resiaddr1||' '||d.resiaddr2||' '||d.resiaddr3||' '||d.resiaddr4||' '||d.resiaddr5 address, " +  
	           "trim(a.empn) empno, " +           
	           "a.passport passno, " + 
	  	       "to_char(b.indt,'yyyy/mm/dd') indt " +  
          "FROM egdb.egtcbas a, " +
		       "hrdb.hrvegemploy b, " +
			   "dfdb.crew_rank_v c, " +                
			   "dfttsa d " + 
          "WHERE a.status in ('1') " + 
		       "AND a.station in ('TPE','SIN') " +
		       "AND trim(a.empn)=b.employid " +  
               "AND trim(a.empn)=c.staff_num " +
			   "AND (sysdate >= c.eff_dt AND (c.exp_dt >= sysdate OR c.exp_dt is null)) " +  
			   "AND c.rank_cd in ('PR', 'MF', 'MC', 'MY', 'FF','FC','FY') " +                  
               "AND trim(a.empn)=d.empno(+) " +  			   			                			   
          "ORDER BY occu, empno"; 
	
	rs = stmt.executeQuery(sql); 
	
	if(rs != null){
	   while (rs.next()){
	        fullname = rs.getString("fullname").trim().replace('-',' ').replace('/',' ');
	        ArrFullname.add(fullname);
						
	        ArrOccu.add(rs.getString("occu"));

			nation = rs.getString("nation").trim();			
			if (nation.length() == 2) nation = countryCode.getCode(nation);  // 2 code country			
	        if (nation.length() == 1) nation = egNationCode.getCode(nation); // EG numbered country			
	        ArrNation.add(nation);
			
			ArrBirthdate.add(rs.getString("birthdate"));			
	        ArrAddress.add(rs.getString("address"));
	        ArrEmpno.add(rs.getString("empno"));
	        ArrPassno.add(rs.getString("passno"));
	        ArrIndt.add(rs.getString("indt"));		 
	   }//while
	}//if
}catch (SQLException e) {
  out.println("SQLException on selecting data: " + e.toString());
}catch (Exception e) {
  out.println("Exception: " + e.toString());
}finally {
  if (conn != null ) {
     try { conn.close();
     }catch (SQLException e) {out.println("SQLException on closing connection: " + e.toString());}
  }//if
}//try
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>India BCAS Data</title>
<link href="../style2.css" rel="stylesheet" type="text/css">
</head>
<body>
<p class="FontSizeEngB">
Pilot: All<br>
Cabin: TPE, SIN base crew only<br><br>
Order: occupation, employee number
</p>
<table width="100%"  border="1" align="center"> 
<tr>
<td class="FontSizeEngB" bgcolor="#CCCCCC">S.No                    </td>
<td class="FontSizeEngB" bgcolor="#CCCCCC">Name                    </td>
<td class="FontSizeEngB" bgcolor="#CCCCCC">Designation             </td>
<td class="FontSizeEngB" bgcolor="#CCCCCC">Nationality             </td>
<td class="FontSizeEngB" bgcolor="#CCCCCC">D.O.Birth               </td>
<td class="FontSizeEngB" bgcolor="#CCCCCC">Address                 </td>
<td class="FontSizeEngB" bgcolor="#CCCCCC">ID No.                  </td>
<td class="FontSizeEngB" bgcolor="#CCCCCC">Passport No.            </td>
<td class="FontSizeEngB" bgcolor="#CCCCCC">Date of Joining Airlines</td>
<td class="FontSizeEngB" bgcolor="#CCCCCC">Any addl. Information   </td>
<% 
String path = "/apsource/csap/projfz/webap/FZ/mcl/bcas/";
PrintWriter prBcas    = new PrintWriter(new BufferedWriter(new FileWriter(path+"bcas.txt")));
StringBuffer bcasText = new StringBuffer(); 

String bcolor = "";
for (i = 0; i < ArrEmpno.size(); i++){ 
    if((i % 2) == 0) bcolor = "";
    else bcolor = "#ECEAD8";
    %>	
    <tr bgcolor="<%=bcolor%>"> 
    <td class="FontSizeEngB"><%= (i+1) %>            </td>
    <td class="FontSizeEngB"><%=ArrFullname.get(i)%> </td>
    <td class="FontSizeEngB"><%=ArrOccu.get(i)%>     </td>
    <td class="FontSizeEngB"><%=ArrNation.get(i)%>   </td>
    <td class="FontSizeEngB"><%=ArrBirthdate.get(i)%></td>
    <td class="FontSizeEngB"><%=ArrAddress.get(i)%>  </td>
    <td class="FontSizeEngB"><%=ArrEmpno.get(i)%>    </td>
    <td class="FontSizeEngB"><%=ArrPassno.get(i)%>   </td>
    <td class="FontSizeEngB"><%=ArrIndt.get(i)%>     </td>
    <td class="FontSizeEngB">                        </td>
    </tr>
    <%
	bcasText.append((i+1)               + "\t"); 
	bcasText.append(ArrFullname.get(i)  + "\t"); 
	bcasText.append(ArrOccu.get(i)      + "\t"); 
	bcasText.append(ArrNation.get(i)    + "\t"); 
	bcasText.append(ArrBirthdate.get(i) + "\t"); 
	bcasText.append(ArrAddress.get(i)   + "\t"); 
	bcasText.append(ArrEmpno.get(i)     + "\t"); 
	bcasText.append(ArrPassno.get(i)    + "\t"); 	
	bcasText.append(ArrIndt.get(i)      + "\t"); 
	bcasText.append(""                  +"\r\n"); 	
} //for

try{
    prBcas.print(bcasText);
}catch(Exception e){out.println("Error in prBcas print: "+e.toString()+ "<BR>");}

try{
    prBcas.close();
}catch(Exception e){ out.println("prBcas close error:" + e.toString() + "<BR>");}
%> 
</table>

<%
short rownum;
try{ 
    FileOutputStream outx = new FileOutputStream("//apsource//csap//projfz//webap//FZ//mcl//bcas//bcas.xls"); // create file
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
	for (short headernum = (short) 0; headernum < 14; headernum++){
           c = r.createCell(headernum); //create header cell			   
		   if (headernum == 0){
		       c.setCellValue("S.No.");			   
		   }else if (headernum == 1){
		       c.setCellValue("Name");			      				 
		   }else if (headernum == 2){
		       c.setCellValue("Designation");
		   }else if (headernum == 3){
              c.setCellValue("Nationality");				
		   }else if (headernum == 4){			  
			   c.setCellValue("D.O.Birth");				  
		   }else if (headernum == 5){			
			     c.setCellValue("Address");
		   }else if (headernum == 6){
			   c.setCellValue("ID No.");  
		   }else if (headernum == 7){			
			     c.setCellValue("Passport No.");
           }else if (headernum == 8){			
			     c.setCellValue("Date of Joining Airlines");
	       }else if (headernum == 9){			
			     c.setCellValue("Any addl. Information");			  				  				  				  
	       }//if
			 s.setColumnWidth(headernum, (short)((50 * 6) / ((double)1/20))); //set column bigger wider
	}//for

	//=== Set Excel content === 	
	for(rownum = (short) 0; rownum < ArrEmpno.size(); rownum++){ 	    
        r = s.createRow(rownum+1); //create content row        		
        for (short cellnum = (short) 0; cellnum < 11; cellnum++){
               c = r.createCell(cellnum); //create content cell
			   if (cellnum == 0){
			       c.setCellValue((rownum+1) + "");			    
			  }else if (cellnum == 1){			 
                   c.setCellValue(ArrFullname.get(rownum).toString());
			  }else if (cellnum == 2){
			       c.setCellValue(ArrOccu.get(rownum).toString());			  			     
			  }else if (cellnum == 3){
			       c.setCellValue(ArrNation.get(rownum).toString());				
			  }else if (cellnum == 4){
			      c.setCellValue(ArrBirthdate.get(rownum).toString());				  
			  }else if (cellnum == 5){
			      c.setCellValue(ArrAddress.get(rownum).toString());
			  }else if (cellnum == 6){
			      c.setCellValue(ArrEmpno.get(rownum).toString());
			  }else if (cellnum == 7){		
			      c.setCellValue(ArrPassno.get(rownum).toString());
			  }else if (cellnum == 8){		
			      c.setCellValue(ArrIndt.get(rownum).toString());
			  }else if (cellnum == 9){
			      c.setCellValue("");		  						  				  				  				  
			  }//if
			  s.setColumnWidth(cellnum, (short)((50 * 6) / ((double)1/20))); //set column bigger wider
           }//for	
    }//for	
    wb.write(outx); //write to file
    outx.close(); //colse file
}catch(IOException e){
   out.println("Error in Excel output IOException: " + e.toString());
}catch(Exception e){
   out.println("Error in Excel output Exception: " + e.toString());  
}//try 
%>
<p align="center"><a href= '<%= "bcas/bcas.txt" %>'><strong><font size="6" color="#0000FF">Text file</font></strong></a></p>
<p align="center"><a href= '<%= "bcas/bcas.xls" %>'><strong><font size="6" color="#0000FF">Excel file</font></strong></a></p>
<%
/*
<!--
<form action="india_download.jsp" method="post">
  <input name="filename" type="hidden" value="bcas.xls">
  <input type="submit" value="Download">
</form>
<jsp:forward page="india_download.jsp"> 
<jsp:param name="filename" value="bcas.xls"/> 
</jsp:forward>
-->
*/
%>
</body>
</html>
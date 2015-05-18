<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*, java.util.*, java.io.*, ci.db.*, org.apache.poi.hssf.usermodel.*" %>
<jsp:useBean id="unicodeStringParser" class="cs40javabean.UnicodeStringParser" />

<html>
<head>
<title>MCL</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>


<%!
ArrayList ArrStaTpe = null;
ArrayList ArrEndTpe = null;
ArrayList ArrEmpno = null;
ArrayList ArrCname = null;
ArrayList ArrActRank = null;
ArrayList ArrInstEmpno = null;
ArrayList ArrInstName = null;
ArrayList ArrTrgFunc = null;
ArrayList ArrTrgDesc = null;
ArrayList ArrVenueName= null;
ArrayList ArrDutyCd = null;
ArrayList ArrTrgCd= null;
String year1, mon1, dd1, year2, mon2, dd2, venueName, venueSelecionOperator, displayVenueName;
int i;
%>

<%
ArrStaTpe = new ArrayList();
ArrEndTpe = new ArrayList();
ArrEmpno = new ArrayList();
ArrCname = new ArrayList();
ArrActRank = new ArrayList();
ArrInstEmpno = new ArrayList();
ArrInstName = new ArrayList();
ArrTrgFunc = new ArrayList();
ArrTrgDesc = new ArrayList();
ArrVenueName = new ArrayList();
ArrDutyCd  = new ArrayList();
ArrTrgCd = new ArrayList();

venueName = request.getParameter("sel_venuename");

if (venueName.equals("allsim")){
    venueSelecionOperator = "like";
    venueName = "%SIM";
}else{
    venueSelecionOperator = "=";
}	 

year1 = request.getParameter("sel_year1");
mon1 = request.getParameter("sel_mon1");
dd1 = request.getParameter("sel_dd1");
year2 = request.getParameter("sel_year2");
mon2 = request.getParameter("sel_mon2");
dd2 = request.getParameter("sel_dd2");

Driver dbDriver = null;
Connection conn = null;
Statement stmt = null;
ResultSet myResultSet = null;
ConnDB cn = new ConnDB();
String sql = null;
String bcolor = "";
try{
       cn.setORP3EGUser();
       dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
       conn = dbDriver.connect(cn.getConnURL(), null);
       stmt = conn.createStatement();	  
	   sql = "select empn, ename " +
	            "from egtcbas " +
				"where staff_nm='637075 ' ";
	   
	   /*
	   sql = "SELECT to_char(seg.STR_DT_TM_GMT,'yyyy/mm/dd HH24MI') sta_TPE, to_char(seg.END_DT_TM_GMT,'yyyy/mm/dd HH24MI') end_TPE,  " +
	            "r.STAFF_NUM, c1.preferred_name cname, r.ACTING_RANK, rostrg.INSTRUCTOR_STAFF_NUM, c2.preferred_name inst_name, " + 
				"rostrg.TRAINING_FUNCTION, " + 
				"trgcd.TRG_CD_DESC, venue.name venue_name, " +
 				 "seg.duty_cd, trgcd.TRG_CD " +
                "FROM ROSTER_V r, DUTY_PRD_SEG_V seg, ROSTER_SPECIAL_DUTIES_TRG_V rostrg, TRAINING_CODES_V trgcd, " + 
				 "venue_bookings_v venuebkg, venues_v venue, crew_v c1, crew_v c2 " +
                 "WHERE r.DELETE_IND='N' AND r.SERIES_NUM = seg.SERIES_NUM AND r.staff_num=c1.staff_num AND " + 
				 "rostrg.INSTRUCTOR_STAFF_NUM=c2.staff_num(+) AND " + 
                 "(seg.SERIES_NUM = rostrg.SERIES_NUM and r.ROSTER_NUM = rostrg.ROSTER_NUM) AND " +
                 "(substr(seg.DUTY_CD,4,3)='SIM' or seg.DUTY_CD='SIM' or " +
                 "substr(trgcd.TRG_CD_DESC,1,4)='FTD-' or substr(trgcd.TRG_CD_DESC,1,4)='FBS-' or substr(trgcd.TRG_CD_DESC,1,4)='FFS-') AND " +
                 "seg.FLT_NUM<>'RST' AND rostrg.TRG_CD=trgcd.TRG_CD AND " + 
                 "seg.STR_DT_TM_GMT between "+ 
				 "TO_DATE('" + year1 + mon1 + dd1 + " 00:00','YYYYMMDD HH24:MI') AND " +
                 "TO_DATE('" + year2 + mon2 + dd2 + " 23:59','YYYYMMDD HH24:MI') AND " +
				 "venue.name " +  venueSelecionOperator + " '" + venueName + "' AND " +
				 " venuebkg.venue_bkg_seq_num=seg.venue_bkg_seq_num AND venuebkg.venue_cd=venue.venue_cd " +
                 "ORDER BY venue.name, seg.STR_DT_TM_GMT, r.STAFF_NUM";	  
		*/		 		
       myResultSet = stmt.executeQuery(sql); 
	   if(myResultSet != null){
	       while (myResultSet.next()){
		       ArrStaTpe.add(myResultSet.getString("sta_TPE"));
               ArrEndTpe.add(myResultSet.getString("end_TPE"));
               ArrEmpno.add(myResultSet.getString("staff_num"));
			   ArrCname.add(myResultSet.getString("cname"));
               ArrActRank.add(myResultSet.getString("ACTING_RANK"));
			   
			   if (myResultSet.getString("INSTRUCTOR_STAFF_NUM") == null){
                   ArrInstEmpno.add("");
			   }else{
				    ArrInstEmpno.add(myResultSet.getString("INSTRUCTOR_STAFF_NUM"));
			   }//if               
			   
			   if(myResultSet.getString("inst_name") == null){
			      ArrInstName.add("");
			   }else{
			      ArrInstName.add(myResultSet.getString("inst_name"));			   
			   }//if 
               ArrTrgFunc.add(myResultSet.getString("TRAINING_FUNCTION"));
               ArrTrgDesc.add(myResultSet.getString("TRG_CD_DESC"));
               ArrVenueName.add(myResultSet.getString("venue_name")); 			   
			   ArrDutyCd.add(myResultSet.getString("duty_cd"));
               ArrTrgCd.add(myResultSet.getString("trg_cd"));
	       }//while
	    }//if
}catch (SQLException e){
      out.println("SQL Error : " + sql+ "\r\n" + e.toString());
}catch (Exception e){
      out.println("SQL Error : " + sql+ "\r\n" + e.toString());
}finally{
  	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}//try
%>
<body>
<table width="100%"  border="0" align="center"><tr><td>
    <div align="right"><a href="javascript:window.print()"> <img src="../images/print.gif" width="17" height="15" border="0" alt="Printing"></a> 
    </div>
</td></tr>
</table>
<p align="center"  class="HeaderNav">&nbsp;&nbsp;******&nbsp;MCL&nbsp;******<br>
  if (venueName.equals("%SIM")) displayVenueName = "All SIM";
  %>
  <%=displayVenueName%><br>
  <%=year1%>/<%=mon1%>/<%=dd1%>&nbsp;~&nbsp;<%=year2%>/<%=mon2%>/<%=dd2%></p>
<%
if(ArrStaTpe.size() == 0){
   %>
<% out.println("There's no simulator check data of "+ venueName +" between "  + year1 + "/" +mon1 +"/" + dd1 +" and " + year2 + "/" +mon2 +"/" + dd2 + ".");
}else{   %>
<table width="100%"  border="1" align="center">       
	<!--	<tr>  <td  colspan = "4" class="tablehead"  align="center"> Venue query result</td>  </tr>	-->
    <tr>
        
    <td  class="FontSizeEngB" bgcolor="#CCCCCC">Start (TPE time)</td>	    
    <td  class="FontSizeEngB" bgcolor="#CCCCCC">End (TPE time)</td>
	<td  class="FontSizeEngB" bgcolor="#CCCCCC">Empno</td>
	<td  class="FontSizeEngB" bgcolor="#CCCCCC">Name</td>
	<td  class="FontSizeEngB" bgcolor="#CCCCCC">Acting rank</td>
	<td  class="FontSizeEngB" bgcolor="#CCCCCC">Instruct empno</td>	
    <td  class="FontSizeEngB" bgcolor="#CCCCCC">Instruct name</td>
    <td  class="FontSizeEngB" bgcolor="#CCCCCC">Trg function</td>
    <td  class="FontSizeEngB" bgcolor="#CCCCCC">Trg code desc</td>
    <td  class="FontSizeEngB" bgcolor="#CCCCCC">SIM venue type</td>
    <td  class="FontSizeEngB" bgcolor="#CCCCCC">Duty code</td>
    <td  class="FontSizeEngB" bgcolor="#CCCCCC">Trg code</td>
    </tr>
     <% for(i = 0; i < ArrStaTpe.size(); i++){ 
		        if((i % 2) == 0)  bcolor = "";
		        else bcolor = "#FFFFCC";
                %>	
	              <tr bgcolor="<%=bcolor%>">
                  <td class="FontSizeEngB"><%=ArrStaTpe.get(i)%></td>
                  <td class="FontSizeEngB"><%=ArrEndTpe.get(i)%></td>
                  <td class="FontSizeEngB"><%=ArrEmpno.get(i)%></td>
				  <%				  
				  String cname = (String)ArrCname.get(i); if (cname == null) {cname = "";}
                  String tempCname = unicodeStringParser.removeExtraEscape(cname);
                  String big5Cname = new String(tempCname.getBytes(), "Big5");
				  cname = big5Cname;                  	
				  %>				  
                  <td class="FontSizeEngB"><%=cname%></td>
				  <td class="FontSizeEngB"><%=ArrActRank.get(i)%></td>
				  <td class="FontSizeEngB"><%=ArrInstEmpno.get(i)%></td>
				  <%
				  String instName = (String)ArrInstName.get(i); if (instName == null) {instName = "";}
                  String tempInstName = unicodeStringParser.removeExtraEscape(instName);
                  String big5InstName = new String(tempInstName.getBytes(), "Big5");
                  instName = big5InstName;
				  %>				  
			      <td class="FontSizeEngB"><%=instName%></td>
			      <td class="FontSizeEngB"><%=ArrTrgFunc.get(i)%></td>
			      <td class="FontSizeEngB"><%=ArrTrgDesc.get(i)%></td>
				  <td class="FontSizeEngB"><%=ArrVenueName.get(i)%></td>	  
			      <td class="FontSizeEngB"><%=ArrDutyCd.get(i)%></td>
				  <td class="FontSizeEngB"><%=ArrTrgCd.get(i)%></td>	 				  	
                </tr>	   
            <% } //for
	%> 
  </table>
   <% 
 }//if 

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
%>
 
<p align="center"> <a href= '<%=(String)session.getAttribute("cs55.usr")+ "simchk.xls"%> '><strong>Excel 
  Download</strong></a> </p>
</body>
</html>
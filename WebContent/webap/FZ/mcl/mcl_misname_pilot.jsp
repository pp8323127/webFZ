<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*, javax.sql.DataSource,javax.naming.InitialContext,java.util.*, java.io.*, java.text.*, ci.db.*, org.apache.poi.hssf.usermodel.*, fz.*" %>
<jsp:useBean id="unicodeStringParser" class="cs40javabean.UnicodeStringParser" />
<html>
<head>
<title>Mismatched names</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>
<%!
Vector misName = null;
Vector row = null;
String empno, lname1, lname2, fname1, fname2;
%>
<%
String bcolor = "";
Driver dbDriver = null;
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
ResultSetMetaData rsmd = null; 
ConnDB cn = new ConnDB();
String sql = null;
int columnCount = 0;
DataSource ds = null; 
//*************************************
// AirCrews vs. HR: Single Nationality
//*************************************
try{     
     //DataSource 2009-6-18
	 InitialContext initialcontext = new InitialContext();
	 ds = (DataSource) initialcontext.lookup("CAL.DFDS01");
	 conn = ds.getConnection();
	 conn.setAutoCommit(false);
	 
	 /*
	 cn. setDFUserCP();
     dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
     conn = dbDriver.connect(cn.getConnURL(), null);
	 */
     stmt = conn.createStatement();	  
	 sql = "SELECT a.staff_num empno, a.other_surname lname1, b.lname lname2, a.other_first_name fname1, b.fname fname2 " +        
           "FROM dfdb.crew_v a, hrdb.hrvegemploy b, dfdb.crew_rank_v c " +
           "WHERE a.staff_num=b.employid and a.staff_num=c.staff_num AND " +
		         "c.rank_cd in ('CA','RP','FO','FE','FDT') AND " +
                 "(UPPER(TRIM(a.other_surname)) <> UPPER(TRIM(b.lname)) OR UPPER(TRIM(a.other_first_name)) <> UPPER(TRIM(b.fname))) AND " +
				 "(c.exp_dt IS NULL OR c.exp_dt >= SYSDATE) " +                
           "ORDER BY a.staff_num";
	 rs = stmt.executeQuery(sql); 
	 rsmd = rs.getMetaData();	
	 columnCount = rsmd.getColumnCount();           
	 misName = new Vector(); 
     
	 //Prepare array of mismatched names by SQL
	 while (rs.next()){
	  	   row = new Vector(columnCount);
	       for (int i=0; i < columnCount; i++) {
	           row.addElement(rs.getObject(i + 1));
	       }//for   
	       misName.addElement(row);		   
	 }//while         
     misName.trimToSize();
	 
	 //Refine array of mismatched names by String comparison
	 %><body>
	   <p align="center"><font face="Arial" size="4">Pilot's Mismatched Names</font></p> 
	   <p align="center"><a href="#avh"><font face="Arial" size="2">AirCrews vs. HR: Single Nationality</font></a></p>
	   <p align="center"><a href="#dvh"><font face="Arial" size="2">DFTPASS vs. HR: Double Nationality</font></a></p>
	   <table width="70%"  border="0" align="center">
	   <tr><td colspan="5" align="center" bgcolor="#660000"><font face="Arial" size="2" color="#FFFFFF"><a name="avh"><strong>AirCrews vs. HR: Single Nationality</strong></a></font></td></tr>
	   <tr>
	   <td  class="FontSizeEngB" bgcolor="#CCCCCC">Empno</td>
	   <td  class="FontSizeEngB" bgcolor="#CCCCCC">AirCrews<BR>Last Name</td>
       <td  class="FontSizeEngB" bgcolor="#CCCCCC">HR<BR>Last Name</td>	  
	   <td  class="FontSizeEngB" bgcolor="#CCCCCC">AirCrews<BR>First Name</td>
       <td  class="FontSizeEngB" bgcolor="#CCCCCC">HR<BR>First Name</td>
	   </tr>
	 <%
	 for (int i=0; i < misName.size(); i++) {
	      row = (Vector)misName.get(i);		  
		  %> <tr bgcolor="<%=bcolor%>"><%
		  if (row.get(0) != null) empno  = ((String)row.get(0)).trim(); //empno  
	      %><td class="FontSizeEngB" bgcolor="#FFddDD"><%=empno  %></td><%
		  
		  if (row.get(1) != null) lname1 = ((String)row.get(1)).trim(); //lname: AirCrews    
          if (row.get(2) != null) lname2 = ((String)row.get(2)).trim(); //lname: eHR   
		  
		  if (lname1.trim().toUpperCase().equals(lname2.trim().toUpperCase())){
		     lname1 = "";
			 lname2 = "";
			 %><td><%=lname1 %></td>
		       <td><%=lname2 %></td><%		  
		  }else{
		     %><td class="FontSizeEngB" bgcolor="#FFFFBB"><%=lname1 %></td>
		       <td class="FontSizeEngB" bgcolor="#FFFFBB"><%=lname2 %></td><% 		  
		  }//if  	   
			       
          if (row.get(3) != null) fname1 = ((String)row.get(3)).trim(); //fname: AirCrews
	      if (row.get(4) != null) fname2 = ((String)row.get(4)).trim(); //fname: eHR 
		  if (fname1.trim().toUpperCase().equals(fname2.trim().toUpperCase())){
		     fname1 = "";
			 fname2 = "";
			 %><td><%=fname1 %></td>
			   <td><%=fname2 %></td><% 
		  }else{
		     %><td class="FontSizeEngB" bgcolor="#DDDDFF"><%=fname1 %></td>
		       <td class="FontSizeEngB" bgcolor="#DDDDFF"><%=fname2 %></td><% 
		  }//if 
		  %></tr><%		 
		 		  
	 }//for
	 //misName = null;
	 //row = null;
	 %></table><%                
}catch (SQLException e){
     out.println("SQL Exception Error : " + sql+ "\r\n" + e.toString());
}catch (Exception e){
     out.println("Exception Error : " + sql+ "\r\n" + e.toString());
}finally{
  	try{
	    if(rs != null) rs.close();
	}catch(SQLException e){out.println("Erron in rs.close() <BR> " + e.toString());}
	
	try{
	    if(stmt != null) stmt.close();   
	}catch(SQLException e){out.println("Erron in  stmt.close() <BR>  " + e.toString());}
		
	try{
	    if(conn != null){
		   conn.close(); 			 					 
	    }//if
	}catch(SQLException e){ out.println("Error in conn.close()" + e.toString());}
}//try

//*************************************
// DFTPASS vs. HR: Double Nationality
//*************************************
try{
     //DataSource 2009-6-18
     InitialContext initialcontext = new InitialContext();
	 ds = (DataSource) initialcontext.lookup("CAL.DFDS01");
	 conn = ds.getConnection();
	 conn.setAutoCommit(false);
	 
	 /*
	 cn. setDFUserCP();
     dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
     conn = dbDriver.connect(cn.getConnURL(), null);
	 */
     stmt = conn.createStatement();	  
     sql = "SELECT a.empno empno, a.lname lname1, b.lname lname2, a.fname fname1,b.fname fname2 " +        
           "FROM dftpass a, hrdb.hrvegemploy b, dfdb.crew_rank_v c " +
           "WHERE a.empno=b.employid and a.empno=c.staff_num AND " +
		         "c.rank_cd in ('CA','RP','FO','FE','FDT') AND " +
                 "(UPPER(TRIM(a.lname)) <> UPPER(TRIM(b.lname)) OR UPPER(TRIM(a.fname)) <> UPPER(TRIM(b.fname))) AND " +
			     "(c.exp_dt IS NULL OR c.exp_dt >= SYSDATE) " +                
           "ORDER BY a.empno";	 
	 rs = stmt.executeQuery(sql); 
	 rsmd = rs.getMetaData();	
	 columnCount = rsmd.getColumnCount();           
	 misName = new Vector(); 
     
	 //Prepare array of mismatched names by SQL
	 while (rs.next()){
	  	   row = new Vector(columnCount);
	       for (int i=0; i < columnCount; i++) {
	           row.addElement(rs.getObject(i + 1));
	       }//for   
	       misName.addElement(row);		   
	 }//while         
     misName.trimToSize();
	 
	 //Refine array of mismatched names by String comparison
	 %>	         
	   <p>&nbsp;</p><p>&nbsp;</p>
	   <table width="70%"  border="0" align="center">
   	   <tr><td colspan="5" align="center" bgcolor="#660000"><font face="Arial" size="2" color="#FFFFFF"><a name="dvh"><strong>DFTPASS vs. HR: Double Nationality</strong></a></font></td></tr>
	   <tr>
	   <td  class="FontSizeEngB" bgcolor="#CCCCCC">Empno</td>
	   <td  class="FontSizeEngB" bgcolor="#CCCCCC">DFTPASS<BR>Last Name</td>
       <td  class="FontSizeEngB" bgcolor="#CCCCCC">HR<BR>Last Name</td>	  
	   <td  class="FontSizeEngB" bgcolor="#CCCCCC">DFTPASS<BR>First Name</td>
       <td  class="FontSizeEngB" bgcolor="#CCCCCC">HR<BR>First Name</td>
	   </tr>
	 <%
	 for (int i=0; i < misName.size(); i++) {
	      row = (Vector)misName.get(i);  
	      %> <tr bgcolor="<%=bcolor%>"><%
		  if (row.get(0) != null) empno  = ((String)row.get(0)).trim(); //empno  
	      %><td class="FontSizeEngB" bgcolor="#FFddDD"><%=empno  %></td><%
		  
		  if (row.get(1) != null) lname1 = ((String)row.get(1)).trim(); //lname: AirCrews    
          if (row.get(2) != null) lname2 = ((String)row.get(2)).trim(); //lname: eHR   
		  
		  if (lname1.trim().toUpperCase().equals(lname2.trim().toUpperCase())){
		     lname1 = "";
			 lname2 = "";
			 %><td><%=lname1 %></td>
		       <td><%=lname2 %></td><%		  
		  }else{
		     %><td class="FontSizeEngB" bgcolor="#FFFFBB"><%=lname1 %></td>
		       <td class="FontSizeEngB" bgcolor="#FFFFBB"><%=lname2 %></td><% 		  
		  }//if  	   
			       
          if (row.get(3) != null) fname1 = ((String)row.get(3)).trim(); //fname: AirCrews
	      if (row.get(4) != null) fname2 = ((String)row.get(4)).trim(); //fname: eHR 
		  if (fname1.trim().toUpperCase().equals(fname2.trim().toUpperCase())){
		     fname1 = "";
			 fname2 = "";
			 %><td><%=fname1 %></td>
			   <td><%=fname2 %></td><% 
		  }else{
		     %><td class="FontSizeEngB" bgcolor="#DDDDFF"><%=fname1 %></td>
		       <td class="FontSizeEngB" bgcolor="#DDDDFF"><%=fname2 %></td><% 
		  }//if 
		  %></tr><% 		  
	 }//for
	 //misName = null;
	 //row = null;
	 %></table><%                
}catch (SQLException e){
     out.println("SQL Exception Error : " + sql+ "\r\n" + e.toString());
}catch (Exception e){
     out.println("Exception Error : " + sql+ "\r\n" + e.toString());
}finally{
  	try{
	    if(rs != null) rs.close();
	}catch(SQLException e){out.println("Erron in rs.close() <BR> " + e.toString());}
	
	try{
	    if(stmt != null) stmt.close();   
	}catch(SQLException e){out.println("Erron in  stmt.close() <BR>  " + e.toString());}
		
	try{
	    if(conn != null){
		   conn.close(); 			 					 
	    }//if
	}catch(SQLException e){ out.println("Error in conn.close()" + e.toString());}
}//try
%>
</body>
</html>

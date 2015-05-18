<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*, javax.sql.DataSource,javax.naming.InitialContext, java.util.*, java.io.*, java.text.*, ci.db.*, org.apache.poi.hssf.usermodel.*, fz.*" %>
<html><head><title></title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>
<%!
String fdate, carrier, fltno, dpt, arv, empno, lname, fname, occu, stdtpe, newuser, birth, sendtype, tmst;
ArrayList ArrFdate = null;
ArrayList ArrCarrier = null;
ArrayList ArrFltno = null;
ArrayList ArrDpt = null;
ArrayList ArrArv = null;
ArrayList ArrEmpno = null;
ArrayList ArrLname = null;
ArrayList ArrFname = null;
ArrayList ArrOccu  = null;
ArrayList ArrStdtpe  = null;
ArrayList ArrNewuser  = null;
ArrayList ArrBirth  = null;
ArrayList ArrSendtype  = null;
ArrayList ArrTmst  = null;
int i;
%>
<%
/*
String userid = (String) session.getAttribute("userid") ; //get user id if already login
if (userid == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} //if
*/
fdate = request.getParameter("fltdt").replaceAll("/","").substring(2); // yyyy/mm/dd --> yymmdd
fltno = request.getParameter("fltno");
dpt   = request.getParameter("dpt");

ArrFdate    = new ArrayList();
ArrCarrier  = new ArrayList();
ArrFltno    = new ArrayList();
ArrDpt      = new ArrayList();
ArrArv      = new ArrayList();
ArrEmpno    = new ArrayList();
ArrLname    = new ArrayList();
ArrFname    = new ArrayList();
ArrOccu     = new ArrayList();
ArrBirth    = new ArrayList();
ArrStdtpe   = new ArrayList();
ArrTmst     = new ArrayList();
ArrSendtype = new ArrayList();
ArrNewuser  = new ArrayList();

String bcolor = "";
Connection conn = null;
DataSource ds = null;
Statement stmt  = null;
ResultSet myResultSet = null;
String sql = null;
try{
    InitialContext initialcontext = new InitialContext();
    ds = (DataSource) initialcontext.lookup("CAL.FZDS02"); 
    conn = ds.getConnection();
    conn.setAutoCommit(false);	
    stmt = conn.createStatement();
	sql = "SELECT fdate, carrier, fltno, dpt, arv, NVL(empno,'N/A') empno, occu, birth, lname, fname, "+
	      "to_char(stdtpe, 'yyyy-mm-dd hh24:mi') stdtpe, to_char(tmst, 'yyyy-mm-dd hh24:mi') tmst, " +
		  "newuser, sendtype " +
	      "FROM FZDB.FZTSELG " +
		  "WHERE fdate='"+fdate+"' and fltno='"+fltno+"' and dpt='"+dpt+"' " +
		  "ORDER BY tmst DESC, occu ";
		
     myResultSet = stmt.executeQuery(sql); 
	 if(myResultSet != null){
	       while (myResultSet.next()){
	           ArrFdate.add(myResultSet.getString("fdate"));
	           ArrCarrier.add(myResultSet.getString("carrier"));			   
	           ArrFltno.add(myResultSet.getString("fltno"));
	           ArrDpt.add(myResultSet.getString("dpt"));
	           ArrArv.add(myResultSet.getString("arv"));
	           ArrEmpno.add(myResultSet.getString("empno"));
			   ArrOccu.add(myResultSet.getString("occu"));
               ArrBirth.add(myResultSet.getString("birth"));
			   ArrLname.add(myResultSet.getString("lname"));
			   ArrFname.add(myResultSet.getString("fname"));
		       ArrNewuser.add(myResultSet.getString("newuser"));
		       ArrSendtype.add(myResultSet.getString("sendtype"));			   
		       ArrTmst.add(myResultSet.getString("tmst"));
		       ArrStdtpe.add(myResultSet.getString("stdtpe"));			   
		   }//while
	 }//if
}catch (SQLException e){
      out.println("SQL Exception Error : <BR>" + sql+ "\r\n" + e.toString());
}catch (Exception e){
      out.println("Exception Error :  <BR>" + sql+ "\r\n" + e.toString());
}finally{
  	try{
	     if(myResultSet != null) myResultSet.close();
	}catch(SQLException e){out.println("Erron in myResultSet.close() <BR> " + e.toString());}
	
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
<body>
<p class="FontSizeEngB">APIS Sent Log</p>
<table><tr>
<td  class="FontSizeEngB" bgcolor="#D0F999"><li>Occu<br>
CGO = Cargo Passenger<br>
CA, RP, FO ... = Pilot<br>
PR, FC, FF ... = Cabin
</li>
<td  class="FontSizeEngB" bgcolor="#D0F999"><li>Send type<br>
AUTO = Auto send<br>
MANU = Manual send(AirCrews matched AirOps)<br>
UDEF = Manual send(AirCrews not matched AirOps)</li>
</tr></table>
<!--
<table width="100%"  border="0" align="center"><tr><td>
<div align="right"><a href="javascript:window.print()"><img src="../images/print.gif" width="17" height="15" border="0" alt="Printing"></a>  </div>
</td></tr> </table> 
-->
<%  


/*
String path = application.getRealPath("/")+"/file/";
String filename = "PA_RAWLINE.CSV";
FileWriter fw = new FileWriter(path+filename,false);
fw.write("Cname,Sern,Empno,Raw Score,Line Score,Weighted Average,Rank" + "\r\n");
*/

if (ArrFdate.size() == 0){
        out.println("No data.");
}else{   %>    
       <table width="100%"  border="1" align="center"> 
       <tr>
	   <td  class="tablehead" bgcolor="#CCCCCC">Fdate<BR>(local)</td>	  
	   <td  class="tablehead" bgcolor="#CCCCCC">Carrier</td> 
	   <td  class="tablehead" bgcolor="#CCCCCC">Fltno</td>
	   <td  class="tablehead" bgcolor="#CCCCCC">Dpt</td>
	   <td  class="tablehead" bgcolor="#CCCCCC">Arv</td>
	   <td  class="tablehead" bgcolor="#CCCCCC">Schedule Dpt Time<br>(TPE)</td>	   
	   <td  class="tablehead" bgcolor="#CCCCCC">Sent Timestamp<br>(TPE)</td>
	   <td  class="tablehead" bgcolor="#CCCCCC">Last name</td>
	   <td  class="tablehead" bgcolor="#CCCCCC">First name</td>			
       <td  class="tablehead" bgcolor="#CCCCCC">Birthday</td>
	   <td  class="tablehead" bgcolor="#CCCCCC">Occu</td>
	   <td  class="tablehead" bgcolor="#CCCCCC">Empno</td>			
	   <td  class="tablehead" bgcolor="#CCCCCC">User</td>	   
    <td  class="tablehead" bgcolor="#CCCCCC">Send Type</td>	
	  </tr>
     <% 	 
	  for(i = 0; i < ArrFdate.size(); i++){ 
		 if((i % 2) == 0)  bcolor = "";
		 else bcolor = "#CDE7FA";
         %>	
	     <tr bgcolor="<%=bcolor%>"> 
         <td class="FontSizeEngB"><%=ArrFdate.get(i)%></td>
		 <td class="FontSizeEngB"><%=ArrCarrier.get(i)%></td>
		 <td class="FontSizeEngB"><%=ArrFltno.get(i)%></td>
		 <td class="FontSizeEngB"><%=ArrDpt.get(i)%></td>
		 <td class="FontSizeEngB"><%=ArrArv.get(i)%></td>
		 <td class="FontSizeEngB"><%=ArrStdtpe.get(i)%></td>
		 <td class="FontSizeEngB"><%=ArrTmst.get(i)%></td>
		 <td class="FontSizeEngB"><%=ArrLname.get(i)%></td>
		 <td class="FontSizeEngB"><%=ArrFname.get(i)%></td>
		 <td class="FontSizeEngB"><%=ArrBirth.get(i)%></td>
		 <td class="FontSizeEngB"><%=ArrOccu.get(i)%></td>
		 <td class="FontSizeEngB"><%=ArrEmpno.get(i)%></td>
		 <td class="FontSizeEngB"><%=ArrNewuser.get(i)%></td>
		 <td class="FontSizeEngB"><%=ArrSendtype.get(i)%></td>
         </tr>			   
         <%		 
	     /*
		 fw.write(ArrCname.get(i) + ",");
         fw.write(ArrSern.get(i)  + ",");
	     fw.write(ArrEmpno.get(i) + ",");
	     fw.write(ArrRawScore.get(i) + ",");
	     fw.write(ArrLineScore.get(i)  + ",");
		 fw.write(ArrWgtAvg.get(i)  + ",");
	     fw.write(ArrRank.get(i) + "\r\n");
		 */
	} //for
	%> 
    </table>   
   <%	
}//if 

//fw.close();

//session close
//session.invalidate();

%>
<!--
<P align="center">
<a href="saveFile.jsp?filename=<% //=filename%>">
<img src="../images/ed4.gif" border="0"><span class="txtblue"><% //=filename%></span></a>
</p>
<div align="center" class="txtblue">請點擊連結存檔<BR>
  Click link to save file</div>
-->
</body>
</html>
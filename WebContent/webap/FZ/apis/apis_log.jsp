<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*, java.util.*, java.io.*, java.text.*, ci.db.*, org.apache.poi.hssf.usermodel.*, fz.*" %>
<html><head><title>APIS Log</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>
<%!
ArrayList ArrActionTime   = null;
ArrayList ArrUserip       = null;		                
ArrayList ArrUserid       = null;						
ArrayList ArrUserhost     = null;
ArrayList ArrAction       = null;						 
ArrayList ArrActionStatus = null;
ArrayList ArrFdate        = null;						 
ArrayList ArrFltno        = null;						 
ArrayList ArrCrewtype     = null;						 
ArrayList ArrActionResult = null;

/*
String ghi = null;
String crewtype = null;
String nat = null;
String empnoString = null;
String path = null;
//String[] EmpnoTokens  = null;
//StringTokenizer tokens = null;
*/
int i;
%>
<%
/*String ename;
String surname;
String firstname;
String nation;
String certno;
crewtype = (String)session.getAttribute("crewtype");
path = "/apsource/csap/projfz/webap/FZ/mcl/" + crewtype + "/";
PrintWriter prMcl=new PrintWriter(new BufferedWriter(new FileWriter(path+"manifest.txt")));
*/

String year1, mon1, dd1, year2, mon2, dd2;

year1 = request.getParameter("sel_year1");
mon1 = request.getParameter("sel_mon1");
dd1 = request.getParameter("sel_dd1");
year2 = request.getParameter("sel_year2");
mon2 = request.getParameter("sel_mon2");
dd2 = request.getParameter("sel_dd2");

ArrActionTime   = new ArrayList();
ArrUserip       = new ArrayList();		                
ArrUserid       = new ArrayList();						
ArrUserhost     = new ArrayList();
ArrAction       = new ArrayList();						 
ArrActionStatus = new ArrayList();
ArrFdate        = new ArrayList();						 
ArrFltno        = new ArrayList();						 
ArrCrewtype     = new ArrayList();						 
ArrActionResult = new ArrayList();

String actionStatus;
actionStatus = "";

String bcolor = "";
Driver dbDriver = null;
Connection conn = null;
Statement stmt = null;
ResultSet myResultSet = null;
ConnDB cn = new ConnDB();
String sql = null;
try{
    cn. setDFUserCP();
    dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
    conn = dbDriver.connect(cn.getConnURL(), null);
    stmt = conn.createStatement();	  
    sql = "select to_char(action_time, 'yyyy/mm/dd hh24:mi:ss') action_time, " +
	             "userip, " +
		         "userid, " +
			     "userhost, "+
				 "action, "+
				 "action_status, " +
				 "fdate, " +
				 "fltno, " +
				 "crewtype, " +
				 "action_result " + 
		   "from dftalog " +		 
		   "where action_time between "+ 
				 "TO_DATE('" + year1 + mon1 + dd1 + " 00:00','YYYYMMDD HH24:MI') AND " +
                 "TO_DATE('" + year2 + mon2 + dd2 + " 23:59','YYYYMMDD HH24:MI') " +
		   "order by action_time, userip";
	   myResultSet = stmt.executeQuery(sql); 
	   if(myResultSet != null){
	      while (myResultSet.next()){
		       ArrActionTime.add(myResultSet.getString("action_time"));
		       ArrUserip.add(myResultSet.getString("userip"));
		       ArrUserid.add(myResultSet.getString("userid"));
		       ArrUserhost.add(myResultSet.getString("userhost"));
		       ArrAction.add(myResultSet.getString("action"));
			   
			   actionStatus = myResultSet.getString("action_status");
			   actionStatus = actionStatus.replaceAll(";", "<BR>");
		       ArrActionStatus.add(actionStatus);
			   			   
		       ArrFdate.add(myResultSet.getString("fdate"));
		       ArrFltno.add(myResultSet.getString("fltno"));
		       ArrCrewtype.add(myResultSet.getString("crewtype"));
		       ArrActionResult.add(myResultSet.getString("action_result"));	
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
		   conn.close(); 			  					 
	    }//if
	}catch(SQLException e){ out.println("Error in conn.close()" + e.toString());}
}//try
%>
<body>
<table width="100%"  border="0" align="center"><tr><td>
<div align="right"><a href="javascript:window.print()"><img src="../images/print.gif" width="17" height="15" border="0" alt="Printing"></a>  </div>
</td></tr> </table> 
<%  
if (ArrActionTime.size() == 0){
   out.println("No log.<hr>");
}else{   %>   
       <p align="center"  class="HeaderNav">APIS Log</p>  
       <table width="100%"  border="1" align="center"> 
       <tr>
	   <td  class="FontSizeEngB" bgcolor="#CCCCCC">Action Time</td>
	   <td  class="FontSizeEngB" bgcolor="#CCCCCC">User IP<BR>Address</td>
       <td  class="FontSizeEngB" bgcolor="#CCCCCC">User<BR>Empno</td>
	   <td  class="FontSizeEngB" bgcolor="#CCCCCC">User<BR>Host<BR>Name</td>
	   <td  class="FontSizeEngB" bgcolor="#CCCCCC">Action</td>
	   <td  class="FontSizeEngB" bgcolor="#CCCCCC">Fdate</td>
       <td  class="FontSizeEngB" bgcolor="#CCCCCC">Fltno</td>
	   <td  class="FontSizeEngB" bgcolor="#CCCCCC">Crew<BR>Type</td>
	   <td  class="FontSizeEngB" bgcolor="#CCCCCC">Action<BR>Result</td>
	   <td  class="FontSizeEngB" bgcolor="#CCCCCC">Action Result Description</td>
      </tr>
     <% 
	  for(i = 0; i < ArrActionTime.size(); i++){ 
		  if((i % 2) == 0)  bcolor = "";
		  else bcolor = "#DAFC99";
          %>	
	        <tr bgcolor="<%=bcolor%>"> 
            <td class="FontSizeEngB"><%=ArrActionTime.get(i)%></td>
			<td class="FontSizeEngB"><%=ArrUserip.get(i)%></td>
		    <td class="FontSizeEngB"><%=ArrUserid.get(i)%></td>
			<td class="FontSizeEngB"><%=ArrUserhost.get(i)%></td>
			<td class="FontSizeEngB"><%=ArrAction.get(i)%></td>			
			<td class="FontSizeEngB"><%=ArrFdate.get(i)%></td>
	        <td class="FontSizeEngB"><%=ArrFltno.get(i)%></td>
			<td class="FontSizeEngB"><%=ArrCrewtype.get(i)%></td>
			<td class="FontSizeEngB"><%=ArrActionResult.get(i)%></td>
			<td class="FontSizeEngB"><%=ArrActionStatus.get(i)%></td>				  
            </tr>	   
          <% 
	} //for
	%> 
    </table>
   
    
	<%    			   
    /*
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
	*/	
}//if 

/*
//close file
try{
      prMcl.close();
}catch(Exception e){ out.println("prMcl close error:" + e.toString() + "<BR>");}
*/

//session close
session.invalidate();
%>
</body>
</html>

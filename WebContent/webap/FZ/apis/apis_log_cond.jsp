<%@ page contentType="text/html; charset=big5" language="java" import="ci.db.*,java.util.*,java.sql.*,fz.UnicodeStringParser" errorPage=""%>
<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //Check if logined
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
if (session.isNew() || sGetUsr == null) {		//check user session start first
    %> <jsp:forward page="../sendredirect.jsp" /> <%
}

ArrayList venueItems = new ArrayList();
Driver dbDriver = null;
Connection conn = null;
Statement stmt = null;
ResultSet myResultSet = null;
ConnDB cn = new ConnDB();
String sql = null;
String bcolor = "";
String venueItem = null;
try{
       cn.setAOCIPRODCP();
       dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
       conn = dbDriver.connect(cn.getConnURL(), null);
       stmt = conn.createStatement();
	   sql = "select name from venues_v where venue_type_cd in ('SIM','FTD','FFS','FBS') order by name"; 
       myResultSet = stmt.executeQuery(sql); 
	   if(myResultSet != null){
	       while (myResultSet.next()){
	            venueItems.add(myResultSet.getString("name")); 
	       }//while
	    }//if	
}catch (SQLException e){
      out.println("SQL Error : " + e.toString() + sql);
}catch (Exception e){
      out.println("Error : " + e.toString() + sql);
}finally{
  	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}//try
%>
<html>
<head>
<title>SIM check query condition</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../menu.css" rel="stylesheet" type="text/css">
<script src="../js/showDate.js"></script>
</head>
<body  onLoad="showYMD('form1','sel_year1','sel_mon1','sel_dd1');showYMD('form1','sel_year2','sel_mon2','sel_dd2');">
<form name="form1" method="post" action="apis_log.jsp" class="txtblue" target="mainFrame">
  <p > APIS Log 
    <select name="sel_year1">
      <%
	java.util.Date now1 = new java.util.Date();
	int syear1	=	now1.getYear() + 1900;
	for (int i=2006; i<syear1 + 2; i++) {    
           %>
      <option value="<%=i%>"><%=i%></option>
      <%
	}
  %>
    </select>
    <span class="txtblue">/</span> 
    <select name="sel_mon1">
      <%
	for (int j=1; j<13; j++) {    
	     if (j<10 ){
               %>
      <option value="0<%=j%>">0<%=j%></option>
      <%
		 }else{
              %>
      <option value="<%=j%>"><%=j%></option>
      <%
		}
	}
  %>
    </select>
    / 
    <select name="sel_dd1">
      <%
	for (int j=1; j<32; j++) 	{    
    	  if (j<10 )		{
             %>
      <option value="0<%=j%>">0<%=j%></option>
      <%
	      }else	{
             %>
      <option value="<%=j%>"><%=j%></option>
      <%
		}
   }
  %>
    </select>
    &nbsp;&nbsp;  - &nbsp; &nbsp; 
    <select name="sel_year2">
      <%
	java.util.Date now2 = new java.util.Date();
	int syear2	=	now2.getYear() + 1900;
	for (int i=2006; i<syear2 + 2; i++) {    
           %>
      <option value="<%=i%>"><%=i%></option>
      <%
	}
  %>
    </select>
    <span class="txtblue">/</span> 
    <select name="sel_mon2">
      <%
	for (int j=1; j<13; j++) {    
	     if (j<10 ){
               %>
      <option value="0<%=j%>">0<%=j%></option>
      <%
		 }else{
              %>
      <option value="<%=j%>"><%=j%></option>
      <%
		}
	}
  %>
    </select>
    / 
    <select name="sel_dd2">
      <%
	for (int j=1; j<32; j++) 	{    
    	  if (j<10 )		{
             %>
      <option value="0<%=j%>">0<%=j%></option>
      <%
	      }else	{
             %>
      <option value="<%=j%>"><%=j%></option>
      <%
		}
   }
  %>
    </select>
    &nbsp; &nbsp; 
    <input name="Submit" type="submit" class="btm" value="Query">
  </p>
  </form>
</body>
</html>

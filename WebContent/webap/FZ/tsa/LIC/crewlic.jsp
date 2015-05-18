<%@page contentType="text/html; charset=big5" language="java" import="fz.*,java.sql.*,javax.sql.DataSource,javax.naming.*"%>
<%
// v001 2008/10/31 cs27 

response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
%>
<html>
<head>
<title>
Crew License Information
</title>
<meta http-equiv="pragma" content="no-cache">
<link href="menu.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=big5"></head>

<body >
<center>
  <span class="txttitletop">Crew Licence Information</span><br>
<%
   String empno = request.getParameter("empno");
   String sql = null;
   String date1 = "";
   String date2 = "";
   java.sql.Date mon1 = null;
   java.sql.Date mon6 = null;
   String rcolor = "#464883";
   String visa_type = null;
   boolean flag = true;
   int rCount = 0;
   
   Connection myConn = null;
   Statement stmt = null;
   Statement stmt2 = null;
   ResultSet myResultSet = null;
   ResultSet myResultSet2 = null;
   //DataSource
	Context initContext = null;
	DataSource ds = null;
	//DataSource
   
try{
   initContext = new InitialContext();
	//connect to AOCIPROD by Datasource
	ds = (javax.sql.DataSource)initContext.lookup("CAL.FZDS03");
	myConn = ds.getConnection();
    stmt = myConn.createStatement();	
	stmt2 = myConn.createStatement();	
   
   CrewInfo ci = new CrewInfo();
   ci.setCrewInfo(empno);
   //Get Today - 1month and Today - 6months
   sql = "select to_char(add_months(sysdate, 1),'yyyy-mm-dd') mon1, to_char(add_months(sysdate, 6),'yyyy-mm-dd') mon6 from dual";
   myResultSet = stmt.executeQuery(sql); 
   if (myResultSet.next()){
   		mon1 = java.sql.Date.valueOf(myResultSet.getString("mon1"));
		mon6 = java.sql.Date.valueOf(myResultSet.getString("mon6"));
   }
   myResultSet.close();
%>
<span class="txttitle"><%=empno%> <%=ci.getCname()%> / <%=ci.getEname()%> <%=ci.getOccu()%> <%=ci.getFleet()%></span>
<br>
<span class="txtxred">Licence
</span>
  <table width="90%" border="1" cellpadding="0" cellspacing="0" class="fortable">
    <tr>
		<td class="tablehead3">Licence</td>
        <td class="tablehead3">Number</td>     
        <td class="tablehead3">Start Date</td>
        <td class="tablehead3">Exp Date</td>
		<td class="tablehead3">Fleet</td>
        <td class="tablehead3">Comments</td>
    </tr>
<%
   sql = "select  c.licence_cd,licence_num,to_char(str_dt,'yyyy-mm-dd') str_dt,nvl(to_char(exp_dt,'yyyy-mm-dd'),'') exp_dt,nvl(fleet_cd,' ') fleet_cd,nvl(comments,' ') comments " +
   "from crew_licence_v c   where staff_num='"+empno+"' and licence_cd<>'CMC'  ";
   myResultSet = stmt.executeQuery(sql);  
   if (myResultSet != null)
   {
   		while (myResultSet.next())
		{
			if(myResultSet.getString("exp_dt") != null){
				 date1 = myResultSet.getString("exp_dt");
				 if(java.sql.Date.valueOf(date1).compareTo(mon1) <= 0){
				 		rcolor = "#FF0000";
				 }
				 else{
				 		rcolor = "#464883";
				 }
			}
//v001
String Licence_cd = "" ;
String Licence_desc = "" ;
Licence_cd = myResultSet.getString("licence_cd"); 
Licence_desc="Code: "+ Licence_cd ;
if (Licence_cd.equals("CHN")) Licence_desc="台胞證<br>MTPT (Mainland Travel Permits for Taiwan Residents)<br>Code: CHN " ;
			
%>
      <tr class="txtblue">
        <td><%= Licence_desc %> </td>
        <td><div align="center"><%= myResultSet.getString("licence_num") %> </div></td>
        <td><div align="center"><%= myResultSet.getString("str_dt") %> </div></td>
        <td><div align="center" style="color:<%=rcolor%>"><%= date1 %></div></td>
		<td><div align="center"><%= myResultSet.getString("fleet_cd") %> </div></td>
		<td><%= myResultSet.getString("comments") %> </td>
      </tr>
<%
		}
		myResultSet.close();
	}
%>
</table>
<span class="txtxred">Medical
</span>
  <table width="90%" border="1" cellpadding="0" cellspacing="0" class="fortable">
    <tr>
        <td class="tablehead3">Last Date</td>
        <td class="tablehead3">Exp Date</td>     
        <td class="tablehead3">Restrict IND</td>
		<td class="tablehead3">Renewal Period IND</td>
    </tr>
<%
   date1 = "";
   sql = "select to_char(last_med_dt,'yyyy-mm-dd') last_med_dt,nvl(to_char(med_exp_dt,'yyyy-mm-dd'),'') med_exp_dt,nvl(restrict_ind,' ') restrict_ind,nvl(renewal_period_ind,' ') renewal_period_ind from crew_medical_v where staff_num='"+empno+"'";
   myResultSet = stmt.executeQuery(sql);  
   if (myResultSet.next())
   {
		if(myResultSet.getString("med_exp_dt") != null){
			date1 = myResultSet.getString("med_exp_dt");
			if(java.sql.Date.valueOf(date1).compareTo(mon1) <= 0){
					rcolor = "#FF0000";
			 }
			 else{
					rcolor = "#464883";
			 }
		}
%>
      <tr class="txtblue">
        <td><div align="center"><%= myResultSet.getString("last_med_dt") %> </div></td>
        <td><div align="center" style="color:<%=rcolor%>"><%= date1 %> </div></td>
        <td><div align="center"><%= myResultSet.getString("restrict_ind") %> </div></td>
		<td><div align="center"><%= myResultSet.getString("renewal_period_ind") %> </div></td>
      </tr>
<%
	}
	myResultSet.close();
%>
</table>
<span class="txtxred">Passport
</span>
  <table width="90%" border="1" cellpadding="0" cellspacing="0" class="fortable">
    <tr>
        <td class="tablehead3">Number</td>
        <td class="tablehead3">Surname</td> 
		<td class="tablehead3">Eff Date</td>    
        <td class="tablehead3">Exp Date</td>
		<td class="tablehead3">Ctry CD</td>
    </tr>
<%
   date1 = "";
   sql = "select passport_num,nvl(passport_surname,' ') passport_surname,to_char(eff_dt,'yyyy-mm-dd') eff_dt,nvl(to_char(exp_dt,'yyyy-mm-dd'),'') exp_dt,nvl(ctry_cd,' ') ctry_cd from crew_passport_v where staff_num='"+empno+"'";
   myResultSet = stmt.executeQuery(sql);  
   if (myResultSet != null)
   {
   		while (myResultSet.next()){
			if(myResultSet.getString("exp_dt") != null){
				 date1 = myResultSet.getString("exp_dt");
				 if(java.sql.Date.valueOf(date1).compareTo(mon6) <= 0){
					rcolor = "#FF0000";
				 }
				 else{
						rcolor = "#464883";
				 }
			}
	%>
		  <tr class="txtblue">
			<td><div align="center"><%= myResultSet.getString("passport_num") %> </div></td>
			<td><div align="center"><%= myResultSet.getString("passport_surname") %> </div></td>
			<td><div align="center"><%= myResultSet.getString("eff_dt") %> </div></td>
			<td><div align="center" style="color:<%=rcolor%>">&nbsp;<%= date1 %> </div></td>
			<td><div align="center">&nbsp;<%= myResultSet.getString("ctry_cd") %> </div></td>
		  </tr>
	<%
		}
		myResultSet.close();
	}
%>
</table>
<span class="txtxred">Visa
</span>
  <table width="90%" border="1" cellpadding="0" cellspacing="0" class="fortable">
    <tr>
        <td class="tablehead3">Ctry CD</td>
		<td class="tablehead3">Type</td> 
        <td class="tablehead3">Issue Date</td> 
        <td class="tablehead3">Exp Date</td>
    </tr>
<%
   date1 = "";
   sql = "select ctry_cd,visa_type,to_char(issue_dt,'yyyy-mm-dd') issue_dt,to_char(exp_dt,'yyyy-mm-dd') exp_dt " +
   "from crew_visa_v where staff_num='"+empno+"'";
   myResultSet = stmt.executeQuery(sql);  
   if (myResultSet != null)
   {
   		while (myResultSet.next()){
			flag = true;
			visa_type = null;
			rCount = 0;
			visa_type = myResultSet.getString("visa_type");
			//add by cs55 2006/05/30
			if("USB".equals(visa_type)){
				flag = false;
				visa_type = "*" + visa_type;
			}
			if("LUX".equals(visa_type)){
				myResultSet2 = stmt2.executeQuery("select count(*) from crew_qualifications_v " +
				"where qual_cd='W1N2' and actuals_status='T' and (expiry_dts>=sysdate or expiry_dts is null) and staff_num='"+empno+"'");
				while (myResultSet2.next()){	
					rCount = myResultSet2.getInt(1);
				}
				myResultSet2.close();
				if(rCount == 0){
					flag = false;
					visa_type = "*" + visa_type;
				}
			}
			//*************end add by cs55 2006/05/30
			if(myResultSet.getString("issue_dt") != null) date1 = myResultSet.getString("issue_dt");
			if(myResultSet.getString("exp_dt") != null){
				 date2 = myResultSet.getString("exp_dt");
				 if(java.sql.Date.valueOf(date2).compareTo(mon1) <= 0 && flag){
						rcolor = "#FF0000";//已過期
				 }
				 else{
						rcolor = "#464883";
				 }
			}
	%>
		  <tr class="txtblue">
			<td><div align="center"><%= myResultSet.getString("ctry_cd") %> </div></td>
			<td><div align="center"><%= visa_type %> </div></td>
			<td><div align="center"> <%= date1 %> </div></td>
			<td><div align="center" style="color:<%=rcolor%>"> <%= date2 %> </div></td>
		  </tr>
	<%
		}
	}
%>
</table>
<br>
    <a href="licence_cd.jsp" target="_blank" class="btm">Licence CD</a>
    <a href="ctry_cd.jsp" target="_blank" class="bu">Ctry CD</a><br>
  <%        

}//end of try
catch(Exception e) {  
	out.print(e.toString());
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(myResultSet2 != null) myResultSet2.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(stmt2 != null) stmt2.close();}catch(SQLException e){}
	try{if(myConn != null) myConn.close();}catch(SQLException e){}
}
%>
</p>
<table width="60%"  border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td class="txtxred">紅色日期代表證件即將過期或已過期。VISA : 1 month   Passport : 6 month<br>Remark * : 不檢查</td>
  </tr>
</table>
</center>
</body>
</html>

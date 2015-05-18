<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.util.*,java.text.*" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //Check if logined

String str_check_date = (String) request.getParameter("applydate"); 
//out.println("check_date= "+str_check_date);
//out.println("sGetUsr= " + sGetUsr.substring(0,3));

if ((sGetUsr == null) || (session.isNew()) )
     {	//check user session start first or not login
	response.sendRedirect("sendredirect.jsp");
     } 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Crew Reporting Check System</title>
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
//String f = request.getParameter("f");
//out.println(" f= "+f);
Driver 		A001_dbDriver  	= null;
Driver 		A002_dbDriver  	= null;
Driver 		A003_dbDriver  	= null;
Driver 		A004_dbDriver  	= null;
Driver 		A005_dbDriver  	= null;
Driver 		A006_dbDriver  	= null;
Driver 		A007_dbDriver  	= null;
Driver 		A008_dbDriver  	= null;
Driver 		A010_dbDriver  	= null;
Driver 		A011_dbDriver  	= null;
Driver 		A012_dbDriver  	= null;

Connection 	A001_conn 	= null;
Connection 	A002_conn 	= null;
Connection 	A003_conn 	= null;
Connection 	A004_conn 	= null;
Connection 	A005_conn 	= null;
Connection 	A006_conn 	= null;
Connection 	A007_conn 	= null;
Connection 	A008_conn 	= null;
Connection 	A010_conn 	= null;
Connection 	A011_conn 	= null;
Connection 	A012_conn 	= null;

Statement 	A001_stmt    	= null;
Statement 	A002_stmt    	= null;
Statement 	A003_stmt    	= null;
Statement 	A004_stmt    	= null;
Statement 	A005_stmt    	= null;
Statement 	A006_stmt    	= null;
Statement 	A007_stmt    	= null;
Statement 	A008_stmt    	= null;
Statement 	A010_stmt    	= null;
Statement 	A011_stmt    	= null;
Statement 	A012_stmt    	= null;

ResultSet 	A001_rs       	= null;
ResultSet 	A002_rs       	= null;
ResultSet 	A003_rs       	= null;
ResultSet 	A004_rs       	= null;
ResultSet 	A005_rs       	= null;
ResultSet 	A006_rs       	= null;
ResultSet 	A007_rs       	= null;
ResultSet 	A008_rs       	= null;
ResultSet 	A010_rs       	= null;
ResultSet 	A011_rs       	= null;
ResultSet 	A012_rs       	= null;

//*************************

ArrayList arr_fleet    	= new ArrayList();
ArrayList arr_empno 	= new ArrayList();
ArrayList arr_rank    	= new ArrayList();
ArrayList arr_cname 	= new ArrayList();
ArrayList arr_qualification_date = new ArrayList();

String A001_sql = null;
String A002_sql = null;
String A003_sql = null;
String A004_sql = null;
String A005_sql = null;
String A006_sql = null;
String A007_sql = null;
String A008_sql = null;
String A010_sql = null;
String A011_sql = null;
String A012_sql = null;


String fleet    = null;
String empno 	= null;
String rank    	= null;
String cname 	= null;
String Big5CName =  null;

String A001_qualification_date  = null;
String A002_qualification_date  = null;
String A003_qualification_date  = null;
String A004_qualification_date  = null;
String A005_qualification_date  = null;
String A006_qualification_date  = null;
String A007_qualification_date  = null;
String A008_qualification_date  = null;
String A010_qualification_date  = null;
String A011_qualification_date  = null;
String A012_qualification_date  = null;

int    A001_diff_date = 0;
int    A002_diff_date = 0;
int    A003_diff_date = 0;
int    A004_diff_date = 0;
int    A005_diff_date = 0;
int    A006_diff_date = 0;
int    A007_diff_date = 0;
int    A008_diff_date = 0;
int    A010_diff_date = 0;
int    A011_diff_date = 0;
int    A012_diff_date = 0;

//  ++++++++++++++++++ item 1   檢定證 +++++++++++++++++++++++++++++++++

try{
	//connect to AOCIPROD
	ConnDB A001_cn = new ConnDB();
	A001_cn.setORP3FZUserCP();
	A001_dbDriver = (Driver) Class.forName(A001_cn.getDriver()).newInstance();
	A001_conn = A001_dbDriver.connect(A001_cn.getConnURL(), null);
	A001_stmt = A001_conn.createStatement();       
	A001_sql = 	"SELECT								" + 
       	       	"	crew.fleet fleet,						" +
       		"	crew.empno empno,						" +
       		"	crew.occu rank,							" +
      		"	crew.name cname,						" +
       		" 	TO_CHAR(lic.exp_dt,'yyyy-mm-dd')  rat_date, 			" +     
		"       TO_DATE(TO_CHAR(lic.exp_dt,'yyyy-mm-dd'),'yyyy-mm-dd') - TO_DATE('"+str_check_date+"','yyyy-mm-dd')  diff_date  " +	
	        "FROM  	fzdb.crew_licence_v lic,					" +
      		"   	(SELECT * FROM dfdb.dftcrew					" + 
       	        "	 WHERE flag='Y' AND cabin='A' AND analysa='100') crew		" +
	        "WHERE  lic.staff_num(+)  = crew.empno					" + 
  	        "  AND 	lic.licence_cd(+) = 'RAT'					" + 
 	        "  AND  crew.empno ='"+sGetUsr+"'";

 	 //out.print(" A001_SQL= "+ A001_sql);	
      	 A001_rs = A001_stmt.executeQuery(A001_sql);

	if(A001_rs != null)
	{
		while(A001_rs.next())
		{
			//arr_fleet.add(A001_rs.getString("fleet"));
			//arr_empno.add(A001_rs.getString("empno"));
			//arr_rank.add(A001_rs.getString("rank"));
			//arr_qualification_date.add(A001_rs.getString("rat_date"));
			fleet 	= A001_rs.getString("fleet");			
			empno 	= A001_rs.getString("empno");			
			rank 	= A001_rs.getString("rank");
			cname	= A001_rs.getString("cname");
				
			A001_qualification_date = A001_rs.getString("rat_date");
			//out.println("qualification_date = " + A001_qualification_date);
 			A001_diff_date = A001_rs.getInt(6);			
		 	// out.println("diff_date = " + A001_diff_date); 
		}
	}
	A001_rs.close();
	A001_conn.close();
}
catch (Exception e){
	 	 out.println("A001 " + e.toString() + A001_sql);
                   }


//    ++++++++++++++++++++ item 3  體檢證+++++++++++++++++++
try {
	ConnDB A003_cn = new ConnDB();
	A003_cn.setORP3FZUserCP();
	A003_dbDriver = (Driver) Class.forName(A003_cn.getDriver()).newInstance();
	A003_conn = A003_dbDriver.connect(A003_cn.getConnURL(), null);
	A003_stmt = A003_conn.createStatement();       
	A003_sql = 	"SELECT								" + 
       	       	"	crew.fleet fleet,						" +
       		"	crew.empno empno,						" +
       		"	crew.occu rank,							" +
      		"	crew.name cname,						" +
       		" 	TO_CHAR(med.med_exp_dt,'yyyy-mm-dd')  med_date, 		" +     
		"       TO_DATE(TO_CHAR(med.med_exp_dt,'yyyy-mm-dd'),'yyyy-mm-dd') - TO_DATE('"+str_check_date+"','yyyy-mm-dd')  diff_date  " +	
	        "FROM  	fzdb.crew_medical_v med,					" +
      		"   	(SELECT * FROM dfdb.dftcrew					" + 
       	        "	 WHERE flag='Y' AND cabin='A' AND analysa='100') crew		" +
	        "WHERE  med.staff_num(+)  = crew.empno					" + 
  	        "  AND  crew.empno ='"+sGetUsr+"'";

 	 //out.print(" A003_SQL= "+ A003_sql);	
      	 A003_rs = A003_stmt.executeQuery(A003_sql);

	if(A003_rs != null)
	{
		while(A003_rs.next())
		{
			//fleet 	= A003_rs.getString("fleet");			
			//empno 	= A003_rs.getString("empno");			
			//rank 		= A003_rs.getString("rank");
			//cname		= A003_rs.getString("cname");
				
			A003_qualification_date = A003_rs.getString("med_date");
			//out.println("qualification_date = " + A003_qualification_date);
 			A003_diff_date = A003_rs.getInt(6);			
		 	// out.println("diff_date = " + A003_diff_date); 
		}
	}
	A003_rs.close();
	A003_conn.close();
}
catch (Exception e){
		 out.println("A003 " + e.toString() + A003_sql);
                   }

//    ++++++++++++++++++++ item 4  護照  +++++++++++++++++++
try {
	ConnDB A004_cn = new ConnDB();
	A004_cn.setORP3FZUserCP();
	A004_dbDriver = (Driver) Class.forName(A004_cn.getDriver()).newInstance();
	A004_conn = A004_dbDriver.connect(A004_cn.getConnURL(), null);
	A004_stmt = A004_conn.createStatement();       
	A004_sql = 	"SELECT								" + 
       	       	"	crew.fleet fleet,						" +
       		"	crew.empno empno,						" +
       		"	crew.occu rank,							" +
      		"	crew.name cname,						" +
       		" 	TO_CHAR(passport.exp_dt,'yyyy-mm-dd')  passport_exp_date, 		" +     
		"       TO_DATE(TO_CHAR(passport.exp_dt,'yyyy-mm-dd'),'yyyy-mm-dd') - TO_DATE('"+str_check_date+"','yyyy-mm-dd')  diff_date  " +	
	        "FROM  	fzdb.crew_passport_v passport,					" +
      		"   	(SELECT * FROM dfdb.dftcrew					" + 
       	        "	 WHERE flag='Y' AND cabin='A' AND analysa='100') crew		" +
	        "WHERE  passport.staff_num(+)  = crew.empno					" + 
  	        "  AND  crew.empno ='"+sGetUsr+"'";

 	 //out.print(" A004_SQL= "+ A004_sql);	
      	 A004_rs = A004_stmt.executeQuery(A004_sql);

	if(A004_rs != null)
	{
		while(A004_rs.next())
		{
			//fleet 		= A004_rs.getString("fleet");			
			//empno 		= A004_rs.getString("empno");			
			//rank 			= A004_rs.getString("rank");
			//cname			= A004_rs.getString("cname");
				
			A004_qualification_date = A004_rs.getString("passport_exp_date");
			//out.println("qualification_date = " + A004_qualification_date);
 			A004_diff_date = A004_rs.getInt(6);			
		 	// out.println("diff_date = " + A004_diff_date); 
		}
	}
	A004_rs.close();
	A004_conn.close();
}
catch (Exception e){
		 out.println("A004 " + e.toString() + A004_sql);
                   }

//  ++++++++++++++++++ item 5   台胞證 +++++++++++++++++++++++++++++++++

try{
	//connect to AOCIPROD
	ConnDB A005_cn = new ConnDB();
	A005_cn.setORP3FZUserCP();
	A005_dbDriver = (Driver) Class.forName(A005_cn.getDriver()).newInstance();
	A005_conn = A005_dbDriver.connect(A005_cn.getConnURL(), null);
	A005_stmt = A005_conn.createStatement();       
	A005_sql = 	"SELECT								" + 
       	       	"	crew.fleet fleet,						" +
       		"	crew.empno empno,						" +
       		"	crew.occu rank,							" +
      		"	crew.name cname,						" +
       		" 	TO_CHAR(lic.exp_dt,'yyyy-mm-dd')  rat_date, 			" +     
		"       TO_DATE(TO_CHAR(lic.exp_dt,'yyyy-mm-dd'),'yyyy-mm-dd') - TO_DATE('"+str_check_date+"','yyyy-mm-dd')  diff_date  " +	
	        "FROM  	fzdb.crew_licence_v lic,					" +
      		"   	(SELECT * FROM dfdb.dftcrew					" + 
       	        "	 WHERE flag='Y' AND cabin='A' AND analysa='100') crew		" +
	        "WHERE  lic.staff_num(+)  = crew.empno					" + 
  	        "  AND 	lic.licence_cd(+) = 'CHN'					" + 
 	        "  AND  crew.empno ='"+sGetUsr+"'";

 	 //out.print(" A005_SQL= "+ A005_sql);	
      	 A005_rs = A005_stmt.executeQuery(A005_sql);

	if(A005_rs != null)
	{
		while(A005_rs.next())
		{
			//fleet 	= A005_rs.getString("fleet");			
			//empno 	= A005_rs.getString("empno");			
			//rank 		= A005_rs.getString("rank");
			//cname		= A005_rs.getString("cname");
				
			A005_qualification_date = A005_rs.getString("rat_date");
			//out.println("qualification_date = " + A005_qualification_date);
 			A005_diff_date = A005_rs.getInt(6);			
		 	// out.println("diff_date = " + A005_diff_date); 
		}
	}
	A005_rs.close();
	A005_conn.close();
}
catch (Exception e){
	 	 out.println("A005 " + e.toString() + A005_sql);
                   }

//  ++++++++++++++++++ item 6   台胞證加簽 +++++++++++++++++++++++++++++++++

try{
	//connect to AOCIPROD
	ConnDB A006_cn = new ConnDB();
	A006_cn.setORP3FZUserCP();
	A006_dbDriver = (Driver) Class.forName(A006_cn.getDriver()).newInstance();
	A006_conn = A006_dbDriver.connect(A006_cn.getConnURL(), null);
	A006_stmt = A006_conn.createStatement();       
	A006_sql = 	"SELECT								" + 
       	       	"	crew.fleet fleet,						" +
       		"	crew.empno empno,						" +
       		"	crew.occu rank,							" +
      		"	crew.name cname,						" +
       		" 	TO_CHAR(visa.exp_dt,'yyyy-mm-dd')  rat_date, 			" +     
		"       TO_DATE(TO_CHAR(visa.exp_dt,'yyyy-mm-dd'),'yyyy-mm-dd') - TO_DATE('"+str_check_date+"','yyyy-mm-dd')  diff_date  " +	
	        "FROM  	fzdb.crew_visa_v visa,					" +
      		"   	(SELECT * FROM dfdb.dftcrew					" + 
       	        "	 WHERE flag='Y' AND cabin='A' AND analysa='100') crew		" +
	        "WHERE  visa.staff_num(+)  = crew.empno					" + 
  	        "  AND 	visa.visa_type(+) = 'CHN'					" + 
 	        "  AND  crew.empno ='"+sGetUsr+"'";

 	 //out.print(" A006_SQL= "+ A006_sql);	
      	 A006_rs = A006_stmt.executeQuery(A006_sql);

	if(A006_rs != null)
	{
		while(A006_rs.next())
		{
			//fleet 	= A006_rs.getString("fleet");			
			//empno 	= A006_rs.getString("empno");			
			//rank 	= A006_rs.getString("rank");
			//cname	= A006_rs.getString("cname");
				
			A006_qualification_date = A006_rs.getString("rat_date");
			//out.println("qualification_date = " + A006_qualification_date);
 			A006_diff_date = A006_rs.getInt(6);			
		 	// out.println("diff_date = " + A006_diff_date); 
		}
	}
	A006_rs.close();
	A006_conn.close();
}
catch (Exception e){
	 	 out.println("A006 " + e.toString() + A006_sql);
                   }

//  ++++++++++++++++++ item 7   US VISA +++++++++++++++++++++++++++++++++

try{
	//connect to AOCIPROD
	ConnDB A007_cn = new ConnDB();
	A007_cn.setORP3FZUserCP();
	A007_dbDriver = (Driver) Class.forName(A007_cn.getDriver()).newInstance();
	A007_conn = A007_dbDriver.connect(A007_cn.getConnURL(), null);
	A007_stmt = A007_conn.createStatement();       
	A007_sql = 	"SELECT								" + 
       	       	"	crew.fleet fleet,						" +
       		"	crew.empno empno,						" +
       		"	crew.occu rank,							" +
      		"	crew.name cname,						" +
       		" 	TO_CHAR(visa.exp_dt,'yyyy-mm-dd')  rat_date, 			" +     
		"       TO_DATE(TO_CHAR(visa.exp_dt,'yyyy-mm-dd'),'yyyy-mm-dd') - TO_DATE('"+str_check_date+"','yyyy-mm-dd')  diff_date  " +	
	        "FROM  	fzdb.crew_visa_v visa,					" +
      		"   	(SELECT * FROM dfdb.dftcrew					" + 
       	        "	 WHERE flag='Y' AND cabin='A' AND analysa='100') crew		" +
	        "WHERE  visa.staff_num(+)  = crew.empno					" + 
  	        "  AND 	visa.visa_type(+) = 'USD'					" + 
 	        "  AND  crew.empno ='"+sGetUsr+"'";

 	 //out.print(" A007_SQL= "+ A007_sql);	
      	 A007_rs = A007_stmt.executeQuery(A007_sql);

	if(A007_rs != null)
	{
		while(A007_rs.next())
		{
			//fleet 	= A007_rs.getString("fleet");			
			//empno 	= A007_rs.getString("empno");			
			//rank 	= A007_rs.getString("rank");
			//cname	= A007_rs.getString("cname");
				
			A007_qualification_date = A007_rs.getString("rat_date");
			//out.println("qualification_date = " + A007_qualification_date);
 			A007_diff_date = A007_rs.getInt(6);			
		 	// out.println("diff_date = " + A007_diff_date); 
		}
	}
	A007_rs.close();
	A007_conn.close();
}
catch (Exception e){
	 	 out.println("A007 " + e.toString() + A007_sql);
                   }


//  ++++++++++++++++++ item 8   SPAA +++++++++++++++++++++++++++++++++

try{
	//connect to AOCIPROD
	ConnDB A008_cn = new ConnDB();
	A008_cn.setORP3FZUserCP();
	A008_dbDriver = (Driver) Class.forName(A008_cn.getDriver()).newInstance();
	A008_conn = A008_dbDriver.connect(A008_cn.getConnURL(), null);
	A008_stmt = A008_conn.createStatement();       
	A008_sql = 	"SELECT								" + 
       	       	"	crew.fleet fleet,						" +
       		"	crew.empno empno,						" +
       		"	crew.occu rank,							" +
      		"	crew.name cname,						" +
       		" 	TO_CHAR(lic.exp_dt,'yyyy-mm-dd')  rat_date, 			" +     
		"       TO_DATE(TO_CHAR(lic.exp_dt,'yyyy-mm-dd'),'yyyy-mm-dd') - TO_DATE('"+str_check_date+"','yyyy-mm-dd')  diff_date  " +	
	        "FROM  	fzdb.crew_licence_v lic,					" +
      		"   	(SELECT * FROM dfdb.dftcrew					" + 
       	        "	 WHERE flag='Y' AND cabin='A' AND analysa='100') crew		" +
	        "WHERE  lic.staff_num(+)  = crew.empno					" + 
  	        "  AND 	lic.licence_cd(+) = 'FAA'					" + 
 	        "  AND  crew.empno ='"+sGetUsr+"'";

 	 //out.print(" A008_SQL= "+ A008_sql);	
      	 A008_rs = A008_stmt.executeQuery(A008_sql);

	if(A008_rs != null)
	{
		while(A008_rs.next())
		{
			//fleet 	= A008_rs.getString("fleet");			
			//empno 	= A008_rs.getString("empno");			
			//rank 		= A008_rs.getString("rank");
			//cname		= A008_rs.getString("cname");
				
			A008_qualification_date = A008_rs.getString("rat_date");
			//out.println("qualification_date = " + A008_qualification_date);
 			A008_diff_date = A008_rs.getInt(6);			
		 	// out.println("diff_date = " + A008_diff_date); 
		}
	}
	A008_rs.close();
	A008_conn.close();
}
catch (Exception e){
	 	 out.println("A008 " + e.toString() + A008_sql);
                   }
//  ++++++++++++++++++ item 10   LUX VISA +++++++++++++++++++++++++++++++++

try{
	//connect to AOCIPROD
	ConnDB A010_cn = new ConnDB();
	A010_cn.setORP3FZUserCP();
	A010_dbDriver = (Driver) Class.forName(A010_cn.getDriver()).newInstance();
	A010_conn = A010_dbDriver.connect(A010_cn.getConnURL(), null);
	A010_stmt = A010_conn.createStatement();       
	A010_sql = 	"SELECT								" + 
       	       	"	crew.fleet fleet,						" +
       		"	crew.empno empno,						" +
       		"	crew.occu rank,							" +
      		"	crew.name cname,						" +
       		" 	TO_CHAR(visa.exp_dt,'yyyy-mm-dd')  rat_date, 			" +     
		"       TO_DATE(TO_CHAR(visa.exp_dt,'yyyy-mm-dd'),'yyyy-mm-dd') - TO_DATE('"+str_check_date+"','yyyy-mm-dd')  diff_date  " +	
	        "FROM  	fzdb.crew_visa_v visa,					" +
      		"   	(SELECT * FROM dfdb.dftcrew					" + 
       	        "	 WHERE flag='Y' AND cabin='A' AND analysa='100') crew		" +
	        "WHERE  visa.staff_num(+)  = crew.empno					" + 
  	        "  AND 	visa.visa_type(+) = 'LUX'					" + 
 	        "  AND  crew.empno ='"+sGetUsr+"'";

 	 //out.print(" A010_SQL= "+ A010_sql);	
      	 A010_rs = A010_stmt.executeQuery(A010_sql);

	if(A010_rs != null)
	{
		while(A010_rs.next())
		{
			//fleet 	= A010_rs.getString("fleet");			
			//empno 	= A010_rs.getString("empno");			
			//rank 		= A010_rs.getString("rank");
			//cname		= A010_rs.getString("cname");
				
			A010_qualification_date = A010_rs.getString("rat_date");
			//out.println("qualification_date = " + A010_qualification_date);
 			A010_diff_date = A010_rs.getInt(6);			
		 	// out.println("diff_date = " + A010_diff_date); 
		}
	}
	A010_rs.close();
	A010_conn.close();
}
catch (Exception e){
	 	 out.println("A010 " + e.toString() + A010_sql);
                   }

//  ++++++++++++++++++ item 11   外籍居留證 +++++++++++++++++++++++++++++++++

try{
	//connect to AOCIPROD
	ConnDB A011_cn = new ConnDB();
	A011_cn.setORP3FZUserCP();
	A011_dbDriver = (Driver) Class.forName(A011_cn.getDriver()).newInstance();
	A011_conn = A011_dbDriver.connect(A011_cn.getConnURL(), null);
	A011_stmt = A011_conn.createStatement();       
	A011_sql = 	"SELECT								" + 
       	       	"	crew.fleet fleet,						" +
       		"	crew.empno empno,						" +
       		"	crew.occu rank,							" +
      		"	crew.name cname,						" +
       		" 	TO_CHAR(lic.exp_dt,'yyyy-mm-dd')  rat_date, 			" +     
		"       TO_DATE(TO_CHAR(lic.exp_dt,'yyyy-mm-dd'),'yyyy-mm-dd') - TO_DATE('"+str_check_date+"','yyyy-mm-dd')  diff_date  " +	
	        "FROM  	fzdb.crew_licence_v lic,					" +
      		"   	(SELECT * FROM dfdb.dftcrew					" + 
       	        "	 WHERE flag='Y' AND cabin='A' AND analysa='100') crew		" +
	        "WHERE  lic.staff_num(+)  = crew.empno					" + 
  	        "  AND 	lic.licence_cd(+) = 'ARC'					" + 
 	        "  AND  crew.empno ='"+sGetUsr+"'";

 	 //out.print(" A011_SQL= "+ A011_sql);	
      	 A011_rs = A011_stmt.executeQuery(A011_sql);

	if(A011_rs != null)
	{
		while(A011_rs.next())
		{
			//fleet 	= A011_rs.getString("fleet");			
			//empno 	= A011_rs.getString("empno");			
			//rank 		= A011_rs.getString("rank");
			//cname		= A011_rs.getString("cname");
				
			A011_qualification_date = A011_rs.getString("rat_date");
			//out.println("qualification_date = " + A011_qualification_date);
 			A011_diff_date = A011_rs.getInt(6);			
		 	// out.println("diff_date = " + A011_diff_date); 
		}
	}
	A011_rs.close();
	A011_conn.close();
}
catch (Exception e){
	 	 out.println("A011 " + e.toString() + A011_sql);
                   }
//  ++++++++++++++++++ item 12   空勤組員證 +++++++++++++++++++++++++++++++++

try{
	//connect to AOCIPROD
	ConnDB A012_cn = new ConnDB();
	A012_cn.setORP3FZUserCP();
	A012_dbDriver = (Driver) Class.forName(A012_cn.getDriver()).newInstance();
	A012_conn = A012_dbDriver.connect(A012_cn.getConnURL(), null);
	A012_stmt = A012_conn.createStatement();       
	A012_sql = 	"SELECT								" + 
       	       	"	crew.fleet fleet,						" +
       		"	crew.empno empno,						" +
       		"	crew.occu rank,							" +
      		"	crew.name cname,						" +
       		" 	TO_CHAR(lic.exp_dt,'yyyy-mm-dd')  rat_date, 			" +     
		"       TO_DATE(TO_CHAR(lic.exp_dt,'yyyy-mm-dd'),'yyyy-mm-dd') - TO_DATE('"+str_check_date+"','yyyy-mm-dd')  diff_date  " +	
	        "FROM  	fzdb.crew_licence_v lic,					" +
      		"   	(SELECT * FROM dfdb.dftcrew					" + 
       	        "	 WHERE flag='Y' AND cabin='A' AND analysa='100') crew		" +
	        "WHERE  lic.staff_num(+)  = crew.empno					" + 
  	        "  AND 	lic.licence_cd(+) = 'CMC'					" + 
 	        "  AND  crew.empno ='"+sGetUsr+"'";

 	 //out.print(" A012_SQL= "+ A012_sql);	
      	 A012_rs = A012_stmt.executeQuery(A012_sql);

	if(A012_rs != null)
	{
		while(A012_rs.next())
		{
			//fleet 	= A012_rs.getString("fleet");			
			//empno 	= A012_rs.getString("empno");			
			//rank 		= A012_rs.getString("rank");
			//cname		= A012_rs.getString("cname");
				
			A012_qualification_date = A012_rs.getString("rat_date");
			//out.println("qualification_date = " + A012_qualification_date);
 			A012_diff_date = A012_rs.getInt(6);			
		 	// out.println("diff_date = " + A012_diff_date); 
		}
	}
	A012_rs.close();
	A012_conn.close();
}
catch (Exception e){
	 	 out.println("A012 " + e.toString() + A012_sql);
                   }
%>

<div align="center" class="txttitle"><%=fleet%>  / <%=sGetUsr%> / <%=rank%> / <%=cname%></div>
<br>
<table width="90%"  border="1" align="center" cellpadding="0" cellspacing="0">
  <tr bgcolor="#00CCFF" class="tablehead" >
    	<td>Qualification</td>
	<td> Valid Date</td>	
  </tr>

  <tr class="tablebody">
	<td width = 300>CAA Rating Certificate</td>
	<td width = 200><div align="center"><% if (A001_diff_date > 0) out.println(A001_qualification_date); 
					else out.println(" <span style='color:red;'><b> Fail </b></span> "); %></div></td>  
  </tr>

  <tr class="tablebody">
	<td width = 300>CAA Medical Certificate</td>
	<td width = 200><div align="center"><% if (A003_diff_date > 0) out.println(A003_qualification_date); 
					else out.println(" <span style='color:red;'><b> Fail </b></span> "); %></div></td>  
  </tr>
 
  <tr class="tablebody">
	<td width = 300>Passport</td>
	<td width = 200><div align="center"><% if (A004_diff_date > 0) out.println(A004_qualification_date); 
					else out.println(" <span style='color:red;'><b> Fail </b></span> "); %></div></td>  
  </tr>

  <tr class="tablebody">
	<td width = 300>Mainland Travel Permits</td>
	<td width = 200><div align="center"><% if (A005_diff_date > 0) out.println(A005_qualification_date); 
					else out.println(" <span style='color:red;'><b> Fail </b></span> "); %></div></td>  
  </tr>

  <tr class="tablebody">
	<td width = 300>China Visa</td>
	<td width = 200><div align="center"><% if (A006_diff_date > 0) out.println(A006_qualification_date); 
					else out.println(" <span style='color:red;'><b> Fail </b></span> "); %></div></td>  
  </tr>

  <tr class="tablebody">
	<td width = 300>U.S. Visa</td>
	<td width = 200><div align="center"><% if (A007_diff_date > 0) out.println(A007_qualification_date); 
					else out.println(" <span style='color:red;'><b> Fail </b></span> "); %></div></td>  
  </tr>

  <tr class="tablebody">
	<td width = 300>FAA SPPA</td>
	<td width = 200><div align="center"><% if (A008_diff_date > 0) out.println(A008_qualification_date); 
					else out.println(" <span style='color:red;'><b> Fail </b></span> "); %></div></td>  
  </tr>

  <tr class="tablebody">
	<td width = 300>Schengen Visa</td>
	<td width = 200><div align="center"><% if (A010_diff_date > 0) out.println(A010_qualification_date); 
					else out.println(" <span style='color:red;'><b> Fail </b></span> "); %></div></td>  
  </tr>
<! //      ------------   item 11  -------------------  >
<% if (sGetUsr.substring(0,1).equals("3") || sGetUsr.substring(0,3).equals("486"))  
  out.println(" <tr class='tablebody'>	<td width = 300>Alien Resident Certificate</td><td width = 200><div align='center'>"); 
%>
<% if      (A011_diff_date >  0 && (sGetUsr.substring(0,1).equals("3") || sGetUsr.substring(0,3).equals("486")))  
     out.println(A011_qualification_date); 
   else if (A011_diff_date <= 0 && (sGetUsr.substring(0,1).equals("3") || sGetUsr.substring(0,3).equals("486")))
     out.println(" <span style='color:red;'><b> Fail </b></span> "); 
%>
<% if (sGetUsr.substring(0,1).equals("3") || sGetUsr.substring(0,3).equals("486"))  
  out.println(" </div></td>  </tr>"); 
%>

<! //      ------------   item 12  -------------------  >
<% if (sGetUsr.substring(0,1).equals("3") || sGetUsr.substring(0,3).equals("486"))  
  out.println(" <tr class='tablebody'>	<td width = 300>Crew Member Certificate</td><td width = 200><div align='center'>"); 
%>
<% if      (A012_diff_date >  0 && (sGetUsr.substring(0,1).equals("3") || sGetUsr.substring(0,3).equals("486")))  
     out.println(A012_qualification_date); 
   else if (A012_diff_date <= 0 && (sGetUsr.substring(0,1).equals("3") || sGetUsr.substring(0,3).equals("486")))
     out.println(" <span style='color:red;'><b> Fail </b></span> "); 
%>
<% if (sGetUsr.substring(0,1).equals("3") || sGetUsr.substring(0,3).equals("486"))  
  out.println(" </div></td>  </tr>"); 
%>
  
</table>
</body>
</html>
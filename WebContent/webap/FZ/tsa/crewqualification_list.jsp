<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*,java.sql.Date,fz.*,dz.eLearning.MSSQLConn"%>
<%

String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
/*response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);*/

if (session.isNew() | sGetUsr == null) 
{		
  response.sendRedirect("sendredirect.jsp");
} 


String fleet 		= request.getParameter("slt_FLEET");
String rank 		= request.getParameter("slt_RANK");
String empno 		= request.getParameter("slt_EMPNO");
String checkdate 	= request.getParameter("checkdate");
String qualification 	= request.getParameter("slt_QUALIFICATION") + "%";
String effective 	= request.getParameter("slt_EFFECTIVE");
String sSYSDATE 	= (String) session.getAttribute("sSYSDATE");

//out.println("slt_FLEET = "+fleet);
//out.println("slt_RANK = "+rank);
//out.println("slt_EMPNO = "+empno);
//out.println("checkdate = "+checkdate);
//out.println("slt_QUALIFICATION = "+qualification);
//out.println("slt_EFFECTIVE = "+effective);
//out.println("sSYSDATE = "+sSYSDATE+".");

Connection conn = null;
 
PreparedStatement pstmt_insert = null;
PreparedStatement pstmt_insert_p2 = null;
PreparedStatement pstmt_insert_fm_mssql = null;
PreparedStatement pstmt_insert_fm_mssql_TRMS = null;
PreparedStatement pstmt_query  = null;
PreparedStatement pstmt_delete = null;
ResultSet rs = null;
String sql_insert = null;
String sql_insert_p2 = null;
String sql_insert_fm_mssql = null;
String sql_insert_fm_mssql_TRMS = null;
String sql_query  = null;
String sql_delete  = null;
String str_sql_where_fleet = null;
String str_sql_where_rank  = null;
ci.db.ConnDB cn = new ci.db.ConnDB();
int i_insert_count = 0;
int i_insert_count_p2 = 0;
int i_insert_fm_mssql_count = 0;
int i_insert_fm_mssql_count_TRMS = 0;
int i_delete_count = 0;

Connection 	MSSQL_conn 	= null;
Statement 	MSSQL_stmt 	= null;
ResultSet 	MSSQL_rs 	= null;
String 		MSSQL_sql 	= "";

Connection 	MSSQL_conn_TRMS	= null;
Statement 	MSSQL_stmt_TRMS	= null;
ResultSet 	MSSQL_rs_TRMS 	= null;
String 		MSSQL_sql_TRMS 	= "";

Driver dbDriver = null;

ArrayList fleetAL 	= new ArrayList();
ArrayList rankAL  	= new ArrayList();
ArrayList empnoAL 	= new ArrayList();
ArrayList cnameAL 	= new ArrayList();
ArrayList exp_dtAL	= new ArrayList();
ArrayList qualAL	= new ArrayList();
ArrayList effectiveAL	= new ArrayList();

if (fleet.equals("%")) { str_sql_where_fleet = " OR fleet is NULL";}
else { str_sql_where_fleet = "";}
//out.println("str_sql_where_fleet = "+str_sql_where_fleet);

if (rank.equals("%")) { str_sql_where_rank = " OR rank is NULL";}
else { str_sql_where_rank = "";}
//out.println("str_sql_where_rank = "+str_sql_where_rank);

try {
  // ====================================================================================================
  
  cn.setORP3FZUserCP();
  dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
  conn = dbDriver.connect(cn.getConnURL(), null); 

  // =====================================================================================================
  
  MSSQLConn MSSQL_db = new MSSQLConn();
  MSSQL_db.setELEARNING(); 
  Class.forName(MSSQL_db.getDriver());
  MSSQL_conn = DriverManager.getConnection(MSSQL_db.getConnURL(),MSSQL_db.getConnID(),MSSQL_db.getConnPW());
  MSSQL_stmt = MSSQL_conn.createStatement();
  MSSQL_sql = "SELECT userid,CONVERT(varchar(10), MAX(dateon), 111) AS exp_date,'A014'   AS qual FROM LMS_for_OZ_View_LMS_Record_In_3 WHERE  (course LIKE '% CRM Recurrent %')   AND (result <> 0)  group by userid " +
    "	UNION  SELECT userid,CONVERT(varchar(10), MAX(dateon), 111) AS exp_date,'A015'   AS qual FROM LMS_for_OZ_View_LMS_Record_In_3 WHERE  (course LIKE '% SS Training%' OR course LIKE '% Aviation Security%')  AND (result <> 0)  group by userid " +
    "	UNION  SELECT userid,CONVERT(varchar(10), MAX(dateon), 111) AS exp_date,'A016'   AS qual FROM LMS_for_OZ_View_LMS_Record_In_3 WHERE  (course LIKE '%SEP%Recurrent%')     AND (result <> 0)  group by userid " +
    "	UNION  SELECT userid,CONVERT(varchar(10), MAX(dateon), 111) AS exp_date,'A017'   AS qual FROM LMS_for_OZ_View_LMS_Record_In_3 WHERE  (course LIKE '%DG EXAM%')           AND (result <> 0)  group by userid " +
    "	UNION  SELECT userid,CONVERT(varchar(10), MAX(dateoff),111) AS exp_date,'A018'   AS qual FROM LMS_for_OZ_View_LMS_Record_In_3 WHERE  (course LIKE '%Recurrent CBT%' AND course LIKE '%2nd half%' ) AND (result <> 0)  group by userid " +
    "	UNION  SELECT userid,CONVERT(varchar(10), MAX(dateon), 111) AS exp_date,'A026'   AS qual FROM LMS_for_OZ_View_LMS_Record_In_3 WHERE  (course LIKE '%Recurrent CBT%' AND course LIKE '%1st half%' ) AND (result <> 0)  group by userid " +
    "	UNION  SELECT userid,CONVERT(varchar(10), MAX(dateoff),111) AS exp_date,'A027-1' AS qual FROM LMS_for_OZ_View_LMS_Record_In_3 WHERE  (course LIKE '%Recurrent CBT%' AND course LIKE '%2nd half%' ) AND (result <> 0)  group by userid " +
    "	UNION  SELECT userid,CONVERT(varchar(10), MAX(dateoff),111) AS exp_date,'A028-1' AS qual FROM LMS_for_OZ_View_LMS_Record_In_3 WHERE  (course LIKE '%Recurrent CBT%' AND course LIKE '%1st half%' ) AND (result <> 0)  group by userid ";


  //out.println("MSSQL_sql = " + MSSQL_sql);

    MSSQL_rs = MSSQL_stmt.executeQuery(MSSQL_sql);

 	   while (MSSQL_rs.next()) 
 	    {
 		sql_insert_fm_mssql = " INSERT INTO fztlicms_temp (empno,exp_date,qual) VALUES('" + MSSQL_rs.getString("userid") + "',TO_DATE('" + MSSQL_rs.getString("exp_date") + "','YYYY/MM/DD'),'" + MSSQL_rs.getString("qual") + "') ";
		
		// out.println("sql_insert_fm_mssql = " + sql_insert_fm_mssql);
	
 		pstmt_insert_fm_mssql = conn.prepareStatement(sql_insert_fm_mssql);		
 		i_insert_fm_mssql_count = pstmt_insert_fm_mssql.executeUpdate();
		pstmt_insert_fm_mssql.close();

      		//out.println("i_insert_fm_mssql_fm_mssql_count = "+i_insert_fm_mssql_count);
 	     }

  // ========================================================================================================
  
  MSSQLConn MSSQL_db_TRMS = new MSSQLConn();
  MSSQL_db_TRMS.setELEARNING_TRMS(); 
  Class.forName(MSSQL_db_TRMS.getDriver());
  MSSQL_conn_TRMS = DriverManager.getConnection(MSSQL_db_TRMS.getConnURL(),MSSQL_db_TRMS.getConnID(),MSSQL_db_TRMS.getConnPW());
  MSSQL_stmt_TRMS = MSSQL_conn_TRMS.createStatement();
  MSSQL_sql_TRMS = "SELECT userid,CONVERT(varchar(10), MAX(TrainingEnd), 111)   AS exp_date,'A014' AS qual FROM XT_TRMS_RESUME WHERE (PackageName LIKE '%Requa%')  GROUP BY UserID " +
        "    UNION  SELECT userid,CONVERT(varchar(10), MAX(TrainingEnd), 111)   AS exp_date,'A015' AS qual FROM XT_TRMS_RESUME WHERE (PackageName LIKE '%Requa%')  GROUP BY UserID " +
	"    UNION  SELECT userid,CONVERT(varchar(10), MAX(TrainingEnd), 111)   AS exp_date,'A016' AS qual FROM XT_TRMS_RESUME WHERE (PackageName LIKE '%Requa%')  GROUP BY UserID " +
	"    UNION  SELECT userid,CONVERT(varchar(10), MAX(TrainingEnd), 111)   AS exp_date,'A017' AS qual FROM XT_TRMS_RESUME WHERE (PackageName LIKE '%Requa%')  GROUP BY UserID " +
	"    UNION  SELECT userid,CONVERT(varchar(10), MAX(TrainingEnd), 111)   AS exp_date,'A018' AS qual FROM XT_TRMS_RESUME WHERE (PackageName LIKE '%Requa%')  GROUP BY UserID " +
	"    UNION  SELECT userid,CONVERT(varchar(10), MAX(TrainingEnd), 111)   AS exp_date,'A021' AS qual FROM XT_TRMS_RESUME WHERE (PackageName LIKE '%Requa%')  GROUP BY UserID " +
 	"    UNION  SELECT userid,CONVERT(varchar(10), MAX(TrainingStart), 111) AS exp_date,'A021' AS qual FROM XT_TRMS_RESUME WHERE (PackageName LIKE '%PT%') AND (Result = 'Complete') GROUP BY UserID " +
	"    UNION  SELECT userid,CONVERT(varchar(10), MAX(TrainingEnd), 111)   AS exp_date,'A022' AS qual FROM XT_TRMS_RESUME WHERE (PackageName LIKE '%Requa%')  GROUP BY UserID " +
	"    UNION  SELECT userid,CONVERT(varchar(10), MAX(TrainingEnd), 111)   AS exp_date,'A026' AS qual FROM XT_TRMS_RESUME WHERE (PackageName LIKE '%Requa%')  GROUP BY UserID " +
   	"    UNION  SELECT userid,CONVERT(varchar(10), MAX(TrainingEnd), 111)   AS exp_date,'A028-1' AS qual FROM XT_TRMS_RESUME WHERE (PackageName LIKE '%Requa%')  GROUP BY UserID " +
	"    UNION  SELECT userid,CONVERT(varchar(10), MAX(TrainingEnd), 111)   AS exp_date,'A028-2' AS qual FROM XT_TRMS_RESUME WHERE (PackageName LIKE '%Requa%')  GROUP BY UserID " +
	"    UNION  SELECT userid,CONVERT(varchar(10), MAX(TrainingEnd), 111)   AS exp_date,'A029' AS qual FROM XT_TRMS_RESUME WHERE (PackageName LIKE '%Requa%')  GROUP BY UserID " +		  
 	"    UNION  SELECT userid,CONVERT(varchar(10), MAX(TrainingStart), 111) AS exp_date,'A029' AS qual FROM XT_TRMS_RESUME WHERE (PackageName LIKE '%PT4%')    GROUP BY UserID ";
    
  //out.println("MSSQL_sql_TRMS = " + MSSQL_sql_TRMS);

    MSSQL_rs_TRMS = MSSQL_stmt_TRMS.executeQuery(MSSQL_sql_TRMS);

 	   while (MSSQL_rs_TRMS.next()) 
 	    {
 		sql_insert_fm_mssql_TRMS = " INSERT INTO fztlicms_temp (empno,exp_date,qual) VALUES('" + MSSQL_rs_TRMS.getString("userid") + "',TO_DATE('" + MSSQL_rs_TRMS.getString("exp_date") + "','YYYY/MM/DD'),'" + MSSQL_rs_TRMS.getString("qual") + "') ";
		
		// out.println("sql_insert_fm_mssql_TRMS = " + sql_insert_fm_mssql_TRMS);
	
 		pstmt_insert_fm_mssql_TRMS = conn.prepareStatement(sql_insert_fm_mssql_TRMS);		
 		i_insert_fm_mssql_count_TRMS = pstmt_insert_fm_mssql_TRMS.executeUpdate();
		pstmt_insert_fm_mssql_TRMS.close();

      		//out.println("i_insert_fm_mssql_fm_mssql_count_TRMS = "+i_insert_fm_mssql_count_TRMS);
 	     }
  // =======================================================================================================
  // insert temp table start
  sql_insert =	"                        						" +     // A001 檢定證   
	"	INSERT INTO fztlicchk_temp (fleet,rank,empno,cname,exp_dt,takeoff,landing,qual)  	" +
	"	(   									" +
	"	SELECT 	crew.fleet fleet,  						" +
       	"		crew.occu  rank, 						" +
       	"		crew.empno empno,  						" +
       	"		crew.name  cname,  						" +
       	"		TRUNC(lic.exp_dt, 'DDD') exp_date,  				" +
	"               0 takeoff,							" +
	"               0 landing,							" +
       	"		'A001' qual      						" +   
  	"	FROM 	fzdb.crew_licence_v lic,  					" +
       	"	     	(SELECT *  							" +
        " 	 	   FROM dfdb.dftcrew  						" +
        " 	          WHERE flag    = 'Y'  						" +
        "   		    AND cabin   = 'A'  						" +
        "   		    AND analysa = '100') crew  					" +
 	"	WHERE 	lic.staff_num(+) = crew.empno  					" +
   	"	AND lic.licence_cd(+)    = 'RAT'  					" +
	"	UNION      								" +    // A002  英檢加簽
	"	SELECT 	crew.fleet fleet,  						" +
       	"		crew.occu  rank, 						" +
       	"		crew.empno empno,  						" +
       	"		crew.name  cname,  						" +
       	"		TRUNC(lic.exp_dt, 'DDD') exp_date,  				" +
	"               0 takeoff,							" +
	"               0 landing,							" +
       	"		'A002' qual      						" +   
  	"	FROM 	fzdb.crew_licence_v lic,  					" +
       	"	     	(SELECT *  							" +
        " 	 	   FROM dfdb.dftcrew  						" +
        " 	          WHERE flag    = 'Y'  						" +
        "   		    AND cabin   = 'A'  						" +
        "   		    AND analysa = '100') crew  					" +
 	"	WHERE 	lic.staff_num(+) = crew.empno  					" +
   	"	AND lic.licence_cd(+)    = 'ENG'  					" +
	"	UNION      								" +    // A003  體檢證(MED)
	"	SELECT  crew.fleet fleet,						" +
	"		crew.occu  rank,  						" +
       	"		crew.empno empno, 						" +       
       	"		crew.name  cname,						" +
       	"		TRUNC(med.med_exp_dt,'DDD') exp_date,				" +
	"               0 takeoff,							" +
	"               0 landing,							" +
       	"		'A003' qual         						" +
  	"	FROM fzdb.crew_medical_v med,						" +
        "       	(SELECT * 							" +
       	"		   FROM dfdb.dftcrew  						" +
        "    		  WHERE flag = 'Y'  						" +
       	"		    AND cabin = 'A' 						" +
       	"		    AND analysa = '100') crew 					" +
        "  	WHERE med.staff_num(+) = crew.empno  					" + 
	"	UNION      								" +    // A004  護照(PPT)
	"	SELECT 	crew.fleet fleet,						" +
	"	       	crew.occu  rank,  						" +
       	"	       	crew.empno empno, 						" +
       	"	       	crew.name  cname,						" +
       	"	      	TRUNC(passport.exp_dt, 'DDD')  exp_date,			" +
	"               0 takeoff,							" +
	"               0 landing,							" +
       	"	       	'A004' qual         						" +
  	"	 FROM  	fzdb.crew_passport_v passport,					" +
        "       	(SELECT *							" +
       	"		   FROM dfdb.dftcrew						" +
        "    		  WHERE flag = 'Y'  						" +
       	"		    AND cabin = 'A' 						" +
       	"		    AND analysa = '100') crew 					" +
        "  	 WHERE passport.staff_num(+) = crew.empno				" +
	"	UNION      								" +    // A005  台胞證(CHN)
	"	SELECT 	crew.fleet fleet,						" +
	"	       	crew.occu  rank,  						" +
       	"	       	crew.empno empno, 						" +
       	"	       	crew.name  cname,						" +
       	"	      	TRUNC(lic.exp_dt,'DDD') exp_date,				" +
	"               0 takeoff,							" +
	"               0 landing,							" +
       	"	       	'A005' qual         						" +
  	"	  FROM 	fzdb.crew_licence_v lic,					" +
        "       	(SELECT *							" +
       	"		   FROM dfdb.dftcrew						" +
        "    		  WHERE flag = 'Y'  						" +
       	"		    AND cabin = 'A' 						" +
       	"		    AND analysa = '100'    					" +
       	"		    AND SUBSTR(empno,1,1) = '6') crew 				" +
        "  	 WHERE lic.staff_num(+) = crew.empno					" +
        "  	   AND lic.licence_cd(+) = 'CHN'					" +
	"	UNION      								" +    // A006  台胞證加簽 (CN)
	"	SELECT 	crew.fleet fleet,						" +
	"	       	crew.occu  rank,  						" +
       	"	       	crew.empno empno, 						" +
       	"	       	crew.name  cname,						" +
       	"	      	 TRUNC(visa.exp_dt, 'DDD') exp_date,				" +
	"               0 takeoff,							" +
	"               0 landing,							" +
       	"	       	'A006' qual         						" +
  	"	  FROM fzdb.crew_visa_v visa,						" +
        "       	(SELECT *							" +
       	"		   FROM dfdb.dftcrew						" +
        "    		  WHERE flag = 'Y'  						" +
       	"		    AND cabin = 'A' 						" +
       	"		    AND analysa = '100' 					" +
       	"		    AND SUBSTR(empno,1,1) = '6') crew 				" +
        "  	WHERE visa.staff_num(+) = crew.empno					" +
        "  	    AND visa.visa_type(+) = 'CHN'					" +
	"	UNION      								" +    // A007  US VISA(USD)
	"	SELECT 	crew.fleet fleet,						" +
	"	       	crew.occu  rank,  						" +
       	"	       	crew.empno empno, 						" +
       	"	       	crew.name  cname,						" +
       	"	      	TRUNC(visa.exp_dt, 'DDD') exp_date,				" +
	"               0 takeoff,							" +
	"               0 landing,							" +
       	"	       	'A007' qual         						" +
  	"	  FROM fzdb.crew_visa_v visa,						" +
        "       	(SELECT *							" +
       	"		   FROM dfdb.dftcrew						" +
        "    		  WHERE flag = 'Y'  						" +
       	"		    AND cabin = 'A' 						" +
       	"		    AND analysa = '100') crew 					" +
        "  	WHERE visa.staff_num(+) = crew.empno					" +
        "  	     AND visa.visa_type(+) = 'USD'					" +
	"	UNION      								" +    // A008  SPPA (FAA)
	"	SELECT 	crew.fleet fleet,						" +
	"	       	crew.occu  rank,  						" +
       	"	       	crew.empno empno, 						" +
       	"	       	crew.name  cname,						" +
       	"	      	TRUNC(lic.exp_dt, 'DDD') exp_date,				" +
	"               0 takeoff,							" +
	"               0 landing,							" +
       	"	       	'A008' qual         						" +
  	"	   FROM fzdb.crew_licence_v lic,					" +
        "       	(SELECT *							" +
       	"		   FROM dfdb.dftcrew						" +
        "    		  WHERE flag = 'Y'  						" +
       	"		    AND cabin = 'A' 						" +
       	"		    AND analysa = '100' 					" +
       	"		    AND fleet = '744') crew 					" +
        "  	WHERE lic.staff_num(+) = crew.empno					" +
        "  	  AND lic.licence_cd(+) = 'FAA'						" +
	"	UNION      								" +    // A009  China VISA (for EXP)(CHN)
	"	SELECT 	crew.fleet fleet,						" +
	"	       	crew.occu  rank,  						" +
       	"	       	crew.empno empno, 						" +
       	"	       	crew.name  cname,						" +
       	"	      	TRUNC(lic.exp_dt,'DDD') exp_date,				" +
	"               0 takeoff,							" +
	"               0 landing,							" +
       	"	       	'A009' qual         						" +
  	"	  FROM 	fzdb.crew_licence_v lic,					" +
        "       	(SELECT *							" +
       	"		   FROM dfdb.dftcrew						" +
        "    		  WHERE flag = 'Y'  						" +
       	"		    AND cabin = 'A' 						" +
       	"		    AND analysa = '100' 					" +
      	"		    AND fleet IN ('744') 					" +
	"                   AND (substr(empno,1,1) = '3' OR substr(empno,1,3) = '486')) crew   " +
        "  	 WHERE lic.staff_num(+) = crew.empno					" +
        "  	   AND lic.licence_cd(+) = 'CN'						" +
	"	UNION      								" +    // A010  LUX VISA(for EXP)(LU)
	"	SELECT 	crew.fleet fleet,						" +
	"	       	crew.occu  rank,  						" +
       	"	       	crew.empno empno, 						" +
       	"	       	crew.name  cname,						" +
       	"	      	TRUNC(visa.exp_dt, 'DDD') exp_date,				" +
	"               0 takeoff,							" +
	"               0 landing,							" +
       	"	       	'A010' qual         						" +
  	"	   FROM fzdb.crew_visa_v visa,						" +
        "       	(SELECT *							" +
       	"		   FROM dfdb.dftcrew						" +
        "    		  WHERE flag = 'Y'  						" +
       	"		    AND cabin = 'A' 						" +
       	"		    AND analysa = '100' 					" +
      	"		    AND fleet IN ('744') 					" +
	"                   AND (substr(empno,1,1) = '3' OR substr(empno,1,3) = '486')) crew   " +
        "  	WHERE visa.staff_num(+) = crew.empno					" +
        "  	 AND  visa.visa_type(+) = 'LUX'						" +
	"	UNION      								" +    // A011  外籍居留證(ARC)
	"	SELECT 	crew.fleet fleet,						" +
	"	       	crew.occu  rank,  						" +
       	"	       	crew.empno empno, 						" +
       	"	       	crew.name  cname,						" +
       	"	      	TRUNC(lic.exp_dt, 'DDD') exp_date,				" +
	"               0 takeoff,							" +
	"               0 landing,							" +
       	"	       	'A011' qual         						" +
  	"	  FROM 	fzdb.crew_licence_v lic,					" +
        "       	(SELECT *							" +
       	"		   FROM dfdb.dftcrew						" +
        "    		  WHERE flag = 'Y'  						" +
       	"		    AND cabin = 'A' 						" +
       	"		    AND analysa = '100' 					" +
	"                   AND (substr(empno,1,1) = '3' OR substr(empno,1,3) = '486')) crew   " +
        "  	WHERE lic.staff_num(+) = crew.empno					" +
        "  	  AND lic.licence_cd(+) = 'ARC'						" +
	"	UNION      								" +    // A012 空勤組員證(CMC)
	"	SELECT 	crew.fleet fleet,						" +
	"	       	crew.occu  rank,  						" +
       	"	       	crew.empno empno, 						" +
       	"	       	crew.name  cname,						" +
       	"	      	TRUNC(lic.exp_dt, 'DDD') exp_date,				" +
	"               0 takeoff,							" +
	"               0 landing,							" +
       	"	       	'A012' qual         						" +
  	"	 FROM 	fzdb.crew_licence_v lic,					" +
        "       	(SELECT *							" +
       	"		   FROM dfdb.dftcrew						" +
        "    		  WHERE flag = 'Y'  						" +
       	"		    AND cabin = 'A' 						" +
       	"		    AND analysa = '100' 					" +
	"                   AND (substr(empno,1,1) = '3' OR substr(empno,1,3) = '486')) crew   " +
        "  	 WHERE lic.staff_num(+) = crew.empno					" +
        "  	   AND lic.licence_cd(+) = 'CMC'					" +
	"  	    							" +  // 放在 A025 內   A013-1 Recency (45/FLT)
	"	UNION      								" +    // A013-2 Recency (90/TO&LD)
	"       SELECT 	crew.fleet fleet, 						" +
       	"		crew.occu  rank, 						" +
       	"		crew.empno empno, 						" +
       	"		crew.name  cname, 						" +
       	"		TRUNC(SYSDATE,'DDD') exp_date, 					" +
       	"		NVL(SUM(flog.takeoff),0) takeoff, 				" +
       	"		NVL(SUM(flog.landing),0) landing, 				" +
       	"		'A013-2' qual  							" +
	"	FROM   ((SELECT  c.empno empno,SUM(nvl(c.today,0))+SUM(nvl(c.tonit,0)) takeoff, 	" +
        "			SUM(nvl(c.ldday,0))+SUM(nvl(c.ldnit,0)) landing 	" +
        "		FROM 	dfdb.dftlogc c, dfdb.dftlogf f 				" +
        "		WHERE 	f.logno = c.logno 					" +
        "		  AND 	TO_DATE(f.year || f.mon || f.dd,'YYYYMMDD') 		" +
        "			BETWEEN TRUNC(TO_DATE('" +checkdate+ "','YYYY-MM-DD') - 90,'DDD') " + 
        "			   AND  TRUNC(TO_DATE('" +checkdate+ "','YYYY-MM-DD'),'DDD') 	  " +
        "		  AND 	f.flag = '3' 						" +
        "		  AND 	f.year >= '2011' 					" +
        "		GROUP BY c.empno)  	 					" +
        "	UNION ALL								" +
        " 	(SELECT crew_rf.empno,(sim.cnt * 2) takeoff,(sim.cnt * 2) landing	" + 
        "  	 FROM  									" + 
        "  	        ( 								" +  
        "  		 SELECT r.staff_num  empno,					" +
        "         	   	COUNT(TO_CHAR(dps.str_dt_tm_loc, 'yyyy/mm/dd')) cnt 	" +
        "    		 FROM   duty_prd_seg_v dps, roster_v r  			" +    
        "   		 WHERE 	dps.series_num = r.series_num 				" +
        "     		   AND 	dps.delete_ind = 'N' 					" +
        "     		   AND 	r.delete_ind = 'N' 					" +
        "     		   AND 	dps.act_str_dt_tm_gmt  BETWEEN TRUNC(TO_DATE('" +checkdate+ "','YYYY-MM-DD') - 90,'DDD') " + 
        "                                                  AND TRUNC(TO_DATE('" +checkdate+ "','YYYY-MM-DD'),'DDD') 	" +
        "     		   AND 	r.roster_num IN (SELECT rostrg.roster_num 		" +
        "                           		 FROM 	roster_special_duties_trg_v rostrg, training_codes_v trgcd   " +
        "                          		 WHERE  rostrg.trg_cd = trgcd.trg_cd 	" +
        "                            		   AND 	trgcd.trg_cd_desc 		" +
        "                                		IN ('SIM PC', 			" +
        "                                    		    'SIM PT', 			" +
        "                                    		    'RE SIM PC', 		" +
        "                                    	            'RE SIM PT', 		" +
        "                                    		    'SIM PRACTICE', 		" +
        "                                    		    'SUPPORT SIM')) 		" +                            
        "    		   AND dps.duty_cd LIKE '%SIM%'  				" +  
        "  		   GROUP BY   r.staff_num  					" +
        "  		 )   sim, 							" +
        "   		(SELECT  empno 							" +
        "                  FROM  dftcrew 						" +
        "                 WHERE  flag = 'Y' 						" +
        "                   AND  cabin = 'A' 						" +
        "                   AND  analysa = '100' 					" +
        "                   AND  occu IN ('RP','FO'))  crew_rf 				" +
        "  	WHERE   								" +                    
        "    		sim.empno(+) = crew_rf.empno  					" +                                
        "       )) flog,								" +
        "	      (SELECT 	* 							" +
        "		 FROM 	dfdb.dftcrew 						" +
        "		WHERE 	flag  = 'Y' 						" +
        "		  AND 	cabin = 'A' 						" +
        "		  AND 	analysa = '100') crew 					" +
	"	WHERE flog.empno(+) = crew.empno  					" +
	"	GROUP BY crew.fleet,crew.occu,crew.empno,crew.name			" +
	"	UNION      								" +    // A014 CRM
	"	SELECT 	crew.fleet fleet, 						" +
	"       	crew.occu  rank, 						" +
	"       	crew.empno empno, 						" +
	"       	crew.name  cname, 						" +
	"       	elearning.exp_date exp_date, 					" +
	"               0 	   takeoff,						" +
	"               0 	   landing,						" +
	"       	'A014'     qual 						" +
 	"	FROM (SELECT  empno,MAX(exp_date) exp_date 				" +
        "	      FROM   (  							" +
        "      		      SELECT  empno,exp_date,qual 				" +
        "      		      FROM    fzdb.fztlicms_temp 				" +
        "      		      WHERE   qual = 'A014' 					" +
        "       	      UNION ALL    						" +
        "      		      SELECT  empno,cdate exp_date,'A014' qual  		" +
        "      		      FROM    dztsimr   					" +
        "      		      WHERE   chktype IN  					" +
        "                   	     (SELECT itemnO FROM dztchks  			" +
        "                   	      WHERE  itemname = 'TYPE RATING')  		" +
 //     "                   	         OR  SUBSTR(itemname,1,3) = 'PC-') 		" +
        "      			AND    s11 = 'S'   					" +        
        "    		     )								" +
        "	GROUP BY empno) elearning, 						" +
	"       	(SELECT * 							" +
	"          	 FROM 	dfdb.dftcrew 						" +
	"         	 WHERE 	flag  = 'Y' 						" +
	"           	   AND 	cabin = 'A' 						" +
	"           	   AND 	analysa = '100') crew 					" +
	" 	WHERE 	elearning.empno(+) = crew.empno 				" +
	"	UNION      								" +    // A015 Security Training(SS)
	"	SELECT 	crew.fleet fleet, 						" +
	"       	crew.occu  rank, 						" +
	"       	crew.empno empno, 						" +
	"       	crew.name  cname, 						" +
	"       	elearning.exp_date exp_date, 					" +
	"       	0 	   takeoff, 						" +
	"       	0 	   landing, 						" +
	"       	'A015'     qual 						" +
 	"	FROM (SELECT  empno,MAX(exp_date) exp_date 				" +
        "	      FROM   (  							" +
        "      		      SELECT  empno,exp_date,qual 				" +
        "      		      FROM    fzdb.fztlicms_temp 				" +
        "      		      WHERE   qual = 'A015' 					" +
        "       	      UNION ALL    						" +
        "      		      SELECT  empno,cdate exp_date,'A015' qual  		" +
        "      		      FROM    dztsimr   					" +
        "      		      WHERE   chktype IN  					" +
        "                   	     (SELECT itemnO FROM dztchks  			" +
        "                   	      WHERE  itemname = 'TYPE RATING') 			" +
 //     "                   	         OR  SUBSTR(itemname,1,3) = 'PC-') 		" +
        "      			AND    s11 = 'S'   					" +        
        "    		     )								" +
        "	GROUP BY empno) elearning, 						" +
	"       	(SELECT * 							" +
	"          	 FROM 	dfdb.dftcrew 						" +
	"         	 WHERE 	flag  = 'Y' 						" +
	"            	   AND  cabin = 'A' 						" +
	"           	   AND  analysa = '100') crew 					" +
	" 	WHERE elearning.empno(+) = crew.empno 					" +
	"	UNION      								" +    // A016 Energency Training(ET)
	"	SELECT 	crew.fleet fleet, 						" +
	"       	crew.occu  rank, 						" +
	"       	crew.empno empno, 						" +
	"       	crew.name  cname, 						" +
	"       	ADD_MONTHS(elearning.exp_date,16) exp_date, 			" +
	"       	0 	   takeoff, 						" +
	"       	0 	   landing, 						" +
	"       	'A016'     qual 						" +
 	"	FROM (SELECT  empno,MAX(exp_date) exp_date 				" +
        "	      FROM   (  							" +
        "      		      SELECT  empno,exp_date,qual 				" +
        "      		      FROM    fzdb.fztlicms_temp 				" +
        "      		      WHERE   qual = 'A016' 					" +
        "       	      UNION ALL    						" +
        "      		      SELECT  empno,cdate exp_date,'A016' qual  		" +
        "      		      FROM    dztsimr   					" +
        "      		      WHERE   chktype IN  					" +
        "                   	     (SELECT itemnO FROM dztchks  			" +
        "                   	      WHERE  itemname = 'TYPE RATING') 			" +
 //     "                   	         OR  SUBSTR(itemname,1,3) = 'PC-') 		" +
        "      			AND    s11 = 'S'   					" +        
        "    		     )								" +
        "	GROUP BY empno) elearning, 						" +
	"       	(SELECT * 							" +
	"          	 FROM 	dfdb.dftcrew 						" +
	"         	 WHERE 	flag  = 'Y' 						" +
	"            	   AND  cabin = 'A' 						" +
	"           	   AND  analysa = '100') crew 					" +
	" 	WHERE elearning.empno(+) = crew.empno 					" +
	"	UNION      								" +    // A017 Dangerous Goods(DG)
	"	SELECT 	crew.fleet fleet, 						" +
	"       	crew.occu  rank, 						" +
	"       	crew.empno empno, 						" +
	"       	crew.name  cname, 						" +
	"       	elearning.exp_date exp_date, 					" +
	"       	0 	   takeoff, 						" +
	"       	0 	   landing, 						" +
	"       	'A017'     qual 						" +
 	"	FROM (SELECT  empno,MAX(exp_date) exp_date 				" +
        "	      FROM   (  							" +
        "      		      SELECT  empno,exp_date,qual 				" +
        "      		      FROM    fzdb.fztlicms_temp 				" +
        "      		      WHERE   qual = 'A017' 					" +
        "       	      UNION ALL    						" +
        "      		      SELECT  empno,cdate exp_date,'A017' qual  		" +
        "      		      FROM    dztsimr   					" +
        "      		      WHERE   chktype IN  					" +
        "                   	     (SELECT itemnO FROM dztchks  			" +
        "                   	      WHERE  itemname = 'TYPE RATING') 			" +
 //     "                   	         OR  SUBSTR(itemname,1,3) = 'PC-') 		" +
        "      			AND    s11 = 'S'   					" +        
        "    		     )								" +
        "	GROUP BY empno) elearning, 						" +
	"       	(SELECT * 							" +
	"          	 FROM 	dfdb.dftcrew 						" +
	"         	 WHERE 	flag  = 'Y' 						" +
	"            	   AND  cabin = 'A' 						" +
	"           	   AND  analysa = '100') crew 					" +
	" 	WHERE elearning.empno(+) = crew.empno 					" +
	"	UNION      								" +    // A018 Airport & Route competence (APT&RT)
	"	SELECT 	crew.fleet fleet, 						" +
	"       	crew.occu  rank, 						" +
	"       	crew.empno empno, 						" +
	"       	crew.name  cname, 						" +
	"       	elearning.exp_date exp_date, 					" +
	"       	0 	   takeoff, 						" +
	"       	0 	   landing, 						" +
	"       	'A018'     qual 						" +
 	"	FROM (SELECT  empno,MAX(exp_date) exp_date 				" +
        "	      FROM   (  							" +
        "      		      SELECT  empno,exp_date,qual 				" +
        "      		      FROM    fzdb.fztlicms_temp 				" +
        "      		      WHERE   qual = 'A018' 					" +
        "       	      UNION ALL    						" +
        "      		      SELECT  empno,cdate exp_date,'A018' qual  		" +
        "      		      FROM    dztsimr   					" +
        "      		      WHERE   chktype IN  					" +
        "                   	     (SELECT itemnO FROM dztchks  			" +
        "                   	      WHERE  itemname = 'TYPE RATING') 			" +
 //     "                   	         OR  SUBSTR(itemname,1,3) = 'PC-') 		" +
        "      			AND    s11 = 'S'   					" +        
        "    		     )								" +
        "	GROUP BY empno) elearning, 						" +
	"       	(SELECT * 							" +
	"          	 FROM 	dfdb.dftcrew 						" +
	"         	 WHERE 	flag  = 'Y' 						" +
	"            	   AND  cabin = 'A' 						" +
	"           	   AND  analysa = '100') crew 					" +
	" 	WHERE elearning.empno(+) = crew.empno 					" +
	"	UNION      								" +    // A019 Right Seat qualification(RHS)
	"	SELECT 	crew.fleet fleet, 						" + 
	"       	crew.occu rank, 						" + 
	"       	crew.empno empno, 						" + 
	"       	crew.name cname, 						" + 
 	"      		rightseat.exp_date exp_date, 					" + 
  	"     		0 takeoff, 							" + 
   	"    		0 landing, 							" + 
    	"   		'A019' qual 							" + 
	"  	FROM 	(SELECT DISTINCT ck.empno empno,b.cdate exp_date 		" + 
	"        	   FROM   fzdb.fztckpl ck, 					" + 
	"               	  (SELECT 	empno,  MAX(cdate) cdate 		" + 
	"                	     FROM 	dzdb.dztsimr 				" + 
	"                	    WHERE 	chktype = 'CA18' 			" +   // RHS Recurrent
	"                 	      AND 	s11 = 'S'      				" +     
	"                 	    GROUP BY 	empno) b 				" + 
	"        	WHERE ck.duty IN ('IP', 'CP','DE') 				" + 
	"          	  AND ck.status = 1 						" + 
	"          	  AND ck.empno = b.empno(+)) rightseat, 			" + 
	"       	(SELECT * 							" + 
	"          	   FROM dfdb.dftcrew 						" + 
	"         	  WHERE flag = 'Y' 						" + 
	"           	    AND cabin = 'A' 						" + 
	"           	    AND analysa = '100') crew 					" + 
	" 	WHERE rightseat.empno = crew.empno(+) 					" + 
	"	UNION      								" +    // A020 IP/CP qualification(IPCP)
	" SELECT crew.fleet fleet, 							" + 
	"       crew.occu  rank, 							" + 
	"       crew.empno empno, 							" + 
	"       crew.name  cname, 							" + 
	"       TRUNC(SYSDATE,'DDD') exp_date, 						" + 
	"       0 takeoff, 								" + 
	"       NVL(ipcp.ipcp_count,0) landing, 					" +   // ipcp_count
	"       'A020' qual 								" + 
	"  FROM (SELECT a.staff_num empno, COUNT(*) ipcp_count 				" + 
	"          FROM (SELECT dps.act_str_dt_tm_gmt, 					" + 
	"                       r.staff_num, 						" + 
	"                       dps.duty_cd, 						" + 
	"                       dps.series_num, 					" + 
	"                       r.roster_num 						" + 
	"                 FROM  duty_prd_seg_v dps, roster_v r 				" + 
	"                 WHERE dps.series_num = r.series_num 				" + 
	"                   AND dps.delete_ind = 'N' 					" + 
	"                   AND r.delete_ind   = 'N' 					" + 
	"                   AND r.staff_num IN (SELECT ck.empno 			" + 
	"                                         FROM fzdb.fztckpl ck 			" + 
	"                                        WHERE ck.duty IN ('IP', 'CP','DE')	" + 
	"                                          AND ck.status = 1 			" + 
	"                                       GROUP BY empno) 			" + 
	"                   AND dps.act_str_dt_tm_gmt BETWEEN lastyear AND lastyearlm	" + 
//	"                       to_date('2011/01/01 0000', 'yyyy/mm/dd hh24mi') AND 	" + 
//	"                       To_Date('2011/12/31 2359', 'yyyy/mm/dd hh24mi') 	" + 
	"                   AND dps.duty_cd NOT IN ('LO', 'RST')) a, 			" + 
	"               (SELECT staff_num, 						" + 
	"                       trg.series_num, 					" + 
	"                       trg.training_function, 					" + 
	"                       trg.roster_num 						" + 
	"                  FROM fzdb.roster_special_duties_trg_v trg 			" + 
	"                 WHERE trg.training_function = 'I' 				" + 
	"                 GROUP BY trg.series_num, 					" + 
	"                          trg.roster_num, 					" + 
	"                          trg.staff_num, 					" + 
	"                          trg.training_function) b 				" + 
	"       WHERE a.staff_num  = b.staff_num(+) 					" + 
	"         AND a.series_num = b.series_num(+) 					" + 
	"         AND a.roster_num = b.roster_num(+) 					" + 
	"         AND b.training_function = 'I' 					" + 
	"       GROUP BY a.staff_num) ipcp, 						" + 
	"       (SELECT d.empno empno,c.fleet fleet,c.occu occu,c.name name		" + 
	"        FROM 									" + 
	"        (SELECT empno,fleet,occu,name 						" + 
	"          FROM  dfdb.dftcrew 							" + 
	"         WHERE  flag = 'Y' 							" + 
	"           AND  cabin = 'A' 							" + 
	"           AND  analysa = '100') c,  						" +           
	"        (SELECT empno 								" + 
	"          FROM  fzdb.fztckpl  							" + 
	"         WHERE  duty IN ('IP', 'CP', 'DE') 					" + 
	"           AND  status = 1 							" + 
	"         GROUP BY empno) d 							" + 
	"        WHERE  c.empno(+) = d.empno ) crew 					" + 
	" WHERE ipcp.empno(+) = crew.empno  						" + 
	"	UNION      								" +    // A021 PT
	"	SELECT 	crew.fleet fleet, 						" +
	"       	crew.occu  rank, 						" +
	"       	crew.empno empno, 						" +
	"       	crew.name  cname, 						" +
	"       	ADD_MONTHS(elearning.exp_date,8) exp_date, 			" +
	"       	0 	   takeoff, 						" +
	"       	0 	   landing, 						" +
	"       	'A021'     qual 						" +
 	"	FROM (SELECT  empno,MAX(exp_date) exp_date 				" +
        "	      FROM   (  							" +
        "      		      SELECT  empno,exp_date,qual 				" +
        "      		      FROM    fzdb.fztlicms_temp 				" +
        "      		      WHERE   qual = 'A021' 					" +
        "       	      UNION ALL    						" +
        "      		      SELECT  empno,cdate exp_date,'A021' qual  		" +
        "      		      FROM    dztsimr   					" +
        "      		      WHERE   chktype IN  					" +
        "                   	     (SELECT itemnO FROM dztchks 			" +
        "                   	      WHERE  itemname = 'TYPE RATING'  			" +
        "                   	         OR  itemname = 'LOCAL')  			" +
  //    "                   	         OR  SUBSTR(itemname,1,3) = 'PC-') 		" +
        "      			AND    s11 = 'S'   					" +        
        "    		     )								" +
        "	GROUP BY empno) elearning, 						" +
	"       	(SELECT * 							" +
	"          	 FROM 	dfdb.dftcrew 						" +
	"         	 WHERE 	flag  = 'Y' 						" +
	"            	   AND  cabin = 'A' 						" +
	"           	   AND  analysa = '100') crew 					" +
	" 	WHERE elearning.empno(+) = crew.empno 					" +
	"	UNION      								" +    // A022 PC
	" SELECT crew.fleet fleet, 							" +
	"       crew.occu rank, 							" +
	"       crew.empno empno,  							" +
	"       crew.name cname, 							" +
	"       ADD_MONTHS(elearning.exp_date,8) exp_date, 				" +
	"       0 takeoff, 								" +
	"       0 landing, 								" +
	"       'A022' qual 								" +
 	"	FROM (SELECT  empno,MAX(exp_date) exp_date 				" +
        "	      FROM   (  							" +
        "      		      SELECT  empno,exp_date,qual 				" +
        "      		      FROM    fzdb.fztlicms_temp 				" +
        "      		      WHERE   qual = 'A022' 					" +
        "       	      UNION ALL    						" +
        "      		      SELECT  empno,cdate exp_date,'A022' qual  		" +
        "      		      FROM    dztsimr   					" +
        "      		      WHERE   chktype IN  					" +
        "                   	     (SELECT itemnO FROM dztchks 			" +
        "                   	       WHERE itemname = 'TYPE RATING' 			" +
        "                   	          OR itemname LIKE 'PC-%' 			" +
        "                   	          OR itemname LIKE 'LOCAL')			" +
        "      			AND    s11 = 'S'   					" +        
        "    		     )								" +
        "	GROUP BY empno) elearning, 						" +
	"       (SELECT * 								" +
	"          FROM dfdb.dftcrew 							" +
	"         WHERE flag = 'Y' 							" +
	"           AND cabin = 'A' 							" +
	"           AND analysa = '100') crew 						" +
	" WHERE elearning.empno(+) = crew.empno 					" +
	"	UNION      								" +    // A023 RC
	" SELECT crew.fleet fleet, 							" +
	"       crew.occu rank, 							" +
	"       crew.empno empno, 							" +
	"       crew.name cname, 							" +
	"       ADD_MONTHS(elearning.exp_date,13) exp_date, 				" +
	"       0 takeoff, 								" +
	"       0 landing, 								" +
	"       'A023' qual 								" +
 	"	FROM (SELECT  empno,MAX(exp_date) exp_date 				" +
        "	      FROM   (  							" +
        "      		      SELECT  empno,exp_date,qual 				" +
        "      		      FROM    fzdb.fztlicms_temp 				" +
        "      		      WHERE   qual = 'A023' 					" +
        "       	      UNION ALL    						" +
        "      		      SELECT  empno,cdate exp_date,'A023' qual  		" +
        "      		      FROM    dztsimr   					" +
        "      		      WHERE   chktype IN  					" +
        "                   	     (SELECT itemnO FROM dztchks 			" +
        "                   	       WHERE (itemname = 'ANNUAL' 			" +
        "                   	         OR   itemname = 'INITIAL' 			" +
        "                   	         OR   itemname = 'RE-QUALIFICATION' 		" +
        "                   	         OR   itemname = 'RP CHECK' 			" +
        "                   	         OR   itemname LIKE 'PIC%')			" +
        "                   	         AND  SUBSTR(itemnO,1,2) = 'CB') 		" +
        "      			AND    s11 = 'S'   					" +        
        "    		     )								" +
        "	GROUP BY empno) elearning, 						" +
	"       (SELECT * 								" +
	"          FROM dfdb.dftcrew 							" +
	"         WHERE flag = 'Y' 							" +
	"           AND cabin = 'A' 							" +
	"           AND analysa = '100') crew 						" +
	" WHERE elearning.empno(+) = crew.empno 					" +
	"	UNION      								" +    // A024 Initial TRN & CHK(Initial)
	" SELECT crew.fleet fleet, 							" +
	"       crew.occu rank, 							" +
	"       crew.empno empno, 							" +
	"       crew.name cname, 							" +
	"       init.exp_date  exp_date, 						" +
	"       0 takeoff, 								" +
	"       0 landing, 								" +
	"       'A024' qual 								" +
	"  FROM (SELECT employid empno, 						" +
	"               MAX(vardt - 1) exp_date 					" +
	"          FROM hrdb.hrvppexp050  						" +
	"         GROUP BY employid ) init, 						" +
	"       (SELECT * 								" +
	"          FROM dfdb.dftcrew 							" +
	"         WHERE flag = 'Y' 							" +
	"           AND cabin = 'A' 							" +
	"           AND analysa = '100') crew 						" +
	" WHERE init.empno(+) = crew.empno  						" +
	"	UNION      								" +    // A025 Specific qualification-LVO
        " SELECT fleet,rank,empno,cname,exp_dt,takeoff,landing,qual                     " +
        "  FROM  fzdb.fztlicchk_a025                                                    " + 
	"	UNION      								" +    // A026 Specific qualification-RVSM
	"	SELECT 	crew.fleet fleet, 						" +
	"       	crew.occu  rank, 						" +
	"       	crew.empno empno, 						" +
	"       	crew.name  cname, 						" +
	"       	elearning.exp_date  exp_date, 					" +
	"       	0 	   takeoff, 						" +
	"       	0 	   landing, 						" +
	"       	'A026'     qual 						" +
 	"	FROM (SELECT  empno,MAX(exp_date) exp_date 				" +
        "	      FROM   (  							" +
        "      		      SELECT  empno,exp_date,qual 				" +
        "      		      FROM    fzdb.fztlicms_temp 				" +
        "      		      WHERE   qual = 'A026' 					" +
        "       	      UNION ALL    						" +
        "      		      SELECT  empno,cdate exp_date,'A026' qual  		" +
        "      		      FROM    dztsimr   					" +
        "      		      WHERE   chktype IN  					" +
        "                   	     (SELECT itemnO FROM dztchks 			" +
        "                   	       WHERE itemname = 'TYPE RATING') 			" +
 //     "                   	          OR SUBSTR(itemname,1,3) = 'PC-') 		" +
        "      			AND    s11 = 'S'   					" +        
        "    		     )								" +
        "	GROUP BY empno) elearning, 						" +
	"       	(SELECT * 							" +
	"          	 FROM 	dfdb.dftcrew 						" +
	"         	 WHERE 	flag  = 'Y' 						" +
	"            	   AND  cabin = 'A' 						" +
	"           	   AND  analysa = '100') crew 					" +
	" 	WHERE elearning.empno(+) = crew.empno 					" +
	"	UNION      								" +    // A027-1 Specific qualification-ETOPS
	"	SELECT 	crew.fleet fleet, 						" +
	"       	crew.occu  rank, 						" +
	"       	crew.empno empno, 						" +
	"       	crew.name  cname, 						" +
	"       	elearning.exp_date exp_date, 					" +
	"       	0 	   takeoff, 						" +
	"       	0 	   landing, 						" +
	"       	'A027-1'     qual 						" +
 	"	FROM (SELECT  empno,MAX(exp_date) exp_date 				" +
        "	      FROM   (  							" +
        "      		      SELECT  empno,exp_date,qual 				" +
        "      		      FROM    fzdb.fztlicms_temp 				" +
        "      		      WHERE   qual = 'A027-1' 					" +
        "       	      UNION ALL    						" +
        "      		      SELECT  empno,cdate exp_date,'A027-1' qual  		" +
        "      		      FROM    dztsimr   					" +
        "      		      WHERE   chktype IN  					" +
        "                   	     (SELECT itemnO FROM dztchks 			" +
        "                   	       WHERE itemname = 'TYPE RATING')			" +
        "      			AND    s11 = 'S'   					" +        
        "    		     )								" +
        "	GROUP BY empno) elearning, 						" +
	"       	(SELECT * 							" +
	"          	 FROM 	dfdb.dftcrew 						" +
	"         	 WHERE 	flag  = 'Y' 						" +
	"            	   AND  cabin = 'A' 						" +
	"           	   AND  analysa = '100' AND fleet IN ('330','738')) crew 	" +
	" 	WHERE elearning.empno(+) = crew.empno 					" +
	"	UNION      								" +    // A027-2 Specific qualification-ETOPS
	" SELECT crew.fleet fleet, 							" + 
	"       crew.occu rank, 							" + 
	"       crew.empno empno, 							" + 
	"       crew.name cname, 							" + 
	"       elearning.exp_date  exp_date, 						" + 
	"       0 takeoff, 								" + 
	"       0 landing, 								" + 
	"       'A027-2' qual 								" + 
 	"	FROM (SELECT  empno,MAX(exp_date) exp_date 				" +
        "	      FROM   (  							" +
        "      		      SELECT  empno,exp_date,qual 				" +
        "      		      FROM    fzdb.fztlicms_temp 				" +
        "      		      WHERE   qual = 'A027-2' 					" +
        "       	      UNION ALL    						" +
        "      		      SELECT  empno,cdate exp_date,'A027-2' qual  		" +
        "      		      FROM    dztsimr   					" +
        "      		      WHERE   chktype IN  					" +
        "                   	     (SELECT itemnO FROM dztchks 			" +
        "                   	       WHERE (itemname = 'ETOPS' 			" +
        "                   	         OR   itemname = 'ANNUAL'  			" +
        "                   	         OR   itemname = 'INITIAL'			" +
        "                   	         OR   itemname LIKE 'PIC%' 			" +
        "                   	         AND  SUBSTR(itemnO,1,2) = 'CB') 		" +
        "                   	         OR  (itemname IN ('PC-1','PC-3','PC-5')	" +
        "                   	         AND  SUBSTR(itemnO,1,2) = 'CA') )		" +
        "      			AND    s11 = 'S'   					" +        
        "    		     )								" +
        "	GROUP BY empno) elearning, 						" +
	"       (SELECT * 								" + 
	"          FROM dfdb.dftcrew 							" + 
	"         WHERE flag  = 'Y' 							" + 
	"           AND cabin = 'A' 							" + 
	"           AND analysa = '100' 						" + 
	"           AND fleet IN ('330','738')) crew 					" + 
	" WHERE elearning.empno(+) = crew.empno 					" + 
	"	UNION      								" +    // A028-1 TCAS CBT Training
	"	SELECT 	crew.fleet fleet, 						" +
	"       	crew.occu  rank, 						" +
	"       	crew.empno empno, 						" +
	"       	crew.name  cname, 						" +
	"       	elearning.exp_date exp_date, 					" +
	"       	0 	   takeoff, 						" +
	"       	0 	   landing, 						" +
	"       	'A028-1'     qual 						" +
 	"	FROM (SELECT  empno,MAX(exp_date) exp_date 				" +
        "	      FROM   (  							" +
        "      		      SELECT  empno,exp_date exp_date,qual 			" +
        "      		      FROM    fzdb.fztlicms_temp 				" +
        "      		      WHERE   qual = 'A028-1' 					" +
        "       	      UNION ALL    						" +
        "      		      SELECT  empno,cdate exp_date,'A028-1' qual 		" +
        "      		      FROM    dztsimr   					" +
        "      		      WHERE   chktype IN  					" +
        "                   	     (SELECT itemnO FROM dztchks 			" +
        "                   	       WHERE itemname = 'TYPE RATING'  			" +
        "                   	          OR itemname = 'PC-1') 			" +
        "      			AND    s11 = 'S'   					" +        
        "    		     )								" +
        "	GROUP BY empno) elearning, 						" +
	"       	(SELECT * 							" +
	"          	 FROM 	dfdb.dftcrew 						" +
	"         	 WHERE 	flag  = 'Y' 						" +
	"            	   AND  cabin = 'A' 						" +
	"           	   AND  analysa = '100' ) crew 					" +
	" 	WHERE elearning.empno(+) = crew.empno 					" +
	"	UNION      								" +    // A028-2 TCAS SIM Check
	" SELECT crew.fleet fleet, 							" +
	"       crew.occu rank, 							" +
	"       crew.empno empno, 							" +
	"       crew.name cname, 							" +
	"       elearning.exp_date exp_date, 						" +
	"       0 takeoff, 								" +
	"       0 landing, 								" +
	"       'A028-2' qual 								" +
 	"	FROM (SELECT  empno,MAX(exp_date) exp_date 				" +
        "	      FROM   (  							" +
        "      		      SELECT  empno,exp_date exp_date,qual 			" +
        "      		      FROM    fzdb.fztlicms_temp 				" +
        "      		      WHERE   qual = 'A028-2' 					" +
        "       	      UNION ALL    						" +
        "      		      SELECT  empno,cdate exp_date,'A028-2' qual 		" +
        "      		      FROM    dztsimr   					" +
        "      		      WHERE   chktype IN  					" +
        "                   	     (SELECT itemnO FROM dztchks 			" +
        "                   	       WHERE itemname = 'TYPE RATING'  			" +
        "                   	          OR itemname = 'PC-1') 			" +
        "      			AND    s11 = 'S'   					" +               
        "    		     )								" +
        "	GROUP BY empno) elearning, 						" +
	"       (SELECT * 								" +
	"          FROM dfdb.dftcrew 							" +
	"         WHERE flag = 'Y' 							" +
	"           AND cabin = 'A' 							" +
	"           AND analysa = '100') crew 						" +
	" WHERE elearning.empno(+) = crew.empno  					" +
	"	UNION      								" +    // A029 Equipment qualification-GPWS/EGPWS
	"	SELECT 	crew.fleet fleet, 						" +
	"       	crew.occu  rank, 						" +
	"       	crew.empno empno, 						" +
	"       	crew.name  cname, 						" +
	"       	elearning.exp_date exp_date, 					" +
	"       	0 	   takeoff, 						" +
	"       	0 	   landing, 						" +
	"       	'A029'     qual 						" +
 	"	FROM (SELECT  empno,MAX(exp_date) exp_date 				" +
        "	      FROM   (  							" +
        "      		      SELECT  empno,exp_date exp_date,qual 			" +
        "      		      FROM    fzdb.fztlicms_temp 				" +
        "      		      WHERE   qual = 'A029' 					" +
        "       	      UNION ALL    						" +
        "      		      SELECT  empno,cdate exp_date,'A029' qual  		" +
        "      		      FROM    dztsimr   					" +
        "      		      WHERE   chktype IN  					" +
        "                   	     (SELECT itemnO FROM dztchks 			" +
        "                   	       WHERE itemname = 'TYPE RATING') 			" +
 //     "                   	          OR SUBSTR(itemname,1,3) = 'PC-') 		" +
        "      			AND    s11 = 'S'   					" +
        "    		     )								" +
        "	GROUP BY empno) elearning, 						" +
	"       	(SELECT * 							" +
	"          	 FROM 	dfdb.dftcrew 						" +
	"         	 WHERE 	flag  = 'Y' 						" +
	"            	   AND  cabin = 'A' 						" +
	"           	   AND  analysa = '100') crew 					" +
	" 	WHERE elearning.empno(+) = crew.empno 					" +
	"	)  ";

//	out.println("sql_insert = "+sql_insert);
	
	pstmt_insert = conn.prepareStatement(sql_insert);		
	i_insert_count = pstmt_insert.executeUpdate();
 
//     	out.println("i_insert_count = "+i_insert_count);



//    insert end 


//out.println("slt_EMPNO = "+empno);
//out.println("slt_EMPNO = "+request.getParameter("slt_EMPNO"));

if(empno.equals("") || empno == null)
 {
	sql_query = " SELECT fleet, 									" +
		    "             CASE WHEN dd.empno IN (SELECT DISTINCT a.empno empno  		" +
                    "                                      FROM   fztckpl a, fztstus b 			" +
              	    "                                      WHERE  a.status = b.status 			" +
                    "                                        AND  b.status = 1 				" +
                    "                                        AND  a.duty IN ('TCA','TFO','TRP')) 	" +
                    "             THEN (SELECT DISTINCT a.duty duty 					" +
                    "                   FROM   fztckpl a, fztstus b 					" +
                    "                   WHERE  a.status = b.status 					" +
                    "                     AND  b.status = 1 						" +
                    "                     AND  a.duty IN ('TCA','TFO','TRP')  				" +
                    "                     AND  a.empno = dd.empno )   					" +              
                    "             ELSE rank 								" +
                    "        END  rank, 								" +
                    "        empno,cname,								" +
		    "	     CASE WHEN qual = 'A013-2' THEN takeoff || '/' || landing 			" +
		    "             WHEN qual = 'A020'   THEN landing || ' '				" +
		    "             WHEN qual = 'A025' AND fleet = '738'  THEN 				" +
		    "                  CASE WHEN takeoff = 1  THEN 'Yes' 				" +
		    "                       WHEN takeoff = 0  THEN 'No' 				" +
		    "                       ELSE ' '					 		" +
		    "                  END								" +
		    "             WHEN qual = 'A025' AND fleet <> '738'  THEN 				" +
		    "                  CASE WHEN takeoff = 1  AND landing = 1  THEN 'Yes/Yes' 		" +
		    "                       WHEN takeoff = 1  AND landing = 0  THEN 'Yes/No' 		" +
		    "                       WHEN takeoff = 0  AND landing = 1  THEN 'No/Yes' 		" +
		    "                       WHEN takeoff = 0  AND landing = 0  THEN 'No/No' 		" +
		    "                       ELSE ' '					 		" +
		    "                  END								" +
                    "		  ELSE TO_CHAR(exp_dt,'yyyy-mm-dd') 					" +
            	    "	     END exp_dt, 								" +
       		    "	     qual,effective,  								" +
		    "		CASE WHEN qual = 'A001' then '檢定證(RAT)' 				" +
		    "		     WHEN qual = 'A002' then '英檢加簽(ENG)' 				" +
		    "		     WHEN qual = 'A003' then '體檢證(MED)' 				" +
		    "		     WHEN qual = 'A004' then '護照(PPT)' 				" +
		    "		     WHEN qual = 'A005' then '台胞證(CHN)' 				" +
		    "		     WHEN qual = 'A006' then '台胞證加簽(CN)' 				" +
		    "		     WHEN qual = 'A007' then 'US VISA(USD)' 				" +
		    "		     WHEN qual = 'A008' then 'SPPA(FAA)' 				" +
		    "		     WHEN qual = 'A009' then 'China VISA (for EXP)(CN)' 		" +
		    "		     WHEN qual = 'A010' then 'LUX VISA (for EXP)(LU)' 			" +
		    "		     WHEN qual = 'A011' then '外籍居留證(ARC)' 				" +
		    "		     WHEN qual = 'A012' then '空勤組員證(CMC)' 				" +
		    "		     WHEN qual = 'A013-1' then 'Recency(45/FLT)' 			" +
  		    "		     WHEN qual = 'A013-2' then 'Recency(90/TO&LD)' 			" +
		    "		     WHEN qual = 'A014' then 'CRM' 					" +
		    "		     WHEN qual = 'A015' then 'Security Training(SS)' 			" +
		    "		     WHEN qual = 'A016' then 'Emergency Training(ET)' 			" +
		    "		     WHEN qual = 'A017' then 'Dangerous Goods(DG)' 			" +
		    "		     WHEN qual = 'A018' then 'Airport & Route competence (APT&RT)' 	" +
		    "		     WHEN qual = 'A019' then 'Right Seat qualification(RHS)' 		" +
		    "		     WHEN qual = 'A020' then 'IP/CP qualification(IPCP)' 		" +
		    "		     WHEN qual = 'A021' then 'PT' 					" +
		    "		     WHEN qual = 'A022' then 'PC' 					" +
		    "		     WHEN qual = 'A023' then 'RC' 					" +
		    "		     WHEN qual = 'A024' then 'Initial TRN & CHK(Initial)' 		" +
		    "		     WHEN qual = 'A025' then 'Specific qualification-LVO(CAT II,IIIa/IIIb)' 	" +
		    "		     WHEN qual = 'A026' then 'Specific qualification-RVSM' 		" +
		    "		     WHEN qual = 'A027-1' then 'ETOPS CBT Training' 			" +
		    "		     WHEN qual = 'A027-2' then 'ETOPS Route Experience' 		" +
		    "		     WHEN qual = 'A028-1' then 'TCAS CBT Training' 			" +
		    "		     WHEN qual = 'A028-2' then 'TCAS SIM Check' 			" +
		    "		     WHEN qual = 'A029' then 'Equipment qualification-GPWS/EGPWS' 	" +
		    "		     ELSE qual  							" +
 		    "		END  qual_n 								" +
		    "   FROM ( 										" +
		    "		SELECT 	fleet,rank,empno,cname,exp_dt,qual,takeoff,landing,		" +
		    "                   CASE 								" +
                    "                       WHEN qual = 'A013-1' THEN 					" +
                    "                            CASE WHEN EXP_DT > TO_DATE(?,'YYYY-MM-DD') - 45 THEN 'Yes' 	" +
                    "                                 ELSE 'No' 					" +
                    "                            END    						" +
                    "			    WHEN qual = 'A013-2' THEN 					" +
                    "				 CASE WHEN (takeoff < 3 OR landing < 3)  THEN 'No' 	" +
                    " 				      ELSE 'Yes' 					" +
                    "				 END  							" +
                    "			    WHEN qual IN ('A014','A015','A017','A018','A019','A026','A027-1','A027-2') THEN 	" +
                    "				 CASE WHEN TO_CHAR(TO_DATE(?,'YYYY-MM-DD'),'YYYY') - 2 < TO_CHAR(EXP_DT,'YYYY')  THEN 'Yes' 	" +
                    " 				      ELSE 'No' 					" +
                    "				 END  							" +
                    "			    WHEN qual IN ('A028-1','A028-2','A029') THEN 		" +
                    "				 CASE WHEN TO_CHAR(TO_DATE(?,'YYYY-MM-DD'),'YYYY') - 4 < TO_CHAR(EXP_DT,'YYYY')  THEN 'Yes' 	" +
                    " 				      ELSE 'No' 					" +
                    "				 END  							" +
                    "			    WHEN qual = 'A016' THEN 					" +
                    "				 CASE WHEN EXP_DT > TO_DATE(?,'YYYY-MM-DD') THEN 'Yes' 	" +
                    " 				      ELSE 'No' 					" +
                    "				 END  							" +
                    "			    WHEN qual = 'A020' THEN 					" +
                    "				 CASE WHEN  landing < 3   THEN 'No' 			" +
                    " 				      ELSE 'Yes' 					" +
                    "				 END  							" +
                    "			    WHEN qual = 'A021' THEN 					" +
                    "				 CASE WHEN EXP_DT > TO_DATE(?,'YYYY-MM-DD')  THEN 'Yes' " +
                    " 				      ELSE 'No' 					" +
                    "				 END  							" +
                    "			    WHEN qual = 'A022'  THEN 					" +
                    "				 CASE WHEN EXP_DT > TO_DATE(?,'YYYY-MM-DD')  THEN 'Yes' " +
                    " 				      ELSE 'No' 					" +
                    "				 END  							" +
                    "			    WHEN qual = 'A024'  THEN 					" +
                    "				 CASE WHEN EXP_DT is NULL  THEN 'No' 			" +
                    " 				      ELSE 'Yes' 					" +
                    "				 END  							" +
                    "			    WHEN qual = 'A025' AND fleet = '738'  THEN 			" +
                    "				 CASE WHEN takeoff = 1  THEN 'Yes' 			" +
                    "				      WHEN takeoff = 0  THEN 'No' 			" +
                    " 				      ELSE ' ' 						" +
                    "				 END  							" +
                    "			    WHEN qual = 'A025' AND fleet <> '738' THEN 			" +
                    "				 CASE WHEN takeoff = 1  AND landing = 1 THEN 'Yes' 	" +
                    "				      WHEN takeoff = 1  AND landing = 0 THEN 'No' 	" +
                    "				      WHEN takeoff = 0  AND landing = 1 THEN 'No' 	" +
                    "				      WHEN takeoff = 0  AND landing = 0 THEN 'No' 	" +
                    " 				      ELSE ' ' 						" +
                    "				 END  							" +
                    "                       ELSE CASE WHEN EXP_DT > TO_DATE(?,'YYYY-MM-DD') THEN 'Yes' 	" +
                    "                                 ELSE 'No' 					" +
                    "                            END     						" +
                    "                   END effective 							" +
		    "		FROM   fztlicchk_temp   						" +
		    "		WHERE  empno  IN  							" +
      	            "		      (SELECT  DISTINCT empno 						" +
		    "	            	FROM   fzdb.fztckpl   						" +   
		    "            	WHERE  status = 1  						" +    // 正常
		    "             	GROUP BY empno)   						" +
                    "             AND  fleet IN ('738','744','330','340') )  dd                         " +
		    " WHERE   										" +
      		    "		(fleet   	LIKE ? " + str_sql_where_fleet + " ) 			" +
  		    "	AND 	(rank    	LIKE ? " + str_sql_where_rank  + " ) 			" +
  		    "	AND 	qual     	LIKE ? 							" +
  		    "	AND 	effective     	LIKE ? 							" +
		    "	ORDER BY empno  ,qual ";

//	out.println("sql_query = "+sql_query);

	pstmt_query = conn.prepareStatement(sql_query);
	pstmt_query.setString(1,checkdate);
	pstmt_query.setString(2,checkdate);
	pstmt_query.setString(3,checkdate);
	pstmt_query.setString(4,checkdate);
	pstmt_query.setString(5,checkdate);
	pstmt_query.setString(6,checkdate);
	pstmt_query.setString(7,checkdate);
	pstmt_query.setString(8,fleet);
	pstmt_query.setString(9,rank);
	pstmt_query.setString(10,qualification);
	pstmt_query.setString(11,effective);	 
 }
else{
	sql_query = "	SELECT fleet,							 			" +
		    "             CASE WHEN dd.empno IN (SELECT DISTINCT a.empno empno  			" +
                    "                                      FROM   fztckpl a, fztstus b 				" +
              	    "                                      WHERE  a.status = b.status 				" +
                    "                                        AND  b.status = 1 					" +
                    "                                        AND  a.duty IN ('TCA','TFO','TRP')) 		" +
                    "             THEN (SELECT DISTINCT a.duty duty 						" +
                    "                   FROM   fztckpl a, fztstus b 						" +
                    "                   WHERE  a.status = b.status 						" +
                    "                     AND  b.status = 1 							" +
                    "                     AND  a.duty IN ('TCA','TFO','TRP')  					" +
                    "                     AND  a.empno = dd.empno )   						" +              
                    "             ELSE rank 									" +
                    "        END  rank, 									" +
                    "        empno,cname,									" +
		    "	     CASE WHEN qual = 'A013-2' THEN takeoff || '/' || landing 				" +
		    "             WHEN qual = 'A020'   THEN landing || ' '					" +
		    "             WHEN qual = 'A025' AND fleet = '738'  THEN 					" +
		    "                  CASE WHEN takeoff = 1  THEN 'Yes' 					" +
		    "                       WHEN takeoff = 0  THEN 'No' 					" +
		    "                       ELSE ' '					 			" +
		    "                  END									" +
		    "             WHEN qual = 'A025' AND fleet <> '738'  THEN 					" +
		    "                  CASE WHEN takeoff = 1  AND landing = 1  THEN 'Yes/Yes' 			" +
		    "                       WHEN takeoff = 1  AND landing = 0  THEN 'Yes/No' 			" +
		    "                       WHEN takeoff = 0  AND landing = 1  THEN 'No/Yes' 			" +
		    "                       WHEN takeoff = 0  AND landing = 0  THEN 'No/No' 			" +
		    "                       ELSE ' '					 			" +
		    "                  END									" +
                    "		  ELSE TO_CHAR(exp_dt,'yyyy-mm-dd') 						" +
            	    "	     END exp_dt, 									" +
       		    "	     qual,effective,  									" +
		    "		CASE WHEN qual = 'A001' then '檢定證(RAT)' 					" +
		    "		     WHEN qual = 'A002' then '英檢加簽(ENG)' 					" +
		    "		     WHEN qual = 'A003' then '體檢證(MED)' 					" +
		    "		     WHEN qual = 'A004' then '護照(PPT)' 					" +
		    "		     WHEN qual = 'A005' then '台胞證(CHN)' 					" +
		    "		     WHEN qual = 'A006' then '台胞證加簽(CN)' 					" +
		    "		     WHEN qual = 'A007' then 'US VISA(USD)' 					" +
		    "		     WHEN qual = 'A008' then 'SPPA(FAA)' 					" +
		    "		     WHEN qual = 'A009' then 'China VISA (for EXP)(CN)' 			" +
		    "		     WHEN qual = 'A010' then 'LUX VISA (for EXP)(LU)' 				" +
		    "		     WHEN qual = 'A011' then '外籍居留證(ARC)' 					" +
		    "		     WHEN qual = 'A012' then '空勤組員證(CMC)' 					" +
		    "		     WHEN qual = 'A013-1' then 'Recency(45/FLT)' 				" +
		    "		     WHEN qual = 'A013-2' then 'Recency(90/TO&LD)' 				" +
		    "		     WHEN qual = 'A014' then 'CRM' 						" +
		    "		     WHEN qual = 'A015' then 'Security Training(SS)' 				" +
		    "		     WHEN qual = 'A016' then 'Emergency Training(ET)' 				" +
		    "		     WHEN qual = 'A017' then 'Dangerous Goods(DG)' 				" +
		    "		     WHEN qual = 'A018' then 'Airport & Route competence (APT&RT)' 	   	" +
		    "		     WHEN qual = 'A019' then 'Right Seat qualification(RHS)' 			" +
		    "		     WHEN qual = 'A020' then 'IP/CP qualification(IPCP)' 			" +
		    "		     WHEN qual = 'A021' then 'PT' 						" +
		    "		     WHEN qual = 'A022' then 'PC' 						" +
		    "		     WHEN qual = 'A023' then 'RC' 						" +
		    "		     WHEN qual = 'A024' then 'Initial TRN & CHK(Initial)' 			" +
		    "		     WHEN qual = 'A025' then 'Specific qualification-LVO(CAT II,IIIa/IIIb)' 	" +
		    "		     WHEN qual = 'A026' then 'Specific qualification-RVSM' 			" +
		    "		     WHEN qual = 'A027-1' then 'ETOPS CBT Training' 				" +
		    "		     WHEN qual = 'A027-2' then 'ETOPS Route Experience' 			" +
		    "		     WHEN qual = 'A028-1' then 'TCAS CBT Training' 				" +
		    "		     WHEN qual = 'A028-2' then 'TCAS SIM Check' 				" +
		    "		     WHEN qual = 'A029' then 'Equipment qualification-GPWS/EGPWS' 		" +
		    "		     ELSE qual  								" +
 		    "		END  qual_n 									" +
		    "   FROM ( 										 	" +
		    "		SELECT fleet,rank,empno,cname,exp_dt,qual,takeoff,landing,			" +
		    "                   CASE 									" +
                    "                       WHEN qual = 'A013-1' THEN 						" +
                    "                            CASE WHEN EXP_DT > TO_DATE(?,'YYYY-MM-DD') - 45 THEN 'Yes' 	" +
                    "                                 ELSE 'No' 						" +
                    "                            END    							" + 
                    "			    WHEN qual = 'A013-2' THEN 						" +
                    "				 CASE WHEN (takeoff < 3 OR landing < 3)  THEN 'No' 		" +
                    " 				      ELSE 'Yes' 						" +
                    "				 END  								" +
                    "			    WHEN qual IN ('A014','A015','A017','A018','A019','A026','A027-1','A027-2') THEN 		" +
                    "				 CASE WHEN TO_CHAR(TO_DATE(?,'YYYY-MM-DD'),'YYYY') - 2 < TO_CHAR(EXP_DT,'YYYY')  THEN 'Yes' 	" +
                    " 				      ELSE 'No' 						" +
                    "				 END  								" +
                    "			    WHEN qual IN ('A028-1','A028-2','A029') THEN 			" +
                    "				 CASE WHEN TO_CHAR(TO_DATE(?,'YYYY-MM-DD'),'YYYY') - 4 < TO_CHAR(EXP_DT,'YYYY')  THEN 'Yes' 	" +
                    " 				      ELSE 'No' 						" +
                    "				 END  								" +
                    "			    WHEN qual = 'A016'  THEN 						" +
                    "				 CASE WHEN EXP_DT > TO_DATE(?,'YYYY-MM-DD') THEN 'Yes'  	" +
                    " 				      ELSE 'No' 						" +
                    "				 END  								" +
                    "			    WHEN qual = 'A020' THEN 						" +
                    "				 CASE WHEN  landing < 3   THEN 'No' 				" +
                    " 				      ELSE 'Yes' 						" +
                    "				 END  								" +
                    "			    WHEN qual =  'A021'  THEN 						" +
                    "				 CASE WHEN EXP_DT > TO_DATE(?,'YYYY-MM-DD')  THEN 'Yes' 	" +
                    " 				      ELSE 'No' 						" +
                    "				 END  								" +
                    "			    WHEN qual = 'A022'  THEN 						" +
                    "				 CASE WHEN EXP_DT > TO_DATE(?,'YYYY-MM-DD')  THEN 'Yes' 	" +
                    " 				      ELSE 'No' 						" +
                    "				 END  								" +
                    "			    WHEN qual = 'A024'  THEN 						" +
                    "				 CASE WHEN EXP_DT is NULL  THEN 'No' 				" +
                    " 				      ELSE 'Yes' 						" +
                    "				 END  								" +
                    "			    WHEN qual = 'A025' AND fleet = '738'  THEN 				" +
                    "				 CASE WHEN takeoff = 1  THEN 'Yes' 				" +
                    "				      WHEN takeoff = 0  THEN 'No' 				" +
                    " 				      ELSE ' ' 							" +
                    "				 END  								" +
                    "			    WHEN qual = 'A025' AND fleet <> '738' THEN 				" +
                    "				 CASE WHEN takeoff = 1  AND landing = 1 THEN 'Yes' 		" +
                    "				      WHEN takeoff = 1  AND landing = 0 THEN 'No' 		" +
                    "				      WHEN takeoff = 0  AND landing = 1 THEN 'No' 		" +
                    "				      WHEN takeoff = 0  AND landing = 0 THEN 'No' 		" +
                    " 				      ELSE ' ' 							" +
                    "				 END  								" +
                    "                       ELSE CASE WHEN EXP_DT > TO_DATE(?,'YYYY-MM-DD') THEN 'Yes' 		" +
                    "                                 ELSE 'No' 						" +
                    "                            END     							" +
                    "                   END effective 								" +
		    "	FROM     fztlicchk_temp  								" + 
		    "	WHERE    empno IN  									" +
      	            "		      (SELECT  DISTINCT empno 							" +
		    "	            	FROM   fzdb.fztckpl   							" +
		    "            	WHERE  status = 1  							" +    // 正常
		    "             	GROUP BY empno)   							" +
                    "     AND    fleet IN ('738','744','330','340') )   dd                         		" +
		    "	WHERE    empno          =    ?  							" +
	 	    "	AND 	 qual     	LIKE ? 								" +
  		    "	AND 	 effective     	LIKE ? 								" +	    
		    "   ORDER BY qual ";
 	
	pstmt_query = conn.prepareStatement(sql_query);
	pstmt_query.setString(1,checkdate);
	pstmt_query.setString(2,checkdate);
	pstmt_query.setString(3,checkdate);
	pstmt_query.setString(4,checkdate);
	pstmt_query.setString(5,checkdate);
	pstmt_query.setString(6,checkdate);
	pstmt_query.setString(7,checkdate);
	pstmt_query.setString(8,empno);
	pstmt_query.setString(9,qualification);
	pstmt_query.setString(10,effective);	 
     }

	//out.println("sql_query = "+sql_query);

	rs = pstmt_query.executeQuery();
	while (rs.next()) 
	     {
		fleetAL.add(rs.getString("fleet"));
		rankAL.add(rs.getString("rank"));
		empnoAL.add(rs.getString("empno"));
		cnameAL.add(rs.getString("cname"));
		exp_dtAL.add(rs.getString("exp_dt"));
		qualAL.add(rs.getString("qual_n"));
		effectiveAL.add(rs.getString("effective"));
	     }
	//conn.commit();
	//out.println("fleetAL = "+fleetAL);
	//out.println("empnoAL.size() = "+empnoAL.size());

	sql_delete = "	DELETE  fztlicchk_temp 	";
	pstmt_delete = conn.prepareStatement(sql_delete);		
	i_delete_count = pstmt_delete.executeUpdate();

	sql_delete = "	DELETE  fztlicms_temp 	";
	pstmt_delete = conn.prepareStatement(sql_delete);		
	i_delete_count = pstmt_delete.executeUpdate();
 
} catch (SQLException e) {
	out.println(e.toString());	
} catch (Exception e) {
	out.println(e.toString());	
} finally {
	if ( rs 	  != null ) try { rs.close();} 		 catch (SQLException e) {}
	if ( pstmt_query  != null ) try { pstmt_query.close();}  catch (SQLException e) {}
	if ( pstmt_insert != null ) try { pstmt_insert.close();} catch (SQLException e) {}
	if ( conn 	  != null ) try { conn.close();	} 	 catch (SQLException e) {}
}

%>
<html>
<head>
<title>Crew Qualification Check List</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>
<body>

<%
if(empnoAL.size() == 0){

%>
	<div align="center"><span class="txtxred">查無符合篩選條件的資料<br>No information match the filter conditions!! <br></span></div>
<% 

}else{

%>

<div align="center"> 
 
  <form name="form1" method="post" action="">
    <table width="100%" border="0" bordercolor="#666666" class="fortable">    
      <tr> 
	<td width="10%" > 
        <div align="center" class="tablehead3"><b><font size="2"><font face="Arial, Helvetica, sans-serif">Fleet</font></font></b></div></td>
	<td width="10%" > 
        <div align="center" class="tablehead3"><b><font size="2"><font face="Arial, Helvetica, sans-serif">Rank</font></font></b></div></td>
	<td width="10%" > 
        <div align="center" class="tablehead3"><b><font size="2"><font face="Arial, Helvetica, sans-serif">EmpNo</font></font></b></div></td>
	<td width="20%" > 
        <div align="center" class="tablehead3"><b><font size="2"><font face="Arial, Helvetica, sans-serif">Cname</font></font></b></div></td>
        <td width="10%" > 
        <div align="center" class="tablehead3"><b><font size="2"><font face="Arial, Helvetica, sans-serif">Exp_dt</font></font></b></div></td>
        <td width="30%" > 
        <div align="center" class="tablehead3"><b><font size="2"><font face="Arial, Helvetica, sans-serif">Qualification</font></font></b></div></td>
        <td width="10%" > 
        <div align="center" class="tablehead3"><b><font size="2"><font face="Arial, Helvetica, sans-serif">Effective</font></font></b></div></td>
      </tr>
       <%
	  	for(int i=0;i<empnoAL.size();i++){ 
					
	  %>
      <tr>
        <td class="tablebody"><div align="left">&nbsp;<%=fleetAL.get(i)%></div></td>
	<td class="tablebody"><div align="left">&nbsp;<%=rankAL.get(i)%></div></td>
	<td class="tablebody"><div align="left">&nbsp;<%=empnoAL.get(i)%></div></td>
	<td class="tablebody"><div align="left">&nbsp;<%=cnameAL.get(i)%></div></td>
	<td class="tablebody"><div align="left">&nbsp;<%=exp_dtAL.get(i)%></div></td>
	<td class="tablebody"><div align="left">&nbsp;<%=qualAL.get(i)%></div></td>
        <td class="tablebody"><div align="left">&nbsp;<% if (effectiveAL.get(i).equals("No"))  out.println("<span style='color:red;'><b>" + effectiveAL.get(i) + "</b></span> "); else out.println(effectiveAL.get(i)); %></div></td>
      </tr>
	  <%
	  }
	  %>
      
    </table>
  
  </form>
</div>
<% } 
%>
</body>
</html>
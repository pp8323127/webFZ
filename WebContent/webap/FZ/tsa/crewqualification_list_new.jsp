<%@page import="fz.tsa.CrewQual"%>
<%@page import="java.io.FileWriter"%>
<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.text.*,java.util.*,java.sql.*,java.sql.Date,fz.*,dz.eLearning.MSSQLConn,ci.db.*,javax.sql.DataSource,javax.naming.InitialContext"%>
<%

String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
/*response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);*/

if (session.isNew() | sGetUsr == null) 
{		
  response.sendRedirect("sendredirect.jsp");
} 

 //  Generate file
  String path = application.getRealPath("/")+"/FZ/tsa/crewqual/file/";
  String filename = sGetUsr+"CrewQualificationCheck";
  FileWriter fw = new FileWriter(path+filename+".csv",false);

String fleet 		= request.getParameter("slt_FLEET");
String rank 		= request.getParameter("slt_RANK");
String empno 		= request.getParameter("slt_EMPNO");
String checkdate 	= request.getParameter("checkdate");
String qualification 	= request.getParameter("slt_QUALIFICATION") + "%";
String qual_id  	= request.getParameter("slt_QUALIFICATION");//only id
String effective 	= request.getParameter("slt_EFFECTIVE");
String sSYSDATE 	= (String) session.getAttribute("sSYSDATE");

String qualAL_savefile 	= null;

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
ArrayList ratAL	= new ArrayList();
ArrayList qual_idAL	= new ArrayList(); 
ArrayList chkitemnameAL	= new ArrayList();

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
  MSSQL_db.setELEARNING_TRMS(); 
  Class.forName(MSSQL_db.getDriver());
  MSSQL_conn = DriverManager.getConnection(MSSQL_db.getConnURL(),MSSQL_db.getConnID(),MSSQL_db.getConnPW());
  MSSQL_stmt = MSSQL_conn.createStatement();
  MSSQL_sql = "SELECT userid,CONVERT(varchar(10), MAX(dateon), 111) AS exp_date,'A014'   AS qual FROM LMS_for_OZ_View_LMS_Record_In_3 WHERE  (course LIKE '%CRM Recurrent%')   AND (result <> 0)  group by userid " +
    "	UNION  SELECT userid,CONVERT(varchar(10), MAX(dateon), 111) AS exp_date,'A015'   AS qual FROM LMS_for_OZ_View_LMS_Record_In_3 WHERE  (course LIKE '%SS Training%' OR course LIKE '%Aviation Security%')  AND (result <> 0)  group by userid " +
    "	UNION  SELECT userid,CONVERT(varchar(10), MAX(dateon), 111) AS exp_date,'A016'   AS qual FROM LMS_for_OZ_View_LMS_Record_In_3 WHERE  (course LIKE '%SEP%Recurrent%' OR course LIKE '%SEP%Requalification%')   AND (result <> 0)  group by userid " +
    "	UNION  SELECT userid,CONVERT(varchar(10), MAX(dateon), 111) AS exp_date,'A017'   AS qual FROM LMS_for_OZ_View_LMS_Record_In_3 WHERE  ((course LIKE '%DG EXAM%')  OR (course LIKE '%DGR%'))         AND (result <> 0)  group by userid " ;
    //"	UNION  SELECT userid,CONVERT(varchar(10), MAX(dateoff),111) AS exp_date,'A018'   AS qual FROM LMS_for_OZ_View_LMS_Record_In_3 WHERE  (course LIKE '%Recurrent CBT%' AND course LIKE '%2nd half%' ) AND (result <> 0)  group by userid " +
    //"	UNION  SELECT userid,CONVERT(varchar(10), MAX(dateon), 111) AS exp_date,'A026'   AS qual FROM LMS_for_OZ_View_LMS_Record_In_3 WHERE  (course LIKE '%Recurrent CBT%' AND course LIKE '%1st half%' ) AND (result <> 0)  group by userid " +
    //"	UNION  SELECT userid,CONVERT(varchar(10), MAX(dateoff),111) AS exp_date,'A027-1' AS qual FROM LMS_for_OZ_View_LMS_Record_In_3 WHERE  (course LIKE '%Recurrent CBT%' AND course LIKE '%2nd half%' ) AND (result <> 0)  group by userid " +
    //"	UNION  SELECT userid,CONVERT(varchar(10), MAX(dateoff),111) AS exp_date,'A028-1' AS qual FROM LMS_for_OZ_View_LMS_Record_In_3 WHERE  (course LIKE '%Recurrent CBT%' AND course LIKE '%1st half%' ) AND (result <> 0)  group by userid ";


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
	//"    UNION  SELECT userid,CONVERT(varchar(10), MAX(TrainingEnd), 111)   AS exp_date,'A018' AS qual FROM XT_TRMS_RESUME WHERE (PackageName LIKE '%Requa%')  GROUP BY UserID " +
	"    UNION  SELECT userid,CONVERT(varchar(10), MAX(TrainingEnd), 111)   AS exp_date,'A021' AS qual FROM XT_TRMS_RESUME WHERE (PackageName LIKE '%Requa%')  GROUP BY UserID " +
 	"    UNION  SELECT userid,CONVERT(varchar(10), MAX(TrainingStart), 111) AS exp_date,'A021' AS qual FROM XT_TRMS_RESUME WHERE (PackageName LIKE '%PT%') AND (Result = 'Complete') GROUP BY UserID " +
	"    UNION  SELECT userid,CONVERT(varchar(10), MAX(TrainingEnd), 111)   AS exp_date,'A022' AS qual FROM XT_TRMS_RESUME WHERE (PackageName LIKE '%Requa%')  GROUP BY UserID ";
	//"    UNION  SELECT userid,CONVERT(varchar(10), MAX(TrainingEnd), 111)   AS exp_date,'A026' AS qual FROM XT_TRMS_RESUME WHERE (PackageName LIKE '%Requa%')  GROUP BY UserID " +
   	//"    UNION  SELECT userid,CONVERT(varchar(10), MAX(TrainingEnd), 111)   AS exp_date,'A028-1' AS qual FROM XT_TRMS_RESUME WHERE (PackageName LIKE '%Requa%')  GROUP BY UserID " +
	//"    UNION  SELECT userid,CONVERT(varchar(10), MAX(TrainingEnd), 111)   AS exp_date,'A028-2' AS qual FROM XT_TRMS_RESUME WHERE (PackageName LIKE '%Requa%')  GROUP BY UserID " +
	//"    UNION  SELECT userid,CONVERT(varchar(10), MAX(TrainingEnd), 111)   AS exp_date,'A029' AS qual FROM XT_TRMS_RESUME WHERE (PackageName LIKE '%Requa%')  GROUP BY UserID " +		  
 	//"    UNION  SELECT userid,CONVERT(varchar(10), MAX(TrainingStart), 111) AS exp_date,'A029' AS qual FROM XT_TRMS_RESUME WHERE (PackageName LIKE '%PT4%')    GROUP BY UserID ";
    
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
	"	INSERT INTO fztlicchk_temp (fleet,rank,empno,cname,exp_dt,takeoff,landing,qual,itemname)  	" + 
	"	(   									" +
	"	SELECT 	crew.fleet fleet,  						" +
       	"		crew.occu  rank, 						" +
       	"		crew.empno empno,  						" +
       	"		crew.name  cname,  						" +
       	"		TRUNC(lic.exp_dt, 'DDD') exp_date,  				" +
	"               0 takeoff,							" +
	"               0 landing,							" +
       	"		'A001' qual,      						" +   
		"       '' chkitemname                       " +   /*cs40 added*/
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
       	"		'A002' qual,      						" +   
		"       '' chkitemname                       " +   /*cs40 added*/
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
       	"		'A003' qual,         						" +
		"       '' chkitemname                       " +   /*cs40 added*/		
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
       	"	      	ADD_MONTHS(TRUNC(passport.exp_dt, 'DDD'),-6)  exp_date,		" +
	"               0 takeoff,							" +
	"               0 landing,							" +
       	"	       	'A004' qual,         						" +
		"           '' chkitemname                       " +   /*cs40 added*/		
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
       	"	       	'A005' qual,         						" +
		"           '' chkitemname                       " +  /*cs40 added*/
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
       	"	       	'A006' qual,         						" +
		"           '' chkitemname                       " +  /*cs40 added*/
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
       	"	       	'A007' qual,         						" +
		"           '' chkitemname                       " +  /*cs40 added*/
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
       	"	       	'A008' qual,         						" +
		"           '' chkitemname                       " +  /*cs40 added*/
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
       	"	       	'A009' qual,         						" +
		"           '' chkitemname                       " +  /*cs40 added*/
  	"	  FROM 	fzdb.crew_licence_v lic,					" +
        "       	(SELECT *							" +
       	"		   FROM dfdb.dftcrew						" +
        "    		  WHERE flag = 'Y'  						" +
       	"		    AND cabin = 'A' 						" +
       	"		    AND analysa = '100' 					" +
      	"		    AND fleet IN ('744') 					" +
	"                   AND (substr(empno,1,1) = '3' OR substr(empno,1,3) = '486')) crew   " +
        "  	 WHERE lic.staff_num(+) = crew.empno					" +
        "  	   AND lic.licence_cd(+) = 'CHN'						" +
	"	UNION      								" +    // A010  LUX VISA(for EXP)(LU)
	"	SELECT 	crew.fleet fleet,						" +
	"	       	crew.occu  rank,  						" +
       	"	       	crew.empno empno, 						" +
       	"	       	crew.name  cname,						" +
       	"	      	TRUNC(visa.exp_dt, 'DDD') exp_date,				" +
	"               0 takeoff,							" +
	"               0 landing,							" +
       	"	       	'A010' qual,         						" +
        "           '' chkitemname                       " +  /*cs40 added*/		
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
       	"	       	'A011' qual,         						" +
		"           '' chkitemname                       " +  /*cs40 added*/
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
       	"	       	'A012' qual,         						" +
		"           '' chkitemname                       " +  /*cs40 added*/
  	"	 FROM 	fzdb.crew_licence_v lic,					" +
        "       	(SELECT *							" +
       	"		   FROM dfdb.dftcrew						" +
        "    		  WHERE flag = 'Y'  						" +
       	"		    AND cabin = 'A' 						" +
       	"		    AND analysa = '100' 					" +
	"                   AND (substr(empno,1,1) = '3' OR substr(empno,1,3) = '486')) crew   " +
        "  	 WHERE lic.staff_num(+) = crew.empno					" +
        "  	   AND lic.licence_cd(+) = 'CMC'					" +
	"        UNION  	    							" +  // 放在 A025 內   A013-1 Recency (45/FLT)
	"        SELECT crew.fleet fleet, 						" +  // A013-2 Recency (90/TO&LD)
        "               crew.occu rank, 						" +  // fzdb.fztlicchk_a013 FROM STORE PROCEDURE
        "      		crew.empno empno, 						" +
        "		crew.name || flog.ac_type cname, 				" +
       	"		TRUNC(SYSDATE, 'DDD') exp_date,					" +
       	"		NVL(flog.takeoff, 0) takeoff, 					" +
       	"		NVL(flog.landing, 0) landing,  					" +
       	"		'A013-2' qual, 							" +
		"       '' chkitemname                       " +  /*cs40 added*/
  	"	FROM (SELECT empno empno, 						" +
        "		     ac_type ac_type, 						" +
        "                    SUM(nvl(today, 0)) + SUM(nvl(tonit, 0)) + SUM(nvl(sim, 0) * 2) takeoff,    " +
        "                    SUM(nvl(ldday, 0)) + SUM(nvl(ldnit, 0)) + SUM(nvl(sim, 0) * 2) landing 	" +
        "	      FROM   fzdb.fztlicchk_a013 					" +
        "	      WHERE  a013_2_date BETWEEN 					" +
        "	             TRUNC(TO_DATE('" +checkdate+ "','YYYY-MM-DD') - 90, 'DDD') AND 	" +
        "	             TRUNC(TO_DATE('" +checkdate+ "','YYYY-MM-DD'), 'DDD') 		" +
        "	      GROUP BY empno,ac_type) flog, 					" +
       	"	     (SELECT * 								" +
        "	      FROM   dfdb.dftcrew 						" +
        "	      WHERE  flag = 'Y' 						" +
        "	        AND  cabin = 'A' 						" +
        "	        AND analysa = '100') crew 					" +
 	"	WHERE flog.empno(+) = crew.empno 					" +
	"	UNION      								" +    // A014 CRM
	"	SELECT 	crew.fleet fleet, 						" +
	"       	crew.occu  rank, 						" +
	"       	crew.empno empno, 						" +
	"       	crew.name  cname, 						" +
	"       	elearning.exp_date exp_date, 					" +
	"               0 	   takeoff,						" +
	"               0 	   landing,						" +
	"       	'A014'     qual, 						" +
	"           '' chkitemname                       " +  /*cs40 added*/
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
	"       	'A015'     qual, 						" +
	"           '' chkitemname                       " +  /*cs40 added*/
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
	"       	'A016'     qual, 						" +
	"           '' chkitemname                       " +  /*cs40 added*/
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
	"       	'A017'     qual, 						" +
	"           '' chkitemname                       " +  /*cs40 added*/
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
	"       	'A018'     qual, 						" +
	"           '' chkitemname                       " +  /*cs40 added*/
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
    	"   		'A019' qual, 							" + 
		"           '' chkitemname                       " +  /*cs40 added*/
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
	"       'A020' qual, 								" + 
	"       '' chkitemname                       " +  /*cs40 added*/
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
	"       	'A021'     qual, 						" +
	"           '' chkitemname                       " +  /*cs40 added*/
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
        "                     UNION ALL 						" + 
        "       	      SELECT  t.empno empno,t.tdate exp_date,'A021' qual 	" + 
        "       	      FROM    dfdb.dfttest t, 					" + 
        "               	      dfdb.dfttrni i 					" + 
        "       	      WHERE   t.itemno2 = i.itemno   				" + 
        "         	        AND   i.itemno IN ('TC32','TC33') 			" +  //  PT(1ST HALF)
        "         	        AND  t.grade = 'PASSED'  				" +  //  PT(2ND HALF)        
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
	" ADD_MONTHS(TO_DATE(SUBSTR(elearning.expitem,1,8),'YYYYMMDD'),8)  exp_date, " +    /*cs40 modified*/ /*ADD_MONTHS(elearning.exp_date,8) exp_date,*/
	"       0 takeoff, 								" +
	"       0 landing, 								" +
	"       'A022' qual, 								" +
	"       substr(elearning.expitem,9) chkitemname              " +  /*cs40 added*/
 	"	FROM (SELECT  empno, MAX(TO_CHAR(exp_date,'YYYYMMDD')||itemname) expitem   " +/*cs40 modified*/ /*MAX(exp_date) exp_date*/
        "	      FROM   (  							" +
        "      		      SELECT  empno,exp_date,qual, '' itemname "+/*cs40 added: itemname*/
        "      		      FROM    fzdb.fztlicms_temp 				" +
        "      		      WHERE   qual = 'A022' 					" +
        "       	      UNION ALL    						" +
        "      		      SELECT  empno,cdate exp_date,'A022' qual, (select itemname from dztchks where itemno=dztsimr.chktype) itemname " + /*cs40 added: itemname*/
        "      		      FROM    dztsimr   					" +
        "      		      WHERE   chktype IN  					" +
        "                   	     (SELECT itemnO FROM dztchks 			" +
        "                   	       WHERE itemname = 'TYPE RATING' 			" +
        "                   	          OR itemname LIKE 'PC-%' 			" +
        "                   	          OR itemname LIKE 'LOCAL')			" +
        "      			AND    s11 = 'S'   					" +        
        "    		     )								" +
        "	GROUP BY empno) elearning, 						" + /*cs40 added: itemname*/
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
	"       crew.name || elearning.ac_type cname, 					" +
	"       ADD_MONTHS(elearning.exp_date,13) exp_date, 				" +
	"       0 takeoff, 								" +
	"       0 landing, 								" +
	"       'A023' qual, 								" +
	"       '' chkitemname                       " +  /*cs40 added*/
 	"	FROM (SELECT  empno,			   				" +
	"             	      CASE WHEN SUBSTR(ac_type,1,2) = '33' THEN '333' 		" +
        "             		   WHEN SUBSTR(ac_type,1,2) = '34' THEN '343' 		" +
        "             		   WHEN SUBSTR(ac_type,1,2) = '73' THEN '738' 		" +
        "             		   WHEN SUBSTR(ac_type,1,2) = '74' THEN '744' 		" +
        "         	      END ac_type, 						" +
        "        	      MAX(exp_date) exp_date 					" +
        "	      FROM   (  							" +
 //       "      		      SELECT  empno,exp_date,qual 				" +
 //       "      		      FROM    fzdb.fztlicms_temp 				" +
 //       "      		      WHERE   qual = 'A023' 					" +
 //       "       	      UNION ALL    						" +
        "      		      SELECT  empno,actp ac_type,cdate exp_date,'A023' qual  	" +
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
	"                       AND    empno||actp IN   				" +  // 333/343/738/744 single
        "                    		 (SELECT a.empno||a.ac_type 			" + 
        "                        	  FROM   fzdb.fztckpl a, fzdb.fztstus b 	" +
        "                       	  WHERE  a.status = b.status 			" +
        "                         	    AND  b.status = 1 				" +
        "                         	    AND  a.ac_type IN ('333', '343', '738', '744') 	" +
        "                         	    AND  a.empno NOT IN (SELECT a2.empno empno 		" +
        "                                               	 FROM   fzdb.fztckpl a2, fzdb.fztstus b2  " +
        "                                              		 WHERE  a2.status = b2.status 	" +
        "                                                	   AND  b2.status = 1 		" +
        "                                                	   AND  a2.ac_type IN ('333', '343')  " +
        "                                              		 GROUP  BY a2.empno 		" +
        "                                             		 HAVING COUNT(a2.empno) > 1))   " +	
        "         	    UNION  								" +
        "          	    SELECT  empno,actp ac_type,cdate exp_date,'A023' qual   	" +	
        "  	            FROM    dztsimr   						" +				
        "  	            WHERE   chktype IN  					" +					
        "           	     	      (SELECT itemnO FROM dztchks 			" +			
        "         	               WHERE (itemname = 'ANNUAL' 			" +		
        "                     	          OR  itemname = 'INITIAL' 			" +	
        "                     	          OR  itemname = 'RE-QUALIFICATION' 		" +	
        "                                 OR  itemname = 'RP CHECK' 			" +	
        "                                 OR  itemname LIKE 'PIC%')			" +	
        "                                AND  SUBSTR(itemnO,1,2) = 'CB') 		" +	
        "      			         AND  s11 = 'S' 				" +
        "                                AND  empno||actp IN  				" +  // 333/343 dual                               
        "                                      (SELECT  DISTINCT c.empno||c.ac_type	" +
        "                          		FROM fztckpl c,				" +
        "                               	(SELECT c2.empno empno			" +
        "                                  	 FROM   fztckpl c2, fztstus d2 		" +
        "                                 	 WHERE  c2.status = d2.status 		" +
        "                                   	   AND  d2.status = 1 			" +
        "                                   	   AND  c2.ac_type IN ('333', '343') 	" +
        "                                        GROUP  BY c2.empno 			" +
        "                                        HAVING COUNT(c2.empno) > 1) d 		" +
        "                                        WHERE c.empno = d.empno)   		" +      
        "    		     )								" +
        "	GROUP BY empno,								" +
	"		 CASE WHEN SUBSTR(ac_type,1,2) = '33' THEN '333' 		" +
        "             	      WHEN SUBSTR(ac_type,1,2) = '34' THEN '343' 		" +
        "             	      WHEN SUBSTR(ac_type,1,2) = '73' THEN '738' 		" +
        "             	      WHEN SUBSTR(ac_type,1,2) = '74' THEN '744' 		" +
        "         	 END ) elearning,	 					" +
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
	"       'A024' qual, 								" +
	"       '' chkitemname                       " +  /*cs40 added*/
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
        " SELECT fleet,rank,empno,cname,exp_dt,takeoff,landing,qual,                     " +
			"       '' chkitemname                      " +  /*cs40 added*/
        "  FROM  fzdb.fztlicchk_a025                                                    " + 
	"	UNION      								" +    // A026 Specific qualification-RVSM
	"	SELECT 	crew.fleet fleet, 						" +
	"       	crew.occu  rank, 						" +
	"       	crew.empno empno, 						" +
	"       	crew.name  cname, 						" +
	"       	elearning.exp_date  exp_date, 					" +
	"       	0 	   takeoff, 						" +
	"       	0 	   landing, 						" +
	"       	'A026'     qual, 						" +
		"       '' chkitemname                       " +  /*cs40 added*/
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
	"       	'A027-1'     qual,						" +
		"       '' chkitemname                       " +  /*cs40 added*/
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
	"       'A027-2' qual, 								" + 
	"       '' chkitemname                       " +  /*cs40 added*/
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
	"       	'A028-1'     qual, 						" +
		"       '' chkitemname                       " +  /*cs40 added*/
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
	"       'A028-2' qual, 								" +
	"       '' chkitemname                       " +  /*cs40 added*/
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
	"       	'A029'     qual, 						" +
		"       '' chkitemname                       " +  /*cs40 added*/
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
                "     (select NVL(TO_CHAR(exp_dt,'yyyy-mm-dd'),'') rat from fztlicchk_temp where empno=dd.empno and qual='A001' and rownum=1) rat, " +
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
		    "	     CASE WHEN qual = 'A013-2' THEN takeoff || ' | ' || landing 		" +
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
		    "		     WHEN qual = 'A009' then 'China VISA (for EXP)(CHN)' 		" +
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
		    "		     WHEN qual = 'A025' then 'Specific qualification-LVO(CAT II IIIa/IIIb)' 	" +
		    "		     WHEN qual = 'A026' then 'Specific qualification-RVSM' 		" +
		    "		     WHEN qual = 'A027-1' then 'ETOPS CBT Training' 			" +
		    "		     WHEN qual = 'A027-2' then 'ETOPS Route Experience' 		" +
		    "		     WHEN qual = 'A028-1' then 'TCAS CBT Training' 			" +
		    "		     WHEN qual = 'A028-2' then 'TCAS SIM Check' 			" +
		    "		     WHEN qual = 'A029' then 'Equipment qualification-GPWS/EGPWS' 	" +
		    "		     ELSE qual  							" +
 		    "		END  qual_n, 								" +
			"       chkitemname                        " + /*cs40 added*/ 
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
                    "                   END effective, 							" +
					"                   ITEMNAME chkitemname       " + /*cs40 added*/
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
	sql_query = "	SELECT fleet, " +
	                "     (select NVL(TO_CHAR(exp_dt,'yyyy-mm-dd'),'') rat from fztlicchk_temp where empno=dd.empno and qual='A001' and rownum=1) rat, " +
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
		    "	     CASE WHEN qual = 'A013-2' THEN takeoff || ' | ' || landing 			" +
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
		    "		     WHEN qual = 'A009' then 'China VISA (for EXP)(CHN)' 			" +
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
		    "		     WHEN qual = 'A025' then 'Specific qualification-LVO(CAT II IIIa/IIIb)' 	" +
		    "		     WHEN qual = 'A026' then 'Specific qualification-RVSM' 			" +
		    "		     WHEN qual = 'A027-1' then 'ETOPS CBT Training' 				" +
		    "		     WHEN qual = 'A027-2' then 'ETOPS Route Experience' 			" +
		    "		     WHEN qual = 'A028-1' then 'TCAS CBT Training' 				" +
		    "		     WHEN qual = 'A028-2' then 'TCAS SIM Check' 				" +
		    "		     WHEN qual = 'A029' then 'Equipment qualification-GPWS/EGPWS' 		" +
		    "		     ELSE qual  								" +
 		    "		END  qual_n, 									" +
			"       chkitemname                            " + /*cs40 added*/ 
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
                    "                   END effective, 								" +     
	    			"                   ITEMNAME chkitemname       " + /*cs40 added*/
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
		ratAL.add(rs.getString("rat"));
		qual_idAL.add(rs.getString("qual"));
		chkitemnameAL.add(rs.getString("chkitemname"));
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
	out.println("SELECT FROM fztlicchk_temp ERROR:<br>"+e.toString());	
} catch (Exception e) {
	out.println(e.toString());	
} finally {
	if ( rs 	  != null ) try { rs.close();} 		 catch (SQLException e) {}
	if ( pstmt_query  != null ) try { pstmt_query.close();}  catch (SQLException e) {}
	if ( pstmt_insert != null ) try { pstmt_insert.close();} catch (SQLException e) {}
	if ( conn 	  != null ) try { conn.close();	} 	 catch (SQLException e) {}
}

//roster assign
String lastDate = "";
String lastItem = "";
String nextItem = "";
String chkitemname ="";
String userInput = "";
String schedDate = "";
CrewQual qual = new CrewQual(); 
if((qual_id.equals("A021") ||qual_id.equals("A022") ||qual_id.equals("A023") ||
	qual_id.equals("A014") ||qual_id.equals("A015") ||qual_id.equals("A016") || qual_id.equals("A017"))
	&& null!=empnoAL && null!= checkdate){
	qual.getUserInputDt(empnoAL, qualification);
	//qual.getAssignDt( empnoAL , qualification , checkdate);
}


%>
<html>
<head>
<title>Crew Qualification Check List</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
<link href="../menu.css" rel="stylesheet" type="text/css">
<script src="../js/subWindow.js"></script>
</head>
<body>

<%
if(empnoAL.size() == 0){

%>
	<div align="center"><span class="txtxred">查無符合篩選條件的資料<br>No information match the filter conditions!! <br></span></div>
<% 

}else{

%>
<p align="center" class="style3">

<div align="center" class="style3">
  <div align="center">
  (New)
    <table width="95%" border="0" cellpadding="0" cellspacing="0">
       <tr> 
         <td align="right">
           <div align="right" class="style5">
		   <a href="../tsa/crewqual/saveFile.jsp?filename=<%=filename%>.csv"><img src="../images/ed4.gif" border="0">Download File		   </a>&nbsp;&nbsp;
		   <a href="javascript:window.print()">請設為橫印<img src="../images/print.gif" width="17" height="15" border="0" alt="列印"></a></div>
         </td>
       </tr>
    </table>
  </div>
</div>
<p align="center" class="style3">

<div align="center"> 
 <%

   fw.write("Fleet,Rank,EmpNo,Cname,Exp_dt,Qualification,Effective,RAT exp_dt,Last_dt,LastItem,NextItem,Sys_dt\\UserInput_dt,Schedule_dt"+"\r\n");
 
 %>
  <form name="form1" method="post" action="">
    <table width="100%" border="0" bordercolor="#666666" class="fortable">    
      <tr> 
	<td width="5%" > 
        <div align="center" class="tablehead3"><b><font size="2"><font face="Arial, Helvetica, sans-serif">Fleet</font></font></b></div></td>
	<td width="5%" > 
        <div align="center" class="tablehead3"><b><font size="2"><font face="Arial, Helvetica, sans-serif">Rank</font></font></b></div></td>
	<td width="7%" > 
        <div align="center" class="tablehead3"><b><font size="2"><font face="Arial, Helvetica, sans-serif">EmpNo</font></font></b></div></td>
	<td width="8%" > 
        <div align="center" class="tablehead3"><b><font size="2"><font face="Arial, Helvetica, sans-serif">Cname</font></font></b></div></td>
    <td width="10%" > 
        <div align="center" class="tablehead3"><b><font size="2"><font face="Arial, Helvetica, sans-serif">Exp_dt</font></font></b></div></td>
    <td width="10%" > 
        <div align="center" class="tablehead3"><b><font size="2"><font face="Arial, Helvetica, sans-serif">Qualification</font></font></b></div></td>
    <td width="5%" > 
        <div align="center" class="tablehead3"><b><font size="2"><font face="Arial, Helvetica, sans-serif">Effective</font></font></b></div></td>
        <!-- CS40 added 2013/11-->
		<td width="10%" ><div align="center" class="tablehead3"><b><font size="2"><font face="Arial, Helvetica, sans-serif">RAT exp_dt</font></font></b></div></td>
        <td width="10%" ><div align="center" class="tablehead3"><b><font size="2"><font face="Arial, Helvetica, sans-serif">Last date</font></font></b></div></td>
        <td width="5%" ><div align="center" class="tablehead3"><b><font size="2"><font face="Arial, Helvetica, sans-serif">Last Item</font></font></b></div></td>
        <td width="5%"  ><div align="center" class="tablehead3"><b><font size="2"><font face="Arial, Helvetica, sans-serif">Next Item</font></font></b></div></td>
        <td width="12%" ><div align="center" class="tablehead3"><b><font size="2"><font face="Arial, Helvetica, sans-serif">系統預排 </font><br><font color="#0000FF">承辦人輸入</font></strong></font></b></div></td>
        <td width="8%" ><div align="center" class="tablehead3"><b><font size="2"><font face="Arial, Helvetica, sans-serif">班表安排日期</font></font></b></div></td>
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
	    <!-- CS40 Added 2013/11 ,CS80 2014/01 modify-->
		<td class="tablebody"><div align="left"><%=ratAL.get(i)%></div></td>
		<%
		java.util.Date d = new java.util.Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");	
		try {d = sdf.parse((String)(exp_dtAL.get(i)));} catch (Exception e) {}
		Calendar cal = new GregorianCalendar();//last date
		cal.setTime(d);
		//PT, PC	
		if (qual_idAL.get(i).equals("A021") | qual_idAL.get(i).equals("A022")) { 					
			cal.add(Calendar.MONTH, -8);
			lastDate = sdf.format(cal.getTime());
		//ET
		}else if (qual_idAL.get(i).equals("A016")) {	
			cal.add(Calendar.MONTH, -16);
		    lastDate = sdf.format(cal.getTime());
		//RC
		}else if (qual_idAL.get(i).equals("A023")) { 			
			cal.add(Calendar.MONTH, -13);
		    lastDate = sdf.format(cal.getTime());
		}else{
			lastDate = (String)exp_dtAL.get(i);
		} //if 
		if(null == lastDate){
			lastDate="";	
		}
		%>
		<td class="tablebody"><div align="left"><%=lastDate %></div></td>	
		<td class="tablebody"><div align="left">
		<%if(null ==chkitemnameAL.get(i)) { 
			chkitemname=""; 
			out.println("&nbsp;");
		}else{
			chkitemname = (String)chkitemnameAL.get(i);
			out.println(chkitemname);
		}%></div></td>
		<% 
		if ("PC-1".equals(chkitemnameAL.get(i)))      nextItem = "PC-2";
		else if ("PC-2".equals(chkitemnameAL.get(i))) nextItem = "PC-3";
		else if ("PC-3".equals(chkitemnameAL.get(i))) nextItem = "PC-4";
		else if ("PC-4".equals(chkitemnameAL.get(i))) nextItem = "PC-5";
		else if ("PC-5".equals(chkitemnameAL.get(i))) nextItem = "PC-6";
		else if ("PC-6".equals(chkitemnameAL.get(i))) nextItem = "PC-1";
		else nextItem =""; %>
		<td class="tablebody"><div align="left"><%if("".equals(nextItem)) out.println("&nbsp;"); else out.println(nextItem);%></div></td>
		<td class="tablebody"><div align="left">
		<%
		if(null!=qual.getInCkajDtHT()){
		 	userInput = (String)qual.getInCkajDtHT().get((String)empnoAL.get(i)+qual_idAL.get(i));
		 	if(null == userInput || "".equals(userInput)){
		 		userInput = "";
		 	}
		}
		
		if (!"".equals(userInput)) { //承辦人已輸入複訓日期 	 
		%>
		    <strong><font color="#0000FF"><%=userInput%></font></strong>
		<%	
		}else{ 
			SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM");	
			try {d = sdf1.parse((String)(exp_dtAL.get(i)));} catch (Exception e) {}
			cal.setTime(d);
			//PT, PC	
			if (qual_idAL.get(i).equals("A021") | qual_idAL.get(i).equals("A022")) { 					
				cal.add(Calendar.MONTH, -2);//last date+6個月
			    userInput = sdf.format(cal.getTime()).substring(0,7);
			//RC,CRM,SS,ET,DG
			}else if (qual_idAL.get(i).equals("A023")|qual_idAL.get(i).equals("A014")|qual_idAL.get(i).equals("A015")|qual_idAL.get(i).equals("A016")|qual_idAL.get(i).equals("A017")) { 			
				cal.add(Calendar.MONTH, -4);//last date+12個月
			    userInput = sdf.format(cal.getTime()).substring(0,7);
			}else{
			    userInput = "";//&nbsp;
			} //if 
			%>
			<%if("".equals(userInput)) out.println("&nbsp;"); else out.println(userInput);%>
		<%
		}
		if("A021".equals(qual_idAL.get(i)) || "A022".equals(qual_idAL.get(i)) || "A023".equals(qual_idAL.get(i)) || 
					"A014".equals(qual_idAL.get(i)) || "A015".equals(qual_idAL.get(i)) ||"A016".equals(qual_idAL.get(i)) ||"A017".equals(qual_idAL.get(i)) ){
		%>
		<a href="#" onClick="subwinXY('OZTrn/pc_update_form.jsp?curremp=<%=(String)empnoAL.get(i)%>&currname=<%=cnameAL.get(i)%>&chktype=<%=qual_idAL.get(i)%>', '', '400', '300')">
				  <img src="OZTrn/img/pencil.gif" border="0" alt="修改"></a>
			</div></td>
		<%
		}
		%>
		<td class="tablebody"><div align="left">
		
		<%/*if(null!=qual.getInRosDtHT()){
		 	schedDate = (String)qual.getInRosDtHT().get((String)empnoAL.get(i)+qual_idAL.get(i));
		 	if(null == schedDate || "".equals(schedDate)){
		 		schedDate = "";
		 	}
		  }*/
		  %>
		  <%if("".equals(schedDate)) out.println("&nbsp;"); else out.println(schedDate);%>
	</div></td>
	  </tr>
	  <%
	    fw.append(fleetAL.get(i)+","+rankAL.get(i)+","+empnoAL.get(i)+","+cnameAL.get(i)+","+exp_dtAL.get(i)+","+qualAL.get(i)+","+effectiveAL.get(i)+","
	    +ratAL.get(i)+","+lastDate+","+chkitemname+","+nextItem+","+userInput+","+schedDate+"\r\n");
	    
	    fw.flush(); 

        }
	    fw.close();
	  %>
      
    </table>
  
  </form>
</div>
<% } 
%>
</body>
</html>
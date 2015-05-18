package al;

import ci.db.ConnDB;
import java.sql.*;

public class ALInfo
{
	private Connection con = null;
	private Statement stmt = null;
	private Driver dbDriver = null;
	private ResultSet myResultSet = null;
	
	private String sql = null;
	
	private String cdept = null;
	private String sern = null;
	private String jobno = null;
	private String cname = null;
	private String station = null;
	private String indate = null;
	private String sex = null;
	
	private String lastdays = null;
	private String thisdays = null;
	private String nextdays = null;
	
	private String sdate = null;
	private String edate = null;
	private String pur = null;
	private String fa = null;
	private String fs = null;
	private String kpur = null;
	private String kcrew = null;
	private String tyo_crew = null;
	private String offday = null;
	private String papers = null;
	private String openday = null;
	private String opentime = null;
	private String kor_crew = null;
	
	int cuser = 0;
	
	public static void main(String[] args)
    {
	    ALInfo ai = new ALInfo();
	    ai.setCrewInfo("635856");
	    System.out.println(ai.getSex());	    
        System.out.println("Done");
    }
	
	
	
	//check user login Id and Password
        public String chkUser(String userid, String password)
        {
        	PreparedStatement pstmt = null;
        	String checkFlag = "";
        	ConnDB cn = new ConnDB();
        	
		try{
			cn.setORP3FZUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			con = dbDriver.connect(cn.getConnURL(), null);
			
//			cn.setORP3EGUser();
//			java.lang.Class.forName(cn.getDriver());
//			con = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW()); 
			
			sql = "select count(*) cuser from fztuser where userid=? and pwd=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,userid);
	        	pstmt.setString(2,password);
			myResultSet = pstmt.executeQuery();
			if (myResultSet != null)
			{
				while(myResultSet.next())
				{
					cuser = myResultSet.getInt("cuser");
				}  
			}
			if (cuser == 0)
			{
				//Id or Password failed
				checkFlag =  "-1";
			}else{
			       checkFlag =  "0";
			}
			
		}
		catch(Exception e){
			//get data error
			checkFlag = e.toString();
		}
		finally{
			try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
			try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
			try{if(con != null) con.close();}catch(SQLException e){}
		}
		return checkFlag;
        }
        //get crew basic information (cdep, sern, jobno, cname, station, indate)
        //can input empno or sern
        public String setCrewInfo(String empno){
        	int xCount = 0;
        	ConnDB cn = new ConnDB();
		try{
			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			con = dbDriver.connect(cn.getConnURL(), null);
			
//			cn.setORP3EGUser();
//			java.lang.Class.forName(cn.getDriver());
//			con = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW()); 
			
			
			stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                                      		   ResultSet.CONCUR_UPDATABLE);
			
			sql = "select b.cdept cdept, a.cname cname, a.sern sern, a.jobno jobno, a.station station, a.sex sex, " + 
			"to_char(a.indate, 'yyyy-mm-dd') indate from egdb.egtcbas a, egdb.egtdept b where a.deptno = b.deptno " +
			"and (trim(a.empn) = '"+empno+"' or a.sern = '" + empno + "')";
			myResultSet = stmt.executeQuery(sql);
			if (myResultSet != null)
			{
				while (myResultSet.next())
				{
					this.cdept = myResultSet.getString("cdept");
					this.sern = myResultSet.getString("sern");
					this.jobno = myResultSet.getString("jobno");
					this.cname = myResultSet.getString("cname");
					this.station = myResultSet.getString("station");
					this.indate = myResultSet.getString("indate");
					this.sex = myResultSet.getString("sex");
					xCount++;
				}  
			}
			if (xCount == 0)
			{
				//not cabin crew
				return "1";
			}
			//get data success
			return "0";
		}
		catch(Exception e){
			//get data error
			return e.toString();
		}
		finally{
			try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
			try{if(stmt != null) stmt.close();}catch(SQLException e){}
			try{if(con != null) con.close();}catch(SQLException e){}
		}
        }
        //get crew AL days information (lastdays, thisdays, nextdays)
        //can input empno or sern
        public String setALDays(String empno){
        	int xCount = 0;
        	ConnDB cn = new ConnDB();
		try{
			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			con = dbDriver.connect(cn.getConnURL(), null);
			
//			cn.setORP3EGUser();
//			java.lang.Class.forName(cn.getDriver());
//			con = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW()); 		
			
			stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                                      		   ResultSet.CONCUR_UPDATABLE);
			
			sql = "select * from egtcoff where (trim(empn) = '"+empno+"' or sern = " + empno + ")";
			myResultSet = stmt.executeQuery(sql);
			if (myResultSet != null)
			{
				while (myResultSet.next())
				{
					this.lastdays = myResultSet.getString("lastdays");
					this.thisdays = myResultSet.getString("thisdays");
					this.nextdays = myResultSet.getString("nextdays");
					xCount++;
				}  
			}
			if (xCount == 0)
			{
				this.lastdays = "0";
				this.thisdays = "0";
				this.nextdays = "0";
			}
			//get data success
			return "0";
		}
		catch(Exception e){
			//get data error
			return e.toString();
		}
		finally{
			try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
			try{if(stmt != null) stmt.close();}catch(SQLException e){}
			try{if(con != null) con.close();}catch(SQLException e){}
		}
        }
        //請假限制設定資訊 (sdate, edate, pur, fa, fs, kpur, kcrew, tyo_crew, .......)
        public String setQuota(){
        	int xCount = 0;
        	ConnDB cn = new ConnDB();
		try{
			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			con = dbDriver.connect(cn.getConnURL(), null);
		    
//		    cn.setORP3EGUser();
//			java.lang.Class.forName(cn.getDriver());
//			con = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW()); 
			
			stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                                      		   ResultSet.CONCUR_UPDATABLE);
			
			sql = "select to_char(sdate, 'yyyy-mm-dd') mysdate, to_char(edate, 'yyyy-mm-dd') myedate," +
			" pur, fa, fs, kpur, kcrew, tyo_crew, offday, papers, openday, opentime, kor_crew from egtalco";
			myResultSet = stmt.executeQuery(sql);
			if (myResultSet != null)
			{
				while (myResultSet.next())
				{
					this.sdate = myResultSet.getString("mysdate");
					this.edate = myResultSet.getString("myedate");
					this.pur = myResultSet.getString("pur");
					this.fa = myResultSet.getString("fa");
					this.fs = myResultSet.getString("fs");
					this.kpur = myResultSet.getString("kpur");
					this.kcrew = myResultSet.getString("kcrew");
					this.tyo_crew = myResultSet.getString("tyo_crew");
					this.offday = myResultSet.getString("offday");
					this.papers = myResultSet.getString("papers");
					this.openday = myResultSet.getString("openday");
					this.opentime = myResultSet.getString("opentime");
					this.kor_crew = myResultSet.getString("kor_crew");
					xCount++;
				}  
			}
			if (xCount == 0)
			{
				return "No data found !";
			}
			//get data success
			return "0";
		}
		catch(Exception e){
			//get data error
			return e.toString();
		}
		finally{
			try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
			try{if(stmt != null) stmt.close();}catch(SQLException e){}
			try{if(con != null) con.close();}catch(SQLException e){}
		}
        }
        
        public String getCdept(){
        	return this.cdept;
        }
        public String getSern(){
        	return this.sern;
        }
        public String getJobno(){
        	return this.jobno;
        }
        public String getCname(){
        	return this.cname;
        }
        public String getStation(){
        	return this.station;
        }
        public String getIndate(){
        	return this.indate;
        }
        public String getLastdays(){
        	return this.lastdays;
        }
        public String getThisdays(){
        	return this.thisdays;
        }
        public String getNextdays(){
        	return this.nextdays;
        }
        public String getSdate(){
        	return this.sdate;
        }
        public String getEdate(){
        	return this.edate;
        }
        public String getPur(){
        	return this.pur;
        }
        public String getFa(){
        	return this.fa;
        }
        public String getFs(){
        	return this.fs;
        }
        public String getKpur(){
        	return this.kpur;
        }
        public String getKcrew(){
        	return this.kcrew;
        }
        public String getTyocrew(){
        	return this.tyo_crew;
        }
        public String getOffday(){
        	return this.offday;
        }
        public String getPapers(){
        	return this.papers;
        }
        public String getOpenday(){
        	return this.openday;
        }
        public String getOpentime(){
        	return this.opentime;
        }
        public String getKorcrew(){
        	return this.kor_crew;
        }
        public String getSex(){
        	return this.sex;
        }
}
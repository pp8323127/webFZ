package fz;

import javax.naming.*;
import javax.sql.DataSource;
import java.sql.*;
 
public class countACshow {
	private Context initContext = null;
	private DataSource ds = null;
	 
	/*public static void main(String[] args) {
		countACshow ac = new countACshow();
		System.out.println(ac.getACshow("2006/10/31","0004","TPE"));
	}*/
	public String getACshow(String fltd, String fltno, String dpt) {
		//fltd : yyyy/mm/ddHH24MI (schedule time)
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = null;
		String chkcnt = null;
		
		try{
			initContext = new InitialContext();
			//connect to AOCITEST / AOCIPROD by Datasource
               		ds = (javax.sql.DataSource)initContext.lookup("CAL.FZDS03");
               		con = ds.getConnection();

//			ci.db.ConnDB cn = new ci.db.ConnDB();
//			Driver dbDriver = null;
//			cn.setORP3FZUserCP();
//			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//			con = dbDriver.connect(cn.getConnURL(), null);
			
			sql = "select count(*) " +
			"from crew_dops_v a, rank_tp_v b, crew_base_v c " +
			"where a.staff_num=c.staff_num(+) " +
			"and a.acting_rank=b.display_rank_cd " +
	/* 2009/1/12 CS40 commented	"and c.base='TPE' " + //只檢查TPE crew   */
	/*2009/3/4 CS40 rollback */		"and c.base='TPE' " + //只檢查TPE crew 			
			"and (c.exp_dt >= sysdate or c.exp_dt is null) " +
			"and b.fd_ind='N' " + //cabin crew
			//"and flt_dt_tm between to_date(?,'yyyy/mm/ddHH24MI') and to_date(?,'yyyy/mm/ddHH24MI') " +
			"and flt_dt_tm = to_date(?,'yyyy/mm/ddHH24MI') " +
			"and a.item_seq_num=1 " +
			"and flt_num=? and dep_arp_cd=? " +
			"and (no_show = 'Y' or no_show is null)";
   			
			pstmt = con.prepareStatement(sql);
		        pstmt.setString(1, fltd);
		        //pstmt.setString(2, fltd + "2359");
		        pstmt.setString(2, fltno);
		        pstmt.setString(3, dpt);
		        
		        rs = pstmt.executeQuery() ;
		        
		        while(rs.next()){
		        	chkcnt = rs.getString(1);
		        }
			return chkcnt;
		} catch(Exception e) {
			return e.toString() + "SQL : " + sql; //connect error or retrieve date error
		}
		finally {
			try{if(rs != null) rs.close();}catch(SQLException e){}
	  		try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
	  		try{if(con != null) con.close();}catch(SQLException e){}
		}
	}
	public String getEGrptloc(String empno, String fltdate) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql="";
		String rptloc = " ";
		Driver dbDriver = null;
		ci.db.ConnDB cn = new ci.db.ConnDB();
		ci.db.ConnectDataSource cs = new ci.db.ConnectDataSource();
		try{
		//	initContext = new InitialContext();
			//connect to AOCITEST / AOCIPROD by Datasource
//               		ds = (javax.sql.DataSource)initContext.lookup("CAL.EGDS01");
			//ds = (javax.sql.DataSource)initContext.lookup("CAL.FZDS02");   		
			//con = ds.getConnection();
			
			
			/*
			cn.setAOCIPRODCP();
			java.lang.Class.forName(cn.getDriver());
			con = DriverManager.getConnection("jdbc:oracle:thin:@192.168.42.42:1521:ort1",
					"fzap", "FZ921002");
			*/
			
//			cn.setORP3FZUserCP();
//			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//			con = dbDriver.connect(cn.getConnURL(), null);
//			con = cs.getFZConnection();
			
			
			//2009-2-25 CS40 added
			cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	        con = dbDriver.connect(cn.getConnURL(), null);
               		
			  sql = "select rptloc from egdb.egtchkin where empno=? ";
   			if(fltdate.length() > 8){
   				sql = sql + "and sdate <= to_date('"+fltdate+"','yyyy/mm/dd') and edate >= to_date('"+fltdate+"','yyyy/mm/dd')";
   			}
   			else{
   				sql = sql + "and sdate <= to_date('"+fltdate+"','yyyymmdd') and edate >= to_date('"+fltdate+"','yyyymmdd')";
   			}
   			
			pstmt = con.prepareStatement(sql);
		        pstmt.setString(1, empno);
		        		        
		        rs = pstmt.executeQuery() ;
		        
		        while(rs.next()){
		        	rptloc = rs.getString(1);
		        }
		        if("TSA".equals(rptloc)) rptloc = " ";
			return rptloc;
		} catch(Exception e) {
			return e.toString() + "<BR>SQL : " + sql; //connect error or retrieve date error
		}
		finally {
			try{if(rs != null) rs.close();}catch(SQLException e){}
	  		try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
	  		try{if(con != null) con.close();}catch(SQLException e){}
		}
	}
}
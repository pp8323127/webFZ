package fz;

import javax.naming.*;
import javax.sql.DataSource;
import java.sql.*;
 
public class countSBcrew {
	private Context initContext = null;
	private DataSource ds = null;
	 
	/*public static void main(String[] args) {
		GetCrewInfo dr = new GetCrewInfo();
		System.out.println(dr.getLastArv("2004/10/08","HKG","633328"));
	}*/
	public String getSB(String rpt_time, String act_port_a) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = null;
		String cr = null;
		
		try{
			initContext = new InitialContext();
			//connect to AOCITEST / AOCIPROD by Datasource
               		ds = (javax.sql.DataSource)initContext.lookup("CAL.FZDS03");
               		con = ds.getConnection();
               		
			sql = "select count(*) cr " +
			"from duty_prd_seg_v dps, roster_v r " +
			"where r.series_num = dps.series_num " +
	  		"AND dps.act_str_dt_tm_gmt between to_date(?,'yyyy/mm/dd hh24mi') - (12/24) and to_date(?,'yyyy/mm/dd hh24mi') " +
			"AND dps.act_end_dt_tm_gmt between to_date(?,'yyyy/mm/dd hh24mi') and to_date(?,'yyyy/mm/dd hh24mi') + (12/24) " +
			"and dps.act_port_a=? " +
		   	"AND dps.fd_ind='N' " + 
			"AND r.delete_ind='N' " + 
			"AND r.sched_nm <> 'DUMMY' " + 
   			"AND (SubStr(dps.duty_cd,1,1)='S' or SubStr(dps.duty_cd,1,2)='HS' or dps.duty_cd='HS1' or dps.duty_cd='HS2' or dps.duty_cd='HS' )";
   			
			pstmt = con.prepareStatement(sql);
		        pstmt.setString(1, rpt_time);
		        pstmt.setString(2, rpt_time);
		        pstmt.setString(3, rpt_time);
		        pstmt.setString(4, rpt_time);
		        pstmt.setString(5, act_port_a);
		        
		        rs = pstmt.executeQuery() ;
		        
		        while(rs.next()){
		        	cr = rs.getString("cr");
		        }
			return cr;
		} catch(Exception e) {
			return e.toString() + "SQL : " + sql; //connect error or retrieve date error
		}
		finally {
			try{if(rs != null) rs.close();}catch(SQLException e){}
	  		try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
	  		try{if(con != null) con.close();}catch(SQLException e){}
		}
	}
}
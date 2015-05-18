package fz.daily;

import ci.db.ConnDB;
import java.sql.*;

public class CheckFlag {
  	private String sql = null;

	/*public static void main(String[] args) {
		CheckFlag cit = new CheckFlag();
		System.out.println(cit.getCheckInfo("2005/02/02", "0122", "TPEOKA"));
	}*/
	//IN--> '2005/02/09', '0004', 'TPESFO' return-->'Y' OR 'N'
	//檢查Aircrews(crew_dops_v column no_show)
	public String getCheckInfo(String fltd, String fltno, String sect) {
		Driver dbDriver = null;
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		ConnDB cn = new ConnDB();
		//connect to AOCIPROD
		cn.setAOCIPRODCP();
		String flag_cks = "T";
		String flag_tsa = "T";
		int rv = 0;
		boolean t = false;
		String empno = null;
		
		try{
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			con = dbDriver.connect(cn.getConnURL(), null);
			
			stmt = con.createStatement();
			
			sql = "select r.staff_num as empno, " +
			"r.acting_rank rank, dps.fleet_cd fleet, " +
			"c.preferred_name as cname " +
			"from roster_v r, duty_prd_seg_v dps, crew_v c " +
			"where r.series_num = dps.series_num and " +
			"r.staff_num=c.staff_num and " +
			"dps.fd_ind='Y' and r.delete_ind='N' and  " +
			"dps.str_dt_tm_gmt between to_date('"+fltd+"0000','yyyy/mm/ddHH24MI') and to_date('"+fltd+"2359','yyyy/mm/ddHH24MI') and " +
			"dps.flt_num = '"+fltno+"' and " +
			"dps.act_port_a||dps.act_port_b='"+sect+"' " +
			"order by dps.cop_duty_cd, r.staff_num";
			
			rs = stmt.executeQuery(sql);
			
			if(rs != null){
				while(rs.next()){
					t = true;
					rv = 0;
					empno = rs.getString("empno");
					rv = getCheckLog(fltd, fltno, sect, empno);
					if(rv == 1 && "T".equals(flag_tsa)) flag_tsa = "Y"; //TSA未報到
					if(rv == 2 && "T".equals(flag_cks)) flag_cks = "Y"; //CKS未報到
				}
			}
			if("T".equals(flag_tsa) && "T".equals(flag_cks)){
				if(t){
					rv = 0; //全報到
				}
				else{
					rv = -1; //無組員
				}
			}
			if("Y".equals(flag_tsa) && "Y".equals(flag_cks)) rv = 3; //TSA & CKS 均有未報到
			if("T".equals(flag_tsa) && "Y".equals(flag_cks)) rv = 2; //CKS 有未報到組員
			if("Y".equals(flag_tsa) && "T".equals(flag_cks)) rv = 1; //TSA 有未報到組員
			return String.valueOf(rv);
		} catch(Exception e) {
			System.out.println(e.toString());
			return e.toString(); //connect error or retrieve date error
		}
		finally {
			try{if(rs != null) rs.close();}catch(SQLException e){}
	  		try{if(stmt != null) stmt.close();}catch(SQLException e){}
	   		try{if(con != null) con.close();}catch(SQLException e){}
		}
	}
	//取得組員是否已於CRC完成證照自我檢核報到程序
	public int getCheckLog(String fltd, String fltno, String sect, String empno){
		Driver dbDriver = null;
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		ConnDB cn = new ConnDB();
		String sql = null;
		String cks = "T";
		String crc = "T";	
		int rv = 0;
		try{
			//connect to ORP3/FZ
			cn.setORP3FZUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			con = dbDriver.connect(cn.getConnURL(), null);
			stmt = con.createStatement(); 
			
			sql = "select cks, nvl(crewchk,'N') crc from fztckin where fltd=to_date('"+fltd+
			"','yyyy/mm/dd') and fltno='"+fltno+"' and sect='"+sect+"' and empno='"+empno+"'";
			rs = stmt.executeQuery(sql);
			if(rs.next()){
				cks = rs.getString("cks");
				crc = rs.getString("crc");
			}
			if(("T".equals(cks) && "T".equals(crc)) || ("N".equals(cks) && "N".equals(crc))){
				rv = 1; //TSA未報到
			}
			else if("Y".equals(cks) && "N".equals(crc)){
				rv = 2; //CKS未報到
			}
			return rv;
		} catch(Exception e) {
			System.out.println(e.toString());
			return -3;
		}
		finally {
			try{if(rs != null) rs.close();}catch(SQLException e){}
			try{if(stmt != null) stmt.close();}catch(SQLException e){}
			try{if(con != null) con.close();}catch(SQLException e){}
		}
	}
}
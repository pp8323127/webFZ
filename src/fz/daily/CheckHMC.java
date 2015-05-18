package fz.daily;

import javax.naming.*;
import javax.sql.DataSource;
import java.sql.*;
 
public class CheckHMC {
	private Context initContext = null;
	private DataSource ds = null;
	 
	/*public static void main(String[] args) {
		GetCrewInfo dr = new GetCrewInfo();
		System.out.println(dr.getLastArv("2004/10/08","HKG","633328"));
	}*/
	public String doCheck(String fltdate, String fltno, String sect) {
		//fltdate : yyyy/mm/dd HH24MI (TPE Time)
		//fltno : 0003
		//sect : TPEHKG
		Connection con = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		
		String sql = null;
		int hmc = 0;
		String rstring = ""; //*************
						
		try{
			initContext = new InitialContext();
			//connect to ORP3 / DF by Datasource
               		ds = (javax.sql.DataSource)initContext.lookup("CAL.DFDS01");
               		con = ds.getConnection();
               		//******************************************
               		//Class.forName("oracle.jdbc.driver.OracleDriver");
   			//con = DriverManager.getConnection("jdbc:oracle:thin:@192.168.242.55:1521:ORP3","dfdb","df$888");
               		//******************************************
               		
			sql = "select r.staff_num, k.rank_cd " +
			"from dfdb.roster_v r, dfdb.duty_prd_seg_v dps, dfdb.crew_rank_v k " +
			"where r.series_num = dps.series_num " + 
			"and r.staff_num = k.staff_num " +
			"and (exp_dt > sysdate or exp_dt is null) " +
			"and dps.fd_ind='Y' " + 
			"and r.delete_ind='N' " + 
			"and dps.act_port_a||dps.act_port_b=? " + 
			"and dps.act_str_dt_tm_gmt = to_date(?,'yyyy/mm/dd HH24MI') " + 
			"and dps.flt_num =?";
   			
			pstmt = con.prepareStatement(sql);
		        pstmt.setString(1, sect);
		        pstmt.setString(2, fltdate);
		        pstmt.setString(3, fltno);
	        
		        rs = pstmt.executeQuery();
		        
		        while(rs.next()){
		        	int my3Xcount = 0;
		        	String fleetString = "";
		        	//*******只檢查CA, 一個航班只需一個CA符合資格即可
				if("CA".equals(rs.getString(2))){
			        	//取得AirCrews組員資料
			        	pstmt2 = con.prepareStatement("select fleet_cd " +
					"from dfdb.crew_fleet_v " +
					"where staff_num=? " +
					"and (exp_dt >= sysdate or exp_dt is null) " +
					"and valid_ind = 'Y'");
					pstmt2.setString(1, rs.getString(1));
					rs2 = pstmt2.executeQuery();
					while(rs2.next()){
						if("333".equals(rs2.getString(1)) || "343".equals(rs2.getString(1))) my3Xcount++;
						if("738".equals(rs2.getString(1))){
							fleetString = fleetString + "'" + rs2.getString(1) + "','737',";
						}
						else{
							fleetString = fleetString + "'" + rs2.getString(1) + "',";
						}
					}
					rs2.close();
					pstmt2.close();
					if(!"".equals(fleetString)) fleetString = fleetString.substring(0, fleetString.length()-1);
			        	if(my3Xcount == 2){ //343,333雙機隊 100Hr = 6000min
			        		sql = "select (select case when(sum(pic3)<6000) then 0 else 1 end case " +
			        		"from dftcrec where staff_num=? and fleet_cd in ('333')) " +
						"+(select case when(sum(pic3)<6000) then 0 else 1 end case " +
						"from dftcrec where staff_num=? and fleet_cd in ('343')) " +
						"from dual";
				        }
				        else{ //單機隊
				        	sql = "select case when(sum(pic3)<6000) then 0 else 2 end case " +
						"from dftcrec where staff_num=? and fleet_cd in ("+fleetString+")";
				        }
				        pstmt2 = con.prepareStatement(sql);
				        if(my3Xcount == 2){ //343,333雙機隊
					        pstmt2.setString(1, rs.getString(1));
					        pstmt2.setString(2, rs.getString(1));
					}
					else{ //單機隊
						pstmt2.setString(1, rs.getString(1));
					}
					rs2 = pstmt2.executeQuery();
					if(rs2.next()){
						hmc = hmc + rs2.getInt(1);
						//rstring = rstring + rs.getString(1)+","+fleetString+","+sql+","+rs2.getInt(1) + "<br>";
					}
					rs2.close();
					pstmt2.close();
					//rstring = rstring + rs.getString(1) + ":" + fleetString + ":my3X--" + my3Xcount + ":hmc--" + hmc+ "<br>";//*****
		        	}
		        }
		        if(hmc >= 2 || "TPETPE".equals(sect)){
		        	return "N";
		        }
		        else{
				return "Y";
			}
			//return rstring; //***************************
		} catch(Exception e) {
			return e.toString(); //connect error or retrieve date error
		}
		finally {
			try{if(rs != null) rs.close();}catch(SQLException e){}
			try{if(rs2 != null) rs.close();}catch(SQLException e){}
	  		try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
	  		try{if(pstmt2 != null) pstmt.close();}catch(SQLException e){}
	  		try{if(con != null) con.close();}catch(SQLException e){}
		}
	}
}
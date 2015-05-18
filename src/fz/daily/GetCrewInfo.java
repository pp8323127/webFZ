package fz.daily;

import ci.db.ConnDB;
import java.sql.*;
 
public class GetCrewInfo {
	private Driver dbDriver = null;
	private Connection con = null;
	private Statement stmt = null;
	private ResultSet rs = null;
	
	private String today = null;
	private String tonit = null;
	private String ldday = null;
	private String ldnit = null;
 
	/*public static void main(String[] args) {
		GetCrewInfo dr = new GetCrewInfo();
		System.out.println(dr.getLastArv("2004/10/08","HKG","633328"));
	}*/

	public String getMeal(String empno) {
	    //抓取組員特別餐
		String meal = "";
		ConnDB cdb = new ConnDB();	
		cdb.setAOCIPRODCP();	
		try{
			dbDriver = (Driver) Class.forName(cdb.getDriver()).newInstance();
			con = dbDriver.connect(cdb.getConnURL(), null);
			
			stmt = con.createStatement();
		
			rs = stmt.executeQuery("select distinct meal_type " +
			"from crew_special_meals_v " +
			"where staff_num='"+empno+"' " +
			"and (eff_to_dt >= sysdate or eff_to_dt is null)");
			if(rs.next()){
				if(meal.equals("")){
					meal = rs.getString("meal_type");
				}
				else{
					meal = meal + "," + rs.getString("meal_type");
				}
			}
			return meal;
		} catch(Exception e) {
			return e.toString(); //connect error or retrieve date error
		}
		finally {
			try{if(rs != null) rs.close();}catch(SQLException e){}
	  		try{if(stmt != null) stmt.close();}catch(SQLException e){}
	   		try{if(con != null) con.close();}catch(SQLException e){}
		}
	}
	public String getSection(String empno) {
	    //抓取組員組別
		String section = "";
		ConnDB cdb = new ConnDB();	
		cdb.setAOCIPRODCP();
		try{
			dbDriver = (Driver) Class.forName(cdb.getDriver()).newInstance();
			con = dbDriver.connect(cdb.getConnURL(), null);
			
			stmt = con.createStatement();
		
			rs = stmt.executeQuery("select section_number from crew_v where staff_num='"+empno+"'");
			if(rs.next()){
				section = rs.getString("section_number");
			}
			return section;
		} catch(Exception e) {
			return e.toString(); //connect error or retrieve date error
		}
		finally {
			try{if(rs != null) rs.close();}catch(SQLException e){}
	  		try{if(stmt != null) stmt.close();}catch(SQLException e){}
	   		try{if(con != null) con.close();}catch(SQLException e){}
		}
	}
	public void setLanding(String empno, String theday){
		ConnDB cdb = new ConnDB();	
		cdb.setDFUserCP();	
		try{
			dbDriver = (Driver) Class.forName(cdb.getDriver()).newInstance();
			con = dbDriver.connect(cdb.getConnURL(), null);
			
			stmt = con.createStatement();
			String sql = "select sum(nvl(today,0)) today, sum(nvl(tonit,0)) tonit, sum(nvl(ldday,0)) ldday, sum(nvl(ldnit,0)) ldnit " +
			"from dftlogc c, dftlogf f " +
			"where c.logno=f.logno and empno='"+empno+"' and (f.year||f.mon||f.dd)>=to_char(sysdate - "+theday+",'yyyymmdd') and flag='3'";
			rs = stmt.executeQuery(sql);
			if(rs.next()){
				today = rs.getString("today");
				tonit = rs.getString("tonit");
				ldday = rs.getString("ldday");
				ldnit = rs.getString("ldnit");
			}
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		finally {
			try{if(rs != null) rs.close();}catch(SQLException e){}
			try{if(stmt != null) stmt.close();}catch(SQLException e){}
			try{if(con != null) con.close();}catch(SQLException e){}
		}
	}
	public String getToday(){
		return today;
	}
	public String getTonit(){
		return tonit;
	}
	public String getLdday(){
		return ldday;
	}
	public String getLdnit(){
		return ldnit;
	}
	public String getCrewCar(String empno) {
	    //抓取組員接車資料, ORP3 DFTCREW
		String traf = "";
		String locate = "";
		ConnDB cdb = new ConnDB();	
		//cdb.setDFUserCP();	
		cdb.setORP3FZUserCP();
		try{
			dbDriver = (Driver) Class.forName(cdb.getDriver()).newInstance();
			con = dbDriver.connect(cdb.getConnURL(), null);
//			cdb.setAOCIPRODCP();
//			java.lang.Class.forName(cdb.getDriver());
//			con = DriverManager.getConnection("jdbc:oracle:thin:@192.168.42.42:1521:ort1",
//					"fzap", "FZ921002");
			
			stmt = con.createStatement();
		
			rs = stmt.executeQuery("select traf, locate from dftcrew where empno='"+empno+"'");
			if(rs.next()){
			    traf = rs.getString("traf");
			    locate = rs.getString("locate");
			    if(locate == null) locate = "";
			}
			return traf + locate;
		} catch(Exception e) {
			return e.toString(); //connect error or retrieve date error
		}
		finally {
			try{if(rs != null) rs.close();}catch(SQLException e){}
	  		try{if(stmt != null) stmt.close();}catch(SQLException e){}
	   		try{if(con != null) con.close();}catch(SQLException e){}
		}
	}
	public String getNextSche(String str_dt_tpe_c, String empno) {//Flight Crew
	    //抓取組員後續行程 mm/dd fltno
	    //****尋找下一個 FLY 任務
		ConnDB cdb = new ConnDB();	
		cdb.setAOCIPRODCP();	
		try{
			dbDriver = (Driver) Class.forName(cdb.getDriver()).newInstance();
			con = dbDriver.connect(cdb.getConnURL(), null);
			
			stmt = con.createStatement();
			
			String str_dt = "";
			String flt_num = "";
			String dpt = "";
			String arv = "";
			
			String sql = "select r.roster_num,to_char(d.str_dt_tm_loc,'mm/dd') str_dt, r.end_dt,r.staff_num," +
				     "d.flt_num||d.cop_duty_cd flt_num, d.act_str_dt_tm_gmt,d.act_port_a dpt,d.act_port_b arv,d.duty_cd " +
				     "from roster_v r, duty_prd_seg_v d " +
				     "where r.series_num=d.series_num(+) " +
				     "and r.staff_num='" + empno + "' and r.delete_ind='N' " +
				     //"and d.duty_cd in ('FLY','GRD') " +   //***mark by cs55 2006/06/29
				     "and d.flt_num not in ('LO','RST','0') " +
				     "and d.act_str_dt_tm_gmt > to_date('" + str_dt_tpe_c + "','yyyy/mm/dd HH24MI') " +
				     "order by d.act_str_dt_tm_gmt";
			
			rs = stmt.executeQuery(sql);
			if(rs.next()){
				str_dt = rs.getString("str_dt");
				flt_num = rs.getString("flt_num");
				dpt = rs.getString("dpt");
				arv = rs.getString("arv");
			}
			return str_dt + "(LCL)" + flt_num + " " + dpt + "/" + arv;
		} catch(Exception e) {
			return e.toString(); //connect error or retrieve date error
		}
		finally {
			try{if(rs != null) rs.close();}catch(SQLException e){}
	  		try{if(stmt != null) stmt.close();}catch(SQLException e){}
	   		try{if(con != null) con.close();}catch(SQLException e){}
		}
	}
	public String getNextDuty(String fdate, String empno) {//Cabin Crew
	    //抓取組員後續行程 mm/dd fltno
	    //****尋找下一個任務,除了ADO, RDO, OF, RST, LO以外
		ConnDB cdb = new ConnDB();	
		cdb.setAOCIPRODCP();
		try{
			dbDriver = (Driver) Class.forName(cdb.getDriver()).newInstance();
			con = dbDriver.connect(cdb.getConnURL(), null);
			
			stmt = con.createStatement();
			
			String str_dt = "";
			String flt_num = "";
			String duty_cd = "";
			
			String sql = "select r.roster_num,to_char(d.act_str_dt_tm_gmt,'mm/dd') str_dt, r.end_dt,r.staff_num,d.flt_num flt_num, d.act_str_dt_tm_gmt,d.port_a,d.port_b,r.duty_cd " +
				     "from roster_v r, duty_prd_seg_v d " +
				     "where r.series_num=d.series_num(+) " +
				     "and r.staff_num='" + empno + "' and (d.flt_num not in ('ADO','RDO','OF','RST','LO') or d.flt_num is null) and r.delete_ind='N' and (d.act_port_a='TPE' or d.act_port_a is null) " +
				     "and d.act_str_dt_tm_gmt > to_date('" + fdate + "0000','yyyy/mm/ddHH24MI') " +
				     "order by d.str_dt_tm_gmt";
			
			rs = stmt.executeQuery(sql);
			if(rs.next()){
				str_dt = rs.getString("str_dt");
				flt_num = rs.getString("flt_num");
				duty_cd = rs.getString("duty_cd");
				if(flt_num == null || !duty_cd.equals("FLY")) flt_num = duty_cd;
			}
			return str_dt + " " + flt_num;
		} catch(Exception e) {
			return e.toString(); //connect error or retrieve date error
		}
		finally {
			try{if(rs != null) rs.close();}catch(SQLException e){}
	  		try{if(stmt != null) stmt.close();}catch(SQLException e){}
	   		try{if(con != null) con.close();}catch(SQLException e){}
		}
	}
	public String getLastArv(String fdate, String arv, String empno) {
	    //抓取組員上次飛航目地的航站日期 yyyy/mm/dd
		ConnDB cdb = new ConnDB();	
		cdb.setAOCIPRODCP();
		try{
			dbDriver = (Driver) Class.forName(cdb.getDriver()).newInstance();
			con = dbDriver.connect(cdb.getConnURL(), null);
			
			stmt = con.createStatement();
			
			String str_dt = "";
			
			String sql = "select r.roster_num,to_char(d.str_dt_tm_gmt,'yyyy/mm/dd') str_dt, r.end_dt,r.staff_num,d.flt_num flt_num, d.str_dt_tm_gmt,d.port_a,d.port_b,d.duty_cd " +
				     "from roster_v r, duty_prd_seg_v d " +
				     "where r.series_num=d.series_num(+) " +
				     "and r.staff_num='" + empno + "' and d.duty_cd='FLY' and r.delete_ind='N' " + 
				     "and (d.act_port_b='"+arv+"' or d.act_port_a='" + arv + "') " +
				     "and d.str_dt_tm_gmt < to_date('" + fdate + "0000','yyyy/mm/ddHH24MI') " +
				     "order by d.str_dt_tm_gmt desc";
			
			rs = stmt.executeQuery(sql);
			if(rs.next()){
				str_dt = rs.getString("str_dt");
			}
			return str_dt;
		} catch(Exception e) {
			return e.toString(); //connect error or retrieve date error
		}
		finally {
			try{if(rs != null) rs.close();}catch(SQLException e){}
	  		try{if(stmt != null) stmt.close();}catch(SQLException e){}
	   		try{if(con != null) con.close();}catch(SQLException e){}
		}
	}
	public String getBlkHr(String mymm, String empno, int chk){
	    String chr = null;
	    
	    ConnDB cdb = new ConnDB();	
		cdb.setAOCIPRODCP();
		try{
			dbDriver = (Driver) Class.forName(cdb.getDriver()).newInstance();
			con = dbDriver.connect(cdb.getConnURL(), null);
			
			stmt = con.createStatement();
			String table_name = null;
			
			if(chk == 1){ //Flight crew
			    table_name = "crew_cum_hr_tc_v";
			}
			else{ //Cabin crew
			    table_name = "crew_cum_hr_cc_v";
			}
			
			String sql = "SELECT round(Sum(non_std_fly_hours)/60,3) chr " +
			"from " + table_name + " WHERE staff_num='"+empno+"' " + 
			"and cal_dt between to_date('"+mymm+"/01','yyyy/mm/dd') and last_day(to_date('"+mymm+"','yyyy/mm'))";
						
			rs = stmt.executeQuery(sql);
			if(rs.next()){
				chr = rs.getString("chr");
			}
			return chr;
		} catch(Exception e) {
			return e.toString(); //connect error or retrieve date error
		}
		finally {
			try{if(rs != null) rs.close();}catch(SQLException e){}
	  		try{if(stmt != null) stmt.close();}catch(SQLException e){}
	   		try{if(con != null) con.close();}catch(SQLException e){}
		}
	}

	//取得組員是否已於CRC完成證照自我檢核報到程序
	public String getCheckLog(String fltd, String fltno, String sect, String empno){
		ConnDB cn = new ConnDB();
		String sql = null;	
		String crc_ck = "N";
		try{
			//connect to ORP3/FZ
			cn.setORP3FZUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			con = dbDriver.connect(cn.getConnURL(), null);
			stmt = con.createStatement(); 
			
			sql = "select nvl(crewchk,'N') crc_ck from fztckin where fltd=to_date('"+fltd+
			"','yyyy/mm/dd') and fltno='"+fltno+"' and sect='"+sect+"' and empno='"+empno+"'";
			rs = stmt.executeQuery(sql);
			if(rs.next()){
				crc_ck = rs.getString("crc_ck");
			}
			return crc_ck;
		} catch(Exception e) {
			System.out.println(e.toString());
			return e.toString();
		}
		finally {
			try{if(rs != null) rs.close();}catch(SQLException e){}
			try{if(stmt != null) stmt.close();}catch(SQLException e){}
			try{if(con != null) con.close();}catch(SQLException e){}
		}
	}
	//IN--> '2005/02/09', '0004', 'TPESFO', '636157' return-->'Y' OR 'N'
	//檢查Aircrews(crew_dops_v column no_show)
	public String getCheckAC(String fltd, String fltno, String sect, String empno) {
		ConnDB cn = new ConnDB();	
		//connect to AOCIPROD
		cn.setAOCIPRODCP();
		String sql = null;	
		String cks_ck = "Y"; //未報到
		try{
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			con = dbDriver.connect(cn.getConnURL(), null);
			
			stmt = con.createStatement();
			
			sql = "select nvl(no_show,'Y') no_show from crew_dops_v " +
			"where flt_dt_tm between to_date('"+fltd+"0000','yyyy/mm/ddHH24MI') and to_date('"+fltd+"2359','yyyy/mm/ddHH24MI')" +
			" and flt_num=lpad('"+fltno+"',4,'0') and dep_arp_cd='"+sect.substring(0,3) +
			"' and staff_num='"+empno+"'";
			
			rs = stmt.executeQuery(sql);
			if(rs.next()) cks_ck = rs.getString("no_show");
			if("N".equals(cks_ck)){ //no_show = 'N' 已報到; 'Y' or null 未報到
				cks_ck = "Y";
			}
			else{
				cks_ck = "N";
			}
			
			return cks_ck;
		} catch(Exception e) {
			return e.toString(); //connect error or retrieve date error
		}
		finally {
			try{if(rs != null) rs.close();}catch(SQLException e){}
	  		try{if(stmt != null) stmt.close();}catch(SQLException e){}
	   		try{if(con != null) con.close();}catch(SQLException e){}
		}
	}
	//抓取組員所屬機隊
	public String getCrewFleet(String empno){
		ConnDB cdb = new ConnDB();	
		cdb.setAOCIPRODCP();
		try{
			dbDriver = (Driver) Class.forName(cdb.getDriver()).newInstance();
			con = dbDriver.connect(cdb.getConnURL(), null);
			
			stmt = con.createStatement();
			
			String c_fleet = "";
			
			String sql = "select b.fleet_grp_cd fgc " + 
			"from crew_fleet_v a, fleet_grp_v b " +
			"where a.fleet_cd=b.fleet_grp_cd and b.fd_ind='Y' and " +
			"a.staff_num='" + empno + "' and a.valid_ind='Y' " +
			"and (a.exp_dt >= sysdate or a.exp_dt is null) " +
			"group by b.fleet_grp_cd";
			
			rs = stmt.executeQuery(sql);
			if(rs != null){
				while(rs.next()){
					c_fleet = c_fleet + " " + rs.getString("fgc");
				}
			}
			return c_fleet;
		} catch(Exception e) {
			return e.toString(); //connect error or retrieve date error
		}
		finally {
			try{if(rs != null) rs.close();}catch(SQLException e){}
	  		try{if(stmt != null) stmt.close();}catch(SQLException e){}
	   		try{if(con != null) con.close();}catch(SQLException e){}
		}
	}
	//抓取組員課程類別
	public String getClass(String empno, String str_dt_tpe_c){
		ConnDB cdb = new ConnDB();	
		cdb.setAOCIPRODCP();
		try{
			dbDriver = (Driver) Class.forName(cdb.getDriver()).newInstance();
			con = dbDriver.connect(cdb.getConnURL(), null);
			
			stmt = con.createStatement();
			
			String c_class = "";
			String tf = "";
			
			String sql = "select distinct a.trg_cd trg_cd, a.training_function tf, b.act_str_dt_tm_gmt, b.act_end_dt_tm_gmt " + 
				"from roster_special_duties_trg_v a, duty_prd_seg_v b " +
				"where a.series_num = b.series_num " +
				"and b.delete_ind='N' " +
				"and flt_num != 'RST' " +
				"and b.act_str_dt_tm_gmt = to_date('"+str_dt_tpe_c+"','yyyy/mm/dd HH24MI') " +
				"and a.staff_num = '"+empno+"'";
			
			rs = stmt.executeQuery(sql);
			if(rs != null){
				while(rs.next()){
					c_class = c_class + " " + rs.getString("trg_cd")+"/"+rs.getString("tf");
				}
			}
			return c_class;
		} catch(Exception e) {
			return e.toString(); //connect error or retrieve date error
		}
		finally {
			try{if(rs != null) rs.close();}catch(SQLException e){}
	  		try{if(stmt != null) stmt.close();}catch(SQLException e){}
	   		try{if(con != null) con.close();}catch(SQLException e){}
		}
	}
	//抓取組員Rank CD CA, FO, RP,.....
	public String getRank(String empno){
		ConnDB cdb = new ConnDB();	
		cdb.setAOCIPRODCP();
		try{
			dbDriver = (Driver) Class.forName(cdb.getDriver()).newInstance();
			con = dbDriver.connect(cdb.getConnURL(), null);
			
			stmt = con.createStatement();
			
			String rank_cd = "";
			
			String sql = "select rank_cd " +
				     "from crew_rank_v " +
				     "where staff_num='" + empno + "' and (exp_dt is null or exp_dt >= sysdate)";
			
			rs = stmt.executeQuery(sql);
			if(rs != null){
				while(rs.next()){
					if(rank_cd.equals("")){
						rank_cd = rs.getString("rank_cd");
					}
					else{
						rank_cd = rank_cd + "," + rs.getString("rank_cd");
					}
				}
			}
			return rank_cd;
		} catch(Exception e) {
			return e.toString(); //connect error or retrieve date error
		}
		finally {
			try{if(rs != null) rs.close();}catch(SQLException e){}
	  		try{if(stmt != null) stmt.close();}catch(SQLException e){}
	   		try{if(con != null) con.close();}catch(SQLException e){}
		}
	}
}

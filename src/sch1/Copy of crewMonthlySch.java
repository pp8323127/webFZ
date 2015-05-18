package sch;

import java.io.*;
import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.*;

import ci.db.*;
 
/**
 * crewMonthlySch
 * 
 * 
 * @author cs55
 * @author cs66
 * @version 1.1 cs66 2007/4/2 新增 Crew_rank_v.Rank (SR7128)
 * 
 * 
 */
public class crewMonthlySch {
	private Context initContext = null;
	private DataSource ds = null;
	//private Driver dbDriver = null;
	private rankObj staffRankObj = null;
	 
	public static void main(String[] args) {
		crewMonthlySch ms = new crewMonthlySch();
		String rs = ms.schFile("2007"+"05", "TPE", "", "*");
		System.out.println(rs);
	}
	


	public String schFile(String fmm, String base, String rank, String sk) {
		try{
			this.SelectAllRank(fmm);
		}catch(Exception e){
			
		}
		
		Connection dbCon = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		//Driver dbDriver = null;
		
		int lday = 0;
		String sql = null;
		
		String empno = null;
		String kempno = "";
		String kcname = "";
		String cname = null;
		String Big5Cname = null;
		int sdd = 0;
		int edd = 0;
		int smm = 0;
		int emm = 0;
		int sloc = 0;
		String shh = null;
		String ehh = null;
		String fltno = null;
		String dutycd = null;
		String copcd = null;
		String dpt = null;
		String arv = null;
		String rankCd =null;
		
		FileWriter fw = null;
		String[] w = {"SU","MO","TU","WE","TH","FR","SA"};
		String[] sch;
		String wstring = "";
		String q_rank = "";
		String q_sk = "";
		StringBuffer sb = new StringBuffer();
				
		try{
			fw =new FileWriter("/apsource/csap/projfz/webap/"+fmm+base+rank+sk+".csv", false);
			
//			UnicodeStringParser usp = new UnicodeStringParser();
			initContext = new InitialContext();
			//connect to AOCITEST / AOCIPROD by Datasource
			
           ds = (javax.sql.DataSource) initContext.lookup("CAL.FZDS03");
			dbCon = ds.getConnection();
			
			//dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
			//*****
			//dbCon = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP03", null);
			//*****
			//get the last day of input month
			
			
			
			sql = "select to_char(last_day(to_date(?,'yyyymm')),'dd') lday from dual";
			pstmt = dbCon.prepareStatement(sql);
			pstmt.setString(1,fmm);
			rs = pstmt.executeQuery();
			if(rs.next()){
				lday = rs.getInt("lday");
				rs.close();
			}
			
			sch = new String[lday];
			//******get crew schedule info******//
			if(!"".equals(rank) && "X".equals(sk)) q_rank = " and cr.rank_cd='" + rank + "' ";
			if("retire".equals(sk)){
				q_sk = " and sk.skill_cd in ('*','**') ";
			}else if(!"X".equals(sk)){ q_sk = " and sk.skill_cd='" + sk + "' ";}
			
			sql = "select cr.rank_cd,r.staff_num empno, c.preferred_name cname, " +  
			"to_char(d.act_str_dt_tm_gmt,'dd') sdd, " +   
			"to_char(d.act_end_dt_tm_gmt,'dd') edd, " +   
			"to_char(d.act_str_dt_tm_gmt,'mm') smm, " +   
			"to_char(d.act_end_dt_tm_gmt,'mm') emm, " +   
			"to_char(d.act_str_dt_tm_gmt,'HH24MI') shh, " +   
			"to_char(d.act_end_dt_tm_gmt,'HH24MI') ehh, " +   
			"to_char(d.str_dt_tm_loc,'HH24') sloc, " +  
			"lpad(nvl(d.flt_num,''),4,'0') fltno, " +  
			"decode(d.duty_cd,'LO','---',nvl(d.duty_cd,'')) dutycd, nvl(d.cop_duty_cd,'') copcd, " +   
			"d.port_a dpt, d.port_b arv, c.seniority_code code " +  
			"from roster_v r, duty_prd_seg_v d, crew_v c, crew_base_v b, rank_tp_v rt, crew_rank_v cr, crew_spec_skills_v sk " +  
			"where r.series_num=d.series_num " +
			"and r.staff_num=c.staff_num " +
			"and c.staff_num=b.staff_num and b.base=? and (b.exp_dt >= sysdate or b.exp_dt is null) " +
			"and r.acting_rank=rt.display_rank_cd and rt.fd_ind='N' " +
			"and c.staff_num=cr.staff_num and (cr.exp_dt >= sysdate or cr.exp_dt is null) " +
			
			"and c.staff_num=sk.staff_num(+) and (sk.exp_dt >= sysdate or sk.exp_dt is null) " + q_sk +
			//"and r.staff_num='638395' " +   //********
			"and (d.act_str_dt_tm_gmt between to_date(?,'yyyymmddHH24MI') and last_day(to_date(?,'yyyymmHH24MI')) " +
			"or d.act_end_dt_tm_gmt between to_date(?,'yyyymmddHH24MI') and last_day(to_date(?,'yyyymmHH24MI'))) " +
			"and r.delete_ind='N' and d.duty_cd<>'RST' " + q_rank +
			"union all " +
			
			"select cr.rank_cd,r.staff_num empno, c.preferred_name cname, " +  
			"to_char(r.act_str_dt,'dd') sdd, " +   
			"to_char(r.act_end_dt,'dd') edd, " +   
			"to_char(r.act_str_dt,'mm') smm, " +   
			"to_char(r.act_end_dt,'mm') emm, " +   
			"to_char(r.act_str_dt,'HH24MI') shh, " +   
			"to_char(r.act_end_dt,'HH24MI') ehh, " +   
			"to_char(r.act_str_dt,'HH24') sloc, " +  
			"'' fltno, " +  
			"r.duty_cd dutycd, '' copcd, " +  
			"r.location_cd dpt, r.location_cd arv, c.seniority_code code " +  
			"from roster_v r, crew_v c, crew_base_v b, rank_tp_v rt, crew_rank_v cr, crew_spec_skills_v sk " +  
			"where r.series_num=0 " +
			"and r.staff_num=c.staff_num " +
			"and c.staff_num=b.staff_num and b.base=? and (b.exp_dt >= sysdate or b.exp_dt is null) " +
			"and r.acting_rank=rt.display_rank_cd and rt.fd_ind='N' " +
			"and c.staff_num=cr.staff_num and (cr.exp_dt >= sysdate or cr.exp_dt is null) " +
			
			"and c.staff_num=sk.staff_num(+) and (sk.exp_dt >= sysdate or sk.exp_dt is null) " + q_sk +
			//"and r.staff_num='638395' " +   //********
			"and (r.act_str_dt between to_date(?,'yyyymmddHH24MI') and last_day(to_date(?,'yyyymmHH24MI')) " +
			"or r.act_end_dt between to_date(?,'yyyymmddHH24MI') and last_day(to_date(?,'yyyymmHH24MI'))) " +
   			"and r.delete_ind='N' " + q_rank +
			"order by code, empno, sdd, edd";
			//***表頭製作***
			int yy = Integer.parseInt(fmm.substring(0, 4));
			int mm = Integer.parseInt(fmm.substring(4, 6)) - 1;
			int inmm = Integer.parseInt(fmm.substring(4, 6));
			Calendar Calendar = new GregorianCalendar(yy, mm, 1);
			int dayOfWeek = Calendar.get(java.util.Calendar.DAY_OF_WEEK);
			int keepindex = dayOfWeek - 1;
			fw.write(fmm + "  " + base + " " + rank + " ROSTER\n");
			for(int i=1; i<=lday; i++){
				wstring = wstring + String.valueOf(i) + " " + w[keepindex] + ",";
				
				if(keepindex == 6){
					keepindex = 0;
				}
				else{
					keepindex++;
				}
			}
			
			//ADD Rank Column
			wstring = "," + wstring.substring(0, wstring.length()-1) + ",CR.,Rank,\n";
			
			fw.write(wstring);
			wstring = "";
			//**************
			
		        pstmt = dbCon.prepareStatement(sql);
		        pstmt.setString(1,base);
		        pstmt.setString(2,fmm+"010000");
		        pstmt.setString(3,fmm+"2359");
		        pstmt.setString(4,fmm+"010000");
		        pstmt.setString(5,fmm+"2359");
		        pstmt.setString(6,base);
		        pstmt.setString(7,fmm+"010000");
		        pstmt.setString(8,fmm+"2359");
		        pstmt.setString(9,fmm+"010000");
		        pstmt.setString(10,fmm+"2359");
		        rs = pstmt.executeQuery() ;
		
			while(rs.next()){
				//Add rankCd column 
				rankCd = rs.getString("rank_cd");
				empno = rs.getString("empno");
				cname = rs.getString("cname");
				Big5Cname = new String(ci.tool.UnicodeStringParser.removeExtraEscape(cname).getBytes(), "Big5");
				sdd = rs.getInt("sdd");
				edd = rs.getInt("edd");
				smm = rs.getInt("smm");
				emm = rs.getInt("emm");
				sloc = rs.getInt("sloc");
				shh = rs.getString("shh");
				ehh = rs.getString("ehh");
				fltno = rs.getString("fltno");
				dutycd = rs.getString("dutycd");
				copcd = rs.getString("copcd");
				if("000".equals(copcd)) copcd = "";
				if(copcd == null) copcd = "";
				fltno = copcd + fltno;
				dpt = rs.getString("dpt");
				arv = rs.getString("arv");
				if("".equals(kempno)){
					kempno = empno;
					kcname = Big5Cname;
				}
				if(!empno.equals(kempno)){
					fw.write(kempno + " " + kcname + ",");
					wstring = "";
					for(int i=0; i<sch.length; i++){
						if(sch[i]==null) sch[i]="";
						wstring = wstring + sch[i] + ",";
					}
					//get flight crew created hours
					String cr = getCr(kempno, fmm, dbCon);
					//****************************
					
					//wstring = wstring.substring(0, wstring.length()-1) + ","+cr+","+rankCd+"\n";					
					wstring = wstring.substring(0, wstring.length()-1) + ","+cr+","+staffRankObj.getRankCd(kempno)+"\n";
					
					fw.write(wstring);
					wstring = "";
					kempno = empno;
					kcname = Big5Cname;
					sch = null;
					sch = new String[lday];
				}
				if(smm == inmm){
					if(sch[sdd - 1]==null || "---".equals(sch[sdd - 1])) sch[sdd - 1]="";
				}
				if(emm == inmm){
					if(sch[edd - 1]==null) sch[edd - 1]="";
				}
				if("FLY".equals(dutycd) || "TVL".equals(dutycd)){
					//dpt date = arv date just show fltno
					if(smm == inmm){
						if(sch[sdd - 1].length() >= 8) sch[sdd - 1] = sch[sdd - 1].substring(0, sch[sdd - 1].indexOf(" ")) + " ";
					}
					if(smm == inmm){
						//loc time 凌晨02:00以前加'*'
						if(sloc < 2 && sch[sdd - 1].indexOf("*") < 0) sch[sdd - 1] = sch[sdd - 1] + "*";
						//if(sloc < 2) sch[sdd - 1] = sch[sdd - 1] + "*";
					}
					if(sdd == edd){
						if("".equals(sch[sdd - 1])){
							sch[sdd - 1] = sch[sdd - 1] + fltno + " " + dpt + arv;
						}
						else{
							sch[sdd - 1] = sch[sdd - 1] + fltno + " ";
						}
					}
					else{
						//顯示[跨月/當月]資料
						if(smm == inmm && emm == inmm){
							sch[sdd - 1] = sch[sdd - 1] + fltno + " " + dpt;
							sch[edd - 1] = sch[edd - 1] + arv;
						}
						else if(smm == inmm){
							sch[sdd - 1] = sch[sdd - 1] + fltno + " " + dpt;
						}
						else if(emm == inmm){
							sch[edd - 1] = sch[edd - 1] + fltno + " " + arv;
						}
					}
				}
				else{
					if("---".equals(dutycd)){
						for(int i = sdd - 1; i < edd; i++){
							if("".equals(sch[i]) || sch[i]==null) sch[i] = "---";
						}
					}
					else if("ADO".equals(dutycd) || "BOFF".equals(dutycd)){
						//don't show anything on schedule
					}
					else{
						if(smm == inmm && emm == inmm){
							if("GD".equals(dutycd) || "GS".equals(dutycd)){
								sch[sdd - 1] = sch[sdd - 1] + dutycd+" "+shh+" "+ehh;
							}
							else{
								sch[sdd - 1] = sch[sdd - 1] + dutycd;
							}
						}
					}
				}
			}
			//******************************
			//將最後一筆record寫入file
			fw.write(kempno + " " + kcname + ",");
			wstring = "";
			for(int i=0; i<sch.length; i++){
				if(sch[i]==null) sch[i]="";
				wstring = wstring + sch[i] + ",";
			}
			//get flight crew created hours
			String cr = getCr(kempno, fmm, dbCon);
			//****************************
			//Add RankCd Column
//			wstring = wstring.substring(0, wstring.length()-1) + ","+cr+","+rankCd+"\n";
			wstring = wstring.substring(0, wstring.length()-1) + ","+cr+","+staffRankObj.getRankCd(kempno)+"\n";
			
			fw.write(wstring);
			//******************************
			return "0";
			
		} catch(Exception e) {
			return e.toString(); //connect error or retrieve date error
		}
		finally {
			try{fw.flush();}catch(Exception e){}
		   	try{if(fw != null) fw.close();}catch(Exception e){}
			try{if(rs != null) rs.close();}catch(SQLException e){}
	  		try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
	   		try{if(dbCon != null) dbCon.close();}catch(SQLException e){}
		}
	}
	public String getCr(String empno, String fmm, Connection con) {
		PreparedStatement pstmt = null;
		ResultSet myrs = null;
		
		String sql = null;
		String cr = null;
		
		try{
		        sql = "SELECT to_char(trunc(Sum(non_std_fly_hours)/60))||':'||to_char(mod(Sum(non_std_fly_hours),60)) cr " +
			"FROM crew_cum_hr_cc_v WHERE staff_num=? " + 
			"AND cal_dt BETWEEN To_Date(?,'yyyymmdd hh24mi') " + 
			"AND Last_Day(To_Date(?,'yyyymmdd hh24mi'))";
			
			pstmt = con.prepareStatement(sql);
		        pstmt.setString(1,empno);
		        pstmt.setString(2,fmm+"01 0000");
		        pstmt.setString(3,fmm+"01 2359");
		        
		        myrs = pstmt.executeQuery() ;
		        
		        while(myrs.next()){
		        	cr = myrs.getString("cr");
		        }
		        myrs.close();
		        pstmt.close();
			return cr;
		} catch(Exception e) {
			return e.toString(); //connect error or retrieve date error
			//return "get cr error";
		}
		finally {
			try{if(myrs != null) myrs.close();}catch(SQLException e){}
	  		try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
		}
	}
	
	public void SelectAllRank(String yyyymm){
		

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ConnDB cn = new ConnDB();
		Driver dbDriver = null;
		try {

			cn.setAOCIPRODCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			pstmt = conn
					.prepareStatement("SELECT staff_num ,rank_cd FROM crew_rank_v " +
							"WHERE eff_dt <= To_Date(?,'yyyymm') " +
							"AND (exp_dt IS NULL OR exp_dt>=To_Date(?,'yyyymm')) " +
							"ORDER BY staff_num	");
			
			pstmt.setString(1,yyyymm);
			pstmt.setString(2,yyyymm);
		
			rs = pstmt.executeQuery();
			ArrayList staff_numAL= null;
			ArrayList rank_cdAL = null;
			while(rs.next()){
				if(staff_numAL == null)
					staff_numAL = new ArrayList();
				if(rank_cdAL == null)
					rank_cdAL = new ArrayList();
				staff_numAL.add(rs.getString("staff_num"));
				rank_cdAL.add(rs.getString("rank_cd"));
				
			}
			this.staffRankObj= new rankObj();
			staffRankObj.setStaff_numAL(staff_numAL);
			staffRankObj.setRank_cdAL(rank_cdAL);
			
			rs.close();
			pstmt.close();
			conn.close();
			

		} catch(Exception e){
			
			
		}finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {

				}
				conn = null;
			}
		}
	}
}


class rankObj{
	private ArrayList staff_numAL;
	private ArrayList rank_cdAL;
	
	public void setRank_cdAL(ArrayList rank_cdAL) {
		this.rank_cdAL = rank_cdAL;
	}
	public void setStaff_numAL(ArrayList staff_numAL) {
		this.staff_numAL = staff_numAL;
	}
	
	public String getRankCd(String staff_num){
		String rankCD ="";
		if(staff_numAL != null){
			int idx = 0;
			try{
				idx = staff_numAL.indexOf(staff_num);
				if(idx != -1){
					rankCD = (String)rank_cdAL.get(idx);	
				}
				
			}catch(Exception e){
				idx = 0;
				rankCD="";
			}			
			
		}
		return rankCD;
			
			
	}
	
	
	
}
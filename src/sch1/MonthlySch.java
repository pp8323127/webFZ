package sch;

import javax.naming.*;
import javax.sql.DataSource;
import java.sql.*;
import java.util.*;
//import fz.UnicodeStringParser;
import java.io.*;
 
public class MonthlySch {
	private Context initContext = null;
	private DataSource ds = null;
	//private Driver dbDriver = null;
	 
	/*public static void main(String[] args) {
		GetCrewInfo dr = new GetCrewInfo();
		System.out.println(dr.getLastArv("2004/10/08","HKG","633328"));
	}*/

	public String schFile(String fmm, String fleet, String rank) {
		Connection dbCon = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		//Driver dbDriver = null;
		
		int lday = 0;
		String sql = null;
		
		ArrayList empn = new ArrayList();
		ArrayList thename = new ArrayList();
		String empno = null;
		String cname = null;

		int sdd = 0;
		int edd = 0;
		int sloc = 0;
		String shh = null;
		String ehh = null;
		String fltno = null;
		String dutycd = null;
		String copcd = null;
		String dpt = null;
		String arv = null;
		String sernum = null;
		
		FileWriter fw = null;
		String[] w = {"SU","MO","TU","WE","TH","FR","SA"};
		String[] sch;
		String wstring = "";
		String myrank = null;
				
		try{
			fw =new FileWriter("/apsource/csap/projfz/webap/"+fmm+fleet+rank+".csv", false);
//			UnicodeStringParser usp = new UnicodeStringParser();
			initContext = new InitialContext();
			//connect to AOCITEST / AOCIPROD by Datasource
               		ds = (javax.sql.DataSource)initContext.lookup("CAL.FZDS03");
               		dbCon = ds.getConnection();
			//dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();//*****
			//dbCon = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP03", null);//*****
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
			myrank = "";

			if(!"ALL".equals(rank)) myrank = " and k.rank_cd='" + rank + "' ";
			
			//***表頭製作***
			int yy = Integer.parseInt(fmm.substring(0, 4));
			int mm = Integer.parseInt(fmm.substring(4, 6)) - 1;
			Calendar Calendar = new GregorianCalendar(yy, mm, 1);
			int dayOfWeek = Calendar.get(Calendar.DAY_OF_WEEK);
			int keepindex = dayOfWeek - 1;
			fw.write(fmm + "  " + fleet + " " + rank + " ROSTER\n");
			for(int i=1; i<=lday; i++){
				wstring = wstring + String.valueOf(i) + " " + w[keepindex] + ",";
				if(keepindex == 6){
					keepindex = 0;
				}
				else{
					keepindex++;
				}
			}
			wstring = "," + wstring.substring(0, wstring.length()-1) + ",CR.,BK.,Qual\n";
			fw.write(wstring);
			wstring = "";
			//***end 表頭製作***
			sql = "select c.staff_num empno, c.preferred_name cname, c.seniority_code code, k.rank_cd rank, rt.priority_no pno " +
			"from crew_v c, crew_rank_v k, rank_tp_v rt, crew_fleet_v f " +
			"where c.staff_num=k.staff_num " + 
			"and c.staff_num=f.staff_num " +   
			"and f.fleet_cd=? " + myrank +
			"and emp_status='A' " +
			"and (f.exp_dt is null or f.exp_dt >= sysdate) " +
			"and (k.exp_dt is null or k.exp_dt >= sysdate) " +  
			"and k.rank_cd=rt.display_rank_cd " + 
			"and rt.fd_ind='Y' " +
			"order by pno, code, empno";
			
			pstmt = dbCon.prepareStatement(sql);
		        pstmt.setString(1,fleet);
		        rs = pstmt.executeQuery();
		
			while(rs.next()){ //while 1.
				empn.add(rs.getString("empno"));
				thename.add(new String(ci.tool.UnicodeStringParser.removeExtraEscape(rs.getString("cname")).getBytes(), "Big5"));
			} //end while 1.
			rs.close();
			pstmt.close();
			for(int j=0; j < empn.size(); j++){
				//******get crew schedule info******//
				sql = "select r.staff_num empno, c.preferred_name cname, " +  
				"to_char(d.act_str_dt_tm_gmt,'dd') sdd, " +   
				"to_char(d.act_end_dt_tm_gmt,'dd') edd, " +   
				"to_char(d.act_str_dt_tm_gmt,'HH24MI') shh, " +   
				"to_char(d.act_end_dt_tm_gmt,'HH24MI') ehh, " +   
				"to_char(d.str_dt_tm_loc,'HH24') sloc, " +  
				"lpad(nvl(d.flt_num,''),4,'0') fltno, r.series_num sernum, " +  
				"decode(d.duty_cd,'LO','---',nvl(d.duty_cd,'')) dutycd, nvl(d.cop_duty_cd,'') copcd, " +   
				"d.port_a dpt, d.port_b arv, c.seniority_code code, k.rank_cd rank, rt.priority_no pno " +  
				"from roster_v r, duty_prd_seg_v d, crew_v c, crew_fleet_v f, crew_rank_v k, rank_tp_v rt " +  
				"where r.series_num=d.series_num " +
				"and r.staff_num=c.staff_num " +
				"and c.staff_num=f.staff_num " +  
				"and f.fleet_cd=? " +
				"and c.staff_num=k.staff_num " + myrank +
				"and (k.exp_dt is null or k.exp_dt >= sysdate) " + 
				"and (f.exp_dt is null or f.exp_dt >= sysdate) " +  
				"and k.rank_cd=rt.display_rank_cd " +
				"and rt.fd_ind='Y' " +
				"and r.staff_num='"+empn.get(j)+"' " +   //********
				"and d.act_str_dt_tm_gmt between to_date(?,'yyyymmddHH24MI') and last_day(to_date(?,'yyyymmHH24MI')) " +
				//"and to_char(d.act_str_dt_tm_gmt,'yyyymm')=? " +
				"and r.delete_ind='N' and d.duty_cd<>'RST' " +  
				"union all " +
				"select r.staff_num empno, c.preferred_name cname, " +  
				"to_char(r.act_str_dt,'dd') sdd, " +   
				"to_char(r.act_end_dt,'dd') edd, " +   
				"to_char(r.act_str_dt,'HH24MI') shh, " +   
				"to_char(r.act_end_dt,'HH24MI') ehh, " +   
				"to_char(r.act_str_dt,'HH24') sloc, " +  
				"'' fltno, 0 sernum, " +  
				"r.duty_cd dutycd, '' copcd, " +  
				"r.location_cd dpt, r.location_cd arv, c.seniority_code code, k.rank_cd rank, rt.priority_no pno " +  
				"from roster_v r, crew_v c, crew_fleet_v f, crew_rank_v k, rank_tp_v rt " + 
				"where r.series_num=0 " +
				"and r.staff_num=c.staff_num " +
				"and c.staff_num=f.staff_num " +
				"and f.fleet_cd=? " +			
				"and c.staff_num=k.staff_num " + myrank +
				"and (k.exp_dt is null or k.exp_dt >= sysdate) " +
				"and (f.exp_dt is null or f.exp_dt >= sysdate) " + 
				"and k.rank_cd=rt.display_rank_cd " +
				"and rt.fd_ind='Y' " +
				"and r.staff_num='"+empn.get(j)+"' " +   //********
				"and r.act_str_dt between to_date(?,'yyyymmddHH24MI') and last_day(to_date(?,'yyyymmHH24MI')) " +
				//"and to_char(r.act_str_dt,'yyyymm')=? " +
	   			"and r.delete_ind='N' " + 
	   			"order by pno, code, empno, sdd, edd";
	   			
			        pstmt = dbCon.prepareStatement(sql);
			        pstmt.setString(1,fleet);
			        pstmt.setString(2,fmm+"010000");
			        pstmt.setString(3,fmm+"2359");
			        pstmt.setString(4,fleet);
			        pstmt.setString(5,fmm+"010000");
			        pstmt.setString(6,fmm+"2359");
			        rs = pstmt.executeQuery() ;
			
				while(rs.next()){ //while 2.
					//empno = rs.getString("empno");
					//cname = rs.getString("cname");
					//Big5Cname = new String(usp.removeExtraEscape(cname).getBytes(), "Big5");
					sdd = rs.getInt("sdd");
					edd = rs.getInt("edd");
					sloc = rs.getInt("sloc");
					shh = rs.getString("shh");
					ehh = rs.getString("ehh");
					fltno = rs.getString("fltno");
					sernum = rs.getString("sernum");
					dutycd = rs.getString("dutycd");
					copcd = rs.getString("copcd");
					if("000".equals(copcd)) copcd = "";
					if(copcd == null) copcd = "";
					fltno = getTrainFun((String)empn.get(j), sernum, dbCon) + copcd + fltno; //ROSTER_SPECIAL_DUTIES_TRG_V : training_function
					dpt = rs.getString("dpt");
					arv = rs.getString("arv");
					
					if(sch[sdd - 1]==null || "---".equals(sch[sdd - 1])) sch[sdd - 1]="";
					if(sch[edd - 1]==null) sch[edd - 1]="";
					if("FLY".equals(dutycd) || "TVL".equals(dutycd)){
						//dpt date = arv date just show fltno
						//if(sch[sdd - 1].length() >= 11) sch[sdd - 1] = sch[sdd - 1].substring(0, sch[sdd - 1].lastIndexOf(" ")) + " ";
						if(sch[sdd - 1].length() >= 8) sch[sdd - 1] = sch[sdd - 1].substring(0, sch[sdd - 1].indexOf(" ")) + " ";
						//loc time 凌晨02:00以前加'*'
						if(sloc < 2) sch[sdd - 1] = sch[sdd - 1] + "*";
						if(sdd == edd){
							if("".equals(sch[sdd - 1])){
								sch[sdd - 1] = sch[sdd - 1] + fltno + " " + dpt + arv;
							}
							else{
								sch[sdd - 1] = sch[sdd - 1] + fltno + " ";
							}
						}
						else{
							sch[sdd - 1] = sch[sdd - 1] + fltno + " " + dpt;
							//跨月資料不顯示
							if(edd >= sdd) sch[edd - 1] = sch[edd - 1] + arv;
						}
					}
					else{
						if("---".equals(dutycd)){
							for(int i = sdd - 1; i < edd; i++){
								if("".equals(sch[i]) || sch[i]==null) sch[i] = "---";
							}
							//sch[sdd - 1] = sch[sdd - 1] + dutycd;
						}
						else if("ADO".equals(dutycd) || "BOFF".equals(dutycd)){
							//don't show anything on schedule
						}
						else{
							if("GDT".equals(dutycd) || "GST".equals(dutycd) || dutycd.indexOf("SIM") > -1){
								sch[sdd - 1] = sch[sdd - 1] + dutycd+" "+shh+" "+ehh;
							}
							else{
								sch[sdd - 1] = sch[sdd - 1] + dutycd;
							}
						}
					}
				} //end while 2.
				fw.write(empn.get(j) + " " + thename.get(j) + " " + getBase((String)empn.get(j), dbCon) + ",");
				wstring = "";
				for(int i=0; i<sch.length; i++){
					if(sch[i]==null) sch[i]="";
					wstring = wstring + sch[i] + ",";
				}
				//get flight crew created hours
				String cr = getCr((String)empn.get(j), fmm, dbCon);
				//get flight crew qualification 
				String qual = getQual((String)empn.get(j), dbCon);
				//****************************
				//wstring = wstring.substring(0, wstring.length()-1) + ","+cr+"\n";
				wstring = wstring.substring(0, wstring.length()-1) + ","+cr+","+qual+","+empn.get(j)+","+thename.get(j)+"\n";
				fw.write(wstring);
				wstring = "";
				sch = null;
				sch = new String[lday];
				rs.close();
				pstmt.close();
			} //end for

			return "0";
			
		} catch(Exception e) {
			return e.toString(); //connect error or retrieve date error
			//return sql;
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
		ResultSet rs = null;
		
		String sql = null;
		String cr = null;
		
		try{
			sql = "SELECT round(Sum(non_std_fly_hours)/60, 3)||','||round(Sum(rem_fh_28)/60, 3) cr " +
			"FROM crew_cum_hr_tc_v WHERE staff_num=? " + 
			"AND cal_dt BETWEEN To_Date(?,'yyyymmdd hh24mi') " + 
			"AND Last_Day(To_Date(?,'yyyymmdd hh24mi'))";
			pstmt = con.prepareStatement(sql);
		        pstmt.setString(1,empno);
		        pstmt.setString(2,fmm+"01 0000");
		        pstmt.setString(3,fmm+"01 2359");
		        
		        rs = pstmt.executeQuery() ;
		        
		        while(rs.next()){
		        	cr = rs.getString("cr");
		        }
			return cr;
		} catch(Exception e) {
			return e.toString(); //connect error or retrieve date error
		}
		finally {
			try{if(rs != null) rs.close();}catch(SQLException e){}
	  		try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
		}
	}
	public String getBase(String empno, Connection con) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = null;
		String base = "";
		
		try{
			sql = "select base from crew_base_v where staff_num=? and (exp_dt is null or exp_dt >= sysdate)";
			
			pstmt = con.prepareStatement(sql);
		        pstmt.setString(1,empno);
		        rs = pstmt.executeQuery() ;
		        
		        while(rs.next()){
		        	if("TPE".equals(rs.getString("base")) || "TSA".equals(rs.getString("base"))){
			        }
			        else{
			        	if("".equals(base)){
			        		base = rs.getString("base");
			        	}
			        	else{
			        		base = base + "/" + rs.getString("base");
			        	}
		        	}
		        }
			return base;
		} catch(Exception e) {
			return e.toString(); //connect error or retrieve date error
		}
		finally {
			try{if(rs != null) rs.close();}catch(SQLException e){}
	  		try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
		}
	}
	public String getQual(String empno, Connection con) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = null;
		String qual = "";
		
		try{
			sql = "select qual_cd " +
			"from crew_qualifications_v " +
			"where staff_num = ? " + 
			"and qual_cd in ('E1N2','W1N2') " +
			"and (expiry_dts >= sysdate or expiry_dts is null) " +
			"order by actuals_status desc";
			
			pstmt = con.prepareStatement(sql);
		        pstmt.setString(1,empno);
		        rs = pstmt.executeQuery() ;
		        
		        if(rs.next()){ //取第一筆qual
		        	qual = rs.getString("qual_cd");
		        }
			return qual;
		} catch(Exception e) {
			return e.toString(); //connect error or retrieve date error
		}
		finally {
			try{if(rs != null) rs.close();}catch(SQLException e){}
	  		try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
		}
	}
	public String getTrainFun(String empno, String sernum, Connection con) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = null;
		String tf = "";
		
		try{
			sql = "SELECT training_function " +
			      "FROM  ROSTER_SPECIAL_DUTIES_TRG_V " +
			      "where staff_num = ? and series_num = ?";
			
			pstmt = con.prepareStatement(sql);
		        pstmt.setString(1,empno);
		        pstmt.setInt(2,Integer.parseInt(sernum));
		        rs = pstmt.executeQuery() ;
		        
		        if(rs.next()){
		        	tf = rs.getString("training_function");
		        	if(tf == null) tf = "";
		        }
			return tf;
		} catch(Exception e) {
			return "getTrainFun : " + e.toString(); //connect error or retrieve date error
		}
		finally {
			try{if(rs != null) rs.close();}catch(SQLException e){}
	  		try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
		}
	}
}
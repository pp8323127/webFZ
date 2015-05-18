package ws.MsgFromGrd;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.ArrayList;
import ci.db.ConnDB;
import ci.db.ConnectionHelper;
import ci.tool.UnicodeStringParser;

public class ListbyFdateFun {
	
	ListbyFdateRObj cObj = null;	
	
	public static void main(String[] args) {
        // TODO Auto-generated method stub
		ListbyFdateFun l = new ListbyFdateFun();
		l.getShowList("20131213", "CM/FC/MC", "0008", "");
        System.out.println("done"); 
    }
	
	public ListbyFdateFun() {
		// TODO Auto-generated constructor stub
	}
	
	public String[] showRank(){
		String []rank = {"CM","FC","MC"};//CM為預設值。		
		return rank;
	}	
	
	public void getShowList(String fdate,String rank,String fltno,String sect){//yyyymmdd
		String yy = fdate.substring(0,4);
		String mm = fdate.substring(4,6);
		String dd = fdate.substring(6,8);
		String sql = null;
		String sqlFltno = "";
		String sqlSect = ""; 
		String sqlRank = "";
		String[] rankArr = rank.split("/");
		for(int i=0;i<rankArr.length;i++){
		    if(rankArr[i].equals("CM")){
	            rankArr[i] = "PR";
	        }
		    if(i<1){
		        sqlRank += "'"+rankArr[i]+"'";
		    }else{
		        sqlRank += ",'"+rankArr[i]+"'";
		    }
		    
		}
//		System.out.println(sqlRank);
		
		 
		if(!fltno.equals(null) && !fltno.equals("")){
			DecimalFormat df = new DecimalFormat("0000");//補位
			fltno = df.format(Integer.parseInt(fltno));
			sqlFltno= " and dps.flt_num = '"+fltno+"'";
		}
		if(!sect.equals(null) && !sect.equals("")){
			sqlSect = " and dps.act_port_a||dps.act_port_b = '"+sect+"'";
		}
		//檢查班表是否公布
		cObj = new ListbyFdateRObj();
		boolean test = true;
		swap3ac.PublishCheck pc = new swap3ac.PublishCheck(yy, mm);
		if(!pc.isPublished()){
//			if(!test){
			//班表尚未正式公佈
			cObj.setResultMsg("1");
			cObj.setErrorMsg("班表尚未正式公佈");
		}else{
			//
			Connection conn = null;
			Statement stmt = null;
			ResultSet rs = null;
			ConnDB cn = new ConnDB();
			Driver dbDriver = null;
			int rowCount = 0;
			String tempName=null;
			try
			{
			//LIVE
			cn.setAOCIPRODCP();

			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);
	        stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
//test
//			ConnectionHelper ch = new ConnectionHelper();
//	        conn = ch.getConnection();
//	        stmt = conn.createStatement();
	        sql = "select dps.flt_num flt_num,r.staff_num empno,c.seniority_code sern, c.preferred_name cname, " 
	        		+ " c.other_surname ename, c.other_first_name ename2,       " 
	        		+ " c.section_number grp, r.series_num trip_num, " 
	        		+ " to_char(dps.act_str_dt_tm_gmt,'yyyy/mm/dd hh24mi') act_ftime, "
					+ " cv.rank_cd rank, decode(r.ACTING_RANK ,'PR','CM',r.ACTING_RANK ) act_rank," 
					+ "dps.fleet_cd fleet, r.location_cd base,dps.duty_cd, "
					+ " to_char(dps.str_dt_tm_gmt,'yyyy/mm/dd') off_date, "
					+ " to_char(dps.str_dt_tm_gmt,'yyyy/mm') gch_yymm, dps.fd_ind fd_ind, "
					+ " dps.act_port_a||dps.act_port_b sector,nvl(to_char(cv.exp_dt,'yyyy/mm/dd'),'&nbsp;') exp_dt "
					+ " from roster_v r, crew_v c, duty_prd_seg_v dps,crew_rank_v cv "
					+ " where r.staff_num=c.staff_num and r.staff_num=cv.staff_num and r.series_num = dps.series_num "
					+ " and r.delete_ind='N' and dps.str_dt_tm_gmt between to_date('"+ fdate+ " 0000','yyyymmdd hh24mi') "
					+ " and to_date('"+ fdate+ " 2359','yyyymmdd hh24mi') "
					+ " and (cv.exp_dt > sysdate or cv.exp_dt is null)"
					+ " and dps.duty_cd = 'FLY'"
					+ " and dps.fd_ind = 'N' "
					+ " and r.ACTING_RANK in ("+sqlRank+")"
					+ sqlFltno + sqlSect
					+ " order by off_date, flt_num, sector, fd_ind desc, rank , empno ";
	        										
//			System.out.println(sql);
	        rs = stmt.executeQuery(sql); 
	        ArrayList ls = new ArrayList();
	        if(!rs.equals(null)){
	        	while(rs.next()){
	        		ListbyFdateObj obj = new ListbyFdateObj();
	        		obj.setFltno(rs.getString("flt_num"));
	        		obj.setEmpno(rs.getString("empno"));
	        		obj.setSern(rs.getString("sern"));
	        		tempName = new String(UnicodeStringParser.removeExtraEscape(rs.getString("cname")).getBytes(), "Big5");//rs.getString("name")
	        		obj.setCname(tempName);
	        		obj.setEname(rs.getString("ename") + " " +rs.getString("ename2"));
//	        		System.out.println(rs.getString("ename") + " " +rs.getString("ename2"));
	        		obj.setGrp(rs.getString("grp"));
	        		obj.setSect(rs.getString("sector"));
	        		obj.setOccu(rs.getString("act_rank"));//acting rank        		
//	        		obj.setTrip_num(rs.getString("trip_num"));
	        		obj.setActFltTime(rs.getString("act_ftime"));
	        		ls.add(obj);
	        		rowCount ++;
	        	}
	        }
	        if (rowCount > 0) {	        	
	        	ListbyFdateObj[] array = new ListbyFdateObj[ls.size()];
                for (int i = 0; i < ls.size(); i++) {
                    array[i] = (ListbyFdateObj) ls.get(i);
                }
                cObj.setLsbyFdate(array);
                cObj.setResultMsg("1");
            } else {
            	cObj.setResultMsg("0");
            	cObj.setErrorMsg("NO data");
            }
			} catch (Exception e) {
				cObj.setErrorMsg(e.toString());//+sql
//				System.out.println(e.toString()+sql);
				cObj.setResultMsg("0");
			} finally {
				try {
					if (rs != null)
						rs.close();
				} catch (SQLException e) {
				}
				try {
					if (stmt != null)
						stmt.close();
				} catch (SQLException e) {
				}
				try {
					if (conn != null)
						conn.close();
				} catch (SQLException e) {
				}
			}
		}
		
	}
	
}

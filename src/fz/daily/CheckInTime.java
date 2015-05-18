package fz.daily;

import ci.db.ConnDB;
import java.sql.*;

public class CheckInTime {
	private Driver dbDriver = null;
	private Connection con = null;
	private Statement stmt = null;
	private ResultSet rs = null;
	
 	private String ms = null;
 	private int mt = 0;
 	private String ct = null;
 	private String st = null;
	/*public static void main(String[] args) {
		CheckInTime cit = new CheckInTime();
		System.out.println(cit.getCheckInTime("0601", "2004/11/24 0810"));
	}*/
	//IN--> '0006', '2004/11/24 0930', return-->2004/11/240830
	public String getCheckInTime(String fltno, String str_dt_tpe) {
		ConnDB cdb = new ConnDB();	
		cdb.setORP3FZUserCP();	
		
		try{
			dbDriver = (Driver) Class.forName(cdb.getDriver()).newInstance();
			con = dbDriver.connect(cdb.getConnURL(), null);
			
			stmt = con.createStatement();
			
			rs = stmt.executeQuery("select smin from fztchki where fltno='"+fltno+"'");
			if(rs.next()){
			    st = rs.getString("smin");
			}
			else{
				if(fltno.equals("0")){
					ms = "X";
				}
				else{
					ms = fltno.substring(1, 2);//Flight Number 的第二位
				}
				mt = Integer.parseInt(str_dt_tpe.substring(11)); //表定起飛時間
				//客機 - 0xx、1xx、5xx、6xx、7xx; 貨機 - 2xx、3xx
				if(ms.equals("0") || ms.equals("1") || ms.equals("2") || ms.equals("3") || ms.equals("5") || ms.equals("6") || ms.equals("7")){
					//AM00:01 to 08:30 130分鐘
					if(mt >= 1 && mt <= 830){
						st = "130";
					}
					else{
						st = "140";
					}
				}   
				else if(ms.equals("X")){
					st = "60"; //模擬機及FTD施訓
				} 
				else{
					st = "120"; //試飛、空機飛渡
				}
			}
			rs = stmt.executeQuery("select to_char(to_date('"+str_dt_tpe+"','yyyy/mm/dd HH24MI') - ("+st+"/1440),'yyyy/mm/ddHH24MI') ct from dual");
			if(rs.next()){
				ct = rs.getString("ct");
			}
			return ct;
		} catch(Exception e) {
			return e.toString(); //connect error or retrieve date error
		}
		finally {
			try{if(rs != null) rs.close();}catch(SQLException e){}
	  		try{if(stmt != null) stmt.close();}catch(SQLException e){}
	   		try{if(con != null) con.close();}catch(SQLException e){}
		}
	}
	public String getCKSTime(String fltno, String str_dt_tpe) {
		ConnDB cdb = new ConnDB();	
		cdb.setAOCIPRODCP();	
		try{
			dbDriver = (Driver) Class.forName(cdb.getDriver()).newInstance();
			con = dbDriver.connect(cdb.getConnURL(), null);
			
			stmt = con.createStatement();
			
			if(!fltno.equals("0")){
			    rs = stmt.executeQuery("select to_char(to_date('"+str_dt_tpe+"','yyyy/mm/dd HH24MI') - (90/1440),'yyyy/mm/ddHH24MI') ct from dual");
				if(rs.next()){
					ct = rs.getString("ct");
				}
			}
			else{
				ct = "0000/00/000000";
			}
			return ct;
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

package fz.pracP;

import ci.db.ConnDB;
import java.sql.*;



/**
 * @author cs55
 *
 */

public class DelReport {
	private Connection con = null;
	private Statement stmt = null;
	private ResultSet rs = null;
 

	/*public static void main(String[] args) {
		DelReport dr = new DelReport();
		String rs = dr.doDel("2004/07/10","003","SFOTPE");
		System.out.println(rs);
	}*/
	//傳入變數fdate-->2004/07/10, fltno-->003, sect-->SFOTPE, pempn-->632578, gdyear-->2004
	public String doDel(String fdate, String fltno, String sect, String pempn, String gdyear, String userid) {
	    ConnDB cn = new ConnDB();
	    Driver dbDriver;
		int mm = 0;
		String sql = null;
		int[] prep = new int[12];
		try{
		    	cn.setORP3EGUserCP();
		    	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
		    	con = dbDriver.connect(cn.getConnURL(), null);

			
				//connect ORT1 EG
		              
//				cn.setORT1EG();
//				Class.forName(cn.getDriver());
//				con = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());

		    	
		    	stmt = con.createStatement();
				
				sql = "delete egtcflt where fltd = to_date('"+fdate+"','yyyy/mm/dd') and fltno = '"+fltno+"' and sect = '"+sect+"'";
				stmt.executeUpdate(sql);
				sql = "delete egtgddt where fltd = to_date('"+fdate+"','yyyy/mm/dd') and fltno = '"+fltno+"' and sect = '"+sect+"'";
				stmt.executeUpdate(sql);
				sql = "update egtpsac set rptcount = rptcount - 1, chguser = '"+userid+"', chgdate = sysdate where gdyear = '"+gdyear+"' and trim(empn) = '"+pempn+"'";
				stmt.executeUpdate(sql);
				sql = "delete egtcmdt where fltd = to_date('"+fdate+"','yyyy/mm/dd') and fltno = '"+fltno+"' and sect = '"+sect+"'";
				stmt.executeUpdate(sql);
				sql = "select * from egtprep where gdyear = '"+gdyear+"' and trim(empn) = '"+pempn+"'";
				rs = stmt.executeQuery(sql);
				if(rs.next()){
					for(int i = 0; i < 12; i++){
						prep[i] = rs.getInt("actreport"+String.valueOf(i + 1));
					}
				}
				
				mm = Integer.parseInt(fdate.substring(5,7));
				switch (mm){
					case 1:
						prep[0] = prep[0] - 1;
						break;
					case 2:
						prep[1] = prep[1] - 1;
						break;	
					case 3:
						prep[2] = prep[2] - 1;
						break;
					case 4:
						prep[3] = prep[3] - 1;
						break;
					case 5:
						prep[4] = prep[4] - 1;
						break;
					case 6:
						prep[5] = prep[5] - 1;
						break;
					case 7:
						prep[6] = prep[6] - 1;
						break;
					case 8:
						prep[7] = prep[7] - 1;
						break;
					case 9:
						prep[8] = prep[8] - 1;
						break;
					case 10:
						prep[9] = prep[9] - 1;
						break;
					case 11:
						prep[10] = prep[10] - 1;
						break;
					case 12:
						prep[11] = prep[11] - 1;
						break;
				}
				sql = "update egtprep set actreport1 = "+prep[0]+", actreport2 = "+prep[1]+", actreport3 = "+prep[2]+", actreport4 = "+prep[3]+", actreport5 = "+prep[4]+
				", actreport6 = "+prep[5]+", actreport7 = "+prep[6]+", actreport8 = "+prep[7]+", actreport9 = "+prep[8]+", actreport10 = "+prep[9]+", actreport11 = "+prep[10]+", actreport12 = "+prep[11]+
				" , chguser = '"+userid+"', chgdate = sysdate where gdyear = '"+gdyear+"' and trim(empn) = '"+pempn+"'";
				stmt.executeUpdate(sql);
			} catch(Exception e) {
				//e.printStackTrace();
				try{con.rollback();}catch(SQLException se){}
				return e.toString()+"Error:"+sql;
			}
			finally {
				try{if(rs != null) rs.close();}catch(SQLException e){}
		  		try{if(stmt != null) stmt.close();}catch(SQLException e){}
		   		try{if(con != null) con.close();}catch(SQLException e){}
			}
			return "0";
		}
		
	public String doAddReport(String fdate, String pempn, String sern, String gdyear, String userid) {
	    ConnDB cn = new ConnDB();
	    Driver dbDriver;
	int mm = 0;
	int[] prep = new int[12];
	int rCount = 0;
	String sql = null;

	try{
	    cn.setORP3EGUserCP();
    	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
    	con = dbDriver.connect(cn.getConnURL(), null);
				
			//connect ORT1 EG	                 
//				cn.setORT1EG();
//				Class.forName(cn.getDriver());
//				con = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());
			stmt = con.createStatement();
			
			rs = stmt.executeQuery("select * from egtprep where gdyear = '"+gdyear+"' and trim(empn) = '"+pempn+"'");
			if(rs.next()){
				rCount++;
				for(int i = 0; i < 12; i++){
					prep[i] = rs.getInt("actreport"+String.valueOf(i+1));
				}
			}
			else{
				for(int i = 0; i < 12; i++){
					prep[i] = 0;
				}
			}
			mm = Integer.parseInt(fdate.substring(5,7));
			switch (mm){
				case 1:
					prep[0] = prep[0] + 1;
					break;
				case 2:
					prep[1] = prep[1] + 1;
					break;	
				case 3:
					prep[2] = prep[2] + 1;
					break;
				case 4:
					prep[3] = prep[3] + 1;
					break;
				case 5:
					prep[4] = prep[4] + 1;
					break;
				case 6:
					prep[5] = prep[5] + 1;
					break;
				case 7:
					prep[6] = prep[6] + 1;
					break;
				case 8:
					prep[7] = prep[7] + 1;
					break;
				case 9:
					prep[8] = prep[8] + 1;
					break;
				case 10:
					prep[9] = prep[9] + 1;
					break;
				case 11:
					prep[10] = prep[10] + 1;
					break;
				case 12:
					prep[11] = prep[11] + 1;
					break;
			}
			
			if(rCount == 0){
				sql = "insert into egtprep values('"+gdyear+"', '"+pempn+"', "+sern+", 0, "+prep[0]+", 0, "+prep[1]+
								", 0, "+prep[2]+", 0, "+prep[3]+", 0, "+prep[4]+", 0, "+prep[5]+", 0, "+prep[6]+", 0, "+prep[7]+", 0, "+prep[8]+
								", 0, "+prep[9]+", 0, "+prep[10]+", 0, "+prep[11]+", '"+userid+"', sysdate, null, null)";
				stmt.executeUpdate(sql);
			}
			else{
				sql = "update egtprep set actreport1 = "+prep[0]+", actreport2 = "+prep[1]+", actreport3 = "+prep[2]+", actreport4 = "+prep[3]+", actreport5 = "+prep[4]+
				", actreport6 = "+prep[5]+", actreport7 = "+prep[6]+", actreport8 = "+prep[7]+", actreport9 = "+prep[8]+", actreport10 = "+prep[9]+", actreport11 = "+prep[10]+", actreport12 = "+prep[11]+
				", chguser = '"+userid+"', chgdate = sysdate where gdyear = '"+gdyear+"' and trim(empn) = '"+pempn+"'";
				stmt.executeUpdate(sql);
			}

		} catch(Exception e) {
			e.printStackTrace();
			try{con.rollback();}catch(SQLException se){}
			return e.toString() + "SQL:" + sql;
		}
		finally {
			try{if(rs != null) rs.close();}catch(SQLException e){}
			try{if(stmt != null) stmt.close();}catch(SQLException e){}
			try{if(con != null) con.close();}catch(SQLException e){}
		}
		return "0";
	}
	public String doScore(String fdate, String fltno, String sect, String[] empn, String[] sern, String[] score, String gdyear, String userid) {
		//Delete all crew score on this flight and then insert new or modify score into egtgddt table
	    ConnDB cn = new ConnDB();
	    Driver dbDriver;	
			try{
			    cn.setORP3EGUserCP();
		    	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
		    	con = dbDriver.connect(cn.getConnURL(), null);
						
					//connect ORT1 EG	                 
//						cn.setORT1EG();
//						Class.forName(cn.getDriver());
//						con = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());
					stmt = con.createStatement();
					//Delete 組員分數
					stmt.executeUpdate("delete egtgddt where fltd = to_date('"+fdate+"','yyyy/mm/dd') and fltno = '"+fltno+"' and sect = '"+sect+"' and score > 0 and score is not null");
					for(int i = 0; i < empn.length; i++){
						//Inser 組員分數
						if(!score[i].equals("0")){
							stmt.executeUpdate("INSERT INTO EGTGDDT ( yearsern,gdyear,empn,sern,fltd,fltno,sect,score,newuser,newdate) "+
                                                            "values(EGQGDYS.nextval,to_char("+gdyear+" ),'"+empn[i]+"','"+sern[i]+"',"+
															"to_date('"+fdate+"','yyyy/mm/dd'),'"+fltno+"','"+sect+"',"+score[i]+",'"+userid+"',sysdate)");
						}
					}
			
				} catch(Exception e) {
					e.printStackTrace();
					try{con.rollback();}catch(SQLException se){}
					return e.toString();
				}
				finally {
					try{if(stmt != null) stmt.close();}catch(SQLException e){}
					try{if(con != null) con.close();}catch(SQLException e){}
				}
				return "0";
			}
}

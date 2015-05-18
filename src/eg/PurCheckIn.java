package eg;

import ci.db.ConnDB;
import java.sql.*;

public class PurCheckIn {
	private Connection con = null;
	private Statement stmt = null;
	private ResultSet rs = null;
	private Driver dbDriver = null;
	
	private String sern = null;
	private String cname = null;
	private String sql = null;
	
	/*public static void main(String[] args) {
		//*****************
	}*/

	public String doCheck(String empno) {
		//檢查是否為座艙長並取得sern , cname
		try{
			//connect ORP3 EG
		        ConnDB cn = new ConnDB();
			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			con = dbDriver.connect(cn.getConnURL(), null);
			stmt = con.createStatement();
					
			sql = "select sern, cname from egtcbas where trim(empn) = '"+empno+"' and to_number(jobno) <= 80";
			rs = stmt.executeQuery(sql);
	
			if(rs.next()){
				sern = rs.getString("sern");
				cname = rs.getString("cname");
			}

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
	public String getSern(){
		return sern;
	}
	public String getCname(){
		return cname;
	}
	public String doUpdateLog(String empno, String sern){
		//update egtpsrm(會議日期) , egtpsac(座艙長考核明細)
		int urow = 0;
		int yy = 0;
		int mm = 0;
		String gdyear = null;
		try{
			//connect ORP3 EG
		        ConnDB cn = new ConnDB();
			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			con = dbDriver.connect(cn.getConnURL(), null);
			stmt = con.createStatement();
			
			sql = "select to_char(sysdate, 'yyyy') yy, to_char(sysdate, 'mm') mm from dual";
			rs = stmt.executeQuery(sql);
			if(rs.next()){
				yy = rs.getInt("yy");
				mm = rs.getInt("mm");
				if(mm > 10){
					gdyear = String.valueOf(yy + 1);
				}
				else{
					gdyear = String.valueOf(yy);
				}
			}
//			sql = "insert into egtpsrm values('"+gdyear+"', '"+empno+" ', "+sern+", sysdate, '"+empno+"', sysdate, null, null)";	
//			stmt.executeUpdate(sql);	
			
			sql = "select count(*) c from egtpsrm where empn = '"+empno+"' and trunc(meetdate,'dd') = trunc(sysdate,'dd') ";
			rs = stmt.executeQuery(sql);
			int count =0;
			if(rs.next())
			{
				count = rs.getInt("c");
			}			
			if(count<=0)
			{				
				sql = "insert into egtpsrm values('"+gdyear+"', '"+empno+" ', "+sern+", sysdate, '"+empno+"', sysdate, null, null)";	
				stmt.executeUpdate(sql);
			}
			
			
			/*sql = "update egtpsac set actmeet=nvl(actmeet, 0) + 1, chguser='"+empno+"', chgdate=sysdate where gdyear='"+gdyear+"' and trim(empn)='"+empno+"'";
			urow = stmt.executeUpdate(sql);
	
			if(urow == 0){
				sql = "insert into egtpsac (gdyear, empn, sern, actmeet, newuser, newdate) values('"+
				gdyear+"', '"+empno+" ', "+sern+", 1, '"+empno+"', sysdate)";
				stmt.executeUpdate(sql);
			}*/
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
}

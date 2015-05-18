package eg;
import ci.db.*;
import java.sql.*;
public class ZCCheckIn 
{
	private Connection con = null;
	private Statement stmt = null;
	private ResultSet rs = null;
	private Driver dbDriver = null;
	
	private String sern = null;
	private String cname = null;
	private String sql = null;
	
	public static void main(String[] args) 
	{
	   
	}

	public String doCheck(String empno) 
	{
		//檢查是否為助理座艙長並取得sern , cname
		try{
			//connect ORP3 EG
		    ConnDB cn = new ConnDB();
			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			con = dbDriver.connect(cn.getConnURL(), null);
			stmt = con.createStatement();
					
			sql = " select cb.sern sern, cb.cname cname from egtcbas cb, egtzcstus zc " +
				  " where zc.empno = '"+empno+"' and trim(cb.empn) = zc.empno " +
				  " and ( trunc(sysdate,'dd') between eff_dt and exp_dt or exp_dt is null) ";
			rs = stmt.executeQuery(sql);
	
			if(rs.next())
			{
				sern = rs.getString("sern");
				cname = rs.getString("cname");
			}

		} 
		catch(Exception e) 
		{
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
	public String doUpdateLog(String empno, String sern)
	{
		//update egtzcmt(會議日期)
		int urow = 0;
		int yy = 0;
		int mm = 0;
		String gdyear = null;
		try
		{
			//connect ORP3 EG
		    ConnDB cn = new ConnDB();
			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			con = dbDriver.connect(cn.getConnURL(), null);
			stmt = con.createStatement();
			
			sql = "select to_char(sysdate, 'yyyy') yy, to_char(sysdate, 'mm') mm from dual";
			rs = stmt.executeQuery(sql);
			if(rs.next())
			{
				yy = rs.getInt("yy");
				mm = rs.getInt("mm");
				if(mm > 10)
				{
					gdyear = String.valueOf(yy + 1);
				}
				else
				{
					gdyear = String.valueOf(yy);
				}
			}
			
			sql = "select count(*) c from egtzcmt where empno = '"+empno+"' and trunc(meetdate,'dd') = trunc(sysdate,'dd') ";
			rs = stmt.executeQuery(sql);
			int count =0;
			if(rs.next())
			{
				count = rs.getInt("c");
			}			
			if(count<=0)
			{
				sql = " insert into egtzcmt (gdyear,empno,sern,meetdate,newuser,newdate,chguser,chgdate) values " +
					  " ('"+gdyear+"', '"+empno+"', "+sern+", sysdate, '"+empno+"', sysdate, null, null)";	
				stmt.executeUpdate(sql);
			}
		} 
		catch(Exception e) 
		{
			try{con.rollback();}catch(SQLException se){}
			return e.toString()+"Error:"+sql;
		}
		finally 
		{
			try{if(rs != null) rs.close();}catch(SQLException e){}
	  		try{if(stmt != null) stmt.close();}catch(SQLException e){}
	   		try{if(con != null) con.close();}catch(SQLException e){}
		}
		return "0";
	}
}

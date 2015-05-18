package fz;

import ci.db.*;
import java.sql.*;

public class checkCheckin
{
    Statement stmt = null;
    Connection conn = null;
    Driver dbDriver = null;
    ResultSet rs = null;
    
    String msg = "0";
    boolean f = true;
    String edate = "20990101";
    //rptloc:TAO, sdate:2006/12/04, setloc:TAO, applydate:2006-12-04, userid:637183
    public String doUpdate(String rptloc, String sdate, String setloc, String applydate, String userid)
    {
        try{
		//connect to ORP3 EG
//		dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
//		conn = dbDriver.connect("jdbc:weblogic:pool:CAL.EGCP01", null);
		ConnDB cn = new ConnDB();
		cn.setORP3EGUserCP();
		dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
		conn = dbDriver.connect(cn.getConnURL(), null);
		conn.setAutoCommit(false);
		stmt = conn.createStatement();
		//1.判斷申請日期是否在2個工作天後
//		rs = stmt.executeQuery("select to_date('"+applydate+"','yyyy-mm-dd') - to_date(sysdate,'yyyy-mm-dd') from dual");
		rs = stmt.executeQuery("select to_date('"+applydate+"','yyyy-mm-dd') - To_Date(To_Char(SYSDATE,'yyyy-mm-dd'),'yyyy-mm-dd') from dual");
		
		if(rs.next()){
			if(rs.getInt(1) < 2)
			{
				msg = "生效日期不得少於兩個工作天 !!";
				f = false;
			}
		}
		rs.close();
		if(f){
			//2.一個月只允許修改一次
			rs = stmt.executeQuery("select count(*) " +
			"from egtchkin " +
			"where to_char(upddate,'yyyymm') = to_char(sysdate,'yyyymm') " +
			"and empno='"+userid+"'");
			if(rs.next()){
				if(rs.getInt(1) > 0){
					msg = "一個月只允許修改一次 !!";
					f = false;
				}
			}
			rs.close();
		}
		if(f){
			//3.判斷申請日期是否重複
			rs = stmt.executeQuery("select to_char(edate,'yyyymmdd') " +
			"from egtchkin " +
			"where to_date('"+applydate+"','yyyy-mm-dd') between sdate and edate " +
			"and empno='"+userid+"'");
			if(rs.next()){
				if(!"20990101".equals(rs.getString(1))){
					msg = "申請日期重複 !!";
					f = false;
				}
			}
			rs.close();
		}
		if(f){
			//4.新增申請記錄 & update 結束日
			rs = stmt.executeQuery("select to_char(max(sdate - 1),'yyyymmdd') " +
			"from egtchkin " +
			"where sdate > to_date('"+applydate+"','yyyy-mm-dd') " +
			"and empno='"+userid+"'");
			if(rs.next()){ 
				edate = rs.getString(1);
				if(edate == null) edate = "20990101"; //***************
			}
			if("20990101".equals(edate)){
				//update record edate
				stmt.executeUpdate("update egtchkin set edate=to_date('"+applydate+"','yyyy-mm-dd')-1 where empno='"+
				userid+"' and edate=to_date('20990101','yyyymmdd')");
			} 
			//Insert new record
			if("20990101".equals(edate)){
				stmt.executeUpdate("insert into egtchkin values ('"+userid+"','"+setloc+"',to_date('"+
				applydate+"','yyyy-mm-dd'),to_date('"+edate+"','yyyymmdd'),sysdate,'"+userid+"')");
			}else{
				stmt.executeUpdate("insert into egtchkin values ('"+userid+"','"+setloc+"',to_date('"+
				applydate+"','yyyy-mm-dd'),to_date('"+edate+"','yyyy-mm-dd'),sysdate,'"+userid+"')");

			}
		}
		return msg;

	    } catch(Exception e){
	    	try{conn.rollback();}catch(Exception ex){}
    	    	//e.printStackTrace();
    	    	return "ERROR:"+e.toString(); //update error
  	    }
  	    finally{
	        try{if(rs != null) rs.close();}catch(SQLException e){}
	        try{if(stmt != null) stmt.close();}catch(SQLException e){}
	        try{if(conn != null) conn.close();}catch(SQLException e){}
	    }
       }
}
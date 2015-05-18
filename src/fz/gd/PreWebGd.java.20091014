package fz.gd;
import ci.db.ConnDB;
import java.sql.*;
import java.util.*;

public class PreWebGd
{

	public static void main(String []args)
	{
//	    String dd = "2007/11/06 2340";
//	    System.out.println(dd.substring(0,4));
//	    System.out.println(dd.substring(5,7));
//	    System.out.println(dd.substring(8,10));
//	    System.out.println(dd.substring(5));
	    
	    PreWebGd we = new PreWebGd();
	    we.getWebEgData("2007/10/09","112","TPE");
//	    System.out.println(we.getObjAL().size());
//	    we.getGDFromDB2("0011","2007/09/28","JFK");
	    System.out.println("Done");
		
	}
	
	Connection conn = null;
	Driver dbDriver = null;
	Statement stmt = null;
	ResultSet rs = null;
	String sql  = "";
	String error = "";
	String returnstr = "";	
	ArrayList objAL = new ArrayList();
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("ddMMMyy", Locale.US);
    //*****************************************************
    public void getWebEgData(String fdate, String fltno, String dpt)
	{
		try
		{
		    ConnDB cn = new ConnDB();
		    
//          cn.setORP3FZUser();
//          java.lang.Class.forName(cn.getDriver());
//          conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() ,cn.getConnPW());
//          stmt = conn.createStatement();      
          
	  		cn.setORP3FZUserCP();
	  		dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	  		conn = dbDriver.connect(cn.getConnURL(), null);
	  		stmt = conn.createStatement(); 
	  		
	  		if("".equals(dpt) | dpt == null)
	  		{
	  		    sql = " SELECT to_char(dps.str_dt_tm_loc,'yyyy/mm/dd hh24mi') str_dt_tm_loc, " +
					  " dps.flt_num flt_num, dps.act_port_a act_port_a, dps.act_port_b act_port_b " +
					  " from  fzdb.duty_prd_seg_v dps " +				  
					  " where dps.delete_ind='N' and dps.duty_cd in ('FLY','TVL') " +
					  "     and dps.str_dt_tm_loc BETWEEN To_Date('"+fdate+" 00:00:00','yyyy/mm/dd hh24:mi:ss') " +
					  "     AND To_Date('"+fdate+" 23:59:59','yyyy/mm/dd hh24:mi:ss') " +
					  "     and (dps.flt_num = '"+fltno+"' OR dps.flt_num='0"+fltno+"') " +
					  " group BY  str_dt_tm_loc, flt_num, act_port_a, act_port_b ";
	  		}
	  		else
	  		{          
				sql = " SELECT to_char(dps.str_dt_tm_loc,'yyyy/mm/dd hh24mi') str_dt_tm_loc, " +
					  " dps.flt_num flt_num, dps.act_port_a act_port_a, dps.act_port_b act_port_b " +
					  " from  fzdb.duty_prd_seg_v dps " +				  
					  " where dps.delete_ind='N' and dps.duty_cd in ('FLY','TVL') " +
					  "     and dps.str_dt_tm_loc BETWEEN To_Date('"+fdate+" 00:00:00','yyyy/mm/dd hh24:mi:ss') " +
					  "     AND To_Date('"+fdate+" 23:59:59','yyyy/mm/dd hh24:mi:ss') " +
					  "     and (dps.flt_num = '"+fltno+"' OR dps.flt_num='0"+fltno+"') AND dps.act_port_a = substr('"+dpt+"',1,3) " +
					  " group BY  str_dt_tm_loc, flt_num, act_port_a, act_port_b ";
	  		}
	  		
//			System.out.println(sql);
			rs = stmt.executeQuery(sql);

			while(rs.next())
			{
			    WebGdObj obj = new WebGdObj();
			    obj.setFltno(rs.getString("flt_num"));
			    obj.setArv(rs.getString("act_port_b"));
			    obj.setDpt(rs.getString("act_port_a"));
			    obj.setFdate(rs.getString("str_dt_tm_loc"));
			    objAL.add(obj);
			}
			
			returnstr = "Y";			
		}
		catch (Exception e)
		{
			System.out.println(e.toString());
			returnstr = "ORA Error : " + e.toString();
		}
		finally
		{
			try{if(rs != null) rs.close();}catch(SQLException e){}
			try{if(stmt != null) stmt.close();}catch(SQLException e){}
			try{if(conn != null) conn.close();}catch(SQLException e){}
		}
	}
    
    public ArrayList getObjAL()
    {
        return objAL;
    }
    
    public String getStr()
    {
        return returnstr;
    }
    
    public String getSql()
    {
        return sql;
    }
}


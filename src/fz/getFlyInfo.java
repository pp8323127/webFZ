package fz;

/**
 * @author cs71 Created on  2006/4/17
 */
import ci.db.ConnDB;
import java.sql.*;

public class getFlyInfo
{
    private Statement stmt = null;
    private ResultSet rs = null;
    private Connection conn = null;
    private Driver dbDriver = null;
    
	private String sector = "";     
    private String sql = null;
	private int count = 0 ;

	public static void main(String []args)
	{
		try
		{
		   getFlyInfo p = new getFlyInfo();
		   System.out.println(p.getSector("0261","2006/04/28"));
		   //System.out.println(p.getSector2("004"));
  		   System.out.println("Done");
		}
		catch (Exception e)
		{
			System.out.println(e.toString());
		}
    } 
       
    public String getSector(String fltno, String fdate) throws Exception
    {
        try
		{
            //connect to ORP3 FZ
            ConnDB cn = new ConnDB();	
//			cn.setAOCIPROD();
//			java.lang.Class.forName(cn.getDriver());
//			conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());
            
            cn.setAOCIPRODCP();  
    	    dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
    	    conn = dbDriver.connect(cn.getConnURL(), null);    	  
    	    
			stmt = conn.createStatement();

			//sql = " select da13_fm_sector||da13_to_sector as sect " +
//				  " from v_ittda13_ci where da13_fltno = LPAD('"+fltno+"',4,'0') " +
//				  " and (da13_fm_sector = 'TPE' and da13_to_sector <> 'TPE' ) " +
//				  " AND To_Char(da13_stdu + 8/24,'yyyy/mm/dd') = '"+fdate+"'";
			//System.out.println(sql);
			
			sql =" SELECT port_a||port_b as sect FROM duty_prd_seg_v WHERE " +
				 " flt_num = LPAD('"+fltno+"',4,'0') AND " +
				 " ((port_a = 'TPE' AND port_b <> 'TPE') OR " +
				 " (port_a = 'TSA' AND port_b <> 'TSA')) AND str_dt_tm_gmt " +
				 " BETWEEN To_Date('"+fdate+" 0000','yyyy/mm/dd hh24mi') " +
				 " AND To_Date('"+fdate+" 2359','yyyy/mm/dd hh24mi') ";
			
			//System.out.println(sql);

			rs = stmt.executeQuery(sql);
	
			if (rs.next())
			{ 
				sector = rs.getString("sect");
				count++;
			}

			if (count <1)
			{
				return "TPETPE";
			}
			else
			{
				return sector;
			}
        }
		catch(Exception e)
		{
                return e.toString();  
        }
        finally
        {
            if(rs!=null)try{rs.close();}catch(Exception e){}
            if(stmt!=null)try{stmt.close();}catch(Exception e){}
            if(conn!=null)try{conn.close();}catch(Exception e){}
        }
    }

    public String getSector2(String fltno, String fdate) throws Exception
    {
        try
		{
            //connect to AIRCREWS
            ConnDB cn = new ConnDB();	
			cn.setAOCIPROD();
			java.lang.Class.forName(cn.getDriver());
			conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());
			stmt = conn.createStatement();

			sql = "select da13_fm_sector||da13_to_sector as sect " +
			  " from fzdb.v_ittda13_ci where da13_fltno = LPAD('"+fltno+"',4,'0') " +
			  " and (da13_fm_sector = 'TPE' and da13_to_sector <> 'TPE' ) " +
			  " AND To_Char(da13_stdu + 8/24,'yyyy/mm/dd') " +
			  " = '"+fdate+"'";

			rs = stmt.executeQuery(sql);
	
			while (rs.next())
			{ 
				sector = rs.getString("sect");
				count++;
			}

			if (count <1)
			{
				return "TPETPE";
			}
			else
			{
				return sector;
			}
        }
		catch(Exception e)
		{
                return e.toString();  
        }
        finally
        {
            if(rs!=null)try{rs.close();}catch(Exception e){}
            if(stmt!=null)try{stmt.close();}catch(Exception e){}
            if(conn!=null)try{conn.close();}catch(Exception e){}
        }
    }
}


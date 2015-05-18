package fz.gd;

import java.sql.*;
import javax.sql.DataSource;
import javax.naming.InitialContext;
public class WebGdCity
{
	public static void main(String []args)
	{
	    WebGdCity we = new WebGdCity("TPE","2007/05/30","CI","065");
	    System.out.println(we.lcity);
	    System.out.println(we.ctry);
	    System.out.println("Done");
	}	
	private Connection conn = null;	private Driver dbDriver = null;	private Statement stmt = null;	private ResultSet rs = null;	private String sql  = "";	//private ConnDB cn = new ConnDB();	private DataSource ds = null; 
	
	public String lcity = "";	public String ctry = "";	public String acno = "";
	

    //*****************************************************    public WebGdCity(String station, String fdate, String arln, String fltno)	{		try		{//          cn.setORP3FZUser();//          java.lang.Class.forName(cn.getDriver());//          conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() ,cn.getConnPW());//          stmt = conn.createStatement();         
			//cn.setORP3FZUserCP();	  		//dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();	  		//conn = dbDriver.connect(cn.getConnURL(), null);	  		
	  		
	  				
	  	    //DataSource 
	  		InitialContext initialcontext = new InitialContext();
	  		ds = (DataSource) initialcontext.lookup("CAL.FZDS02"); 
	  		conn = ds.getConnection();
	  		stmt = conn.createStatement(); 	  		  		        			sql = " select * from fzdb.fztcity where scity = '"+station+"' ";//			System.out.println(sql);			rs = stmt.executeQuery(sql);
			while(rs.next())
			{			    lcity = rs.getString("lcity");			    ctry = rs.getString("ctry");			}			rs.close();			//Get acno			//schedule time 
			sql = " SELECT da13_acno acno FROM fzdb.v_ittda13_ci WHERE (da13_fltno = '"+fltno+"' " +				  " OR da13_fltno = '0"+fltno+"') " +
				  //" AND  da13_airl = '"+arln+"' " +
				  " AND da13_fm_sector = '"+station+"' " +
				  " AND  da13_stdl BETWEEN To_Date('"+fdate+" 00:00:00','yyyy/mm/dd hh24:mi:ss') " +				  " AND To_Date('"+fdate+" 23:59:59','yyyy/mm/dd hh24:mi:ss') " +
				  " AND da13_cond NOT IN ('CF','DL','OF') ";				rs = stmt.executeQuery(sql);			while(rs.next())			{			    acno = rs.getString("acno");			}					}		catch (Exception e)		{			System.out.println(e.toString());		}		finally		{			try{if(rs != null) rs.close();}catch(SQLException e){}			try{if(stmt != null) stmt.close();}catch(SQLException e){}			try{if(conn != null) conn.close();}catch(SQLException e){}		}
	}   
}


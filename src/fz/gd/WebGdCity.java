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
	private Connection conn = null;
	
	public String lcity = "";
	

    //*****************************************************
			//cn.setORP3FZUserCP();
	  		
	  				
	  	    //DataSource 
	  		InitialContext initialcontext = new InitialContext();
	  		ds = (DataSource) initialcontext.lookup("CAL.FZDS02"); 
	  		conn = ds.getConnection();
	  		stmt = conn.createStatement(); 	  		  		
			while(rs.next())
			{
			sql = " SELECT da13_acno acno FROM fzdb.v_ittda13_ci WHERE (da13_fltno = '"+fltno+"' " +
				  //" AND  da13_airl = '"+arln+"' " +
				  " AND da13_fm_sector = '"+station+"' " +
				  " AND  da13_stdl BETWEEN To_Date('"+fdate+" 00:00:00','yyyy/mm/dd hh24:mi:ss') " +
				  " AND da13_cond NOT IN ('CF','DL','OF') ";
	}   
}

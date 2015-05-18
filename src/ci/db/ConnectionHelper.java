package ci.db;

//import java.io.File;
//import java.io.FileInputStream;

import java.sql.*;

import javax.naming.*;
import javax.sql.*;
//import java.util.Properties;

public class ConnectionHelper 
{
//	private static Properties prop = null;
	private  String iswebap = "";
	private  String connURL= "";
	private  String connID = "";
	private  String connPW = "";
	private  String driver = "";
	private  Context initContext = null;
	private  DataSource ds = null;
//	private  String path = "C:\\FZTemp\\";
//	private  String file = "Connection.properties";
////	public final static String file = "Connection_orp3.properties";
//	private  String path_web = "/apsource/csap/projfz/webap/";
//	private  String file_web = "Connection_web.properties";
	
	
	public static void main(String[] args)
    {
	    ConnectionHelper ch = new ConnectionHelper();
	    Connection conn = ch.getConnection();
	    if(conn != null)
	    {
	        System.out.println("not null");
	        try{
	        conn.close(); 
	        }
	        catch(Exception e){}
	        
	    }
	    else
	    {
	        System.out.println("null");
	    }
        System.out.println("Done");
    }

//	public static void initProperties() 
//	{
//	    if (prop == null)
//	    {
//			File file1 = new File(path+file);
//			File file = null;
//			if (file1.isFile()) 
//			{
//				file = file1;
//			} 
//			else 
//			{
//				file1 = new File(path_web+file_web);
//			    file = file1;
//			}
//	
//			FileInputStream inputStream = null;
//			try 
//			{
//			    prop = new Properties();
//				inputStream = new FileInputStream(file);
//				prop.load(inputStream);			
//			} 
//			catch (Exception e) 
//			{
//	//			e.printStackTrace();
//				System.out.println("**************"+e.toString());
//			} 
//			finally 
//			{			    
//				if (inputStream != null) 
//				{
//					try 
//					{
//						inputStream.close();
//					} 
//					catch (Exception e) 
//					{
//	//					e.printStackTrace();
//						System.out.println("**************"+e.toString());
//					}
//				}
//			}
//	    }
//	}

	public Connection getConnection() 
	{
		Connection conn = null;		
//		iswebap="true";
//		connURL="jdbc:weblogic:pool:CAL.FZCP02";
//		connID="";
//		connPW="";
//		driver="weblogic.jdbc.pool.Driver";		
		
//		iswebap="false";
//		connURL="jdbc:oracle:thin:@HDQora03L:1521:orp3";
//		connID="egdb";
//		connPW="eg$888";
//		driver="oracle.jdbc.driver.OracleDriver";
		
		iswebap="false";
		connURL="jdbc:oracle:thin:@HDQora01T:1521:ort1";
		connID="egdb";
		connPW="eg$888";
		driver="oracle.jdbc.driver.OracleDriver";
		
		try 
		{          
//			initProperties();
		    if ("true".equalsIgnoreCase(iswebap)) 		    
			{
				// TODO WEB LOGIC CONTEXT
//	            Driver dbDriver = (Driver) Class.forName(driver).newInstance();
//	            conn = dbDriver.connect(connURL, null);
	            
	            initContext = new InitialContext();
	    		ds = (javax.sql.DataSource) initContext.lookup("CAL.FZDS02");
	    		ds.setLoginTimeout(60);
	    		conn = ds.getConnection();
			} 
			else 
			{
			    //connect to ORT1
				java.lang.Class.forName(driver);
				conn = DriverManager.getConnection(connURL,connID,connPW);
			}
		} 
		catch (Exception e) 
		{
//			e.printStackTrace();
			System.out.println("**************"+e.toString());
		}
		return conn;
	}
}

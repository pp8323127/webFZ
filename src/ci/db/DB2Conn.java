package ci.db;

/**
 * @author cs71 Created on  2006/9/1
 * CS80 db2 2014/04
 */
public class DB2Conn
{
    /**
     * @param connURL：連線字串 <br>
     *        ex: jdbc:oracle:thin:@ip:port:dbname
     * @param connID ：連線帳號
     * @param connPW ：連線密碼
     * @param driver：Driver
     */
		private String connURL = null;
		private String connID = null;
		private String connPW = null;
		private String driver = null;

	   public DB2Conn() 
	   {}

	   public void setDB2PUser() 
	   {
	        driver = "COM.ibm.db2.jdbc.app.DB2Driver";
	        connURL = "jdbc:db2:TPEDB2P";
	        connID = "cs98";
	        connPW = "cs98";
	   }
	   
	   
	   public void setDB2TUser() 
	   {
	        driver = "COM.ibm.db2.jdbc.app.DB2Driver";
	        connURL = "jdbc:db2:TPEDB2T";
	        connID = "cs98";
	        connPW = "cs98";
	    }

	   public void setDB2UserCP() 
	   {
	        driver = "weblogic.jdbc.pool.Driver";
	        connURL = "jdbc:weblogic:pool:CAL.FZDS01";
	    }
	 //cs80 add 20140429 CRM conn
	   public void setDB2UserTcrm() 
       {
            driver = "COM.ibm.db2.jdbc.app.DB2Driver";
            connURL = "jdbc:db2:TPEDB2T";
            connID = "csbi01";
            connPW = "cs8888";
       }       
       public void setDB2UserPcrm() 
       {
            driver = "COM.ibm.db2.jdbc.app.DB2Driver";
            connURL = "jdbc:db2:TPEDB2P";
            connID = "csbi01";
            connPW = "cs8888";
       }
	   
       public void setDB2crmCP() 
       {
            driver = "weblogic.jdbc.pool.Driver";
            connURL = "jdbc:weblogic:pool:CAL.FZDS07";
       }
       
       public void setAIXUserT()
       {
            driver = "COM.ibm.db2.jdbc.app.DB2Driver";
            connURL = "jdbc:db2:UGDDB2T";
            connID = "csbi01";
            connPW = "cs$888";
       }	   
       public void setAIXUserP() 
       {
            driver = "COM.ibm.db2.jdbc.app.DB2Driver";
            connURL = "jdbc:db2:UGDDB2P";
            connID = "csbi01";
            connPW = "cs$888";
       }      
       
       
       public void setAIXUserCP()  
       {
            driver = "weblogic.jdbc.pool.Driver";
            connURL = "jdbc:weblogic:pool:CAL.FZDS06";
       }
	     /**
	     * @return Returns the driver.
	     */
	    public String getDriver() {
	        return driver;
	    }
	
	    /**
	     * @return Returns the connURL.
	     */
	    public String getConnURL() {
	        return connURL;
	    }
	
	    /**
	     * @return Returns the connID.
	     */
	    public String getConnID() {
	        return connID;
	    }
	
	    /**
	     * @return Returns the connPW.
	     */
	    public String getConnPW() {
	        return connPW;
	    }
}

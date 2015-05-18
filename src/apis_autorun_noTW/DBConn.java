package apis_autorun;

/**
 * @author cs71 Created on  2006/9/1
 */
public class DBConn
{
    /**
     * @param connURL�G�s�u�r�� <br>
     *        ex: jdbc:oracle:thin:@ip:port:dbname
     * @param connID �G�s�u�b��
     * @param connPW �G�s�u�K�X
     * @param driver�GDriver
     */
		private String connURL = null;
		private String connID = null;
		private String connPW = null;
		private String driver = null;

	   public DBConn() 
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
	   
	   public void setORP3EGUser() 
	   {
	        driver = "oracle.jdbc.driver.OracleDriver";
	        connURL = "jdbc:oracle:thin:@HDQora03L:1521:orp3";
	        //connID = "eg01";
	        //connPW = "cseg#01";
	        connID = "egap";
	        connPW = "cseg#ap";
	    }
	   
	   public void setORP3FZUser()
	    {
	        driver = "oracle.jdbc.driver.OracleDriver";
	        connURL = "jdbc:oracle:thin:@HDQora03L:1521:orp3";
	        connID = "fzw2";
	        connPW = "xns72fs9kf";
	    }
	   
	   public void setORT1FZUser()
	    {
	        driver = "oracle.jdbc.driver.OracleDriver";
	        connURL = "jdbc:oracle:thin:@HDQora01T:1521:ort1";
	        connID = "fzw2";
	        connPW = "xns72fs9kf";
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

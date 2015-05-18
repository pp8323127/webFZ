package fz.ipad;

/**
 * @author cs71 Created on  2006/7/14
 */
public class MSSQLConn
{
    private String connURL = null;
    private String connID = null;
    private String connPW = null;
    private String driver = null;
    
    public void setDIPConn() 
    {
        driver = "com.microsoft.jdbc.sqlserver.SQLServerDriver";
        connURL = "jdbc:microsoft:sqlserver://10.16.48.20:1433;DatabaseName=dip_ez";
        connID = "hr_cs_ipad";
        connPW = "1a2x5e4";
        //Properties props = new Properties();
        //props.put("user", "lms_cs71_fchr");
        //props.put("password", "fchr4527");
    }
    
    public String getDriver() 
    {
        return driver;
    }

    /**
     * @return Returns the connURL.
     */
    public String getConnURL() 
    {
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

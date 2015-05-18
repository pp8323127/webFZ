package ci.db;

/**
 * ConnAOCI ³s½uAOCIPROD
 * 
 * @author cs66
 * @version 1.0 2005/12/8
 * 
 * Copyright: Copyright (c) 2005
 */
public class ConnAOCI {
    private String connURL = null;
    private String connID = null;
    private String connPW = null;
    private String driver = null;

    public void setAOCIFZUser() {
        setDriver("oracle.jdbc.driver.OracleDriver");
//        setConnURL("jdbc:oracle:thin:@192.168.242.41:1521:AOCIPROD");
        setConnURL("jdbc:oracle:thin:@10.16.58.23:1521:AOCIPROD");
        setConnID("csfz01");
        setConnPW("csfz#01");
    }
    
    public String getConnID() {
        return connID;
    }

    private void setConnID(String connID) {
        this.connID = connID;
    }

    public String getConnPW() {
        return connPW;
    }

    private void setConnPW(String connPW) {
        this.connPW = connPW;
    }

    public String getConnURL() {
        return connURL;
    }

    private void setConnURL(String connURL) {
        this.connURL = connURL;
    }

    public String getDriver() {
        return driver;
    }

    private void setDriver(String driver) {
        this.driver = driver;
    }
}
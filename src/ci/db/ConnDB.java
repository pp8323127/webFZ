// Decompiled by DJ v3.9.9.91 Copyright 2005 Atanas Neshkov  Date: 2008/5/28 AM 11:20:36
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   ConnDB.java
// DataSource version ConnDB 2009/10/16 14:52
// cs27 10/17 change
// -- //        connURL = "jdbc:oracle:thin:@192.168.242.41:1521:AOCIPROD";
// --        connURL = "jdbc:oracle:thin:@HDQora02L:1521:AOCIPROD";
// DataSource Pool Connection Index
//    setORP3FZUserCP_new() - CAL.FZDS02
//    setORP3FZUserCP()     - CAL.FZDS02
//    setORP3EGUserCP()     - CAL.EGDS01
//    setEGUserCP()         - CAL.EGDS01
//    setAOCIPRODCP()       - CAL.FZDS03
//    setDFUserCP()         - CAL.DFDS01
//    setDZUserCP()         - CAL.DZDS01
//    setDKUserCP()         - CAL.DKDS01    2009/10/27 add

// CS80 2014/05/05 CRM new add 
package ci.db;


public class ConnDB
{

    public String getVersion() {
//      return "20091027" ;
        return "20140505" ;
    }

    public ConnDB()
    {
        connURL = null;
        connID = null;
        connPW = null;
        driver = null;
    }

    public void setORP3FZUserCP_new()
    {
        driver = "ci.db.PoolDriver";
        connURL = "CAL.FZDS02";
    }

    public void setORP3FZUserCP()
    {
        driver = "ci.db.PoolDriver";        
        connURL = "CAL.FZDS02";
    }

    public void setORP3EGUserCP()
    {
//        driver = "weblogic.jdbc.pool.Driver";
//        connURL = "jdbc:weblogic:pool:CAL.EGCP01";
        driver = "ci.db.PoolDriver";        
        connURL = "CAL.EGDS01";
    }

    public void setEGUserCP()
    {
//        driver = "weblogic.jdbc.pool.Driver";
//        connURL = "jdbc:weblogic:pool:CAL.EGCP01";
        driver = "ci.db.PoolDriver";        
        connURL = "CAL.EGDS01";
    }
    


    public void setAOCIPRODCP()
    {
//        driver = "weblogic.jdbc.pool.Driver";
//        connURL = "jdbc:weblogic:pool:CAL.FZCP03";  //csfzw1
        driver = "ci.db.PoolDriver";        
        connURL = "CAL.FZDS03";
    }

    public void setDFUserCP()
    {
//        driver = "weblogic.jdbc.pool.Driver";
//        connURL = "jdbc:weblogic:pool:CAL.DFCP01";
        driver = "ci.db.PoolDriver";        
        connURL = "CAL.DFDS01";
    }

    public void setDZUserCP()
    {
//        driver = "weblogic.jdbc.pool.Driver";
//        connURL = "jdbc:weblogic:pool:CAL.DZCP01";
        driver = "ci.db.PoolDriver";        
        connURL = "CAL.DZDS01";
    }

    public void setDKUserCP()               // 2009/10/27 new add
    {
        driver = "ci.db.PoolDriver";
        connURL = "CAL.DKDS01";
    }
    
    public void setCRMUserCP()              // 2014/05/05 CRM new add
    {
        driver = "ci.db.PoolDriver";
        connURL = "CAL.FZDS05";
    }
// -----------------
// DIRECT CONNECTION
// -----------------
    public void setORP3DFUser()
    {
        driver = "oracle.jdbc.driver.OracleDriver";
//        connURL = "jdbc:oracle:thin:@192.168.242.55:1521:orp3";
        connURL = "jdbc:oracle:thin:@HDQora03L:1521:orp3";
        connID = "df01";
        connPW = "df1234";
    }

    public void setORP3EGUser()
    {
        driver = "oracle.jdbc.driver.OracleDriver";
//        connURL = "jdbc:oracle:thin:@192.168.242.55:1521:orp3";
        connURL = "jdbc:oracle:thin:@HDQora03L:1521:orp3";
        connID = "eg01";
        connPW = "cseg#01";
    }

    public void setORP3FZUser()
    {
        driver = "oracle.jdbc.driver.OracleDriver";
//        connURL = "jdbc:oracle:thin:@192.168.242.55:1521:orp3";
        connURL = "jdbc:oracle:thin:@HDQora03L:1521:orp3";
        connID = "fz02";
        connPW = "csfz#02";
    }

    public void setORP3FZAP()
    {
        driver = "oracle.jdbc.driver.OracleDriver";
//        connURL = "jdbc:oracle:thin:@192.168.242.55:1521:orp3";
        connURL = "jdbc:oracle:thin:@HDQora03L:1521:orp3";
        connID = "fzap";
        connPW = "FZ921002";
    }

    public void setAOCIPROD()
    {
        driver = "oracle.jdbc.driver.OracleDriver";
//        connURL = "jdbc:oracle:thin:@192.168.242.41:1521:AOCIPROD";
        connURL = "jdbc:oracle:thin:@10.16.58.23:1521:AOCIPROD";
//        connID = "acdba";
//        connPW = "acdba";
        connID = "csfz01";
        connPW = "csfz#01";
    }

    public void setAOCIPRODFZUser()
    {
        driver = "oracle.jdbc.driver.OracleDriver";
//        connURL = "jdbc:oracle:thin:@192.168.242.41:1521:AOCIPROD";
//        connURL = "jdbc:oracle:thin:@HDQora02L:1521:AOCIPROD";
        connURL = "jdbc:oracle:thin:@10.16.58.23:1521:AOCIPROD";
        connID = "csfz01";
        connPW = "csfz#01";
    }

    public void setAOCIPRODUser()
    {
        driver = "oracle.jdbc.driver.OracleDriver";
//        connURL = "jdbc:oracle:thin:@192.168.242.41:1521:AOCIPROD";
//        connURL = "jdbc:oracle:thin:@HDQora02L:1521:AOCIPROD";
        connURL = "jdbc:oracle:thin:@10.16.58.23:1521:AOCIPROD";
        connID = "jzdba";
        connPW = "jzdba";
    }

    public void setAOCIPRODJZDB()
    {
        driver = "oracle.jdbc.driver.OracleDriver";
//        connURL = "jdbc:oracle:thin:@192.168.242.41:1521:AOCIPROD";
//        connURL = "jdbc:oracle:thin:@HDQora02L:1521:AOCIPROD";
        connURL = "jdbc:oracle:thin:@10.16.58.23:1521:AOCIPROD";
        connID = "csjzap";
        connPW = "yxul4dj4";
    }

    public void setORP3FZDB()
    {
        driver = "oracle.jdbc.driver.OracleDriver";
//        connURL = "jdbc:oracle:thin:@192.168.242.55:1521:orp3";
        connURL = "jdbc:oracle:thin:@HDQora03L:1521:orp3";
        connID = "fzdb";
        connPW = "fz$888";
    }

    public void setORP3DZUser()
    {
        driver = "oracle.jdbc.driver.OracleDriver";
//        connURL = "jdbc:oracle:thin:@192.168.242.55:1521:orp3";
        connURL = "jdbc:oracle:thin:@HDQora03L:1521:orp3";
        connID = "dzdb";
        connPW = "dz$888";
    }

    public void setORT1DFUser()
    {
        driver = "oracle.jdbc.driver.OracleDriver";
//        connURL = "jdbc:oracle:thin:@192.168.42.42:1521:ort1";
        connURL = "jdbc:oracle:thin:@HDQora03T:1521:ort1";
        connID = "df01";
        connPW = "csdf#01";
    }

    public void setORT1FZ()
    {
        driver = "oracle.jdbc.driver.OracleDriver";
//        connURL = "jdbc:oracle:thin:@192.168.42.42:1521:ort1";
        connURL = "jdbc:oracle:thin:@HDQora03T:1521:ort1";
        connID = "fzdb";
        connPW = "fz$888";
    }

    public void setORT1FZUser()
    {
        driver = "oracle.jdbc.driver.OracleDriver";
//        connURL = "jdbc:oracle:thin:@192.168.42.42:1521:ort1";
        connURL = "jdbc:oracle:thin:@HDQora03T:1521:ort1";
        connID = "fzw2";
        connPW = "xns72fs9kf";
    }

    public void setORT1AOCITESTUser()
    {
        driver = "oracle.jdbc.driver.OracleDriver";
//        connURL = "jdbc:oracle:thin:@HDQora03T:1521:aocitest";
        connURL = "jdbc:oracle:thin:@10.16.58.34:1521:aocitest";
        connID = "acdba";
        connPW = "acdba";
    }

    public void setORT1EG()
    {
        driver = "oracle.jdbc.driver.OracleDriver";
//        connURL = "jdbc:oracle:thin:@192.168.42.42:1521:ort1";
        connURL = "jdbc:oracle:thin:@HDQora03T:1521:ort1";
        connID = "egdb";
        connPW = "eg$888";
    }

    public void setORT1JD()
    {
        driver = "oracle.jdbc.driver.OracleDriver";
//        connURL = "jdbc:oracle:thin:@192.168.42.42:1521:ort1";
        connURL = "jdbc:oracle:thin:@HDQora03T:1521:ort1";
        connID = "jddb";
        connPW = "jddb";
    }

    public void setORT1DZUser()
    {
        driver = "oracle.jdbc.driver.OracleDriver";
//        connURL = "jdbc:oracle:thin:@192.168.42.42:1521:ort1";
        connURL = "jdbc:oracle:thin:@HDQora03T:1521:ort1";
        connID = "dzdb";
        connPW = "dz$888";
    }

    public void setDBFDA()
    {
        driver = "sun.jdbc.odbc.JdbcOdbcDriver";
        connURL = "jdbc:odbc:da";
        connID = "";
        connPW = "";
    }

    public void setORT1FZAP()
    {
        driver = "oracle.jdbc.driver.OracleDriver";
//        connURL = "jdbc:oracle:thin:@192.168.42.42:1521:ort1";
        connURL = "jdbc:oracle:thin:@hdqora03t:1521:ort1";
        connID = "fzap";
        connPW = "FZ921002";
    }
    
    public void setCRMUserLive()
    {
        driver="oracle.jdbc.driver.OracleDriver";
        connURL="jdbc:oracle:thin:@10.16.52.12:1521:CRMP";
        connID="CSBI01";
        connPW="abkl2ix0";
        
    }
    public void setCRMUserTest()
    {
        driver="oracle.jdbc.driver.OracleDriver";
        connURL="jdbc:oracle:thin:@10.16.52.12:1521:CRMT";
        connID="CSBI01";
        connPW="abkl2ix0";
        
    }
    public String getDriver()
    {
        return driver;
    }

    public String getConnURL()
    {
        return connURL;
    }

    public String getConnID()
    {
        return connID;
    }

    public String getConnPW()
    {
        return connPW;
    }

    private String connURL;
    private String connID;
    private String connPW;
    private String driver;
    
}
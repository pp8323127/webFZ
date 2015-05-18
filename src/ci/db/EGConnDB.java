/*
 * �b 2004/8/3 �إ� ��Ʈw�s�uDriver,�r�� 
 *  modify by cs66 at 2005/6/13 change password
 * of ACOITEST,del static keyword!!  
 * 2005/7/22 add ACOUPRODFZUser() 
 * 2005/12/09 add PDA DB connection by cs71
 */

package ci.db;

/**
 * @author cs66 add setDFUserCP() at 2005/6/6 <br>
 *             2005/9/7 add setDZUserCP()
 */
public class EGConnDB {
    /**
     * @param connURL�G�s�u�r�� <br>
     *            ex: jdbc:oracle:thin:@ip:port:dbname
     * @param connID �G�s�u�b��
     * @param connPW �G�s�u�K�X
     * @param driver�GDriver
     */
    private String connURL = null;
    private String connID = null;
    private String connPW = null;
    private String driver = null;

    public EGConnDB() {
    }
/*
    public static void main(String[] args) {
        ConnDB cn = new ConnDB();
        cn.setORT1FZ();

        System.out.println(cn.getDriver() + "\t" + cn.getConnURL() + "\t"
                + cn.getConnID() + "\t" + cn.getConnPW());

    }
*/

    /**
     * �]�wWeblogic�� Connection pool �s�u�r�� <br>
     * System: FZ <br>
     * ���B�]�wdriver��ConnURL <br>
     */
    public void setORP3FZUserCP() {
//        driver = "weblogic.jdbc.pool.Driver";
//        connURL = "jdbc:weblogic:pool:CAL.FZCP02";
        driver = "ci.db.PoolDriver";        
        connURL = "CAL.FZDS02";
    }

    /**
     * �]�wWeblogic�� Connection pool �s�u�r�� <br>
     * System: EG <br>
     * ���B�]�wdriver��ConnURL <br>
     */
    public void setORP3EGUserCP() 
    {
//        driver = "weblogic.jdbc.pool.Driver";
//        connURL = "jdbc:weblogic:pool:CAL.EGCP01";
        driver = "ci.db.PoolDriver";        
        connURL = "CAL.EGDS01";
    }

    /**
     * �]�wWeblogic�� Connection pool �s�u�r�� <br>
     * System: AirCrews <br>
     * ���B�]�wdriver��ConnURL <br>
     */
    public void setAOCIPRODCP() {
//        driver = "weblogic.jdbc.pool.Driver";
//        connURL = "jdbc:weblogic:pool:CAL.DZCP02";
        driver = "ci.db.PoolDriver";        
        connURL = "CAL.DZDS02";
    }

    /**
     * connection pool for df01 System: DF Test & live are the same.
     */
    public void setDFUserCP() {
//        driver = "weblogic.jdbc.pool.Driver";
//        connURL = "jdbc:weblogic:pool:CAL.DFCP01";
        driver = "ci.db.PoolDriver";        
        connURL = "CAL.DFDS01";
    }

    public void setDZUserCP() {
//        driver = "weblogic.jdbc.pool.Driver";
//        connURL = "jdbc:weblogic:pool:CAL.DZCP01";
        driver = "ci.db.PoolDriver";        
        connURL = "CAL.DZDS01";
    }
    
    public void setDNUserCP() {
//        driver = "weblogic.jdbc.pool.Driver";
//        connURL = "jdbc:weblogic:pool:CAL.DNCP01";
        driver = "ci.db.PoolDriver";        
        connURL = "CAL.DNDS01";
        
    }
    
    public void setDMUserCP() {
//        driver = "weblogic.jdbc.pool.Driver";
//        connURL = "jdbc:weblogic:pool:CAL.MUCP01";
        driver = "ci.db.PoolDriver";        
        connURL = "CAL.MUDS01";
    }
    
    public void setEGUserCP() 
    {
//        driver = "weblogic.jdbc.pool.Driver";
//        connURL = "jdbc:weblogic:pool:CAL.EGCP01";
        driver = "ci.db.PoolDriver";        
        connURL = "CAL.EGDS01";
    }

    //****************192.168.242.55 ORP3************************
    public void setORP3DNUser() {
        driver = "oracle.jdbc.driver.OracleDriver";
        connURL = "jdbc:oracle:thin:@HDQora03L:1521:orp3";
        connID = "dn01";
        connPW = "csdn#01";
        //connID = "dndb";
        //connPW = "dn$888";
    }
    
    public void setORP3EJUser() 
    {
        driver = "oracle.jdbc.driver.OracleDriver";
        connURL = "jdbc:oracle:thin:@HDQora03L:1521:orp3";
        connID = "ej01";
        connPW = "csej#01";
    }    
    
    public void setORP3DFUser() {
        driver = "oracle.jdbc.driver.OracleDriver";
        connURL = "jdbc:oracle:thin:@HDQora03L:1521:orp3";
        connID = "df01";
        connPW = "df1234";
        //connID = "dfdb";
        //connPW = "df$888";
    }

    public void setORP3EGUser() {
        driver = "oracle.jdbc.driver.OracleDriver";
        connURL = "jdbc:oracle:thin:@HDQora03L:1521:orp3";
        //connID = "eg01";
        //connPW = "cseg#01";
//        connID = "egap";
//        connPW = "cseg#ap";
        connID = "egdb";
        connPW = "eg$888";

    }

    public void setORP3FZUser() {
        driver = "oracle.jdbc.driver.OracleDriver";
        connURL = "jdbc:oracle:thin:@HDQora03L:1521:orp3";
        connID = "fz02";
        connPW = "csfz#02";

    }

    /**
     * �s���B��
     */
    public void setORP3FZAP() {
        driver = "oracle.jdbc.driver.OracleDriver";
        connURL = "jdbc:oracle:thin:@HDQora03L:1521:orp3";
        connID = "fzap";
        connPW = "FZ921002";
    }

    public void setAOCIPROD() {
        driver = "oracle.jdbc.driver.OracleDriver";
        connURL = "jdbc:oracle:thin:@192.168.242.41:1521:AOCIPROD";
//        connID = "csfz01";
//        connPW = "csfz#01";
        connID = "acdba";
        connPW = "cs#1234";
    }

    public void setAOCIPRODFZUser() {
        driver = "oracle.jdbc.driver.OracleDriver";
        connURL = "jdbc:oracle:thin:@192.168.242.41:1521:AOCIPROD";
        connID = "csfz01";
        connPW = "csfz#01";
    }

    public void setAOCIPRODUser() {
        driver = "oracle.jdbc.driver.OracleDriver";
        connURL = "jdbc:oracle:thin:@192.168.242.41:1521:AOCIPROD";
        connID = "jzdba";
        connPW = "jzdba";
    }

    public void setAOCIPRODJZDB() { // �p�޳s�u VIA AOCIPROD BY CS73
        driver = "oracle.jdbc.driver.OracleDriver";
        connURL = "jdbc:oracle:thin:@192.168.242.41:1521:AOCIPROD";
        connID = "csjzap";
        connPW = "yxul4dj4";
    }

    public void setORP3FZDB() {
        driver = "oracle.jdbc.driver.OracleDriver";
        connURL = "jdbc:oracle:thin:@HDQora03L:1521:orp3";
        connID = "fzdb";
        connPW = "fz$888";
    }

    public void setORP3DZUser() {
        driver = "oracle.jdbc.driver.OracleDriver";
        connURL = "jdbc:oracle:thin:@HDQora03L:1521:orp3";
        connID = "dzdb";
        connPW = "dz$888";
    }
    
    public void setORP3MUUser() {
        driver = "oracle.jdbc.driver.OracleDriver";
        connURL = "jdbc:oracle:thin:@HDQora03L:1521:orp3";
        connID = "MUW1";   
        connPW = "k2l3i4h1";
    }

    //****************192.168.42.42 ORT1************************
    public void setORT1DNUser() {
        driver = "oracle.jdbc.driver.OracleDriver";
        connURL = "jdbc:oracle:thin:@HDQora03T:1521:ort1";
        connID = "dn01";
        connPW = "csdn#01";
    }
    
    public void setORT1PDAUser() {
        driver = "oracle.jdbc.driver.OracleDriver";
        connURL = "jdbc:oracle:thin:@HDQora03T:1521:ort1";
        connID = "testml";
        connPW = "sql";
    }    
   
    public void setORT1FZ() {
        driver = "oracle.jdbc.driver.OracleDriver";
        connURL = "jdbc:oracle:thin:@HDQora01T:1521:ort1";
        connID = "fzdb";
        connPW = "fz$888";
    }

    public void setORT1FZUser() {
        driver = "oracle.jdbc.driver.OracleDriver";
        connURL = "jdbc:oracle:thin:@HDQora01T:1521:ort1";
        connID = "fz02";
        connPW = "csfz#02";
    }

    public void setORT1AOCITESTUser() {
        driver = "oracle.jdbc.driver.OracleDriver";
        connURL = "jdbc:oracle:thin:@HDQora01T:1521:aocitest";
        connID = "acdba";
        connPW = "acdba";
    }

    public void setORT1EG() {
        driver = "oracle.jdbc.driver.OracleDriver";
        connURL = "jdbc:oracle:thin:@HDQora01T:1521:ort1";
        connID = "egdb";
        connPW = "eg$888";
    }

    public void setORT1JD() { //CONNECT TO JD VIA ORT1 BY CS73
        driver = "oracle.jdbc.driver.OracleDriver";
        connURL = "jdbc:oracle:thin:@HDQora01T:1521:ort1";
        connID = "jddb";
        connPW = "jddb";
    }

    public void setORT1DZUser() { //CONNECT TO DZ VIA ORT1 BY CS55
        driver = "oracle.jdbc.driver.OracleDriver";
        connURL = "jdbc:oracle:thin:@HDQora01T:1521:ort1";
        connID = "dzdb";
        connPW = "dz$888";
    }
    
    public void setORT1MUUser() { 
        driver = "oracle.jdbc.driver.OracleDriver";
        connURL = "jdbc:oracle:thin:@HDQora01T:1521:ort1";
        connID = "MUW1";   
        connPW = "k2l3i4h1";
    }

    //	connect to DA O:\DA\Db\*.dbf
    public void setDBFDA() {
        driver = "sun.jdbc.odbc.JdbcOdbcDriver";
        connURL = "jdbc:odbc:da";
        connID = "";
        connPW = "";
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
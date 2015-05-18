package al;

import org.apache.log4j.Logger;
/**
 * <p>Log helper object</p>
 *
 * <p>Copyright: Copyright (c) 2005</p>
 *
 * <p>Company: China-airlines </p>
 *
 * @version 1.0
 * @author Marc Tsai 639784
 * @since JDK 1.4
 */

public class Loger
{
    private static final Logger logger = Logger.getLogger(Loger.class);
    /**
    * Set error log using log4j
    */
    public void setErrorLog(String pageName,String userName,String sql,Exception e){
    	
	logger.error("Error "+new java.util.Date()+" "+pageName+"/"+userName+" "+sql,e);
    }
    /**
    * Set error log using log4j
    */
    public void setErrorLog(String pageName,String userName,Exception e){
        
	logger.error("Error "+new java.util.Date()+" "+pageName+"/"+userName,e);
    }
    /**
    * Set Info log using log4j
    */
    public void setCommonInfoLog(String pageName,String userName,String msg){
	logger.info("CommonInfo "+new java.util.Date()+" "+pageName+"/"+userName+" "+msg);
    }
    /**
    * Set Info log using log4j
    */
    public void setLoginLog(String userName){
	logger.info("Login "+new java.util.Date()+" "+userName);
    }
}

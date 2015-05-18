package ci.db;

import java.sql.*;

import javax.naming.*;
import javax.sql.*;

/**
 * ConnectDataSource �ϥ�weblogic DataSource�s�uDB. <br>
 * 
 * @author cs66
 * @version 1.0 2005/10/31
 * 
 * Copyright: Copyright (c) 2005
 */
public class ConnectDataSource {
    private static Context initContext = null;
    private static DataSource ds = null;

    /**
     * @return Connection ,�ϥ�DF��Datasource��Connection
     */
    public Connection getDFConnection() throws SQLException,
            ClassNotFoundException, NamingException {
        if ( initContext == null ) {
            initContext = new InitialContext();
            ds = (javax.sql.DataSource) initContext.lookup("CAL.DFDS01");
            ds.setLoginTimeout(60);
        }

        return ds.getConnection();
    }

    /**
     * @return Connection ,�ϥ�DZ��Datasource��Connection
     */
    public Connection getDZConnection() throws SQLException,
            ClassNotFoundException, NamingException {
        if ( initContext == null ) {
            initContext = new InitialContext();
            ds = (javax.sql.DataSource) initContext.lookup("CAL.DZDS01");
            ds.setLoginTimeout(60);
        }
    
        return ds.getConnection();
    }

    /**
     * @return Connection ,�ϥ�EG��Datasource��Connection
     */
    public Connection getEGConnection() throws SQLException,
            ClassNotFoundException, NamingException {
        if ( initContext == null ) {
            initContext = new InitialContext();
            ds = (javax.sql.DataSource) initContext.lookup("CAL.EGDS01");
            ds.setLoginTimeout(60);
        }

        return ds.getConnection();
    }

    /**
     * @return Connection ,�ϥ�FZ��Datasource��Connection
     */
    public Connection getFZConnection() throws SQLException,
            ClassNotFoundException, NamingException {
        if ( initContext == null ) {
            initContext = new InitialContext();
            ds = (javax.sql.DataSource) initContext.lookup("CAL.FZDS01");
            ds.setLoginTimeout(60);
        }

        return ds.getConnection();
    }
}
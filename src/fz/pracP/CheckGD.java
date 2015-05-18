package fz.pracP;

import ci.db.*;
import java.sql.*;

/** 
 * @author cs55
 * @version 2 cs66 2006/2/18 <br>
 * @version 2.1 cs66 2007/01/12 檢查ZC是否輸入
 * 
 *              DB:connection pool
 *  
 *  
 */

public class CheckGD {
    private Connection con = null;
    private Statement stmt = null;
    private ResultSet rs = null;

        public static void main(String[] args) 
        {
            CheckGD cgd = new CheckGD();
//            String[] sern = { "20306" , "7807" };
//            String[] score = { "7" , "8" };
            int str = cgd.doKPICheck("2010/05/01" ,"0781" ,"TPESGN");
            System.out.println(str);
        }

    //檢查組員分數是否1,2,3,9,10是否有記錄考核項目
    //傳入變數fdate-->2004/07/10, fltno-->003, sect-->SFOTPE, sern[]-->20306,
    // score[]-->0~10
    public String doCheck(String fdate, String fltno, String sect,
            String[] sern, String[] score) {
        String sql = null;
        int acount = 0;
        ConnDB cn = new ConnDB();
        Driver dbDriver = null;

        try 
        {
//            cn.setORT1EG();
//	    	java.lang.Class.forName(cn.getDriver());
//	    	con = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
//	    	stmt = con.createStatement();	
	    	
            cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            con = dbDriver.connect(cn.getConnURL() ,null);

            
            stmt = con.createStatement();

            for ( int i = 0; i < sern.length; i++) {
                if ( score[i].equals("1") || score[i].equals("2")
                        || score[i].equals("3") || score[i].equals("9")
                        || score[i].equals("10") ) {
                    acount = 0;
                    sql = "select count(*) acount from egtgddt where fltd = to_date('"
                            + fdate
                            + "','yyyy/mm/dd') and fltno = '"
                            + fltno
                            + "' and sect = '"
                            + sect
                            + "' and length(gdtype)>2 and gdtype <> 'GD1' and sern="
                            + sern[i];
                    rs = stmt.executeQuery(sql);
                    if ( rs.next() ) {
                        acount = rs.getInt("acount");
                    }
                    if ( acount == 0 ) { return sern[i]; }
                }
            }
            return "0";
        } catch (Exception e) {
            //e.printStackTrace();
            try {
                con.rollback();
            } catch (SQLException se) {}
            return "Error:" + e.toString();
        } finally {
            try {
                if ( rs != null ) rs.close();
            } catch (SQLException e) {}
            try {
                if ( stmt != null ) stmt.close();
            } catch (SQLException e) {}
            try {
                if ( con != null ) con.close();
            } catch (SQLException e) {}
        }
    }
    
    public int doKPICheck(String fdate, String fltno, String sect) 
    {
        String sql = null;
        int c = -1;
        ConnDB cn = new ConnDB();
        Driver dbDriver = null;

        try 
        {
//            cn.setORT1EG();
//	    	java.lang.Class.forName(cn.getDriver());
//	    	con = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
//	    	stmt = con.createStatement();	
	    	
            cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            con = dbDriver.connect(cn.getConnURL() ,null);
            stmt = con.createStatement();

            sql = "select count(*) c from egtgddt where fltd = to_date('"
                    + fdate
                    + "','yyyy/mm/dd') and fltno = '"
                    + fltno
                    + "' and sect = '"
                    + sect
                    + "' and gdtype = 'GD25' ";
//System.out.println(sql);            
            rs = stmt.executeQuery(sql);
            if ( rs.next() ) 
            {
                c = rs.getInt("c");
            }
        } 
        catch (Exception e) 
        {
            e.printStackTrace();
//            try 
//            {
//                con.rollback();
//            } catch (SQLException se) {}
        } 
        finally 
        {
            try {
                if ( rs != null ) rs.close();
            } catch (SQLException e) {}
            try {
                if ( stmt != null ) stmt.close();
            } catch (SQLException e) {}
            try {
                if ( con != null ) con.close();
            } catch (SQLException e) {}
        }
        return c;
    }
}
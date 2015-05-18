package fzAuthP;

import java.sql.*;

import ci.db.*;
import ci.tool.*;

/**
 * 輸入員工號後，將原始密碼寄至該帳號全員信箱 <br>
 * DB:Connection pool
 * 
 * @author cs66 at 2005/7/3
 * @version 1.1 2006/03/01
 */
public class ForgetPW {
    private String userid;
    private String password;
    private ConnDB cn;
    private Connection conn;
    private Statement stmt;
    private String sql = null;
    private ResultSet rs;
    private Driver dbDriver = null;
    private boolean isValidAcc;
    private boolean status;

    public ForgetPW(String userid) 
    {
        this.userid = userid;
        cn = new ConnDB();
//        cn.setORP3FZUser();
        cn.setORP3FZUserCP();
    }

    public void RetrievePW() 
    {
        try 
        {
//            java.lang.Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() ,cn.getConnPW());
            
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL() ,null);
            
            stmt = conn.createStatement();

            sql = "select pwd from fztuser where userid='" + userid + "'";

            rs = stmt.executeQuery(sql);
            String pw = null;
            while (rs.next()) 
            {
                pw = rs.getString("pwd");
            }

            if ( null != pw ) {
                setPassword(pw);
                setValidAcc(true);
            } else {
                setValidAcc(false);
                setPassword(null);
            }

        } 
        catch (ClassNotFoundException e) 
        {
            System.out.println(e.toString());
        } 
        catch (SQLException e) 
        {
            System.out.println(e.toString());
        } 
        catch (InstantiationException e) 
        {
            System.out.println(e.toString());
        } 
        catch (IllegalAccessException e) 
        {
            System.out.println(e.toString());
        } 
        finally {
            if ( rs != null ) try {
                rs.close();
            } catch (SQLException e) {
                System.out.println(e.toString());
            }
            if ( stmt != null ) try {
                stmt.close();
            } catch (SQLException e) {
                System.out.println(e.toString());
            }
            if ( conn != null ) try {
                conn.close();
            } catch (SQLException e) {
                System.out.println(e.toString());
            }
        }

    }

    public void job() 
    {
        RetrievePW();

        if ( isValidAcc ) 
        {
            StringBuffer sb = new StringBuffer();

            sb.append("您在組員班表資訊網的密碼為" + password + "\r\n");
            sb.append("請使用此密碼登入系統，謝謝。\r\n");
            sb.append("強烈建議您登入班表資訊網後，於「個人專區」中變更個人密碼。\r\n");

            sb.append("Your password of Cabin Crew Inquiry ");
            sb.append("System is " + password + "\r\n");
            sb.append("Please use it to access the system,Thank you.\r\n");
            sb.append("We recommend strictly that you change ");
            sb.append("the password after  logon the system.\r\n");

            DeliverMail dm = new DeliverMail();
            try 
            {
                dm.DeliverMailWithBackup("Your password of Cabin Crew Inquiry System" ,userid ,sb.toString());
                setStatus(true);
            } 
            catch (Exception e) 
            {
                e.printStackTrace();
            }
        } 
        else 
        {
            setStatus(false);
        }
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isValidAcc() {
        return isValidAcc;
    }

    public void setValidAcc(boolean isValidAcc) {
        this.isValidAcc = isValidAcc;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
}


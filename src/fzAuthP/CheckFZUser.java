package fzAuthP;

import java.sql.*;
import ci.db.*;

/**
 * 驗證fzuser的帳號密碼 <br>
 * DB: Connection pool
 * 
 * @author cs66 at 2005/6/29
 * @version 1.1 2006/03/01
 */
public class CheckFZUser 
{
    private ConnDB cn;
    private Connection conn;
    private PreparedStatement stmt;
    private String sql = null;
    private Driver dbDriver = null;
    private ResultSet rs;
    private boolean isFZUser;
    private boolean hasFZAccount;

    public static void main(String[] args) 
    {
        CheckFZUser ckFZUsr = new CheckFZUser();
    }
    
    public CheckFZUser() 
    {
        cn = new ConnDB();
//        cn.setORP3FZUser();
        cn.setORP3FZUserCP();
        RetrieveData();
    }

    public boolean RetrieveData() throws NullPointerException 
    {
        String pwd = null;
        int rowCount = 0;
        try 
        {
//				java.lang.Class.forName(cn.getDriver());
//				conn = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());
				
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL() ,null);
            
            sql = "select * from fztuser where userid =? ";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, UserID.getUserid());
            rs = stmt.executeQuery();
            while (rs.next()) 
            {
                pwd = rs.getString("pwd");
                rowCount++;
            }
            
            if ( rowCount == 0 ) 
            {
                //沒有fztuser帳號
                setHasFZAccount(false);
                setFZUser(false);
            } 
            else 
            {
                //有fztuser帳號
                setHasFZAccount(true);
                if ( pwd.equals(UserID.getPassword()) ) 
                {
                    //密碼驗證成功
                    setFZUser(true);
                } 
                else 
                {
                    setFZUser(false);
                }
            }

        } 
        catch (ClassNotFoundException e) 
        {
            System.out.println(toString());
        } 
        catch (SQLException e) 
        {
            System.out.println(toString());
        } 
//        catch (InstantiationException e) 
//        {
//            System.out.println(toString());
//        } 
//        catch (IllegalAccessException e) 
//        {
//            System.out.println(toString());
//        } 
        catch (Exception e) 
        {
          System.out.println(toString());
        } 
        finally 
        {
            if ( rs != null ) try {
                rs.close();
            } catch (SQLException e) {
                System.out.println(toString());
            }
            if ( stmt != null ) try {
                stmt.close();
            } catch (SQLException e) {
                System.out.println(toString());
            }
            if ( conn != null ) try {
                conn.close();
            } catch (SQLException e) {
                System.out.println(toString());
            }
        }
        return hasFZAccount;
    }

    public boolean isHasFZAccount() {
        return hasFZAccount;
    }

    public void setHasFZAccount(boolean hasFZAccount) {
        this.hasFZAccount = hasFZAccount;
    }

    public boolean isFZUser() {
        return isFZUser;
    }

    public void setFZUser(boolean isFZUser) {
        this.isFZUser = isFZUser;
    }
}
package fzAuthP;

import java.sql.*;

import ci.db.*;

/**
 * 驗證是否有班表 <br>
 * DB:Connection pool
 * 
 * @author cs66 at 2005/6/30
 * @version 1.1 2006/03/01
 */
public class CheckSkj 
{

//    public static void main(String[] args) 
//    {
//        fzAuth.UserID uid = new fzAuth.UserID("640073", null);
//        fzAuth.CheckSkj ckhSkj = new fzAuth.CheckSkj();
//        System.out.println(ckhSkj.isHasSkj());
//    }

    private ConnDB cn;
    private Connection conn;
    private Statement stmt;
    private String sql = null;
    private ResultSet rs;
    private Driver dbDriver = null;
    private String liveTable;
    private boolean isHasSkj;

    public CheckSkj() 
    {
        cn = new ConnDB();
//        cn.setORP3FZUser();
        cn.setORP3FZUserCP();
        RetrieveSkj();
    }

    public void RetrieveSkj() 
    {
        try 
        {
//              java.lang.Class.forName(cn.getDriver());
//              conn = DriverManager.getConnection(cn.getConnURL(),cn.getConnID() ,cn.getConnPW());
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL() ,null);

            stmt = conn.createStatement();

            sql = "select * from fztupdt";
            rs = stmt.executeQuery(sql);

            while (rs.next()) 
            {
                setLiveTable(rs.getString("table_name"));
            }
            rs.close();

            sql = "select count(*) count from " + liveTable + " where empno='"
                    + UserID.getUserid() + "'";
            int count = 0;
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                count = rs.getInt("count");
            }

            if ( count > 0 ) {
                setHasSkj(true);
            } else {
                setHasSkj(false);
            }

        } catch (ClassNotFoundException e) {
            System.out.println(e.toString());
        } catch (SQLException e) {
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
        finally 
        {
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

    public String getLiveTable() {
        return liveTable;
    }

    public void setLiveTable(String liveTable) {
        this.liveTable = liveTable;
    }

    public boolean isHasSkj() {
        return isHasSkj;
    }

    public void setHasSkj(boolean isHasSkj) {
        this.isHasSkj = isHasSkj;
    }
}


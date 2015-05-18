package fzAuthP;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * 取得fztcrew之資料 <br>
 * DB: Connection pool
 * 
 * @author cs66 at 2005/6/30
 * @version 1.1 2006/03/01
 * cs80 2012/12/25  //20130101啟用 CM & PU * 
 */
public class CheckFZCrew {

    public static void main(String[] args) 
    {
        UserID u = new UserID("632544", null);
        CheckFZCrew ckCrew = new CheckFZCrew();
        System.out.println(ckCrew.isFZCrew());
    }

    private ConnDB cn;
    private Connection conn;
    private Statement stmt;
    private String sql = null;
    private ResultSet rs;
    private Driver dbDriver = null;
    private FZCrewObj fzCrewObj;
    private boolean isFZCrew;
    private boolean newName = false;

    public CheckFZCrew() 
    {
        cn = new ConnDB();
//        cn.setORP3FZUser();
        cn.setORP3FZUserCP();
        RetrieveFZCrew();
    }

    public void RetrieveFZCrew() throws NullPointerException 
    { 
        Calendar calendar = Calendar.getInstance();
        String thisY = Integer.toString(calendar.get(Calendar.YEAR));
        System.out.println(thisY);
        if(Integer.parseInt(thisY) > 2012){
            newName=true;
        }
        try 
        {
//            java.lang.Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() , cn.getConnPW());

            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);

            stmt = conn.createStatement();
//            sql = "SELECT * FROM fztcrew WHERE empno='" + UserID.getUserid()+ "'";
            
            if(newName){//20130101啟用 CM & PU
                sql = " SELECT crew.empno empno, nvl(cb.station,crew.base) base, cb.sern box, cb.section sess, " +
                      " crew.cabin cabin, crew.NAME NAME, crew.ename ename, crew.fleet fleet, " +
                      " Nvl(crew.occu, CASE WHEN To_Number(jobno) <90 THEN 'CM' WHEN To_Number(jobno) = 95 THEN 'PU' " +
                      " else (CASE WHEN sex='M' THEN 'FA' ELSE 'FS' END) END) occu, Nvl(crew.locked,'N') locked " +
                      " FROM fztcrew crew, (SELECT Trim(empn) empn, sern, SECTION, station, jobno, sex FROM egtcbas) cb " +
                      " WHERE empno='" + UserID.getUserid()+ "' AND crew.empno = cb.empn (+)";

            }else{
            sql = " SELECT crew.empno empno, nvl(cb.station,crew.base) base, cb.sern box, cb.section sess, " +
                  " crew.cabin cabin, crew.NAME NAME, crew.ename ename, crew.fleet fleet, " +
                  " Nvl(crew.occu, CASE WHEN To_Number(jobno) <90 THEN 'PR' WHEN To_Number(jobno) = 95 THEN 'ZC' " +
                  " else (CASE WHEN sex='M' THEN 'FA' ELSE 'FS' END) END) occu, Nvl(crew.locked,'N') locked " +
                  " FROM fztcrew crew, (SELECT Trim(empn) empn, sern, SECTION, station, jobno, sex FROM egtcbas) cb " +
                  " WHERE empno='" + UserID.getUserid()+ "' AND crew.empno = cb.empn (+)";
            }
            rs = stmt.executeQuery(sql);

            while (rs.next()) 
            {
                fzCrewObj = new FZCrewObj();

                fzCrewObj.setEmpno(rs.getString("empno"));
                fzCrewObj.setBase(rs.getString("base"));
                fzCrewObj.setSern(rs.getString("box"));
                fzCrewObj.setCabin(rs.getString("cabin"));
                fzCrewObj.setCname(rs.getString("name"));
                fzCrewObj.setEname(rs.getString("ename"));
                fzCrewObj.setFleet(rs.getString("fleet"));
                fzCrewObj.setOccu(rs.getString("occu"));
                fzCrewObj.setSess(rs.getString("sess"));
                fzCrewObj.setLocked(rs.getString("locked"));

                setFzCrewObj(fzCrewObj);
            }

            if ( null == fzCrewObj ) 
            {
                setFZCrew(false);
            } 
            else 
            {
                setFZCrew(true);
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
        catch (Exception e) 
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

    public boolean isFZCrew() {
        return isFZCrew;
    }

    public void setFZCrew(boolean isFZCrew) {
        this.isFZCrew = isFZCrew;
    }

    public FZCrewObj getFzCrewObj() {
        if ( null == fzCrewObj ) {
            fzCrewObj = new FZCrewObj();
        }
        return fzCrewObj;
    }

    public void setFzCrewObj(FZCrewObj fzCrewObj) {
        this.fzCrewObj = fzCrewObj;
    }
}
package dz;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * CrewName 從員額表取得所有組員中英文姓名
 * 
 * @author cs66
 * @version 1.0 2005/9/21
 * 
 * Copyright: Copyright (c) 2005
 */
public class CrewName {

    //    public static void main(String[] args) {
    //        CrewName cn = new CrewName();
    //        System.out
    //                .println(cn.getCname("625559") + "\t" + cn.getEname("625559"));
    //
    //    }

    private ArrayList crewEmpnoAL;
    private ArrayList crewCnameAL;
    private ArrayList crewEnameAL;

    public CrewName() {
        selectCrewName();
    }

    public void selectCrewName() {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        String sql = null;
        ConnDB cn = new ConnDB();
        try {

            cn.setORP3FZAP();
            java.lang.Class.forName(cn.getDriver());
            conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() ,
                    cn.getConnPW());
            stmt = conn.createStatement();
            sql = "select distinct empno,c_name,l_name||' '||f_name ename "
                    + "from fztckpl  where status=1 order by empno";

            rs = stmt.executeQuery(sql);

            crewEmpnoAL = new ArrayList();
            crewCnameAL = new ArrayList();
            crewEnameAL = new ArrayList();
            while (rs.next()) {
                crewEmpnoAL.add(rs.getString("empno"));
                crewCnameAL.add(rs.getString("c_name"));
                crewEnameAL.add(rs.getString("ename"));
            }

        } catch (SQLException e) {
            System.out.print(e.toString());

        } catch (Exception e) {
            System.out.print(e.toString());

        } finally {

            if ( rs != null ) try {
                rs.close();
            } catch (SQLException e) {}
            if ( stmt != null ) try {
                stmt.close();
            } catch (SQLException e) {}
            if ( conn != null ) try {
                conn.close();
            } catch (SQLException e) {}

        }

    }

    /**
     * @param empno
     * @return 中文姓名,若無法取得,回傳空白
     */
    public String getCname(String empno) {
        int idx = 0;
        String cname = "";
        idx = crewEmpnoAL.indexOf(empno);
        if ( idx != -1 ) {
            cname = (String) crewCnameAL.get(idx);
        }
        return cname;
    }

    /**
     * @param empno
     * @return 英文姓名,若無法取得,回傳空白
     */
    public String getEname(String empno) {
        int idx = 0;
        String ename = "";
        idx = crewEmpnoAL.indexOf(empno);
        if ( idx != -1 ) {
            ename = (String) crewEnameAL.get(idx);
        }
        return ename;
    }

}
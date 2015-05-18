package aircrew;

import java.io.*;
import java.sql.*;
import java.util.*;

import ci.db.*;
import ci.tool.*;

/**
 * CrewInfo 取得AirCrews中的組員基本資料 <br>
 * talbe:crew_v,crew_rank_v,rank_tp_v
 * 
 * @author cs66
 * @version 1.0 2005/12/12
 * 
 * Copyright: Copyright (c) 2005
 */
public class CrewInfo {

        public static void main(String[] args) {
            CrewInfo ci = new CrewInfo();
            System.out.println(ci.getCname("811112"));
        }

    private ArrayList empnoAL;
    private ArrayList cnameAL;
    private ArrayList grpAL;
    private ArrayList rankAL;
    private ArrayList sernAL;
    private ArrayList cabinAL;

    public CrewInfo() {
        SelectData();
    }

    private void SelectData() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
//        ConnAOCI cn = new ConnAOCI();
        Driver dbDriver = null;
        ConnDB cn = new ConnDB();
        

        try {
        	 cn.setAOCIPRODCP();
			 dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			 conn = dbDriver.connect(cn.getConnURL(), null);

//			cna.setAOCIFZUser();
//			java.lang.Class.forName(cna.getDriver());
//			conn = DriverManager.getConnection(cna.getConnURL(), cna
//					.getConnID(), cna.getConnPW());

        	
            sql = "SELECT  c.staff_num,c.preferred_name cname ,"
                    + "c.section_number grp,c.seniority_code sern,"
                    + "crank.Rank_cd rank_cd ,p.fd_ind cabin "
                    + "FROM crew_rank_v crank, crew_v c, rank_tp_v p "
                    + "WHERE c.staff_num = crank.staff_num "
                    + "AND crank.rank_cd= p.display_rank_cd ";

            pstmt = conn.prepareStatement(sql);

            rs = pstmt.executeQuery();

            empnoAL = new ArrayList();
            cnameAL = new ArrayList();
            grpAL = new ArrayList();
            rankAL = new ArrayList();
            sernAL = new ArrayList();
            cabinAL = new ArrayList();

            while (rs.next()) {
                empnoAL.add(rs.getString("staff_num"));
                cnameAL.add(rs.getString("cname"));
                grpAL.add(rs.getString("grp"));
                rankAL.add(rs.getString("rank_cd"));
                sernAL.add(rs.getString("sern"));
                cabinAL.add(rs.getString("cabin"));
            }

        } catch (SQLException e) {
            System.out.println(e.toString());
        } catch (Exception e) {
            System.out.println(e.toString());
        } finally {
            if ( rs != null ) try {
                rs.close();
            } catch (SQLException e) {}
            if ( pstmt != null ) try {
                pstmt.close();
            } catch (SQLException e) {}
            if ( conn != null ) try {
                conn.close();
            } catch (SQLException e) {}

        }

    }

    /**
     * @param empno
     * @return 組員艙別,Y前艙,N後艙
     */
    public String getCabin(String empno) {
        int idx = 0;
        String cabin = "";
        idx = empnoAL.indexOf(empno);
        if ( idx != -1 ) {
            cabin = (String) cabinAL.get(idx);
        }

        return cabin;
    }

    /**
     * @param empno
     * @return 中文姓名(已轉碼)
     */
    public String getCname(String empno) {
        int idx = 0;
        String cname = "";
        idx = empnoAL.indexOf(empno);
        if ( idx != -1 ) {
            cname = (String) cnameAL.get(idx);
        }
        try {
            cname = new String(UnicodeStringParser.removeExtraEscape(cname)
                    .getBytes(), "Big5");
        } catch (UnsupportedEncodingException e) {
            System.out.println(e.toString());
        } catch (Exception e) {
            System.out.println(e.toString());
        }

        return cname;
    }

    /**
     * @param empno
     * @return 組別
     */
    public String getGrp(String empno) {
        int idx = 0;
        String grp = "";
        idx = empnoAL.indexOf(empno);
        if ( idx != -1 ) {
            grp = (String) grpAL.get(idx);
        }
        return grp;

    }

    /**
     * @param empno
     * @return rank
     */
    public String getRank(String empno) {
        int idx = 0;
        String rank = "";
        idx = empnoAL.indexOf(empno);
        if ( idx != -1 ) {
            rank = (String) rankAL.get(idx);
        }
        return rank;
    }

    /**
     * @param empno
     * @return 序號
     */
    public String getSern(String empno) {
        int idx = 0;
        String sern = "";
        idx = empnoAL.indexOf(empno);
        if ( idx != -1 ) {
            sern = (String) sernAL.get(idx);
        }
        return sern;
    }
}
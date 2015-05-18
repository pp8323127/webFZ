package fz.pracP;

import java.sql.*;

import ci.db.*;

/**
 * DeleteBordingOnTime 刪除登機準時資料(DB:ORT1)
 * 
 * @author cs66
 * @version 1.0 2006/2/15
 * 
 * Copyright: Copyright (c) 2006
 */
public class DeleteBordingOnTime {

    public static void main(String[] args) {
        DeleteBordingOnTime d = new DeleteBordingOnTime("2006/02/15", "006",
                "TPELAX", "629698");
        d.DeleteData();
        System.out.println(d.isDelSuccess());
    }

    private String fdate;//yyyy/mm/dd
    private String fltno;
    private String sect;
    private String purEmpno;
    private boolean delSuccess = false;

    public DeleteBordingOnTime(String fdate, String fltno, String sect,
            String purEmpno) {
        this.fdate = fdate;
        this.fltno = fltno;
        this.sect = sect;
        this.purEmpno = purEmpno;
    }

    public void DeleteData() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        int resultCount = 0;
        String sql = null;
        ConnDB cn = new ConnDB();
        Driver dbDriver = null;

        try {
            //        User connection pool to
                    cn.setORP3EGUserCP();
                    dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
                    conn = dbDriver.connect(cn.getConnURL(), null);

            //        直接連線 ORP3FZ
//            cn.setORT1EG();
//            java.lang.Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() ,
//                    cn.getConnPW());
                    
            conn.setAutoCommit(false);
            sql = "DELETE egtcflt WHERE fltd = To_Date('" + fdate
                    + " 0000','yyyy/mm/dd hh24mi') "
                    + "AND fltno=?  AND sect=?  AND psrempn=? ";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1 ,fltno);
            pstmt.setString(2 ,sect);
            pstmt.setString(3 ,purEmpno);
            int result = 0;
            result = pstmt.executeUpdate();

            if ( result == 1 ) {
                setDelSuccess(true);
            }

        } catch (SQLException e) {
            try {
                conn.rollback();
            } catch (SQLException e1) {
                System.out.print(e1.toString());
            }
            System.out.print(e.toString());
        } catch (Exception e) {
            System.out.print(e.toString());
            try {
                conn.rollback();
            } catch (SQLException e1) {
                System.out.print(e1.toString());
            }
        } finally {

            if ( pstmt != null ) try {
                pstmt.close();
            } catch (SQLException e) {}
            if ( conn != null ) try {
                conn.close();
            } catch (SQLException e) {}

        }
    }

    public boolean isDelSuccess() {
        return delSuccess;
    }

    public void setDelSuccess(boolean delSuccess) {
        this.delSuccess = delSuccess;
    }
}
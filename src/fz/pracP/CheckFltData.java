package fz.pracP;

import java.sql.*;
import ci.db.*;

/**
 * CheckFltData �ˬd�y�������i�O�_�w��Jflt���
 * 
 * @author cs66
 * @version 1.0 2006/2/20
 * 
 * Copyright: Copyright (c) 2006
 */
public class CheckFltData {

//    public static void main(String[] args) {
//        CheckFltData cflt = new CheckFltData("2006/03/16", "0006", "TPELAX",
//                "624344");
//        try {
//            cflt.RetrieveData();
//            System.out.println("�O�_��flight ��ơG" + cflt.isHasFltData());
//            if ( cflt.isHasFltData() ) {
//                System.out.println("�O�_��Crew��ơG" + cflt.isHasFltCrewData());
//                System.out.println("�O�_���n���Ǯɸ�ơG" + cflt.isHasBdotData());
//                System.out.println("�O�_�i��s���i:" + cflt.isUpd());
//            }
//        } catch (SQLException e) {
//            System.out.println(e.toString());
//        } catch (Exception e) {
//            System.out.println(e.toString());
//        }
//    }

    private String stdDt; // format: yyyy/mm/dd
    private String fltno;
    private String sector;
    private String psrEmpno;
    private boolean hasFltData = false; //�O�_�w���ӵ�flight���
    private boolean hasFltCrewData = false;//�O�_���խ��W��
    private boolean hasBdotData = false; //�O�_���n���ɶ�
    private boolean isUpd = false;

    /**
     * @param stdDt flight date,format: yyyy/mm/dd
     * @param fltno flight number
     * @param sector
     * @param psrEmpno employ number of purser
     */
    public CheckFltData(String stdDt, String fltno, String sector,
            String psrEmpno) {
        this.stdDt = stdDt;
        this.fltno = fltno;
        this.sector = sector;
        this.psrEmpno = psrEmpno;
    }

    public void RetrieveData() throws SQLException, Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        ConnDB cn = new ConnDB();
        Driver dbDriver = null;

        try {

            cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL() ,null);

//            cn.setORT1EG();
//            java.lang.Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() ,
//                    cn.getConnPW());

            pstmt = conn
                    .prepareStatement("select nvl(empn1,'N') empn,Nvl(bdot,'N') bdot,Nvl(upd,'-') upd "
                            + "FROM  egtcflt WHERE fltd= "
                            + "To_Date('"
                            + stdDt
                            + " 0000','yyyy/mm/dd hh24mi') "
                            + "AND lpad(fltno,4,'0')=lpad(?,4,'0') "
                            + "AND sect=Upper(?) AND psrempn=?");

            pstmt.setString(1 ,fltno);
            pstmt.setString(2 ,sector);
            pstmt.setString(3 ,psrEmpno);
            rs = pstmt.executeQuery();
            while (rs.next()) 
            {
                setHasFltData(true);
                if ( hasFltData ) 
                {
                    if ( !"N".equals(rs.getString("empn")) ) {
                        setHasFltCrewData(true);
                    }
                    if ( "Y".equals(rs.getString("bdot")) ) {
                        setHasBdotData(true);
                    }
                    if ( "Y".equals(rs.getString("upd")) | "-".equals(rs.getString("upd"))) 
                    {
                        setUpd(true);
                    }
                }
            }

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

    public boolean isHasBdotData() {
        return hasBdotData;
    }

    private void setHasBdotData(boolean hasBdotData) {
        this.hasBdotData = hasBdotData;
    }

    public boolean isHasFltCrewData() {
        return hasFltCrewData;
    }

    private void setHasFltCrewData(boolean hasFltCrewData) {
        this.hasFltCrewData = hasFltCrewData;
    }

    public boolean isHasFltData() {
        return hasFltData;
    }

    private void setHasFltData(boolean hasFltData) {
        this.hasFltData = hasFltData;
    }

    public boolean isUpd() {
        return isUpd;
    }

    private void setUpd(boolean isUpd) {
        this.isUpd = isUpd;
    }
}
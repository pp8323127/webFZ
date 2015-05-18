package fz.pracP;

import java.sql.*;

import ci.db.*;

/**
 * BordingOnTime �ˬd�O�_���n���Ǯ����è��o��� <br>
 * AirCrews�Z����
 * 
 * 
 * @author cs66
 * @version 1.0 2006/2/11
 * 
 * Copyright: Copyright (c) 2006
 */
public class BordingOnTime {

//        public static void main(String[] args) {
//            BordingOnTime bot = new BordingOnTime("2006/03/03", "0012", "ANCJFK",
//                    "628928");
//            try {
//                bot.SelectData();
//    
//            } catch (SQLException e) {
//    
//                e.printStackTrace();
//            } catch (Exception e) {
//    
//                e.printStackTrace();
//            }
//            System.out.println("�O�_��flight��ơG" + bot.isHasFlightInfo());
//            System.out.println("�O�_���n����ơG" + bot.isHasBdotInfo());
//    
//            if ( !bot.isHasFlightInfo()
//                    | (bot.isHasFlightInfo() && !bot.isHasBdotInfo() ) ) {
//                //�w�]��,1.�Lflt���, or 2��flt��Ʀ��L�n���Ǯɸ��
//                System.out.println("�L���,��ܹw�]��");
//            } else {
//                System.out.println(bot.getBdot() + "\t" + bot.getBdReason());
//    
//            }
//        }

    private String fdate;//yyyy/mm/dd
    private String fltno;
    private String sect;
    private String purEmpno;
    private String bdot;
    private String bdtmYear;
    private String bdtmMonth;
    private String bdtmDay;
    private String bdtmHM;
    private String bdReason;
    private boolean hasFlightInfo = false;//�O�_�w��flihgt���
    private boolean hasBdotInfo = false;//�O�_�w���n���Ǯɸ��

    public BordingOnTime(String fdate, String fltno, String sect,
            String purEmpno) {
        this.fdate = fdate;
        this.fltno = fltno;
        this.sect = sect;
        this.purEmpno = purEmpno;

    }

    public void SelectData() throws SQLException, Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        ConnDB cn = new ConnDB();

        Driver dbDriver = null;

        try {
            //        User connection pool 
                        cn.setORP3EGUserCP();
                        dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
                        conn = dbDriver.connect(cn.getConnURL() ,null);

            // �����s�u ORP3FZ cn.setORT1EG();
            //            cn.setORP3EGUser();
			// cn.setORT1EG();
			// java.lang.Class.forName(cn.getDriver());
			// conn = DriverManager.getConnection(cn.getConnURL()
			// ,cn.getConnID() ,
			// cn.getConnPW());

            sql = "SELECT fltd,psrempn,bdot,To_Char(bdtime,'yyyy') bdtmYear,  To_Char(bdtime,'mm') bdtmMonth,"
                    + "To_Char(bdtime,'dd') bdtmDay,To_Char(bdtime,'hh24mi') bdtmHM,"
                    + " bdreason FROM egtcflt "
                    + "WHERE fltd= To_Date('"
                    + fdate
                    + " 0000','yyyy/mm/dd hh24mi') "
                    + "AND fltno=? AND sect=? and psrempn=?";

            pstmt = conn.prepareStatement(sql ,
                    ResultSet.TYPE_SCROLL_INSENSITIVE ,
                    ResultSet.CONCUR_READ_ONLY);

            pstmt.setString(1 ,fltno);
            pstmt.setString(2 ,sect);
            pstmt.setString(3 ,purEmpno);

            rs = pstmt.executeQuery();
            int count = 0;
            rs.last();
            count = rs.getRow();
            rs.beforeFirst();

            if ( count > 0 ) {//���Z�����

                setHasFlightInfo(true);
                while (rs.next()) {

                    //                      �L�Ǯɸ��,�w�]�n���ɶ���fdate
                    if ( null == rs.getString("bdot") ) {
                        setBdtmYear(fdate.substring(0 ,4));
                        setBdtmMonth(fdate.substring(5 ,7));
                        setBdtmDay(fdate.substring(8));
                        setBdot("Y");
                    } else {
                        setHasBdotInfo(true);
                        setBdtmYear(rs.getString("bdtmYear"));
                        setBdtmMonth(rs.getString("bdtmMonth"));
                        setBdtmDay(rs.getString("bdtmDay"));
                        setBdtmHM(rs.getString("bdtmHM"));
                        setBdot(rs.getString("bdot"));
                        setBdReason(rs.getString("bdreason"));

                    }
                    //                  } else if ( "Y".equals(rs.getString("bdot")) ) {
                    //                  setBdtmYear(rs.getString("bdtmYear"));
                    //                  setBdtmMonth(rs.getString("bdtmMonth"));
                    //                  setBdtmDay(rs.getString("bdtmDay"));
                    //                  setBdtmHM(rs.getString("bdtmHM"));
                    //                  setBdot(rs.getString("bdot"));
                    //                  setHasBdotInfo(true);
                    //              } else {
                    //                  setHasBdotInfo(true);
                    //                  setBdot(rs.getString("bdot"));
                    //                  setBdtmYear(rs.getString("bdtmYear"));
                    //                  setBdtmMonth(rs.getString("bdtmMonth"));
                    //                  setBdtmDay(rs.getString("bdtmDay"));
                    //                  setBdtmHM(rs.getString("bdtmHM"));
                    //                  setBdReason(rs.getString("bdreason"));
                    //                  setHasBdotInfo(true);
                    //              }

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

    public String getBdot() {
        return bdot;
    }

    public void setBdot(String bdot) {
        this.bdot = bdot;
    }

    public String getBdReason() {
        return bdReason;
    }

    public void setBdReason(String bdReason) {
        this.bdReason = bdReason;
    }

    public String getBdtmDay() {
        return bdtmDay;
    }

    public void setBdtmDay(String bdtmDay) {
        this.bdtmDay = bdtmDay;
    }

    public String getBdtmHM() {
        return bdtmHM;
    }

    public void setBdtmHM(String bdtmHM) {
        this.bdtmHM = bdtmHM;
    }

    public String getBdtmMonth() {
        return bdtmMonth;
    }

    public void setBdtmMonth(String bdtmMonth) {
        this.bdtmMonth = bdtmMonth;
    }

    public String getBdtmYear() {
        return bdtmYear;
    }

    public void setBdtmYear(String bdtmYear) {
        this.bdtmYear = bdtmYear;
    }

    public boolean isHasBdotInfo() {
        return hasBdotInfo;
    }

    public void setHasBdotInfo(boolean hasBotInfo) {
        this.hasBdotInfo = hasBotInfo;
    }

    public boolean isHasFlightInfo() {
        return hasFlightInfo;
    }

    public void setHasFlightInfo(boolean hasFlightInfo) {
        this.hasFlightInfo = hasFlightInfo;
    }
}
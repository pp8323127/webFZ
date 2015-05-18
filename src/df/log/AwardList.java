package df.log;

import java.io.*;
import java.sql.*;
import java.util.*;
import javax.naming.*;
import ci.db.*;
import ci.tool.*;

/**
 * AwardList
 * 
 * @author cs66
 * @version 1.0 2005/10/27
 * 
 * Copyright: Copyright (c) 2005
 */
public class AwardList {

    private ArrayList dataAL;
    private boolean hasData;
    private boolean sendStatus;
    private String content;

    //    public static void main(String[] args) {
    //        AwardList a = new AwardList("2005", "09", "594048");
    //        a.setLogFile("C:\\aa.txt");
    //        a.SendLogList("C:\\");
    //        
    //        
    //    }

    private String empno;
    private String year;
    private String month;
    private String logFile;

    public AwardList(String year, String month, String empno) {
        this.year = year;
        this.month = month;
        this.empno = empno;
    }

    public void selectData() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ConnectDataSource cn = new ConnectDataSource();
        try {
            conn = cn.getDFConnection();
            pstmt = conn
                    .prepareStatement("SELECT To_Char(transdt,'yyyy.mm.dd hh24:mi') transdt,"
                            + "employid,awrdid,awrdcd,basert,apdesc,remarks FROM hrvegawrdoc "
                            + "WHERE To_Char(transdt,'yyyymm')=? AND awrdcd='D3' AND "
                            + "employid=? ORDER BY transdt");
            pstmt.setString(1 ,year + month);
            pstmt.setString(2 ,empno);

            rs = pstmt.executeQuery();
            dataAL = new ArrayList();
            while (rs.next()) {
                AwardListObj obj = new AwardListObj();
                obj.setTransdt(rs.getString("transdt"));
                obj.setEmpno(rs.getString("employid"));
                obj.setAwardid(rs.getString("awrdid"));
                obj.setAwardcd(rs.getString("awrdcd"));
                obj.setBasert(rs.getString("basert"));
                obj.setApdesc(rs.getString("apdesc"));
                obj.setRemarks(rs.getString("remarks"));

                dataAL.add(obj);

            }
            if ( dataAL.size() == 0 ) {
                setHasData(false);
            } else {
                setHasData(true);
            }

        } catch (SQLException e) {
            System.out.println(e.toString());
        } catch (ClassNotFoundException e) {
            System.out.println(e.toString());
        } catch (NamingException e) {
            System.out.println(e.toString());
        } finally {
            if ( conn != null ) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    System.out.println(e.toString());
                }
                conn = null;
            }
        }
    }

    private void setContent() {
        content = null;
        StringBuffer sb = new StringBuffer();
        if ( dataAL == null ) {
            selectData();
        }
        sb.append("<HTML>");
        sb.append("<HEAD>");
        sb.append("<TITLE> " + year + "/" + month + " Personal Log List ");
        sb.append("</TITLE>");
        sb
                .append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=big5\">");
        sb.append("<style type=\"text/css\">");
        sb
                .append("body{font-family:DotumChe;font-family:DotumChe;} .l{text-align:right;}");
        sb.append("td{text-align:center;}");
        sb.append("th{background-color:#C0C0C0;}");

        sb.append("</style>");
        sb.append("</HEAD>");
        sb.append("<BODY>");

        sb.append(year + "/" + month);
        sb.append(" Personal Award  List <p>");
        sb
                .append("<table border=\"1\" cellspacing=\"0\" cellpadding=\"1\" width=\"80%\">");
        sb.append("<tr>");
        sb.append("<th>Date</th>");
        sb.append("<th>Emp.No</th>");
        sb.append("<th>AWRDID</th>");
        sb.append("<th>AWRDCD</th>");
        sb.append("<th>BASERT</th>");
        sb.append("<th>APDESC</th>");
        sb.append("<th>REMARKS</th>");

        sb.append("</tr>");

        for ( int i = 0; i < dataAL.size(); i++) {
            AwardListObj obj = (AwardListObj) dataAL.get(i);
            sb.append("<tr>");
            sb.append("<td>" + obj.getTransdt() + "</td>");
            sb.append("<td>" + obj.getEmpno() + "</td>");
            sb.append("<td>" + obj.getAwardid() + "</td>");
            sb.append("<td>" + obj.getAwardcd() + "</td>");
            sb.append("<td class=\"l\">" + obj.getBasert() + "</td>");
            sb.append("<td>" + obj.getApdesc() + "</td>");
            sb.append("<td>&nbsp;" + obj.getRemarks() + "</td>");
            sb.append("</tr>");
        }
        sb.append("</table>");
        sb.append("</BODY>");
        sb.append("</HTML>");
        content = sb.toString();
    }

    public void SendLogList(String attachFilePath) {
        String attachFile = attachFilePath + empno + year + month + ".htm";
        FileWriter fw = null;
        sendStatus = false;
        try {
            fw = new FileWriter(attachFile, false);
        } catch (IOException e) {}

        if ( dataAL == null ) {
            selectData();
        }

        if ( hasData ) {
            DeliverMail dm = new DeliverMail();
            WriteLog wl = null;

            try {

                fw.write(getContent());
                fw.close();
                //                dm.Deliver(year + "/" + month + " Personal Log List" ,sObj
                //                        .getEmpno() ,getLogListContent());
                //                dm.Deliver(year + "/" + month + " Personal Log List" ,
                //                        "tpecsci" ,getContent());
                dm.DeliverMailWithAttach(year + "/" + month
                                        + " Personal AwardLog List" ,empno ,
//                        + " Personal AwardLog List" ,"tpecsci" ,
                        "Please open the attach File." ,attachFile ,year
                                + month + ".htm");

                if ( logFile != null ) {
                    wl = new WriteLog(logFile);
                }

                setSendStatus(true);
                wl.WriteFileWithTime(empno + "\t" + year + "/" + month);

            } catch (Exception e) {
                if ( logFile != null ) {
                    wl = new WriteLog(logFile);
                    wl.WriteFileWithTime("error: " + empno + "\t" + year + "/"
                            + month);
                }

            } finally {
                if ( fw != null ) {
                    try {
                        fw.close();
                    } catch (IOException e1) {}
                }
                File afile = new File(attachFile);
                afile.delete();

            }
        }

    }

    public String getContent() {
        if ( content == null ) setContent();

        return content;
    }

    public boolean isHasData() {
        return hasData;
    }

    private void setHasData(boolean hasData) {
        this.hasData = hasData;
    }

    /**
     * @param logFile log檔之絕對路徑與檔名
     */
    public void setLogFile(String logFile) {
        this.logFile = logFile;
    }

    /**
     * @return 寄送狀態, true為成功,false為失敗
     */
    public boolean isSendStatus() {
        return sendStatus;
    }

    private void setSendStatus(boolean sendStatus) {
        this.sendStatus = sendStatus;
    }
}
package df.log;

import java.io.*;
import java.sql.*;
import java.util.*;
import ci.db.*;
import ci.tool.*;

/**
 * SingleCrewLogList 組員索取個人飛航記錄,寄至全員信箱
 * 
 * @author cs66
 * @version 1.2 2004/12/30 modify slelect condition nu cs66 <br>
 *              add jobid <>' ' -- abnormal log <br>
 *              add jobid <>'E' -- extra crew <br>
 *              add jobid <>'G' -- sick crew <br>
 * 
 * @version 1.3 2005/02/02 modify jobid='M',flyhr = flyhr/2
 * @version 2 2005/10/26 改寫,採用附加htm檔之方式寄送信件
 * @version 3 2012/12/22 cs57 modify,以"SingleCrewLogList.java.To宏哥"檔案修改而來，
 *			  需求單SR1110,班表資訊網之'飛航時間'以TPE顯示：將dftlogf改為dfvlogf_tpe.
 */
public class SingleCrewLogList {
    //    public static void main(String[] args) {
    //        SingleCrewLogList s = new SingleCrewLogList("2005", "07", "636750");
    //// s.SelectData();
    //        System.out.println(s.getContent());
    //// s.setLogFile("C:\\22.txt");
    //        System.out.println("寄送是否成功:\t" + s.SendLogList("C:\\"));
    //    }

    private String year;
    private String month;
    private String empno;
    private SingleCrewLogObj sObj;
    private String content;
    private boolean hasData = false;//是否有資料
    private String logFile;

    public SingleCrewLogList(String year, String month, String empno) {
        this.year = year;
        this.month = month;
        this.empno = empno;
    }

    public void SelectData() 
    {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ConnectDataSource cn = new ConnectDataSource();
        try {

            conn = cn.getDFConnection(); 

            pstmt = conn
                    .prepareStatement("select crew.NAME cname,crew.ename ename,"
                            + "YEAR||'/'||mon||'/'||dd fdate,fltno,nvl(acno,'0') acno,"
                            + "dpt,arv,blkout,takeoff,landing,blkin, "
                            + "nvl(round((blk/60),4),'0') blkhr,"
                            + "nvl(round((fly/60),4),'0') flyhr,"
                            + "nvl(round(((fly/60)/2),4),'0') flyhr2,"
                            + "nvl(duty,'0') duty, nvl(jobid,'0') jobid "
                            + "from dfvlogf_tpe f , dftlogc c,dftcrew crew "
                            + "where f.logno=c.logno AND c.empno = crew.empno "
                            + "and c.jobid NOT IN(' ','E','G')  and c.empno=? and year=? "
                            + "and mon=? and trim(f.flag)='3' ORDER BY dd,blkout");
            pstmt.setString(1 ,empno);
            pstmt.setString(2 ,year);
            pstmt.setString(3 ,month);

            rs = pstmt.executeQuery();

            sObj = new SingleCrewLogObj();
            ArrayList dataAL = new ArrayList();
            sObj.setEmpno(empno);
            sObj.setWorkingYear(year);
            sObj.setWorkingMonth(month);
            String cname = null;
            String ename = null;

            while (rs.next()) {
                sObj.setCname(rs.getString("cname"));
                sObj.setEname(rs.getString("ename"));

                LogListObj lobj = new LogListObj();

                lobj.setFdate(rs.getString("fdate"));
                lobj.setFltno(rs.getString("fltno"));
                lobj.setAcno(rs.getString("acno"));
                lobj.setDpt(rs.getString("dpt"));
                lobj.setArv(rs.getString("arv"));
                lobj.setBlkout(rs.getString("blkout"));
                lobj.setTakeoff(rs.getString("takeoff"));
                lobj.setLanding(rs.getString("landing"));
                lobj.setBlkin(rs.getString("blkin"));
                lobj.setBlkhr(rs.getString("blkhr"));
                lobj.setFlyhr(rs.getString("flyhr"));
                lobj.setFlyhr2(rs.getString("flyhr2"));
                lobj.setDuty(rs.getString("duty"));
                lobj.setJobid(rs.getString("jobid"));
                System.out.println(rs.getString("blkhr"));
                //              cs66 modify at 2004/11/10 DA(jobid)為G者，blkhr與flyhr為0
                if ( "G".equals(rs.getString("jobid")) ) {
                    lobj.setBlkhr("0");
                    lobj.setFlyhr("0");
                    //    				blkhr="0";
                    //    				flyhr="0";
                } //cs66 modify at 2005/02/02 jobid='M'者，flyhr = flyhr/2
                else if ( "M".equals(rs.getString("jobid")) ) {
                    lobj.setFlyhr(rs.getString("flyhr2"));
                    //flyhr = flyhr2;
                }

                dataAL.add(lobj);
            }

            if ( dataAL.size() == 0 ) {
                setHasData(false);
            } else {
                setHasData(true);
            }

            sObj.setDataAL(dataAL);

            pstmt = conn
                    .prepareStatement("SELECT  round( (sum(blk) / 60), 4) sumblk,"
                            + "round( (Sum(Decode(jobid, 'M', fly / 2, fly)) / 60), 4) sumfly "
                            + "from dftlogf_tpe f , dftlogc c "
                            + "where f.logno=c.logno and jobid NOT IN(' ','E','G') "
                            + "and c.empno=? and year=? and mon=? and f.flag='3'");

            pstmt.setString(1 ,empno);
            pstmt.setString(2 ,year);
            pstmt.setString(3 ,month);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                sObj.setSumBlk(rs.getString("sumblk"));
                sObj.setSumFly(rs.getString("sumfly"));
            }

            setContent();
        } catch (SQLException e) {
            System.out.print(e.toString());
        } catch (Exception e) {
            System.out.print(e.toString());
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

    private void setContent() {
        content = null;
        StringBuffer sb = new StringBuffer();
        if ( sObj == null ) {
            SelectData();
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
        sb.append("th{background-color:#C0C0C0;}");
        sb.append("</style>");
        sb.append("</HEAD>");
        sb.append("<BODY>");

        sb.append(sObj.getWorkingYear() + "/" + sObj.getWorkingMonth());
        sb.append(" Personal Log List <p>");
        sb.append("Emp.No. : " + sObj.getEmpno());
        sb.append("&nbsp;&nbsp;Name : " + sObj.getCname());
        sb.append("&nbsp;" + sObj.getEname() + "<p><p>");
        sb.append("Working Month<br>" + sObj.getWorkingYear());
        sb.append(sObj.getWorkingMonth() + "<p><p>");
        sb
                .append("<table border=\"1\" cellspacing=\"0\" cellpadding=\"1\" width=\"100%\">");
        sb.append("<tr>");
        sb.append("<th>Flight<br>Date</th>");
        sb.append("<th>Flt</th>");
        sb.append("<th>DPT</th>");
        sb.append("<th>ARV</th>");
        sb.append("<th>Out</th>");
        sb.append("<th>Off</th>");
        sb.append("<th>On</th>");
        sb.append("<th>In</th>");
        sb.append("<th>Block<br>Hours</th>");
        sb.append("<th>Fly<br>Hours</th>");
        sb.append("<th>Duty</th>");
        sb.append("<th>DA</th>");
        sb.append("<th>AC/ NO</th>");

        sb.append("</tr>");
        ArrayList al = sObj.getDataAL();
        for ( int i = 0; i < al.size(); i++) {
            LogListObj lobj = (LogListObj) al.get(i);
            sb.append("<tr>");
            sb.append("<td>" + lobj.getFdate() + "</td>");
            sb.append("<td>" + lobj.getFltno() + "</td>");
            sb.append("<td>" + lobj.getDpt() + "</td>");
            sb.append("<td>" + lobj.getArv() + "</td>");
            sb.append("<td>" + lobj.getBlkout() + "</td>");
            sb.append("<td>" + lobj.getTakeoff() + "</td>");
            sb.append("<td>" + lobj.getLanding() + "</td>");
            sb.append("<td>" + lobj.getBlkin() + "</td>");
            sb.append("<td class=\"l\">" + lobj.getBlkhr() + "</td>");
            sb.append("<td class=\"l\">" + lobj.getFlyhr() + "</td>");
            sb.append("<td>" + lobj.getDuty() + "</td>");
            sb.append("<td>" + lobj.getJobid() + "</td>");
            sb.append("<td>" + lobj.getAcno() + "</td>");
            sb.append("</tr>");

        }
        sb.append("</table>");
        sb.append("<p>Summary <br>");
        sb.append("Fly_Hours=" + sObj.getSumFly());
        sb.append("&nbsp;&nbsp;&nbsp;Block_Hours=" + sObj.getSumBlk());
        sb.append("</BODY>");
        sb.append("</HTML>");
        content = sb.toString();
    }

    public String getContent() {
        if ( content == null ) setContent();

        return content;
    }

    public boolean SendLogList(String attachFilePath) {
        String attachFile = attachFilePath + empno + year + month + ".htm";
        FileWriter fw = null;

        try {
            fw = new FileWriter(attachFile, false);
        } catch (IOException e) {}
        boolean sendStatus = false;
        if ( sObj == null ) {
            SelectData();
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
                        + " Personal Log List" ,sObj.getEmpno() ,
                        "Please open the attach File." ,attachFile ,year
                                + month + ".htm");

                if ( logFile != null ) {
                    wl = new WriteLog(logFile);
                }

                sendStatus = true;
                wl.WriteFileWithTime(sObj.getEmpno() + "\t" + sObj.getCname()
                        + "\t" + year + "/" + month);

            } catch (Exception e) {
                if ( logFile != null ) {
                    wl = new WriteLog(logFile);
                    wl.WriteFileWithTime("error: " + sObj.getEmpno() + "\t"
                            + year + "/" + month);
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
        return sendStatus;
    }

    /**
     * @param logFile log檔之絕對路徑與檔名
     */
    public void setLogFile(String logFile) {
        this.logFile = logFile;
    }

    public boolean isHasData() {
        return hasData;
    }

    private void setHasData(boolean hasData) {
        this.hasData = hasData;
    }
}
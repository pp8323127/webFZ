package ws.prac.ftp;

import java.sql.*;
import java.util.*;

import ws.prac.*;
import ci.db.*;

public class AppFile
{

    /**
     * @param args
     * PR(CM) file位置
     * ZC(PR) file位置
     */

    public FtpFileRObj ftpObj = null;
    public FtpFileRObj zcFtpObj = null;
//    String live = "http://cabincrew.china-airlines.com/prpt/";
    String test = "http://cabincrew.china-airlines.com/prptt/";
    String url = test ;
    //PR(CM) file位置
    public void getFile(String fdate,String fltno ,String sect){//yyyy/mm/dd
        Driver dbDriver = null;
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        String sql = null;
        String a ="";
        ftpObj = new FtpFileRObj();
        ArrayList dataAL = new ArrayList();
        String ftpFileName = ""; 
        FtpDownLoad ftp = new FtpDownLoad();
        try{
            ConnDB cn = new ConnDB();
            cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            stmt = conn.createStatement();
//            ConnectionHelper ch = new ConnectionHelper();
//            conn = ch.getConnection();
//            stmt = conn.createStatement();            
            
            sql = "select f.fltd,f.fltno,f.sect,f.filename,f.app_filename,f.filedsc,f.upduser,to_char(f.upddate,'yyyy/mm/dd hh24:mi:ss') upddate from egtfile f" +
                        " where fltd=to_date('"+fdate+"','yyyy/mm/dd') and fltno='"+fltno+"' and sect='"+sect+"' and f.app_filename is not null";
            rs = stmt.executeQuery(sql);
            if(rs != null){
                while(rs.next()){
                    FtpFileObj obj = new FtpFileObj();
                    obj.setFilename(rs.getString("app_filename"));
                    obj.setFiledsc(rs.getString("filedsc"));
                    obj.setUpduser(rs.getString("upduser"));
                    obj.setUpddate(rs.getString("upddate"));   
//                    ftpFileName += rs.getString("filename")+"/";
                    obj.setUrl(url+rs.getString("filename"));
                    dataAL.add(obj);
                }                
                
                if(dataAL.size()>0){
                    FtpFileObj[] array = new FtpFileObj[dataAL.size()];
                    for (int i = 0; i < dataAL.size(); i++) {
                        array[i] = (FtpFileObj) dataAL.get(i);
                    }
                    ftpObj.setFileObj(array);
                    //zip byte change
//                    String zipName = fdate.replace("/", "")+sect+fltno;
////                    System.out.println(zipName);
//                    ftp.getFtpFileByte(ftpFileName , zipName);
//                    ftpObj.setZipFile(ftp.getFtp());
////                    for(int i=0; i<ftp.getFtp().length; i++)
////                    {
////                        System.out.print(ftp.getFtp()[i]);            
////                    }
                    ftpObj.setResultMsg("1");
                }else{
                    ftpObj.setResultMsg("1");
                    ftpObj.setErrorMsg("No data");
                }
            }else{
                ftpObj.setResultMsg("1");
                ftpObj.setErrorMsg("No data");
            }       
            
        } catch (Exception e) {
            ftpObj.setResultMsg("0");
            ftpObj.setErrorMsg(e.toString());
//          System.out.println(e.toString());
        } finally {
            try {
                if (rs != null)
                    rs.close();
            } catch (SQLException e) {
            }
            try {
                if (stmt != null)
                    stmt.close();
            } catch (SQLException e) {
            }
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
            }
        }
    }
//    ZC(PR) file位置
    public void getZcFile(String fdate,String fltno ,String sect){//yyyy/mm/dd
        Driver dbDriver = null;
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        String sql = null;
        String a ="";
        zcFtpObj = new FtpFileRObj();
        ArrayList dataAL = new ArrayList();
        String ftpFileName = ""; 
        FtpDownLoad ftp = new FtpDownLoad();
        try{
            ConnDB cn = new ConnDB();
            cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            stmt = conn.createStatement();
//            ConnectionHelper ch = new ConnectionHelper();
//            conn = ch.getConnection();
//            stmt = conn.createStatement();            
            
            sql = "select f.fltd,f.fltno,f.sect,f.filename,f.app_filename,f.filedsc,f.upduser,to_char(f.upddate,'yyyy/mm/dd hh24:mi:ss') upddate from egtzcfile f" +
                        " where fltd=to_date('"+fdate+"','yyyy/mm/dd') and fltno='"+fltno+"' and sect='"+sect+"' and f.app_filename is not null";
            rs = stmt.executeQuery(sql);
            if(rs != null){
                while(rs.next()){
                    FtpFileObj obj = new FtpFileObj();
                    obj.setFilename(rs.getString("app_filename"));
                    obj.setFiledsc(rs.getString("filedsc"));
                    obj.setUpduser(rs.getString("upduser"));
                    obj.setUpddate(rs.getString("upddate"));   
//                    ftpFileName += rs.getString("filename")+"/";
                    obj.setUrl(url+"PR/"+rs.getString("filename"));
                    dataAL.add(obj);
                }                
                
                if(dataAL.size()>0){
                    FtpFileObj[] array = new FtpFileObj[dataAL.size()];
                    for (int i = 0; i < dataAL.size(); i++) {
                        array[i] = (FtpFileObj) dataAL.get(i);
                    }
                    zcFtpObj.setFileObj(array);
                    //zip byte change
//                    String zipName = fdate.replace("/", "")+sect+fltno;
////                    System.out.println(zipName);
//                    ftp.getFtpFileByte(ftpFileName , zipName);
//                    ftpObj.setZipFile(ftp.getFtp());
////                    for(int i=0; i<ftp.getFtp().length; i++)
////                    {
////                        System.out.print(ftp.getFtp()[i]);            
////                    }
                    zcFtpObj.setResultMsg("1");
                }else{
                    zcFtpObj.setResultMsg("1");
                    zcFtpObj.setErrorMsg("No data");
                }
            }else{
                zcFtpObj.setResultMsg("1");
                zcFtpObj.setErrorMsg("No data");
            }       
            
        } catch (Exception e) {
            zcFtpObj.setResultMsg("0");
            zcFtpObj.setErrorMsg(e.toString());
//          System.out.println(e.toString());
        } finally {
            try {
                if (rs != null)
                    rs.close();
            } catch (SQLException e) {
            }
            try {
                if (stmt != null)
                    stmt.close();
            } catch (SQLException e) {
            }
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
            }
        }
    }
    
}

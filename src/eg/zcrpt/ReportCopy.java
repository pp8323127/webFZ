package eg.zcrpt;

import java.io.File;
import java.io.FileOutputStream;

import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.Driver;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.ibm.db2.jcc.a.c;
import com.ibm.db2.jcc.a.e;

import ci.db.ConnDB;
import ci.db.ConnectionHelper;
import ftp.FtpUtility;
import ftp.updFilePath;

public class ReportCopy {

    /**
     * @param args
     */
    ArrayList  irrObjAL = new ArrayList();
    ArrayList  fileObjAL = new ArrayList();
    private String errorstr = "Y";
    private String sql = "";      
    
    public static void main(String[] args) {
        // TODO Auto-generated method stub
      String fltd = "2014/03/06";
      String fltno = "0752";
      String sect = "SUBSIN";
      String acno = "111221";
      String purserEmpno = "654321";
      String psrname = "ZZZ";
      String psrsern = "54321";
////      String[] itemno = {"258","852"};
////      String[] com = {"258","852"};
////      String[] dsc = {"987","789"};
////      String[] flag = {"1","1"};
      String[] filename = {"201400003.jpg"};
      String[] filedsc = {"XXX"};
        ReportCopy co = new ReportCopy();
        co.copyFileToCM(fltd, fltno, sect, purserEmpno, psrname, psrsern, filename, filedsc);
    }
    //get ZC report 
    public void getZCFltIrr( String fltd, String fltno, String sect)
    {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        irrObjAL.clear();
       
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
           
            sql = " select m.*, f.*, pi.itemdsc itemnodsc  from egtzccmdt m, egtzcflt f, egtcmpi pi where f.seqno = m.seqno   and m.itemno = pi.itemno" +
                  " and fltd = to_date('"+fltd+"','yyyy/mm/dd') and fltno='"+fltno+"' and sect='"+sect+"' " ;      
            
//            System.out.prin+tln(sql);
            rs = stmt.executeQuery(sql);

            while (rs.next())
            {
                ReportCopyObj obj = new ReportCopyObj();
                obj.setItemno(rs.getString("itemno"));
                obj.setItemDsc(rs.getString("itemdsc"));
                obj.setComments(rs.getString("comments"));    
                obj.setItemNoDsc(rs.getString("itemnodsc"));
                obj.setFlag(rs.getString("flag"));
                irrObjAL.add(obj);
                
            }   
            //******************************************************************************
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            errorstr = e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                    rs.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }
    }
    //get ZC report file 
    public void getZCReportFile( String fltd, String fltno, String sect)
    {
        Driver dbDriver = null;
        
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        fileObjAL=null;
        fileObjAL=new ArrayList();
       
        try
        {
//            ConnectionHelper ch = new ConnectionHelper();
//            conn = ch.getConnection();
//            stmt = conn.createStatement();
            ConnDB cn = new ConnDB();
            cn.setORP3EGUserCP();
//            cn.setORT1EG();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            stmt = conn.createStatement();
            sql = " select filename, filedsc from egtzcfile where " +
                  " fltd=to_date('"+fltd+"','yyyy/mm/dd') and fltno='"+fltno+"' and sect='"+sect+"' " ;      
            
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);

            while (rs.next())
            {
                ReportCopyObj obj = new ReportCopyObj();
                obj.setFileName(rs.getString("filename"));
                obj.setFileDsc(rs.getString("filedsc"));                
                fileObjAL.add(obj);
                
            }   
            //******************************************************************************
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            errorstr = e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                    rs.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }
    }
    
    public void getCMReportFile( String fltd, String fltno, String sect)
    {
        Driver dbDriver = null;
        
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        fileObjAL=null;
        fileObjAL=new ArrayList();
        try
        {
//            ConnectionHelper ch = new ConnectionHelper();
//            conn = ch.getConnection();
//            stmt = conn.createStatement();
            ConnDB cn = new ConnDB();
            cn.setORP3EGUserCP();
//            cn.setORT1EG();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            stmt = conn.createStatement();
            sql = " select filename, filedsc from egtfile where " +
                  " fltd=to_date('"+fltd+"','yyyy/mm/dd') and fltno='"+fltno+"' and sect='"+sect+"' " ;      
            
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);

            while (rs.next())
            {
                ReportCopyObj obj = new ReportCopyObj();
                obj.setFileName(rs.getString("filename"));
                obj.setFileDsc(rs.getString("filedsc"));                
                fileObjAL.add(obj);
                
            }   
            //******************************************************************************
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            errorstr = e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                    rs.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }
    }
    
    public void copyIrrToCM(String fltd ,String fltno ,String sect ,String acno ,String purserEmpno ,String psrname ,String psrsern 
            ,String[] itemno ,String[] com ,String[] dsc ,String[] flag ){

//      if(itemno != null){
//          for(int i=0 ; i<itemno.length ; i++){
//              System.out.println(itemno[i]+"/"+dsc[i]+"/"+com[i]);
//          }
//      }
        /**insert**/
        Connection conn = null;
        Driver dbDriver = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        StringBuffer sqlsb = new StringBuffer();
        int idx = 0;
        try
        {
            ConnDB cn = new ConnDB();
            cn.setORP3EGUserCP();
//          cn.setORT1EG();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            
//          ConnectionHelper ch = new ConnectionHelper();
//          conn = ch.getConnection();
            
            
            //insert 客艙動態 no yearsern#
            if(itemno.length>0)     
                sqlsb = new StringBuffer();
                sqlsb.append(" INSERT INTO egtcmdt(yearsern,fltd,fltno,sect,acno,psrname,psrsern,itemno,itemdsc,comments,caseclose,newdate,newuser,chgdate,chguser,flag) ");
                sqlsb.append(" VALUES (egqcmys.nextval,To_Date(?,'yyyy/mm/dd'),?,?,?,?,?,?,?,?,'N',sysdate,?,sysdate,?,?)");//to_date(?,'yyyy/mm/dd hh24:mi')
                pstmt=null;
                pstmt = conn.prepareStatement(sqlsb.toString());
        
                for(int i =0; i<itemno.length; i++)
                {       
                    idx=0;                  
                    pstmt.setString(++idx,fltd);
                    pstmt.setString(++idx,fltno);
                    pstmt.setString(++idx,sect);
                    pstmt.setString(++idx,acno);
                    pstmt.setString(++idx,psrname);
                    pstmt.setString(++idx,psrsern);
                    pstmt.setString(++idx,itemno[i]);
                    pstmt.setString(++idx,dsc[i]);
                    pstmt.setString(++idx,com[i]);
                    pstmt.setString(++idx,purserEmpno);             
                    pstmt.setString(++idx,purserEmpno);
                    pstmt.setString(++idx,flag[i]);
                    pstmt.addBatch();
                    
                }
                pstmt.executeBatch();
                pstmt.clearBatch(); 
                errorstr = "Y";
        }
        catch (Exception e)
        {
                errorstr = e.toString();
//           System.out.print(errMsg);
        }
        finally
        {
            try {
                if (pstmt != null){
                    pstmt.close();
                }
            } catch (SQLException e) {}
            try {
                if (conn != null){ 
                    conn.close();
                }
            }catch(SQLException e){}
        }
        
    }
    
    
    public void copyFileToCM(String fltd ,String fltno ,String sect ,String purserEmpno ,String psrname ,String psrsern 
        ,String[] filename ,String[] filedsc){

//      if(itemno != null){
//          for(int i=0 ; i<itemno.length ; i++){
//              System.out.println(itemno[i]+"/"+dsc[i]+"/"+com[i]);
//          }
//      }
        /**insert**/   
        String testurl = "http://cabincrew.china-airlines.com/prptt/PR/";
        String liveurl = "http://cabincrew.china-airlines.com/prpt/PR/";
        String urlDirectory = testurl;  
        
        if (null != filename && filename.length > 0) {
            String[] newFilename = new String[filename.length];
            String rs = null;
            try {
                // 宣告將上傳之檔案放置到伺服器的 / .... /upload 目錄中 
                //String saveDirectory = application.getRealPath("/")+"/uploadfile/";
                String tmpDirectory = "/apsource/csap/projfz/webap/uploadfile/";
//                tmpDirectory = "E:\\test\\";
                File outFile = null;
                int max = 0;
                OutputStream fout = null;
                InputStream in = null;
                int count = 0;
                // download
                for(int i=0; i<filename.length; i++){
//                  URL url = new URL( "http://cabincrew.china-airlines.com/prptt/PR/"+filename[i] );
//                  System.out.println(url);
                    URL url = new URL( urlDirectory+filename[i] );
                    HttpURLConnection connect = (HttpURLConnection) url.openConnection();
//                    System.out.println(connect.getResponseCode());
                    if ( connect.getResponseCode() == 200 ) {
                        outFile = new File(tmpDirectory + filename[i]);
//                        System.out.println(outFile);
                        fout =  new FileOutputStream( outFile );
                        max = 1024 * 1024 * 5;
                        in = connect.getInputStream();
                        byte data[] = new byte[max];
                        while((count = in.read(data, 0 ,max)) != -1){
                            fout.write(data ,0 ,count);
                        }               
                        in.close();
                        fout.close();
                        errorstr = "Y";
                    }else{
                        errorstr += "File Not Found, Copy Failed.";//+connect.getResponseCode()+urlDirectory+filename[i];
                    }
                    connect.disconnect();               
                }         
                // upload
                if("Y".equals(errorstr)){
                    // FtpUtility example = new
                    FtpUtility example = new FtpUtility("202.165.148.99","/EGTEST/", "egtestftp01", "egtest#01");
//                    FtpUtility example = new FtpUtility("202.165.148.99","/EG/","egftp01","cseg#01");             
                    example.connect();
                    example.setDirectory("/EGTEST/");
//                     example.setDirectory("/EG/");                                            
                    updFilePath fp = new updFilePath();
                    for (int i = 0; i < filename.length; i++) {
                        newFilename[i] = fp.getFilename() + filename[i].substring(filename[i].lastIndexOf(".")); // 取副檔名
                        example.putBinFile( tmpDirectory + filename[i], newFilename[i]);
                        // update ORP3/EGTFILE upload file information into
                        rs = fp.updFile(fltd, fltno, sect, purserEmpno, newFilename[i] , filedsc[i]);
                    }
                    example.close();
                    //******delete tpeweb03 temp file
                    for(int i=0; i<filename.length; i++){
                        File f = new File(tmpDirectory+filename[i]);
                        f.delete();          
                    }
                    errorstr = "Y";
                }else{
                    errorstr += "#File Not Found, Copy Failed.";
                }          
                
            } catch (Exception e) {
                System.out.println(e.toString());
                errorstr = e.toString();
            }
        } else {
            errorstr = "no file"+filename.length;
        }
        
    }
   

    public ArrayList getIrrObjAL() {
        return irrObjAL;
    }
    public void setIrrObjAL(ArrayList irrObjAL) {
        this.irrObjAL = irrObjAL;
    }
    public ArrayList getFileObjAL() {
        return fileObjAL;
    }
    public void setFileObjAL(ArrayList fileObjAL) {
        this.fileObjAL = fileObjAL;
    }
    public String getErrorstr() {
        return errorstr;
    }
    public void setErrorstr(String errorstr) {
        this.errorstr = errorstr;
    }
    
    
}

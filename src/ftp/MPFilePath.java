package ftp;

import java.io.*;
import java.sql.*;

import org.apache.commons.net.ftp.*;

import ci.db.ConnDB;

public class MPFilePath {

    /**
     * @param args
     */
   

	private String fdate;
	private String fltno;
	private String sect;
	
	private String uploadFileName;
    private boolean delSuccess = false;
    private boolean fileIsExist = false;


    public static void main(String[] args) {
        // TODO Auto-generated method stub
//      updZCFilePath fp = new updZCFilePath();
//      System.out.println(fp.getFilename());
//        System.out.println(fp.updFile("2013/03/04", "0151", "NGOTPE", "631766", "test.jsp", "N/A"));
    }

    public MPFilePath() {//upload file
        
    }

    public MPFilePath(String uploadFileName) {//delete file
        this.uploadFileName = uploadFileName;
    }
    public MPFilePath(String fdate, String fltno, String sect,String uploadFileName) {
		this.fdate = fdate;
		this.fltno = fltno;
		this.sect = sect;

		this.uploadFileName = uploadFileName;
	}  
    public String getFilename() {
        
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        String sql = null;
        ConnDB cn = new ConnDB();

        Driver dbDriver = null;

        try {
            // User connection pool to ORP3DF
            cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            // 直接連線
//          cn.setORT1EG();
//            java.lang.Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL(),cn.getConnID() ,cn.getConnPW());
            
            stmt = conn.createStatement();
        
            sql = "select nvl(to_number(max(substr(filename, 1, 9))) + 1, 0) fn, to_char(sysdate, 'yyyy') yy from egtmpfile ";
            rs = stmt.executeQuery(sql);  
            
        
            String yy = "";
            String fn = null;
            String no = "";
            while (rs.next()) {
                yy = rs.getString("yy");
                fn = rs.getString("fn");
                if ("0".equals(fn)) {
                    fn = fn + "00001";
                }

                no = fn.substring(0, 4);
                if (no.equals(yy)) continue; fn = yy + "00001";
              }

            if (fn == null){
                fn = "201400001";
            }
            return fn;
        } catch (Exception localException) {
            return localException.toString();
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
    //web insert
    public String updFile(String sernno ,String fltd, String fltno,String sect, String upduser, String filename,String filedsc,String type,String subtype) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        ConnDB cn = new ConnDB();

        Driver dbDriver = null;
        try {
            cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);           
            
//            cn.setORT1EG();
//            java.lang.Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL(),cn.getConnID() ,cn.getConnPW());
            
            sql = "insert into egtmpfile (sernno,fltd,fltno,sect,filename,filedsc, upduser,upddate,type,subtype) values" +
                    "(?,to_date(?,'yyyy/mm/dd'), ?, ?, ?, ?, ?, sysdate,?,?)";
            int i = 0;
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(++i, sernno);
            pstmt.setString(++i, fltd);
            pstmt.setString(++i, fltno);
            pstmt.setString(++i, sect);
            pstmt.setString(++i, filename);
            pstmt.setString(++i, filedsc);
            pstmt.setString(++i, upduser);
            pstmt.setString(++i, type);
            pstmt.setString(++i, subtype);

            pstmt.executeUpdate();
            return "0";
        } catch (Exception e) {
            return e.toString();
        } finally {
            try {
                if (rs != null)
                    rs.close();
                } catch (SQLException e) {
                }
                try {
                    if (pstmt != null)
                        pstmt.close();
                } catch (SQLException e) {
                }
                try {
                    if (conn != null)
                        conn.close();
                } catch (SQLException e) {
                }
        }

    }
    //ws del ftp
    public void DoMPDelete() throws IOException {
        FTPClient ftp = new FTPClient();

        try {
            int reply;
            FtpUrl url = new FtpUrl();//統一設定ftp Url.
            ftp.connect(url.getIp());//cabincrew.china-airlines.com
            
            ftp.login(url.getAccount() ,url.getPass());
            ftp.cwd(url.getDirectory()+"MP/");
//          ftp.login("egftp01" ,"cseg#01");
//          ftp.cwd("/EG/MP/");

          
            String[] fileList = ftp.listNames();

            boolean isMatch = false;
            for ( int i = 0; i < fileList.length; i++) {

                if ( uploadFileName.equals(fileList[i]) ) {
                    isMatch = true;
                    break;
                }
            }

            if ( isMatch ) {
                setFileIsExist(true);
                ftp.deleteFile(uploadFileName);
                setDelSuccess(true);
            }
            reply = ftp.getReplyCode();
            if ( !FTPReply.isPositiveCompletion(reply) ) {
                ftp.disconnect();
            }

            ftp.logout();
        } finally {
            if ( ftp.isConnected() ) {
                try {
                    ftp.disconnect();
                } catch (IOException ioe) {

                }
            }

        }
    }

    //web del DB
    public void DoMCdbDelete() throws  SQLException,Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ConnDB cn = new ConnDB();

		Driver dbDriver = null;

		try {
			// User connection pool to ORP3DF
			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);
			// 直接連線
//			 cn.setORT1EG();
//			 java.lang.Class.forName(cn.getDriver());
//			 conn = DriverManager.getConnection(cn.getConnURL()
//			 ,cn.getConnID() ,
//			 cn.getConnPW());

			if (uploadFileName != null) {
				sql = "DELETE egtmpfile WHERE fltd=To_Date(?,'yyyy/mm/dd') and fltno=? and sect=?  and filename=? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, fdate);
				pstmt.setString(2, fltno);
				pstmt.setString(3, sect);
				pstmt.setString(4, uploadFileName);

			} else {
				sql = "DELETE egtmpfile WHERE fltd=To_Date(?,'yyyy/mm/dd') and fltno=? and sect=? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, fdate);
				pstmt.setString(2, fltno);
				pstmt.setString(3, sect);

			}

			pstmt.executeUpdate();
			setDelSuccess(true);
//			setMsg(sql+uploadFileName);
		}catch(Exception e){
			setDelSuccess(false);
//			setMsg(e.toString());
		}finally {

			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {}

		}

	}
    
    public boolean isDelSuccess()
    {
        return delSuccess;
    }

    public void setDelSuccess(boolean delSuccess)
    {
        this.delSuccess = delSuccess;
    }

    public boolean isFileIsExist()
    {
        return fileIsExist;
    }

    public void setFileIsExist(boolean fileIsExist)
    {
        this.fileIsExist = fileIsExist;
    }
    
}

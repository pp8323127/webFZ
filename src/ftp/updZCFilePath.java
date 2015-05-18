package ftp;

import java.sql.*;

import ci.db.ConnDB;

public class updZCFilePath {

	/**
	 * @param args
	 */


	public static void main(String[] args) {
		// TODO Auto-generated method stub
//	    updZCFilePath fp = new updZCFilePath();
//	    System.out.println(fp.getFilename());
//	      System.out.println(fp.updFile("2013/03/04", "0151", "NGOTPE", "631766", "test.jsp", "N/A"));
	}

	public updZCFilePath() {
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
//			cn.setORT1EG();
//            java.lang.Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL(),cn.getConnID() ,cn.getConnPW());
            
		    stmt = conn.createStatement();
		
			sql = "select nvl(to_number(max(substr(filename, 1, 9))) + 1, 0) fn, to_char(sysdate, 'yyyy') yy from egtzcfile ";
			rs = stmt.executeQuery(sql);  
			
		
			String yy = "";
			String fn = "";
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

	public String updFile(String fltd, String fltno,String sect, String upduser, String filename,String filedsc) {
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
			
            sql = "insert into egtzcfile (fltd,fltno,sect,filename,filedsc, upduser,upddate) values" +
					"(to_date(?,'yyyy/mm/dd'), ?, ?, ?, ?, ?, sysdate)";
			int i = 0;
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(++i, fltd);
			pstmt.setString(++i, fltno);
			pstmt.setString(++i, sect);
			pstmt.setString(++i, filename);
			pstmt.setString(++i, filedsc);
			pstmt.setString(++i, upduser);

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
}

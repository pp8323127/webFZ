package ftp;

import ci.db.ConnDB;
import java.sql.Connection; 
import java.sql.Driver;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class updFilePath
{
  private ResultSet rs;
  private Driver dbDriver;
  private Connection con;
  private Statement stmt;
  
  public static void main(String[] args) {
        // TODO Auto-generated method stub
      updFilePath fp = new updFilePath();
      System.out.println(fp.updFile("2013/03/04", "0151", "NGOTPE", "631766", "test.jsp", "N/A"));
  }
  
  public updFilePath()
  {
    this.rs = null;
    this.dbDriver = null;
    this.con = null;
    this.stmt = null;
  }

  public String getFilename()
  {
    ConnDB localConnDB = new ConnDB();
    localConnDB.setORP3EGUserCP();

    String str1 = null;
    String str2 = null;
    String str3 = null;
    try
    {
      this.dbDriver = ((Driver)Class.forName(localConnDB.getDriver()).newInstance());
      this.con = this.dbDriver.connect(localConnDB.getConnURL(), null);

      this.stmt = this.con.createStatement();

      this.rs = this.stmt.executeQuery("select nvl(to_number(max(substr(filename, 1, 9))) + 1, 0) fn, to_char(sysdate, 'yyyy') yy from egtfile");
      while (this.rs.next()) {
        str2 = this.rs.getString("yy");
        str3 = this.rs.getString("fn");
        if ("0".equals(str3)) {
          str3 = str2 + "00001";
        }

        str1 = str3.substring(0, 4);
        if (str1.equals(str2)) continue; str3 = str2 + "00001";
      }

      if (str3 == null) str3 = "200500001";
      return str3;
    } catch (Exception localException) {
      return localException.toString();
    } finally {
      try {
        if (this.rs != null) this.rs.close();  } catch (SQLException localSQLException1) { }
      try {
        if (this.stmt != null) this.stmt.close();  } catch (SQLException localSQLException2) { }
      try {
        if (this.con != null) this.con.close(); 
      } catch (SQLException localSQLException3) {
      }
    }
  }

  public String updFile(String paramString1, String paramString2, String paramString3, String paramString4, String paramString5, String paramString6) {
    ConnDB localConnDB = new ConnDB();
    localConnDB.setORP3EGUserCP();
    try {
      this.dbDriver = ((Driver)Class.forName(localConnDB.getDriver()).newInstance());
      this.con = this.dbDriver.connect(localConnDB.getConnURL(), null);

      this.stmt = this.con.createStatement();

      this.stmt.executeUpdate("insert into egtfile values(to_date('" + paramString1 + "','yyyy/mm/dd'), '" + paramString2 + "', '" + paramString3 + "', '" + paramString5 + "', '" + paramString6 + "', '" + paramString4 + "', sysdate)");

      return "0";
    } catch (Exception localException) {
      return localException.toString();
    } finally {
      try {
        if (this.stmt != null) this.stmt.close();  } catch (SQLException localSQLException1) { }
      try {
        if (this.con != null) this.con.close();
      }
      catch (SQLException localSQLException2)
      {
      }
    }
  }
}
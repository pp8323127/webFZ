package fz;

import ci.db.ConnDB;
import java.sql.Connection;
import java.sql.Driver;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class chkUser
{
  Connection conn;
  Driver dbDriver;
  Statement stmt;
  ResultSet myResultSet;
  private String cname;
  private String sern;
  private String occu;
  private String base;
  private String locked;
  private String spcode;
  private String groups;

  public chkUser()
  {
    this.conn = null;
    this.dbDriver = null;
    this.stmt = null;
    this.myResultSet = null;
    this.cname = null;
    this.sern = null;
    this.occu = null;
    this.base = null;
    this.locked = null;
    this.spcode = null;
    this.groups = null;
  }

  public String getAuth(String paramString1, String paramString2) throws Exception {
    ConnDB localConnDB = new ConnDB();
    int i = 0;
    try
    {
      String str1;
      localConnDB.setORP3FZUserCP();
      this.dbDriver = ((Driver)Class.forName(localConnDB.getDriver()).newInstance());
      this.conn = this.dbDriver.connect(localConnDB.getConnURL(), null);
      this.stmt = this.conn.createStatement();

      this.myResultSet = this.stmt.executeQuery("select * from hrvegemploy where employid='" + paramString1 + "' and unitcd='190A'");
      i = 0;
      while ((this.myResultSet != null) && 
        (this.myResultSet.next())) {
        ++i;
      }

      if (i != 0)
      {
        if (!(paramString2.equals("#1234#"))) {
          return "Please check your ID or Password !!";
        }

        return "ED";
      }

      this.myResultSet = this.stmt.executeQuery("select * from fztcrew where trim(empno)='" + paramString1.trim() + "'");
      i = 0;
      while ((this.myResultSet != null) && 
        (this.myResultSet.next())) {
        ++i;
        this.cname = this.myResultSet.getString("name");
        this.sern = this.myResultSet.getString("box");
        this.occu = this.myResultSet.getString("occu");
        this.base = this.myResultSet.getString("base");
      }

      if (i != 0)
      {
        this.myResultSet = this.stmt.executeQuery("select count(*) xcount from fztuser where userid='" + paramString1 + "' and pwd='" + paramString2 + "'");
        while ((this.myResultSet != null) && 
          (this.myResultSet.next())) {
          i = this.myResultSet.getInt("xcount");
        }

        if (i == 0) {
          return "Please check your ID or Password !!";
        }

        return "C";
      }

      this.myResultSet = this.stmt.executeQuery("select * from hrvegemploy where employid='" + paramString1 + "' and (substr(unitcd,1,2) in ('05','06','18','19') or unitcd in ('635','850','837','811','827'))");

      i = 0;
      while ((this.myResultSet != null) && 
        (this.myResultSet.next())) {
        ++i;
      }

      if (i != 0)
      {
        if (!(paramString2.equals("#1234#"))) {
          return "Please check your ID or Password !!";
        }

        return "O";
      }

      return "You are not authorized !!";
    }
    catch (SQLException localSQLException)
    {
      return "Connect ORP3 FZ DataBase Fail !!";
    } finally {
      try {
        if (this.myResultSet != null) this.myResultSet.close();  } catch (Exception localException1) { }
      try {
        if (this.stmt != null) this.stmt.close();  } catch (Exception localException2) { }
      try {
        if (this.conn != null) this.conn.close(); 
      } catch (Exception localException3) {
      }
    }
  }

  public String findCrew(String paramString) throws Exception {
    String str3;
    int i = 0;
    String str1 = null;
    String str2 = null;
    try
    {
      ConnDB localConnDB = new ConnDB();
      localConnDB.setORP3FZUserCP();
      this.dbDriver = ((Driver)Class.forName(localConnDB.getDriver()).newInstance());
      this.conn = this.dbDriver.connect(localConnDB.getConnURL(), null);
      this.stmt = this.conn.createStatement();
      if (paramString.length() < 6)
      {
        str1 = "select * from fztcrew where trim(box)='" + paramString.trim() + "'";
        str2 = "select groups, nvl(specialcode,'N') spcode from egtcbas where sern=" + paramString.trim();
      }
      else
      {
        str1 = "select * from fztcrew where trim(empno)='" + paramString.trim() + "'";
        str2 = "select groups, nvl(specialcode,'N') spcode from egtcbas where trim(empn)='" + paramString.trim() + "'";
      }
      this.myResultSet = this.stmt.executeQuery(str1);

      while ((this.myResultSet != null) && 
        (this.myResultSet.next())) {
        ++i;
        this.cname = this.myResultSet.getString("name");
        this.sern = this.myResultSet.getString("box");
        this.occu = this.myResultSet.getString("occu");
        this.base = this.myResultSet.getString("base");
      }

      this.myResultSet = this.stmt.executeQuery(str2);

      while ((this.myResultSet != null) && 
        (this.myResultSet.next())) {
        this.spcode = this.myResultSet.getString("spcode");
        if (this.spcode.equals("N")) this.spcode = "";
        this.groups = this.myResultSet.getString("groups");
      }

      if (i != 0)
      {
        return "1";
      }

      return "0";
    }
    catch (Exception localException1)
    {
      return localException1.toString();
    }
    finally {
      try {
        if (this.myResultSet != null) this.myResultSet.close();  } catch (Exception localException2) { }
      try {
        if (this.stmt != null) this.stmt.close();  } catch (Exception localException3) { }
      try {
        if (this.conn != null) this.conn.close();
      } catch (Exception localException4) {
      }
    }
  }

  public String checkLock(String paramString) throws Exception {
    String str2;
    int i = 0;
    String str1 = null;
    try
    {
      ConnDB localConnDB = new ConnDB();
      localConnDB.setORP3FZUserCP();
      this.dbDriver = ((Driver)Class.forName(localConnDB.getDriver()).newInstance());
      this.conn = this.dbDriver.connect(localConnDB.getConnURL(), null);
      this.stmt = this.conn.createStatement();

      if (paramString.length() < 6)
      {
        str1 = "select * from fztcrew where trim(box)='" + paramString.trim() + "'";
      }
      else
      {
        str1 = "select * from fztcrew where trim(empno)='" + paramString.trim() + "'";
      }
      this.myResultSet = this.stmt.executeQuery(str1);
      while ((this.myResultSet != null) && 
        (this.myResultSet.next())) {
        ++i;
        this.locked = this.myResultSet.getString("locked");
      }

      if (i != 0)
      {
        return this.locked;
      }

      return "0";
    }
    catch (Exception localException1)
    {
      return localException1.toString();
    }
    finally {
      try {
        if (this.myResultSet != null) this.myResultSet.close();  } catch (Exception localException2) { }
      try {
        if (this.stmt != null) this.stmt.close();  } catch (Exception localException3) { }
      try {
        if (this.conn != null) this.conn.close();  } catch (Exception localException4) {
      }
    }
  }

  public String getName() {
    return this.cname;
  }

  public String getSern() {
    return this.sern;
  }

  public String getOccu() {
    if (this.occu == null) this.occu = "NO";
    return this.occu;
  }

  public String getBase() {
    return this.base;
  }

  public String getSpcode() {
    return this.spcode;
  }

  public String getGroup() {
    return this.groups;
  }
}
package ci.auth;

import ci.db.ConnDB;
import java.io.PrintStream;
import java.sql.Connection;
import java.sql.Driver;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class GroupsAuth
{
  private String userid;
  private String password;
  private ArrayList grpAL;
  private boolean belongThisGroup;

  public static void main(String[] args)
  {
    GroupsAuth ga = new GroupsAuth("640792");
    try {
      ga.initData();
    }
    catch (ClassNotFoundException e) {
      System.out.println(e.toString());
    }
    catch (SQLException e) {
      System.out.println(e.toString());
    }

    ArrayList al = ga.getGrpAL();

    for (int i = 0; i < al.size(); ++i) {
      System.out.println(al.get(i));
    }

    System.out.println("¬O§_ÄÝ©óUVCII¸s²Õ¡H" + ga.isBelongThisGroup("UVCII"));
  }

  public GroupsAuth(String userid)
  {
    this.userid = userid;
  }

  public void initData() throws ClassNotFoundException, SQLException {
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    ConnDB cn = new ConnDB();

    Driver dbDriver = null;
    try
    {
      cn.setORP3FZUserCP();
      dbDriver = (Driver)Class.forName(cn.getDriver()).newInstance();
      conn = dbDriver.connect(cn.getConnURL(), null);

      pstmt = conn
        .prepareStatement("SELECT gid FROM fztuidg WHERE userid=? ");
      pstmt.setString(1, this.userid);
      rs = pstmt.executeQuery();

      if (rs != null) {
        this.grpAL = new ArrayList();
        while (rs.next()) {
          this.grpAL.add(rs.getString("gid"));
        }
      }
    }
    catch (Exception e)
    {
      System.out.println(e.toString());
    } finally {
      if (rs != null)
        try {
          rs.close(); } catch (SQLException localSQLException) {
        }
      if (pstmt != null)
        try {
          pstmt.close(); } catch (SQLException localSQLException1) {
        }
      if (conn != null)
        try {
          conn.close();
        }
        catch (SQLException localSQLException2)
        {
        }
    }
  }

  public boolean isBelongThisGroup(String grp)
  {
    boolean belongThisGroup = false;
    int idx = -1;
    if (this.grpAL != null) {
      try {
        idx = this.grpAL.indexOf(grp.toUpperCase());
      }
      catch (IndexOutOfBoundsException e) {
        idx = -1;
      }
      if (idx != -1) {
        belongThisGroup = true;
      }
    }

    return belongThisGroup;
  }

  public ArrayList getGrpAL()
  {
    return this.grpAL;
  }
}
package apis_check;

import java.sql.*;
import java.util.*;

/**
 * @author cs71 Created on 2005/10/6
 */
public class HRInfo
{
    private ArrayList empnoAL;
    private ArrayList cnameAL;
    private ArrayList enameAL;
    private ArrayList nationcdAL;
    private ArrayList unitcdAL;
    private ArrayList unitdscAL;
    private ArrayList postcdAL;
    private ArrayList postdscAL;
    private ArrayList indtAL;
    private ArrayList birthdtAL;
    private ArrayList postdtAL;
    private ArrayList ntaccnoAL;
    private ArrayList usaccnoAL;
    private ArrayList sexAL;
    private ArrayList fleetAL;
    private ArrayList rankAL;
    private ArrayList baseAL;


    public static void main(String[] args)
    {
        HRInfo c = new HRInfo();
        System.out.println(c.getCname("635849").replaceAll(",",""));
//        System.out.println(c.getEname("631848"));        
//        System.out.println(c.getNation("631848"));        
//        System.out.println(c.getUnitcd("631848"));
//        System.out.println(c.getPostcd("631848"));        
//        System.out.println(c.getUnitDsc("631848"));        
//        System.out.println(c.getPostDsc("631848"));        
//        System.out.println(c.getBirthdt("631848"));        
//        System.out.println(c.getIndt("631848"));        
//        System.out.println(c.getPostdt("631848"));  
//        System.out.println(c.getBanknoNT("631848"));        
//        System.out.println(c.getBanknoUS("631848"));   
        System.out.println(c.getFleet("635849"));   
        System.out.println(c.getBase("635849"));  
        System.out.println(c.getRank("635849"));  
        System.out.println("Done");
        
    }

    
    public HRInfo()
    {
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        String sql = "";     
        Driver dbDriver = null;
        
        try 
        {
            DBConn cn = new DBConn();
	        cn.setORP3FZUser();
	    	java.lang.Class.forName(cn.getDriver());
	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
	    	stmt = conn.createStatement();	

//            sql = "SELECT a.employid as empno, a.cname as cname, a.lname as lname, " +
//            	  "a.fname as fname, a.nationcd as nationcd, a.unitcd as unitcd, " +
//            	  "a.postcd as postcd, c.cdesc as postdesc, d.cdesc as unitdesc, " +
//            	  "to_char(a.indt,'yyyy/mm/dd') as indt, " +
//            	  "to_char(b.birthdt,'yyyy/mm/dd') as birthdt," +
//            	  "to_char(a.postdt,'yyyy/mm/dd') as postdt, a.sex sex " +
//            	  "FROM hrdb.hrvegemploy a, hrdb.hrvppemp050 b, hrdb.hrvpbpostcd c, hrdb.hrvpbunitcd d " +
//            	  " where a.employid = b.employid (+)" +
//            	  "and a.postcd = c.postcd and a.unitcd = d.unitcd ";
	    	
	    	sql = " SELECT trim(a.employid) as empno, a.cname as cname, a.lname as lname, " +
	    		  " a.fname as fname, a.nationcd as nationcd, a.unitcd as unitcd, " +
	    		  " a.postcd as postcd, c.cdesc as postdesc, d.cdesc as unitdesc, " +
	    		  " to_char(a.indt,'yyyy/mm/dd') as indt, to_char(b.birthdt,'yyyy/mm/dd') as birthdt, " +
	    		  " to_char(a.postdt,'yyyy/mm/dd') as postdt, a.sex sex, v.rank_cd rank, v2.fleet_cd fleet, v3.base base " +
	    		  " FROM hrdb.hrvegemploy a, hrdb.hrvppemp050 b, hrdb.hrvpbpostcd c, hrdb.hrvpbunitcd d, " +
	    		  " (SELECT * FROM fzdb.crew_rank_v WHERE eff_dt <= SYSDATE AND (exp_dt IS NULL OR exp_dt > SYSDATE)) v, " +
	    		  " (SELECT * FROM fzdb.crew_fleet_v WHERE eff_dt <= SYSDATE AND (exp_dt IS NULL OR exp_dt > SYSDATE)) v2 , " +
	    		  " fzdb.crew_base_v v3 " +
	    		  " where a.employid = b.employid (+) AND a.employid = v.staff_num (+)  " +
	    		  " AND a.employid = v2.staff_num (+)   AND a.employid = v3.staff_num (+) " +
	    		  " and a.postcd = c.postcd and a.unitcd = d.unitcd AND b.exstflg = 'Y'  AND a.exstflg = 'Y' " +
	    		  " ORDER BY v3.base " ;
//	    		  System.out.println(sql);
            rs = stmt.executeQuery(sql);

            empnoAL= new ArrayList();
            cnameAL= new ArrayList();
            enameAL= new ArrayList();
            nationcdAL= new ArrayList();
            unitcdAL= new ArrayList();
            unitdscAL= new ArrayList();
            postcdAL= new ArrayList();
            postdscAL= new ArrayList();
            indtAL= new ArrayList();
            birthdtAL= new ArrayList();
            postdtAL= new ArrayList(); 
            ntaccnoAL= new ArrayList();
            usaccnoAL= new ArrayList(); 
            sexAL= new ArrayList(); 
            fleetAL= new ArrayList();
            baseAL= new ArrayList(); 
            rankAL= new ArrayList(); 
            
            while (rs.next()) 
            {
                empnoAL.add(rs.getString("empno"));
                cnameAL.add(rs.getString("cname"));
                enameAL.add(rs.getString("lname")+" "+ rs.getString("fname"));
                nationcdAL.add(rs.getString("nationcd"));
                unitcdAL.add(rs.getString("unitcd"));
                unitdscAL.add(rs.getString("unitdesc"));
                postcdAL.add(rs.getString("postcd"));
                postdscAL.add(rs.getString("postdesc"));
                indtAL.add(rs.getString("indt"));
                birthdtAL.add(rs.getString("birthdt"));
                postdtAL.add(rs.getString("postdt")); 
                sexAL.add(rs.getString("sex")); 
                fleetAL.add(rs.getString("fleet")); 
                baseAL.add(rs.getString("base")); 
                rankAL.add(rs.getString("rank"));                 
            }

        } 
        catch (SQLException e) 
        {
            System.out.print(e.toString());
        } 
        catch (Exception e) 
        {
            System.out.print(e.toString());

        }
        finally 
        {

            if ( rs != null ) try {
                rs.close();
            } catch (SQLException e) {}
            if ( stmt != null ) try {
                stmt.close();
            } catch (SQLException e) {}
            if ( conn != null ) try {
                conn.close();
            } catch (SQLException e) {}

        }
    }// end of public HRInfo()

    public HRInfo(String empno)
    {
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        String sql = "";     
        Driver dbDriver = null;
        
        try 
        {
            DBConn cn = new DBConn();
	        cn.setORP3FZUser();
	    	java.lang.Class.forName(cn.getDriver());
	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
	    	stmt = conn.createStatement();	
	    	
	    	sql = " SELECT trim(a.employid) as empno, a.cname as cname, a.lname as lname, " +
		  		  " a.fname as fname, a.nationcd as nationcd, a.unitcd as unitcd, " +
		  		  " a.postcd as postcd, c.cdesc as postdesc, d.cdesc as unitdesc, " +
		  		  " to_char(a.indt,'yyyy/mm/dd') as indt, to_char(b.birthdt,'yyyy/mm/dd') as birthdt, " +
		  		  " to_char(a.postdt,'yyyy/mm/dd') as postdt, a.sex sex, v.rank_cd rank, v2.fleet_cd fleet, v3.base base " +
		  		  " FROM hrdb.hrvegemploy a, hrdb.hrvppemp050 b, hrdb.hrvpbpostcd c, hrdb.hrvpbunitcd d, " +
		  		  " (SELECT * FROM fzdb.crew_rank_v WHERE eff_dt <= SYSDATE AND (exp_dt IS NULL OR exp_dt > SYSDATE)) v, " +
		  		  " (SELECT * FROM fzdb.crew_fleet_v WHERE eff_dt <= SYSDATE AND (exp_dt IS NULL OR exp_dt > SYSDATE)) v2 , " +
		  		  " fzdb.crew_base_v v3 " +
		  		  " where  a.employid = '"+empno+"' and a.employid = b.employid (+) AND a.employid = v.staff_num (+)  " +
		  		  " AND a.employid = v2.staff_num (+)   AND a.employid = v3.staff_num (+) " +
		  		  " and a.postcd = c.postcd and a.unitcd = d.unitcd ORDER BY v3.base ";
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);

            empnoAL= new ArrayList();
            cnameAL= new ArrayList();
            enameAL= new ArrayList();
            nationcdAL= new ArrayList();
            unitcdAL= new ArrayList();
            unitdscAL= new ArrayList();
            postcdAL= new ArrayList();
            postdscAL= new ArrayList();
            indtAL= new ArrayList();
            birthdtAL= new ArrayList();
            postdtAL= new ArrayList(); 
            ntaccnoAL= new ArrayList();
            usaccnoAL= new ArrayList(); 
            sexAL= new ArrayList(); 
            fleetAL= new ArrayList();
            baseAL= new ArrayList(); 
            rankAL= new ArrayList(); 
            
            while (rs.next()) 
            {
                empnoAL.add(rs.getString("empno"));
                cnameAL.add(rs.getString("cname"));
                enameAL.add(rs.getString("lname")+", "+ rs.getString("fname"));
                nationcdAL.add(rs.getString("nationcd"));
                unitcdAL.add(rs.getString("unitcd"));
                unitdscAL.add(rs.getString("unitdesc"));
                postcdAL.add(rs.getString("postcd"));
                postdscAL.add(rs.getString("postdesc"));
                indtAL.add(rs.getString("indt"));
                birthdtAL.add(rs.getString("birthdt"));
                postdtAL.add(rs.getString("postdt")); 
                sexAL.add(rs.getString("sex")); 
                fleetAL.add(rs.getString("fleet")); 
                baseAL.add(rs.getString("base")); 
                rankAL.add(rs.getString("rank"));
            }

        } 
        catch (SQLException e) 
        {
            System.out.print(e.toString());
        } 
        catch (Exception e) 
        {
            System.out.print(e.toString());

        }
        finally 
        {

            if ( rs != null ) try {
                rs.close();
            } catch (SQLException e) {}
            if ( stmt != null ) try {
                stmt.close();
            } catch (SQLException e) {}
            if ( conn != null ) try {
                conn.close();
            } catch (SQLException e) {}

        }
    }// end of public HRInfo(String empno) 
    
    
    
    public String getCname(String empno) 
    {
        int idx = 0;
        String cname = "";
        idx = empnoAL.indexOf(empno);
        if ( idx != -1 ) 
        {
            cname = (String) cnameAL.get(idx);
        }
        return cname;
    }
    
    public String getEname(String empno) 
    {
        int idx = 0;
        String ename = "";
        idx = empnoAL.indexOf(empno);
        if ( idx != -1 ) 
        {
            ename = (String) enameAL.get(idx);
        }
        return ename;
    }
    
    public String getNation(String empno) 
    {
        int idx = 0;
        String nationcd = "";
        idx = empnoAL.indexOf(empno);
        if ( idx != -1 ) 
        {
            nationcd = (String) nationcdAL.get(idx);
        }
        return nationcd;
    }
  
    public String getUnitcd(String empno) 
    {
        int idx = 0;
        String unitcd = "";
        idx = empnoAL.indexOf(empno);
        if ( idx != -1 ) 
        {
            unitcd = (String) unitcdAL.get(idx);
        }
        return unitcd;
    }   

    public String getUnitDsc(String empno) 
    {
        int idx = 0;
        String unitdsc = "";
        idx = empnoAL.indexOf(empno);
        if ( idx != -1 ) 
        {
            unitdsc = (String) unitdscAL.get(idx);
        }
        return unitdsc;
    }   

    public String getPostcd(String empno) 
    {
        int idx = 0;
        String postcd = "";
        idx = empnoAL.indexOf(empno);
        if ( idx != -1 ) 
        {
            postcd = (String) postcdAL.get(idx);
        }
        return postcd;
    }   

    public String getPostDsc(String empno) 
    {
        int idx = 0;
        String postdsc = "";
        idx = empnoAL.indexOf(empno);
        if ( idx != -1 ) 
        {
            postdsc = (String) postdscAL.get(idx);
        }
        return postdsc;
    }   

    public String getIndt(String empno) 
    {
        int idx = 0;
        String indt = "";
        idx = empnoAL.indexOf(empno);
        if ( idx != -1 ) 
        {
            indt = (String) indtAL.get(idx);
        }
        return indt;
    }     
    
    public String getBirthdt(String empno) 
    {
        int idx = 0;
        String birthdt = "";
        idx = empnoAL.indexOf(empno);
        if ( idx != -1 ) 
        {
            birthdt = (String) birthdtAL.get(idx);
        }
        return birthdt;
    }     
    
    public String getPostdt(String empno) 
    {
        int idx = 0;
        String postdt = "";
        idx = empnoAL.indexOf(empno);
        if ( idx != -1 ) 
        {
            postdt = (String) postdtAL.get(idx);
        }
        return postdt;
    }    
    
    public String getBanknoNT(String empno) 
    {
        int idx = 0;
        String banknont = "";
        idx = empnoAL.indexOf(empno);
        if ( idx != -1 ) 
        {
            banknont = (String) ntaccnoAL.get(idx);
        }
        return banknont;
    }   
    
    public String getBanknoUS(String empno) 
    {
        int idx = 0;
        String banknous = "";
        idx = empnoAL.indexOf(empno);
        if ( idx != -1 ) 
        {
            banknous = (String) usaccnoAL.get(idx);
        }
        return banknous;
    }   
    
    public String getSex(String empno) 
    {
        int idx = 0;
        String sex = "";
        idx = empnoAL.indexOf(empno);
        if ( idx != -1 ) 
        {
            sex = (String) sexAL.get(idx);
        }
        return sex;
    }   
    
    public String getFleet(String empno) 
    {
        int idx = 0;
        String fleet = "";
        idx = empnoAL.indexOf(empno);
        if ( idx != -1 ) 
        {
            fleet = (String) fleetAL.get(idx);
        }
        return fleet;
    }
    
    public String getBase(String empno) 
    {
        int idx = 0;
        String base = "";
        idx = empnoAL.indexOf(empno);
        if ( idx != -1 ) 
        {
            base = (String) baseAL.get(idx);
        }
        return base;
    }
    
    public String getRank(String empno) 
    {
        int idx = 0;
        String rank = "";
        idx = empnoAL.indexOf(empno);
        if ( idx != -1 ) 
        {
            rank = (String) rankAL.get(idx);
        }
        return rank;
    }
    
}//end of class

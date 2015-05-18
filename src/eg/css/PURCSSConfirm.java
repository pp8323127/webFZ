package eg.css;

import java.sql.*;
import java.util.*;
import ci.db.*;

/**
 * @author cs71 Created on  2007/7/18
 */
public class PURCSSConfirm
{    
    private String sql = null;
    private ArrayList objAL = new ArrayList();
    private String errorstr = "";
    
    
    public static void main(String[] args)
    {
        PURCSSConfirm ccr =  new PURCSSConfirm();
//        ccr.getConfirmCSS("628890");
        ccr.getConfirmedCSS("628890","201201","201206");
        System.out.println(ccr.getObjAL().size());
    }    
    
    public void getConfirmCSS(String empno)
    {         
        Driver dbDriver = null;
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();

            //******************************************************************************    
            sql = " SELECT seq, trim(caseno) caseno, purempn, pursern, purname, To_char(fltd,'yyyy/mm/dd') fltd, fltno, sect, " +
            	  " To_char(close_date,'yyyy/mm/dd hh24:mi') close_date " +
            	  " FROM egtcssn n WHERE purempn = '"+empno+"' AND confirm_date IS NULL  ";
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);

            while (rs.next())
            {
                NoticeCSSCloseObj obj  = new NoticeCSSCloseObj();
                obj.setSeq(rs.getString("seq"));
                obj.setCaseno(rs.getString("caseno"));                
                obj.setPsrempn(rs.getString("purempn")); 
                obj.setPsrsern(rs.getString("pursern"));
                obj.setPsrname(rs.getString("purname"));
                obj.setFltd(rs.getString("fltd"));
                obj.setFltno(rs.getString("fltno"));
                obj.setSect(rs.getString("sect"));
                obj.setClose_date(rs.getString("close_date"));
                objAL.add(obj);                
            }                
            errorstr = "Y";
            //******************************************************************************
        }
        catch ( SQLException e )
        {
            System.out.println("SQL error : "+e.toString());
            errorstr = e.toString();
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
    
    /*crew*/
    public void getConfirmCSS(String empno,String type)
    {         
        Driver dbDriver = null;
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        //for crew distinct ­«½Æcaseno
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();

            //******************************************************************************    
            sql = " SELECT distinct trim(caseno) caseno, purempn, pursern, purname, To_char(fltd,'yyyy/mm/dd') fltd, fltno, sect, " +
                  " To_char(close_date,'yyyy/mm/dd hh24:mi') close_date " +
                  " FROM egtcssn n WHERE purempn = '"+empno+"' AND confirm_date IS NULL  ";
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);

            while (rs.next())
            {
                NoticeCSSCloseObj obj  = new NoticeCSSCloseObj();
                //obj.setSeq(rs.getString("seq"));
                obj.setCaseno(rs.getString("caseno"));                
                obj.setPsrempn(rs.getString("purempn")); 
                obj.setPsrsern(rs.getString("pursern"));
                obj.setPsrname(rs.getString("purname"));
                obj.setFltd(rs.getString("fltd"));
                obj.setFltno(rs.getString("fltno"));
                obj.setSect(rs.getString("sect"));
                obj.setClose_date(rs.getString("close_date"));
                objAL.add(obj);                
            }                
            errorstr = "Y";
            //******************************************************************************
        }
        catch ( SQLException e )
        {
            System.out.println("SQL error : "+e.toString());
            errorstr = e.toString();
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
    
    public void getConfirmedCSS(String empno, String smm, String emm)
    {         
        Driver dbDriver = null;
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();

            //******************************************************************************    
            sql = " SELECT seq, trim(caseno) caseno, purempn, pursern, purname, To_char(fltd,'yyyy/mm/dd') fltd, " +
            	  " fltno, sect, To_char(close_date,'yyyy/mm/dd hh24:mi') close_date, " +
            	  " To_char(confirm_date,'yyyy/mm/dd hh24:mi') confirm_date " +
            	  " FROM egtcssn n WHERE purempn = '"+empno+"' AND confirm_date IS NOT NULL " +
            	  " AND fltd BETWEEN To_Date('"+smm+"01','yyyymmdd') AND Last_Day(To_Date('"+emm+"01','yyyymmdd')) ";
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);

            while (rs.next())
            {
                NoticeCSSCloseObj obj  = new NoticeCSSCloseObj();
                obj.setSeq(rs.getString("seq"));
                obj.setCaseno(rs.getString("caseno"));                
                obj.setPsrempn(rs.getString("purempn")); 
                obj.setPsrsern(rs.getString("pursern"));
                obj.setPsrname(rs.getString("purname"));
                obj.setFltd(rs.getString("fltd"));
                obj.setFltno(rs.getString("fltno"));
                obj.setSect(rs.getString("sect"));
                obj.setClose_date(rs.getString("close_date"));
                obj.setConfirm_date(rs.getString("confirm_date"));
                objAL.add(obj);                
            }                
            errorstr = "Y";
            //******************************************************************************
        }
        catch ( SQLException e )
        {
            System.out.println("SQL error : "+e.toString());
            errorstr = e.toString();
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
    
    public void getCpsCssRecord(String caseno)
    {         
        Driver dbDriver = null;
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
            
//            ConnDB cn = new ConnDB();   
//            cn.setORP3FZUser();
//            java.lang.Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() , cn.getConnPW());      
//            stmt = conn.createStatement();

            //******************************************************************************    
            sql = " SELECT css.*, trim(css.caseno) caseno2, To_Char(css.close_date,'yyyy/mm/dd hh24:mi') close_date2, " +
            	  " To_Char(flight_date,'yyyy/mm/dd') flight_date2, cb.sern sern, cb.groups groups, cb.station " +
            	  " FROM cps_egcss_v css, (SELECT Trim(empn) empn2, sern, GROUPS, station FROM egtcbas) cb " +
            	  " WHERE css.rid = cb.empn2(+)  and caseno = '"+caseno+"'" ;
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);

            while (rs.next())
            {
                CpsCssObj obj  = new CpsCssObj();
                obj.setAircraft_no(rs.getString("aircraft_no"));
                obj.setCaseno(rs.getString("caseno2"));
                obj.setDescription(rs.getString("description"));
                obj.setOrigin(rs.getString("origin"));
                obj.setDestination(rs.getString("destination"));
                obj.setFlight_date(rs.getString("flight_date2"));
                obj.setFlight_no(rs.getString("flight_no"));
                obj.setRdetail(rs.getString("rdetail"));
                obj.setRnunit(rs.getString("station"));
                obj.setRid(rs.getString("rid"));
                obj.setRsern(rs.getString("sern"));
                obj.setRgroup(rs.getString("groups"));
                obj.setRname(rs.getString("rname"));                
                obj.setInvestigation(rs.getString("investigation"));
                obj.setSubject(rs.getString("subject"));   
                obj.setClose_date(rs.getString("close_date2"));
                obj.setCategory(rs.getString("category"));
                obj.setDept(rs.getString("dept"));
                obj.setItem(rs.getString("item"));
                obj.setDetail(rs.getString("detail"));     
                obj.setAction_taken(rs.getString("action_taken"));
                objAL.add(obj);                
            }                
            errorstr = "Y";
            //******************************************************************************
        }
        catch ( SQLException e )
        {
            System.out.println("SQL error : "+e.toString());
            errorstr = e.toString();
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
    
    /*crew*/
    public void getCpsCssRecord(String caseno,String userid)
    {         
        Driver dbDriver = null;
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
            
//            ConnDB cn = new ConnDB();   
//            cn.setORP3FZUser();
//            java.lang.Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() , cn.getConnPW());      
//            stmt = conn.createStatement();

            //******************************************************************************    
            sql = " SELECT css.*, trim(css.caseno) caseno2, To_Char(css.close_date,'yyyy/mm/dd hh24:mi') close_date2, " +
            	  " To_Char(flight_date,'yyyy/mm/dd') flight_date2, cb.sern sern, cb.groups groups, cb.station " +
            	  " FROM cps_egcss_v css, (SELECT Trim(empn) empn2, sern, GROUPS, station FROM egtcbas) cb " +
            	  " WHERE css.rid = cb.empn2(+)  and caseno = '"+caseno+"' and rid = '"+userid+"'" +
            	  " AND category =  'Compliment' " ;
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);

            while (rs.next())
            {
                CpsCssObj obj  = new CpsCssObj();
                obj.setAircraft_no(rs.getString("aircraft_no"));
                obj.setCaseno(rs.getString("caseno2"));
                obj.setDescription(rs.getString("description"));
                obj.setOrigin(rs.getString("origin"));
                obj.setDestination(rs.getString("destination"));
                obj.setFlight_date(rs.getString("flight_date2"));
                obj.setFlight_no(rs.getString("flight_no"));
                obj.setRdetail(rs.getString("rdetail"));
                obj.setRnunit(rs.getString("station"));
                obj.setRid(rs.getString("rid"));
                obj.setRsern(rs.getString("sern"));
                obj.setRgroup(rs.getString("groups"));
                obj.setRname(rs.getString("rname"));                
                obj.setInvestigation(rs.getString("investigation"));
                obj.setSubject(rs.getString("subject"));   
                obj.setClose_date(rs.getString("close_date2"));
                obj.setCategory(rs.getString("category"));
                obj.setDept(rs.getString("dept"));
                obj.setItem(rs.getString("item"));
                obj.setDetail(rs.getString("detail"));     
                obj.setAction_taken(rs.getString("action_taken"));
                objAL.add(obj);                
            }                
            errorstr = "Y";
            //******************************************************************************
        }
        catch ( SQLException e )
        {
            System.out.println("SQL error : "+e.toString());
            errorstr = e.toString();
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
    
    public ArrayList getObjAL()
    {
        return objAL;
    }    
   
    public String getStr()
    {
        return errorstr;
    }
    
    public String getSql()
    {
        return sql;
    }

}

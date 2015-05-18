package fz.tsa;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.sun.org.apache.xalan.internal.xsltc.runtime.Hashtable;

import ci.db.ConnDB;
import ci.db.ConnectionHelper;

public class CrewQual {

    /**
     * @param args
     */
    

    Hashtable InRosDtHT = new Hashtable(); 
    Hashtable InCkajDtHT = new Hashtable();
    
    public static void main(String[] args) {
        // TODO Auto-generated method stub
        CrewQual t = new CrewQual();
        ArrayList empnoAL = new ArrayList(); 
//      empnoAL.add("636332");
        empnoAL.add("632368");
//      empnoAL.add("642152"); 
//      empnoAL.add("36332");
        t.getUserInputDt(empnoAL,"A022");
        t.getAssignDt(empnoAL, "%", "2014-01-05");
        System.out.println("done");
    }


    //#5
    //=============================================
    //©Ó¿ì¤H¿é¤J 
    //sharon add
    //==============================================
    public void getUserInputDt(ArrayList empnoAL ,String qualification){
        //qualification
        String Ckadjdt = "";        
        if("A021".equals(qualification) || "A022".equals(qualification) || "A023".equals(qualification) || 
                "A014".equals(qualification) || "A015".equals(qualification) ||"A016".equals(qualification) ||"A017".equals(qualification) ||
                "%".equals(qualification)){
            ResultSet rs = null;
            Statement stmt  = null;   
            Driver dbDriver = null;
            Connection  conn    = null;
            String sql_type = "";
            String empno_sql = "";
            String sql = "";
            if(null!=empnoAL){
                for(int i=0;i<empnoAL.size();i++){
                    if(i==0){
                        empno_sql = "'"+(String)empnoAL.get(i)+"'";
                    }else{
                        empno_sql += ",'"+(String)empnoAL.get(i)+"'";
                    }
                }
            }           
            try{        
                if      ("A021".equals(qualification))  sql_type = " and cktp ='PT' ";
                else if ("A022".equals(qualification))  sql_type = " and cktp ='PC' ";
                else if ("A023".equals(qualification))  sql_type = " and cktp ='RC' ";
                else if ("A014".equals(qualification))  sql_type = " and cktp ='CRM' ";
                else if ("A015".equals(qualification))  sql_type = " and cktp ='SS' ";
                else if ("A016".equals(qualification))  sql_type = " and cktp ='ET' ";
                else if ("A017".equals(qualification))  sql_type = " and cktp ='DG' ";
                else if ("%".equals(qualification))     sql_type = " and cktp in ('PT','PC','RC','CRM','SS','ET','DG')";
                            
                sql="select empno,decode(cktp,'PT','A021','PC','A022','RC','A023','CRM','A014','SS','A015','ET','A016','DG','A017','') cktp," +
                    "to_char(ckadjdt,'yyyy-mm-dd') ckadjdt,newuser,newdate from DZDB.DZTCKAJ " +
                    "where empno in ("+ empno_sql +")" +  sql_type  ;  
                
//              System.out.println(sql);
                ConnDB cn = new ConnDB();
                cn.setORP3FZUserCP();
                dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
                conn = dbDriver.connect(cn.getConnURL(), null); 

//              ConnectionHelper ch = new ConnectionHelper();
//              conn = ch.getConnection();
                 
                stmt = conn.createStatement();      
                rs = stmt.executeQuery(sql);        
                if(rs!= null){
                    while (rs.next()){ 
    //                  System.out.println(rs.getString("cktp"));
                        InCkajDtHT.put(rs.getString("empno")+rs.getString("cktp"), rs.getString("ckadjdt"));
                    }//while
                }//if
            } catch (SQLException e) {
                System.out.println( "SELECT FROM DZTCKAJ ERROR:<br>"+e.toString());
            } catch (Exception e) {
                Ckadjdt = e.toString(); 
            } finally {
                if ( rs != null )   try { rs.close();}    catch (SQLException e) {}
                if ( stmt != null ) try { stmt.close();}  catch (SQLException e) {}
                if ( conn != null ) try { conn.close(); } catch (SQLException e) {}
            }
        }//if("A021".equals(qualification) || "A022".equals(qualification) || "A023".equals(qualification) || 
        
    }
    //#6
    //=============================================
    // Get chk date already assign in roster
    //==============================================
//  public String getAssignDt(String empno ,String qualification,String checkDt){ //yyyymm
    public void getAssignDt(ArrayList empnoAL ,String qualification, String checkDt){
        ResultSet rs = null;
        Statement stmt  = null;   
        Driver dbDriver = null;
        Connection  conn    = null;
        String sql = "";
        String trnCdCond_sql="";
        String empno_sql ="";
        String temp = "";
//      String rosterAssign="";
        if(null!=empnoAL){
            for(int i=0;i<empnoAL.size();i++){
                if(i==0){
                    empno_sql = "'"+(String)empnoAL.get(i)+"'";
                }else{
                    empno_sql += ",'"+(String)empnoAL.get(i)+"'";
                }
            }
        }
        
//      System.out.println(empno_sql);
        try {           
            if("%".equals(qualification)){
                trnCdCond_sql =  
                          "    AND ( "+
                          "     (SUBSTR(rostrg.TRG_CD, 1, 1) = '0' AND "+
                          "     (SUBSTR(rostrg.TRG_CD, LENGTH(rostrg.TRG_CD) - 2) = '_PC' OR "+
                          "     SUBSTR(rostrg.TRG_CD, LENGTH(rostrg.TRG_CD) - 4) = 'RE-PC') )  "+
                          "  or (SUBSTR(rostrg.TRG_CD, 1, 1) = '0' AND "+
                          "     (SUBSTR(rostrg.TRG_CD, LENGTH(rostrg.TRG_CD) - 2) = '_PT' OR "+
                          "      SUBSTR(rostrg.TRG_CD, LENGTH(rostrg.TRG_CD) - 4) = 'RE-PT')) "+
                          "  or( SUBSTR(rostrg.TRG_CD, 1, 1) = '0' AND "+
                          "       SUBSTR(rostrg.TRG_CD, LENGTH(rostrg.TRG_CD) - 9) = '_R/C')  "+
                          "  or rostrg.TRG_CD = 'CRMT'  "+
                          "  or rostrg.TRG_CD = 'SST' "+
                          "  or rostrg.TRG_CD = 'ETT' "+
                          "     ) ";
            }else if ("A022".equals(qualification))//PC 
                 //trnCdCond_sql = " AND (rostrg.TRG_CD LIKE '0%_PC' or rostrg.TRG_CD like '0%_RE-PC') ";
                 trnCdCond_sql = " AND SUBSTR(rostrg.TRG_CD,1,1)='0' AND " +
                                 "( SUBSTR(rostrg.TRG_CD, LENGTH(rostrg.TRG_CD)-2)='_PC' OR " +
                                  " SUBSTR(rostrg.TRG_CD, LENGTH(rostrg.TRG_CD)-4)='RE-PC' ) "; 
            else if ("A201".equals(qualification))//PT 
                 //trnCdCond_sql = " AND (rostrg.TRG_CD LIKE '0%_PT' or rostrg.TRG_CD like '0%_RE-PT') ";
                trnCdCond_sql = " AND SUBSTR(rostrg.TRG_CD,1,1)='0' AND " +
                                 "( SUBSTR(rostrg.TRG_CD, LENGTH(rostrg.TRG_CD)-2)='_PT' OR " +
                                  " SUBSTR(rostrg.TRG_CD, LENGTH(rostrg.TRG_CD)-4)='RE-PT' ) "; 
            else if ("A023".equals(qualification)) //RC
                 //trnCdCond_sql = " AND rostrg.TRG_CD LIKE '0%ANNUAL_R/C' ";
                 trnCdCond_sql = " ( AND SUBSTR(rostrg.TRG_CD,1,1)='0' AND " +
                                 " SUBSTR(rostrg.TRG_CD, LENGTH(rostrg.TRG_CD)-9)='_R/C' )"; 
            else if ("A014".equals(qualification))//CRM
                 trnCdCond_sql = " AND rostrg.TRG_CD='CRMT' ";
            else if ("A015".equals(qualification))//SS   
                 trnCdCond_sql = " AND rostrg.TRG_CD='SST' ";
            else if ("A016".equals(qualification))//ET
                  trnCdCond_sql = " AND rostrg.TRG_CD='ETT' ";
            else trnCdCond_sql = "";
            
            sql = "select r.staff_num, rostrg.trg_cd trg_cd, TO_CHAR(r.str_dt,'yyyy-mm-dd') str_dt " +
                    "from ROSTER_SPECIAL_DUTIES_TRG_V rostrg, TRAINING_CODES_V trgcd, roster_v r " +
                    "WHERE r.series_num = rostrg.SERIES_NUM " +
                    "and r.ROSTER_NUM = rostrg.ROSTER_NUM " +
                    "and rostrg.TRG_CD = trgcd.TRG_CD " +
            //      "and r.staff_num = '"+empno+"'" +
                    "and r.staff_num in ("+empno_sql+")  " +
            //      "and TO_CHAR(r.str_dt,'yyyymm') BETWEEN '" + syyyymm + "' AND '" + eyyyymm + "'";
                    "and r.str_dt BETWEEN  to_date('" + checkDt + " 0000','yyyy-mm-dd hh24mi') " +
                    		         " AND to_date('" + checkDt + " 2359','yyyy-mm-dd hh24mi')+10 "+
            trnCdCond_sql ;
            System.out.println(sql);
            
            ConnDB cn = new ConnDB();
            cn.setAOCIPRODCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null); 

//          ConnectionHelper ch = new ConnectionHelper();
//          conn = ch.getConnection();
             
            stmt = conn.createStatement();   
            
             rs = stmt.executeQuery(sql);       
             if(rs!= null){
                while (rs.next()){ 
                    //rosterAssign = rs.getString("str_dt");
//                  rosterAssignAL.add(rs.getString("str_dt"));
//                  
                    temp = rs.getString("trg_cd");
                    if(temp.contains("PC")){
                        temp = "A022";
                    }else if(temp.contains("PT")){
                        temp = "A021";  
                    }else if(temp.contains("R/C")){
                        temp = "A023";  
                    }else if(temp.equals("CRMT")){
                        temp = "A014";  
                    }else if(temp.equals("SST")){
                        temp = "A015";  
                    }else if(temp.equals("ETT")){
                        temp = "A016";
                    }
//                  System.out.println(rs.getString("staff_num")+","+  rs.getString("str_dt")) ;
                    InRosDtHT.put(rs.getString("staff_num")+temp, rs.getString("str_dt"));
                }//while
             }//if
                        
        } catch (Exception e) {
            System.out.println( "SELECT FROM roster ERROR:<br>"+e.toString());
//          rosterAssign = e.toString();    
        } finally {
            if ( rs != null )   try { rs.close();}    catch (SQLException e) {}
            if ( stmt != null ) try { stmt.close();}  catch (SQLException e) {}
            if ( conn != null ) try { conn.close(); } catch (SQLException e) {}
        }//try
         
    }


    public Hashtable getInRosDtHT() {
        return InRosDtHT;
    }


    public void setInRosDtHT(Hashtable inRosDtHT) {
        InRosDtHT = inRosDtHT;
    }


    public Hashtable getInCkajDtHT() {
        return InCkajDtHT;
    }


    public void setInCkajDtHT(Hashtable inCkajDtHT) {
        InCkajDtHT = inCkajDtHT;
    }

    
    
    
}

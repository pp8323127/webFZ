package ws.prac.FltInfo;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import ci.db.*;


public class FltInfoFun {
    
     public FltInfoRObj fltObj = null;  // previous flight
     public FltInfoRObj fltObj2 = null; // this flight
     
     public static void main(String[] args) {
         FltInfoFun pflt = new FltInfoFun();
//       pflt.getPreFltInfo("18206", "201406101710", "TPELAX");
       pflt.getThisFltInfo("18206", "201406101710", "TPELAX","0006");
//       pflt.getPreFltInfo("18202", "201308271446", "KULTPE");
//       pflt.getThisFltInfo("18202", "201308271446", "KULTPE");
//         pflt.getThisFltInfo("", "201312271735", "TPEFUK","0110");//local time
//         pflt.getPreFltInfo("18359", "20131106 1227", "ICNTPE");
         System.out.println("Done.");
     }
     
     public void getPreFltInfo(String acNo,String fltd,String sect){
         Driver dbDriver = null;
         Connection conn = null;
         Statement stmt = null;
         ResultSet myResultSet = null;
         ArrayList fltInfoAL = null;
         String toSect = "";
         if(sect.length() == 6){
             toSect = sect.substring(0,3);
         }
//       System.out.println(toSect);
         
         try{
//              live
                ConnDB cn = new ConnDB();
                cn.setAOCIPRODCP();
                dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
                conn = dbDriver.connect(cn.getConnURL(), null);
                stmt = conn.createStatement();
//                直接連線
//                   ConnectionHelper ch = new ConnectionHelper();
//                   conn = ch.getConnection();
//                   stmt = conn.createStatement();
//                String sql =" SELECT DA13_AIRL airl,DA13_FLTNO fltno, DA13_SCDATE_U scdate, " +
//                            " DA13_FM_SECTOR || DA13_TO_SECTOR SECTOR,"+
//                            " da13_a_gate a_gate, da13_d_gate d_gate," +
//                            " to_char(DA13_ETDL, 'yyyy/mm/dd hh24:mi') L_preTD," +
//                            " to_char(DA13_ETAL, 'yyyy/mm/dd hh24:mi') L_preTA," +
//                            " to_char(DA13_ETDU, 'yyyy/mm/dd hh24:mi') preTD," +
//                            " to_char(DA13_ETAU, 'yyyy/mm/dd hh24:mi') preTA" +
//                            " from (SELECT * FROM V_ITTDA13_CI" +
//                            "   WHERE DA13_ACNO = '"+acNo+"'  " +//-- FILL TAIL NUMBER
//                            "   AND DA13_SCDATE_L >= To_Date('"+fltd+"', 'YYYYMMDD HH24:MI') - 3 " +//-- FILL STD
//                            "   AND DA13_SCDATE_L <= To_Date('"+fltd+"', 'YYYYMMDD HH24:MI') + 3 " +//-- FILL STD
//                            "   AND DA13_AIRL in ('AE', 'CI') AND DA13_TO_SECTOR = '"+toSect+"' " +
//                            "   AND DA13_ETAL < To_Date('"+fltd+"', 'YYYYMMDD HH24:MI')" +
//                            //"   --AND (DA13_flt_manip_code IS  NULL  OR DA13_flt_manip_code not in ('RPL','CNL','CNL-OVR') )" +
//                            "   AND (DA13_COND IS NULL OR DA13_COND NOT in ('C'))" +
//                            " ORDER BY DA13_ETAL desc) where ROWNUM = '1'";
                String sql = " SELECT * FROM ("+
                             " SELECT DA13_AIRL airl,DA13_FLTNO fltno, DA13_SCDATE_U scdate,"+ 
                             " DA13_FM_SECTOR || DA13_TO_SECTOR SECTOR,"+
                             " da13_a_gate a_gate, da13_d_gate d_gate,"+
                             " to_char(DA13_ETDL, 'yyyy/mm/dd hh24:mi') L_preTD,"+
                             " to_char(DA13_ETAL, 'yyyy/mm/dd hh24:mi') L_preTA,"+
                             " to_char(DA13_ETDU, 'yyyy/mm/dd hh24:mi') preTD,"+
                             " to_char(DA13_ETAU, 'yyyy/mm/dd hh24:mi') preTA"+
                             " from (   "+
                             " SELECT * FROM V_ITTDA13_CI"+
                             "  WHERE DA13_ACNO = '"+acNo+"'"+  
                             "  AND DA13_SCDATE_L >= To_Date('"+fltd+"', 'YYYYMMDD HH24:MI') - 3"+ 
                             "  AND DA13_SCDATE_L <= To_Date('"+fltd+"', 'YYYYMMDD HH24:MI') + 3" +
                             "  AND DA13_SCDATE_U BETWEEN To_Date('"+fltd+"', 'YYYYMMDD HH24:MI') -20" +
                             "  AND To_Date('"+fltd+"', 'YYYYMMDD HH24:MI') +20"+ 
                             "  AND DA13_AIRL in ('AE', 'CI')"+  
                             "  AND DA13_ETAL < To_Date('"+fltd+"', 'YYYYMMDD HH24:MI')"+
                             " AND (DA13_COND IS NULL OR DA13_COND NOT in ('C'))"+                              
                             " ) WHERE  DA13_TO_SECTOR = '"+toSect+"' ORDER BY DA13_ETAL DESC"+  
                             " ) WHERE ROWNUM = '1'";
//              System.out.println(sql);
                 
                myResultSet = stmt.executeQuery(sql); 
                
                fltObj = new FltInfoRObj();
                fltInfoAL = new ArrayList();
                if(myResultSet != null){
                    if(myResultSet.next())
                    {
                        FltInfoObj obj = new FltInfoObj();
//                      System.out.println(myResultSet.getString("fltno")+myResultSet.getString("SECTOR"));
                        obj.setAirl(myResultSet.getString("airl"));
                        obj.setFltno(myResultSet.getString("fltno"));
                        obj.setScdate(myResultSet.getString("scdate"));
                        obj.setSect(myResultSet.getString("SECTOR"));
                        obj.setaGate(myResultSet.getString("a_gate"));
                        obj.setdGate(myResultSet.getString("d_gate"));
                        obj.setLoc_timeDep(myResultSet.getString("L_preTD"));
                        obj.setLoc_timeArv(myResultSet.getString("L_preTA"));
                        obj.setTimeDep(myResultSet.getString("preTD"));
                        obj.setTimeArv(myResultSet.getString("preTA"));      
                        fltInfoAL.add(obj);                     
                    }   
                    if(fltInfoAL.size() > 0){
                        FltInfoObj[] array = new FltInfoObj[fltInfoAL.size()];
                        for (int j = 0; j < fltInfoAL.size(); j++) {
                            array[j] = (FltInfoObj) fltInfoAL.get(j);
//                          System.out.println(array[j].getFltno());
                        }
                        fltObj.setfInfo(array); 
                        fltObj.setResultMsg("1");
                    }else{
                        fltObj.setResultMsg("1");
                        fltObj.setErrorMsg("Not Data.");                
                    }   
                }else{
                    fltObj.setResultMsg("1");
                    fltObj.setErrorMsg("Not Data.");                
                }               
            } catch (Exception e) {
                fltObj.setResultMsg("0");
                fltObj.setErrorMsg(e.toString());
//              System.out.println(e.toString());
            } finally {
                try {
                    if (myResultSet != null)
                        myResultSet.close();
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

     public void getThisFltInfo(String acNo,String fltd,String sect,String fltno){
         Driver dbDriver = null;
         Connection conn = null;
         Statement stmt = null;
         ResultSet myResultSet = null;
         ArrayList fltInfoAL = null;
         String scdate = fltd.substring(2,8);
         String fltnoSql = "";
         if(null != fltno && !"".equals(fltno)){
             fltno = fltno.substring(0,4);
             fltnoSql = "and DA13_FLTNO = '"+fltno+"'";
         }     
//         System.out.println(fltno);
       
         try{
//               live
//                ConnDB cn = new ConnDB();
//                 cn.setAOCIPRODCP();
//                 dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//                 conn = dbDriver.connect(cn.getConnURL(), null);
//                 stmt = conn.createStatement();
             
//               直接連線
               ConnectionHelper ch = new ConnectionHelper();
               conn = ch.getConnection();
               stmt = conn.createStatement();
                /*String sql =" SELECT DA13_AIRL airl,DA13_FLTNO fltno, DA13_SCDATE_U scdate, " +
                            " DA13_FM_SECTOR || DA13_TO_SECTOR SECTOR,"+
                            " da13_a_gate a_gate, da13_d_gate d_gate," +
                            " to_char(DA13_ETDL, 'yyyy/mm/dd hh24:mi') L_preTD," +
                            " to_char(DA13_ETAL, 'yyyy/mm/dd hh24:mi') L_preTA," +
                            " to_char(DA13_ETDU, 'yyyy/mm/dd hh24:mi') preTD," +
                            " to_char(DA13_ETAU, 'yyyy/mm/dd hh24:mi') preTA" +
                            " from (SELECT * FROM V_ITTDA13_CI" +
                            " WHERE DA13_SCDATE_U >= To_Date('"+fltd+"', 'YYYYMMDD HH24:MI') - 3 " +
                            " AND DA13_SCDATE_U <= To_Date('"+fltd+"', 'YYYYMMDD HH24:MI') + 3" +
                            " AND DA13_ACNO = '"+acNo+"' and DA13_FM_SECTOR || DA13_TO_SECTOR = '"+sect+"')";*/
//               String sql =
//                       " SELECT DA13_AIRL airl,DA13_FLTNO fltno, DA13_SCDATE_U scdate, " +
//                       " DA13_FM_SECTOR || DA13_TO_SECTOR SECTOR,"+
//                       " da13_a_gate a_gate, da13_d_gate d_gate," +
//                       " to_char(DA13_ETDL, 'yyyy/mm/dd hh24:mi') L_preTD," +
//                       " to_char(DA13_ETAL, 'yyyy/mm/dd hh24:mi') L_preTA," +
//                       " to_char(DA13_ETDU, 'yyyy/mm/dd hh24:mi') preTD," +
//                       " to_char(DA13_ETAU, 'yyyy/mm/dd hh24:mi') preTA," +
//                       " DA13_ACNO " +
//                       " FROM V_ITTDA13_CI" +
//                       " WHERE DA13_SCDATE_L >= To_Date('"+fltd+"', 'YYYYMMDD HH24:MI') - 1 " +
//                       " AND DA13_SCDATE_L <= To_Date('"+fltd+"', 'YYYYMMDD HH24:MI') + 1" +
//                       " AND DA13_ACNO = '"+acNo+"' " +                        
//                       " and da13_scdate='"+scdate+"' " + fltnoSql+
//                       " and DA13_FM_SECTOR || DA13_TO_SECTOR = '"+sect+"'" ; 
               
               
               String sql =
                        " SELECT * FROM ("+
                        " SELECT DA13_AIRL airl,DA13_FLTNO fltno, DA13_SCDATE_U scdate, " +
                        " DA13_FM_SECTOR || DA13_TO_SECTOR SECTOR,"+
                        " da13_a_gate a_gate, da13_d_gate d_gate," +
                        " to_char(DA13_ETDL, 'yyyy/mm/dd hh24:mi') L_preTD," +
                        " to_char(DA13_ETAL, 'yyyy/mm/dd hh24:mi') L_preTA," +
                        " to_char(DA13_ETDU, 'yyyy/mm/dd hh24:mi') preTD," +
                        " to_char(DA13_ETAU, 'yyyy/mm/dd hh24:mi') preTA," +
                        " DA13_ACNO " +
                        " FROM V_ITTDA13_CI" +
                        " WHERE DA13_SCDATE_L >= To_Date('"+fltd+"', 'YYYYMMDD HH24:MI') - 1 " +
                        " AND DA13_SCDATE_L <= To_Date('"+fltd+"', 'YYYYMMDD HH24:MI') + 1" +
                        " AND DA13_ACNO = '"+acNo+"' " +                        
                        " and da13_scdate='"+scdate+"' " + fltnoSql+
                        " ) where SECTOR = '"+sect+"'" ;
//                System.out.println(sql);
                 
                myResultSet = stmt.executeQuery(sql); 
                
                fltObj2 = new FltInfoRObj();
                fltInfoAL = new ArrayList();
                if(myResultSet != null){
                    if(myResultSet.next())
                    {
                        FltInfoObj obj = new FltInfoObj();
//                      System.out.println(myResultSet.getString("fltno")+myResultSet.getString("SECTOR"));
                        obj.setAirl(myResultSet.getString("airl"));
                        obj.setFltno(myResultSet.getString("fltno"));
                        obj.setScdate(myResultSet.getString("scdate"));
                        obj.setSect(myResultSet.getString("SECTOR"));
                        obj.setaGate(myResultSet.getString("a_gate"));
                        obj.setdGate(myResultSet.getString("d_gate"));
                        obj.setLoc_timeDep(myResultSet.getString("L_preTD"));
                        obj.setLoc_timeArv(myResultSet.getString("L_preTA"));
                        obj.setTimeDep(myResultSet.getString("preTD"));
                        obj.setTimeArv(myResultSet.getString("preTA")); 
//                        System.out.println(myResultSet.getString("DA13_ACNO"));
                        fltInfoAL.add(obj);                     
                    }          
                    if(fltInfoAL.size() > 0){
                        FltInfoObj[] array = new FltInfoObj[fltInfoAL.size()];
                        for (int j = 0; j < fltInfoAL.size(); j++) {
                            array[j] = (FltInfoObj) fltInfoAL.get(j);
//                          System.out.println(array[j].getFltno());
                        }
                        fltObj2.setfInfo(array); 
                        fltObj2.setResultMsg("1");
                    }else{
                        fltObj2.setResultMsg("1");
                        fltObj2.setErrorMsg("Not Data.");  
                    }    
                }else{
                    fltObj2.setResultMsg("1");
                    fltObj2.setErrorMsg("Not Data.");               
                }
                
            } catch (Exception e) {
                fltObj2.setResultMsg("0");
                fltObj2.setErrorMsg(e.toString());
//              System.out.println(e.toString());
            } finally {
                try {
                    if (myResultSet != null)
                        myResultSet.close();
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

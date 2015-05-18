package ws.crew;

import java.sql.*;
import java.util.*;

import ci.db.*;

import ws.*;


public class SendCrewSwap
{
    /**
     * @param args.
     * CS 80
     * type:
     *  3次 TPE:1 
     *  3次 KHH:2
     *  積點 TPE:3,4
     *  積點 KHH:5 
     */
    CrewMsgObj sendObj = null;
    ArrayList objAL = new ArrayList();
    
    public static void main(String[] args)
    {
        // TODO Auto-generated method stub

    }    
    /*送出三次 換班單 TPE*/
    public CrewMsgObj SendSwapFormTPE(SendCrewSwapFormObj objAr){
       
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        int formno = 0;
        String errorStr = "";
        try {
            sendObj = new CrewMsgObj();
            if(null != objAr && "".equals(objAr.getaEmpno())){          
                //User connection pool to FZ
                ConnectionHelper ch = new ConnectionHelper();
                conn = ch.getConnection();  
               
                //取得formno 2006/01/10 依申請月份取得單號
                sql = "SELECT Nvl(Max(formno),'" + objAr.getYear() + objAr.getMonth() + "0000')+1 newFormNo "
                        + "FROM fztform WHERE substr(to_char(formno),1,6)= ? " ;
                
                pstmt = conn.prepareStatement(sql);
                
                pstmt.setString(1 ,objAr.getYear() + objAr.getMonth());
                
                rs = pstmt.executeQuery();
                
                if ( rs.next() ) {
                    formno = rs.getInt("newFormNo");
                }
                pstmt.clearParameters();
                
                //有錯誤時rollback
                 conn.setAutoCommit(false);
        
                 //先insert 申請單主table
                 sql = "INSERT INTO fztform VALUES "
                        +"(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,"
                        +"null,null,?,null,null,?,sysdate,null,null,'TPE')";
                pstmt = conn.prepareStatement(sql);
                int j=0;
                pstmt.setInt(j++,formno);
                pstmt.setString(j++,objAr.getaEmpno());
                pstmt.setString(j++,objAr.getaSern());
                pstmt.setString(j++,objAr.getaCname());
                pstmt.setString(j++,objAr.getaGrps());
                pstmt.setString(j++,objAr.getaApplyTimes());
                pstmt.setString(j++,objAr.getaQual());
                pstmt.setString(j++,objAr.getrEmpno());
                pstmt.setString(j++,objAr.getrSern());
                pstmt.setString(j++,objAr.getrCname());
                pstmt.setString(j++,objAr.getrGrps());
                pstmt.setString(j++,objAr.getrApplyTimes());
                pstmt.setString(j++,objAr.getrQual());
                pstmt.setString(j++,"N");
                pstmt.setString(j++,objAr.getaSwapHr());
                pstmt.setString(j++,objAr.getrSwapHr());
                pstmt.setString(j++,objAr.getaSwapDiff());
                pstmt.setString(j++,objAr.getrSwapDiff());
                pstmt.setString(j++,objAr.getaPrjcr());
                pstmt.setString(j++,objAr.getrPrjcr());
                pstmt.setString(j++,objAr.getaSwapCr());
                pstmt.setString(j++,objAr.getrSwapCr());
                pstmt.setString(j++,objAr.getComments());
                pstmt.setString(j++,objAr.getaEmpno());//userid
                
                pstmt.executeUpdate();              
                
                //insert 申請單明細
                pstmt = conn.prepareStatement("insert INTO fztaply(formno,therole,empno,tripno,fdate,fltno,fly_hr) "
                 +"VALUES ("+formno+",?,?,?,?,?,?)");
                //   +"VALUES ("+formno+",therole,empno,tripno,fdate,fltno,fly_hr)");
        
                pstmt.clearBatch();
                if(objAr.getaFdate() != null){
        
                    for(int i=0;i<objAr.getaFdate().length;i++){
                        pstmt.setString(1,"A");
                        pstmt.setString(2,objAr.getaEmpno());
                        pstmt.setString(3,objAr.getaTripno()[i]);
                        pstmt.setString(4,objAr.getaFdate()[i]);
                        pstmt.setString(5,objAr.getaFltno()[i]);
                        pstmt.setString(6,objAr.getaFlyHrs()[i]);
                        pstmt.addBatch(); 
                        
                    }
                    pstmt.executeBatch(); 
                }
                    pstmt.clearBatch();
        
                if(objAr.getrFdate() != null){
                    for(int i=0;i<objAr.getrFdate().length;i++){
                        pstmt.setString(1,"R");
                        pstmt.setString(2,objAr.getrEmpno());
                        pstmt.setString(3,objAr.getrTripno()[i]);
                        pstmt.setString(4,objAr.getrFdate()[i]);
                        pstmt.setString(5,objAr.getrFltno()[i]);
                        pstmt.setString(6,objAr.getrFlyHrs()[i]);
                        pstmt.addBatch();
                    }
                     pstmt.executeBatch();
        
                }
                pstmt.clearBatch();
                conn.commit();

                sendObj.setResultMsg("1");
                sendObj.setErrorMsg("Done");
                //寫入log        
//                fz.writeLog wl = new fz.writeLog();
//                wl.updLog(userid, request.getRemoteAddr(),request.getRemoteHost(), "FZ2851");
            }//objAr.length>0
        } catch (SQLException e) {
            //有錯誤時rollback
            try {conn.rollback();} catch (SQLException e1) {}
            errorStr = objAr.getaEmpno()+". 申請單"+formno+"更新失敗";
            sendObj.setResultMsg("0");
            sendObj.setErrorMsg(errorStr);
        //  System.out.print(new java.util.Date()+" 申請單"+formno+"更新失敗："+e.toString());
//            ci.tool.WriteLog wl2 = new ci.tool.WriteLog("/apsource/csap/projfz/webap/Log/fzFormLog.txt");
//            wl2.WriteFile(new java.util.Date()+"\t"+objAr.getaEmpno()+"\t 申請單"+formno+"更新失敗："+e.toString());    
        } catch (Exception e) {
            //有錯誤時rollback
            try {conn.rollback();} catch (SQLException e1) {}
            errorStr = objAr.getaEmpno()+". 申請單"+formno+"更新失敗";
            sendObj.setResultMsg("0");
            sendObj.setErrorMsg(errorStr);
            //System.out.print(e.toString());
//            ci.tool.WriteLog wl2 = new ci.tool.WriteLog("/apsource/csap/projfz/webap/Log/fzFormLog.txt");
//            wl2.WriteFile(new java.util.Date()+"\t"+objAr.getaEmpno()+"\t 申請單"+formno+"更新失敗："+e.toString());
        } finally {
            if ( rs != null ) try {
                rs.close();
            } catch (SQLException e) {}
            if ( pstmt != null ) try {
                pstmt.close();
            } catch (SQLException e) {}
            if ( conn != null ) try {
                conn.close();
            } catch (SQLException e) {}

        }
        return sendObj;
    }
    
    /*送出三次 換班單 KHH*/
    public CrewMsgObj SendSwapFormKHH(SendCrewSwapFormObj objAr){
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        int formno = 0;
        String errorStr = "";
        try {
            sendObj = new CrewMsgObj();
            if(null != objAr && "".equals(objAr.getaEmpno())){
              //User connection pool to FZ
                ConnectionHelper ch = new ConnectionHelper();
                conn = ch.getConnection();       
                //取得formno 2006/01/10 依申請月份取得單號
                sql = "SELECT Nvl(Max(formno),'" + objAr.getYear()
                        + objAr.getMonth() + "0000')+1 newFormNo "
                        + "FROM fztformf WHERE station='KHH' and  substr(to_char(formno),1,6)=?";
                pstmt = conn.prepareStatement(sql);
                
                pstmt.setString(1 ,objAr.getYear() + objAr.getMonth());
                
                rs = pstmt.executeQuery();
                
                if ( rs.next() ) {
                    formno = rs.getInt("newFormNo");
                }
                            
                //有錯誤時rollback
                 conn.setAutoCommit(false);
        
            //先insert 申請單主table
                pstmt = conn.prepareStatement("INSERT INTO fztformf VALUES "
                        +"(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,"
                        +"null,null,?,null,null,?,sysdate,null,null,'KHH')");
                int j=0;
                pstmt.setInt(j++,formno);
                pstmt.setString(j++,objAr.getaEmpno());
                pstmt.setString(j++,objAr.getaSern());
                pstmt.setString(j++,objAr.getaCname());
                pstmt.setString(j++,objAr.getaGrps());
                pstmt.setString(j++,objAr.getaApplyTimes());
                pstmt.setString(j++,objAr.getaQual());
                pstmt.setString(j++,objAr.getrEmpno());
                pstmt.setString(j++,objAr.getrSern());
                pstmt.setString(j++,objAr.getrCname());
                pstmt.setString(j++,objAr.getrGrps());
                pstmt.setString(j++,objAr.getrApplyTimes());
                pstmt.setString(j++,objAr.getrQual());
                pstmt.setString(j++,"N");
                pstmt.setString(j++,objAr.getaSwapHr());
                pstmt.setString(j++,objAr.getrSwapHr());
                pstmt.setString(j++,objAr.getaSwapDiff());
                pstmt.setString(j++,objAr.getrSwapDiff());
                pstmt.setString(j++,objAr.getaPrjcr());
                pstmt.setString(j++,objAr.getrPrjcr());
                pstmt.setString(j++,objAr.getaSwapCr());
                pstmt.setString(j++,objAr.getrSwapCr());
                pstmt.setString(j++,objAr.getComments());
                pstmt.setString(j++,objAr.getaEmpno());//userid
                pstmt.executeUpdate();              
        
                //insert 申請單明細
                pstmt = conn.prepareStatement("insert INTO fztaplyf (formno,therole,empno,tripno,fdate,fltno,fly_hr,station) "
                 +"VALUES ("+formno+",?,?,?,?,?,?,'KHH')");
        
        
                pstmt.clearBatch();
                if(objAr.getaFdate() != null){
            
                    for(int i=0;i<objAr.getaFdate().length;i++){
                        pstmt.setString(1,"A");
                        pstmt.setString(2,objAr.getaEmpno());
                        pstmt.setString(3,objAr.getaTripno()[i]);
                        pstmt.setString(4,objAr.getaFdate()[i]);
                        pstmt.setString(5,objAr.getaFltno()[i]);
                        pstmt.setString(6,objAr.getaFlyHrs()[i]);            
                        pstmt.addBatch();                         
                    }
                    pstmt.executeBatch(); 
            
                }
                    pstmt.clearBatch();
            
                if(objAr.getrFdate() != null){
                    for(int i=0;i<objAr.getrFdate().length;i++){
                        pstmt.setString(1,"R");
                        pstmt.setString(2,objAr.getrEmpno());
                        pstmt.setString(3,objAr.getrTripno()[i]);
                        pstmt.setString(4,objAr.getrFdate()[i]);
                        pstmt.setString(5,objAr.getrFltno()[i]);
                        pstmt.setString(6,objAr.getrFlyHrs()[i]);
                        pstmt.addBatch();
                    }
                     pstmt.executeBatch();
                }
                pstmt.clearBatch();
                conn.commit();
                //寫入log
            
//                fz.writeLog wl = new fz.writeLog();
//                wl.updLog(userid, request.getRemoteAddr(),request.getRemoteHost(), "FZ285K");                     
            }
            
        } catch (SQLException e) {
            errorStr = objAr.getaEmpno()+". 申請單"+ formno+"更新失敗";
            sendObj.setResultMsg("0");
            sendObj.setErrorMsg(errorStr);
            //有錯誤時rollback
            try {conn.rollback();} catch (SQLException e1) {}
            //System.out.print(new java.util.Date()+" 申請單"+formno+"更新失敗："+e.toString());    
//            ci.tool.WriteLog wl2 = new ci.tool.WriteLog("/apsource/csap/projfz/webap/Log/fzFormLogf.txt");
//            wl2.WriteFile(new java.util.Date()+"\t"+objAr.getaEmpno()+". 申請單"+formno+"更新失敗："+e.toString());
            
        }catch (Exception e) {            
            errorStr = objAr.getaEmpno()+". 申請單"+ formno+"更新失敗";
            sendObj.setResultMsg("0");
            sendObj.setErrorMsg(e.toString());
            //有錯誤時rollback
            try {conn.rollback();} catch (SQLException e1) {}
            //System.out.print(e.toString());    
//            ci.tool.WriteLog wl2 = new ci.tool.WriteLog("/apsource/csap/projfz/webap/Log/fzFormLogf.txt");
//            wl2.WriteFile(new java.util.Date()+"\t"+objAr.getaEmpno()+". 申請單"+formno+"更新失敗："+e.toString());    
        } finally {
            if ( rs != null ) try {
                rs.close();
            } catch (SQLException e) {}
            if ( pstmt != null ) try {
                pstmt.close();
            } catch (SQLException e) {}
            if ( conn != null ) try {
                conn.close();
            } catch (SQLException e) {}
    
        }
        return sendObj;
        
    }
   
    /*送出積點  換班單TPE*/
    public CrewMsgObj SendSwapCreditFormTPE(SendCrewSwapFormObj objAr,
            String asno,String rsno,String rcount,String rcomm){
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        Driver dbDriver = null;
        int formno = 0;
        String errorStr = "";
        try {
            sendObj = new CrewMsgObj();
            if(null != objAr && "".equals(objAr.getaEmpno())){
                //User connection pool to FZ
                ConnectionHelper ch = new ConnectionHelper();
                conn = ch.getConnection();  
                //有錯誤時rollback
                conn.setAutoCommit(false);
                //取得formno 2006/01/10 依申請月份取得單號
                pstmt = conn.prepareStatement("SELECT Nvl(Max(formno),'" + objAr.getYear()
                            + objAr.getMonth() + "0000')+1 newFormNo "
                            + "FROM fztbform WHERE substr(to_char(formno),1,6)=?");
                
                pstmt.setString(1 ,objAr.getYear() + objAr.getMonth());
                
                rs = pstmt.executeQuery();
                
                if ( rs.next() )
                {
                    formno = rs.getInt("newFormNo");
                }

                pstmt = null;
                            
                //先insert 申請單主table
                //sql = " INSERT INTO fztbform (formno,aempno,asern,acname,agroups,atimes,aqual,rempno,rsern,rcname,rgroups,rtimes,rqual,chg_all,aswaphr,rswaphr,aswapdiff,rswapdiff,apch,rpch,attlhr,rttlhr,overpay,over_hr,crew_comm,ed_check,comments,newuser,newdate,checkuser,checkdate,station,acount,acomm,rcount,rcomm) values ("+formno+",'"+aEmpno+"','"+aSern+"','"+aCname+"','"+aGrps+"',"+aApplyTimes+",'"+aQual+"','"+rEmpno+"','"+rSern+"','"+rCname+"','"+rGrps+"','"+rApplyTimes+"','"+rQual+"','N','"+aSwapHr+"','"+rSwapHr+"','"+aSwapDiff+"','"+rSwapDiff+"','"+aPrjcr+"','"+rPrjcr+"','"+aSwapCr+"','"+rSwapCr+"',null,null,'"+comments+"',null,null,'"+userid+"',sysdate,null,null,'TPE','N','"+asno+"','"+rcount+"','"+rcomm+"') ";
                sql = " INSERT INTO fzdb.fztbform (formno,aempno,asern,acname,agroups,atimes,aqual,rempno,rsern,rcname,rgroups,rtimes,rqual,chg_all,aswaphr,rswaphr,aswapdiff,rswapdiff,apch,rpch,attlhr,rttlhr,overpay,over_hr,crew_comm,ed_check,comments,newuser,newdate,checkuser,checkdate,station,acount,acomm,rcount,rcomm) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,null,null,?,null,null,?,sysdate,null,null,'TPE','N',?,?,?) ";

                pstmt = conn.prepareStatement(sql); 
                int j = 1;
                pstmt.setString(j++,objAr.getaEmpno());
                pstmt.setString(j++,objAr.getaSern());
                pstmt.setString(j++,objAr.getaCname());
                pstmt.setString(j++,objAr.getaGrps());
                pstmt.setString(j++,objAr.getaApplyTimes());
                pstmt.setString(j++,objAr.getaQual());
                pstmt.setString(j++,objAr.getrEmpno());
                pstmt.setString(j++,objAr.getrSern());
                pstmt.setString(j++,objAr.getrCname());
                pstmt.setString(j++,objAr.getrGrps());
                pstmt.setString(j++,objAr.getrApplyTimes());
                pstmt.setString(j++,objAr.getrQual());
                pstmt.setString(j++,"N");
                pstmt.setString(j++,objAr.getaSwapHr());
                pstmt.setString(j++,objAr.getrSwapHr());
                pstmt.setString(j++,objAr.getaSwapDiff());
                pstmt.setString(j++,objAr.getrSwapDiff());
                pstmt.setString(j++,objAr.getaPrjcr());
                pstmt.setString(j++,objAr.getrPrjcr());
                pstmt.setString(j++,objAr.getaSwapCr());
                pstmt.setString(j++,objAr.getrSwapCr());
                pstmt.setString(j++,objAr.getComments());
                pstmt.setString(j++,objAr.getaEmpno());//userid
                
                pstmt.setString(++j,asno);
                pstmt.setString(++j,rcount);
                pstmt.setString(++j,rcomm); 
                pstmt.executeUpdate();      
                pstmt.clearBatch();

                pstmt = null;
                //insert 申請單明細
                pstmt = conn.prepareStatement("insert INTO fzdb.fztbaply(formno,therole,empno,tripno,fdate,fltno,fly_hr,actp) "
                 +"VALUES ("+formno+",?,?,?,?,?,?,?)");

                if(objAr.getaFdate() != null){    
                    for(int i=0;i<objAr.getaFdate().length;i++){
                        pstmt.setString(1,"A");
                        pstmt.setString(2,objAr.getaEmpno());
                        pstmt.setString(3,objAr.getaTripno()[i]);
                        pstmt.setString(4,objAr.getaFdate()[i]);
                        pstmt.setString(5,objAr.getaFltno()[i]);
                        pstmt.setString(6,objAr.getaFlyHrs()[i]);
                        pstmt.addBatch();  
                    }
                    pstmt.executeBatch(); 
                }

                pstmt.clearBatch();
                if(objAr.getrFdate() != null){
                    for(int i=0;i<objAr.getrFdate().length;i++){
                        pstmt.setString(1,"R");
                        pstmt.setString(2,objAr.getrEmpno());
                        pstmt.setString(3,objAr.getrTripno()[i]);
                        pstmt.setString(4,objAr.getrFdate()[i]);
                        pstmt.setString(5,objAr.getrFltno()[i]);
                        pstmt.setString(6,objAr.getrFlyHrs()[i]);
                        pstmt.addBatch();
                    }
                    pstmt.executeBatch();
                }
                pstmt.clearBatch();
                
                pstmt = null;
                //remark formno for egtcrdt
                sql = "update egdb.egtcrdt set formno = ?, used_ind = 'Y', upduser = 'SYS', upddate = sysdate where (sno = ? or sno = ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1,formno);
                pstmt.setInt(2,Integer.parseInt(asno));
                pstmt.setInt(3,Integer.parseInt(rsno));
                pstmt.executeUpdate(); 

                conn.commit();
                //寫入log

//            fz.writeLog wl = new fz.writeLog();
//            wl.updLog(userid, request.getRemoteAddr(),request.getRemoteHost(), "FZ2851");
            }
        } catch (SQLException e) {
          //有錯誤時rollback
            try {conn.rollback();} catch (SQLException e1) {}
            errorStr = objAr.getaEmpno()+". 申請單"+formno+"更新失敗";
            sendObj.setResultMsg("0");
            sendObj.setErrorMsg(errorStr);            
            //System.out.print(new java.util.Date()+" 申請單"+formno+"更新失敗："+e.toString());
//            ci.tool.WriteLog wl2 = new ci.tool.WriteLog("/apsource/csap/projfz/webap/Log/fzFormLog.txt");
//            wl2.WriteFile(new java.util.Date()+"\t"+objAr.getaEmpno()+"\t 申請單"+formno+"更新失敗："+e.toString());
            
        } catch (Exception e) {
            //有錯誤時rollback
            try {conn.rollback();} catch (SQLException e1) {}
            errorStr = objAr.getaEmpno()+". 申請單"+formno+"更新失敗";
            sendObj.setResultMsg("0");
            sendObj.setErrorMsg(errorStr);
            //System.out.print(e.toString());
//            ci.tool.WriteLog wl2 = new ci.tool.WriteLog("/apsource/csap/projfz/webap/Log/fzFormLog.txt");
//            wl2.WriteFile(new java.util.Date()+"\t"+objAr.getaEmpno()+"\t 申請單"+formno+"更新失敗："+e.toString());
        } finally {
            if ( rs != null ) try {
                rs.close();
            } catch (SQLException e) {}
            if ( pstmt != null ) try {
                pstmt.close();
            } catch (SQLException e) {}
            if ( conn != null ) try {
                conn.close();
            } catch (SQLException e) {}

        }
        return  sendObj;
    }
    
    /*送出積點  換班單KHH*/
    public CrewMsgObj SendSwapCreditFormKHH(SendCrewSwapFormObj objAr,
            String asno,String rsno,String rcount,String rcomm){
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        Driver dbDriver = null;
        int formno = 0;
        boolean updFlag = false ;
        String errorStr = "";
        sendObj = new CrewMsgObj();
        try 
        {
            
            if(null != objAr && "".equals(objAr.getaEmpno())){
                ConnectionHelper ch = new ConnectionHelper();
                conn = ch.getConnection();  
                //有錯誤時rollback
                conn.setAutoCommit(false);
                //取得formno 2006/01/10 依申請月份取得單號
                sql = "SELECT Nvl(Max(formno),'" + objAr.getYear()
                        + objAr.getMonth() + "0000')+1 newFormNo "
                        + "FROM fztbformf WHERE substr(to_char(formno),1,6)=?";
                pstmt = conn.prepareStatement(sql);
                
                pstmt.setString(1 ,objAr.getYear() + objAr.getMonth());
                
                rs = pstmt.executeQuery();
                
                if ( rs.next() )
                {
                    formno = rs.getInt("newFormNo");
                }
    
                pstmt = null;
                            
                //先insert 申請單主table
                sql = " INSERT INTO fzdb.fztbformf (formno,aempno,asern,acname,agroups,atimes,aqual,rempno,rsern,rcname,rgroups,rtimes,rqual,chg_all,aswaphr,rswaphr,aswapdiff,rswapdiff,apch,rpch,attlhr,rttlhr,overpay,over_hr,crew_comm,ed_check,comments,newuser,newdate,checkuser,checkdate,station,acount,acomm,rcount,rcomm) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,null,null,?,null,null,?,sysdate,null,null,'KHH','N',?,?,?) ";
    
                pstmt = conn.prepareStatement(sql); 
                int j = 1;
                pstmt.setString(j++,objAr.getaEmpno());
                pstmt.setString(j++,objAr.getaSern());
                pstmt.setString(j++,objAr.getaCname());
                pstmt.setString(j++,objAr.getaGrps());
                pstmt.setString(j++,objAr.getaApplyTimes());
                pstmt.setString(j++,objAr.getaQual());
                pstmt.setString(j++,objAr.getrEmpno());
                pstmt.setString(j++,objAr.getrSern());
                pstmt.setString(j++,objAr.getrCname());
                pstmt.setString(j++,objAr.getrGrps());
                pstmt.setString(j++,objAr.getrApplyTimes());
                pstmt.setString(j++,objAr.getrQual());
                pstmt.setString(j++,"N");
                pstmt.setString(j++,objAr.getaSwapHr());
                pstmt.setString(j++,objAr.getrSwapHr());
                pstmt.setString(j++,objAr.getaSwapDiff());
                pstmt.setString(j++,objAr.getrSwapDiff());
                pstmt.setString(j++,objAr.getaPrjcr());
                pstmt.setString(j++,objAr.getrPrjcr());
                pstmt.setString(j++,objAr.getaSwapCr());
                pstmt.setString(j++,objAr.getrSwapCr());
                pstmt.setString(j++,objAr.getComments());
                pstmt.setString(j++,objAr.getaEmpno());//userid
                
                pstmt.setString(++j,asno);
                pstmt.setString(++j,rcount);
                pstmt.setString(++j,rcomm); 
                pstmt.executeUpdate();      
                pstmt.clearBatch();
    
                pstmt = null;
                //insert 申請單明細
                pstmt = conn.prepareStatement("insert INTO fzdb.fztbaplyf(formno,therole,empno,tripno,fdate,fltno,fly_hr) "
                 +"VALUES ("+formno+",?,?,?,?,?,?)");
    
                if(objAr.getaFdate() != null){    
                    for(int i=0;i<objAr.getaFdate().length;i++){
                        pstmt.setString(1,"A");
                        pstmt.setString(2,objAr.getaEmpno());
                        pstmt.setString(3,objAr.getaTripno()[i]);
                        pstmt.setString(4,objAr.getaFdate()[i]);
                        pstmt.setString(5,objAr.getaFltno()[i]);
                        pstmt.setString(6,objAr.getaFlyHrs()[i]);
                        pstmt.addBatch();  
                    }
                    pstmt.executeBatch(); 
                }
    
                pstmt.clearBatch();
                if(objAr.getrFdate() != null){
                    for(int i=0;i<objAr.getrFdate().length;i++){
                        pstmt.setString(1,"R");
                        pstmt.setString(2,objAr.getrEmpno());
                        pstmt.setString(3,objAr.getrTripno()[i]);
                        pstmt.setString(4,objAr.getrFdate()[i]);
                        pstmt.setString(5,objAr.getrFltno()[i]);
                        pstmt.setString(6,objAr.getrFlyHrs()[i]);
                        pstmt.addBatch();
                    }
                    pstmt.executeBatch();
                }
                pstmt.clearBatch();
                
                pstmt = null;
                //remark formno for egtcrdt
                sql = "update egdb.egtcrdt set formno = ?, used_ind = 'Y', upduser = 'SYS', upddate = sysdate where (sno = ? )";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1,formno);
                pstmt.setInt(2,Integer.parseInt(asno));
                pstmt.executeUpdate(); 
    
                conn.commit();
                //寫入log
//                fz.writeLog wl = new fz.writeLog();
//                wl.updLog(userid, request.getRemoteAddr(),request.getRemoteHost(), "FZ285K");
            } 
        }
        catch (SQLException e) 
        {
            //有錯誤時rollback
            try {conn.rollback();} catch (SQLException e1) {}
            errorStr += objAr.getaEmpno()+". 申請單"+formno+"更新失敗";
            sendObj.setResultMsg("0");
            sendObj.setErrorMsg(errorStr);
//              System.out.print(new java.util.Date()+" 申請單"+formno+"更新失敗："+e.toString());
//              ci.tool.WriteLog wl2 = new ci.tool.WriteLog("/apsource/csap/projfz/webap/Log/fzFormLogf.txt");
//              wl2.WriteFile(new java.util.Date()+"\t"+objAr.getaEmpno()+"\t 積點申請單"+formno+"更新失敗："+e.toString());
            
        } catch (Exception e) {
            //有錯誤時rollback
            try {conn.rollback();} catch (SQLException e1) {}
            errorStr += objAr.getaEmpno()+". 申請單"+formno+"更新失敗";
            sendObj.setResultMsg("0");
            sendObj.setErrorMsg(errorStr);            
//                System.out.print(e.toString());
//                ci.tool.WriteLog wl2 = new ci.tool.WriteLog("/apsource/csap/projfz/webap/Log/fzFormLogf.txt");
//                wl2.WriteFile(new java.util.Date()+"\t"+objAr.getaEmpno()+"\t 積點申請單"+formno+"更新失敗："+e.toString());
        } finally {
            if ( rs != null ) try {
                rs.close();
            } catch (SQLException e) {}
            if ( pstmt != null ) try {
                pstmt.close();
            } catch (SQLException e) {}
            if ( conn != null ) try {
                conn.close();
            } catch (SQLException e) {}

        }
        return  sendObj;
    }
}

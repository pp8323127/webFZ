package ws;
import javax.jws.*;

import ws.MsgFromGrd.*;
import ws.header.*;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import ci.db.ConnectionHelper;
import fzAuthP.*;

@WebService(serviceName = "LoginService")
@HandlerChain(file = "prac/ReportListMain_handler.xml")
public class LoginApp {

    /**
     * @param args
     */
    public LoginAppObj auth = null;
//    public static void main(String[] args) {
//        // TODO Auto-generated method stub
//    LoginApp lg = new LoginApp();
//        lg.Authentication("631255", "PEI810229");
//    lg.getHRdetail("624851");
//        System.out.println(lg.auth.getCode() + "//" + lg.auth.getMessage());
//      System.out.println(lg.auth.getHrObj().getEmployid());
//      System.out.println(lg.auth.getHrObj().getCname());
//      System.out.println(lg.auth.getHrObj().getPostcd());
    
//    }
    
    public LoginAppObj Authentication(String userid,String password,String sysPwd){
        boolean wsAuth = true;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        if(wsAuth){
            auth = new LoginAppObj();//xml return
            UserID uid;
            CheckHR ckHR;
            CheckFZUser ckFZUsr;
            CheckEIP ckEIP;
            CheckFZCrew ckCrew;
            /****************/
    //      設定帳號密碼
            try {
//                DESede d = new DESede();      
//                password = d.decryptProperty("password");
                
                // 設定帳號密碼
                uid = new UserID(userid, password);
                
                // check HR
                ckHR = new CheckHR();
    //          auth.setHrObj(ckHR.getHrObj());         //權限顯示--暫註解
                
                // check fzuser
                ckFZUsr = new CheckFZUser();
            
                // check eip
                ckEIP = null;
    
                // check fzcrew
                ckCrew = new CheckFZCrew();
                
                
                // 無帳號密碼
                if (userid == null | password == null | "".equals(userid) | "".equals(password)) {
                    auth.setCode("2");
                    auth.setResult(false);
                    auth.setMessage("NO ID or PW");
                }
                // Check Crew
                else if (ckCrew.isFZCrew()) {
                    if (ckFZUsr.isHasFZAccount()) {
                        if (ckFZUsr.isFZUser()) {
                            // login success
                            auth.setCode("1");
                            auth.setResult(true);
                            auth.setMessage("Crew Login Successful");
    //                      setFzCrewObj(ckCrew.getFzCrewObj());
                        } else {
                            // password error.
                            auth.setCode("2");
                            auth.setResult(false);
                            auth.setMessage("password error");
                        }
                        //FZT 失敗 ,則chk EIP
                        if(!"1".equals(auth.getCode())){
                            ckEIP = new CheckEIP(userid, password);
                            if (ckEIP.isPassEIP()) {
                                auth.setCode("1");
                                auth.setResult(true);
                                auth.setMessage("Crew Login Successful");
                            }else{
                             // password error.
                                auth.setCode("2");
                                auth.setResult(false);
                                auth.setMessage("password error");
                            }
                        }
                    } else {// Crew無fztuser帳號
                        auth.setCode("3");
                        auth.setResult(false);
                        auth.setMessage("ID not find");
                    }
                    //Eip & FZT 皆可登入
                    if(!"1".equals(auth.getCode())){                  
                        if ("Y".equals(ckHR.getHrObj().getExstflg())) {             
                            ckEIP = new CheckEIP(userid, password);
                            if (ckEIP.isPassEIP()) {
                                // login success
                                auth.setCode("7");
                                auth.setResult(true);
                                auth.setMessage("EIP Login Successful");
                            } else {
                                // password error(eip)
                                auth.setCode("8");
                                auth.setResult(false);
                                auth.setMessage("password error.");
                            }
                        }else{
                            auth.setCode("9");
                            auth.setResult(false);
                            auth.setMessage("Not find data of HR.");
                        }  
                    } 
                }   
                // Eip在職,但非後艙組員
                else if ("Y".equals(ckHR.getHrObj().getExstflg()) && !"200".equals(ckHR.getHrObj().getAnalysa())) {             
                    ckEIP = new CheckEIP(userid, password);
                    if (ckEIP.isPassEIP()) {
                        // login success
                        auth.setCode("4");
                        auth.setResult(true);
                        auth.setMessage("EIP Login Successful");
                    } else {
                        // password error(eip)
                        auth.setCode("5");
                        auth.setResult(false);
                        auth.setMessage("EIP password error");
                    }
                }else{
                    auth.setCode("6");
                    auth.setResult(false);
                    auth.setMessage("Not find data of HR.");
                }       
            } catch (NullPointerException e) {
                // 未initial UserID
                // out.println("缺少帳號密碼,請重新輸入");
                auth.setCode("0");
                auth.setResult(false);
                auth.setMessage("Login NullPointerException :" + e.toString());
    //          System.out.println("Login NullPointerException :" + e.toString());
            } catch (Exception e) {
                auth.setCode("0");
                auth.setResult(false);
                auth.setMessage("Login Exception :" + e.toString());
    //          System.out.println("Login Exception :" + e.toString());
            }   
        }else{
            auth = new LoginAppObj();//xml return
            auth.setCode("0");
            auth.setResult(false);
            auth.setMessage("Login - ws Auth failed.");
        }
        return auth;              
    }
    
    
    public LoginAppObj Authentication2(String userid,String password,String gCode,String sysPwd){
        boolean wsAuth = true;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        if(null==gCode || "".equals(gCode)){
            gCode = "0";
        }
        if(wsAuth){
            auth = new LoginAppObj();//xml return
            UserID uid;
            CheckHR ckHR;
            CheckFZUser ckFZUsr;
            CheckEIP ckEIP;
            CheckFZCrew ckCrew;
            /****************/
    //      設定帳號密碼
            try {
//                DESede d = new DESede();      
//                password = d.decryptProperty("password");
                
                // 設定帳號密碼
                uid = new UserID(userid, password);
                
                // check HR
                ckHR = new CheckHR();
    //          auth.setHrObj(ckHR.getHrObj());         //權限顯示--暫註解
                
                // check fzuser
                ckFZUsr = new CheckFZUser();
            
                // check eip
                ckEIP = null;
    
                // check fzcrew
                ckCrew = new CheckFZCrew();
                
                
                // 無帳號密碼
                if (userid == null | password == null | "".equals(userid) | "".equals(password)) {
                    auth.setCode("2");
                    auth.setResult(false);
                    auth.setMessage("NO ID or PW");
                }
                // Check Crew
                else if (ckCrew.isFZCrew()) {
                    if (ckFZUsr.isHasFZAccount()) {
                        if (ckFZUsr.isFZUser()) {
                            // login success
                            auth.setCode("1");
                            auth.setResult(true);
                            auth.setMessage("Crew Login Successful");
                            if(Integer.parseInt(gCode)==1){    
                                LoginAppObj obj2 = getHRdetail(userid);
                                if(null!=obj2 && (null == obj2.getMessage() ||"".equals(obj2.getMessage()))){
                                    auth.setEmployid(obj2.getEmployid());
                                    auth.setCname(obj2.getCname());
                                    auth.setEname(obj2.getEname());
                                    auth.setEmail(obj2.getEmail());
                                    auth.setSitacode(obj2.getSitacode());
                                }else{
                                    auth.setMessage("Crew Login Successful ,but no found HR detail."+obj2.getMessage());
                                }
                            }
    //                      setFzCrewObj(ckCrew.getFzCrewObj());
                        } else {
                            // password error.
                            auth.setCode("2");
                            auth.setResult(false);
                            auth.setMessage("password error");
                        }
                    } else {// Crew無fztuser帳號
                        auth.setCode("3");
                        auth.setResult(false);
                        auth.setMessage("ID not find");
                    }
                }   
                // Eip在職,但非後艙組員
                else if ("Y".equals(ckHR.getHrObj().getExstflg()) && !"200".equals(ckHR.getHrObj().getAnalysa())) {             
                    ckEIP = new CheckEIP(userid, password);
                    if (ckEIP.isPassEIP()) {
                        // login success
                        auth.setCode("4");
                        auth.setResult(true);
                        auth.setMessage("EIP Login Successful");
                        if(Integer.parseInt(gCode)==1){    
                            LoginAppObj obj2 = getHRdetail(userid);
                            if(null!=obj2 && (null == obj2.getMessage() ||"".equals(obj2.getMessage()))){
                                auth.setEmployid(obj2.getEmployid());
                                auth.setCname(obj2.getCname());
                                auth.setEname(obj2.getEname());
                                auth.setEmail(obj2.getEmail());
                                auth.setSitacode(obj2.getSitacode());
                            }else{
                                auth.setMessage("Crew Login Successful ,but not found HR detail."+obj2.getMessage());
                            }
                        }
                    } else {
                        // password error(eip)
                        auth.setCode("5");
                        auth.setResult(false);
                        auth.setMessage("EIP password error");
                    }
                }else{
                    auth.setCode("6");
                    auth.setResult(false);
                    auth.setMessage("Not find data of HR.");
                }       
            } catch (NullPointerException e) {
                // 未initial UserID
                // out.println("缺少帳號密碼,請重新輸入");
                auth.setCode("0");
                auth.setResult(false);
                auth.setMessage("Login NullPointerException :" + e.toString());
    //          System.out.println("Login NullPointerException :" + e.toString());
            } catch (Exception e) {
                auth.setCode("0");
                auth.setResult(false);
                auth.setMessage("Login Exception :" + e.toString());
    //          System.out.println("Login Exception :" + e.toString());
            }   
        }else{
            auth = new LoginAppObj();//xml return
            auth.setCode("0");
            auth.setResult(false);
            auth.setMessage("Login - ws Auth failed."+sysPwd);
        }
        return auth;    
          
    }
    private LoginAppObj getHRdetail(String empn){
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;     
        String sql = null;
        LoginAppObj obj = null;
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
            sql = "SELECT employid," +
                " cname,ename," +
                " Decode(sitacode, NULL, 'N/A', sitacode) sitacode," +
                " Decode(email, NULL, employid || '@cal.aero', email) email," +
                " Decode(email, null, 'N', 'Y') gotemail  FROM hrvegsitacd" +
                " where employid = '"+empn+"'" +
                " ORDER BY gotemail desc, sitacode";
            rs = stmt.executeQuery(sql);
            if(rs.next()){
                obj = new LoginAppObj();
                obj.setEmployid(rs.getString("employid"));
                obj.setCname(rs.getString("cname"));
                obj.setEname(rs.getString("ename"));
                obj.setEmail(rs.getString("email"));
                obj.setSitacode(rs.getString("sitacode"));             
            }else{
                obj = new LoginAppObj();
                obj.setMessage("Test DB.");
            }
        }
        catch ( Exception e )
        {
            obj = new LoginAppObj();
            obj.setMessage(e.toString());
        }
        finally {
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
        return obj;
    }
}

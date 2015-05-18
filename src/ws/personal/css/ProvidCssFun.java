package ws.personal.css;

import java.sql.*;
import java.util.*;

import ws.personal.*;
import ws.prac.*;

import ci.db.*;

public class ProvidCssFun
{

    /**
     * @param args cs80 Cabin iService (II)
     * 回傳MVC & CSS內容 
     */
    
    private ProvidCssRObj proCssAL = null;
  private  String sysurl = "test"; // test,live
//  private  String sysurl = "live";
    
    public static void main(String[] args)
    {
        // TODO Auto-generated method stub
        InputCusObj[] cusAr = new InputCusObj[1];//{"WA7041003","CA0360270","WD1201116",};
        InputCusObj cus = new InputCusObj();
        cus.setCardNo("WA7041003");
        cusAr[0] = cus;
        String[] cardNO = {"WA7041003","CA0360270","WD1201116",};
        String[] cusId = {"XX"};
        String rank = "CM";//MC,PR,FA
        ProvidCssFun css = new ProvidCssFun();
        css.ProvideCss(cusAr,rank);
        

    }
   
    
    public void ProvideCss(InputCusObj[] cus ,String rank) {//mapping 卡號及顧客號碼
        proCssAL = new ProvidCssRObj();
        boolean flag = false;
        String ruleSql = "";
        String cardNoSql = "";
        //String cusIdSql = "and card_no in('')";//顧客號碼
        //參數驗證
        if(null==rank || "".equals(rank)){
            flag = false;
            proCssAL.setResultMsg("0");
            proCssAL.setErrorMsg("無職等,無法查詢.");
        }
//        else if((null==cus[0].getCardNo() || "".equals(cus[0].getCardNo())) ){//&& (null==customerId[0] || "".equals(customerId[0]))
//            flag = false;
//            proCssAL.setResultMsg("0");
//            proCssAL.setErrorMsg("請填入資料");
//        }
        else{
            flag = true;
        }
        //條件篩選
        if(flag && !"".equals(rank)){
            flag = true;
            if("CM".equals(rank) || "MC".equals(rank) || "MP".equals(rank) || "PR".equals(rank) ){
                //全部可查
            }else{
                flag = false;
                proCssAL.setResultMsg("0");
                proCssAL.setErrorMsg("無授權.");
            }
            
        }
//        if(flag && null!=cus && cus.length >0){            
//            flag = true;
//            cardNoSql +=  "and card_no in(";
//            for(int i=0 ;i<cus.length;i++){
//                if(i==0){
//                    cardNoSql +=  "'"+ cus[i].getCardNo() +"'";
//                }else{
//                    cardNoSql +=  ",'"+ cus[i].getCardNo() +"'";
//                }                
//            }
//            cardNoSql +=  ")";            
//        }else{
//            cardNoSql = "and card_no in('')";
//        }
        /*if(flag && null!=customerId && customerId.length>0){
            flag = true;            
        }*/
//        System.out.println(cardNoSql+cusIdSql );
        //
        if(flag){
            Driver dbDriver = null;
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            String sql = null;
            ArrayList<ProvidCssObj> providCssAL = new ArrayList<ProvidCssObj>();
            
            try {

//                ConnectionHelper ch = new ConnectionHelper();
//                conn = ch.getConnection();
//                stmt = conn.createStatement();
                
                ConnDB cn = new ConnDB();
                cn.setORP3EGUserCP();
                dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
                conn = dbDriver.connect(cn.getConnURL(), null);
                stmt = conn.createStatement();
                
                sql = "select caseno,REOPEN,PETITION_DATE,CARD_NO,DESCRIPTION, " +
                	  " FLIGHT_DATE,FLIGHT_NO,ORIGIN,DESTINATION,CLASS,SEAT_NO," +
                	  " OCCURRENCE_STATION,C_NAME,E_NAME,BIRTH_DATE,SEX,EMAIL, " +
                	  " CELPHN,H_PHONE,ADDR1,S_CASE,CATEGORY,DEPT,REF_STN,HANDLER, " +
                	  " STATUS,ACTION_TAKEN from cps_eg_rd_v " +
                	  " where substr(trim(caseno),1,4) = to_char(sysdate,'yyyy')" +
                	  " and category IN ('Complaint','Compliment','Assistance','Suggestion')" +
                	  "  and card_no in ('WA5527361','CA0360270','WD1201116' )and rownum <= 10";
               
                rs = stmt.executeQuery(sql);
                
               
                while (rs.next())
                {
                    ProvidCssObj cssObj = new ProvidCssObj();
//                    System.out.println(rs.getString("caseno"));
//                    cssObj.setCaseNo(rs.getString("caseno"));//                    
                    //cssObj.setReopen(rs.getString("REOPEN"));
                    cssObj.setPetitionDate(rs.getString("PETITION_DATE"));  
//                    cssObj.setFltDate(rs.getString("FLIGHT_DATE"));
//                    cssObj.setFltno(rs.getString("FLIGHT_NO"));
//                    cssObj.setDep(rs.getString("ORIGIN"));
//                    cssObj.setArr(rs.getString("DESTINATION"));
//                    cssObj.setClassTp(rs.getString("CLASS"));
//                    cssObj.setSeat(rs.getString("SEAT_NO"));               
                    cssObj.setOccurrenceStat(rs.getString("OCCURRENCE_STATION"));
//                    cssObj.setcName(rs.getString("C_NAME"));
//                    cssObj.seteName(rs.getString("E_NAME"));
//                    cssObj.setBirthDt(rs.getString("BIRTH_DATE"));
//                    cssObj.setSex(rs.getString("SEX"));
//                    cssObj.setEmail(rs.getString("EMAIL"));
//                    cssObj.setCelPhn(rs.getString("CELPHN"));
//                    cssObj.setHomePhn(rs.getString("H_PHONE"));
//                    cssObj.setAddr1(rs.getString("ADDR1"));                
                    cssObj.setsCase(rs.getString("S_CASE"));
//                    cssObj.setDept(rs.getString("DEPT"));
//                    cssObj.setRefStn(rs.getString("REF_STN"));
//                    cssObj.setHandler(rs.getString("HANDLER"));
//                    cssObj.setStatus(rs.getString("STATUS"));
                    cssObj.setCardNo(rs.getString("CARD_NO"));
                    cssObj.setCategory(rs.getString("CATEGORY"));
                    cssObj.setDesc(rs.getString("DESCRIPTION"));
                    cssObj.setActionTaken(rs.getString("action_taken"));
   
                    providCssAL.add(cssObj);
                }
                
                if(null != providCssAL && providCssAL.size() > 0){
                    ProvidCssObj[] array = new ProvidCssObj[providCssAL.size()];
                    for(int i=0; i<providCssAL.size();i++){
                         array[i] = (ProvidCssObj) providCssAL.get(i);
//                        System.out.println(array[i].getCardNo());
                    }
                    proCssAL.setProCssArr(array);
                    proCssAL.setResultMsg("1");
                    proCssAL.setErrorMsg("Done.");
                    
                }else{
                    proCssAL.setResultMsg("2");
                    proCssAL.setErrorMsg("No data!");
                }
                
                          
            } catch (Exception e) {
                proCssAL.setResultMsg("0");
                proCssAL.setErrorMsg("Excep Css: "+ e.toString());
            } finally {
//                System.out.println(proCssAL.getErrorMsg());
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
        
    }
    public ProvidCssRObj getProCssAL()
    {
        return proCssAL;
    }
    public void setProCssAL(ProvidCssRObj proCssAL)
    {
        this.proCssAL = proCssAL;
    }
}

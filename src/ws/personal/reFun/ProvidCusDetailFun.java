package ws.personal.reFun;

import java.sql.*;
import java.util.*;

import ws.personal.*;
import ws.personal.css.*;
import ws.personal.mvc.*;
import ci.db.*;



/**
 * @author 643937 Created on  2014/5/22
 * 
 * live test 上傳需要切換 sysurl
 * 
 */
public class ProvidCusDetailFun
{
    
    private CusDetailRObj proCusAL = null;
    private  String sysurl = "test"; // test,live
//    private  String sysurl = "live"; 
    
    
    
//    private CusOthersObj[] cusOthersArr = null;
    private ArrayList otherAL = new ArrayList();
    private CusReqObj cusReq= null;
    private CusMileObj cusMile = null;
    private CusSpecReqObj[] cusSpecReqArr = null;
    
    
    private CusItemsRObj cusItemAL = null;
    public static void main(String[] args)
    {
        // TODO Auto-generated method stub
        InputCusObj[] cusAr = new InputCusObj[1];//{"WA7041003","CA0360270","WD1201116",};
        String[] cardNumAr = {"CT0614417"};
        String cardno = "CT0614417";// WA9398248,WA7041003
        //CT3666104 spew
        ProvidCusDetailFun f1 = new ProvidCusDetailFun();
        f1.ProvideCus(cardNumAr, "CM");
//        System.out.println(f1.getSpew(cardno));
//        f1.AllOption();
//        System.out.println(f1.getMvcReq_Spew(cardno));
//        ProvidCusFun f = new ProvidCusFun();
//        System.out.println(f.getMvcReq(cardno).getBeverage().length + "///" +f.getErrorstr().size());
//        System.out.println(f.getCrmSpecReq(cardno));
//        f.getCusSuggCRM(cardno);
//        System.out.println(f.getCrmMile(cardno).getCurreffMil());
        
        //
//        f.getCusDataCRM("'"+cardno+"'");
//        cus[0].setCardNo("AA0001675");
//        f.ProvideCusMvcCss(cusAr);
        
    }
    
    public CusItemsRObj AllOption(){
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        String sql = null;
           
        cusItemAL = new CusItemsRObj();
        String result = "";
        ArrayList objAL = new ArrayList();
        CusItemsObj obj  = null;
        try
        {
            DB2Conn cn = new DB2Conn();
//            cn.setDB2UserTcrm();
//            cn.setDB2UserPcrm();
//            java.lang.Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
//            stmt = conn.createStatement();  
      
            cn.setDB2crmCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            stmt = conn.createStatement();
            
//          ******************************************************************************   
            sql = "select CODE,DESCRIPTION,TYPE from CAL.ITVBIBH where Rtrim(type) in ( 'S','B','G','N') order by type,code ";
           
            rs = stmt.executeQuery(sql);
            while (rs.next())
            {   
                
               obj  = new CusItemsObj();
               obj.setCode(rs.getString("CODE"));
               obj.setItem(rs.getString("DESCRIPTION"));
               obj.setType(rs.getString("TYPE"));
               objAL.add(obj);
               
            }
            if("test".equals(sysurl)){
               for(int k=0;k < 50;k++){
                   obj  = new CusItemsObj();
                   obj.setCode("B0"+k);
                   obj.setItem("紅酒"+k);
                   obj.setType("B");
                   objAL.add(obj);
               }
               for(int k=0;k < 50;k++){
                   obj  = new CusItemsObj();
                   obj.setCode("N0"+k);
                   obj.setItem("報紙"+k);
                   obj.setType("N");
                   objAL.add(obj);
               }
               for(int k=0;k < 50;k++){
                   obj  = new CusItemsObj();
                   obj.setCode("G0"+k);
                   obj.setItem("雜誌"+k);
                   obj.setType("G");
                   objAL.add(obj);
               }
            }
           //1/Must","2/Nice to Have","3/Option
            obj  = new CusItemsObj();
            obj.setCode("1");
            obj.setItem("Must");
            obj.setType("S1");
            objAL.add(obj);
            
            obj  = new CusItemsObj();
            obj.setCode("2");
            obj.setItem("Nice to Have");
            obj.setType("S1");
            objAL.add(obj);
            
            obj  = new CusItemsObj();
            obj.setCode("3");
            obj.setItem("Option");
            obj.setType("S1");
            objAL.add(obj);
            //"1/Every Time","2/Periodically","3/One Time"
            obj  = new CusItemsObj();
            obj.setCode("1");
            obj.setItem("Every Time");
            obj.setType("S2");
            objAL.add(obj);
            
            obj  = new CusItemsObj();
            obj.setCode("2");
            obj.setItem("Periodically");
            obj.setType("S2");
            objAL.add(obj);
            
            obj  = new CusItemsObj();
            obj.setCode("3");
            obj.setItem("One Time");
            obj.setType("S2");
            objAL.add(obj);
            //"報到櫃台","登機門口","客艙"
            obj  = new CusItemsObj();
            obj.setCode("報到櫃台");
            obj.setItem("報到櫃台");
            obj.setType("S3");
            objAL.add(obj);
            
            obj  = new CusItemsObj();
            obj.setCode("登機門口");
            obj.setItem("登機門口");
            obj.setType("S3");
            objAL.add(obj);
            
            obj  = new CusItemsObj();
            obj.setCode("客艙");
            obj.setItem("客艙");
            obj.setType("S3");
            objAL.add(obj);
            
            
            if(null!=objAL && objAL.size()>0){
                CusItemsObj[] array = new CusItemsObj[objAL.size()];
                for(int i=0 ;i<objAL.size();i++){
                    array[i] = (CusItemsObj) objAL.get(i);
                }
                cusItemAL.setOption(array);
                cusItemAL.setErrorMsg("1");
                cusItemAL.setResultMsg("Done");
            }else{
                cusItemAL.setErrorMsg("1");
                cusItemAL.setResultMsg("No Data");                
            }
            
           
        //******************************************************************************
        }
        catch ( Exception e )
        {
            cusItemAL.setErrorMsg("0");
            cusItemAL.setResultMsg(e.toString());
//            System.out.println(e.toString());           
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
        return cusItemAL;
        
    }
    
    public void ProvideCus(String[] cardNumAr ,String rank) {//mapping 卡號及顧客號碼
        proCusAL = new CusDetailRObj();
        boolean flag = false;
        String ruleSql = "";
        String cardNoSql = "";
        String errorStr = "";
        //String cusIdSql = "and card_no in('')";//顧客號碼
        //參數驗證
        if(null==rank || "".equals(rank)){
            flag = false;
            proCusAL.setResultMsg("0");
            proCusAL.setErrorMsg("無職等,無法查詢.");
        }
        else if("".equals(cardNumAr[0]) ){
            flag = false;
            proCusAL.setResultMsg("0");
            proCusAL.setErrorMsg("請填入卡號/顧客ID");
        }
        else{
            flag = true;
        }
        //條件篩選
        if(flag && !"".equals(rank)){
            
            if("CM".equals(rank) || "MC".equals(rank) || "MP".equals(rank) || "PR".equals(rank) ){
                //可查
                flag = true;
            }else{
                flag = false;
                proCusAL.setResultMsg("0");
                proCusAL.setErrorMsg("此帳號未被授權查詢顧客基本資料.");
            }
            
        }
        if(flag){
            Driver dbDriver = null;
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            String sql = null;
            ArrayList<ProvidCssObj> objAL = new ArrayList<ProvidCssObj>();
            ArrayList<ProvidPerObj> objAL2 = new ArrayList<ProvidPerObj>();
            
            ProvidCssObj cssObj = null;
            ProvidPerObj perObj = null;
            
            ProvidCssObj[] array = null;
            ProvidPerObj[] array2 = null;
            try {

//                ConnectionHelper ch = new ConnectionHelper();
//                conn = ch.getConnection();
//                stmt = conn.createStatement();
                
                ConnDB cn = new ConnDB();
                cn.setCRMUserCP();    
                dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
                conn = dbDriver.connect(cn.getConnURL(), null);
                stmt = conn.createStatement();                
                //****CSS***************  
                if("live".equals(sysurl)){ 
                    //CRM 
                    if("XX123456".equals(cardNumAr[0])){
                        String test[] = {"XX123456","WA6324412","WB4935240","WA5527361","AH0000088","WA7041003"};
                        cardNumAr = test;
                    }
                }
                else if ("test".equals(sysurl))
                {
                    cssObj = new ProvidCssObj();
                    cssObj.setCardNo("WA6324412"); // WA6324412
                    cssObj.setPetitionDate("2014-01-25 00:00:00.0");
                    cssObj.setCategory("Complaint");
                    cssObj.setDesc("餐點未熱,導致身體不適");
                    cssObj.setOccurrenceStat("INFLT");
                    cssObj.setsCase("Y");
                    cssObj.setActionTaken("折扣券");
                    objAL.add(cssObj);

                    cssObj = new ProvidCssObj();
                    cssObj.setCardNo("WA6324412"); // WA6324412
                    cssObj.setPetitionDate("2014-02-25 00:00:00.0");
                    cssObj.setCategory("Complaint");
                    cssObj.setDesc("組員服務,口氣不佳");
                    cssObj.setOccurrenceStat("INFLT");
                    cssObj.setsCase("Y");
                    cssObj.setActionTaken("");
                    objAL.add(cssObj);

                    cssObj = new ProvidCssObj();
                    cssObj.setCardNo("WA6324412"); // WA6324412
                    cssObj.setPetitionDate("2014-03-25 00:00:00.0");
                    cssObj.setCategory("Suggestion");
                    cssObj.setDesc("提供充電插座");
                    cssObj.setOccurrenceStat("INFLT");
                    cssObj.setActionTaken("");
                    objAL.add(cssObj);

                    cssObj = new ProvidCssObj();
                    cssObj.setCardNo("WA6324412"); // WA6324412
                    cssObj.setPetitionDate("2014-03-25 00:00:00.0");
                    cssObj.setCategory("Compliment");
                    cssObj.setDesc("服務非常棒");
                    cssObj.setOccurrenceStat("INFLT");
                    cssObj.setActionTaken("");
                    objAL.add(cssObj);

                    cssObj = new ProvidCssObj();
                    cssObj.setCardNo("WA6324412"); // WA6324412
                    cssObj.setPetitionDate("2014-03-25 00:00:00.0");
                    cssObj.setCategory("Assistance");
                    cssObj.setDesc("plz be regret to infm tht neg found the itm.");
                    cssObj.setOccurrenceStat("INFLT");
                    cssObj.setActionTaken("");
                    objAL.add(cssObj);
                    
                    cssObj = new ProvidCssObj();
                    cssObj.setCardNo("WA6324412"); // WA6324412
                    cssObj.setPetitionDate("2013-03-25 00:00:00.0");
                    cssObj.setCategory("Assistance");
                    cssObj.setDesc("手機遺落在機上,紅色HTC.");
                    cssObj.setOccurrenceStat("INFLT");
                    cssObj.setActionTaken("");
                    objAL.add(cssObj);
                    
                    cssObj = new ProvidCssObj();
                    cssObj.setCardNo("CT0614417"); // WA6324412
                    cssObj.setPetitionDate("2014-01-25 00:00:00.0");
                    cssObj.setCategory("Complaint");
                    cssObj.setDesc("餐點未熱,導致身體不適");
                    cssObj.setOccurrenceStat("INFLT");
                    cssObj.setsCase("Y");
                    cssObj.setActionTaken("折扣券");
                    objAL.add(cssObj);

                    if (null != objAL && objAL.size() > 0)
                    {
                        array = new ProvidCssObj[objAL.size()];
                        for (int i = 0; i < objAL.size(); i++)
                        {
                            array[i] = (ProvidCssObj) objAL.get(i);
                            // System.out.println(array[i].getCardNo());
                        }
                        proCusAL.setCssArr(array);
                    }
                }// end else if
                for (int j = 0; j < cardNumAr.length; j++) {
                    sql =" SELECT * "+
                    " FROM (SELECT c.*,ROW_NUMBER() OVER(PARTITION BY category Order by inpdate desc) as rank10 "+//  --各類別取10筆 
                    "         FROM (SELECT * "+
                    "             FROM (SELECT b.*,ROW_NUMBER() OVER(PARTITION BY caseno Order by reopen desc) as rank "+  //--取reopen 最後1版  
                    "                 FROM (SELECT DISTINCT "+
                    "                            reopen,reasonno,caseno,s_case, "+
                    "                            category,occurrence_station, "+
                    "                            description,opinion_of_examiner action_taken, "+
                    "                            inpdate,card_no,c_name,e_name,birth_date,sex,PETITION_DATE "+
                    "                     FROM cps_egcss_v@p4demo "+
                    "                     WHERE  caseno IN (SELECT case_no|| ' '  "+
                    "                                       FROM   cps_egcss_v2@p4demo "+
                    "                                       WHERE  card_no = '"+cardNumAr[j]+"')  "+                                           
                    "                       AND  ADD_MONTHS(inpdate, 24) >= SYSDATE "+
                    "                       AND  category IN ('Complaint','Compliment','Assistance','Suggestion') "+
                    "                     UNION  "+
                    "                     SELECT DISTINCT "+
                    "                            reopen,reasonno,caseno,s_case, "+
                    "                            CASE WHEN a.category = 'Reopen' THEN "+
                    "                                      (SELECT DISTINCT d.category FROM cps_egcss_v@p4demo d "+
                    "                                       WHERE  d.caseno = a.caseno "+
                    "                                         AND (d.reopen IS NULL OR d.reopen = ' ')) "+
                    "                                 ELSE a.category "+
                    "                            END category, "+
                    "                            occurrence_station, "+
                    "                            description,opinion_of_examiner action_taken, "+
                    "                            inpdate,card_no,c_name,e_name,birth_date,sex,PETITION_DATE  "+
                    "                     FROM cps_egcss_v@p4demo a "+
                    "                     WHERE caseno IN (  "+
                    "                                 SELECT caseno FROM cps_egcss_v@p4demo "+   
                    "                                 WHERE  caseno IN (SELECT case_no|| ' ' "+
                    "                                                   FROM   cps_egcss_v2@p4demo "+
                    "                                                   WHERE  card_no = '"+cardNumAr[j]+"')  "+                                          
                    "                                   AND  ADD_MONTHS(inpdate, 24) >= SYSDATE "+
                    "                                   AND  category IN ('Reopen')   "+
                    "                                 )) b ) "+
                    "         WHERE rank = 1 ) c ) "+
                    "     WHERE rank10 <= 10   ";
                            
                     rs = stmt.executeQuery(sql);
                     
                     while (rs.next())
                     {
                         cssObj = new ProvidCssObj();
                         cssObj.setCardNo(rs.getString("CARD_NO"));                 
                         cssObj.setPetitionDate(rs.getString("PETITION_DATE"));
                         cssObj.setCategory(rs.getString("CATEGORY"));
                         cssObj.setDesc(rs.getString("DESCRIPTION"));
                         cssObj.setOccurrenceStat(rs.getString("OCCURRENCE_STATION"));
                         cssObj.setsCase(rs.getString("S_CASE"));
                         cssObj.setActionTaken(rs.getString("action_taken"));
     
                         objAL.add(cssObj);
                     }
                }//for
               
                if(null != objAL && objAL.size() > 0){
                    array = new ProvidCssObj[objAL.size()];
                    for(int i=0 ; i<objAL.size() ; i++){
                        array[i] = (ProvidCssObj) objAL.get(i);
//                        System.out.println(array[i].getCardNo());
                    }
                    proCusAL.setCssArr(array);
                }
                
               //****CUS***************  
               
                if("live".equals(sysurl)){
                     if("XX123456".equals(cardNumAr[0])){
                         String test[] = {"WA6324412","WB4935240","WA5527361","AH0000088","WA7041003"};
                         cardNumAr = test;
                     }                     
                }else if("test".equals(sysurl)){                     
//                     String cardnum2 = "WA6324412,CT0614417,WB4458328";             
                     String[] news = {"中國時報","紐約時報"};
                     String[] mag = {"商業週刊","經濟人","CNN"};
                     String[] bra = {"紅茶","綠茶"};
                     for (int j = 0; j < cardNumAr.length; j++) {
                         perObj = new ProvidPerObj(); 
                         perObj.setCusCardNo(cardNumAr[j]);
                         if("WA6324412".equals(cardNumAr[j])||"CT0614417".equals(cardNumAr[j])){
                             CusReqObj req= new CusReqObj();
                             req.setBeverage(bra);
                             req.setMagazine(mag);
                             req.setNewspaper(news);
                             perObj.setCusReq(req);
                         }
                         
                         if("WA6324412".equals(cardNumAr[j])||"CT0614417".equals(cardNumAr[j])){
                             String[] news1 = {"中國時報","聯合報"};
                             String[] mag1 = {"商業週刊","經濟人","國家地理雜誌"};
                             String[] bra1 = {"熱咖啡","蘋果汁"};
                             CusReqObj req= new CusReqObj();
                             req.setBeverage(bra1);
                             req.setMagazine(mag1);
                             req.setNewspaper(news1);
                             perObj.setCusReq(req);
                         }                         
                         if("WA6324412".equals(cardNumAr[j])){
                             CusOthersObj[] cusOArr = new CusOthersObj[1];
                             CusOthersObj o = new CusOthersObj();
                             String [] de = {"spew test.1","spew test.2"};
                             o.setItem("Spew原因");
                             o.setDetail(de);
                             cusOArr[0] = o;
                             
                             perObj.setCusOthersArr(cusOArr);
                             
                         }
                         if("WA6324412".equals(cardNumAr[j])){    
                             CusSpecReqObj[] cusSpecReqArr= new CusSpecReqObj[2];
                             CusSpecReqObj a = new CusSpecReqObj();
                             a.setType("R");
                             a.setDescription("不要牛奶");
                             a.setPriority("Must");
                             a.setFrequency("every time");
                             a.setPlace("客艙");
                             cusSpecReqArr[0] = a;
                             a = new CusSpecReqObj();
                             a.setType("R");
                             a.setDescription("不要靠近廁所");
                             a.setPriority("NICE TO HAVE");
                             a.setFrequency("ONE TIME");
                             a.setPlace("客艙");     
                             cusSpecReqArr[1] = a;
                             perObj.setCusSpecReqArr(cusSpecReqArr);
                                                       
                             CusMileObj cusMile= new CusMileObj();
                             cusMile.setCurreffMil("266,300");
                             String[] balMil = new String[2];
                             balMil[0] = "10000";
                             balMil[1] = "20000";
                             String[] exprDt = new String[2];
                             exprDt[0] = "2014-05-31";
                             exprDt[1] = "2014-06-30";
                             cusMile.setBalMil(balMil);
                             cusMile.setExprDt(exprDt);
                             perObj.setCusMile(cusMile); 
                             
                             CusOthersObj[] cusOArr = new CusOthersObj[1];
                             CusOthersObj o = new CusOthersObj();
                             String[] noteAr = {"需要拖鞋","短程不供餐","需要毛毯"};
                             o.setItem("Special Important Information");                                     
                             o.setDetail(noteAr);
                             cusOArr[0] = o;

                             perObj.setCusOthersArr(cusOArr);
                         }
                         objAL2.add(perObj);   
                     }//for                     
                 }//end else if
                 for (int j = 0; j < cardNumAr.length; j++) {
                    perObj = new ProvidPerObj();

                    perObj.setCusCardNo(cardNumAr[j]);
                    //取得MVC 喜好
                    String result = getMvc(cardNumAr[j]);
                    if(!"Y".equals(result)){
                        errorStr += result;
                    }else{                             
                        perObj.setCusReq(cusReq);
                    }
                    //spew
                    result = getSpew(cardNumAr[j]);
                    if(!"Y".equals(result)){
                        errorStr += result;
                    } 
                    // others => MVC note & spew 
                    if(null!=otherAL && otherAL.size()>0){
                        CusOthersObj[] cusOthersArr = new CusOthersObj[otherAL.size()];
                        for(int k=0;k<otherAL.size();k++){
                            cusOthersArr[k] = (CusOthersObj)otherAL.get(k);
                        }
                        perObj.setCusOthersArr(cusOthersArr);//note + spew
                    }                         
                    
                    //mile
                    result = getCrmMile(cardNumAr[j]);
                    if(!"Y".equals(result)){
                        errorStr += result;
                    }else{                             
                        perObj.setCusMile(cusMile);
                    }
                    //特殊要求
                    result = getCrmSpecReq(cardNumAr[j]);
                    if(!"Y".equals(result)){
                        errorStr += result;
                    }else{                             
                        perObj.setCusSpecReqArr(cusSpecReqArr);
                    }
                    otherAL = new ArrayList();
                    objAL2.add(perObj);  
                }
                 if(null != objAL2 && objAL2.size() > 0){
                     array2 = new ProvidPerObj[objAL2.size()];
                     for(int i=0 ; i<objAL2.size() ; i++){
                         array2[i] = (ProvidPerObj) objAL2.get(i);
//                         System.out.println(array[i].getCardNo());
                     }
                     proCusAL.setCusArr(array2);
                     
                 }                 
                 proCusAL.setResultMsg("1");
                 proCusAL.setErrorMsg("Done."+errorStr);            
                          
            } catch (Exception e) {
                proCusAL.setResultMsg("0");
                proCusAL.setErrorMsg("Excep CUS: "+ e.toString());
//                errorStr+="Excep CUS: "+ e.toString();
            } finally {
//                System.out.println(errorStr);
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

    public String getMvc(String cardnum)//mvc req, note
    { 
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        String sql = null;
              
        String beverage = "";
        String magazine = "";
        String newspaper = "";
        String type = null;
        String typeDsc = null;        
        String[] note = new String[1];
        String temp = "";
        String result = "";
        try
        {
            DB2Conn cn = new DB2Conn();
////            cn.setDB2UserTcrm();
//            cn.setDB2UserPcrm();
//            java.lang.Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
//            stmt = conn.createStatement();  
      
            cn.setDB2crmCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            stmt = conn.createStatement();
            
//          ******************************************************************************   /AH0000088
            sql = " select CARDNUM,TYPE,CODE,DESC,TYPEDESC,NOTE from cal.itvbzaa  where cardnum = '"+cardnum+"' and type <> 'M' and type <> 'V' order by cardnum, type, code ";
           
//            sql = " select Rtrim(CARDNUM) CARDNUM,Rtrim(TYPE) TYPE,Rtrim(CODE) CODE,Rtrim(DESC) DESC, " +
//            	  " Rtrim(TYPEDESC) TYPEDESC ,Rtrim(NOTE) NOTE,Rtrim(DETAIL) DETAIL " + 
//            	  " from cal.rzvblab spew " +
//            	  " Right JOIN cal.itvbzaa mvc on mvc.cardnum = spew.dfno where cardnum = '"+cardnum+"'";//'WA9398248'
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);
            while (rs.next())
            {   
                
                type = rs.getString("TYPE");
                typeDsc = rs.getString("DESC");
                if("B".equals(type) && null != typeDsc && !"".equals(typeDsc)){
                    beverage += typeDsc.trim()+"\\\\";
                }else if ("N".equals(type) && null != typeDsc && !"".equals(typeDsc)){
                    newspaper+= typeDsc.trim()+"\\\\";
                }else if ("G".equals(type) && null != typeDsc && !"".equals(typeDsc)){
                    magazine += typeDsc.trim()+"\\\\";
                }    
                //note
                note[0] = rs.getString("NOTE");
                
            }
            if(!"".equals(beverage) || !"".equals(magazine) || !"".equals(newspaper)){
                cusReq = new CusReqObj();
                if(null != beverage && !"".equals(beverage)){
                    cusReq.setBeverage(beverage.split("\\\\"));
                }else if(null != magazine && !"".equals(magazine)){
                    cusReq.setMagazine(magazine.split("\\\\"));
                }else if(null != newspaper && !"".equals(newspaper)){
                    cusReq.setNewspaper(newspaper.split("\\\\"));
                }
            }else{
                cusReq = null;
            }
            if(null!=note[0]){
                CusOthersObj obj = new CusOthersObj();                
                obj.setItem("Special Important Information");
                obj.setDetail(note);
                otherAL.add(obj);
            }
            result = "Y";
//            System.out.println(beverage+newspaper+magazine);
//            System.out.println(note);
           
        //******************************************************************************
        }
        catch ( Exception e )
        {
            result = "MVC req :"+cardnum+"****"+e.toString();
//            System.out.println(e.toString());           
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
        return result;
    }
    //mapping spew data. 
    public String getSpew(String cardnum){
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        String sql = null;
        String detail = "";
        String temp = "";
        CusOthersObj obj =  null; 
        String result = null;
        try
        {
            DB2Conn cn = new DB2Conn();
////          cn.setDB2UserTcrm();
//            cn.setDB2UserPcrm();
//            java.lang.Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
//            stmt = conn.createStatement();  
    
          cn.setDB2crmCP();
          dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
          conn = dbDriver.connect(cn.getConnURL(), null);
          stmt = conn.createStatement();
            
//          ******************************************************************************   
            sql =" SELECT dfno,detail ,lastname,fname,shwuse,validdat  " +
                 " FROM CAL.RZVBLAB WHERE validdat >= current_date AND shwuse in ('BOTH','INFLT') " +
                 " AND Rtrim(dfno) = '"+cardnum+"'";//CT0958410
            rs = stmt.executeQuery(sql);
            while (rs.next())
            {   
                temp=rs.getString("detail");
                
                if(null!= temp && !"".equals(temp)) {
                    detail += temp.trim()+"\\\\";
                }
                
            }
            if(null!=detail && !"".equals(detail)){
                obj = new CusOthersObj();                
                obj.setItem("Spew原因");
                obj.setDetail(detail.split("\\\\"));
                System.out.println(obj.getDetail().length);
                otherAL.add(obj);
            }
            result = "Y";
        //******************************************************************************
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            result +="SPEW req :"+cardnum+"****"+e.toString();
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
        return result;
    }
    //mapping mile
    public String getCrmMile(String cardnum)
    { 
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        String sql = null;        
        String result = null;
        
        ArrayList balMil = new ArrayList(); 
        ArrayList exprDt = new ArrayList(); 
        CusMileObj obj = null;
        try
        {
            DB2Conn cn = new DB2Conn();
////            cn.setAIXUserT();
//            cn.setAIXUserP();            
//            java.lang.Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
//            stmt = conn.createStatement();  
    
            cn.setAIXUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            stmt = conn.createStatement();
            
//          ******************************************************************************   
            //目前有效哩程數,一筆
            sql = " SELECT a.CARDNO ,b.effmil" +
                  " FROM AIX.UGVBIAA a,AIX.UGVBIBD b" +
                  " WHERE A.CARDNO = B.CARDNO AND A.cardno = '"+cardnum+"'";

            rs = stmt.executeQuery(sql);
            if (rs.next())
            {
                obj = new CusMileObj();
                obj.setCurreffMil(rs.getString("effmil"));
            }
            
//          ******************************************************************************        
           //最近6個月失效哩程數,多筆
            sql = " SELECT a.CARDNO,b.exprdt,b.balmil " +
                  " FROM AIX.UGVBIAA a,AIX.UGVBIBG b " +
                  " WHERE A.CARDNO = B.CARDNO AND A.cardno = '"+cardnum+"'";
            rs = stmt.executeQuery(sql);
            while (rs.next())
            {              
                balMil.add(rs.getString("balmil"));
                exprDt.add(rs.getString("exprdt"));
            }    
            
            //*****set array*****
            if( (null != balMil && balMil.size() >0 ) && (null != exprDt && exprDt.size() >0 )){
                String[] array1 = new String[balMil.size()];
                String[] array2 = new String[exprDt.size()];
                for (int i = 0; i < balMil.size(); i++) {
                    array1[i] = (String) balMil.get(i);
                    array2[i] = (String) exprDt.get(i);
                }
                if( obj == null){
                    obj = new CusMileObj();
                }
                obj.setBalMil(array1);
                obj.setExprDt(array2);
                
            }
            if(null!=obj){
                cusMile = obj;
            }
            result="Y";
        } 
        catch ( Exception e )
        {
            System.out.println(e.toString());
            result = "mile:"+cardnum+"****"+e.toString();
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
        
        return result;
    }
    //mapping specReq 特殊要求
    public String getCrmSpecReq(String cardnum){
        
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        String sql = null;
        String result = "";
        CusSpecReqObj obj = null;
        ArrayList srObjAL = null;
        try
        {
//            ConnectionHelper ch = new ConnectionHelper();
//            conn = ch.getConnection();
//            stmt = conn.createStatement();
            
                //***CRM
              ConnDB cn = new ConnDB();
//              cn.setCRMUserLive();    
              cn.setCRMUserCP();
              dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
              conn = dbDriver.connect(cn.getConnURL(), null);
              stmt = conn.createStatement();
//          ******************************************************************************   
            //特殊要求
            sql = "select cardno,description,priority,frequency,place from BITREQT q " //type,
                    + " where q.cardno = '"+cardnum+"' order by cardno ";//AL0003677
            
            rs = stmt.executeQuery(sql);
            srObjAL  = new ArrayList();
            while (rs.next())
            {              
                obj = new CusSpecReqObj();
//                obj.setType(rs.getString("type"));
                obj.setDescription(rs.getString("description"));
                obj.setPriority(rs.getString("priority"));
                obj.setFrequency(rs.getString("frequency"));
                obj.setPlace(rs.getString("place"));
                srObjAL.add(obj);
            }
            if(null!= srObjAL && srObjAL.size() > 0){
                cusSpecReqArr = new CusSpecReqObj[srObjAL.size()];
                for(int i=0;i<srObjAL.size();i++){
                    cusSpecReqArr[i] = (CusSpecReqObj) srObjAL.get(i);
                }
            }
            result = "Y";
        } 
        catch ( Exception e )
        {
//            System.out.println(e.toString());
            result = "sReq :"+cardnum+"****"+e.toString();
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
        
        return result;
    }

    public CusDetailRObj getProCusAL()
    {
        return proCusAL;
    }

    public void setProCusAL(CusDetailRObj proCusAL)
    {
        this.proCusAL = proCusAL;
    }

    public CusItemsRObj getCusItemAL()
    {
        return cusItemAL;
    }

    public void setCusItemAL(CusItemsRObj cusItemAL)
    {
        this.cusItemAL = cusItemAL;
    }


    
   

}

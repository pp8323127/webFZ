package ws.personal.mvc;

import java.sql.*;
import java.util.*;
import ws.personal.*;

import ci.db.*;
import eg.mvc.*;


public class ProvidCusFun
{

    /**
     * @param args
     */
    
    private ProvidCusRObj proCusAL = null;
    private  String sysurl = "test"; // test,live
//    private  String sysurl = "live"; 
    ArrayList errorstr = new ArrayList(); 
    
    
    public static void main(String[] args)
    {
        // TODO Auto-generated method stub
        InputCusObj[] cusAr = new InputCusObj[1];//{"WA7041003","CA0360270","WD1201116",};
        InputCusObj cus = new InputCusObj();
        cus.setCardNo("WA7041003");
        cusAr[0] = cus;
//        String[] cusId = {""};
        String cardno = "AA0001675"; 
        
        
        ProvidCusFun f = new ProvidCusFun();
//        System.out.println(f.getMvcReq(cardno).getBeverage().length + "///" +f.getErrorstr().size());
//        System.out.println(f.getCrmSpecReq(cardno));
//        f.getCusSuggCRM(cardno);
        System.out.println(f.getCrmMile(cardno).getCurreffMil());
        
        //
//        f.getCusDataCRM("'"+cardno+"'");
//        cus[0].setCardNo("AA0001675");
//        f.ProvideCusMvcCss(cusAr);
        
    }
    
    //取得 CRM ,DB2 => Cus data.
    public void ProvideCusMvcCss(InputCusObj[] cus ) {
        proCusAL= new ProvidCusRObj();        
        String cardnum = "";
        String cusIdSql = "";
        boolean flag = false;
        String sql = null;
        
        try{
            if(null != cus){
               System.out.println(cus[0].getCardNo());
            }
        
        
            if((null==cus[0] || "".equals(cus[0]))){// && (null==customerId[0] || "".equals(customerId[0]))
                flag = false;
                proCusAL.setResultMsg("0");
                proCusAL.setErrorMsg("請填入資料");            
            }else{
                if(null!=cus[0].getCardNo() && cus.length >0){            
                    flag = true;
                    for(int i=0 ;i<cus.length;i++){
                        if(i==0){
                            cardnum +=  "'"+ cus[i].getCardNo() +"'";
                        }else{
                            cardnum +=  ",'"+ cus[i].getCardNo() +"'";
                        }                
                    }           
                }else{
                    flag = false;
                }           
            }
            flag = true; 
            if(flag){
                if ("live".equals(sysurl))//!"".equals(cardnum) && 
                {
                    proCusAL.setProCusArr(getCusDataCRM(cardnum));
                    
                    if (null != proCusAL.getProCusArr()){ 
                        for(int i=0 ;i<errorstr.size();i++){
    //                        System.out.println(i+":"+(String)errorstr.get(i)); 
                            //取i=4,主檔是否有資料
                            if("Y".equals(errorstr.get(i))){   
                                proCusAL.setResultMsg("1");
                                proCusAL.setErrorMsg("Done");
                            }
                            else if ("N".equals(errorstr.get(i)))
                            {
                                proCusAL.setResultMsg("1");
                                proCusAL.setErrorMsg("No data");
                            }
                            else
                            {
                                proCusAL.setResultMsg("0");
                                proCusAL.setErrorMsg("Excep MVC(II):" + cardnum + "///");
                            }
                        }
                    }else{
                        proCusAL.setResultMsg("1");
                        proCusAL.setErrorMsg("proCusAL<0");
                    }   
                } else if ("test".equals(sysurl)){
    //              dummy --------
    //              cardnum = "'WA7041003','CA0360270','WD1201116'";
    //              mvc.getMVCData2(cardnum); 
    //              ArrayList listMvc = new ArrayList(); 
    //              listMvc = mvc.getObjAL();     
                  
    //              ProvidMvcObj[] array = new ProvidMvcObj[listMvc.size()];
    //              for (int i = 0; i < listMvc.size(); i++) {
    //                  array[i] = (ProvidMvcObj) listMvc.get(i);
    //              }
                  cardnum = "WA7041003,CA0360270,WD1201116";
                  String[] cardnumAr = cardnum.split(","); 
                  String[] cNameAr = {"王治明","董曉雯","謝永慶"};
                  String[] companyCnameAr = {"全能股份有限公司","台灣美國辦事處","流浪狗協會財團法人"};
                  String[] cardTpAr = {"COLD","EMER","PARA"};
                  String[] titleAr = {"執行長","代表委員","代表"};
                  String[] genderAr = {"M","F","F","M","M"};
                  String[] BrthAr = {"1972-01-01","1956-11-11","1959-12-12"};
                  String[] noteAr = {"需要拖鞋","短程不供餐","需要毛毯"};
                  String[] news = {"中國時報","紐約時報"};
                  String[] mag = {"商業週刊","經濟人","CNN"};
                  String[] bra = {"紅茶","綠茶"};
                  ProvidCusObj obj;
                  
                  ArrayList listMvc = new ArrayList(); 
                  for (int i = 0; i < 3; i++) {
                      obj = new ProvidCusObj();
                      obj.setCardnum(cardnumAr[i]);
                      obj.setChinName(cNameAr[i]);
                      obj.setCompany_cname(companyCnameAr[i]);
                      obj.setCard_type(cardTpAr[i]);
                      obj.setTitle(titleAr[i]);
                      obj.setGender(genderAr[i]);
                      obj.setBrthdt(BrthAr[i]);
                      obj.setNote(noteAr[i]);
                      
                      if(i==0 || i==1){
                          CusReqObj req= new CusReqObj();
                          req.setBeverage(bra);
                          req.setMagazine(mag);
                          req.setNewspaper(news);
                          obj.setCusReq(req);
                      }
                      
                      if(i==2){  
                       
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
                      obj.setCusSpecReqArr(cusSpecReqArr);
                      
                      CusSpewObj[] cusSpewArr = new CusSpewObj[1];
                      CusSpewObj b = new CusSpewObj();
                      b.setDetail("spew test.");
                      cusSpewArr[0] = b;
                      obj.setCusSpewArr(cusSpewArr);
                      
//                      CusSugObj[] custSugArr = new CusSugObj[2];
//                      CusSugObj c = new CusSugObj();
//                      
//                      c.setCatalog("S");
//                      c.setContent("提供小孩玩具書.");
//                      custSugArr[0] = c;
//                      c = new CusSugObj();
//                      c.setCatalog("S");
//                      c.setContent("提供機上哺乳室.");
//                      custSugArr[1] = c;
//                      obj.setCustSugArr(custSugArr);
                      
                      CusMileObj cusMile= new CusMileObj();
                      cusMile.setCurreffMil("266,300");
                      String[] balMil = new String[2];
                      balMil[0] = "10000";
                      balMil[1] = "20000";
                      String[] exprDt = new String[2];
                      balMil[0] = "2014-05-31";
                      balMil[1] = "2014-06-30";
                      cusMile.setBalMil(balMil);
                      cusMile.setExprDt(exprDt);
                      obj.setCusMile(cusMile); 
                      }
                      listMvc.add(obj);
                  }
                  ProvidCusObj[] array = new ProvidCusObj[3];
                  for (int i = 0; i < 3; i++) {
                      array[i] = (ProvidCusObj) listMvc.get(i);
//                      System.out.println(array[i].getBrthdt());
                  }          
                  proCusAL.setProCusArr(array);
                  if(array.length > 0){
                      proCusAL.setResultMsg("1");
                      proCusAL.setErrorMsg("Done");
                  }else{
                      proCusAL.setResultMsg("0");
                      proCusAL.setErrorMsg("Excep MVC(II) dummy");
                  }              
                  //dummy -------------
              }else{
                  proCusAL.setResultMsg("0");
                  proCusAL.setErrorMsg("NO data");              
              }
            }//if(flag)
            
        }catch(Exception e){
//            System.out.println(e.toString());
            proCusAL.setResultMsg("0");
            proCusAL.setErrorMsg(e.toString());    
        }
     }
        

    //取得 CRM 主檔案 cardNum / ID (muti)
    public ProvidCusObj[] getCusDataCRM(String cardnum)
    { 
        ProvidCusObj obj = null;
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        String sql = null;
        ArrayList cusObjAL = null;
        ProvidCusObj[] curAr =  null;
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
            //顧客主檔案-基本資料
            sql = "select customer_id, englnm, engfnm,chinname,givnname, gender, brthdt,idnum,passport,"
                    + " cardno,hometel1, emailadr, busstel1, mobnum, nationality, crtdt,"
                    + " crtuser,crtpgm, updtdt,  updtuser, updtpgm, exceprmk,excepcd"
                    + "  from BITCUID d" 
                    + " where d.cardno in ("+cardnum+")";
            
            rs = stmt.executeQuery(sql);
            cusObjAL  = new ArrayList();
            while (rs.next())
            {              
                obj = new ProvidCusObj();
                obj.setCardnum(rs.getString("cardno"));
                obj.setEngLnm(rs.getString("englnm").trim());
                obj.setEngFnm(rs.getString("engfnm").trim());
                obj.setChinName(rs.getString("chinname").trim());
                obj.setGender(rs.getString("gender"));
                obj.setBrthdt(rs.getString("brthdt"));
                obj.setNationality(rs.getString("nationality"));
                
//                obj.setCompany_cname(rs.getString(""));
//                obj.setTitle(rs.getString(""));
//                obj.setNote(rs.getString(""));
//                obj.setCard_type(rs.getString(""));
                cusObjAL.add(obj);
            }    
            
            //*****set cus array*****
            
            if(null != cusObjAL && cusObjAL.size() >0 ){
                curAr = new ProvidCusObj[cusObjAL.size()];
                for (int i = 0; i < cusObjAL.size(); i++) {
                    //*****set detail array*****
                    obj = (ProvidCusObj) cusObjAL.get(i);
                    obj.setCusReq(getMvcReq(obj.getCardnum()));//1筆
                    obj.setCusSpecReqArr(getCrmSpecReq(obj.getCardnum()));
//                    obj.setCustSugArr(getCusSuggCRM(obj.getCardnum()));
                    obj.setCusMile(getCrmMile(obj.getCardnum()));//1筆                  
//                    obj.setCusSpewArr(cusSpewArr);
//                    obj.setCusOtherArr(cusOtherArr);
                    cusObjAL.set(i, obj);
                    curAr[i] = (ProvidCusObj) cusObjAL.get(i);
                }
            }
            if(null != curAr){
                errorstr.add("Y");
            }else{
                errorstr.add("N");
            }
        } 
        catch ( Exception e )
        {
//            System.out.println(e.toString());
            errorstr.add("cus:"+cardnum+"****"+e.toString());
        }        
        finally
        {       
            setErrorstr(errorstr);
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
        return curAr;
    }

    //mapping DB2 MVC Req cardNum (signle)
    public CusReqObj getMvcReq(String cardnum)
    { 
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        String sql = null;
        
        CusReqObj obj =  null;        
        String beverage = null;
        String magazine = null;
        String newspaper = null;
        String type = null;
        String typeDsc = null;
        try
        {
            DB2Conn cn = new DB2Conn();
//            cn.setDB2TUser();
//            cn.setDB2PUser();
//            java.lang.Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
//            stmt = conn.createStatement();  
      
            cn.setDB2crmCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            stmt = conn.createStatement();
            
//          ******************************************************************************   
            sql = " select CARDNUM,TYPE,CODE,DESC,TYPEDESC,NOTE from cal.itvbzaa  where cardnum in ('"+cardnum+"') and type <> 'M' and type <> 'V' order by cardnum, type, code ";
            rs = stmt.executeQuery(sql);
            while (rs.next())
            {   
                type = rs.getString("TYPE").trim();
                typeDsc = rs.getString("DESC").trim();
                
                if("B".equals(type) && null != type){
                    beverage += typeDsc+",";
                }else if ("N".equals(type) && null != type){
                    newspaper+= typeDsc+",";
                }else if ("G".equals(type) && null != type){
                    magazine += typeDsc+",";
                }    
                
            }
            String res= "Y";
            obj = new CusReqObj();
            if(null != beverage && !"".equals(beverage)){
                obj.setBeverage(beverage.split(","));
            }else if(null != beverage && !"".equals(magazine)){
                obj.setMagazine(magazine.split(","));
            }else if(null != beverage && !"".equals(newspaper)){
                obj.setNewspaper(newspaper.split(","));
            }else{
                res= "N";
            }
            errorstr.add(res);
           
        //******************************************************************************
        }
        catch ( Exception e )
        {
//            System.out.println(e.toString());
            errorstr.add("MVC req :"+cardnum+"****"+e.toString());
        }        
        finally
        {
            setErrorstr(errorstr);
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
        return obj;
    }
    
    //mpaaing CRM SpecReq  cardNum  (signle)
    public CusSpecReqObj[] getCrmSpecReq(String cardnum){
        
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        String sql = null;
        
        CusSpecReqObj obj = null;
        ArrayList srObjAL = null;
        CusSpecReqObj[] srObjAr = null;
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
            
                //***CRM
//              ConnDB cn = new ConnDB();
////              cn.setCRMUserLive();    
//              cn.setCRMUserCP();
//              dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//              conn = dbDriver.connect(cn.getConnURL(), null);
//              stmt = conn.createStatement();
//          ******************************************************************************   
            //顧客需求
            sql = "select cardno,description,priority,frequency,place from BITREQT q " //type,
                    + " where q.cardno = '"+cardnum+"' order by cardno ";
            
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
                srObjAr = new CusSpecReqObj[srObjAL.size()];
                for(int i=0;i<srObjAL.size();i++){
                    srObjAr[i] = (CusSpecReqObj) srObjAL.get(i);
                }
                errorstr.add("Y");
            }else{
                errorstr.add("N");
            }
        } 
        catch ( Exception e )
        {
//            System.out.println(e.toString());
            errorstr.add("sReq :"+cardnum+"****"+e.toString());
        }        
        finally
        {  
            setErrorstr(errorstr);
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
        
        return srObjAr;
    }
   
    //mapping DB2 mile data
    public CusMileObj getCrmMile(String cardnum)
    { 
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        String sql = null;
        
        ArrayList balMil = new ArrayList(); 
        ArrayList exprDt = new ArrayList(); 
        CusMileObj obj = null;
        try
        {
            DB2Conn cn = new DB2Conn();
//            cn.setAIXUserT();
            cn.setAIXUserP();            
            java.lang.Class.forName(cn.getDriver());
            conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
            stmt = conn.createStatement();  
    
//            cn.setAIXUserCP();
//            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//            conn = dbDriver.connect(cn.getConnURL(), null);
//            stmt = conn.createStatement();
            
//          ******************************************************************************   
            //目前有效哩程數,一筆
            sql = " SELECT a.cardno,a.cardtype,a.englname,a.chinname,b.effmil" +
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
            sql = " SELECT a.cardno,a.cardtype,a.englname,a.chinname,b.exprdt,b.balmil " +
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
                errorstr.add("Y");
            }
            else{
                errorstr.add("N");
            }
            
        } 
        catch ( Exception e )
        {
            System.out.println(e.toString());
            errorstr.add("mile:"+cardnum+"****"+e.toString());
        }        
        finally
        {
            setErrorstr(errorstr);
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
        
        return obj;
    }
    
    
    //mapping other data.
    
    
    public ProvidCusRObj getProCusAL()
    {
        return proCusAL;
    }
    
    public void setProCusAL(ProvidCusRObj proCusAL)
    {
        this.proCusAL = proCusAL;
    }

    public ArrayList getErrorstr()
    {
        return errorstr;
    }

    public void setErrorstr(ArrayList errorstr)
    {
        this.errorstr = errorstr;
    }


    
    
}

package ws.personal.mvc;

import java.sql.*;
import java.util.*;

import ci.db.*;


public class SaveCusFun
{

    /**
     * @param args
     */

    
//    private Statement stmt = null;
//    private ResultSet rs = null;
    private String sql ="";  
    private int idx =0;
    private final String pgName = "CS_CIS";
    private SavaCusRObj saveCusReturnAL = null;
    public static void main(String[] args)
    {
        // TODO Auto-generated method stub
        SaveCusFun fun = new SaveCusFun();
        SaveCusObj obj = new SaveCusObj();
        SaveCusObj[] saveCusAr = new SaveCusObj[1];
        String[] note = {"999","444"};
//        obj.setTableKey(tableKey);
        obj.setCardNo("WD5740964");//WA7041003,CT0138497
        obj.setLastName("POYI");
        obj.setFstName1("HO");
        obj.setFstName2("HOHO");
        obj.setNote(note);
        obj.setDepDt("2014-05-06");
        obj.setCdc("CI");
        obj.setFltno("0006");
        obj.setDep("TPE");
        obj.setArr("LAX");
        obj.setUpdtDt("2014-05-28");
        obj.setUpdtUser("123456");
        
        SaveDetailCusObj obj2 = new SaveDetailCusObj();
//        SaveDetailCusObj[] detailArr = new SaveDetailCusObj[1];
        SaveDetailCusObj[] detailArr = new SaveDetailCusObj[2];
        obj2.setType("S");
        obj2.setCode("SG001");
        obj2.setDesc("請提供兒童餐具");
        obj2.setUpdtDt("2014-05-28");
        obj2.setUpdtUser("123456");
        detailArr[0] = obj2;
        detailArr[1] = obj2;
        obj.setDetailArr(detailArr);
        
        saveCusAr[0] = obj;
        fun.saveCus(saveCusAr);
    }
    
    public void saveCus(SaveCusObj[] saveCusArr){
        StringBuffer sqlsb = null;  
        saveCusReturnAL = new SavaCusRObj();
        
        Statement stmt = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        String sql = null;
        String keySql = "";
        String cardNoSql= "";
        String note = "";
        String msg = "";
        boolean chkflag = false;
        ArrayList delAL = new ArrayList();
        SaveCusObj saveCusObj = null;
        SaveDetailCusObj saveDetailCusObj = null;
        int countSaveCusObj = 0;
        int countSaveDetailCusObj = 0;
        try{
            //check 資料.
            for(int i=0;i<saveCusArr.length;i++){
                saveCusObj = (SaveCusObj) saveCusArr[i];
                if(i == saveCusArr.length-1){
                    cardNoSql += "'"+saveCusObj.getCardNo()+"'";//取卡號
                }else{
                    cardNoSql += "'"+saveCusObj.getCardNo()+"',";//取卡號
                }
//                System.out.println(cardNoSql);
                if("".equals(saveCusObj.getFstName1()) || "".equals(saveCusObj.getLastName())){
                    saveCusReturnAL.setResultMsg("0");
                    msg += saveCusObj.getCardNo()+":LastName/FirstName,不可為空";
                    chkflag = false;
                    break;                    
                }else if ("".equals(saveCusObj.getDepDt())){
                    saveCusReturnAL.setResultMsg("0");
                    msg += saveCusObj.getCardNo()+":出發日,不可為空";
                    chkflag = false;
                    break;
                }else if ("".equals(saveCusObj.getCdc())){
                    saveCusReturnAL.setResultMsg("0");
                    msg += saveCusObj.getCardNo()+":航空公司,不可為空";
                    chkflag = false;
                    break;
                }else if ("".equals(saveCusObj.getFltno())){
                    saveCusReturnAL.setResultMsg("0");
                    msg += saveCusObj.getCardNo()+":班號,不可為空";
                    chkflag = false;
                    break;
                }else if ("".equals(saveCusObj.getArr())|| "".equals(saveCusObj.getDep()) ){
                    saveCusReturnAL.setResultMsg("0");
                    msg += saveCusObj.getCardNo()+":航段,不可為空";
                    chkflag = false;
                    break;
                }else if ("".equals(saveCusObj.getUpdtDt())|| "".equals(saveCusObj.getUpdtUser())){
                    saveCusReturnAL.setResultMsg("0");
                    msg += saveCusObj.getCardNo()+":更新日/人,不可為空";
                    chkflag = false;
                    break;
                }else{
                    chkflag = true;
                }
            }            
            
//            ConnectionHelper ch = new ConnectionHelper();
//            conn = ch.getConnection();
//            stmt = conn.createStatement();
          
            //***CRM connection pool
            ConnDB cn = new ConnDB();
            cn.setCRMUserCP();              
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            stmt = conn.createStatement();
            
            //mapping CUS_ID
            if(chkflag && !"".equals(cardNoSql)){
                sql = " select trim(customer_id) customer_id,trim(cardno) cardno from bitcuid id where trim(id.cardno) in ("+cardNoSql+")";
                rs = stmt.executeQuery(sql); 
                Hashtable cardHT = new Hashtable();
                while (rs.next()) {
                    cardHT.put(rs.getString("cardno"), rs.getString("customer_id"));
                }    
                for(int i=0;i<saveCusArr.length;i++){
                    saveCusObj = (SaveCusObj) saveCusArr[i];
                        saveCusArr[i].setCustomerId((String) cardHT.get(saveCusObj.getCardNo().trim()));//saveCusArr塞入cus ID
//                        System.out.println(saveCusArr[i].getCustomerId()); 
                }
                
            }
               
           //資料不為空才刪檔&新增
            if(chkflag){
                if(null != saveCusArr && saveCusArr.length >0){
                    String fltd = saveCusArr[0].getDepDt();
                    String fltno = saveCusArr[0].getFltno();
                    String sect = saveCusArr[0].getDep()+saveCusArr[0].getArr();
                    String user = saveCusArr[0].getUpdtUser();
                    sql = " select table_key from Bitreqm where depdt = to_date('"+fltd+"','yyyy-mm-dd') and flno = '"+fltno+"' and depstn||arrstn = '"+sect+"' " +
                          " and trim(updtuser) = '"+user+"' and trim(updtpgm) = '"+pgName+"'";
                    rs = stmt.executeQuery(sql); 
                    while (rs.next()) {
                        delAL.add("'"+rs.getString("table_key")+"'");
    //                    System.out.println(rs.getString("table_key"));
                    }       
    
                    conn.setAutoCommit(false);
                    if(null != delAL && delAL.size() > 0){
                        for(int i=0 ;i< delAL.size();i++){
                            if(i != delAL.size()-1){
                                keySql += delAL.get(i)+",";
                            }else{
                                keySql += delAL.get(i);
                            }
                        }
                        //刪細檔
                        sql = "delete from Bitreqd where table_key in ("+keySql+") ";
                        stmt.executeUpdate(sql); 
    //                    System.out.println("Bitreqd:"+stmt.getUpdateCount());
                    }
                    //刪主檔
                    sql = " delete from Bitreqm where depdt = to_date('"+fltd+"','yyyy-mm-dd') and flno = '"+fltno+"' and depstn||arrstn = '"+sect+"' " +
                    	  " and trim(updtuser) = '"+user+"' and trim(updtpgm) = '"+pgName+"'";
                    stmt.executeUpdate(sql); 
    //                System.out.println("bitreqm:"+stmt.getUpdateCount());
                    
                    //新增
                    for(int i=0; i<saveCusArr.length;i++){          
                        //取Mvc主項
                        saveCusObj = (SaveCusObj) saveCusArr[i];
                        //無table key 
                        if(saveCusObj.getTableKey()==null || "".equals(saveCusObj.getTableKey())){      
                            //取next table key
                            sql = "select nvl(to_number(max(substr(table_key, 1, 14))) + 1, 0) fn, to_char(sysdate, 'yyyymm') yymm from bitreqm ";
                            rs = stmt.executeQuery(sql);                          
                        
                            String yymm = "";
                            String fn = "";
                            String no = "";
                            while (rs.next()) {
                                yymm = rs.getString("yymm");
                                fn = rs.getString("fn");
    //                            System.out.println("sql:"+fn);
                                if ("0".equals(fn)) {
                                    fn = fn + "00000001";
                                }
                                no = fn.substring(0, 6);
                                if (no.equals(yymm)) continue; fn = yymm + "00000001";
                            }                      
//                            System.out.println(fn);
                            
                            
                            //新增主項
                            sqlsb = new StringBuffer();
                            sqlsb.append("insert into bitreqm (table_key,customer_id,cardno,lastname,fstname1,fstname2," +
                            		" chinname,gender,brthdt,language,note,corpnm,cortnmc,title,titlec,depdt,cdc," +
                            		" flno,depstn,arrstn,updtdt,updtuser,updtpgm)" +
                            		
                            		" values (?,?,?,?,?,Nvl(?,' ')," +
                            		" ?,?,to_date(?,'yyyy-mm-dd'),?,?,?,?,?,?,to_date(?,'yyyy-mm-dd'),?," +
                            		" ?,?,?,to_date(?,'yyyy-mm-dd'),?,?)");
    //                        "insert into bitreqm (table_key,customer_id,cardno,lastname,fstname1,fstname2," +
    //                        "chinname,gender,brthdt,language,note,corpnm,cortnmc,title,titlec,depdt,cdc," +
    //                        "flno,depstn,arrstn,updtdt,updtuser,updtpgm)" +
    //                        
    //                        "values (table_key,customer_id,cardno,lastname,fstname1,fstname2," +
    //                        "chinname,gender,brthdt,language,note,corpnm,cortnmc,title,titlec,depdt,cdc," +
    //                        "flno,depstn,arrstn,updtdt,updtuser,updtpgm)"
    //                        System.out.println(sqlsb.toString());
                            
                            pstmt = conn.prepareStatement(sqlsb.toString());
                            
                            if(null != saveCusObj.getNote() && saveCusObj.getNote().length > 0){
                                for(int j=0;j<saveCusObj.getNote().length;j++){
                                    note += saveCusObj.getNote()[j]+",";
                                }                            
                            }
                            idx = 0;
                            pstmt.setString(++idx, fn );//saveMvcObj.getTableKey()
                            pstmt.setString(++idx, saveCusObj.getCustomerId());
                            pstmt.setString(++idx, saveCusObj.getCardNo());
                            pstmt.setString(++idx, saveCusObj.getLastName());
                            pstmt.setString(++idx, saveCusObj.getFstName1());
                            pstmt.setString(++idx, saveCusObj.getFstName2());
                            pstmt.setString(++idx, saveCusObj.getChinName());
                            pstmt.setString(++idx, saveCusObj.getGender());
                            pstmt.setString(++idx, saveCusObj.getBrthDt());
                            pstmt.setString(++idx, saveCusObj.getLanguage());
                            pstmt.setString(++idx, note);
                            pstmt.setString(++idx, saveCusObj.getCorpNm());
                            pstmt.setString(++idx, saveCusObj.getCorpNmC());
                            pstmt.setString(++idx, saveCusObj.getTitle());
                            pstmt.setString(++idx, saveCusObj.getTitleC());
                            pstmt.setString(++idx, saveCusObj.getDepDt());
                            pstmt.setString(++idx, saveCusObj.getCdc());
                            pstmt.setString(++idx, saveCusObj.getFltno());
                            pstmt.setString(++idx, saveCusObj.getDep());
                            pstmt.setString(++idx, saveCusObj.getArr());
                            pstmt.setString(++idx, saveCusObj.getUpdtDt());
    //                        pstmt.setString(++idx, saveMvcObj.getUpdtTime());
                            pstmt.setString(++idx, saveCusObj.getUpdtUser());
                            pstmt.setString(++idx, pgName);//saveMvcObj.getUpdtPgm()
                            
                            countSaveCusObj = pstmt.executeUpdate();
    //                        System.out.println(countSaveCusObj);
                            
                            if(null != saveCusObj.getDetailArr() && saveCusObj.getDetailArr().length > 0 ){                        
                                
                                sqlsb = new StringBuffer();
                                sqlsb.append("insert into Bitreqd (table_key,serial_no,type,code,description, " +
                                		" priority,frequency,score,status,place,permission,owner,updtdt,updtuser,updtpgm) " +
                                		" values (?,?,?,?,?, " +
                                		" Nvl(?,'1'),Nvl(?,'1'),Nvl(?,'1'),Nvl(?,'1'),?,?,?,to_date(?,'yyyy-mm-dd'),?,?) ");
                                sqlsb.toString();
                                pstmt = null;
                                pstmt = conn.prepareStatement(sqlsb.toString());
                                
                                for(int j=0 ;j<saveCusObj.getDetailArr().length ;j++){
                                    //取Mvc副項
                                    saveDetailCusObj = (SaveDetailCusObj) saveCusObj.getDetailArr()[j];
                                    
                                    idx = 0;
                                    pstmt.setString(++idx, fn );//saveDetailMVCObj.getTableKey()
                                    pstmt.setInt   (++idx, j);//saveDetailCusObj.getSerialNo()
                                    pstmt.setString(++idx, saveDetailCusObj.getType());
                                    pstmt.setString(++idx, saveDetailCusObj.getCode());
                                    pstmt.setString(++idx, saveDetailCusObj.getDesc());
                                    pstmt.setString(++idx, saveDetailCusObj.getPriority());
                                    pstmt.setString(++idx, saveDetailCusObj.getFrequency());
                                    pstmt.setString(++idx, null);//saveDetailMVCObj.getScore()
                                    pstmt.setString(++idx, null);//saveDetailMVCObj.getStatus()
                                    pstmt.setString(++idx, saveDetailCusObj.getPlace());
                                    pstmt.setString(++idx, "");//saveDetailMVCObj.getPermission()
                                    pstmt.setString(++idx, "SF");//saveDetailMVCObj.getOwner()
                                    pstmt.setString(++idx, saveDetailCusObj.getUpdtDt());
    //                                pstmt.setString(++idx, saveDetailCusObj.getUpdtTime());
                                    pstmt.setString(++idx, saveDetailCusObj.getUpdtUser());
                                    pstmt.setString(++idx, pgName);//saveDetailMVCObj.getUpdtPgm()                                
                                    pstmt.addBatch();
                                }//for(int j=0 ;j<saveMvcObj.getDetailAL().length ;j++)
                                
                                pstmt.executeBatch();
                                countSaveDetailCusObj = pstmt.getUpdateCount();//.SUCCESS_NO_INFO;
    //                            System.out.println(countSaveDetailCusObj);
                                pstmt.clearBatch();
                                
                                saveCusReturnAL.setResultMsg("1");
                                msg+="更新完成"+countSaveDetailCusObj;
                            }else{
                                saveCusReturnAL.setResultMsg("1");
                                msg+="內容為空,無需更新.";
                            }//if(null != saveMvcObj.getDetailAL() && saveMvcObj.getDetailAL().length > 0 ) 
                        }
                        conn.commit();                    
                        saveCusReturnAL.setResultMsg("1");
                        msg+="更新主項成功"+countSaveCusObj;
                    }//for(int i=0; i<saveAllMVCAL.length;i++)               
                }else{
                    saveCusReturnAL.setResultMsg("0");
                    msg+="主項為空,無法更新.";
                }//if(null != saveAllMVCAL && saveAllMVCAL.length >0)    
            }//if chkfalg
        }catch(Exception e){
            saveCusReturnAL.setResultMsg("0");
            msg="更新失敗"+e.toString();
//            System.out.println(msg+":"+saveCusReturnAL.getErrorMsg());
            try{
                conn.rollback();
            }catch(SQLException se){ 
                msg += "rollback exception :"+se.toString();
//                System.out.println("rollback exception :"+se.toString());
            }
            
            //return e.toString();            
        }finally{
            saveCusReturnAL.setErrorMsg(msg);
            try{
                if (rs != null)
                    rs.close();
            }
            catch ( SQLException e ){
            }
            try{
                if (stmt != null)
                    stmt.close();
            }
            catch ( SQLException e ){
            }
            try{
                if (pstmt != null){
                    pstmt.close();
                }
            }
            catch ( SQLException e ){
            }
            try{
                if (conn != null){
                    conn.close();
                }
            }
            catch ( SQLException e ){
            }
        } 
        
    }

    public SavaCusRObj getSaveCusReturnAL()
    {
        return saveCusReturnAL;
    }

    public void setSaveCusReturnAL(SavaCusRObj saveCusReturnAL)
    {
        this.saveCusReturnAL = saveCusReturnAL;
    }

    
   
}

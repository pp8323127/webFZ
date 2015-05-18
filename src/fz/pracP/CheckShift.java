package fz.pracP;

import java.sql.*;

import ci.db.*;

public class CheckShift {

	/**
	 * CheckFltData 
	 * 檢查客艙經理是否已輸入shift資料
	 * 必填航班為:
	 * 002/001, 004/003, 006/005, 008/007, 020/019(KIX/JFK/KIX),032/031, 061/062, 063/064, 065/066(BKK/AMS/BKK)
	 * 另檢查 區域線 847/848, 851/852(但可能因特殊原因不需強制執行,將cflt noshift:設為有值即可ex:Y)
	 * 2013/05/31 SR 3086 CS80
	 * 2013/10/21 SR 3185 CS80區域線航班TPE/HKT/TPE(847/848)，TPE/CNX/TPE(851/852)，TPE/GUM/TPE(025/026)，TPE/RGN/TPE (7915/7916)，TPE/CTS/TPE(130/131)等10個航班新增勾選組員輪休時段，其中包括加班機
	 * 2013/10/25 CI757/758 KHH-SIN-KHH
	 * 2013/11/21 XIY
	 * 2014/01/28 :(1)有排輪休勾選"Y"，必需註明組員分別輪休時段(現行作業)。(2)無法排輪休勾選"N"，需於備註欄說明原因後，方可送出報告。
	 * 2014/02/12 改顯示wording
	 * 2014/03/11 航段判斷修正
	 * 2015/05/14有duty,至少填一梯次
	 * @param args
	 */
	private String fltd; // format: yyyy/mm/dd
    private String fltno;
    private String sector;
    private String psrEmpno;    
    private String mustWrite = "Y";
    private String msg = "";
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		CheckShift chk = new CheckShift();
//		System.out.println(chk.getChickShift("2013/05/31", "0020", "KIXJFK"));
//		System.out.println(chk.getChickShift("2013/04/29", "0847", "TPEHKT"));
		System.out.println(chk.getChickShift("2015/05/10", "0006", "TPESIN"));
		System.out.println(chk.getMsg());
	}	
	public CheckShift() {
		
	}
	public String getChickShift(String fltd,String fltno,String sector){
		Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;        
        Driver dbDriver = null;
        String sql = "";
        String shift = "";
        String noshift = "";
        String sh_remark ="";
        String mp_empn = "";
        String sh_mp = "";
        String sh_cm = "";
        
        String[] empn = new String[20];
        String[] duty = new String[20];
        String[] sh = new String[20];        
//        boolean[] flag = new boolean[20];
        boolean flagSh = false;
        boolean dutyCd = false;
        int count = 0;
        try 
        {
            ConnDB cn = new ConnDB();
            //直接連線
//            cn.setORT1EG();
//            cn.setORP3EGUser();
//	    	java.lang.Class.forName(cn.getDriver());
//	    	con = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
//	    	stmt = con.createStatement();	
	    	
	    	//connection pool
//            cn.setORP3EGUserCP();
//            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//            con = dbDriver.connect(cn.getConnURL() ,null);            
//            stmt = con.createStatement();
	    	
            ConnectionHelper ch = new ConnectionHelper();
            con = ch.getConnection();
            stmt = con.createStatement();  
            
	    	sql = "  select  * from egtcflt where fltd = to_date('"+fltd+"','yyyy/mm/dd') and fltno = '"+fltno+"' and sect = '"+sector+"'";
		
//	    	System.out.println(sql);
	    	rs = stmt.executeQuery(sql);            
      
		    if (rs.next()) 
		    {
		    	shift = rs.getString("shift");
		    	sh_remark = rs.getString("sh_remark");
                noshift = rs.getString("noshift");
                sh_cm = rs.getString("sh_cm");
                sh_mp = rs.getString("sh_mp");
                mp_empn = rs.getString("mp_empn");
                
                if(shift == null) shift = "";
    		    if(noshift == null) noshift = "";
    		    if(sh_remark == null) sh_remark = "";
    		    if(sh_cm == null) sh_cm = "";
    		    if(mp_empn == null) mp_empn = "";
    		    if(sh_mp == null) sh_mp = "";
//    		    System.out.println(shift);
//    		    System.out.println(noshift);
//    		    System.out.println(sh_remark);
//    		    System.out.println(sh_cm);
//    		    System.out.println(mp_empn);
//    		    System.out.println(sh_mp);
    		    //輪休為N or Y , 若note有註記內容皆可pass
                if(!"".equals(sh_remark)){
                	 mustWrite = "N";                	
                }else{
                	for(int i=0; i<empn.length; i++){
                        empn[i] = rs.getString("empn"+String.valueOf(i+1));
                        if(empn[i] == null) empn[i] = "000000";   
                        duty[i] = rs.getString("duty"+String.valueOf(i+1));
                        if(duty[i] == null) duty[i] = "X";
                        sh[i] = rs.getString("SH_CREW"+String.valueOf(i+1));
                        if(sh[i] == null) sh[i] = "X";
                        //必填班次
                        //有duty,未填寫梯次
                        //CM,未填寫
                        //有MP,未填寫
                        if((!duty[i].equals("X") && ("0".equals(sh[i].trim()) || "X".equals(sh[i].trim()))) || 
                        		("0".equals(sh_cm.trim()) || "X".equals(sh_cm.trim()) ) || 
                        		(!"".equals(mp_empn) && ("0".equals(sh_mp.trim()) || "X".equals(sh_cm.trim()))) 
                        		){ 
//                            flag[i] = true;
                            flagSh = true;//提醒要填
                        }
                       
                        //非必填班次,on duty crew & cm & mp,已至少填一梯次
                        if(!duty[i].equals("X") && (!sh[i].equals("0") && !sh[i].equals("X")) || 
                        		(!"0".equals(sh_cm) && !"X".equals(sh_cm) )  || 
                        		(!"".equals(mp_empn) && (!"0".equals(sh_mp) &&  !"X".equals(sh_cm))) 
                        		){
                        	count++ ;//>0不需提醒
                        }                    
                        if(!duty[i].equals("X")){
            				dutyCd = true;//有on duty組員/CM/MP
            			}
                        //System.out.println(count);
                    }   		   	    
	    		    
    		        
    		    if(fltno.subSequence(0,4).equals("0002") || fltno.subSequence(0,4).equals("0001") ||
    		       fltno.subSequence(0,4).equals("0004") || fltno.subSequence(0,4).equals("0003") ||
    		       fltno.subSequence(0,4).equals("0006") || fltno.subSequence(0,4).equals("0005") ||
    		       fltno.subSequence(0,4).equals("0008") || fltno.subSequence(0,4).equals("0007") ||
    		       (fltno.subSequence(0,4).equals("0020") && sector.equals("KIXJFK")) || (fltno.subSequence(0,4).equals("0019") && sector.equals("JFKKIX")) ||
    		       fltno.subSequence(0,4).equals("0032") || fltno.subSequence(0,4).equals("0031") ||
    		       fltno.subSequence(0,4).equals("0061") || fltno.subSequence(0,4).equals("0062") ||
    		       fltno.subSequence(0,4).equals("0063") || fltno.subSequence(0,4).equals("0064") ||
    		       (fltno.subSequence(0,4).equals("0065") && sector.equals("BKKAMS"))  || (fltno.subSequence(0,4).equals("0066") && sector.equals("AMSBKK")) )
//    		    if(sector.contains("HNL") || sector.contains("SFO") || sector.contains("LAX") || 
//    		       sector.equals("KIXJFK")|| sector.equals("JFKKIX") ||
//    		       sector.equals("BKKAMS")|| sector.equals("AMSBKK") ||
//    		       sector.contains("YVR") || sector.contains("FRA") || sector.contains("VIE"))
    		    {
                    if (shift.equals("Y")){
                        /*for(int i=0; i<flag.length; i++){
                            if(flag[i]){                            
                                msg += empn[i]+"\n";
                            }
                        }*/
                        if(msg.equals("") && !flagSh ){
                            mustWrite = "N";// 皆已填寫-->不提醒 
                        }else{
	                        mustWrite = "Y";// 已填寫,但有duty,未填寫梯次-->需提醒
	                        msg += "有Duty組員/客艙經理/組長,請填寫輪休梯次,方可送出報告,如未排輪休,請填寫備註";                        	
                        }
                    }                
                    else 
                    {
                        if(shift.equals("N") && !"".equals(sh_remark)) {//不輪休有填remark-->不提醒 
                            mustWrite = "N";
                            msg = "";
                        }else{// 尚未填寫-->提醒必填.
                            mustWrite = "Y";
                            msg = "本班輪休為必填!\n未輪休請備註原因,方可送出報告!!";
                        }   
                        
                    }
    		    }
    		    else if( sector.subSequence(0,3).equals("HKT") || sector.subSequence(4,6).equals("HKT") || 
    		         	 sector.subSequence(0,3).equals("CNX") || sector.subSequence(4,6).equals("CNX") || 
    		         	 sector.subSequence(0,3).equals("GUM") || sector.subSequence(4,6).equals("GUM") || 
                         sector.subSequence(0,3).equals("RGN") || sector.subSequence(4,6).equals("RGN") || 
                         sector.subSequence(0,3).equals("CTS") || sector.subSequence(4,6).equals("CTS") || 
                         sector.subSequence(0,3).equals("XIY") || sector.subSequence(4,6).equals("XIY") ) 
    /*		    	fltno.subSequence(0,4).equals("0847") || fltno.subSequence(0,4).equals("0848") ||
    		    	fltno.subSequence(0,4).equals("0851") || fltno.subSequence(0,4).equals("0852") ||
    		    	fltno.subSequence(0,4).equals("0025") || fltno.subSequence(0,4).equals("0026") ||
    		    	fltno.subSequence(0,4).equals("7915") || fltno.subSequence(0,4).equals("7916") ||
    		    	fltno.subSequence(0,4).equals("0130") || fltno.subSequence(0,4).equals("0131") ||
    		    	fltno.subSequence(0,4).equals("0757") || fltno.subSequence(0,4).equals("0758") ||*/
    		    	
    		    {        
//    		    	System.out.println(fltno.subSequence(0,4));
    		    	if (shift.equals("Y")){
                        /*for(int i=0; i<flag.length; i++){
                            if(flag[i]){                            
                                msg += empn[i]+"\n";
                            }
                        }*/
                        if(msg.equals("") && !flagSh ){
                            mustWrite = "N";// 皆已填寫-->不提醒 
                        }else{
	                        mustWrite = "Y";// 已填寫,但有duty,未填寫梯次-->需提醒
	                        msg += "有Duty組員/客艙經理/組長,請填寫輪休梯次,方可送出報告,如未排輪休,請填寫備註";                        	
                        }
                    } 
                    else
                    {
                        if(!noshift.equals("")){// noshift有值-->不提醒
                            mustWrite = "N";
                            msg = "";
                        }else if((shift.equals("N") && !"".equals(sh_remark))){//不輪休有填remark-->不提醒
                            mustWrite = "N";
                            msg = "";
                        }else{// 尚未填寫-->提醒必填.
                            mustWrite = "Y";
                            msg = "本班輪休為必填!\n未輪休請備註原因,方可送出報告!!";
                        }
                    }
    		    }
    		    else
    		    {
    		    	if (shift.equals("Y"))
                    {
                        if(msg.equals("") && count>0 && dutyCd){
                            mustWrite = "N";// 至少cm/mp/crew已填梯次-->不提醒 
                        }else{
	                        mustWrite = "Y";// 未填寫梯次-->需提醒
	                        msg += "有Duty組員/客艙經理/組長,請填寫輪休梯次,方可送出報告.";                        	
                        }
                    
                    }else{
                    	mustWrite = "N";
                    }
    		        
    		    }
    		    
                }
                return mustWrite;
		    }else{
		    	return "查無班次";
		    }
        } 
        catch (Exception e) 
        {            
            return e.toString();
        } 
        finally 
        {
            try {
                if ( rs != null ) rs.close();
            } catch (SQLException e) {}
            try {
                if ( stmt != null ) stmt.close();
            } catch (SQLException e) {}
            try {
                if ( con != null ) con.close();
            } catch (SQLException e) {}
        }
   
	}
    public String getMsg()
    {
        return msg;
    }
    public void setMsg(String msg)
    {
        this.msg = msg;
    }
	

}

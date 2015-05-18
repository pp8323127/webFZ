package fz.pracP;

import java.sql.*;

import ci.db.*;

public class CheckShift {

	/**
	 * CheckFltData 
	 * �ˬd�ȿ��g�z�O�_�w��Jshift���
	 * �����Z��:
	 * 002/001, 004/003, 006/005, 008/007, 020/019(KIX/JFK/KIX),032/031, 061/062, 063/064, 065/066(BKK/AMS/BKK)
	 * �t�ˬd �ϰ�u 847/848, 851/852(���i��]�S���]���ݱj�����,�Ncflt noshift:�]�����ȧY�iex:Y)
	 * 2013/05/31 SR 3086 CS80
	 * 2013/10/21 SR 3185 CS80�ϰ�u��ZTPE/HKT/TPE(847/848)�ATPE/CNX/TPE(851/852)�ATPE/GUM/TPE(025/026)�ATPE/RGN/TPE (7915/7916)�ATPE/CTS/TPE(130/131)��10�ӯ�Z�s�W�Ŀ�խ�����ɬq�A�䤤�]�A�[�Z��
	 * 2013/10/25 CI757/758 KHH-SIN-KHH
	 * 2013/11/21 XIY
	 * 2014/01/28 :(1)���ƽ���Ŀ�"Y"�A���ݵ����խ����O����ɬq(�{��@�~)�C(2)�L�k�ƽ���Ŀ�"N"�A�ݩ�Ƶ��满����]��A��i�e�X���i�C
	 * 2014/02/12 �����wording
	 * 2014/03/11 ��q�P�_�ץ�
	 * 2015/05/14��duty,�ܤֶ�@�覸
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
            //�����s�u
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
    		    //����N or Y , �Ynote�����O���e�ҥipass
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
                        //����Z��
                        //��duty,����g�覸
                        //CM,����g
                        //��MP,����g
                        if((!duty[i].equals("X") && ("0".equals(sh[i].trim()) || "X".equals(sh[i].trim()))) || 
                        		("0".equals(sh_cm.trim()) || "X".equals(sh_cm.trim()) ) || 
                        		(!"".equals(mp_empn) && ("0".equals(sh_mp.trim()) || "X".equals(sh_cm.trim()))) 
                        		){ 
//                            flag[i] = true;
                            flagSh = true;//�����n��
                        }
                       
                        //�D����Z��,on duty crew & cm & mp,�w�ܤֶ�@�覸
                        if(!duty[i].equals("X") && (!sh[i].equals("0") && !sh[i].equals("X")) || 
                        		(!"0".equals(sh_cm) && !"X".equals(sh_cm) )  || 
                        		(!"".equals(mp_empn) && (!"0".equals(sh_mp) &&  !"X".equals(sh_cm))) 
                        		){
                        	count++ ;//>0���ݴ���
                        }                    
                        if(!duty[i].equals("X")){
            				dutyCd = true;//��on duty�խ�/CM/MP
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
                            mustWrite = "N";// �Ҥw��g-->������ 
                        }else{
	                        mustWrite = "Y";// �w��g,����duty,����g�覸-->�ݴ���
	                        msg += "��Duty�խ�/�ȿ��g�z/�ժ�,�ж�g����覸,��i�e�X���i,�p���ƽ���,�ж�g�Ƶ�";                        	
                        }
                    }                
                    else 
                    {
                        if(shift.equals("N") && !"".equals(sh_remark)) {//�����𦳶�remark-->������ 
                            mustWrite = "N";
                            msg = "";
                        }else{// �|����g-->��������.
                            mustWrite = "Y";
                            msg = "���Z���𬰥���!\n������гƵ���],��i�e�X���i!!";
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
                            mustWrite = "N";// �Ҥw��g-->������ 
                        }else{
	                        mustWrite = "Y";// �w��g,����duty,����g�覸-->�ݴ���
	                        msg += "��Duty�խ�/�ȿ��g�z/�ժ�,�ж�g����覸,��i�e�X���i,�p���ƽ���,�ж�g�Ƶ�";                        	
                        }
                    } 
                    else
                    {
                        if(!noshift.equals("")){// noshift����-->������
                            mustWrite = "N";
                            msg = "";
                        }else if((shift.equals("N") && !"".equals(sh_remark))){//�����𦳶�remark-->������
                            mustWrite = "N";
                            msg = "";
                        }else{// �|����g-->��������.
                            mustWrite = "Y";
                            msg = "���Z���𬰥���!\n������гƵ���],��i�e�X���i!!";
                        }
                    }
    		    }
    		    else
    		    {
    		    	if (shift.equals("Y"))
                    {
                        if(msg.equals("") && count>0 && dutyCd){
                            mustWrite = "N";// �ܤ�cm/mp/crew�w��覸-->������ 
                        }else{
	                        mustWrite = "Y";// ����g�覸-->�ݴ���
	                        msg += "��Duty�խ�/�ȿ��g�z/�ժ�,�ж�g����覸,��i�e�X���i.";                        	
                        }
                    
                    }else{
                    	mustWrite = "N";
                    }
    		        
    		    }
    		    
                }
                return mustWrite;
		    }else{
		    	return "�d�L�Z��";
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

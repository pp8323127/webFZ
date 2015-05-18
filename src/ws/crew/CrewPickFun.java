package ws.crew;

import java.sql.*;
import java.util.*;
import ws.*;
import ci.db.*;

import credit.*;

public class CrewPickFun
{

    /**
     * @param args
     */
    private CrewPickCreditRObj pickCtObjAL = null;//1. �n�I��Z��� �ˬd
    private CrewPickFullAttRObj pickAttObjAL = null;//2. ���Կ�Z��� �ˬd
    private CrewPickApplyListRObj pickListObjAL = null;//5.���o�i��������Z�C��
    private CrewPickApplyNumRObj pickNumObjAL = null;//6.���o����
    private CrewPickProcessRObj ProcPickObjAL = null;  //7.�B�z�i�׬d��
    
//    private ArrayList objAL = new ArrayList();
    public static void main(String[] args)
    {
        // TODO Auto-generated method stub
    	CrewPickFun cpf = new CrewPickFun();
    	cpf.PickApplyList("633020");
    	
    	CrewPickApplyListRObj rObjAL = cpf.getPickListObjAL();
    	if(null!= rObjAL ){
    		ArrayList objAL = rObjAL.getListObjAL();
    		System.out.println(objAL.size());
    		/*if(null!= objAL && objAL.size()>0){
        		for(int i=0; i<objAL.size() ;i++){
        			
        		}
        	}*/
    	}
    	
    }
    
    //1. �n�I��Z��� �ˬd
    public void ChkPickCtInfo(String empno,String yyyy,String mm){
        //'1','�n�I��Z','2','�n�洫�Z','3','���Կ�Z','4','�䥦��Z'
        CreditList cl = new CreditList();
        cl.getCreditList("N",empno);    
        pickCtObjAL = new CrewPickCreditRObj();
        if(cl.getObjAL()!=null  && cl.getObjAL().size() > 0){
            //Empno ���i�οn�I
            CreditObj[] crewCtAr = new CreditObj[cl.getObjAL().size()];
            for(int i=0 ;i<cl.getObjAL().size();i++){                
                crewCtAr[i] = (CreditObj) cl.getObjAL().get(i);
            }
            pickCtObjAL.setCrewCtAr(crewCtAr);
            pickCtObjAL.setResultMsg("1");
            pickCtObjAL.setErrorMsg("Done.");
//            crewCtObjAL.setaCrewCtAL(aCl.getObjAL());
        }else{
            pickCtObjAL.setResultMsg("0");
            pickCtObjAL.setErrorMsg("�L���Ŀn�I");
        }
    
    } 
    
    //2. ���Կ�Z��� �ˬd
    public void ChkPickAttInfo(String empno,String yyyy,String mm){
        ArrayList fullAttendAL = new ArrayList();
        FullAttendanceForPickSkj faps = new FullAttendanceForPickSkj(empno);
//        SimpleDateFormat f = new SimpleDateFormat("yyyy/MM/dd");
//        GregorianCalendar cal1 = new GregorianCalendar();//now
//        String today = f.format(cal1.getTime());        
        pickAttObjAL = new CrewPickFullAttRObj();
        faps.getCheckRange3();//since 2012/09/01
        fullAttendAL = faps.getFullAttendanceRange2();
        if(fullAttendAL!=null  && fullAttendAL.size() > 0){
            //Empno ���i�Υ��Կ�Z
            FullAttendanceForPickSkjObj[] crewAttAr = new FullAttendanceForPickSkjObj[fullAttendAL.size()];
            for(int i=0 ;i<fullAttendAL.size();i++){                
                crewAttAr[i] = (FullAttendanceForPickSkjObj) fullAttendAL.get(i);
            }
            pickAttObjAL.setCrewAttAr(crewAttAr);
            pickAttObjAL.setResultMsg("1");
            pickAttObjAL.setErrorMsg("Done.");
        }else{
            pickAttObjAL.setResultMsg("0");
            pickAttObjAL.setErrorMsg("�L���Կn�I");
        }
    }
    
    //3. �e�X�n�I��Z��  reason = 2
    public CrewMsgObj SendPickCtForm(String[] chkItem,String empno,String base){
        Connection conn = null;
        Statement stmt = null;
        String sql = "";
        ResultSet rs = null;
//        Driver dbDriver = null;
        int count = 0;
        String credit3 = "";
        CrewMsgObj MsgObj = new CrewMsgObj();
        if("TPE".equals(base)){
        	base = "1";
        }else if("KHH".equals(base)){
        	base = "2";
        }
        if(chkItem.length > 0 && ("1".equals(base) || "2".equals(base)))//chkItem->obj.getSno()
        {
            for(int i=0;i<chkItem.length;i++)
            {
                credit3 = credit3 + ","+chkItem[i];
            }
            try 
            {
                ConnectionHelper ch = new ConnectionHelper();
                conn = ch.getConnection();  
                conn.setAutoCommit(false);  
                stmt = conn.createStatement();
                
    			sql = "insert into egtpick (sno, empno, new_tmst, reason, valid_ind, credit3) values ( (select max(sno)+1 from egtpick),'"+empno+"',sysdate,'2','Y','"+credit3.substring(1)+"') ";
    //out.println(sql+"<br>");
    			stmt.executeUpdate(sql);
    			//***********************************************************************************
    			sql = "update egtcrdt set intention='1', used_ind='Y', upduser='"+empno+"', upddate = sysdate where sno in ("+credit3.substring(1)+") ";
    //out.println(sql+"<br>");
    			stmt.executeUpdate(sql);
    			conn.commit();	
    			
    			MsgObj.setResultMsg("1");
                if("1".equals(MsgObj.getResultMsg()))
                {      
                    if("1".equals(base)){//TPE
                        MsgObj.setErrorMsg("��Z��w�e�X,�Х���<��Z�B�z�w���ӽ�>���o�B�z�ƧǸ��X�A�A�쬣�����d�i�̱ƧǸ��X��z��Z�n�O�C");
                    }else if("2".equals(base)){//KHH
                        MsgObj.setErrorMsg("�Щ�ӽФ��30�Ѥ���ñ���i���Z�Ʃy�C");
                    }
                }

                /*if(count == 3){
                    sql = "insert into egtpick (sno, empno, new_tmst, reason, valid_ind, credit3) " +
                    		"values ( (select max(sno)+1 from egtpick),'"+empno+"',sysdate,'2','Y','"+credit3.substring(1)+"') ";
                    //out.println(sql+"<br>");
                    stmt.executeUpdate(sql);
                    //***********************************************************************************
                    sql = "update egtcrdt set intention='1', used_ind='Y', upduser='"+empno+"', upddate = sysdate where sno in ("+credit3.substring(1)+") ";
                    //out.println(sql+"<br>");
                    stmt.executeUpdate(sql);
                    conn.commit();
                    MsgObj.setResultMsg("1");
                    if("1".equals(MsgObj.getResultMsg()))
                    {      
                        if("1".equals(base)){//TPE
                            MsgObj.setErrorMsg("��Z��w�e�X,�Х���<��Z�B�z�w���ӽ�>���o�B�z�ƧǸ��X�A�A�쬣�����d�i�̱ƧǸ��X��z��Z�n�O�C");
                        }else if("2".equals(base)){//KHH
                            MsgObj.setErrorMsg("��Z��w�e�X,�Щ�ӽЫ�ɧ֦�ñ���i���Z�Ʃy�C");
                        }
                    }
                }else{ 
                    MsgObj.setResultMsg("0");
                    MsgObj.setErrorMsg("�ФĿ�T�ӿn�I������Z���| �� �Ŀ�@�ӿ�Z��!!");
                }*/
                
            } 
            catch (Exception e) 
            {
//                System.out.print(e.toString());
                MsgObj.setResultMsg("0");
                MsgObj.setErrorMsg("����Z�楢��!!"+e.toString());
                try { 
                    conn.rollback(); 
                } //�����~�� rollback
                catch (SQLException e1) { 
                    MsgObj.setResultMsg("0");
                    MsgObj.setErrorMsg("����Z����~!!"+e1.toString());
//                  System.out.print(e1.toString());
                }
            } 
            finally 
            {
                if (rs != null)   try {rs.close(); }   catch (SQLException e) {}
                if (stmt != null) try { stmt.close();} catch (SQLException e) {}
                if (conn != null) try { conn.close(); } catch (SQLException e) {}
                
            }
        }else{
            MsgObj.setResultMsg("0");
            MsgObj.setErrorMsg("�|����h�n�I �� �խ�Base�L��");
        }
        return MsgObj;
        
    }
    
    //4. �e�X���Կ�Z��  reason = 1
    public CrewMsgObj SendPickAttForm(String[] chkItem,FullAttendanceForPickSkjObj[] CrewAttAr,String base){
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        ResultSet rs = null;
//        Driver dbDriver = null;
//        ChkPickAttInfo(empno, yyyy, mm);
        
        CrewMsgObj MsgObj = new CrewMsgObj();
        if(chkItem.length > 0 && null != CrewAttAr && "".equals(CrewAttAr)
                && ("1".equals(base) || "2".equals(base)))//chkItem->idx
        {
            try{
                ConnectionHelper ch = new ConnectionHelper();
                conn = ch.getConnection();  
                conn.setAutoCommit(false);  
    
                sql = "insert into egtpick (sno, empno, new_tmst, reason, valid_ind, sdate, edate, comments )" +
                		" values ( (select max(sno)+1 from egtpick),?,sysdate,'1','Y',to_date(?,'yyyy/mm/dd'),to_date(?,'yyyy/mm/dd'),?) ";
                pstmt = conn.prepareStatement(sql); 
                FullAttendanceForPickSkjObj obj = null;
                for(int i=0;i<chkItem.length;i++)
                {
                    obj = (FullAttendanceForPickSkjObj) CrewAttAr[Integer.parseInt(chkItem[i])];
                    pstmt.setString(1 ,obj.getEmpno());
                    //pstmt.setString(2 ,obj.getCheck_range_final_end());
                    //pstmt.setString(3 ,obj.getCheck_range_start());
                    pstmt.setString(2 ,obj.getCheck_range_start());
                    pstmt.setString(3 ,obj.getCheck_range_final_end());
                    pstmt.setString(4 ,obj.getComments());
                    pstmt.executeUpdate();
                }
                conn.commit();  
                MsgObj.setResultMsg("1");
                if("1".equals(MsgObj.getResultMsg()))
                {      
                    if("1".equals(base)){//TPE
                        MsgObj.setErrorMsg("��Z��w�e�X,�Х���<��Z�B�z�w���ӽ�>���o�B�z�ƧǸ��X�A�A�쬣�����d�i�̱ƧǸ��X��z��Z�n�O�C");
                    }else if("2".equals(base)){//KHH
                        MsgObj.setErrorMsg("��Z��w�e�X,�Щ�ӽЫ�ɧ֦�ñ���i���Z�Ʃy�C");
                    } 
                }
                }catch (Exception e) 
                {
        //                System.out.print(e.toString());
                    MsgObj.setResultMsg("0");
                    MsgObj.setErrorMsg("�����Կ�Z�楢��!!"+e.toString());
                    try { 
                        conn.rollback(); 
                    } //�����~�� rollback
                    catch (SQLException e1) { 
                        MsgObj.setResultMsg("0");
                        MsgObj.setErrorMsg("�����Կ�Z����~!!"+e1.toString());
        //                  System.out.print(e1.toString());
                    }
                } 
                finally 
                {
                    if (pstmt != null) try { pstmt.close();} catch (SQLException e) {}
                    if (conn != null) try { conn.close(); } catch (SQLException e) {}
                    
                }
        }else{
            MsgObj.setResultMsg("0");
            MsgObj.setErrorMsg("�|����h���Կn�I �� �խ�Base�L��");
        }
        return MsgObj;
    }
  
    //4-1. �e�X���Կ�Z��  reason = 1 #�s��
    public CrewMsgObj SendPickAttForm(String empno,String base,String sdate ,String edate,String comment){
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        ResultSet rs = null;
        
        CrewMsgObj MsgObj = new CrewMsgObj();
        if("TPE".equals(base)){
        	base = "1";
        }else if("KHH".equals(base)){
        	base = "2";
        }
        if(("1".equals(base) || "2".equals(base)))
        {
            try{
                ConnectionHelper ch = new ConnectionHelper();
                conn = ch.getConnection();  
                conn.setAutoCommit(false);  
    
                sql = "insert into egtpick (sno, empno, new_tmst, reason, valid_ind, sdate, edate, comments )" +
                		" values ( (select max(sno)+1 from egtpick),?,sysdate,'1','Y',to_date(?,'yyyy/mm/dd'),to_date(?,'yyyy/mm/dd'),?) ";
                pstmt = conn.prepareStatement(sql); 
                FullAttendanceForPickSkjObj obj = null;                
                pstmt.setString(1 ,empno);
                pstmt.setString(2 ,sdate);
                pstmt.setString(3 ,edate);
                pstmt.setString(4 ,comment);
                pstmt.executeUpdate();
                
                conn.commit();  
                MsgObj.setResultMsg("1");
                if("1".equals(MsgObj.getResultMsg()))
                {      
                    if("1".equals(base)){//TPE
                        MsgObj.setErrorMsg("��Z��w�e�X,�Х���<��Z�B�z�w���ӽ�>���o�B�z�ƧǸ��X�A�A�쬣�����d�i�̱ƧǸ��X��z��Z�n�O�C");
                    }else if("2".equals(base)){//KHH
                        MsgObj.setErrorMsg("��Z��w�e�X,�Щ�ӽЫ�ɧ֦�ñ���i���Z�Ʃy�C");
                    } 
                }
                }catch (Exception e) 
                {
        //                System.out.print(e.toString());
                    MsgObj.setResultMsg("0");
                    MsgObj.setErrorMsg("�����Կ�Z�楢��!!"+e.toString());
                    try { 
                        conn.rollback(); 
                    } //�����~�� rollback
                    catch (SQLException e1) { 
                        MsgObj.setResultMsg("0");
                        MsgObj.setErrorMsg("�����Կ�Z����~!!"+e1.toString());
        //                  System.out.print(e1.toString());
                    }
                } 
                finally 
                {
                    if (pstmt != null) try { pstmt.close();} catch (SQLException e) {}
                    if (conn != null) try { conn.close(); } catch (SQLException e) {}
                    
                }
        }else{
            MsgObj.setResultMsg("0");
            MsgObj.setErrorMsg("�|����h���Կn�I �� �խ�Base�L��");
        }
        return MsgObj;
    }
    
    //5.���o�i��������Z��C��
    public void PickApplyList(String empno){
        pickListObjAL = new CrewPickApplyListRObj();
        try
        {
            ArrayList objAL = new ArrayList();
            ArrayList listObjAL = new ArrayList();
            SkjPickList spl = new SkjPickList();
            spl.getSkjPickList("ALL",empno);
            objAL = spl.getObjAL();         
            
            /*if(null != objAL && objAL.size()>0){
                for(int i=0;i<objAL.size();i++){
                    SkjPickObj obj = (SkjPickObj) objAL.get(i);
                    listObjAL.add(obj);
                    CrewPickApplyListObj obj2 = (CrewPickApplyListObj) listObjAL.get(i);
                    obj2.setBid_num(spl.getPick_Num(Integer.toString(obj.getSno())));
                    
                }            
            }*/
            pickListObjAL.setListObjAL(listObjAL);
            pickListObjAL.setResultMsg("1");
            pickListObjAL.setErrorMsg("done");
        }
        catch ( Exception e )
        {
            pickListObjAL.setResultMsg("0");
            pickListObjAL.setErrorMsg(e.toString());
        }
        
    }
    
    //6.���o����//2015������
    public void PickApplyNum(String empno,String base,String sno){
        //srctype 
        //1:��Z�B�z�w������ 
        //2:�h��/���Z�ӽйw������
        pickNumObjAL = new CrewPickApplyNumRObj();
        String returnmsg = "";
        
        if("TPE".equals(base)){
            Connection conn = null;
            PreparedStatement pstmt = null;
            Statement stmt = null;      
            ResultSet rs = null;    
            String sql = "";
            String returnstr = "";
            String work_date = "";
            int count = 0;
            int bid_num = 0;
            String ifY = "Y";// 16:30~ 18:00 �����z
        	String ifY2 = "Y"; // �����z��
            try 
            {
                ConnectionHelper ch = new ConnectionHelper();
                conn = ch.getConnection();  
                stmt = conn.createStatement();

                sql = " SELECT   d.*, (SELECT  To_Char(CASE WHEN SYSDATE >= Trunc(sysdate)+18/24 THEN Trunc(sysdate)+1 ELSE Trunc(sysdate) END,'yyyy/mm/dd') FROM dual ) work_date , CASE WHEN (SELECT  CASE WHEN SYSDATE >= Trunc(sysdate)+18/24 THEN Trunc(sysdate)+1 ELSE Trunc(sysdate) END FROM dual) BETWEEN to_Date(To_Char(setdate,'yyyymmdd')||' 16:31:00','yyyymmdd hh24:mi:ss') AND to_Date(To_Char(setedate,'yyyymmdd')||' 17:59:59','yyyymmdd hh24:mi:ss') THEN 'N' ELSE 'Y' END s FROM fztsetd d ";

    			rs = stmt.executeQuery(sql);			
    			while (rs.next())
    			{
    				if("N".equals(rs.getString("s")))
    				{
    					ifY2="N";
    					work_date = rs.getString("work_date");
    				}
    			}
    			rs.close();

    			if("N".equals(ifY2))
    			{
    				returnmsg = work_date + " ���D�W�Z��C";
    			}
    			else
    			{

    				sql = " SELECT CASE WHEN SYSDATE BETWEEN to_Date(To_Char(SYSDATE,'yyyymmdd')||' 16:31:00','yyyymmdd hh24:mi:ss') AND to_Date(To_Char(SYSDATE,'yyyymmdd')||' 17:59:59','yyyymmdd hh24:mi:ss') THEN 'N' ELSE 'Y' END ifY FROM dual";

    				rs = stmt.executeQuery(sql);			
    				if (rs.next())
    				{
    					ifY = rs.getString("ifY").trim();
    				}
    				rs.close();

    				if("Y".equals(ifY))
    				{

    					sql = " SELECT Count(*) c FROM egtpick_bid WHERE empno ='"+empno+"' and work_date = (CASE WHEN SYSDATE >= Trunc(sysdate)+18/24 THEN Trunc(sysdate)+1 ELSE Trunc(sysdate) end) ";

    					rs = stmt.executeQuery(sql);			
    					if (rs.next())
    					{
    						count = rs.getInt("c");
    					}
    					rs.close();

    					if(count>=3)
    					{
    						returnmsg = "�C�H�C��ȭ������T���C";
    					}
    					else
    					{
    						count = 0;
    						//********************************
    						sql = " SELECT Nvl(Max(sno),0)+1 c FROM egtpick_bid ";
    						rs = stmt.executeQuery(sql);			
    						if (rs.next())
    						{
    							count = rs.getInt("c");
    						}
    						rs.close();
    						//***********************************************************			
    						sql = " SELECT Nvl(Max(bid_num),0)+1 c2, To_Char(CASE WHEN SYSDATE >= Trunc(sysdate)+18/24 THEN Trunc(sysdate)+1 ELSE Trunc(sysdate) END,'yyyy/mm/dd') work_date FROM egtpick_bid WHERE work_date = (CASE WHEN SYSDATE >= Trunc(sysdate)+18/24 THEN Trunc(sysdate)+1 ELSE Trunc(sysdate) end) ";
    						rs = stmt.executeQuery(sql);			
    						if (rs.next())
    						{
    							bid_num = rs.getInt("c2");
    							work_date = rs.getString("work_date");
    						}
    						rs.close();

    						if(bid_num <= 150 )
    						{
    							sql = "insert into egtpick_bid (sno, pick_sno, empno, bid_num, bid_time, work_date) values ( ?,?,?,?,sysdate,to_date(?,'yyyy/mm/dd')) ";
    							pstmt = conn.prepareStatement(sql);	
    							pstmt.setInt(1 ,count);
    							pstmt.setString(2 ,sno);
    							pstmt.setString(3 ,empno);
    							pstmt.setInt(4 ,bid_num);
    							pstmt.setString(5 ,work_date);
    							pstmt.executeUpdate();
    							returnmsg = "���o���B�z�Ǹ� : "+ bid_num+" ��";
    						}
    						else
    						{
    							returnmsg = "�w�F�C��B�z�W��!";
    						}
    					}
    				}
    				else
    				{
    					returnmsg = "16:31:00 ~ 17:59:59 �������w��!";
    				}
    			}//�O�_���W�Z��
                if(null != pickNumObjAL.getNum() && "".equals(pickNumObjAL.getNum())){
                    pickNumObjAL.setResultMsg("1");
                    pickNumObjAL.setErrorMsg(returnmsg);
                }else{
                    pickNumObjAL.setResultMsg("0");
                    pickNumObjAL.setErrorMsg(returnmsg);
                }
                
            } 
            catch (Exception e) 
            {
                returnmsg = e.toString();
                pickNumObjAL.setResultMsg("0");
                pickNumObjAL.setErrorMsg(returnmsg);
            } 
            finally 
            {
                if (rs != null) try { rs.close();} catch (SQLException e) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
                if (pstmt != null) try { pstmt.close();} catch (SQLException e) {}
                if (conn != null) try { conn.close(); } catch (SQLException e) {}
                
            }
        }else{
            pickNumObjAL.setResultMsg("1");
            pickNumObjAL.setErrorMsg("TPE only.");
        }
    }
    
    //7.�B�z��Z�w���i�׬d��
    public void PocessPickQuery(){
        SkjPickList spl = new SkjPickList();
        ArrayList bidAL = new ArrayList();        
        bidAL = spl.getPick_Handle_List();
        ProcPickObjAL = new CrewPickProcessRObj();
        ProcPickObjAL.setBidAL(bidAL);
        ProcPickObjAL.setResultMsg("1");
        ProcPickObjAL.setErrorMsg("done");
    }
    
    
    
    public CrewPickCreditRObj getPickCtObjAL()
    {
        return pickCtObjAL;
    }

    public void setPickCtObjAL(CrewPickCreditRObj pickCtObjAL)
    {
        this.pickCtObjAL = pickCtObjAL;
    }

    
    public CrewPickFullAttRObj getPickAttObjAL()
    {
        return pickAttObjAL;
    }

    public void setPickAttObjAL(CrewPickFullAttRObj pickAttObjAL)
    {
        this.pickAttObjAL = pickAttObjAL;
    }

    
    public CrewPickApplyListRObj getPickListObjAL()
    {
        return pickListObjAL;
    }

    public void setPickListObjAL(CrewPickApplyListRObj pickListObjAL)
    {
        this.pickListObjAL = pickListObjAL;
    }
    

    public CrewPickApplyNumRObj getPickNumObjAL()
    {
        return pickNumObjAL;
    }

    public void setPickNumObjAL(CrewPickApplyNumRObj pickNumObjAL)
    {
        this.pickNumObjAL = pickNumObjAL;
    }

    public CrewPickProcessRObj getProcPickObjAL()
    {
        return ProcPickObjAL;
    }

    public void setProcPickObjAL(CrewPickProcessRObj procPickObjAL)
    {
        ProcPickObjAL = procPickObjAL;
    }


    
    
}

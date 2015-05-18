package swap3ac;

import java.util.*;
import java.sql.*;
import ci.db.*;

/**
 * �iAirCrews�������j <br>
 * SwapCheck �̷ӥӽЪ̻P�Q���̪�Prjcr�δ��᭸��,�]�w�O�_�ŦX���Z�ɼƭ���
 * 
 * @author cs66
 * @version 1.0 2006/01/10
 * @version 2.0 2009/03/03 �W��100�p�ɭקאּ 95�p��
 * @version 3.0 2011/12/22 �W��95�p�ɭקאּ 100�p��
 * @version 3.0 2012/01/19 �W��100�p�ɭקאּ 95�p��
 * 
 * Copyright: Copyright (c) 2005
 */
public class SwapCheck 
{
        public static void main(String[] args) {
            SwapCheck s = new SwapCheck("10115","4625","7810","6930","2011","12");
            
//             System.out.println(s.getFlow());
//             System.out.println(s.getErrorMsg());
        }

    private String aPrjcr;
    private String rPrjcr;
    private String aSwapCr;
    private String rSwapCr;
    private int top_limit = 10000;// origial��9500    
    //private int top_limit = 9500;// origial��10000 
    private int button_limit = 7000;
    private int flow;
    private boolean exchangeable = false;
    private String errorMsg; 

    public SwapCheck(String aPrjcr, String rPrjcr, String aSwapCr,String rSwapCr) 
    {
        this.aPrjcr = aPrjcr;
        this.rPrjcr = rPrjcr;
        this.aSwapCr = aSwapCr;
        this.rSwapCr = rSwapCr;
        
        GregorianCalendar cal1 = new GregorianCalendar();
        GregorianCalendar cal2 = new GregorianCalendar();//now
        //2012/01/19 change        
        cal1.set(Calendar.YEAR,2012);
        cal1.set(Calendar.MONTH,1-1);
        cal1.set(Calendar.DATE,19);
        cal1.set(Calendar.HOUR_OF_DAY,16);
        cal1.set(Calendar.MINUTE,1);
        
        if(cal1.before(cal2) | cal1.equals(cal2))
        {
            top_limit = 9500;
        }      
        
        setFlow();
    }
    
    public SwapCheck(String aPrjcr, String rPrjcr, String aSwapCr,String rSwapCr,String yyyy, String mm) 
    {
        this.aPrjcr = aPrjcr;
        this.rPrjcr = rPrjcr;
        this.aSwapCr = aSwapCr;
        this.rSwapCr = rSwapCr;
        setCrRange(yyyy, mm);
        setFlow();
    }
    
    public void setCrRange(String yyyy, String mm) 
    {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;		
		Driver dbDriver = null;

		try 
		{
		    ConnDB cn = new ConnDB();
			// User connection pool to ORP3DF
			cn.setORP3FZUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			// �����s�u
//			 cn.setORT1FZ();
//			 java.lang.Class.forName(cn.getDriver());
//			 conn = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());

			sql = " SELECT * FROM fztspub WHERE  yyyy='"+yyyy+"' AND mm = '"+mm+"'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) 
			{
			    top_limit = rs.getInt("upper_limit");			    
			    button_limit = rs.getInt("lower_limit");	
//			    System.out.println(top_limit+"  "+button_limit);
			}
		} 
		catch (SQLException e) 
		{
			System.out.print(e.toString());
		} 
		catch (Exception e) 
		{
			System.out.print(e.toString());
		} 
		finally 
		{
			if (rs != null)
				try 
				{
					rs.close();
				} 
				catch (SQLException e) 
				{}
			if (pstmt != null)
				try 
				{
					pstmt.close();
				} 
				catch (SQLException e) {}
			if (conn != null)
				try 
				{
					conn.close();
				} 
				catch (SQLException e) {}
		}
	}

    private void setFlow() 
    {
        int aPr = Integer.parseInt(aPrjcr);
        int rPr = Integer.parseInt(rPrjcr);
        int aSwap = Integer.parseInt(aSwapCr);
        int rSwap = Integer.parseInt(rSwapCr);

        if ( aPr > top_limit ) 
        {//crew a's ori cr > �W��
            if ( rPr > top_limit ) 
            {//crew b's ori cr > �W��
                //              flow = 11;
                if ( (aSwap <= aPr ) && (rSwap <= rPr ) ) 
                {
                    setExchangeable(true);
                } 
                else 
                {
                    setErrorMsg(1);
                }
            } 
            else if ( rPr >= button_limit && rPr <= top_limit ) 
            {
                //                flow = 12;

                if ( aSwap <= aPr && (rSwap >= button_limit && rSwap <= top_limit ) ) 
                {
                    setExchangeable(true);
                } 
                else 
                {
                    setErrorMsg(2);
                }
            } 
            else if ( rPr < button_limit ) 
            {
                //                flow = 13;
                if ( (aSwap <= aPr ) && (rSwap >= rPr ) ) 
                {
                    setExchangeable(true);
                } 
                else 
                {
                    setErrorMsg(3);
                }
            }
        } 
        else if ( aPr >= button_limit && aPr <= top_limit ) 
        {
            if ( rPr > top_limit ) 
            {
                //               flow = 21;
                if ( (aSwap >= button_limit && aSwap <= top_limit ) && (rSwap <= rPr ) ) 
                {
                    setExchangeable(true);
                } 
                else 
                {
                    setErrorMsg(4);
                }

            } 
            else if ( rPr >= button_limit && rPr <= top_limit ) 
            {
                //                flow = 22;
                if ( (aSwap >= button_limit && aSwap <= top_limit )
                        && (rSwap >= button_limit && rSwap <= top_limit ) ) 
                {
                    setExchangeable(true);
                } 
                else 
                {
                    setErrorMsg(5);
                }
            } 
            else if ( rPr < button_limit ) 
            {
                //                flow = 23;
                if ( (aSwap >= button_limit && aSwap <= top_limit ) && (rSwap >= rPr ) ) 
                {
                    setExchangeable(true);
                } 
                else 
                {
                    setErrorMsg(6);
                }
            }
        } 
        else if ( aPr < button_limit ) 
        {
            if ( rPr > top_limit ) 
            {
                //                flow = 31;
                if ( (aSwap >= aPr ) && (rSwap <= rPr ) ) 
                {
                    setExchangeable(true);
                } 
                else 
                {
                    setErrorMsg(7);
                }

            } 
            else if ( rPr >= button_limit && rPr <= top_limit ) 
            {
                //                flow = 32;
                if ( (aSwap >= aPr ) && ((rSwap >= button_limit && rSwap <= top_limit ) ) ) 
                {
                    setExchangeable(true);
                } 
                else 
                {
                    setErrorMsg(8);
                }
            } 
            else if ( rPr < button_limit ) 
            {
                //                flow = 33;
                if ( (aSwap >= aPr ) && (rSwap >= rPr ) ) 
                {
                    setExchangeable(true);
                } 
                else 
                {
                    setErrorMsg(9);
                }
            }
        }
    }

    public int getFlow() {
        return flow;
    }

    public boolean isExchangeable() {
        return exchangeable;
    }

    private void setExchangeable(boolean exchangeable) {
        this.exchangeable = exchangeable;
    }

    private void setErrorMsg(int errorCode) {
        errorMsg = "";
        switch (errorCode) {
        case 1:
            //            errorMsg = "�ӽЪ̻P�Q���̴��᭸�ɡA�ݤp�󴫫e����.";
            errorMsg = "�ӽЪ̻P�Q����,���᭸�ɧ��ݤj��Τp�󴫫e����.";
            break;
        case 2:
            errorMsg = "�ӽЪ̴��᭸�ɻݤp�󴫫e����,<br>�Q���̴��᭸�ɡA�ݤ���"+top_limit/100+"�P"+button_limit/100+"�p�ɤ���";
//            errorMsg = "�ӽЪ̻ݴ����C�ɼ�,<br>�Q���̴��᭸�ɡA�ݤ���95�P70�p�ɤ���";
            break;
        case 3:
            //            errorMsg = "�ӽЪ̴��᭸�ɻݩ󴫫e����,<br>�Q���̴��᭸�ɻݤj�󴫫e����";
            errorMsg = "�ӽЪ̻ݴ����C�ɼ�,<br>�Q���̻ݴ������ɼ�";
            break;
        case 4:
            errorMsg = "�ӽЪ̴��᭸�ɻݤ���"+top_limit/100+"�P"+button_limit/100+"�p�ɤ���.<br>�Q���̴��᭸�ɻݤp�󴫫e����";
//            errorMsg = "�ӽЪ̴��᭸�ɻݤ���95�P70�p�ɤ���.<br>�Q���̻ݴ����C�ɼ�";
            break;
        case 5:
//            errorMsg = "�ӽЪ̻P�Q����,���᭸�ɧ��ݤ���95�P70�p�ɤ���.";
            errorMsg = "�ӽЪ̻P�Q����,���᭸�ɧ��ݤ���"+top_limit/100+"�P"+button_limit/100+"�p�ɤp�ɤ���.";
            break;
        case 6:
            errorMsg = "�ӽЪ̴��᭸�ɻݤ���"+top_limit/100+"�P"+button_limit/100+"�p�ɤ���.<br>�Q���̴��᭸�ɻݤj�󴫫e����";
//            errorMsg = "�ӽЪ̴��᭸�ɻݤ���95�P70�p�ɤ���.<br>�Q���̻ݴ������ɼ�";
            break;
        case 7:
            //     errorMsg = "�ӽЪ̴��᭸�ɻݤj�󴫫e����,<br>�Q���̴��᭸�ɻݤp�󴫫e����";
            errorMsg = "�ӽЪ̻ݴ������ɼ�,<br>�Q���̻ݴ����C�ɼ�";
            break;
        case 8:
            errorMsg = "�ӽЪ̴��᭸�ɻݤj�󴫫e����,<br>�Q���̴��᭸�ɡA�ݤ���"+top_limit/100+"�P"+button_limit/100+"�p�ɤ���";
//            errorMsg = "�ӽЪ̻ݴ������ɼ�,<br>�Q���̴��᭸�ɡA�ݤ���95�P70�p�ɤ���";
            break;
        case 9:
            //              errorMsg = "�ӽЪ̻P�Q����,���᭸�ɧ��ݤj�󴫫e����";
            errorMsg = "�ӽЪ̻P�Q����,���᭸�ɧ��ݤj��ε��󴫫e����.";
            break;

        default:
            errorMsg = "";
            break;
        }

    }

    public String getErrorMsg() 
    {
        return errorMsg;
    }
}
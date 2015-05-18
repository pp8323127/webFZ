package eg.off;

import java.sql.*;
import java.util.*;

import tool.*;

import ci.db.*;

/**
 * @author cs71 Created on  2008/1/17
 */
public class OffsheetRejectEmail
{
    private Driver dbDriver = null;
    private static Connection conn = null;
    private static Statement stmt = null;
    private static ResultSet rs = null;
    private String sql = null;
    private ArrayList objAL = null;
    private ArrayList objCountAL = null;
    private String errorstr = "";

    public static void main(String[] args)
    {
        OffsheetRejectEmail ore = new OffsheetRejectEmail();
        System.out.println(ore.setOffsheetRejectEmail("000362","reject reject"));
        System.out.println("Done");
    }

    public String setOffsheetRejectEmail(String form_num, String rejstr)
    {       
        String sender = "";
        String receiver ="";
        String cc = "";
        String mailSubject =""; 
        StringBuffer mailContent = new StringBuffer();
        
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();

            //******************************************************************************
            
            sql = " SELECT trim(offno) offno,trim(empn) empn,sern,offtype,To_Char(offsdate,'yyyy/mm/dd') offsdate, " +
            	  " To_Char(offedate,'yyyy/mm/dd') offedate, offdays,offftno,station,remark,offyear," +
            	  " gradeyear,newuser,to_Char(newdate, 'yyyy/mm/dd hh24:mi:ss') newdate, " +
            	  " chguser,to_Char(chgdate, 'yyyy/mm/dd hh24:mi:ss') chgdate, form_num,leaverank," +
            	  " reassign, ef_judge_status, ef_judge_user," +
            	  " to_Char(ef_judge_tmst, 'yyyy/mm/dd hh24:mi:ss') ef_judge_tmst, ed_inform_user," +
            	  " to_Char(ed_inform_tmst, 'yyyy/mm/dd hh24:mi:ss') ed_inform_tmst, doc_status, " +
            	  " delete_user, to_Char(delete_tmst, 'yyyy/mm/dd hh24:mi:ss') delete_tmst FROM egtoffs " +
            	  " WHERE form_num = '"+form_num+"'  and trunc(ef_judge_tmst,'dd') = trunc(sysdate,'dd') " +
	          	  " order by offsdate desc ";  
            
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);
            int i = 1;
            while (rs.next())
            {
                if(i==1)
                {
                    if("KHH".equals(rs.getString("station")))
                    {
                        sender = "khhefcibox@email.china-airlines.com";
                    }
                    else
                    {//TPE
                        sender = "TPEEFCI@email.china-airlines.com";
                    }
                    receiver = rs.getString("empn") +"@cal.aero";
//                    receiver ="640790@cal.aero";
//                    receiver = "jennychi@china-airlines.com";
                    mailSubject = "客艙組員請休假申請單";      
                    mailContent.append("假單編號 :\r\n");
                }
                mailContent.append("      "+rs.getString("offno")+" : "+rs.getString("offsdate")+"~"+rs.getString("offedate")+"\r\n");
                
                i++;
            }
            
            if(i>1)
            {//got data
                mailContent.append("審核 : 退回\r\n");
                mailContent.append("審核意見 : "+rejstr+"\r\n");
                mailContent.append("\r\n");
                mailContent.append("備註 : 詳細資訊請登入請休假系統查詢\r\n");
//                System.out.println(mailContent.toString());
                Email al = new Email();
                String str = al.sendEmail( sender,  receiver, cc, mailSubject, mailContent);
                if("0".equals(str))
                {
                    errorstr = "Y";
                }
                else
                {
                    errorstr = str;
                }
            }
            else
            {
                errorstr = "Email failed!!";    
            }
            //******************************************************************************
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            errorstr = e.toString();
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
        return errorstr ;
    }
    
}

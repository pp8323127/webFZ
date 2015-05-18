package df.overTime.ac;

import java.math.*;
import java.sql.*;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import ci.db.*;

/**
 * @author cs71 Created on  2006/8/31
 */
public class SBIREmail_AC
{
    private String yyyy = "";
    private String mm = "" ;
    private String empno = "";
    private String returnstr = "";
    ArrayList empnoAL = new ArrayList();
    
    Connection conn = null;
    Statement stmt = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String sql = null;
    Driver dbDriver = null;
    
    public static void main(String[] args)
    {
        SBIREmail_AC s = new SBIREmail_AC("2011","07","632268");
        s.setEmpnoObj();
        System.out.println(s.getReturnStr());
        System.out.println("Done");
    }
    
    public SBIREmail_AC(String yyyy, String mm)
    {
        this.yyyy = yyyy ;
        this.mm = mm ;        
        
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
      
            sql = " SELECT DISTINCT(empno) empno FROM dftovrp " +
            	  " WHERE paymm = to_char(last_day(to_date('"+yyyy+mm+"01','yyyymmdd'))+1,'yyyymm') ";
            
            rs = stmt.executeQuery(sql);
            
            while(rs.next())
            {
                empnoAL.add(rs.getString("empno"));
            }
           
        }
        catch ( SQLException e )
        {
            System.out.print(e.toString());
        }
        catch ( Exception e )
        {
            System.out.print(e.toString());
            e.printStackTrace();
        }
        finally
        {
            if (rs != null)
                try
                {
                    rs.close();
                }
                catch ( SQLException e )
                {
                }
            if (stmt != null)
                try
                {
                    stmt.close();
                }
                catch ( SQLException e )
                {
                }
            if (conn != null)
                try
                {
                    conn.close();
                }
                catch ( SQLException e )
                {
                }
        }

    }
    
    public SBIREmail_AC(String yyyy, String mm, String empno)
    {
        this.yyyy = yyyy ;
        this.mm = mm ;
        empnoAL.add(empno);
    }
    
    public void setEmpnoObj()
    {
        try
        {            
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
            
	        for(int i=0; i<empnoAL.size(); i++)
	        {           	            
	            ArrayList objAL = new ArrayList();
            
	            sql = " SELECT f.empno empno, w.name||'  '||w.ename name, " +
	            	  " To_Char(f.act_takeoff_utc,'yyyy/mm/dd') fdate, " +
	            	  " lpad(f.fltno,4,'0') fltno, " +
	            	  " nvl(f.overmins,0) adjmins, f.port_a||'/'||f.port_b sect, nvl(p.ovrpayratedd,0) rate, " +
	            	  " nvl(f.overmins2,0) adjmins2, round(nvl(p.ovrpayratedd/1.66*2,0),0) rate2, " +
	            	  " p.ovrmindd ovrmindd, " +
	            	  " p.ovrmindd2 ovrmindd2, p.ovrpaydd ovrpaydd, " +
	            	  " CASE WHEN f.sbirflag IS NOT NULL  THEN '(*)' else ' ' END sbir " +
	            	  " FROM dfdb.dftovrp f, dfdb.dftpock p, dfdb.dftcrew w " +
	            	  " WHERE f.empno = w.empno (+) " +
	            	  " AND f.paymm = to_char(last_day(to_date('"+yyyy+mm+"01','yyyymmdd'))+1,'yyyymm') " +
	            	  " AND f.overmins > 0 AND f.empno = '"+empnoAL.get(i)+"' " +
	            	  " AND f.empno = p.empno AND p.yyyy = '"+yyyy+"' AND p.mm = '"+mm+"' AND p.ovrpaydd > 0 ";
	            
//	            System.out.println(sql);
	            rs = stmt.executeQuery(sql);	            

	            while(rs.next())
	            {
		            SBIREmailObj obj = new SBIREmailObj();
		            obj.setEmpno(rs.getString("empno"));
		            obj.setName(rs.getString("name"));
		            obj.setFltno(rs.getString("fltno"));
		            obj.setFdate(rs.getString("fdate"));
		            obj.setSect(rs.getString("sect"));
		            obj.setOvermin(rs.getString("adjmins"));
		            obj.setOvermin2(rs.getString("adjmins2"));
		            obj.setRate(rs.getString("rate"));
		            obj.setRate2(rs.getString("rate2"));
		            obj.setSbir(rs.getString("sbir"));
		            obj.setOvrpaydd(rs.getString("ovrpaydd"));
		            obj.setOverhrs(rs.getString("ovrmindd"));
		            obj.setOverhrs2(rs.getString("ovrmindd2"));
		            objAL.add(obj);		            
	            }
	            
	            //email overtime payment statement    
	            if(objAL.size()>0)
	            {
	                sendEmail(objAL);
	            }
	            else
	            {
	                returnstr = "N";    
	            }
	        }
        }
        catch ( SQLException e )
        {
            System.out.print(e.toString());
        }
        catch ( Exception e )
        {
            System.out.print(e.toString());
            e.printStackTrace();
        }
        finally
        {
            if (rs != null)
                try
                {
                    rs.close();
                }
                catch ( SQLException e )
                {
                }
            if (pstmt != null)
                try
                {
                    pstmt.close();
                }
                catch ( SQLException e )
                {
                }
            if (conn != null)
                try
                {
                    conn.close();
                }
                catch ( SQLException e )
                {
                }
        }    
    }
    
    
    public void sendEmail(ArrayList objAL)
    { 
        String mailSubject = "";
        StringBuffer mailContent = new StringBuffer();
        String overmins = "0";
        String overmins2 = "0";
        String overpay = "0";
 
        //TODO smtp server
        Properties props = new Properties();
        //props.put("mail.smtp.host", "192.168.2.4");
        props.put("mail.smtp.host", "APmailrly1.china-airlines.com");

        try
        {
            Session mailSession = Session.getInstance(props, null);
            MimeMessage msg = new MimeMessage(mailSession);

            //set sender
            msg.setFrom(new InternetAddress("tpecsci@cal.aero"));

            //email subject --start--            
            SBIREmailObj s = (SBIREmailObj) objAL.get(0);
            mailSubject = s.getFdate().substring(0,7)+" Overtime payment statement";      
            msg.setSubject(mailSubject);
            //email subject --end--

            //set recipient
            String receiver = s.getEmpno() + "@cal.aero";
//            String receiver = "640790@cal.aero";
            InternetAddress[] TheAddresses = InternetAddress.parse(receiver);
            msg.setRecipients(Message.RecipientType.TO,TheAddresses);


            //Email Content --start--
            MimeBodyPart mbp = new MimeBodyPart();
           
            mailContent.append("Staff Num.    : " + s.getEmpno()+"\r\n");
            mailContent.append("Name          : " + s.getName()+"\r\n");
            mailContent.append("Working Month : " + s.getFdate().substring(0,7)+"\r\n");
            mailContent.append("Rate (Scale 1): $" + s.getRate()+"/hour\r\n");
            mailContent.append("Rate (Scale 2): $" + s.getRate2()+"/hour\r\n");
            mailContent.append("\r\n");
            mailContent.append("Date           Fltno   Sector         Overtime(mins)          Total \r\n"); 
            mailContent.append("---------------------------------------------------------------------\r\n");
            mailContent.append("                                 (Scale 1)       (Scale 2) \r\n");
            mailContent.append("                                 ------------------------- \r\n");                    
            for(int i=0; i<objAL.size(); i++)
            {
                SBIREmailObj obj = (SBIREmailObj) objAL.get(i);
                mailContent.append(obj.getFdate().trim()+"     "+obj.getFltno().trim()+"    "+obj.getSect().trim()+"       "+obj.getOvermin().trim()+"              "+obj.getOvermin2().trim()+"    "+obj.getSbir()+"\r\n");
//                overmins = overmins + Integer.parseInt(obj.getOvermin().trim()) + Integer.parseInt(obj.getOvermin2().trim());  
//                overpay = overpay + Integer.parseInt(obj.getOvrpaydd()) ;
                overmins = obj.getOverhrs();
                overmins2 = obj.getOverhrs2();
                overpay = obj.getOvrpaydd();                
            }
          
            mailContent.append("---------------------------------------------------------------------\r\n");
            
            BigDecimal bd = new BigDecimal(Integer.parseInt(overmins));
            BigDecimal bd2 = new BigDecimal(Integer.parseInt(overmins2));
        	BigDecimal min = new BigDecimal(60);
        	BigDecimal rate1 = new BigDecimal(s.getRate());
        	BigDecimal rate2 = new BigDecimal(s.getRate2()); 
            //BigDecimal bd2 = new BigDecimal(((float)overmins/60)*Integer.parseInt(s.getRate().trim()));
            //mailContent.append("Summary (hours/Payment):         "+bd.setScale(2, BigDecimal.ROUND_HALF_UP).toString()+"/"+bd2.setScale(0, BigDecimal.ROUND_HALF_UP).toString()+"\r\n");
            //mailContent.append("Summary (hours/Payment):         "+bd.setScale(2, BigDecimal.ROUND_HALF_UP).toString()+"/"+overpay+"\r\n");
            mailContent.append("Summary (hours/Payment):        "+bd.divide(min,3,3)+"/$"+bd.divide(min,3,3).multiply(rate1).setScale(0,BigDecimal.ROUND_HALF_UP)+"     "+bd2.divide(min,3,3)+"/$"+bd2.divide(min,3,3).multiply(rate2).setScale(0,BigDecimal.ROUND_HALF_UP)+"      $"+overpay+"\r\n");
            mailContent.append("\r\n");
            mailContent.append("(*) 代表待命派飛或空管調整列項\r\n");
            mbp.setContent(mailContent.toString(), "text/plain;charset=big5");
            Multipart mp = new MimeMultipart();
            mp.addBodyPart(mbp);
            //Email Content --end--

            //TODO mail Content
            msg.setContent(mp);

            //send email
            Transport.send(msg);   
            returnstr = "Y";
        } 
        catch (Exception e)
        {
            e.printStackTrace();
            returnstr = "Email error !!\r\n " + e.toString();
        } 
        finally
        {
            
        }
    }
    
    public String getReturnStr()
    {
        return returnstr;
    }   
}

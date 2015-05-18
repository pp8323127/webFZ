package pay;


import java.sql.*;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import ci.db.*;

/**
 * @author cs71 Created on  2006/8/31
 */
public class NoBusEmail
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
        NoBusEmail s = new NoBusEmail("2007","10","638765");
        s.setEmpnoObj();
        System.out.println(s.getReturnStr());
        System.out.println("Done");
    }
    
    public NoBusEmail(String yyyy, String mm)
    {
        this.yyyy = yyyy ;
        this.mm = mm ;        
        
        try
        {
            ConnDB cn = new ConnDB();
            
            cn.setORP3FZUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            stmt = conn.createStatement();

//            cn.setORP3FZUser();
//            java.lang.Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),
//                    cn.getConnPW());
//            stmt = conn.createStatement();
      
            sql = " SELECT DISTINCT(empno) empno FROM dftdalg " +
            	  " WHERE dptdate BETWEEN To_Date('"+yyyy+mm+"01','yyyymmdd') " +
            	  " AND Last_Day(To_Date('"+yyyy+mm+"01','yyyy/mm/dd')) ";
            
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
    
    public NoBusEmail(String yyyy, String mm, String empno)
    {
        this.yyyy = yyyy ;
        this.mm = mm ;
        empnoAL.add(empno);
    }
    
    public void setEmpnoObj()
    {
        try
        {
            ConnDB cn = new ConnDB();
            
            cn.setORP3FZUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            stmt = conn.createStatement();

//            cn.setORP3FZUser();
//            java.lang.Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());
//            stmt = conn.createStatement();
            
            
	        for(int i=0; i<empnoAL.size(); i++)
	        {           	            
	            ArrayList objAL = new ArrayList();
	            sql = " SELECT d.empno empno, c.NAME||' ('||c.ename||')' cename, " +
	            	  " To_Char(dptdate,'yyyy/mm/dd') dptdate, fltno duty, " +
	            	  " dpt, arv, nvl(checkin,'    ') checkin, nvl(checkout,'    ') checkout, carpay " +
	            	  " FROM dftdalg d, dftcrew c " +
	            	  " WHERE d.empno = '"+empnoAL.get(i).toString()+"' and d.empno = c.empno(+) " +
		          	  " and dptdate BETWEEN To_Date('"+yyyy+mm+"01','yyyymmdd') " +
		    	      " AND Last_Day(To_Date('"+yyyy+mm+"01','yyyy/mm/dd')) ";
	            
	            rs = stmt.executeQuery(sql);	            

	            while(rs.next())
	            {
	                SrcObj obj = new SrcObj();
		            obj.setEmpno(rs.getString("empno"));
		            obj.setName(rs.getString("cename"));
		            obj.setDutydate(rs.getString("dptdate"));		
		            if(rs.getString("duty").length()==4)
		            {
		                obj.setDuty(rs.getString("duty")+"     "+ rs.getString("dpt")+"  "+rs.getString("arv"));
		            }
		            else
		            {
		                obj.setDuty(rs.getString("duty")+"  "+ rs.getString("dpt")+"  "+rs.getString("arv"));
		            }
		            obj.setPaymm(rs.getString("checkin")+"  "+rs.getString("checkout"));		
		            obj.setAmount(rs.getString("carpay"));           
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
    
    
    public void sendEmail(ArrayList objAL)
    { 
        String mailSubject = "";
        StringBuffer mailContent = new StringBuffer();
        int amount = 0;
 
        //TODO smtp server
        Properties props = new Properties();
        //props.put("mail.smtp.host", "192.168.2.4");
        props.put("mail.smtp.host","APmailrly1.china-airlines.com");

        try
        {
            Session mailSession = Session.getInstance(props, null);
            MimeMessage msg = new MimeMessage(mailSession);

            //set sender
            msg.setFrom(new InternetAddress("tpecsci@cal.aero"));

            SrcObj s = (SrcObj) objAL.get(0);
            //email subject --start--
            mailSubject = yyyy+"/"+mm+" 無公車時段車費補助明細";      
            msg.setSubject(mailSubject,"big5");
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
            mailContent.append("\r\n");
            mailContent.append("Date        Duty     Dpt  Arv  Checkin/Checkout  Amount        \r\n");
            mailContent.append("------------------------------------------------------------------\r\n");
                                
            for(int i=0; i<objAL.size(); i++)
            {
                SrcObj sbobj =(SrcObj) objAL.get(i);
                mailContent.append(sbobj.getDutydate()+"  "+sbobj.getDuty()+"  "+sbobj.getPaymm()+"        $"+sbobj.getAmount()+"\r\n");
                amount = amount + Integer.parseInt(sbobj.getAmount().trim()) ;  
            }
          
            mailContent.append("------------------------------------------------------------------\r\n");          
 
            mailContent.append("Summary       :                                  $"+amount+"\r\n");
            mbp.setContent(mailContent.toString(),"text/plain;charset=big5");
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

// Created on 2005/9/21 @author cs71
package apis_autorun;

import java.util.*;
import javax.mail.*; 
import javax.mail.internet.*;

public class Email
{
    private java.util.Date time1 = null;

  
    public static void main(String[] args)
    {
        Email al = new Email();
        String sender = "640792@cal.aero";
        String receiver = "betty.yu@china-airlines.com,640790@cal.aero ";
        String cc = "betty.yu@china-airlines.com,640790@cal.aero ";
        String mailSubject = "APIS email test ";
        StringBuffer mailContent = new StringBuffer();
        mailContent.append("Dear kfj\r\n");
        mailContent.append("§Aªºxxxxxxxx!!\r\n");
        mailContent.append("Betty\r\n");
        System.out.println(al.sendEmail( sender,  receiver, cc, mailSubject, mailContent));
        System.out.println("Done");
    }
    
    public String sendEmail(String sender, String receiver, String cc, String mailSubject, StringBuffer mailContent)
    {        
        //TODO smtp server
        String returnstr = "";
        StringBuffer mailContent2 = new StringBuffer();       
        Properties props = new Properties();
		props.put("mail.smtp.host", "APmailrly2.china-airlines.com");

        try
        {
            Session mailSession = Session.getInstance(props, null);
            MimeMessage msg = new MimeMessage(mailSession);
            Multipart mp = new MimeMultipart();   

            //set sender
            msg.setFrom(new InternetAddress(sender));   
            msg.setSubject(mailSubject,"big5");
            //email subject --end--

            //set recipient
//            sender = "tpecsci@cal.aero";
//            cc = "betty.yu@china-airlines.com,640790@cal.aero";
            InternetAddress[] TheAddresses = InternetAddress.parse(receiver);
            msg.setRecipients(Message.RecipientType.TO,TheAddresses);
            if(!"".equals(cc) && cc != null)
            {
	            InternetAddress[] TheAddresses2 = InternetAddress.parse(cc);
	            msg.setRecipients(Message.RecipientType.CC,TheAddresses2);
            }
            //msg.setRecipients(Message.RecipientType.BCC, InternetAddress.parse("640790@cal.aero"));

            //Email Content --start-- 
            MimeBodyPart mbp = new MimeBodyPart();   
            mbp.setContent(mailContent.toString(), "text/plain;charset=big5");  
            mp.addBodyPart(mbp);    
            //Email Content --end--
            
            //TODO mail Content
            msg.setContent(mp);         
            //send email
            Transport.send(msg);
          
            returnstr = "0";

        } 
        catch (Exception e)
        {
            e.printStackTrace();
            returnstr = "Email error !!\r\n " + e.toString();
        } 
        finally
        {
           
        }

        return returnstr;

    }
}


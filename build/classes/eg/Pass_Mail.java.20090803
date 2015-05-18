package eg;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.*;

public class Pass_Mail
{
    public static void main (String arg[])
    {
        try{
        //***************************
            Pass_Mail pm = new Pass_Mail();
            String[] empno = {"631768"};
            String[] cname = {"豬爪延江"};
            String[] passno = {"TZ0069343"};
            String[] exp_date = {"2008/05/11"};
            String[] smail = {"Y"};
            String comm = "您的證照即將過期，詳細作業流程放置在您的組員信箱內，為維護公司與您個人的權益請儘速取閱，謝謝您的配合 !!";
            Pass_Mail PM = new Pass_Mail();
            System.out.println(PM.doSend(empno, cname, passno, exp_date, smail, comm));
        }
        catch(Exception e)
        {
            System.out.println(e.toString());
        }
    }
    public String doSend(String[] empno, String[] cname, String[] passno, String[] exp_date, String[] smail,String comm)
    {
    	String send_office = "";
     
        try{
        	Properties props = new Properties();
	        props.put("mail.smtp.host", "192.168.2.3");
//	        props.put("mail.smtp.host", "192.168.2.4");
	        //**************
	        Session mailSession = Session.getInstance(props,null);
	        MimeMessage msg = new MimeMessage(mailSession);
//	        msg.setFrom(new InternetAddress("TPEEA@email.china-airlines.com"));//空服行政
	        msg.setFrom(new InternetAddress("YING-YING_HSU@email.china-airlines.com"));//空服行政
	        msg.setSubject("Passport/Visa Delay Notice");
	
	        for(int i=0; i < empno.length; i++)
	        {
	            //empno[i]="640790";
	        	if("Y".equals(smail[i].trim()))
	        	{
			        msg.setRecipient(Message.RecipientType.TO,new InternetAddress(empno[i].trim()+"@cal.aero"));
			        //msg.setRecipient(Message.RecipientType.TO,new InternetAddress("638716@cal.aero"));
			        msg.setRecipient(Message.RecipientType.BCC,new InternetAddress("YING-YING_HSU@email.china-airlines.com"));
			        send_office = send_office + "已寄出通知給 " + empno[i] + "  " + cname[i] + "\r\n\r\n";
			        msg.setContent(empno[i]+" "+cname[i]+" "+passno[i]+" "+exp_date[i]+"\r\n\r\n"+comm, "text/plain; charset=big5");
			        Transport.send(msg);
	        	}
	        }
	        //寄出已通知組員訊息給TPEEA 石儀 6655
//	        msg.setSubject("Passport/Visa Delay Notice -- Mail Check List");
//	        //msg.setRecipient(Message.RecipientType.TO,new InternetAddress("yi_shih@email.china-airlines.com"));
//	        msg.setRecipient(Message.RecipientType.TO,new InternetAddress("640790@cal.aero"));
//	        msg.setContent(send_office + "內容:" + comm, "text/plain; charset=big5");
//	        Transport.send(msg);
	        //***********************************
	        msg = null;
	                      
	        return "0";    
         
        } catch(Exception e) {
        	return "Pass_Mail.java " + e.toString();
        }
    }
}
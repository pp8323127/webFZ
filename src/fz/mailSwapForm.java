package fz;

import java.util.*;

import javax.mail.*;
import javax.mail.internet.*;

/**
 * mailSwapForm 
 *
 * @author  cs66  
 * @version 1.0    2006/3/3
 * 
 * Copyright: Copyright (c) 2006
 */
public class mailSwapForm {

	private String errMsg = "";
	private boolean mailStatus = false;
    
    public String sendForm(String[] formno, String[] aempno, String[] rempno, String[] cf, String[] comm,String[] addComm)
    {
        String cfm=null;
        Properties props = new Properties();
//        props.put("mail.smtp.host", "192.168.2.4");
        props.put("mail.smtp.host", "APmailrly2.china-airlines.com");
        try {
        Session mailSession = Session.getInstance(props,null);
        
        MimeMessage msg = new MimeMessage(mailSession);
        
        for(int i = 0; i < formno.length; i++)
        {	
                if (cf[i].equals("Y"))
                {
                        cfm = "核准";
                }
                else
                {
                        cfm = "退回";
                }
        	msg.setFrom(new InternetAddress("tpecsci@cal.aero"));
        	
        	msg.setRecipients(Message.RecipientType.TO,InternetAddress.parse(aempno[i]+"@cal.aero"));
        	msg.setRecipients(Message.RecipientType.CC,(Address[])InternetAddress.parse(rempno[i]+"@cal.aero"));
        	msg.setSubject("客艙組員任務互換申請單");
        	msg.setContent("ApplyNumber : "+formno[i]+" \r\nConfirm : "+cfm+"\r\nComments : "+addComm[i]+" "+comm[i], "text/plain; charset=big5");  // added big5
        	
        	Transport.send(msg);
        }
        	msg = null;
                return "0";        
        } catch(Exception e) {
        	//e.printStackTrace();
        	return e.toString();
        }
    }
    
    
    /**
     * FOR 高雄換班申請單確認信件
     *  
     * @param formno
     * @param aempno
     * @param rempno
     * @param cf
     * @param comm
     * @param addComm
     *  
     */
    public void sendSwapFormMail(String[] formno, String[] aempno, String[] rempno, String[] cf, String[] comm,String[] addComm)
    {
        String cfm=null;
        Properties props = new Properties();
//        props.put("mail.smtp.host", "192.168.2.4");
        props.put("mail.smtp.host", "APmailrly2.china-airlines.com");
        try {
        Session mailSession = Session.getInstance(props,null);
        
        MimeMessage msg = new MimeMessage(mailSession);
        
        for(int i = 0; i < formno.length; i++)
        {	
                if (cf[i].equals("Y"))
                {
                        cfm = "核准";
                }
                else
                {
                        cfm = "退回";
                }
        	msg.setFrom(new InternetAddress("khhefcibox@email.china-airlines.com"));
        	
        	msg.setRecipients(Message.RecipientType.TO,InternetAddress.parse(aempno[i]+"@cal.aero"));
        	msg.setRecipients(Message.RecipientType.CC,(Address[])InternetAddress.parse(rempno[i]+"@cal.aero"));
        	msg.setSubject("客艙組員任務互換申請單");
        	msg.setContent("ApplyNumber : "+formno[i]+" \r\nConfirm : "+cfm+"\r\nComments : "+addComm[i]+" "+comm[i], "text/plain; charset=big5");  // added big5
        	
        	Transport.send(msg);
        }
        	msg = null;
        	mailStatus = true;
        	
        } catch(Exception e) {
        	mailStatus = false;
        	errMsg = "ERROR:"+e.toString();
        	
        }
    }
	
	public String getErrMsg() {
		return errMsg;
	}

	
	private void setErrMsg(String errMsg) {
		this.errMsg = errMsg;
	}

	
	public boolean isMailStatus() {
		return mailStatus;
	}

	
	private void setMailStatus(boolean mailStatus) {
		this.mailStatus = mailStatus;
	}
}

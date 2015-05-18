package fz;

import java.sql.*;
import java.util.*;
import java.io.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;

public class crewHour
{
    
    public String sendFile(String rs)
    {
        Properties props = new Properties();
        props.put("mail.smtp.host", "192.168.2.4");
        try {
        Session mailSession = Session.getInstance(props,null);
        
        MimeMessage msg = new MimeMessage(mailSession);
        //attach file
        MimeMultipart mm = new MimeMultipart();
        MimeBodyPart mbp = new MimeBodyPart();
        FileDataSource fds = new FileDataSource("/apsource/csap/projfz/webap/crewhour.txt");
        DataHandler dh = new DataHandler(rs, "text/plain; charset=big5");
        mbp.setDataHandler(dh);
        mm.addBodyPart(mbp);
        mbp = new MimeBodyPart();
        mbp.setDataHandler(new DataHandler(fds));
        mbp.setFileName("crewhour.txt");
        mm.addBodyPart(mbp);
        
    	msg.setFrom(new InternetAddress("TSA"));
	
	msg.setRecipients(Message.RecipientType.TO,InternetAddress.parse("TPEOSCI@email.china-airlines.com"));
	//msg.setRecipients(Message.RecipientType.TO,InternetAddress.parse("christi@china-airlines.com"));
	msg.setSubject("Crew Hours Information Report");
	msg.setContent(mm);
	
	Transport.send(msg);

	msg = null;
        return "0";    //send mail success    
        } catch(Exception e) {
        	e.printStackTrace();
        	return e.toString();
        }
    }
    public String makeFile(String[] fleet, String[] cname, String[] occu, String[] flyhours, String[] landtime, String tfilepath) throws Exception
    {
        FileWriter fw = new FileWriter(tfilepath,false);
        String rstring = "";
        
        try{
        for(int i=0; i<fleet.length; i++)
        {
                if (cname[i]==null)
                {
                        i = 1000;
                }
                else
                {
                        fw.write(fleet[i]+"\t"+cname[i]+"\t"+occu[i]+"\t"+flyhours[i]+"\t"+landtime[i]+"\n");
                        rstring = rstring + fleet[i]+"\t"+cname[i]+"\t"+occu[i]+"\t"+flyhours[i]+"\t"+landtime[i]+"\n";
                }
        }
        return rstring; 
        } catch(Exception e) {
        	e.printStackTrace();
        	return "crewHour.java " + e.toString();
        }
        finally
        {
           fw.flush();
           fw.close();
        }
    }
}
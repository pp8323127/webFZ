package catii;

import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import dz.CrewName;
import fz.splitString;

/**
 * @author cs71 Created on 2005/11/15
 */
public class EmailUnqualified
{
    private String str_fleet = null;
    private String str_Occu = null;
    private String str_EmpNo = null;
    private String str_Name = null;
    private String str_SIM_Count_1 = null;
    private String str_Aircraft_Count_1 = null;
    private String str_Total_Count_1 = null;
    private String str_SIM_Count_2 = null;
    private String str_Aircraft_Count_2 = null;
    private String str_Total_Count_2 = null;
    private String str_pic = null;
    private String str_HMC = null;
    private String str_CATII = null;
    private String str_CATIIIa = null;
    private String receiver = "";
    private String cc = "";
    private String bcc = "";
    
    /*
    public static void main(String[] args)
    {
        EmailUnqualified a = new EmailUnqualified();
        System.out.println(a.sendEmail("343-CAPT -310319-�� ェ-13-2-15-0-0-0-1493.98-NO-NO-NO"));
    }
    */

    //sendEmail
    public String sendEmail(String str)
    {
        splitString spstr = new splitString();
        String[] stral = spstr.doSplit(str,"-");
        str_fleet = stral[0];
        str_Occu = stral[1];
        str_EmpNo = stral[2];
        str_Name = stral[3];
        str_SIM_Count_1 = stral[4];
        str_Aircraft_Count_1 = stral[5];
        str_Total_Count_1 = stral[6];
        str_SIM_Count_2 = stral[7];
        str_Aircraft_Count_2 = stral[8];
        str_Total_Count_2 = stral[9];
        str_pic = stral[10];
        str_HMC = stral[11];
        str_CATII = stral[12];
        str_CATIIIa = stral[13];
        //String path = "/apsource/csap/projdz/webap/Log/";
        //String path = "C://";
        //FileWriter fwlog = null;
        String returnstr = "Exception";
        String mailSubject = "";
        StringBuffer mailContent = new StringBuffer();
        //TODO smtp server
        Properties props = new Properties();
        //props.put("mail.smtp.host", "192.168.2.4");
        props.put("mail.smtp.host", "192.168.2.3");
        try
        {
            Session mailSession = Session.getInstance(props, null);
            MimeMessage msg = new MimeMessage(mailSession);
            //set sender
            msg.setFrom(new InternetAddress("debra.wang@china-airlines.com"));
            
            //email subject --Start--
            mailSubject = "Pre-alert for your CAT II/IIIa recency experience";
            msg.setSubject(mailSubject);
            //email subject --end--
            
            //set recipient
            //msg.setRecipients(Message.RecipientType.TO,
            //InternetAddress.parse(empno + "@cal.aero"));
            
            receiver = str_EmpNo + "@cal.aero";
            //receiver = "martin.chang@china-airlines.com";
            //receiver = "640790@cal.aero";  
            
            String fleet = "";
            if (str_fleet.equals("744"))
            {
                cc = "jocelyn.wang@china-airlines.com,menciuslin@china-airlines.com,shiou-fen_chen@email.china-airlines.com,benson@china-airlines.com";
                fleet = "744";
            }
            else if (str_fleet.equals("AB6"))
            {
                cc = "632546@china-airlines.com";
                fleet = "AB6";
            } 
            else if (str_fleet.equals("738"))
            {
                cc = "738jimmy@china-airlines.com";
                fleet = "738";
            } 
            else // A330 or 340    
            {
                cc = " jay@china-airlines.com,shwu-yuh_tseng@email.china-airlines.com";//,seperate
                fleet = "A330/A340";
            }  
            
                
            bcc = "640790@cal.aero";
            
            InternetAddress[] TheAddresses = InternetAddress.parse(receiver);
            InternetAddress[] TheAddresses2 = InternetAddress.parse(cc);
            //InternetAddress[] TheAddresses3 = InternetAddress.parse(bcc);
            
            msg.setRecipients(Message.RecipientType.TO, TheAddresses);
            msg.setRecipients(Message.RecipientType.CC, TheAddresses2);
            //msg.setRecipients(Message.RecipientType.BCC, TheAddresses3);
            
            //Email Content --start--
            CrewName cn = new CrewName();
            MimeBodyPart mbp = new MimeBodyPart();
            //mailContent.append(fleet + "\r\n\r\n");
            mailContent.append("Dear "+ str_Occu+" "+ cn.getEname(str_EmpNo).trim() + ",\r\n\r\n");
            mailContent.append("According to the flight records of Flight Log System and Training and check \r\n");
            mailContent.append("record management system , your CAT II/IIIa recency experience during the\r\n");
            mailContent.append("preceding 12(6) months are still below the threshold regulated by FOM.\r\n");
            mailContent.append("(The FOM requires ：CM1 must satisfy the following recency experience \r\n");            
            mailContent.append("requirements prior to conducting CAT II/IIIa operations:\r\n\r\n");
            mailContent.append("A.Within the preceding 12 months,conduct at least 3 CATII/IIIa approaches,in \r\n");
            mailContent.append("  actual or simulated CATII/IIIa conditions.One of these landings must be \r\n");
            mailContent.append("  during line operations.\r\n");
            mailContent.append("B.Within the preceding 6 months ,conduct at least one actual or simulated CAT \r\n");            
            mailContent.append("  II/IIIa appraocheds to an automatic landing)\r\n");
            mailContent.append("  1. The letter is for your pre-alert only. For the purpose to keep you satisfy the \r\n");
            mailContent.append("     requirement of CAT II/IIIa recency experience, please link to the URL : \r\n");    
            mailContent.append("     http://tpeweb03:7001/webdz/catiii/cat_report.jsp?empno="+str_EmpNo+"&sysname=CATII/IIIa \r\n");
            mailContent.append("     for the relevant information.\r\n");            
            mailContent.append("  2. Please be reminded to record your CATII/IIIa approaches in Training Record \r\n");
            mailContent.append("     or Simulator proficiency check report during your PTs or PCs.\r\n");
            mailContent.append("  3. Please be reminded to record your Auto landing record in Aircraft operations log.\r\n");
            mailContent.append("  4. Should these CATII/IIIa approaches records are empty in your Training \r\n");
            mailContent.append("     Record or Simulator proficiency check report during your PTs or PCs,there \r\n");
            mailContent.append("     won・t be SIM approaches records in your CAT II/IIIa recency experience.\r\n");
            mailContent.append("  5. Should the Auto landing record in Aircraft operations log is empty ,there won・t \r\n");
            mailContent.append("     be CATII/IIIa approaches records for line operations in your CAT II/IIIa  \r\n");
            mailContent.append("     recency experience.\r\n\r\n");            
            mailContent.append("Please be reminded to pay attention on this issue.\r\n");
            mailContent.append("Your kindly cooperation will be highly appreciated.\r\n\r\n");
            
            /*
            mailContent.append("***************************************************\r\n");
            mailContent.append("                CATII/IIIa record\r\n");            
            mailContent.append("***************************************************\r\n");            
            mailContent.append("Occu\t\t\t: " + str_Occu + "\r\n");
            mailContent.append("EmpNo\t\t\t: " + str_EmpNo + "\r\n");
            mailContent.append("Name\t\t\t: " + cn.getEname(str_EmpNo) + "\r\n");
            mailContent.append("12 Months (Period - 2005-11-16 ~ 2004-11-15)" + "\r\n");
            mailContent.append("SIM Count\t\t: " + str_SIM_Count_1 + "\r\n");
            mailContent.append("Aircraft Count\t\t: " + str_Aircraft_Count_1 + "\r\n");
            mailContent.append("Total Count\t\t: " + str_Total_Count_1 + "\r\n");
            mailContent.append("6 Months (Period - 2005-11-16 ~ 2005-05-15)"+ "\r\n");
            mailContent.append("SIM Count\t\t: " + str_SIM_Count_2 + "\r\n");
            mailContent.append("Aircraft Count\t\t: " + str_Aircraft_Count_2 + "\r\n");
            mailContent.append("Total Count\t\t: " + str_Total_Count_2 + "\r\n");
            mailContent.append("End of 2005/9 (Hours)" + "\r\n");
            mailContent.append("PIC on Type with CAL\t: " + str_pic + "\r\n");
            mailContent.append("HMC\t\t\t: " + str_HMC + "\r\n");
            mailContent.append("Recency" + "\r\n");
            mailContent.append("CATII\t\t\t: " + str_CATII + "\r\n");
            mailContent.append("CATIIIa\t\t: " + str_CATIIIa + "\r\n");            
            mailContent.append("***************************************************\r\n\r\n");
            */
            mailContent.append("Planning section/Crew Scheduling Department\r\n");                       
            mbp.setContent(mailContent.toString(), "text/plain;charset=big5");
            Multipart mp = new MimeMultipart();
            mp.addBodyPart(mbp);
            //Email Content --end--
            //TODO mail Content
            msg.setContent(mp);
            //send email
            Transport.send(msg);
            //record in log
            //fwlog = new FileWriter(path + "emailExp.txt", true);
            //java.util.Date runDate1 = Calendar.getInstance().getTime();
            //String time1 = new SimpleDateFormat("yyyy/MM/dd EEE HH:mm:ss a")
            // .format(runDate1);
            //fwlog.write("\r\n" + time1 + " send " + empno + " " + liccd + "
            // expired notice\r\n");
            //fwlog.close();
            returnstr = "0";
        }
        catch ( Exception e )
        {
            e.printStackTrace();
            returnstr = "Email error !!\r\n " + e.toString();
        }
        finally
        {
            try
            {
                //if (fwlog != null)
                //fwlog.close();
            }
            catch ( Exception e )
            {
            }
        }
        return returnstr;
    }
}
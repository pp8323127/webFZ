/*
 * Created on 2005/3/7
 * �z�LJavaMail�H�H
 */

/**
 * @author cs66
 *
 * @param subject:�H����D
 * @param receiver:����̭��u��
 * @param msgContent:�H�󤺤�
 * v02 20090824 cs27 use domain-name
 */

package ci.tool;

import java.util.*;

import javax.activation.*;
import javax.mail.*;
import javax.mail.internet.*;



public class DeliverMail {

       String mailrelay = "APmailrly2.china-airlines.com" ;  //v02 mail relay server domain-name

	public void Deliver(String subject, String receiverEmpno, String msgContent)
			throws Exception {
		Properties props = new Properties();

		//props.put("mail.smtp.host", "APmailrly1.china-airlines.com");    //v02
		props.put("mail.smtp.host", mailrelay );      //v02

		Session mailSession = Session.getInstance(props, null);
		MimeMessage msg = new MimeMessage(mailSession);

		try {
			msg.setFrom(new InternetAddress("tpecsci@cal.aero"));
			msg.setSubject(subject);

                        //v02
                        if (receiverEmpno.indexOf("@")==(-1)) receiverEmpno= receiverEmpno+ "@cal.aero" ;

			if (!"null".equals(receiverEmpno) && receiverEmpno != null) {

				msg.setRecipients(Message.RecipientType.TO,
				    //v02 InternetAddress.parse(receiverEmpno + "@cal.aero"));
				    InternetAddress.parse(receiverEmpno ));  //v02

				msg.setRecipients(Message.RecipientType.BCC, InternetAddress
						.parse("tpecsci@cal.aero"));

				msg.setContent(msgContent, "text/plain;charset=big5");
				Transport.send(msg);

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			msg = null;
			mailSession = null;
			props = null;
		}

	}
	

	/**
	 * �H�X���H��|�P��BCC to tpecsci@cal.aero
	 */
	public void DeliverMailWithBackup(String subject, String receiverEmpno,	String msgContent) throws Exception {
		Properties props = new Properties();
		props.put("mail.smtp.host", mailrelay );    //v02  IP addr or host-name

		Session mailSession = Session.getInstance(props, null);
		MimeMessage msg = new MimeMessage(mailSession);
		

		try {

			msg.setFrom(new InternetAddress("tpecsci@cal.aero"));
			msg.setSubject(subject);

                        //v02
                        if (receiverEmpno.indexOf("@")==(-1)) receiverEmpno= receiverEmpno+ "@cal.aero" ;

			if (!"null".equals(receiverEmpno) && receiverEmpno != null) {

				msg.setRecipients(Message.RecipientType.TO,
                                    //v02 InternetAddress.parse(receiverEmpno + "@cal.aero"));
                                    InternetAddress.parse(receiverEmpno ));  //v02
				msg.setRecipients(Message.RecipientType.BCC, InternetAddress
						.parse("<tpecsci@cal.aero>"));

				msg.setContent(msgContent, "text/plain;charset=big5");
				Transport.send(msg);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			msg = null;
			mailSession = null;
			props = null;

		}

	}

	/**
	 * @param subject�G�l��D�D
	 * @param receiverEmpno�G�����l��̪����u��
	 * @param msgContent:�l�󤺮e
	 * @param fileNamePath:�����ɪ��ɦW�θ��|
	 *                ex: C:\cs66.txt
	 * @param attachFileName:
	 *                ��ܦb�l�󤺪����[���ɦW
	 *
	 * ��function �Ϊ��[�ɪ��覡�H�X�l��
	 */
	public void DeliverMailWithAttach(String subject, String receiverEmpno,
			String msgContent, String fileNamePath, String attachFileName) {
		Properties props = new Properties();
		props.put("mail.smtp.host", mailrelay );

		Session mailSession = Session.getInstance(props, null);
		MimeMessage msg = new MimeMessage(mailSession);

		try {
			msg.setFrom(new InternetAddress("tpecsci@cal.aero"));
			msg.setSubject(subject);

                        //v02
                        if (receiverEmpno.indexOf("@")==(-1)) receiverEmpno= receiverEmpno+ "@cal.aero" ;

			if (!"null".equals(receiverEmpno) && receiverEmpno != null) {

				String mailContent = msgContent;
				msg.setRecipients(Message.RecipientType.TO, 
                                    //v02 InternetAddress.parse(receiverEmpno + "@cal.aero"));
                                    InternetAddress.parse(receiverEmpno ));  //v02

				MimeBodyPart mbp1 = new MimeBodyPart();
				mbp1.setContent(mailContent, "text/plain;charset=big5");

				MimeBodyPart mbp = new MimeBodyPart();
				//TODO �l������ɦW�١B��m
				//			FileDataSource fds = new
				// FileDataSource("/apsource/csap/projfz/webap/txt/OutTaiwan"+year+"_"+empno+".txt");
				FileDataSource fds = new FileDataSource(fileNamePath);
				mbp.setDataHandler(new DataHandler(fds));
				mbp.setFileName(MimeUtility.encodeText(attachFileName, "MS950",
						"B"));

				Multipart mp = new MimeMultipart();
				mp.addBodyPart(mbp1);
				mp.addBodyPart(mbp);
				msg.setContent(mp);

				Transport.send(msg);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			msg = null;
			mailSession = null;
			props = null;

		}

	}
	/*	public static void main(String args[]) {
	 String msg = "3";

	 DeliverMail dm = new DeliverMail();
	 
	 try {
	 //			dm.DeliverMailWithBackup("Backup", "null", "3");
	 //			dm.DeliverMailWithAttach("fff","null","123","C:\\DBS.TXT","fff.txt");
	 dm.Deliver("test",null,"test");
	 dm.Deliver("test","null","test");
	 } catch (Exception e) {
	 System.out.println(e.toString());
	 }
	 }*/
}
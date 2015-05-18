/**
 * DeliverMailService �z�LJavaMail�H�H
 * 
 * @author cs66
 * @version 1.0 2005/3/7
 * @version 1.1 2005/12/01 by betty �i�]�w����� (DeliverMailWithBackup)
 * 
 * Copyright: Copyright (c) 2005
 */
package df.ec;

import java.util.*;

import javax.activation.*;
import javax.mail.*;
import javax.mail.internet.*;

public class DeliverMailService {

	/**
	 * @param subject
	 *            �H����D
	 * @param receiverEmpno
	 *            ����̭��u��
	 * @param msgContent
	 *            �H�󤺤�
	 * 
	 */
	public void Deliver(String subject, String receiverEmpno, String msgContent)
			throws Exception {
		Properties props = new Properties();
		props.put("mail.smtp.host", "APmailrly1.china-airlines.com");

		Session mailSession = Session.getInstance(props, null);
		MimeMessage msg = new MimeMessage(mailSession);

		try {
			msg.setFrom(new InternetAddress("tpecsci@cal.aero"));

			msg.setSubject(subject);

			if (!"null".equals(receiverEmpno) && receiverEmpno != null) {

				msg.setRecipients(Message.RecipientType.TO, InternetAddress
						.parse(receiverEmpno + "@cal.aero"));

				msg.setContent(msgContent, "text/plain;charset=big5");
				Transport.send(msg);

			}
		} finally {
			msg = null;
			mailSession = null;
			props = null;
		}

	}

	/**
	 * �H�X���H��|�P��BCC to tpecsci@cal.aero
	 * 
	 * 2005/12/01 by betty �i�]�w�����
	 */
	public void DeliverMailWithBackup(String subject, String receiverEmpno,
			String msgContent) throws Exception {
		Properties props = new Properties();
		props.put("mail.smtp.host", "APmailrly1.china-airlines.com");

		Session mailSession = Session.getInstance(props, null);
		MimeMessage msg = new MimeMessage(mailSession);

		try {

			msg.setFrom(new InternetAddress("tpecsci@cal.aero"));
			msg.setSubject(subject);

			if (!"null".equals(receiverEmpno) && receiverEmpno != null) {

				// msg.setRecipients(Message.RecipientType.TO, InternetAddress
				// .parse(receiverEmpno + "@cal.aero"));

				// add by betty*******************************************
				String receiver = "";

				// when without @cal.aero
				if (receiverEmpno.length() <= 8) {
					receiver = receiverEmpno + "@cal.aero";
				} else {
					receiver = receiverEmpno;
				}

				msg.setRecipients(Message.RecipientType.TO, InternetAddress
						.parse(receiver));
				// ********************************************************

				msg.setRecipients(Message.RecipientType.BCC, InternetAddress
						.parse("tpecsci@cal.aero"));

				msg.setContent(msgContent, "text/plain;charset=big5");
				Transport.send(msg);
			}
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
	 *            ex: C:\cs66.txt
	 * @param attachFileName:
	 *            ��ܦb�l�󤺪����[���ɦW
	 * 
	 * ��function �Ϊ��[�ɪ��覡�H�X�l��
	 */
	public void DeliverMailWithAttach(String subject, String receiverEmpno,
			String msgContent, String fileNamePath, String attachFileName) {
		Properties props = new Properties();
		props.put("mail.smtp.host", "APmailrly1.china-airlines.com");
		Session mailSession = Session.getInstance(props, null);
		MimeMessage msg = new MimeMessage(mailSession);

		try {
			msg.setFrom(new InternetAddress("tpeeb@china-airlines.com"));

			msg.setSubject(subject);

			if (!"null".equals(receiverEmpno) && receiverEmpno != null) {

				String mailContent = msgContent;
				msg.setRecipients(Message.RecipientType.TO, InternetAddress
						.parse(receiverEmpno + "@cal.aero"));

				MimeBodyPart mbp1 = new MimeBodyPart();
				mbp1.setContent(mailContent, "text/plain;charset=big5");

				MimeBodyPart mbp = new MimeBodyPart();
				// TODO �l������ɦW�١B��m
				// FileDataSource fds = new
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

	/**
	 * @param subject
	 *            �l��D�D
	 * @param receiverEmpno
	 *            �����l��̪����u��
	 * @param msgContent
	 *            �l�󤺮e
	 * @param Sender
	 *            ��ܦb�l��W���H��̦W��(�D�H���email)
	 * @param Encode
	 *            �H��̦W�٤��s�X
	 * 
	 */
	public void DeliverWithSenderName(String subject, String receiverEmpno,
			String msgContent, String Sender, String Encode) throws Exception {

		Properties props = new Properties();
		props.put("mail.smtp.host", "APmailrly1.china-airlines.com");

		Session mailSession = Session.getInstance(props, null);
		MimeMessage msg = new MimeMessage(mailSession);

		try {

			InternetAddress from = new InternetAddress("tpecsci@cal.aero");
			from.setPersonal(Sender, Encode);

			msg.setFrom(from);

			msg.setSubject(subject);

			if (!"null".equals(receiverEmpno) && receiverEmpno != null) {

				msg.setRecipients(Message.RecipientType.TO, InternetAddress
						.parse(receiverEmpno + "@cal.aero"));
				msg.setRecipients(Message.RecipientType.BCC, InternetAddress
						.parse("tpecsci@cal.aero"));

				msg.setContent(msgContent, "text/plain;charset=big5");
				Transport.send(msg);

			}
		} finally {
			msg = null;
			mailSession = null;
			props = null;
		}

	}

//	public static void main(String args[]) {
//		DeliverMail dm = new DeliverMail();
//		try {
//			dm.DeliverWithSenderName("test subject����", "640073",
//					"test  content", "���", "Big5");
//
//		} catch (Exception e) {
//
//			e.printStackTrace();
//		}
//	}
	/*
	 * public static void main(String args[]) { String msg = "3";
	 * 
	 * DeliverMail dm = new DeliverMail();
	 * 
	 * try { // dm.DeliverMailWithBackup("Backup", "null", "3"); //
	 * dm.DeliverMailWithAttach("fff","null","123","C:\\DBS.TXT","fff.txt");
	 * dm.Deliver("test", null, "test"); dm.Deliver("test", "null", "test"); }
	 * catch (Exception e) { System.out.println(e.toString()); } }
	 */
}
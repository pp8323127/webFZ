
package fzAuthP;

import javax.mail.*;

/**
 * 驗證全員信箱
 * 
 * @author cs66 at 2005/6/29
 */
public class CheckAeroMail {
	private boolean	passAeroMail;

	/**
	 * @throws NullPointerException
	 *             無帳號密碼（未Initial UserID)
	 * @throws AuthenticationFailedException
	 *             帳號密碼錯誤
	 */
	 public static void main(String[] args) 
	 {
	     CheckAeroMail ckMail = new CheckAeroMail();
	     System.out.println(ckMail.isPassAeroMail());
	 }
	
	public CheckAeroMail() throws NullPointerException 
	{
		Session mailSession;
		Store store = null;
		try 
		{
			mailSession = Session.getInstance(System.getProperties(), null);
			store = mailSession.getStore("imap");
			store.connect("202.165.148.123", UserID.getUserid(), UserID.getPassword());
//			store.connect("192.168.46.29", UserID.getUserid(), UserID.getPassword());			
			setPassAeroMail(true);
		} catch (AuthenticationFailedException e) {
			//			帳號密碼驗證不過
			setPassAeroMail(false);
		} catch (NoSuchProviderException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		} finally {
			try {
				if (store != null) store.close();
			} catch (MessagingException e) {
				e.printStackTrace();
			}
		}
	}

	public boolean isPassAeroMail() {
		return passAeroMail;
	}

	public void setPassAeroMail(boolean passAeroMail) {
		this.passAeroMail = passAeroMail;
	}
}
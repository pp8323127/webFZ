package ci.tool;

import javax.mail.*;

/**
 * 驗證全員信箱
 * 
 * @author cs66 at 2005/6/29
 */
public class CheckAeroMail {
    private boolean passAeroMail;
    private String userID;
    private String userPassword;

//    public static void main(String[] args) {
//        CheckAeroMail ck = new CheckAeroMail(null, null);
//        ck.CheckAeroMailAuth();
//        System.out.println(ck.isPassAeroMail());
//    }

    public CheckAeroMail(String userID, String userPassword) {
        this.userID = userID;
        this.userPassword = userPassword;
    }

    /**
     * @throws NullPointerException 無帳號密碼（未Initial UserID)
     * @throws AuthenticationFailedException 帳號密碼錯誤
     */
    public void CheckAeroMailAuth() throws NullPointerException {
        Session mailSession;
        Store store = null;
        try {
            mailSession = Session.getInstance(System.getProperties() ,null);
            store = mailSession.getStore("imap");
            store.connect("202.165.148.123" ,userID ,userPassword);
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
                if ( store != null ) store.close();
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
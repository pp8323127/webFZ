package ci.tool;

import javax.mail.*;

/**
 * ���ҥ����H�c
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
     * @throws NullPointerException �L�b���K�X�]��Initial UserID)
     * @throws AuthenticationFailedException �b���K�X���~
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
            //			�b���K�X���Ҥ��L
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
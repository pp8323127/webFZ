
package fzAuthP;

/**
 * Àx¦sµn¤J±b¸¹±K½X
 * 
 * @author cs66 at 2005/6/29
 */
public class UserID 
{
	private static String	userid;
	private static String	password;

	public UserID(String userid, String password) {
		setUserid(userid);
		setPassword(password);
	}

	public static String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		UserID.password = password;
	}

	public static String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		UserID.userid = userid;
	}
}

package ci.tool;

/**
 * 密碼驗證功能 <br>
 * 檢查原則：長度需六位數,至少需有一位文字或數字(含特殊符號) , 不允許：空白字元 <br>
 * jdk1.3 使用：ci.tool.ReplaceAllFor1_3 <br>
 * 
 * @author cs66 at 2005/7/26
 */
public class PwCheck {

		public static void main(String[] args) {
			PwCheck f = new PwCheck("99999");
			System.out.println("是否通過驗證：" + f.isValidPw());
		}

	private String	pw;

	public PwCheck(String pw) {
		this.pw = pw;
	}

	public boolean isValidPw() {
		if (pw == null) return false;

		//不允許含有空白字元
		//		if(!pw.equals(pw.replaceAll(" ",""))){ // for jdk 1.4

		//for jdk 1.3
		if (!pw.equals(ReplaceAllFor1_3.replace(pw, " ", ""))) {
			return false;
		}

		if (pw.length() < 6) { //密碼不滿六位
			return false;
		} else {
			boolean isDigital = false;
			boolean isWord = false;

			for (int index = 0; index < pw.length(); index++) {

				char c = pw.charAt(index);
				if (c >= '0' && c <= '9') {
					isDigital = true;
				} else if (c >= 'A' && c <= 'Z') {
					isWord = true;
				} else if (c >= 'a' && c <= 'z') {
					isWord = true;
				}

				if (isWord && isDigital) return true;
			}

		}
		return false;
	}
}


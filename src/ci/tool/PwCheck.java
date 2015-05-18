
package ci.tool;

/**
 * �K�X���ҥ\�� <br>
 * �ˬd��h�G���׻ݤ����,�ܤֻݦ��@���r�μƦr(�t�S��Ÿ�) , �����\�G�ťզr�� <br>
 * jdk1.3 �ϥΡGci.tool.ReplaceAllFor1_3 <br>
 * 
 * @author cs66 at 2005/7/26
 */
public class PwCheck {

		public static void main(String[] args) {
			PwCheck f = new PwCheck("99999");
			System.out.println("�O�_�q�L���ҡG" + f.isValidPw());
		}

	private String	pw;

	public PwCheck(String pw) {
		this.pw = pw;
	}

	public boolean isValidPw() {
		if (pw == null) return false;

		//�����\�t���ťզr��
		//		if(!pw.equals(pw.replaceAll(" ",""))){ // for jdk 1.4

		//for jdk 1.3
		if (!pw.equals(ReplaceAllFor1_3.replace(pw, " ", ""))) {
			return false;
		}

		if (pw.length() < 6) { //�K�X��������
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


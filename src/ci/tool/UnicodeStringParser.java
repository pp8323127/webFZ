package ci.tool;


/**
 * UnicodeStringParser Unicode �r���ഫ
 * 
 * 
 * @author cs40,cs66
 * @version 1.0 2006
 * 
 * Copyright: Copyright (c) 2007
 */
public class UnicodeStringParser {
	// public static void main(String[] args) throws
	// UnsupportedEncodingException, Exception {
	//		
	// UnicodeStringParser u = new UnicodeStringParser();
	// String s = new
	// String(UnicodeStringParser.removeExtraEscape("\\u674e\\u828a\\u7a4e").getBytes(),
	// "Big5");
	//					
	// System.out.println(s);
	// System.out.println(UnicodeStringParser.Big5ToUnicode("��ˡ�o"));
	// }

	public static boolean isHexDigit(byte b) {
		if (b >= '0' && b <= '9' || b >= 'a' && b <= 'f' || b >= 'A'
				&& b <= 'F') {
			return true;
		}
		return false;
	} // isHexDigit

	// removeExtraEscape: \\u7d30 --> \u7d30
	public static String removeExtraEscape(String str) throws Exception {
		byte[] bytes = str.getBytes();
		byte escape = '\\';
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < bytes.length; i++) {
			if (i < bytes.length - 5 && bytes[i] == '\\'
					&& (bytes[i + 1] == 'u' || bytes[i + 1] == 'U')
					&& isHexDigit(bytes[i + 2]) && isHexDigit(bytes[i + 3])
					&& isHexDigit(bytes[i + 4]) && isHexDigit(bytes[i + 5])) {
				String value = new String(bytes, i + 2, 4);
				sb.append((char) Integer.parseInt(value, 16));
				i = i + 5;
			} else {
				String c = new String(bytes, i, 1);
				sb.append(c);
			}
		}
		return new String(sb.toString().getBytes(), "Big5");
	}

	/**
	 * �ഫ���^��r�ꦨ Unicode
	 * 
	 * @param source
	 *            �ӷ��r��,�i���^�姨��
	 * @return
	 * @throws Exception
	 *             �ഫ�� Unicode
	 * 
	 */ 
	public static String Big5ToUnicode(String source) throws Exception {
		// source = "�B�ӱjPierce Ting";
		String target = "";
		StringBuffer sb = new StringBuffer("");

		char[] c = source.toCharArray();
		for (int i = 0; i < c.length; i++) {
			target = "\\u" + Integer.toHexString((int) c[i]);
			if (target.length() == 6) {
				sb.append(target);
			} else {
				sb.append(c[i]);
			}// if
		}// for
		return sb.toString();
	} // getUnicodeString

}
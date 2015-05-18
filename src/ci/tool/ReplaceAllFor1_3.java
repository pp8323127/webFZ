package ci.tool;

public class ReplaceAllFor1_3 {
	
	/**
	 * jdk1.3�LreplaceAll�����N�Ϊk
	 * 
	 * @param strSource
	 *                ��l�r��
	 * @param strFrom
	 *                ���ഫ���r��
	 * @param strTo
	 *                �ഫ��
	 */
	public static String replace(String strSource, String strFrom, String strTo) {
		java.lang.String strDest = "";
		int intFromLen = strFrom.length();
		int intPos;

		while ((intPos = strSource.indexOf(strFrom)) != -1) {
			strDest = strDest + strSource.substring(0, intPos);
			strDest = strDest + strTo;
			strSource = strSource.substring(intPos + intFromLen);
		}
		strDest = strDest + strSource;

		return strDest;
	}

}
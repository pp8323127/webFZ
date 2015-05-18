package ci.tool;

public class ReplaceAllFor1_3 {
	
	/**
	 * jdk1.3無replaceAll之替代用法
	 * 
	 * @param strSource
	 *                原始字串
	 * @param strFrom
	 *                欲轉換的字串
	 * @param strTo
	 *                轉換成
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
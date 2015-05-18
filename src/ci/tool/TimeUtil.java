package ci.tool;

import java.math.BigDecimal;
import java.text.*;
import java.util.*;
import java.util.Calendar;
import java.util.Date;

/**
 * @author cs66 at 2005/5/25 <br>
 *         modify : add differenceOfTwoDate() <br>
 *         modify: hhmm to min(修改三位數以上時數之計算)
 */
public class TimeUtil {

	public static void main(String[] args) {

		// String min = "11202";

		// System.out.println("hour:" + TimeUtil.minToHHMM(min).substring(0,
		// 2));
		// System.out
		// .println("minutes:" + TimeUtil.minToHHMM(min).substring(2, 4));
		// System.out.println("hhmm:" + TimeUtil.minToHHMM(min));
		// System.out.println("時數：" + TimeUtil.minToHours(4, min));

		// String mi = "8482";
		// System.out.println(Integer.parseInt(TimeUtil.minToHHMM(mi)));
		String min = "5237";
		System.out.println("HHMM= "+TimeUtil.minToHHMM(min));
		System.out.println("hours= "+TimeUtil.minToHours(2, min));
		// System.out.println(TimeUtil.hhmmToMin(hhmm));
		// String endDate = "200508120026";
		// String startDate = "200508112318";
		// String min = TimeUtil.differenceOfTwoDate(startDate ,endDate);
		// System.out.println(TimeUtil.differenceOfTwoDate(startDate ,endDate));

	}

	/**
	 * @param min
	 *            分鐘數
	 * @return 將min轉換成小時制（format: HHMM）
	 */
	public static String minToHHMM(String min) { // 將分鐘數轉為小時與分鐘
		String HH = null;
		String MM = null;
		if (min == null || min.equals("") || min.equals("0")) {
			HH = "00";
			MM = "00";
		} else {
			HH = Integer.toString(Integer.parseInt(min) / 60);
			if (HH.length() < 2) {
				HH = "0" + HH;
			}
			MM = Integer.toString((Integer.parseInt(min)) % 60);
			if (MM.length() < 2) {
				MM = "0" + MM;
			}
		}
		return (HH + MM);
	}

	// 將分鐘數轉為小時與分鐘,若為0000時，顯示為1個0
	public static String minToHHMM1Zero(String min) {
		String HH = null;
		String MM = null;
		if (min == null || min.equals("") || min.equals("0")) {
			HH = "";
			MM = "0";
		} else {
			HH = Integer.toString(Integer.parseInt(min) / 60);
			if (HH.length() < 2) {
				HH = "0" + HH;
			}
			MM = Integer.toString((Integer.parseInt(min)) % 60);
			if (MM.length() < 2) {
				MM = "0" + MM;
			}

			if ("0000".equals(HH + MM)) {
				return "0";
			}

		}

		return (HH + MM);

	}

	/**
	 * @param hhmm
	 * @return 轉換成中間有冒號的小時制（format: HH:MM）
	 */
	public static String hhmmWithColon(String hhmm) {
		String str = hhmm;
		if ("0".equals(hhmm)) {
			return "0";
		}
		str = hhmm.substring(0, hhmm.length() - 2) + ":"
				+ hhmm.substring(hhmm.length() - 2);
		return str;
	}

	/**
	 * @param min
	 * @return 將分鐘轉換成中間有冒號的小時制（format: HH:MM）
	 */
	public static String minToHHMMWithColon(String min) {
		String hhmm = minToHHMM(min);

		return hhmmWithColon(hhmm);

	}
	/**
	 * @param i
	 *            :小數位數
	 * @param min
	 *            :分鐘數
	 * @return hr :將min轉為i 位數小數的時數
	 */
	public static String minToHours(int i, String min) { // 將分鐘數轉為時數
		String hr = null;
		if (min == null || min.equals("") || min.equals("0")) {
			hr = "0";
		} else {
			BigDecimal bd = new BigDecimal((float) (Integer.parseInt(min)) / 60);
			hr = bd.setScale(i, BigDecimal.ROUND_HALF_UP).toString();
		}
		return hr;
	}

	/**
	 * @param hhmm
	 *            時分
	 * @return 將hhmm轉為分鐘
	 */
	public static String hhmmToMin(String hhmm) {
		int min = 0;
		if (null == hhmm || "".equals(hhmm)) {
			return "";
		} else if ("0".equals(hhmm)) {
			return "0";
		} else if (hhmm.length() <= 2) {
			return hhmm;
		} else {
			int idx1 = hhmm.length() - 2;
			min = Integer.parseInt(hhmm.substring(0, idx1)) * 60
					+ Integer.parseInt(hhmm.substring(idx1));
			return Integer.toString(min);
		}
	}

	/**
	 * @param startDate
	 *            開始時間,format: yyyymmddhhmi
	 * @param endDate
	 *            結束時間,format: yyyymmddhhmi
	 * @return 兩者相差的時間,單位為分鐘
	 */
	public static String differenceOfTwoDate(String startDate, String endDate) {

		Calendar cal = Calendar.getInstance();
		Calendar cal2 = Calendar.getInstance();

		cal.set(Integer.parseInt(startDate.substring(0, 4)), Integer
				.parseInt(startDate.substring(4, 6)) - 1, Integer
				.parseInt(startDate.substring(6, 8)), Integer
				.parseInt(startDate.substring(8, 10)), Integer
				.parseInt(startDate.substring(10)));

		cal2.set(Integer.parseInt(endDate.substring(0, 4)), Integer
				.parseInt(endDate.substring(4, 6)) - 1, Integer
				.parseInt(endDate.substring(6, 8)), Integer.parseInt(endDate
				.substring(8, 10)), Integer.parseInt(endDate.substring(10)));

		Date d1 = cal.getTime();
		Date d2 = cal2.getTime();
		long dateRange = d2.getTime() - d1.getTime();

		long time = 1000 * 60; // A minute in milliseconds

		BigDecimal bd = new BigDecimal((dateRange / time));

		return bd.setScale(0, BigDecimal.ROUND_HALF_UP).toString();
	}
	
	
	/**
	 *  
	 * @param year (format yyyy)
	 * @param month (format MM)
	 * @return 上個月(format yyyyMM)
	 *  
	 */
	public static String PreviousYM(String year, String month) {
		String preYM = "";
		GregorianCalendar cal = new GregorianCalendar();
		cal.set(Calendar.YEAR, Integer.parseInt(year));
		cal.set(Calendar.MONTH, Integer.parseInt(month) - 1);
		cal.add(Calendar.MONTH, -1);
		SimpleDateFormat format = new SimpleDateFormat("yyyyMM");
		preYM = new SimpleDateFormat("yyyy").format((Date) cal.getTime())
				+ new SimpleDateFormat("MM").format((Date) cal.getTime());
		return preYM;

	}
}
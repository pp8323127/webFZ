/*
 * Created on 2005/3/17
 *	關於日期的計算
 */
/**
 * @author cs66
 *  
 */
package ci.tool;

import java.util.*;

public class DateUtil {

	/**
	 * @param year 年份(yyyy)
	 * @return days of that year
	 *  
	 */

	public static int getDayOfThisYear(String thisYear) {
		GregorianCalendar crtDate = new GregorianCalendar();
		java.util.Date curDate = Calendar.getInstance().getTime();

		int daysOfYear;
		if (crtDate.isLeapYear(Integer.parseInt(thisYear))) { //判斷是否為潤年，再傳回天數
			daysOfYear = 366;
		} else {
			daysOfYear = 365;

		}
		return daysOfYear;
	}

	/**
	 * @param year format:yyyy
	 * @param month from 1~12
	 * @return last day of that month
	 */
	public final static int LastDayOfMonth(int year, int month) {
		Calendar cal = Calendar.getInstance();
		cal.set(year, month - 1, 1);
		int LastDay = cal.getActualMaximum(Calendar.DATE);
		return LastDay;

	}

}


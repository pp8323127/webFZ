package ci.tool;

import java.text.*;
import java.util.*;

/**
 * 驗證是否為正確的日期
 * 
 * 
 * @author cs69 友情贊助
 * @version 1.0 2006/4/4
 * 
 * Copyright: Copyright (c) 2006
 */
public class CheckDate {

	/**
	 * 驗證是否為正確的日期（格式：yyyy/mm/dd)
	 * 
	 * @param strDay
	 * @return
	 * 
	 */
	public static boolean isValidateDate(String strDay) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd");

		try {
			Date date = format.parse(strDay);
			GregorianCalendar cal = new GregorianCalendar();
			cal.setTime(date);
			String strYear = strDay.substring(0, 4);
			String strMon = strDay.substring(5, 7);
			String strDate = strDay.substring(8);

			if (cal.get(Calendar.YEAR) != Integer.parseInt(strYear)
					|| cal.get(Calendar.MONTH) + 1 != Integer.parseInt(strMon)
					|| cal.get(Calendar.DAY_OF_MONTH) != Integer
							.parseInt(strDate)) {
				return false;
			}

			return true;
		} catch (ParseException e) {
			return false;
		}

	}

	/**
	 * 檢查日期區間日否正確（結束日期大於或等於開始日期）
	 * 
	 * @param startDate
	 *            format:yyyy/mm/dd
	 * @param endDate
	 *            format:yyyy/mm/dd
	 * @return
	 * 
	 */
	public static boolean checkDateRange(String startDate, String endDate) {
		boolean isTrue = true;
		SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd");
		try {
			Date date = format.parse(startDate);
			Date date2 = format.parse(endDate);
			if(startDate.equals(endDate)|| date2.after(date) ){
				isTrue = true;
			}else{
				isTrue = false;
			}

		} catch (ParseException e) {
			isTrue = false;
		}

		return isTrue;

	}
	

	/**
	 * 回傳日期是否為週末
	 * 
	 * @param flightDate
	 *            format: yyyy/mm/dd
	 * @return
	 * 
	 */
	public static boolean isWeekend(String flightDate) {
		boolean isWeekend = false;
		// 日期格式不正確
		if (!ci.tool.CheckDate.isValidateDate(flightDate)) {
			return false;
		}

		try {
			SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd");
			Date date = format.parse(flightDate);
			GregorianCalendar gc = new GregorianCalendar();
			gc.setTime(date);

			if (gc.get(GregorianCalendar.DAY_OF_WEEK) == 7
					|| gc.get(GregorianCalendar.DAY_OF_WEEK) == 1) {
				isWeekend = true;
			}
		} catch (Exception e) {
			isWeekend = false;
		}
		return isWeekend;
	}
	
	
}

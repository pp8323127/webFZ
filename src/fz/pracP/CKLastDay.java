 /*
 * 在 2004/8/3 建立
 *
 * 傳回某月的最後一天
 */
package fz.pracP;


import java.util.Calendar;
import java.util.GregorianCalendar;

/**
 * @author Administrator
 *
 * 若要變更這個產生的類別註解的範本，請移至
 * 視窗 > 喜好設定 > Java > 程式碼產生 > 程式碼和註解
 */
public class CKLastDay {
	
//	public static void main(String[] args) {
//		CKLastDay ck = new CKLastDay();
//		System.out.println("200102的最後一天是：" + ck.getLastDay("2001", "02"));
//		System.out.println("200002的最後一天是：" + ck.getLastDay("2000", "02"));
//	}


	/*
	 * 每個月的天數
	 * */
	public final static int dom[] =
		{ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
		
/**
 * @param Syear: 四位數西曆年
 * @param Smonth:二位數月份
 * @return daysInMonth：當月的最後一天
 * */		
	public  int getLastDay(String Syear, String Smonth) {
		int year = Integer.parseInt(Syear);
		int month = Integer.parseInt(Smonth);
		
		if (month < 1 || month > 12)
			throw new IllegalArgumentException(
				"Month " + month + " bad, must be 1-12");
		GregorianCalendar calendar =	new GregorianCalendar(year, month, 1);
		
		int daysInMonth = dom[month - 1];
		
		//潤年時，2月有29天
		if (calendar.isLeapYear(calendar.get(Calendar.YEAR)) && (month - 1) == 1)
			++daysInMonth;
		
		return daysInMonth;
	}


}

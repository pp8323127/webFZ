 /*
 * �b 2004/8/3 �إ�
 *
 * �Ǧ^�Y�몺�̫�@��
 */
package fz.pracP;


import java.util.Calendar;
import java.util.GregorianCalendar;

/**
 * @author Administrator
 *
 * �Y�n�ܧ�o�Ӳ��ͪ����O���Ѫ��d���A�в���
 * ���� > �ߦn�]�w > Java > �{���X���� > �{���X�M����
 */
public class CKLastDay {
	
//	public static void main(String[] args) {
//		CKLastDay ck = new CKLastDay();
//		System.out.println("200102���̫�@�ѬO�G" + ck.getLastDay("2001", "02"));
//		System.out.println("200002���̫�@�ѬO�G" + ck.getLastDay("2000", "02"));
//	}


	/*
	 * �C�Ӥ몺�Ѽ�
	 * */
	public final static int dom[] =
		{ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
		
/**
 * @param Syear: �|��Ʀ��~
 * @param Smonth:�G��Ƥ��
 * @return daysInMonth�G��몺�̫�@��
 * */		
	public  int getLastDay(String Syear, String Smonth) {
		int year = Integer.parseInt(Syear);
		int month = Integer.parseInt(Smonth);
		
		if (month < 1 || month > 12)
			throw new IllegalArgumentException(
				"Month " + month + " bad, must be 1-12");
		GregorianCalendar calendar =	new GregorianCalendar(year, month, 1);
		
		int daysInMonth = dom[month - 1];
		
		//��~�ɡA2�릳29��
		if (calendar.isLeapYear(calendar.get(Calendar.YEAR)) && (month - 1) == 1)
			++daysInMonth;
		
		return daysInMonth;
	}


}

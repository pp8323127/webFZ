package ftdp;

import java.math.*;
import java.text.*;
import java.util.*;

/**
 * @author cs66 at 2005/5/25 <br>
 *         modify : add differenceOfTwoDate() <br>
 *         modify: hhmm to min(�ק�T��ƥH�W�ɼƤ��p��)
 */
public class TimeUtil 
{

	public static void main(String[] args) 
	{

//		 String d1 = "201402262355";
//		 String d2 = "2014023623545";
//		 System.out.println(d1);
//		 System.out.println(TimeUtil.datetimePlusMinstoDatetime(d1,"0"));
		 

		// System.out.println("hour:" + TimeUtil.minToHHMM(min).substring(0,
		// 2));
		// System.out
		// .println("minutes:" + TimeUtil.minToHHMM(min).substring(2, 4));
		// System.out.println("hhmm:" + TimeUtil.minToHHMM(min));
		// System.out.println("�ɼơG" + TimeUtil.minToHours(4, min));

		// String mi = "8482";
		// System.out.println(Integer.parseInt(TimeUtil.minToHHMM(mi)));
//		String min = "5237";
//		System.out.println("HHMM= "+TimeUtil.minToHHMM(min));
//		System.out.println("hours= "+TimeUtil.minToHours(2, min));
		// System.out.println(TimeUtil.hhmmToMin(hhmm));
		 String endDate = "200508120024";
		 String startDate = "200508110025";
		// String min = TimeUtil.differenceOfTwoDate(startDate ,endDate);
		 System.out.println(TimeUtil.differenceOfTwoDate(startDate ,endDate));
	}

	/**
	 * @param min
	 *            ������
	 * @return �Nmin�ഫ���p�ɨ�]format: HHMM�^
	 */
	public static String minToHHMM(String min) { // �N�������ର�p�ɻP����
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

	// �N�������ର�p�ɻP����,�Y��0000�ɡA��ܬ�1��0
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
	 * @return �ഫ���������_�����p�ɨ�]format: HH:MM�^
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
	 * @return �N�����ഫ���������_�����p�ɨ�]format: HH:MM�^
	 */
	public static String minToHHMMWithColon(String min) {
		String hhmm = minToHHMM(min);

		return hhmmWithColon(hhmm);

	}
	/**
	 * @param i
	 *            :�p�Ʀ��
	 * @param min
	 *            :������
	 * @return hr :�Nmin�ରi ��Ƥp�ƪ��ɼ�
	 */
	public static String minToHours(int i, String min) { // �N�������ର�ɼ�
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
	 *            �ɤ�
	 * @return �Nhhmm�ର����
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
	 *            �}�l�ɶ�,format: yyyymmddhhmi
	 * @param endDate
	 *            �����ɶ�,format: yyyymmddhhmi
	 * @return ��̬ۮt���ɶ�,��쬰����
	 */
	public static String differenceOfTwoDate_FZ(String startDate, String endDate) {

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

		java.math.BigDecimal bd = new java.math.BigDecimal((dateRange / time));

		return bd.setScale(0, java.math.BigDecimal.ROUND_HALF_UP).toString();
	}
	

    /**
     * @param startDate
     *            �}�l�ɶ�,format: yyyymmddhhmi
     * @param endDate
     *            �����ɶ�,format: yyyymmddhhmi
     * @return ��̬ۮt���ɶ�,��쬰����
     */
    public static String differenceOfTwoDate(String startDate, String endDate) 
    {
        GregorianCalendar c1 = new GregorianCalendar();
        GregorianCalendar c2 = new GregorianCalendar();
        
        c1.set(Integer.parseInt(startDate.substring(0, 4)), Integer
              .parseInt(startDate.substring(4, 6)) - 1, Integer
              .parseInt(startDate.substring(6, 8)), Integer
              .parseInt(startDate.substring(8, 10)), Integer
              .parseInt(startDate.substring(10)));

        c2.set(Integer.parseInt(endDate.substring(0, 4)), Integer
              .parseInt(endDate.substring(4, 6)) - 1, Integer
              .parseInt(endDate.substring(6, 8)), Integer.parseInt(endDate
              .substring(8, 10)), Integer.parseInt(endDate.substring(10)));
        
        long span = c2.getTimeInMillis() - c1.getTimeInMillis();
        GregorianCalendar c3 = new GregorianCalendar();
        c3.setTimeInMillis(span);
        long numberOfMSInADay = 1000*60;
        return Long.toString((c3.getTimeInMillis() / numberOfMSInADay));        
    }
	

	
	//����ɶ� + ����  -> ����ɶ�
	/**
     * @param startDate
     *            �}�l�ɶ�,format: yyyymmddhhmi
     */
	public static String datetimePlusMinstoDatetime(String startDate, String mins) 
	{
	    SimpleDateFormat df = new SimpleDateFormat("yyyy/MM/dd HH:mm");   
        Calendar cal = Calendar.getInstance();
        cal.set(Integer.parseInt(startDate.substring(0, 4)), Integer.parseInt(startDate.substring(4,6)) - 1, Integer.parseInt(startDate.substring(6,8)),Integer.parseInt(startDate.substring(8,10)), Integer.parseInt(startDate.substring(10,12)));

        cal.add(Calendar.MINUTE,Integer.parseInt(mins));
        return df.format(cal.getTime());
    }
	
	
	/**
	 *  
	 * @param year (format yyyy)
	 * @param month (format MM)
	 * @return �W�Ӥ�(format yyyyMM)
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
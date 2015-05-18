package fz.psfly;

import java.util.Calendar;
import java.util.GregorianCalendar;

public class isNewCheckForSFLY {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		isNewCheckForSFLY a = new isNewCheckForSFLY();
		System.out.println(a.checkTime("2014/09/01", "2014/09/02"));
	}
	public boolean checkTime(String yyyymmddStart ,String yyyymmddFdate){//yyyy/mm/dd
		if("".equals(yyyymmddStart)){
			yyyymmddStart = "2014/10/31";
		}
		boolean str = false;
		GregorianCalendar cal1 = new GregorianCalendar();//today
        cal1.set(Calendar.HOUR_OF_DAY,00);
        cal1.set(Calendar.MINUTE,01);
        //yyyymmddStart¹ê¬I¤é´Á
        GregorianCalendar cal2 = new GregorianCalendar();
        cal2.set(Calendar.YEAR,Integer.parseInt(yyyymmddStart.substring(0,4)));
        cal2.set(Calendar.MONTH,(Integer.parseInt(yyyymmddStart.substring(5,7)))-1);
        cal2.set(Calendar.DATE,Integer.parseInt(yyyymmddStart.substring(8))); 
        //cal2.add(Calendar.DATE,1);  
        
        if("".equals(yyyymmddFdate)){
        	
        	if(cal1.after(cal2)){
            	str = true;
            }        	
        }else{
        	//fltd
            GregorianCalendar cal3 = new GregorianCalendar();
            cal3.set(Calendar.YEAR,Integer.parseInt(yyyymmddFdate.substring(0,4)));
            cal3.set(Calendar.MONTH,(Integer.parseInt(yyyymmddFdate.substring(5,7)))-1);
            cal3.set(Calendar.DATE,Integer.parseInt(yyyymmddFdate.substring(8)));
            ///cal3.add(Calendar.DATE,-1);	
        	if(cal3.after(cal2)){
            	str = true;
            }
        }
        
		return str;
		
	}
}

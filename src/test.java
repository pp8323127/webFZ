import java.util.Calendar;
import java.util.GregorianCalendar;

public class test {

	/**
	 * @param args
	 */

//	public static void main(String[] args) {
//		// TODO Auto-generated method stub
//		String shift="Y";
//		String shst1 = "2013/11/21 11:00";
//		String shet1 = "2013/11/21 12:00";
//		String shst2 = "2013/11/21 10:00";
//		String shet2 = "2013/11/21 09:00";
//		String fdate = "2013/11/22 00:00";
//		
//		String[] duty 	= {"1L","2L","3L","",""};
//		String[] sh_crew = {"1","2","2","",""};
//		String sh_cm ="0";
//		String sh_mp ="0";
//		String mp_empn ="";
//		
//		if(shift.equals("")){
//			System.out.println("請勾選是否輪休");		
//		}else if(shift.equals("Y") && 
//				!"".equals(shst1) && null!=shst1 && !"".equals(shet1) && null!=shet1 && 
//				!"".equals(shst2) && null!=shst2 && !"".equals(shet2)&& null!= shet2 )
//		{
//					int times = 4;
//					String[] timeChk = {shst1,shet1,shst2,shet2};
//					int[] year = new int[times];
//					int[] month = new int[times];
//					int[] date = new int[times];
//					int[] hourOfDay = new int[times];
//					int[] minute = new int[times];
//					Calendar[] cal = new Calendar[(times+1)];					
//						//out.println(shst1.substring(0,4)+ shst1.substring(5,7)+shst1.substring(8,10)+shst1.substring(11,13)+shst1.substring(14,16));
//					for(int i=0 ;i<timeChk.length ;i++){
//						year[i] =  Integer.parseInt(timeChk[i].substring(0,4));
//						month[i] = Integer.parseInt(timeChk[i].substring(5,7))-1;
//						date[i] = Integer.parseInt(timeChk[i].substring(8,10));
//						hourOfDay[i] = Integer.parseInt(timeChk[i].substring(11,13));
//						minute[i] = Integer.parseInt(timeChk[i].substring(14,16));
//						cal[i] = new GregorianCalendar();
//						cal[i].set(year[i], month[i], date[i], hourOfDay[i], minute[i]);
//						System.out.println(cal[i].getTime());
//					}
//					cal[4] = new GregorianCalendar();
//					cal[4].set(Integer.parseInt(fdate.substring(0,4)), Integer.parseInt(fdate.substring(5,7))-1, Integer.parseInt(fdate.substring(8,10)),0,0,0);
////					System.out.println(cal[4].getTime());
//					if(cal[0].after(cal[1]) || cal[2].after(cal[3])){
//						System.out.println("日期時間選擇錯誤,總時間不可為負值");
//					}else if(cal[1].after(cal[2])){
//						System.out.println("第二段輪休開始時間錯誤");
//					}else if(cal[4].after(cal[0])){
//						System.out.println("開始時間不可早於航班日期");
//					}else if ((cal[1].getTimeInMillis()-cal[0].getTimeInMillis())/60/60/1000 > 6 ||
//							(cal[3].getTimeInMillis()-cal[2].getTimeInMillis())/60/60/1000 > 6){
//						System.out.println("選擇錯誤,總休時不可超過6小時");
//					}
//					
//					if(sh_cm.equals("0") || sh_cm.equals("")){						
//						System.out.println("請選CM輪休梯次");
//					}
//					if(!mp_empn.equals("") && (sh_mp.equals("0") || sh_mp.equals(""))){//有MP則需填
//						System.out.println("請選MP輪休梯次");
//					}
//					for(int i=0;i<duty.length;i++){
//						if(!duty[i].equals("X") && sh_crew[i].equals("0")){
//							System.out.println("請選擇組員輪休梯次");
//						}
//					}
//					
//					
//
//					
//		}
//		System.out.println("done");
//	}
}

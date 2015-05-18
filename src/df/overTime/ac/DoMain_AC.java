package df.overTime.ac;

import java.io.*;
import java.text.*;
import java.util.*;

/**
 * @author cs71 Created on  2007/11/21
 */
public class DoMain_AC
{
    private String year = "";
    private String month = "";
    
    public static void main(String[] args)
    {  
//        SimpleDateFormat f = new SimpleDateFormat("yyyy/MM/dd");
//        Calendar gc = new GregorianCalendar();  
//        gc.set(2007,12,1);
////        System.out.println(f.format(gc));
//        System.out.println(f.format(gc.getTime()));
//        
//        Calendar gcnow = new GregorianCalendar();  
//        gcnow.set(2007,12,1);
////        System.out.println(f.format(gc));
//        System.out.println(f.format(gcnow.getTime()));        
//
////        System.out.println(gc.before(gcnow));
//        if(gc.after(gcnow))
//        {
//            System.out.println("old");
//        }
//        else
//        {
//            System.out.println("new");
//        }
        
        DoMain_AC d = new DoMain_AC();
        d.doMain("2009","10");  
        System.out.println("Done");
    }
        
    public void doMain(String year, String month)  
    {   
		try
		{
			String path = "/apsource/csap/projdf/webap/DF/file/";			
//		    String path = "C:///DF/file/";
		    String filename = "OverTimeHrs.txt";		    
			FileWriter fwlog = new FileWriter(path+filename,true);
			
			fwlog.write("Calculate "+year+"/"+month+" OverTimeHrs & Overtime Payment\r\n");
			java.util.Date runDate1 = Calendar.getInstance().getTime();
			String time1 = new SimpleDateFormat("yyyy/MM/dd EEE HH:mm:ss a").format(runDate1);
			fwlog.write("Process starts at    " + time1 +" \r\n");			
			
			RetrieveOverTimeData_AC rot = new RetrieveOverTimeData_AC(year, month);
            //clrOverTimeData
            rot.clrOverTimeData();
            fwlog.write("----Return clrOverTimeData " + rot.getErrorStr() +" \r\n");
			java.util.Date runDate2 = Calendar.getInstance().getTime();
			String time2 = new SimpleDateFormat("yyyy/MM/dd EEE HH:mm:ss a").format(runDate2);
			fwlog.write("----retrieveOverTimeData starts at    " + time2 +" \r\n");
//            retrieveOverTimeData        
            rot.retrieveOverTimeData();
            fwlog.write("----Return retrieveOverTimeData " + rot.getErrorStr() +" \r\n");
			java.util.Date runDate3 = Calendar.getInstance().getTime();
			String time3 = new SimpleDateFormat("yyyy/MM/dd EEE HH:mm:ss a").format(runDate3);
			fwlog.write("----retrieveOverTimeData end at    " + time3 +" \r\n"); 
			java.util.Date runDate4 = Calendar.getInstance().getTime();
			String time4 = new SimpleDateFormat("yyyy/MM/dd EEE HH:mm:ss a").format(runDate4);
			//insOverTimeData();
			rot.insOverTimeData();	
			fwlog.write("----Return insOverTimeData " + rot.getErrorStr() +" \r\n");
			fwlog.write("----insOverTimeData end at    " + time4 +" \r\n"); 			
			fwlog.write("----Done for RetrieveOverTimeData at    " + time4 +" \r\n"); 
			java.util.Date runDate5 = Calendar.getInstance().getTime();
			String time5 = new SimpleDateFormat("yyyy/MM/dd EEE HH:mm:ss a").format(runDate5);			
			rot.adjSBIR();
			fwlog.write("----Done for adjSB " + new java.util.Date() +" \r\n"); 
			if(Integer.parseInt((year+month)) >= 200907)
			{
			    rot.adjSB();
			}
			fwlog.write("----Done for adjSB " + new java.util.Date() +" \r\n"); 			
			fwlog.write("----Error msg " + rot.getErrorStr() +" \r\n"); 			
            System.out.println("Done for RetrieveOverTimeData_AC ");
            
            SumOverTime_AC ovr = new SumOverTime_AC(year, month);            
            //set overpay rate to pock
            ovr.setOverRate();
           //update ovrhrs, ovrpayrate, ovrpay to dftpock
            ovr.sumOverPay();
            fwlog.write("Done for SumOverTime_AC \r\n"); 			    
			//End
			java.util.Date runDate6 = Calendar.getInstance().getTime();
			String time6 = new SimpleDateFormat("yyyy/MM/dd EEE HH:mm:ss a").format(runDate6);
			fwlog.write("Process finishes at   " + time6 +" \r\n");	
			fwlog.write("*************************************** \r\n\r\n");	
			fwlog.close();			
		}
		catch (Exception e)
		{
			System.out.println(e.toString());
		}       
   }
}

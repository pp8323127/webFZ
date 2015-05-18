package apis_new;

import java.io.*;
import java.text.*;
import java.util.*;
/**
 * @author cs71 Created on  2010/6/30
 */
public class DoAPISSkjJob
{      
    public static void main(String[] args)
    {       
        DoAPISSkjJob doapis = new DoAPISSkjJob();
        doapis.doAPISCheck();
        System.out.println("Done");
    }
    
    String tday = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    String path = "C:///APIS/";
    String filename = "apislog_"+tday+".txt";		    
	FileWriter fwlog = null;
    
    public void doAPISCheck()
    {           
        try
		{            
            fwlog = new FileWriter(path+filename,true);
			fwlog.write("****** RUN APIS starts : "+ new java.util.Date()+" ****** \r\n");
	        ArrayList apisfltAL = new ArrayList();
	        
	        APISSkjJob c = new APISSkjJob();
	        //c.getAPISFlt();
	        apisfltAL = c.getAPISFltAL();	 
	        //get Country
	        PortCity pc = new PortCity();
	        pc.getPortCityData();
	        
	        if(apisfltAL.size()>0)
	        {
	            for(int i=0; i < apisfltAL.size(); i++)
	            {
	                Hashtable myHT  = new Hashtable();
	                Hashtable myHT2  = new Hashtable();
	                ArrayList apisdetailAL = new ArrayList();
	                APISObj obj = (APISObj) apisfltAL.get(i);
	                c.getAPISFltDetail_Aircrews(obj.getStdtpe(),obj.getFltno(),obj.getDpt(),obj.getArv());
	                c.getAPISFltDetail_DB2(obj.getFdate(),obj.getFltno(),obj.getDpt(),obj.getArv(),obj.getStr_port_local(),obj.getEnd_port_local(),obj.getStdtpe(),obj.getFly_status());
	                apisdetailAL = c.getObjAL();
	                
	                if(apisdetailAL.size()>0)
	                {
	                    int ifsent_cnt = c.checkIfSent(apisdetailAL);

	                    //是否已送過
	                    if(ifsent_cnt<=0)
	                    {//尚未送過
	                        if(obj.getDa13AL().size()>0)
	                        {
		                        //get apis un/edifact txt, send apis
	                            PortCityObj portobj1 = pc.getPortCityObj(obj.getDpt());
	    		   	         	PortCityObj portobj2 = pc.getPortCityObj(obj.getArv());  
	    		   	         	
	    			   	         if("UK".equals(portobj1.getCtry()))
	    				         {
	    			   	             myHT = c.getUKDptAPISTxtHT(obj,apisdetailAL);
	    				         }
	    			   	         else
	    			   	         {
	    			   	             myHT = c.getDptAPISTxtHT(obj,apisdetailAL);
	    			   	         }
	    			   	         
	    			   	         if("UK".equals(portobj2.getCtry()))
	    				         {
	    			   	             myHT2 = c.getUKArvAPISTxtHT(obj,apisdetailAL); 
	    				         }
	    			   	         else
	    			   	         {
	    			   	             myHT2 = c.getArvAPISTxtHT(obj,apisdetailAL); 
	    			   	         }		
	    			   	         
		                        if(myHT.size()>0)
		                        {
	//		                        System.out.println("myHT.size "+ myHT.size());
			                        Set keyset = myHT.keySet();
			    			        Iterator itr = keyset.iterator();
			    			        int idx = 0;
			    			        while(itr.hasNext())
			    			    	{
			    			            idx++;
			    			    	    String key = String.valueOf(itr.next());
			    			    	    String value = (String)myHT.get(key);	
			    			    	    //*************************************
			    			    	    //Telex path
			    			    	    FileWriter fw =  new FileWriter(path+obj.getStdtpe().replaceAll("/|:| ","")+"_"+obj.getFltno()+"_"+obj.getDpt()+"_"+obj.getArv()+"_DPT"+idx+".TXT",false);
			    			    	    fw.write(value);
			    			    	    fw.flush();
			    					    fw.close();
			    					    //*************************************
			    			    	} 	
		                        }
		                        
		                        if(myHT2.size()>0)
		                        {
	//		                        System.out.println("myHT2.size "+ myHT2.size());
			                        Set keyset = myHT2.keySet();
			    			        Iterator itr = keyset.iterator();
			    			        int idx = 0;
			    			        while(itr.hasNext())
			    			    	{
			    			            idx++;
			    			    	    String key = String.valueOf(itr.next());
			    			    	    String value = (String)myHT2.get(key);
//			    			    	  *************************************
			    			    	    //Telex path
			    			    	    FileWriter fw =  new FileWriter(path+obj.getStdtpe().replaceAll("/|:| ","")+"_"+obj.getFltno()+"_"+obj.getDpt()+"_"+obj.getArv()+"_ARV"+idx+".TXT",false);
			    			    	    fw.write(value);
			    			    	    fw.flush();
			    					    fw.close();
//			    					  *************************************
			    			    	} 	
		                        }
		                        
		                        if(myHT.size()>0 | myHT2.size()>0)
		                        {
				                    fwlog.write("  Stdtpe : "+obj.getStdtpe()+"  Fltno : "+obj.getFltno()+"  Dpt : "+obj.getDpt()+"  Arv : "+obj.getArv()+"\r\n");
			                        //write fztselg
				                    String sendtmst = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new java.util.Date());
			                        for(int d=0; d<apisdetailAL.size(); d++)
			                        {	    
			                            APISObj detailobj = (APISObj) apisdetailAL.get(d);
			                            detailobj.setTmst(sendtmst);
			                            c.writeSentLog(detailobj,"SYSTEM","AUTO");
			                        }
		                        }
	                        }
	                        else
	                        {//if(obj.getDa13AL().size()<=0)
	                         // Mapping 不到 da13 資料, 通知簽派
	                            fwlog.write("  Stdtpe : "+obj.getStdtpe()+"  Fltno : "+obj.getFltno()+"  Dpt : "+obj.getDpt()+"  Arv : "+obj.getArv()+" getDa13AL.size() <=0"+"\r\n");
	                            StringBuffer sb = new StringBuffer();
	    			    	    sb.append("QD TPEOSCI TPEEDCI"+"\r\n");
	    			    	    sb.append(".TPECSCI"+"\r\n");
	    			    	    sb.append("-----NOTICE F/APIS CREW CHECK-----"+"\r\n");
	    			    	    sb.append("*"+"\r\n");
	    			    	    sb.append("****SERIOUS APIS ERROR FOUND****"+"\r\n");
	    			    	    sb.append("****CANNOT AUTO SEND DUE FLT NOT MATCH****"+"\r\n");
	    			    	    sb.append("PLS MANUALLY SEND APIS"+"\r\n");
	    			    	    sb.append(obj.getCarrier()+obj.getFltno()+" "+obj.getDpt()+" "+obj.getArv()+" TPEMMDD "+obj.getStdtpe().substring(11).replaceAll(":","")+" LCLMMDD "+obj.getStr_port_local().substring(11).replaceAll(":","")+"\r\n");	
	    			    	    APISObj chklogobj = (APISObj) apisdetailAL.get(0);
								chklogobj.setMsgSB(sb);
								//write check log
								c.writeCheckLog(chklogobj);
								//email log content
								Email el = new Email(); 
								//live tpeosci@email.china-airlines.com,tpeedbox@china-airlines.com
								el.sendEmail("tpeosci@cal.aero", "pierce@china-airlines.com,betty.yu@china-airlines.com","tpecsci@cal.aero", "SERIOUS APIS ERROR FOUND",sb);
//								el.sendEmail("tpeosci@cal.aero", "betty.yu@china-airlines.com","tpecsci@cal.aero","SERIOUS APIS ERROR FOUND",sb);
	                        }
	                    }
	                    else
	                    {//if(ifsent_cnt>0)
	                        //do not send again	 
	                        //check un-match
	                        Hashtable unmatchHT = c.checkUnMatch(apisdetailAL);
	                        Set keyset = unmatchHT.keySet();
	    			        Iterator itr = keyset.iterator();
	    			        StringBuffer hasASB = new StringBuffer();
	    			        StringBuffer hasNSB = new StringBuffer();
	    			        while(itr.hasNext())
	    			    	{
	    			    	    String key = String.valueOf(itr.next());
	    			    	    APISObj valueobj = (APISObj)unmatchHT.get(key);	    			    	    
	    			    	    if("A".equals(valueobj.getRemark()))
	    			    	    {//unmatch sent log crew not in aircrews 
	    			    	     //sentlog 有 aircrews 無
	    			    	        hasASB.append(valueobj.getOccu()+" "+valueobj.getEmpno()+" "+valueobj.getCarrier()+valueobj.getFltno()+" "+valueobj.getDpt()+" "+valueobj.getArv()+" TPEMMDD "+valueobj.getStdtpe().substring(11).replaceAll(":","")+" LCLMMDD "+valueobj.getStr_port_local().substring(11).replaceAll(":","")+"\r\n");	    			    	        
//System.out.println("**** SENT LOG CREW NOT IN AIRCREWS ****"+valueobj.getOccu()+" "+valueobj.getEmpno()+" "+valueobj.getCarrier()+valueobj.getFltno()+" "+valueobj.getDpt()+" "+valueobj.getArv()+" TPEMMDD "+valueobj.getStdtpe().substring(11).replaceAll(":","")+" LCLMMDD "+valueobj.getStr_port_local().substring(11).replaceAll(":",""));	    			    	        
	    			    	    }
	    			    	    else if("N".equals(valueobj.getRemark()))
	    			    	    {//unmatch Aircrews crew not in sent log 
	    			    	     //sentlog 無 aircrews 有		    			
	    			    	        hasNSB.append(valueobj.getOccu()+" "+valueobj.getEmpno()+" "+valueobj.getCarrier()+valueobj.getFltno()+" "+valueobj.getDpt()+" "+valueobj.getArv()+" TPEMMDD "+valueobj.getStdtpe().substring(11).replaceAll(":","")+" LCLMMDD "+valueobj.getStr_port_local().substring(11).replaceAll(":","")+"\r\n");
//System.out.println("**** AIRCREWS CREW NOT IN SENT LOG ****"+valueobj.getOccu()+" "+valueobj.getEmpno()+" "+valueobj.getCarrier()+valueobj.getFltno()+" "+valueobj.getDpt()+" "+valueobj.getArv()+" TPEMMDD "+valueobj.getStdtpe().substring(11).replaceAll(":","")+" LCLMMDD "+valueobj.getStr_port_local().substring(11).replaceAll(":",""));   			    	             
	    			    	    }
	    			    	    else
	    			    	    {
	    			    	        //match do nothing
	    			    	    }
	    			    	} 		   
	    			    	    
    			    	    //write fztcklg
    			    	    if(hasASB.length()>0 | hasNSB.length()>0 )
    			    	    {//通知簽派
	    			    	    StringBuffer sb = new StringBuffer();
	    			    	    sb.append("QD TPEOSCI TPEEDCI"+"\r\n");
	    			    	    sb.append(".TPECSCI"+"\r\n");
	    			    	    sb.append("-----NOTICE F/APIS CREW CHECK-----"+"\r\n");
	    			    	    sb.append("*"+"\r\n");
	    			    	    sb.append("****SERIOUS APIS ERROR FOUND****"+"\r\n");
	    			    	    sb.append("****APIS DATA NOT MATCH****"+"\r\n");
	    			    	    sb.append("PLS CHK AIRCREWS CREW LIST AND APIS DATA"+"\r\n");
	    			    	    if(hasNSB.length()>0)
	    			    	    {
	    			    	        sb.append("PLS RESEND APIS DATA"+"\r\n");
	    			    	        sb.append("****AIRCREWS CREW NOT IN SENT LOG****"+"\r\n");
	    			    	        sb.append(hasNSB.toString());
	    			    	        sb.append("\r\n");
	    			    	    }
	    			    	    
	    			    	    if(hasASB.length()>0)
	    			    	    {
	    			    	        sb.append("PLS RE-TRANSFER APIS DATA AND RESEND APIS DATA"+"\r\n");
	    			    	        sb.append("****SEND LOG CREW NOT IN AIRCREWS****"+"\r\n");
	    			    	        sb.append(hasASB.toString());
	    			    	        sb.append("\r\n");
	    			    	    }
//	    			    	    System.out.println(sb.toString());
	    			    	    if(apisdetailAL.size()>0)
	    			    	    {
	    			    	        APISObj chklogobj = (APISObj) apisdetailAL.get(0);
	    			    	        chklogobj.setMsgSB(sb);
	    			    	        //write check log
	    			    	        c.writeCheckLog(chklogobj);
	    			    	        //email log content
	    			    	        Email el = new Email(); 
	    			    	        //live tpeosci@email.china-airlines.com,tpeedbox@china-airlines.com
	    			    	        el.sendEmail("tpeosci@cal.aero", "pierce@china-airlines.com,betty.yu@china-airlines.com","tpecsci@cal.aero","SERIOUS APIS ERROR FOUND",sb);	
//	    			    	        el.sendEmail("tpeosci@cal.aero", "betty.yu@china-airlines.com","tpecsci@cal.aero","SERIOUS APIS ERROR FOUND",sb);
	    			    	    }
    			    	    } 			        
	                    }	                
	                }   
	                else
	                {//if(apisdetailAL.size()>0)
	                    fwlog.write("  Stdtpe : "+obj.getStdtpe()+"  Fltno : "+obj.getFltno()+"  Dpt : "+obj.getDpt()+"  Arv : "+obj.getArv()+" apisdetailAL.size() <=0"+"\r\n");
	                }
	            }//for(int i=0; i < apisfltAL.size(); i++)   
	            fwlog.write("****** RUN APIS end    : "+ new java.util.Date()+" ****** \r\n");
	        }
	        else
	        {//if(apisfltAL.size()>0)
	            fwlog.write("****** RUN APIS end    : "+ new java.util.Date()+" ****** \r\n");
	        }
	        fwlog.flush();
		    fwlog.close();
		}
		catch (Exception e)
		{
			System.out.println("Error ## "+e.toString());
			try
			{
			    fwlog.write("****** RUN APIS Error : "+ new java.util.Date()+" --> "+e.toString()+"\r\n");
			    fwlog.flush();
			    fwlog.close();
			}
			catch (Exception e1)
			{}
		} 
		finally
		{
		    
		}
   }
}

package apis_autorun;

import java.io.*;
import java.text.*;
import java.util.*;
/**
 * @author cs71 Created on  2010/6/30
 */
public class DoAPISSkjJob
{      
    //Need to compile  apis_autorun & ftp
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
	        c.getAPISFlt();
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
	                boolean ifneedapis = false;
	                ArrayList apisdetailAL = new ArrayList();
	                APISObj obj = (APISObj) apisfltAL.get(i);
	                c.getAPISFltDetail_Aircrews(obj.getStdtpe(),obj.getFltno(),obj.getDpt(),obj.getArv());
	                c.getAPISFltDetail_DB2(obj.getFdate(),obj.getFltno(),obj.getDpt(),obj.getArv(),obj.getStr_port_local(),obj.getEnd_port_local(),obj.getStdtpe(),obj.getFly_status());
	                apisdetailAL = c.getObjAL();
	                if(apisdetailAL.size()>0)
	                {
	                    //Check AUTO send, BEF & AFT 各發一次
	                    int ifsent_cnt = c.checkIfSent(apisdetailAL);
	                    //check if need apis
	                    PortCityObj portobj1 = pc.getPortCityObj(obj.getDpt());
		   	         	PortCityObj portobj2 = pc.getPortCityObj(obj.getArv()); 
		   	         	//if dpt in 'USA','CHINA','CANADA','KOREA','INDIA','NEW ZEALAND','TAIWAN' send apis
		   	         	//if arv in 'USA','CHINA','CANADA','JAPAN','KOREA','INDIA','NEW ZEALAND','TAIWAN' send apis
//		   	         	if("USA,CHINA,CANADA,KOREA,INDIA,NEW ZEALAND".indexOf(portobj1.getCtry())>=0)
		   	            if("USA,CHINA,CANADA,KOREA,INDIA,NEW ZEALAND,TAIWAN,UK".indexOf(portobj1.getCtry())>=0)
		   	         	{
		   	         	    ifneedapis = true ;
		   	         	}
		   	         	
		   	         	if("USA,CHINA,JAPAN,CANADA,KOREA,INDIA,NEW ZEALAND,TAIWAN,UK,NETHERLANDS".indexOf(portobj2.getCtry())>=0)
		   	         	{
		   	         	    ifneedapis = true ;
		   	         	}
		   	         	
		   	         	if(ifneedapis==true)
		   	         	{
		                    //是否已送過
		                    if(ifsent_cnt<=0)
		                    {//尚未送過
		                        if(obj.getDa13AL().size()>0)
		                        {		                            
		                            StringBuffer errorSB = new StringBuffer();
		                            boolean ifcorrect = true;
		                            boolean iscargo = false;
		                            
		                            DA13Obj da13obj = (DA13Obj) obj.getDa13AL().get(0) ;
			           	            if("74X".equals(da13obj.getDa13_actp()) | "74Y".equals(da13obj.getDa13_actp()))
			           	            {
			           	                 iscargo = true;
			           	            }
		                            
			                        //get apis un/edifact txt, send apis					   	         	
					   	            if("".equals(portobj1.getCtry()) | portobj1.getCtry() == null)
					   	         	{
					   	                ifcorrect = false;
					   	                errorSB.append(" "+obj.getDpt()+" DOES NOT IN FZTCITY");
					   	         	}
					   	            
					   	         	if("".equals(portobj2.getCtry()) | portobj2.getCtry() == null)
					   	         	{
					   	         	    ifcorrect = false;
					   	         	    errorSB.append(" "+obj.getArv()+" DOES NOT IN FZTCITY");
					   	         	}
					   	         	
						   	         if("UK".equals(portobj1.getCtry()))
							         {
						   	             myHT = c.getUKDptAPISTxtHT(obj,apisdetailAL);
						   	             if(!"Y".equals(c.getErrorStr()))
						   	             {
						   	                 ifcorrect = false;
						   	                 errorSB.append(" INSUFFICIENT CREW INFO");
						   	             }
							         }
						   	         else if("NEW ZEALAND".equals(portobj1.getCtry()))
							         {
						   	             myHT = c.getNZDptAPISTxtHT(obj,apisdetailAL);
						   	             if(!"Y".equals(c.getErrorStr()))
						   	             {
						   	                 ifcorrect = false;
						   	                 errorSB.append(" INSUFFICIENT CREW INFO");
						   	             }
							         }
							   	     else if("NETHERLANDS".equals(portobj1.getCtry()))
							   		 {
							   			 myHT = c.getNLDptAPISTxtHT(obj,apisdetailAL);
							   			 if(!"Y".equals(c.getErrorStr()))
							   			 {
							   				 ifcorrect = false;
							   				 errorSB.append(" INSUFFICIENT CREW INFO");
							   			 }
							   		 }
						   	         else if("CHINA".equals(portobj1.getCtry()))
							         {
						   	             myHT = c.getCNDptAPISTxtHT(obj,apisdetailAL);
						   	             if(!"Y".equals(c.getErrorStr()))
						   	             {
						   	                 ifcorrect = false;
						   	                 errorSB.append(" INSUFFICIENT CREW INFO");
						   	             }
							         }
						   	         else if("TAIWAN".equals(portobj1.getCtry()))
							         {
						   	             myHT = c.getTWDptAPISTxtHT(obj,apisdetailAL);
						   	             if(!"Y".equals(c.getErrorStr()))
						   	             {
						   	                 ifcorrect = false;
						   	                 errorSB.append(" INSUFFICIENT CREW INFO");
						   	             }
							         }
						   	         else
						   	         {
						   	             myHT = c.getDptAPISTxtHT(obj,apisdetailAL);
						   	             if(!"Y".equals(c.getErrorStr()))
						   	             {
						   	                 ifcorrect = false;
						   	                 errorSB.append(" INSUFFICIENT CREW INFO");
						   	             }
						   	         }
						   	         
						   	         if("UK".equals(portobj2.getCtry()))
							         {
						   	             myHT2 = c.getUKArvAPISTxtHT(obj,apisdetailAL); 
						   	             if(!"Y".equals(c.getErrorStr()))
						   	             {
						   	                 ifcorrect = false;
						   	                 errorSB.append(" INSUFFICIENT CREW INFO");
						   	             }
							         }
						   	         else if("NEW ZEALAND".equals(portobj2.getCtry()))
							         {
						   	             myHT2 = c.getNZArvAPISTxtHT(obj,apisdetailAL); 
						   	             if(!"Y".equals(c.getErrorStr()))
						   	             {
						   	                 ifcorrect = false;
						   	                 errorSB.append(" INSUFFICIENT CREW INFO");
						   	             }
							         }
							   	     else if("NETHERLANDS".equals(portobj2.getCtry()))
							   		 {
							   			 myHT2 = c.getNLArvAPISTxtHT(obj,apisdetailAL); 
							   			 if(!"Y".equals(c.getErrorStr()))
							   			 {
							   				 ifcorrect = false;
							   				 errorSB.append(" INSUFFICIENT CREW INFO");
							   			 }
							   		 }
						   	         else if("CHINA".equals(portobj2.getCtry()))
							         {
						   	             myHT2 = c.getCNArvAPISTxtHT(obj,apisdetailAL); 
						   	             if(!"Y".equals(c.getErrorStr()))
						   	             {
						   	                 ifcorrect = false;
						   	                 errorSB.append(" INSUFFICIENT CREW INFO");
						   	             }
							         }
						   	         else if("TAIWAN".equals(portobj2.getCtry()))
							         {
						   	             myHT2 = c.getTWArvAPISTxtHT(obj,apisdetailAL); 
						   	             if(!"Y".equals(c.getErrorStr()))
						   	             {
						   	                 ifcorrect = false;
						   	                 errorSB.append(" INSUFFICIENT CREW INFO");
						   	             }
							         }
						   	         else
						   	         {
						   	             myHT2 = c.getArvAPISTxtHT(obj,apisdetailAL); 
						   	             if(!"Y".equals(c.getErrorStr()))
						   	             {
						   	                 ifcorrect = false;
						   	                 errorSB.append(" INSUFFICIENT CREW INFO");
						   	             }
						   	         }
					   	         
						   	         if(ifcorrect == true)
						   	         {//		                        
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
					    			    	    String filename = obj.getStdtpe().replaceAll("/|:| ","")+"_"+obj.getFltno()+"_"+obj.getDpt()+"_"+obj.getArv()+"_DPT"+idx+".TXT";
		//			    			    	    FileWriter fw =  new FileWriter(path+obj.getStdtpe().replaceAll("/|:| ","")+"_"+obj.getFltno()+"_"+obj.getDpt()+"_"+obj.getArv()+"_DPT"+idx+".TXT",false);
					    			    	    FileWriter fw =  new FileWriter(path+filename,false);		    			    	    
					    			    	    fw.write(value);
					    			    	    fw.flush();
					    					    fw.close();		
					    					    
		//			    					    System.out.println("path+filename = "+path+filename);
		//			    					    System.out.println("filename = "+filename);
					    					    ftp.putFile pf = new ftp.putFile();
					    					    pf.doFtp(path+filename,filename);//doFtp(String locfilepath, String ftpfilename)
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
					    			    	    String filename = obj.getStdtpe().replaceAll("/|:| ","")+"_"+obj.getFltno()+"_"+obj.getDpt()+"_"+obj.getArv()+"_ARV"+idx+".TXT";
		//			    			    	    FileWriter fw =  new FileWriter(path+obj.getStdtpe().replaceAll("/|:| ","")+"_"+obj.getFltno()+"_"+obj.getDpt()+"_"+obj.getArv()+"_ARV"+idx+".TXT",false);
					    			    	    FileWriter fw =  new FileWriter(path+filename,false);		  
					    			    	    fw.write(value);
					    			    	    fw.flush();
					    					    fw.close();
		//			    					    System.out.println("path+filename = "+path+filename);
		//			    					    System.out.println("filename = "+filename);
					    					    ftp.putFile pf = new ftp.putFile();
					    					    pf.doFtp(path+filename,filename);//doFtp(String locfilepath, String ftpfilename)
		//			    					  *************************************
					    			    	} 	
				                        }
				                        
				                        if(myHT.size()>0 | myHT2.size()>0)
				                        {
				                            //Send APIS CREW COUNT
				                            int cr1 =0;
				                            int cr2 =0;
				                            int cr3 =0;
				                            int cr4 =0;
				                            int cr5 =0;
				                            
					    			        for(int o=0; o<apisdetailAL.size();o++)
					    			        {
					    			            APISObj apisdetailobj = (APISObj) apisdetailAL.get(o);
					    			            if("CR1".equals(apisdetailobj.getTvlstatus()))
					    			        	{
					    			        		cr1 ++;
					    			        	}
					    			        	if("CR2".equals(apisdetailobj.getTvlstatus()))
					    			        	{
					    			        		cr2 ++;
					    			        	}
					    			        	if("CR3".equals(apisdetailobj.getTvlstatus()))
					    			        	{
					    			        		cr3 ++;
					    			        	}
					    			        	if("CR4".equals(apisdetailobj.getTvlstatus()))
					    			        	{
					    			        		cr4 ++;
					    			        	}
					    			        	if("CR5".equals(apisdetailobj.getTvlstatus()))
					    			        	{
					    			        		cr5 ++;
					    			        	}					    			            
					    			        }	
					    			        //*************************************
				    			    	    //Telex path
				    			    	    String filename = obj.getStdtpe().replaceAll("/|:| ","")+"_"+obj.getFltno()+"_"+obj.getDpt()+"_"+obj.getArv()+".TXT";
				    			    	    FileWriter fw =  new FileWriter(path+filename,false);	
				    			    	    StringBuffer crewcntSB = new StringBuffer();
				    			    	    //crewcntSB.append("QD TPEOSCI TPEEDCI TPEWGCI TPETTCI"+"\r\n");
				    			    	    
				    			    	    if(iscargo == true)
				    			    	    {
				    			    	        crewcntSB.append("QD TPEOSCI TPEEDCI TPEWGCI "+obj.getDpt()+"FFCI "+obj.getArv()+"FFCI"+"\r\n");					    			    	    
					    			    	    crewcntSB.append("."+obj.getDpt()+"FFCI"+"\r\n");
				    			    	    }
				    			    	    else
				    			    	    {
				    			    	        crewcntSB.append("QD TPEOSCI TPEEDCI TPEWGCI "+obj.getDpt()+"TTCI "+obj.getArv()+"TTCI "+"\r\n");					    			    	    
					    			    	    crewcntSB.append("."+obj.getDpt()+"TTCI"+"\r\n");
				    			    	    }
				    			    	    
				    			    	    //crewcntSB.append("QD TPEOSCI TPEEDCI TPEWGCI "+obj.getDpt()+"TTCI "+obj.getDpt()+"FFCI "+obj.getArv()+"TTCI "+obj.getArv()+"FFCI"+"\r\n");
				    			    	    //crewcntSB.append(".TPETTCI"+"\r\n");
				    			    	    //crewcntSB.append("."+obj.getDpt()+"TTCI"+"\r\n");
				    			    	    crewcntSB.append("****AUTO****"+"\r\n");
				    			    	    crewcntSB.append(obj.getCarrier()+obj.getFltno()+" "+obj.getStdtpe()+" "+obj.getDpt()+obj.getArv()+" APIS HAS SENT"+"\r\n");
				    			    	    crewcntSB.append("CREW   "+apisdetailAL.size()+"\r\n");
				    			    	    crewcntSB.append("CR1    "+cr1+"\r\n");
				    			    	    crewcntSB.append("CR2    "+cr2+"\r\n");
				    			    	    crewcntSB.append("CR3    "+cr3+"\r\n");
				    			    	    crewcntSB.append("CR4    "+cr4+"\r\n");
				    			    	    crewcntSB.append("CR5    "+cr5+"\r\n");		
				    			    	    crewcntSB.append("\r\n"+"IF NEED RESEND X PLZ CONTACT TPEOSCI OR TPEEDCI"+"\r\n");
				    			    	    fw.write(crewcntSB.toString());
				    			    	    fw.flush();
				    					    fw.close();
	//			    					    System.out.println("path+filename = "+path+filename);
	//			    					    System.out.println("filename = "+filename);
				    					    ftp.putFile pf = new ftp.putFile();
				    					    pf.doFtp(path+filename,filename);//doFtp(String locfilepath, String ftpfilename)
	//			    					  *************************************
				                            
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
						   	         {//if(ifcorrect == false)
						   	            //error occur, does not send 
						   	            fwlog.write("  Stdtpe : "+obj.getStdtpe()+"  Fltno : "+obj.getFltno()+"  Dpt : "+obj.getDpt()+"  Arv : "+obj.getArv()+" ERROR:"+errorSB.toString()+"\r\n");
			                            StringBuffer sb = new StringBuffer();
			    			    	    sb.append("QD TPEOSCI TPEEDCI"+"\r\n");
			    			    	    sb.append(".TPECSCI"+"\r\n");
			    			    	    sb.append("-----NOTICE F/APIS CREW CHECK-----"+"\r\n");
			    			    	    sb.append("*"+"\r\n");
			    			    	    sb.append("****FATAL APIS ERROR FOUND****"+"\r\n");
			    			    	    sb.append("****CANNOT AUTO SEND DUE ");
			    			    	    sb.append(errorSB.toString()+"****"+"\r\n");
			    			    	    sb.append("PLS HANDLE THEN MANUALLY SEND APIS"+"\r\n");
			    			    	    sb.append(obj.getCarrier()+obj.getFltno()+" "+obj.getDpt()+" "+obj.getArv()+" TPEMMDD "+obj.getStdtpe().substring(11).replaceAll(":","")+" LCLMMDD "+obj.getStr_port_local().substring(11).replaceAll(":","")+"\r\n");	
			    			    	    APISObj chklogobj = (APISObj) apisdetailAL.get(0);
										chklogobj.setMsgSB(sb);
										//write check log
										c.writeCheckLog(chklogobj);
										//email log content
										Email el = new Email(); 
										//live tpeosci@email.china-airlines.com,tpeedbox@china-airlines.com								
										el.sendEmail("tpeosci@cal.aero","tpeosci@email.china-airlines.com,tpeedbox@china-airlines.com","pierce@china-airlines.com,tpecsci@cal.aero","FATAL APIS ERROR FOUND",sb);
	//									el.sendEmail("tpeosci@cal.aero", "betty.yu@china-airlines.com","640790@cal.aero","FATAL APIS ERROR FOUND",sb);
										//*************************************
			    			    	    //Telex path
			    			    	    String filename = obj.getStdtpe().replaceAll("/|:| ","")+"_"+obj.getFltno()+"_"+obj.getDpt()+"_"+obj.getArv()+"ERROR.TXT";	    			    	    
			    			    	    FileWriter fw =  new FileWriter(path+filename,false);		  
			    			    	    fw.write(sb.toString());
			    			    	    fw.flush();
			    					    fw.close();
			    					    ftp.putFile pf = new ftp.putFile();
			    					    pf.doFtp(path+filename,filename);//doFtp(String locfilepath, String ftpfilename)
			    					    //*************************************
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
		    			    	    sb.append("****FATAL APIS ERROR FOUND****"+"\r\n");
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
									el.sendEmail("tpeosci@cal.aero","tpeosci@email.china-airlines.com,tpeedbox@china-airlines.com","pierce@china-airlines.com,tpecsci@cal.aero","FATAL APIS ERROR FOUND",sb);
	//								el.sendEmail("tpeosci@cal.aero", "betty.yu@china-airlines.com","640790@cal.aero","FATAL APIS ERROR FOUND",sb);
									//*************************************
		    			    	    //Telex path
		    			    	    String filename = obj.getStdtpe().replaceAll("/|:| ","")+"_"+obj.getFltno()+"_"+obj.getDpt()+"_"+obj.getArv()+"ERROR.TXT";	    			    	    
		    			    	    FileWriter fw =  new FileWriter(path+filename,false);		  
		    			    	    fw.write(sb.toString());
		    			    	    fw.flush();
		    					    fw.close();
		    					    ftp.putFile pf = new ftp.putFile();
		    					    pf.doFtp(path+filename,filename);//doFtp(String locfilepath, String ftpfilename)
		    					    //*************************************
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
		    			        boolean hasCGO = false;
		    			        while(itr.hasNext())
		    			    	{
		    			    	    String key = String.valueOf(itr.next());
		    			    	    APISObj valueobj = (APISObj)unmatchHT.get(key);	    			    	    
		    			    	    if("A".equals(valueobj.getRemark()))
		    			    	    {//unmatch sent log crew not in aircrews 
		    			    	     //sentlog 有 aircrews 無
		    			    	        hasASB.append(valueobj.getOccu()+" "+valueobj.getEmpno()+" "+valueobj.getCarrier()+valueobj.getFltno()+" "+valueobj.getDpt()+" "+valueobj.getArv()+" TPEMMDD "+valueobj.getStdtpe().substring(11).replaceAll(":","")+" LCLMMDD "+valueobj.getStr_port_local().substring(11).replaceAll(":","")+"\r\n");
		    			    	        if("CGO".equals(valueobj.getOccu()))
		    			    	        {
		    			    	            hasCGO =true;
		    			    	        }
	//System.out.println("**** SENT LOG CREW NOT IN AIRCREWS ****"+valueobj.getOccu()+" "+valueobj.getEmpno()+" "+valueobj.getCarrier()+valueobj.getFltno()+" "+valueobj.getDpt()+" "+valueobj.getArv()+" TPEMMDD "+valueobj.getStdtpe().substring(11).replaceAll(":","")+" LCLMMDD "+valueobj.getStr_port_local().substring(11).replaceAll(":",""));	    			    	        
		    			    	    }
		    			    	    else if("N".equals(valueobj.getRemark()))
		    			    	    {//unmatch Aircrews crew not in sent log 
		    			    	     //sentlog 無 aircrews 有		    			
		    			    	        hasNSB.append(valueobj.getOccu()+" "+valueobj.getEmpno()+" "+valueobj.getCarrier()+valueobj.getFltno()+" "+valueobj.getDpt()+" "+valueobj.getArv()+" TPEMMDD "+valueobj.getStdtpe().substring(11).replaceAll(":","")+" LCLMMDD "+valueobj.getStr_port_local().substring(11).replaceAll(":","")+"\r\n");
		    			    	        if("CGO".equals(valueobj.getOccu()))
		    			    	        {
		    			    	            hasCGO =true;
		    			    	        }
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
		    			    	    sb.append("QD TPEOSCI TPEEDCI");
		    			    	    if(hasCGO==true)
		    			    	    {
		    			    	        sb.append(" TPEFJCI");
		    			    	    }
		    			    	    sb.append("\r\n");	    			    	    
		    			    	    sb.append(".TPECSCI"+"\r\n");
		    			    	    sb.append("-----NOTICE F/APIS CREW CHECK-----"+"\r\n");
		    			    	    sb.append("*"+"\r\n");
		    			    	    sb.append("****FATAL APIS ERROR FOUND****"+"\r\n");
		    			    	    sb.append("****APIS DATA NOT MATCH****"+"\r\n");
		    			    	    sb.append("PLS CHK AIRCREWS CREW LIST AND APIS DATA"+"\r\n");
		    			    	    if(hasNSB.length()>0)
		    			    	    {
		    			    	        sb.append("PLS RESEND APIS DATA"+"\r\n");
		    			    	        sb.append("****AIRCREWS CREW OR CGO PAX NOT IN SENT LOG****"+"\r\n");
		    			    	        sb.append(hasNSB.toString());
		    			    	        sb.append("\r\n");
		    			    	    }
		    			    	    
		    			    	    if(hasASB.length()>0)
		    			    	    {
	//	    			    	        sb.append("PLS RE-TRANSFER APIS DATA AND RESEND APIS DATA"+"\r\n");
		    			    	        sb.append("PLS RESEND APIS DATA"+"\r\n");
		    			    	        sb.append("****SEND LOG CREW NOT IN AIRCREWS CREW OR CGO PAX****"+"\r\n");
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
		    			    	        if(hasCGO==true)
			    			    	    {
		    			    	            el.sendEmail("tpeosci@cal.aero","tpeosci@email.china-airlines.com,tpeedbox@china-airlines.com,mattewliu@china-airlines.com","pierce@china-airlines.com,tpecsci@cal.aero","FATAL APIS ERROR FOUND",sb);
			    			    	    }
		    			    	        else
		    			    	        {
			    			    	        el.sendEmail("tpeosci@cal.aero","tpeosci@email.china-airlines.com,tpeedbox@china-airlines.com","pierce@china-airlines.com,tpecsci@cal.aero","FATAL APIS ERROR FOUND",sb);	
		//	    			    	        el.sendEmail("tpeosci@cal.aero","betty.yu@china-airlines.com","640790@cal.aero","FATAL APIS ERROR FOUND",sb);
		    			    	        }
		    			    	        //*************************************
			    			    	    //Telex path
			    			    	    String filename = obj.getStdtpe().replaceAll("/|:| ","")+"_"+obj.getFltno()+"_"+obj.getDpt()+"_"+obj.getArv()+"ERROR.TXT";	    			    	    
			    			    	    FileWriter fw =  new FileWriter(path+filename,false);		  
			    			    	    fw.write(sb.toString());
			    			    	    fw.flush();
			    					    fw.close();
			    					    ftp.putFile pf = new ftp.putFile();
			    					    pf.doFtp(path+filename,filename);//doFtp(String locfilepath, String ftpfilename)
			    					    //*************************************
		    			    	    }
    			    	    	} 			        
	                    	}	       
		   	         	}//if(ifneedapis==true)
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
	        fwlog.write("****** RUN APIS end Error String   : "+ c.getStr()+" ****** \r\n");
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

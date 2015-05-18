package al;

import ci.db.ConnDB;
import java.sql.*;
import java.sql.Date;
import java.util.*;
import java.text.*;

//***********刪除特休假單*************
public class deleteAl
{
        public String deleteoff(String[] offsdate, String[] offedate, String[] offno, String empn)
        {
        	String thedate = null;
        	String mymm = null;
        	String aa = null;
        	
         	int yy = 0;
        	int mm = 0;
        	int dd = 0;
        	Connection con = null;
        	Statement stmt = null;
        	Driver dbDriver = null;
                try
                {
                        ConnDB cdb = new ConnDB();	
                	cdb.setORP3EGUserCP();
                        dbDriver = (Driver) Class.forName(cdb.getDriver()).newInstance();
			con = dbDriver.connect(cdb.getConnURL(), null);
                        stmt = con.createStatement();
                        ResultSet myResultSet = null;
                        
                        String ddate = null;
                                               
                        //取得今天日期
                        aa = "select to_char(sysdate,'yyyy-mm-dd') td from dual";
                        myResultSet = stmt.executeQuery(aa);
                        if (myResultSet.next())
                        {
                                thedate = myResultSet.getString("td");
                        }
                        for(int i = 0; i<offsdate.length; i++)
                        {
                        	yy = Integer.parseInt(offsdate[i].substring(0,4));
                        	mm = Integer.parseInt(offsdate[i].substring(5,7));
                        	dd = Integer.parseInt(offsdate[i].substring(8,10));
                        	//1~10日;2個月前銷假
                        	if (dd <= 10){
                        		mm = mm - 2;
                        	}
                        	else{  //11~月底;1個月前銷假
                        		mm = mm - 1;
                        	}
                        	if (mm < 1){
                        		mm = 12 + mm;
                        		yy = yy - 1;
                        	}
                        	if (mm < 10){
                        		mymm = "0" + String.valueOf(mm);
                        	}
                        	else{
                        		mymm = String.valueOf(mm);
                        	}
                        	
                        	ddate = String.valueOf(yy) + "-" + mymm + "-10";
                        	Date themydate = Date.valueOf(thedate);//今天日期
                        	Date theddate = Date.valueOf(ddate);//可銷假日期
                        
                        	int cd = themydate.compareTo(theddate);//請假開始日是否>進公司日
				if (cd > 0){
					 return "您必須於 " + theddate + " 前取消此特休假單 !";
				}
				else{
					//判斷銷假期間請假限額是否已額滿,如已期間任一日已額滿則不準進行銷假****************
					int qlcount = 0;
					int jobno = 0;
		                        int offdays = 0;
		                        int tyo_crew = 0;
		                        int kor_crew = 0;
		                        int fa = 0;
		                        int fs = 0;
		                        int zc = 0;
		                        int pur = 0;
		                        int kcrew = 0;
		                        int kpur = 0;
		                        
		                        String theday = "";
		                        String station = null;
		                        String specialcode = null;
		                        String sex = null;
		                        String str1 = "";
		                        String str2 = "";
		                        //get crew STATION, JOBNO, SPECIALCODE from orp3 egtcbas table
		                        aa = "select station, jobno, nvl(specialcode,'N') specialcode, sex from egtcbas where trim(empn) = trim('"+empn+"')";
		                        myResultSet = stmt.executeQuery(aa);
	                                if (myResultSet.next())
	                                {
	                                	station = myResultSet.getString("station");
	                                	jobno = myResultSet.getInt("jobno");
	                                        specialcode = myResultSet.getString("specialcode");
	                                        sex = myResultSet.getString("sex");
	                                }
	                                //modify by cs55 2005/03/07 
	                                //開放日(J)、韓(K)、義(I)語組員於休假配額為0時，可自行更改或取消已申請之特休假。
	                                if(!specialcode.equals("J") && !specialcode.equals("I") && !specialcode.equals("K")){
		                                 //取得各職務請假限額
		                                aa = "select * from egtalco";
		                                myResultSet = stmt.executeQuery(aa);
		                                if (myResultSet.next())
		                                {
		                                	tyo_crew = myResultSet.getInt("tyo_crew");
		                                	kor_crew = myResultSet.getInt("kor_crew");
		                                	fa = myResultSet.getInt("fa");
		                                	fs = myResultSet.getInt("fs");
		                                	pur = myResultSet.getInt("pur");
		                                	kcrew = myResultSet.getInt("kcrew");
		                                	kpur = myResultSet.getInt("kpur");
		                                }
			                        //計算請假天數
			                        aa = "select (to_date('"+offedate[i]+"', 'yyyy-mm-dd') - to_date('"+offsdate[i]+"', 'yyyy-mm-dd')) offdays from dual";
			                        myResultSet = stmt.executeQuery(aa);
			                        if (myResultSet.next())
			                        {
							offdays = myResultSet.getInt("offdays");
			                        }
			                        
			                        if (station.equals("TPE"))//TPE station
			                        {
			                                if (jobno > 80)//FA 男空服員(男助理座艙長), FS 女空服員(女助理座艙長)
			                                {
			                                        for (int j = 0; j <= offdays; j++)
			                                        {
			                                                aa = "select to_char(to_date('"+offsdate[i]+"', 'yyyy-mm-dd') + "+j+", 'yyyy-mm-dd') theday from dual";
			                                                myResultSet = stmt.executeQuery(aa);
			                                                if (myResultSet.next())
			                                                {
			                                              		theday = myResultSet.getString("theday");
			                                                }
			                                                //判斷是否為日語組組員
			                                                if (specialcode.equals("J"))//日語組組員
			                                                {
			                                                	//*****add by cs55 2005/07/19 取得當月Quota*****
			                                                	myResultSet = stmt.executeQuery("select quota from egtquota where yy||'-'||mm=substr('"+theday+"',1,7) and qitem='TPE TYO'");
			                                                	while(myResultSet.next()){
			                                                		tyo_crew = myResultSet.getInt("quota");
			                                                	}
			                                                	//**********************************************
			                                                        aa = "SELECT count(*) qlcount " +
			                                			     "FROM EGTCBAS, EGTOFFS  " +
			                                			     "WHERE ( EGTCBAS.empn = EGTOFFS.empn ) and " +   
			                                			     "( ( NVL(EGTCBAS.specialcode, 'N') = 'J' ) AND " + 
			                                			     "( EGTCBAS.station = 'TPE' ) AND " + 
			                                			     "( to_char(EGTOFFS.offsdate,'yyyy-mm-dd') <= '"+theday+"' ) AND " +  
			                                			     "( to_char(EGTOFFS.offedate,'yyyy-mm-dd') >= '"+theday+"' ) AND " +
			                                			     "( EGTOFFS.offtype = '0' ) and (EGTOFFS.remark <> '*' or EGTOFFS.remark is null))";
			                                                        myResultSet = stmt.executeQuery(aa);
			                                                        if (myResultSet != null)
			                                                        {
			                                                                while (myResultSet.next())
			                                                        	{ 
			                                                        	        qlcount = myResultSet.getInt("qlcount");
			                                                        	        /*if (qlcount >= tyo_crew)
			                                                        	        {
			                                                        	                return "TPE-TYO-Crew "+theday+" had over "+tyo_crew+" person, You can't cancel it.";
			                                                        	        }*/
			                                                               	}
			                                                        }
			                                                }
			                                                //判斷是否為韓語組組員
			                                                else if (specialcode.equals("K"))//韓語組組員
			                                                {
			                                                	//*****add by cs55 2005/07/19 取得當月Quota*****
			                                                	myResultSet = stmt.executeQuery("select quota from egtquota where yy||'-'||mm=substr('"+theday+"',1,7) and qitem='TPE KOR'");
			                                                	while(myResultSet.next()){
			                                                		kor_crew = myResultSet.getInt("quota");
			                                                	}
			                                                	//**********************************************
			                                                        aa = "SELECT count(*) qlcount " +
			                                			     "FROM EGTCBAS, EGTOFFS  " +
			                                			     "WHERE ( EGTCBAS.empn = EGTOFFS.empn ) and " +   
			                                			     "( ( NVL(EGTCBAS.specialcode, 'N') = 'K' ) AND " + 
			                                			     "( EGTCBAS.station = 'TPE' ) AND " + 
			                                			     "( to_char(EGTOFFS.offsdate,'yyyy-mm-dd') <= '"+theday+"' ) AND " +  
			                                			     "( to_char(EGTOFFS.offedate,'yyyy-mm-dd') >= '"+theday+"' ) AND " +
			                                			     "( EGTOFFS.offtype = '0' ) and (EGTOFFS.remark <> '*' or EGTOFFS.remark is null))";
			                                                        myResultSet = stmt.executeQuery(aa);
			                                                        if (myResultSet != null)
			                                                        {
			                                                                while (myResultSet.next())
			                                                        	{ 
			                                                        	        qlcount = myResultSet.getInt("qlcount");
			                                                        	        /*if (qlcount >= kor_crew)
			                                                        	        {
			                                                        	                return "TPE-KOR-Crew "+theday+" had over "+kor_crew+" person";
			                                                        	        }*/
			                                                               	}
			                                                        }
			                                                }
			                                                else//非日語組組員, 韓語組組員
			                                                {
			                                                        if (jobno==110 || jobno==90 || (jobno==95 && "M".equals(sex))) //FA
			                                                        {
			                                                                str1 = "110";
			                                                                str2 = "90";
			                                                                //*****add by cs55 2005/07/19 取得當月Quota*****
				                                                	myResultSet = stmt.executeQuery("select quota from egtquota where yy||'-'||mm=substr('"+theday+"',1,7) and qitem='TPE FA'");
				                                                	while(myResultSet.next()){
				                                                		fa = myResultSet.getInt("quota");
				                                                	}
				                                                	//**********************************************
				                                                	aa = "SELECT count(*) qlcount " +
					                                			     "FROM EGTCBAS, EGTOFFS  " +
					                                			     "WHERE ( EGTCBAS.empn = EGTOFFS.empn ) and " +   
					                                			     "( ( EGTCBAS.jobno = "+str1+" or EGTCBAS.jobno = "+str2+" or (EGTCBAS.jobno = '95' and EGTCBAS.sex = 'M')) AND " + 
					                                			     "( EGTCBAS.station = 'TPE' ) AND ( NVL(EGTCBAS.specialcode, 'N') not in ('J','K') ) AND " + 
					                                			     "( to_char(EGTOFFS.offsdate,'yyyy-mm-dd') <= '"+theday+"' ) AND " +  
					                                			     "( to_char(EGTOFFS.offedate,'yyyy-mm-dd') >= '"+theday+"' ) AND " +
					                                			     "( EGTOFFS.offtype = '0' )  and (EGTOFFS.remark <> '*' or EGTOFFS.remark is null))";
			                                                        }
			                                                        else  //FS 100,120
			                                                        {
			                                                                str1 = "100";
			                                                                str2 = "120";
			                                                                //*****add by cs55 2005/07/19 取得當月Quota*****
			                                                                
						                                                	myResultSet = stmt.executeQuery("select quota from egtquota where yy||'-'||mm=substr('"+theday+"',1,7) and qitem='TPE FS'");			                                                                
						                                                	while(myResultSet.next()){
						                                                		fs = myResultSet.getInt("quota");
						                                                	}
				                                                	//**********************************************
				                                                	aa = "SELECT count(*) qlcount " +
					                                			     "FROM EGTCBAS, EGTOFFS  " +
					                                			     "WHERE ( EGTCBAS.empn = EGTOFFS.empn ) and " +					                                			    
					                                			     "( ( EGTCBAS.jobno = "+str1+" or EGTCBAS.jobno = "+str2+" or (EGTCBAS.jobno = '95' and EGTCBAS.sex = 'F') ) AND " +					                                			    
					                                			     "( EGTCBAS.station = 'TPE' ) AND ( NVL(EGTCBAS.specialcode, 'N') not in ('J','K') ) AND " + 
					                                			     "( to_char(EGTOFFS.offsdate,'yyyy-mm-dd') <= '"+theday+"' ) AND " +  
					                                			     "( to_char(EGTOFFS.offedate,'yyyy-mm-dd') >= '"+theday+"' ) AND " +
					                                			     "( EGTOFFS.offtype = '0' )  and (EGTOFFS.remark <> '*' or EGTOFFS.remark is null))";
			                                                        }
			                                                        
			                                                        
			                                                        myResultSet = stmt.executeQuery(aa);
			                                                        if (myResultSet != null)
			                                                        {
			                                                                while (myResultSet.next())
			                                                        	{ 
			                                                        	        qlcount = myResultSet.getInt("qlcount");
			                                                        	        if ((jobno==110 || jobno==90 || (jobno==95 && "M".equals(sex))) && qlcount >= fa)
			                                                        	        {
			                                                        	                return "TPE-FA "+theday+" had over "+fa+" , You can't cancel it.";
			                                                        	        }
			                                                        	        else if ((jobno==120 || jobno==100 || (jobno==95 && "F".equals(sex))) && qlcount >= fs)
			                                                        	        {
			                                                        	                return "TPE-FS "+theday+" had over "+fs+" , You can't cancel it.";
			                                                        	        }			                                                        	        
			                                                        	}
			                                                        }
			                                                }
			                                        }
			                                }
			                                else//PUR 座艙長, 空服教官, 空服長
			                                {
			                                        for (int j = 0; j <= offdays; j++)
			                                        {
			                                                aa = "select to_char(to_date('"+offsdate[i]+"', 'yyyy-mm-dd') + "+j+", 'yyyy-mm-dd') theday from dual";
			                                                myResultSet = stmt.executeQuery(aa);
			                                                if (myResultSet != null)
			                                                {
			                                                        while (myResultSet.next())
			                                                	{ 
			                                                	        theday = myResultSet.getString("theday");
			                                                	}
			                                                }
			                                                //*****add by cs55 2005/07/19 取得當月Quota*****
			                                        	myResultSet = stmt.executeQuery("select quota from egtquota where yy||'-'||mm=substr('"+theday+"',1,7) and qitem='TPE PUR'");
			                                        	while(myResultSet.next()){
			                                        		pur = myResultSet.getInt("quota");
			                                        	}
			                                        	//**********************************************
			                                                aa = "SELECT count(*) qlcount " +
			                        			     "FROM EGTCBAS, EGTOFFS  " +
			                        			     "WHERE ( EGTCBAS.empn = EGTOFFS.empn ) and " +   
			                        			     "( ( to_number(EGTCBAS.jobno) <= 80 ) AND " + 
			                        			     "( EGTCBAS.station = 'TPE' ) AND " + 
			                        			     "( to_char(EGTOFFS.offsdate,'yyyy-mm-dd') <= '"+theday+"' ) AND " +  
			                        			     "( to_char(EGTOFFS.offedate,'yyyy-mm-dd') >= '"+theday+"' ) AND " +
			                        			     "( EGTOFFS.offtype = '0' )  and (EGTOFFS.remark <> '*' or EGTOFFS.remark is null))";
			                                                myResultSet = stmt.executeQuery(aa);
			                                                if (myResultSet != null)
			                                                {
			                                                        while (myResultSet.next())
			                                                	{ 
			                                                	        qlcount = myResultSet.getInt("qlcount");
			                                                	        if (qlcount >= pur)
			                                                	        {
			                                                	                return "TPE-PUR "+theday+" had over "+pur+" , You can't cancel it.";
			                                                	        }
			                                                	        
			                                                	}
			                                                }
			                                        }
			                                }
			                        }
			                        else //KHH station
			                        {
			                                if (jobno >= 95)//FA 男空服員, FS 女空服員
			                                {
			                                        for (int j = 0; j <= offdays; j++)
			                                        {
			                                                aa = "select to_char(to_date('"+offsdate[i]+"', 'yyyy-mm-dd') + "+j+", 'yyyy-mm-dd') theday from dual";
			                                                myResultSet = stmt.executeQuery(aa);
			                                                if (myResultSet != null)
			                                                {
			                                                        while (myResultSet.next())
			                                                	{ 
			                                                	        theday = myResultSet.getString("theday");
			                                                	}
			                                                }
			                                                //*****add by cs55 2005/07/19 取得當月Quota*****
			                                        	myResultSet = stmt.executeQuery("select quota from egtquota where yy||'-'||mm=substr('"+theday+"',1,7) and qitem='KHH CREW'");
			                                        	while(myResultSet.next()){
			                                        		kcrew = myResultSet.getInt("quota");
			                                        	}
			                                        	//**********************************************
			                                                aa = "SELECT count(*) qlcount " +
			                        			     "FROM EGTCBAS, EGTOFFS  " +
			                        			     "WHERE ( EGTCBAS.empn = EGTOFFS.empn ) and " +   
			                        			     "( ( (EGTCBAS.jobno = '110' ) or (EGTCBAS.jobno = '120' ) or (EGTCBAS.jobno = '95' )) AND " + 
			                        			     "( EGTCBAS.station = 'KHH' ) AND " + 
			                        			     "( to_char(EGTOFFS.offsdate,'yyyy-mm-dd') <= '"+theday+"' ) AND " +  
			                        			     "( to_char(EGTOFFS.offedate,'yyyy-mm-dd') >= '"+theday+"' ) AND " +
			                        			     "( EGTOFFS.offtype = '0' )  and (EGTOFFS.remark <> '*' or EGTOFFS.remark is null))";
			                                                myResultSet = stmt.executeQuery(aa);
			                                                if (myResultSet != null)
			                                                {
			                                                        while (myResultSet.next())
			                                                	{ 
			                                                	        qlcount = myResultSet.getInt("qlcount");
			                                                	        if (qlcount >= kcrew)
			                                                	        {
			                                                	                return "KHH-Crew "+theday+" had over "+kcrew+" , You can't cancel it.";
			                                                	        }
			                                                	        
			                                                	}
			                                                }
			                                        }
			                                }
			                                else//PUR 座艙長, 空服教官, 空服長
			                                {
			                                        for (int j = 0; j <= offdays; j++)
			                                        {
			                                                aa = "select to_char(to_date('"+offsdate[i]+"', 'yyyy-mm-dd') + "+j+", 'yyyy-mm-dd') theday from dual";
			                                                myResultSet = stmt.executeQuery(aa);
			                                                if (myResultSet != null)
			                                                {
			                                                        while (myResultSet.next())
			                                                	{ 
			                                                	        theday = myResultSet.getString("theday");
			                                                	}
			                                                }
			                                                //*****add by cs55 2005/07/19 取得當月Quota*****
			                                        	myResultSet = stmt.executeQuery("select quota from egtquota where yy||'-'||mm=substr('"+theday+"',1,7) and qitem='KHH PUR'");
			                                        	while(myResultSet.next()){
			                                        		kpur = myResultSet.getInt("quota");
			                                        	}
			                                        	//**********************************************
			                                                aa = "SELECT count(*) qlcount " +
			                        			     "FROM EGTCBAS, EGTOFFS  " +
			                        			     "WHERE ( EGTCBAS.empn = EGTOFFS.empn ) and " +   
			                        			     "( ( to_number(EGTCBAS.jobno) <= 80 ) AND " + 
			                        			     "( EGTCBAS.station = 'KHH' ) AND " + 
			                        			     "( to_char(EGTOFFS.offsdate,'yyyy-mm-dd') <= '"+theday+"' ) AND " +  
			                        			     "( to_char(EGTOFFS.offedate,'yyyy-mm-dd') >= '"+theday+"' ) AND " +
			                        			     "( EGTOFFS.offtype = '0' )  and (EGTOFFS.remark <> '*' or EGTOFFS.remark is null))";
			                                                myResultSet = stmt.executeQuery(aa);
			                                                if (myResultSet != null)
			                                                {
			                                                        while (myResultSet.next())
			                                                	{ 
			                                                	        qlcount = myResultSet.getInt("qlcount");
			                                                	        if (qlcount >= kpur)
			                                                	        {
			                                                	                return "KHH-PUR "+theday+" had over "+kpur+" person, You can't cancel it.";
			                                                	        }
			                                                	        
			                                                	}
			                                                }
			                                        }
			                                }
			                        }
			                 }
					//update remark into al offsheet****************
					int rowsAffected = stmt.executeUpdate("update egtoffs set remark = '*', chguser = '" + empn + "', chgdate = sysdate where offno = '"+offno[i]+"'");
					
					if (rowsAffected != 1)
					{
						return "Delete Offsheet Fail !!";
					}
				}
                        }
                                                
                        return "0";
                }
                catch (Exception e)
                {
                        System.out.println(e.toString());
                        return e.toString();
                }  
                finally{
                	try{if(stmt != null) stmt.close();}catch (Exception e){}
                	try{if(con!=null) con.close();}catch (Exception e){}
                }
        }
}
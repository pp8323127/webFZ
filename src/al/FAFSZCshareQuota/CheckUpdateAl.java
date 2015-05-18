package al;

import ci.db.ConnDB;
import java.sql.*;
import java.sql.Date;
import java.util.*;
import java.text.*;

//***********�ˬd����O�_�i�ؤJ*************
public class CheckUpdateAl
{
        private String cutdate = null;
        private Connection con = null;
        
        public static void main(String[] args)
        {
            CheckUpdateAl cua = new CheckUpdateAl();
            cua.handleOff("2007-07-01", "2007-07-01", "629020", "");
            try{
            cua.checktimes("629020", "2007", "2007-07-01", "2007-07-01", "2007", "2007");
            } 
            catch(Exception e)
            {
            System.out.println(e.toString());    
            }
            System.out.println("Done");
        }
        
        
        
        
        //***************�D�B�z�{�� modify by cs55 2005/09/29***************
        public String handleOff(String offsdate, String offedate, String empno, String sern){
        	Driver dbDriver = null;
        	
        	String rs = null;
        	
        	try{
	        	ConnDB cdb = new ConnDB();	
	        	
	        	cdb.setORP3EGUserCP();
                dbDriver = (Driver) Class.forName(cdb.getDriver()).newInstance();
                con = dbDriver.connect(cdb.getConnURL(), null);
                
//                cdb.setORP3EGUser();
//    			java.lang.Class.forName(cdb.getDriver());
//    			con = DriverManager.getConnection(cdb.getConnURL(), cdb.getConnID(),cdb.getConnPW()); 
	                
	        	//AutoCommit�]��false
	        	con.setAutoCommit(false);
	        	//step 1.
	        	rs = getOffdays(offsdate, offedate);
	        	if("0".equals(rs)){
	        		//step 2.
	        		rs = checkdate(offsdate, offedate);
	        		if("0".equals(rs)){
	        			//step 3.
	        			rs = checktimes(empno, offsdate.substring(0, 7), offsdate, offedate, offsdate.substring(0, 4), offedate.substring(0, 4));
	        			if("0".equals(rs)){
	        				con.commit();
	        				//new Loger().setCommonInfoLog("handleOff/checktimes", empno, sern +" offsheet : " + offsdate + " to " + offedate + " Success");
	        				return rs;
	        			}
	        			else{
	        				con.rollback();
	        				//new Loger().setCommonInfoLog("handleOff/checktimes", empno, sern +" offsheet : " + offsdate + " to " + offedate + rs);
	        				return rs;
	        			}
	        		}
	        		else{
	        			con.rollback();
	        			//new Loger().setCommonInfoLog("handleOff/checkdate", empno, sern +" offsheet : " + offsdate + " to " + offedate + rs);
	        			return rs;
	        		}
	        	}
	        	else{
	        		con.rollback();
	        		//new Loger().setCommonInfoLog("handleOff/getOffdays", empno, sern +" offsheet : " + offsdate + " to " + offedate + rs);
	        		return rs;
	        	}
	        }
	        catch (Exception e)
                {
                	try{con.rollback();}catch(Exception ce){}
                	//new Loger().setErrorLog("CheckUpdateAl.java-->handleOff", empno, e);
                        return "Error : " + e.toString();
                }  
                finally{
                	//�A��s�uAutoCommit�]�^true
        		try{con.setAutoCommit(true);}catch(Exception ignored){}
                	try{if(con!=null) con.close();}catch (Exception e){}
                }
        }
        //*******************************************************************
        //�O�_������а����
        public String checkdate(String offsdate, String offedate)throws Exception{
        	Statement stmt = con.createStatement();
        	ResultSet myResultSet = null;
        	
        	String sdate = null;
        	String edate = null;
        	
		myResultSet = stmt.executeQuery("select to_char(sdate, 'yyyy-mm-dd') mysdate, to_char(edate, 'yyyy-mm-dd') myedate from egtalco");
		if (myResultSet != null)
		{
			while (myResultSet.next())
			{
				sdate = myResultSet.getString("mysdate");
				edate = myResultSet.getString("myedate");
			}
		}
		
                try{if(myResultSet!=null) myResultSet.close();}catch (Exception e){throw e;}
        	try{if(stmt!=null) stmt.close();}catch (Exception e){throw e;}
        	
                Date mysdate = Date.valueOf(sdate);
                Date myedate = Date.valueOf(edate);
                Date myoffsdate = Date.valueOf(offsdate);
                Date myoffedate = Date.valueOf(offedate);
                int x = mysdate.compareTo(myoffsdate);
                int y = myedate.compareTo(myoffsdate);
                int z = mysdate.compareTo(myoffedate);
                int e = myedate.compareTo(myoffedate);
                if ((x <= 0 && y >= 0) || (z <= 0 && e >= 0)){
                        return "Can't take day-off during "+sdate+" to "+edate;
                }
                else{
                        return "0";
                }
        }
        //1.EX: 7/01~10(offday)-->�i��8,9,10�밲��
        //      7/11~25-->�i��9/11~10������
        //      7/26~��-->�i��9,10,11�밲��
        //2.�P�_��������O�_�W�L3(�i�վ�)�i
        //3.�P�_�O�_���ƻ��e����
        //4.�P�_�а����B�O�_�B��
        public String checktimes(String empn, String mymonth, String mysdate, String myedate, String offyear, String gradeyear)throws Exception{
        	String rs = null;
        	Statement stmt = con.createStatement();
        	ResultSet myResultSet = null;
        	
        	String indate = null;
        	String sern = null;
        	String station = null;
        	String sex = null;
        	int jobno = 0;
        	
        	int lastdays = 0;
        	int thisdays = 0;
        	int nextdays = 0;
        	
        	int papers = 0;
        	int offday = 0;
        	int pur = 0;
        	int fa = 0;
        	int fs = 0;
        	int zc = 0;
        	int kpur = 0;
        	int kcrew = 0;
        	int tyo_crew = 0;
        	int openday = 0;
        	String opentime = null;
        	int kor_crew = 0;
        	
                String aa = "";
                int offdays = 0;
                cutdate = myedate;
                
                aa = "select sern, jobno, station, to_char(indate, 'yyyy-mm-dd') indate, sex from egtcbas " +
		"where (trim(empn) = '"+empn+"' or sern = " + empn + ")";
		myResultSet = stmt.executeQuery(aa);
		if (myResultSet != null)
		{
			while (myResultSet.next())
			{
				indate = myResultSet.getString("indate");
				sern = myResultSet.getString("sern");
				station = myResultSet.getString("station");
				jobno = myResultSet.getInt("jobno");
				sex = myResultSet.getString("sex");
			}
			myResultSet.close();
		}
		
		aa = "select * from egtcoff where (trim(empn) = '"+empn+"' or sern = " + empn + ")";
		myResultSet = stmt.executeQuery(aa);
		if (myResultSet != null)
		{
			while (myResultSet.next())
			{
				lastdays = myResultSet.getInt("lastdays");
				thisdays = myResultSet.getInt("thisdays");
				nextdays = myResultSet.getInt("nextdays");
			}
			myResultSet.close();
		}
		
		aa = "select papers, offday, openday, opentime from egtalco";
		myResultSet = stmt.executeQuery(aa);
		if (myResultSet != null)
		{
			while (myResultSet.next())
			{
				papers = myResultSet.getInt("papers");
				offday = myResultSet.getInt("offday");
				openday = myResultSet.getInt("openday");
				opentime = myResultSet.getString("opentime");
			}
			myResultSet.close();
		}
        	
                //�p��а��Ѽ�
                aa = "select (to_date('"+myedate+"', 'yyyy-mm-dd') - to_date('"+mysdate+"', 'yyyy-mm-dd')) offdays from dual";
                myResultSet = stmt.executeQuery(aa);
                if (myResultSet != null)
                {
                        while (myResultSet.next())
                	{ 
                	        offdays = myResultSet.getInt("offdays");
                	}
                	myResultSet.close();
                }
                //�`�а��ѼƤ��i�W�L30��
                if(offdays > 30) return "Can't take day-off over 30 days";
                //1.EX: 7/01~10(offday)-->�i��8,9,10�밲��
                //      7/11~25-->�i��9/11~10������
                //      7/26~��-->�i��9,10,11�밲��
                aa = "select to_char(sysdate, 'yyyy-mm-dd') inputdate, to_char(sysdate, 'yyyy-mm') mymonth, "+
                "to_char(sysdate, 'dd') myday, " +  
                "to_char(add_months(sysdate, 2), 'yyyy-mm') date1, " + 
                "to_char(last_day(add_months(sysdate, 3)), 'yyyy-mm-dd') date2, " +
                "to_char(last_day(add_months(sysdate, 4)), 'yyyy-mm-dd') date3, " +
                "to_char(trunc(add_months(sysdate, 1),'MONTH'), 'yyyy-mm-dd') date4" +
                " from dual";
                myResultSet = stmt.executeQuery(aa);
                if (myResultSet != null)
                {
                        while (myResultSet.next())
                	{ 
                	        int myday = myResultSet.getInt("myday");//���Ѥ��
                	        Date inputdate = Date.valueOf(myResultSet.getString("inputdate"));//���Ѥ��yyyy-mm-dd
                	        String mysmonth = myResultSet.getString("mymonth");//���Ѥ��
                	        String date1 = myResultSet.getString("date1");//2003-09
                	        String date2 = myResultSet.getString("date2");//2003-10-31 3�Ӥ�
                	        String date3 = myResultSet.getString("date3");//2003-11-30 4�Ӥ�
                	        Date date4 = Date.valueOf(myResultSet.getString("date4"));//2003-08-01 1�Ӥ�
                	        String offsmonth = mysdate.substring(0, 7);//yyyy/mm
                	        
                	        Date offsdate = Date.valueOf(mysdate);//�а��}�l��
                	        Date offedate = Date.valueOf(myedate);//�а�������
                	        Date offdate1 = Date.valueOf(date1 + "-" + String.valueOf(offday));//2003-09-10
                	        Date offdate2 = Date.valueOf(date2);//2003-10-31
                	        Date offdate3 = Date.valueOf(date3);//2003-11-30
                	        Date offdate4 = Date.valueOf(date1 + "-01");//2003-09-01
                	        //���o���Ѥ�� 2003/10/03 add
                	        Calendar cal = Calendar.getInstance() ;
                                java.util.Date thetime = cal.getTime() ;
                                Locale lcUK = Locale.UK ;
                                DateFormat dfT = DateFormat.getTimeInstance(DateFormat.SHORT,lcUK) ; //use 24Hrs UK timestyle
                                String mynow = dfT.format(thetime);//17:35
                                //�p�G������鬰openday(25��), �hcheck opentime�O�_�w�i������
                                int a9 = mynow.compareTo(opentime);//2003/10/03 add
                                int a10 = offsdate.compareTo(inputdate);
                                                        	        
                	        if (mysmonth.equals(offsmonth)){return "Can't take day-off druing " + mysmonth;}
                	        //���i�����ѥH�e������
                	        if (a10 < 0){return "Can't take day-off before today";}
                	        
                	        else if (myday <= offday)//�i��8,9,10�밲��  openday(25��), myday(today), offday(take off day range)
                	        {
                	               int a1 = offsdate.compareTo(offdate2);//offdate2 2003-10-31
                	               int a11 = offedate.compareTo(offdate2);
                	               if (a1 > 0 || a11 > 0){return "Can't take day-off over " + date2;}
                	               int a12 = offsdate.compareTo(date4);//offsdate must > 2003-08-01
                	               if (a12 < 0){return "Can't take day-off before " + date4;}
                	        }
                	        else if (myday > offday && myday < openday)//�i��9/11~10������
                	        {
                	                int a2 = offsdate.compareTo(offdate1);
                	                int a3 = offsdate.compareTo(offdate2);
                	                int a13 = offedate.compareTo(offdate1);
                	                int a14 = offedate.compareTo(offdate2);
                	                if (a2 <= 0 || a3 > 0 || a13 <= 0 || a14 > 0){return "You just can take day-off between "+date1 + "-" + String.valueOf(offday + 1) + " and " + date2;}
                                }
                	        else//�i��9,10,11�밲��
                	        {
                	                if (myday == openday && a9 <= 0){return "You just can take day-off after " + opentime;}//2003/10/03 add
                	                int a4 = offsdate.compareTo(offdate4);//2003-09-01 offsdate
                	                int a5 = offsdate.compareTo(offdate3);//2003-11-30
                	                int a15 = offedate.compareTo(offdate4);//2003-09-01 offedate
                	                int a16 = offedate.compareTo(offdate3);//2003-11-30
                	                if (a4 < 0 || a5 > 0 || a15 < 0 || a16 > 0){return "You just can take day-off between "+date1 + "-01"+" and "+date3;}
                	        }
                	}
                	myResultSet.close();
                }
               
                
                //2.�P�_��������O�_�W�L3(�i�վ�)�i
	        /*aa = "select count(*) alcount from egtoffs where trim(empn) = '"+empn+"' and offtype = '0' and to_char(offsdate, 'yyyy-mm') = '"+mymonth+"' and (remark <> '*' or remark is null)";
	        myResultSet = stmt.executeQuery(aa);
                if (myResultSet != null)
                {
                        while (myResultSet.next())
                	{ 
                	        int alcount = myResultSet.getInt("alcount");
                	        if (alcount >= papers)
                	        {
                	                return "You can't take day-off(AL) over "+papers+" times in "+mymonth;
                	        }
                	}
                	myResultSet.close();
                }*/
                
                //3.�P�_�O�_���ƻ��e����
                aa = "select count(*) mycount from egtoffs where trim(empn) = '"+empn+
                "' and ((to_char(offsdate,'yyyy-mm-dd')<='"+mysdate+"' and "+
                "to_char(offedate,'yyyy-mm-dd')>='"+mysdate+"') or (to_char(offsdate,'yyyy-mm-dd')<='"+myedate+
                "' and to_char(offedate,'yyyy-mm-dd')>='"+myedate+"')) and (remark <> '*' or remark is null)";
                myResultSet = stmt.executeQuery(aa);
                if (myResultSet != null)
                {
                        while (myResultSet.next())
                	{ 
                	        int mycount = myResultSet.getInt("mycount");
                	        if (mycount > 0)
                	        {
                	                return "The offdate is duplication";
                	        }
                	}
                	myResultSet.close();
                }
                //4.�P�_�а����B�O�_�B��
                
                int qlcount = 0;
                String theday = "";
                String specialcode = "";
                String str1 = "";
                String str2 = "";
                
                if (station.equals("TPE"))//TPE station
                {
                        aa = "select NVL(specialcode, 'N') specialcode from egtcbas where trim(empn) = '"+empn+"'";
                        myResultSet = stmt.executeQuery(aa);
                        if (myResultSet != null)
                        {
                                while (myResultSet.next())
                        	{ 
                        	        specialcode = myResultSet.getString("specialcode");
                        	        if(specialcode.equals("")) specialcode = "N";
                        	}
                        	myResultSet.close();
                        }
                        if (jobno > 80)//FA �k�ŪA��(�k�U�z�y����), FS �k�ŪA��(�k�U�z�y����)
                        {
                                for (int i = 0; i <= offdays; i++)
                                {
                                        aa = "select to_char(to_date('"+mysdate+"', 'yyyy-mm-dd') + "+i+", 'yyyy-mm-dd') theday from dual";
                                        myResultSet = stmt.executeQuery(aa);
                                        if (myResultSet != null)
                                        {
                                                while (myResultSet.next())
                                        	{ 
                                        	        theday = myResultSet.getString("theday");
                                        	}
                                        	myResultSet.close();
                                        }
                                        //�P�_�O�_����y�ղխ�
                                        if (specialcode.equals("J"))//��y�ղխ�
                                        {
                                        	//*****add by cs55 2005/07/19 ���o���Quota*****
                                        	myResultSet = stmt.executeQuery("select quota from egtquota where yy||'-'||mm=substr('"+theday+"',1,7) and qitem='TPE TYO'");
                                        	while(myResultSet.next()){
                                        		tyo_crew = myResultSet.getInt("quota");
                                        	}
                                        	myResultSet.close();
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
                                                	        if (qlcount >= tyo_crew)
                                                	        {
                                                	                return "TPE-TYO-Crew "+theday+" had over "+tyo_crew+" person";
                                                	        }
                                                       	}
                                                       	myResultSet.close();
                                                }
                                        }
                                        //�P�_�O�_�����y�ղխ�
                                        else if (specialcode.equals("K"))//���y�ղխ�
                                        {
                                        	//*****add by cs55 2005/07/19 ���o���Quota*****
                                        	myResultSet = stmt.executeQuery("select quota from egtquota where yy||'-'||mm=substr('"+theday+"',1,7) and qitem='TPE KOR'");
                                        	while(myResultSet.next()){
                                        		kor_crew = myResultSet.getInt("quota");
                                        	}
                                        	myResultSet.close();
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
                                                	        if (qlcount >= kor_crew)
                                                	        {
                                                	                return "TPE-KOR-Crew "+theday+" had over "+kor_crew+" person";
                                                	        }
                                                       	}
                                                       	myResultSet.close();
                                                }
                                        }
                                        else//�D��y�ղխ�, ���y�ղխ�
                                        {
                                                if (jobno==110 || jobno==90 || (jobno==95 && "M".equals(sex))) //FA
                                                {
                                                        str1 = "110";
                                                        str2 = "90";
                                                        //*****add by cs55 2005/07/19 ���o���Quota*****
                                                	myResultSet = stmt.executeQuery("select quota from egtquota where yy||'-'||mm=substr('"+theday+"',1,7) and qitem='TPE FA'");
                                                	while(myResultSet.next()){
                                                		fa = myResultSet.getInt("quota");
                                                	}
                                                	myResultSet.close();
                                                	//**********************************************
                                                	aa = "SELECT count(*) qlcount " +
                                   			     "FROM EGTCBAS, EGTOFFS  " +
                                   			     "WHERE ( EGTCBAS.empn = EGTOFFS.empn ) and " +   
                                   			     "( ( EGTCBAS.jobno = "+str1+" or EGTCBAS.jobno = "+str2+" or (EGTCBAS.jobno = '95' and EGTCBAS.sex = 'M')) AND " + 
                                   			     "( EGTCBAS.station = 'TPE' ) AND ( NVL(EGTCBAS.specialcode, 'N') not in ('J','K') ) AND " + 
                                   			     "( to_char(EGTOFFS.offsdate,'yyyy-mm-dd') <= '"+theday+"' ) AND " +  
                                   			     "( to_char(EGTOFFS.offedate,'yyyy-mm-dd') >= '"+theday+"' ) AND " +
                                   			     "( EGTOFFS.offtype = '0' ) and (EGTOFFS.remark <> '*' or EGTOFFS.remark is null))";
                                                	System.out.println("FA");
                                                }
                                                else //FS 100,120
                                                {
                                                        str1 = "100";
                                                        str2 = "120";
                                                        //*****add by cs55 2005/07/19 ���o���Quota*****                                                        
                                                	myResultSet = stmt.executeQuery("select quota from egtquota where yy||'-'||mm=substr('"+theday+"',1,7) and qitem='TPE FS'");
                                                    
                                                	while(myResultSet.next()){
                                                		fs = myResultSet.getInt("quota");
                                                	}
                                                	myResultSet.close();
                                                	//**********************************************
                                                	aa = "SELECT count(*) qlcount " +
                                   			     "FROM EGTCBAS, EGTOFFS  " +
                                   			     "WHERE ( EGTCBAS.empn = EGTOFFS.empn ) and " +                                      			     
                                   			     "( ( EGTCBAS.jobno = "+str1+" or EGTCBAS.jobno = "+str2+" or (EGTCBAS.jobno = '95' and EGTCBAS.sex = 'F')) AND " +                                   			     
                                   			     "( EGTCBAS.station = 'TPE' ) AND ( NVL(EGTCBAS.specialcode, 'N') not in ('J','K') ) AND " + 
                                   			     "( to_char(EGTOFFS.offsdate,'yyyy-mm-dd') <= '"+theday+"' ) AND " +  
                                   			     "( to_char(EGTOFFS.offedate,'yyyy-mm-dd') >= '"+theday+"' ) AND " +
                                   			     "( EGTOFFS.offtype = '0' ) and (EGTOFFS.remark <> '*' or EGTOFFS.remark is null))";
                                                	System.out.println("FS");
                                                }
                                                
                                                myResultSet = stmt.executeQuery(aa);
                                                if (myResultSet != null)
                                                {
                                                        while (myResultSet.next())
                                                	{ 
                                                	        qlcount = myResultSet.getInt("qlcount");
                                                	        if ((jobno==110 || jobno==90 || (jobno==95 && "M".equals(sex))) && qlcount >= fa)
                                                	        {
                                                	                return "TPE-FA "+theday+" had over "+fa+" person";
                                                	        }
                                                	        else if ((jobno==120 || jobno==100 || (jobno==95 && "F".equals(sex))) && qlcount >= fs)
                                                	        {
                                                	                return "TPE-FS "+theday+" had over "+fs+" person";
                                                	        }
                                                	        
                                                	}
                                                	myResultSet.close();
                                                }
                                        }
                                }
                        }
                        else//PUR �y����, �ŪA�Щx, �ŪA��
                        {
                                for (int i = 0; i <= offdays; i++)
                                {
                                        aa = "select to_char(to_date('"+mysdate+"', 'yyyy-mm-dd') + "+i+", 'yyyy-mm-dd') theday from dual";
                                        myResultSet = stmt.executeQuery(aa);
                                        if (myResultSet != null)
                                        {
                                                while (myResultSet.next())
                                        	{ 
                                        	        theday = myResultSet.getString("theday");
                                        	}
                                        	myResultSet.close();
                                        }
                                        //*****add by cs55 2005/07/19 ���o���Quota*****
                                	myResultSet = stmt.executeQuery("select quota from egtquota where yy||'-'||mm=substr('"+theday+"',1,7) and qitem='TPE PUR'");
                                	while(myResultSet.next()){
                                		pur = myResultSet.getInt("quota");
                                	}
                                	myResultSet.close();
                                	//**********************************************
                                        aa = "SELECT count(*) qlcount " +
                			     "FROM EGTCBAS, EGTOFFS  " +
                			     "WHERE ( EGTCBAS.empn = EGTOFFS.empn ) and " +   
                			     "( ( to_number(EGTCBAS.jobno) <= 80 ) AND " + 
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
                                        	        if (qlcount >= pur)
                                        	        {
                                        	                return "TPE-PUR "+theday+" had over "+pur+" person";
                                        	        }
                                        	        
                                        	}
                                        	myResultSet.close();
                                        }
                                }
                        }
                }
                else //KHH station
                {
                        if (jobno >= 95)//FA �k�ŪA��, FS �k�ŪA��
                        {
                                for (int i = 0; i <= offdays; i++)
                                {
                                        aa = "select to_char(to_date('"+mysdate+"', 'yyyy-mm-dd') + "+i+", 'yyyy-mm-dd') theday from dual";
                                        myResultSet = stmt.executeQuery(aa);
                                        if (myResultSet != null)
                                        {
                                                while (myResultSet.next())
                                        	{ 
                                        	        theday = myResultSet.getString("theday");
                                        	}
                                        	myResultSet.close();
                                        }
                                        //*****add by cs55 2005/07/19 ���o���Quota*****
                                	myResultSet = stmt.executeQuery("select quota from egtquota where yy||'-'||mm=substr('"+theday+"',1,7) and qitem='KHH CREW'");
                                	while(myResultSet.next()){
                                		kcrew = myResultSet.getInt("quota");
                                	}
                                	//**********************************************
                                        aa = "SELECT count(*) qlcount " +
                			     "FROM EGTCBAS, EGTOFFS  " +
                			     "WHERE ( EGTCBAS.empn = EGTOFFS.empn ) and " +   
                			     "( ( (EGTCBAS.jobno = '110' ) or (EGTCBAS.jobno = '120' ) or (EGTCBAS.jobno = '95')) AND " + 
                			     "( EGTCBAS.station = 'KHH' ) AND " + 
                			     "( to_char(EGTOFFS.offsdate,'yyyy-mm-dd') <= '"+theday+"' ) AND " +  
                			     "( to_char(EGTOFFS.offedate,'yyyy-mm-dd') >= '"+theday+"' ) AND " +
                			     "( EGTOFFS.offtype = '0' ) and (EGTOFFS.remark <> '*' or EGTOFFS.remark is null))";
                                        myResultSet = stmt.executeQuery(aa);
                                        if (myResultSet != null)
                                        {
                                                while (myResultSet.next())
                                        	{ 
                                        	        qlcount = myResultSet.getInt("qlcount");
                                        	        if (qlcount >= kcrew)
                                        	        {
                                        	                return "KHH-Crew "+theday+" had over "+kcrew+" person";
                                        	        }
                                        	        
                                        	}
                                        	myResultSet.close();
                                        }
                                }
                        }
                        else//PUR �y����, �ŪA�Щx, �ŪA��
                        {
                                for (int i = 0; i <= offdays; i++)
                                {
                                        aa = "select to_char(to_date('"+mysdate+"', 'yyyy-mm-dd') + "+i+", 'yyyy-mm-dd') theday from dual";
                                        myResultSet = stmt.executeQuery(aa);
                                        if (myResultSet != null)
                                        {
                                                while (myResultSet.next())
                                        	{ 
                                        	        theday = myResultSet.getString("theday");
                                        	}
                                        	myResultSet.close();
                                        }
                                        //*****add by cs55 2005/07/19 ���o���Quota*****
                                	myResultSet = stmt.executeQuery("select quota from egtquota where yy||'-'||mm=substr('"+theday+"',1,7) and qitem='KHH PUR'");
                                	while(myResultSet.next()){
                                		kpur = myResultSet.getInt("quota");
                                	}
                                	myResultSet.close();
                                	//**********************************************
                                        aa = "SELECT count(*) qlcount " +
                			     "FROM EGTCBAS, EGTOFFS  " +
                			     "WHERE ( EGTCBAS.empn = EGTOFFS.empn ) and " +   
                			     "( ( to_number(EGTCBAS.jobno) <= 80 ) AND " + 
                			     "( EGTCBAS.station = 'KHH' ) AND " + 
                			     "( to_char(EGTOFFS.offsdate,'yyyy-mm-dd') <= '"+theday+"' ) AND " +  
                			     "( to_char(EGTOFFS.offedate,'yyyy-mm-dd') >= '"+theday+"' ) AND " +
                			     "( EGTOFFS.offtype = '0' ) and (EGTOFFS.remark <> '*' or EGTOFFS.remark is null))";
                                        myResultSet = stmt.executeQuery(aa);
                                        if (myResultSet != null)
                                        {
                                                while (myResultSet.next())
                                        	{ 
                                        	        qlcount = myResultSet.getInt("qlcount");
                                        	        if (qlcount >= kpur)
                                        	        {
                                        	                return "KHH-PUR "+theday+" had over "+kpur+" person";
                                        	        }
                                        	        
                                        	}
                                        	myResultSet.close();
                                        }
                                }
                        }
                }
                //5.�P�_�S�𰲬O�_������,�O�_�n���
                offdays = offdays + 1;
                GregorianCalendar cd1 = new GregorianCalendar();
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                SimpleDateFormat MM = new SimpleDateFormat("MM");
                SimpleDateFormat DD = new SimpleDateFormat("dd");
                SimpleDateFormat YY = new SimpleDateFormat("yyyy");
                String currentdate = dateFormat.format(cd1.getTime());//���Ѥ��
                String themm = MM.format(cd1.getTime());
                String thedd = DD.format(cd1.getTime());
                String theyy = YY.format(cd1.getTime());
                String inmm = indate.substring(5, 7);
                String indd = indate.substring(8);
                String myindate = null;
                if (themm.compareTo(inmm) == 0)
                {
                	if (thedd.compareTo(indd) < 0)
                	{
                		myindate = theyy + indate.substring(4);//"���~��"�i���q��
                	}
                	else
                	{
                		myindate = String.valueOf(Integer.parseInt(theyy) + 1) + indate.substring(4);
                	}
                }
                else if (themm.compareTo(inmm) < 0)//�i���q����O�_�j���J������
                {
                        myindate = theyy + indate.substring(4);//"���~��"�i���q��
                }
                else //"���~��"�i���q��
                {
                        myindate = String.valueOf(Integer.parseInt(theyy) + 1) + indate.substring(4);
                }
                Date thedate = Date.valueOf(currentdate);//���Ѥ��
                Date theoffsdate = Date.valueOf(mysdate);//�а��}�l��
                Date theoffedate = Date.valueOf(myedate);//�а�������
                Date theindate = Date.valueOf(myindate);//�i���q��
                
                int cthisdays = 0;
                int cnextdays = 0;
                rs = "0--" + myindate + "," + mysdate + "," + myedate;
                //�p�⥼�������~<lastdays+thisdays>�S�𰲤Ѽ�
                aa = "select nvl(sum(offdays), 0) offcount from egtoffs where sern = "+sern+" and to_char(offsdate,'yyyy-mm-dd') < '"+myindate+"' and offtype = '0' and remark = 'N'";
                myResultSet = stmt.executeQuery(aa);
                if (myResultSet.next()){
                	cthisdays = myResultSet.getInt("offcount");
                }
                myResultSet.close();
                rs = "1--"+cthisdays+"," + myindate + "," + mysdate + "," + myedate;
                //�p�⥼�����w��<nextdays>�S�𰲤Ѽ�
		aa = "select nvl(sum(offdays), 0) offcount from egtoffs where sern = "+sern+" and to_char(offsdate,'yyyy-mm-dd') >= '"+myindate+"' and offtype = '0' and remark = 'N'";
                myResultSet = stmt.executeQuery(aa);
                if (myResultSet.next()){
                	cnextdays = myResultSet.getInt("offcount");
                }
                myResultSet.close();
                rs = "2--"+cnextdays+"," + myindate + "," + mysdate + "," + myedate;
                int b1 = theoffsdate.compareTo(theindate);//�а��}�l��O�_>�i���q��
                int b2 = theoffedate.compareTo(theindate);//�а�������O�_>�i���q��
                
                //�P�_���i����Ӧ����@�ӯS��
                //offedate < indate
                if (b2 < 0){
                	cthisdays = cthisdays + offdays;
        	}
        	//offsdate >= indate
                else if (b1 >= 0){
                	cnextdays = cnextdays + offdays;
	        }
	        else{
	        	aa = "select (to_date('"+myindate+"', 'yyyy-mm-dd') - to_date('"+mysdate+"', 'yyyy-mm-dd')) day1, " +
	        	     "(to_date('"+myedate+"', 'yyyy-mm-dd') - to_date('"+myindate+"', 'yyyy-mm-dd')) day2 from dual";
                        myResultSet = stmt.executeQuery(aa);
                        if (myResultSet.next())
                        {
				cthisdays = cthisdays + myResultSet.getInt("day1");
				cnextdays = cnextdays + myResultSet.getInt("day2") + 1;
                        }
                        myResultSet.close();
	        }
	        rs = "3" + myindate + "," + mysdate + "," + myedate;
                //�P�_�ثe�Ѿl�S�𰲤ѼƬO�_����<lastdays,thisdays,nextdays>
                if ((cthisdays > (lastdays + thisdays)) || (cnextdays > nextdays)){
                	return "�O�d+���~�S�� �� �w���S�𰲤��� !";
                }
                //�P�_�O�_�Ӱ��榳��"�i���q��", �p���h�n��}����
                
                if (b1 < 0 && b2 >= 0){
                	//�p��а��Ѽ�
                        aa = "select (to_date('"+myedate+"', 'yyyy-mm-dd') - to_date('"+myindate+"', 'yyyy-mm-dd')) offdays from dual";
                        myResultSet = stmt.executeQuery(aa);
                        if (myResultSet.next())
                        {
				offdays = myResultSet.getInt("offdays") + 1;
                        }
                        myResultSet.close();
                        rs = "4" + myindate + "," + mysdate + "," + myedate;
                        int rowsAffected = stmt.executeUpdate("insert into egtoffs (offno, empn, sern, offtype, offsdate, offedate, offdays, station, remark, offyear, gradeyear, newuser, newdate)"+
			" values (LPAD(egqofno.nextval, 6, '0'), '"+empn+"', "+sern+", '0', to_date('"+myindate+"', 'yyyy-mm-dd'), to_date('"+myedate+"', 'yyyy-mm-dd'), to_date('"+myedate+
			"', 'yyyy-mm-dd') - to_date('"+myindate+"', 'yyyy-mm-dd') + 1, '"+station+"', 'N', '"+offyear+"', '"+gradeyear+"', 'sys', sysdate)");
			
			if (rowsAffected == 1)
			{
				aa = "select to_char((to_date('"+myindate+"', 'yyyy-mm-dd') - 1), 'yyyy-mm-dd') cutdays from dual";
	                        myResultSet = stmt.executeQuery(aa);
	                        if (myResultSet.next())
	                        {       //�p�����Ǧ^���а�������
	                                cutdate = myResultSet.getString("cutdays");
	                        }
	                        myResultSet.close();
			}
			rs = "5" + myindate + "," + mysdate + "," + myedate;
                }
                //�x�s�찲��***************************
                stmt.executeUpdate("insert into egtoffs (offno, empn, sern, offtype, offsdate, offedate, offdays, station, remark, offyear, gradeyear, newuser, newdate)"+
		" values (LPAD(egqofno.nextval, 6, '0'), '"+empn+"', "+sern+", '0', to_date('"+mysdate+"', 'yyyy-mm-dd'), to_date('"+cutdate+"', 'yyyy-mm-dd'), to_date('"+cutdate+
		"', 'yyyy-mm-dd') - to_date('"+mysdate+"', 'yyyy-mm-dd') + 1, '"+station+"', 'N', '"+offyear+"', '"+gradeyear+"', '"+empn+"', sysdate)");

        	try{if(myResultSet!=null) myResultSet.close();}catch(Exception e){throw e;}
        	try{if(stmt!=null) stmt.close();}catch(Exception e){throw e;}

                return "0";
        }
        //�S�𰲤ѼƤ��i�j��30�Ѥp��0��//
        public String getOffdays(String offsdate, String offedate) throws Exception{
        	Statement stmt = con.createStatement();
        	ResultSet myResultSet = null;
        	int offdays = 0;
                
                myResultSet = stmt.executeQuery("select (to_date('"+offedate+"','yyyy-mm-dd') - to_date('"+offsdate+
		"','yyyy-mm-dd') + 1) offdays from dual");
                if (myResultSet.next()){
                	offdays = myResultSet.getInt("offdays");
                }
                if(offdays <= 0 || offdays > 30){
                	return "�𰲤ѼƤ��i�p�󵥩�0�ѩΤj��30�� : " + String.valueOf(offdays);
                }
                
        	try{if(myResultSet!=null) myResultSet.close();}catch (Exception e){throw e;}
        	try{if(stmt!=null) stmt.close();}catch (Exception e){throw e;}
        	
        	return "0";
        }
        //�p�⥼�����S�𰲤Ѽ�//
        public int getCutday(String sern){
        	int cd = 0;
        	Driver dbDriver = null;
        	Connection con = null;
        	Statement stmt = null;
        	ResultSet myResultSet = null;
        	try{
	        	ConnDB cdb = new ConnDB();	
                	cdb.setORP3EGUserCP();
                        dbDriver = (Driver) Class.forName(cdb.getDriver()).newInstance();
			con = dbDriver.connect(cdb.getConnURL(), null);
	                stmt = con.createStatement();
	                	                
	                myResultSet = stmt.executeQuery("select nvl(sum(offdays), 0) offcount from egtoffs where sern = "+sern+" and offtype = '0' and remark = 'N'");
	                if (myResultSet.next()){
	                	cd = myResultSet.getInt("offcount");
	                }
                }
                catch (Exception e)
                {
                	new Loger().setErrorLog("CheckUpdateAl.java-->getCutday", sern, e);
                }  
                finally{
                	try{if(myResultSet!=null) myResultSet.close();}catch (Exception e){}
                	try{if(stmt!=null) stmt.close();}catch (Exception e){}
                	try{if(con!=null) con.close();}catch (Exception e){}
                	
                }
                return cd;
        }
        //�p�⥻��w�ЯS�𰲤Ѽ�//
        public int getOverOff(String sern, String offmm){
        	int cd = 0;
        	Driver dbDriver = null;
        	Connection con = null;
        	Statement stmt = null;
        	ResultSet myResultSet = null;
        	try{
	        	ConnDB cdb = new ConnDB();	
                	cdb.setORP3EGUserCP();
                        dbDriver = (Driver) Class.forName(cdb.getDriver()).newInstance();
			con = dbDriver.connect(cdb.getConnURL(), null);
	                stmt = con.createStatement();
	                	                
	                myResultSet = stmt.executeQuery("select nvl(sum(offdays), 0) offcount from egtoffs where sern = "+
	                sern+" and to_char(offsdate,'yyyy-mm') = '"+offmm+"' and (remark <> '*' or remark is null)");
	                if (myResultSet.next()){
	                	cd = myResultSet.getInt("offcount");
	                }
                }
                catch (Exception e)
                {
                	new Loger().setErrorLog("CheckUpdateAl.java-->getOffdays", sern, e);
                }  
                finally{
                	try{if(myResultSet!=null) myResultSet.close();}catch (Exception e){}
                	try{if(stmt!=null) stmt.close();}catch (Exception e){}
                	try{if(con!=null) con.close();}catch (Exception e){}
                	
                }
                return cd;
        }
        public String cutdate(){
        	return cutdate;
        }
}
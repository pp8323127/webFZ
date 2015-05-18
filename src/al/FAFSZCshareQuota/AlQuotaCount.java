package al;

import ci.db.ConnDB;
import java.sql.*;
import java.util.*;
import java.sql.Date;
import java.text.*;
import java.lang.*;
import al.ALInfo;

//***********計算組員特休額度*************
public class AlQuotaCount
{   
        private int lastday; 
        private String jobno1; 
        private String jobno2;
        private int thequota = 0;
        
                            //PUR, FA, FS, TYO_CREW, KOR_CREW , TPE ZC 2003-09        
        public int[] quotacount(String jobitem, String myday, String qitem, String station) 
        {            
                String aa = "";
                String theday = "";
                String offsdate = "";
                String offedate = "";
                int[] alquota = new int[31];
                
                Driver dbDriver = null;
                Connection con = null;
                Statement stmt = null;
                
                String sdate = null;
                String edate = null;
                
                try
                {
                	ALInfo ai = new ALInfo();
                	ai.setQuota();
                	sdate = ai.getSdate();
                	edate = ai.getEdate();
                	
                	ConnDB cdb = new ConnDB();	
                	cdb.setORP3EGUserCP();
                    dbDriver = (Driver) Class.forName(cdb.getDriver()).newInstance();
                    con = dbDriver.connect(cdb.getConnURL(), null);
                    stmt = con.createStatement();
                    ResultSet myResultSet = null;
        
                    //取得請假限額
                    //****************************              
                    aa = "select quota from egtquota where yy||'-'||mm='"+myday+"' and qitem='"+qitem+"'";

                    myResultSet = stmt.executeQuery(aa);
                    if (myResultSet != null){
                    	while(myResultSet.next()){
                    		this.thequota = myResultSet.getInt("quota");
                    	}
                    }
                                		
                        //當月最後一天
                        aa = "select to_char(last_day(to_date('" + myday + "-01', 'yyyy-mm-dd')), 'dd') lastday from dual";
                        myResultSet = stmt.executeQuery(aa);
                        if (myResultSet != null)
                        {
                                while (myResultSet.next())
                        	{ 
                        	        lastday = myResultSet.getInt("lastday");
                        	}
                        }
                        String mysmm = sdate.substring(0, 7);
                        String myemm = edate.substring(0, 7);
                        int thesday;
                        int theeday;
                        if (mysmm.equals(myday) && !myemm.equals(myday))
                        {
                                thesday = Integer.parseInt(sdate.substring(8, 10));
                                theeday = lastday;
                        }
                        else if (mysmm.equals(myday) && myemm.equals(myday))
                        {
                                thesday = Integer.parseInt(sdate.substring(8, 10));
                                theeday = Integer.parseInt(edate.substring(8, 10));
                        }
                        else if (!mysmm.equals(myday) && myemm.equals(myday))
                        {
                                thesday = 1;
                                theeday = Integer.parseInt(edate.substring(8, 10));
                        }
                        else
                        {
                                thesday = 0;
                                theeday = 0;
                        }
                        
                        //定義初始值
                        for (int i = 0; i < lastday; i++)
                        {
                                if ((thesday + theeday) != 0 && i >= (thesday - 1) && i <= (theeday - 1))
                                {
                                        alquota[i] = 0;
                                }
                                else
                                {
                                        alquota[i] = thequota;
                                }
                        }
                        //********************判斷station and jobitem**************
                                
                        if (jobitem.equals("PUR"))//TPE, KHH PUR
                        {
                                aa = "select to_char(a.offsdate, 'yyyy-mm-dd') offsdate, to_char(a.offedate, 'yyyy-mm-dd') offedate " +
	                             "from EGTOFFS a, EGTCBAS b " +
	                             "where a.empn = b.empn and b.station = '" + station + 
	                             "' and to_number(b.jobno) <= 80 and " +
			             "a.offtype = '0' and (to_char(a.offsdate,'yyyy-mm') = '" + myday + 
			             "' or to_char(a.offedate,'yyyy-mm') = '" + myday + "') and (a.remark <> '*' or a.remark is null)";
                        }
                        else if (jobitem.equals("TYO_CREW"))
                        {
                                aa = "select to_char(a.offsdate, 'yyyy-mm-dd') offsdate, to_char(a.offedate, 'yyyy-mm-dd') offedate " +
                        	"from EGTOFFS a, EGTCBAS b " +
                        	"where a.empn = b.empn and b.station = 'TPE' and " +
        			"b.specialcode = 'J' and " + 
        			"a.offtype = '0' and (to_char(a.offsdate,'yyyy-mm') = '" + myday + "' or " +
        			"to_char(a.offedate,'yyyy-mm') = '" + myday + "') and (a.remark <> '*' or a.remark is null)";
                        }
                        else if (jobitem.equals("KOR_CREW"))//ADD BY CS55 2004/08/10
                        {
                                aa = "select to_char(a.offsdate, 'yyyy-mm-dd') offsdate, to_char(a.offedate, 'yyyy-mm-dd') offedate " +
                        	"from EGTOFFS a, EGTCBAS b " +
                        	"where a.empn = b.empn and b.station = 'TPE' and " +
        			"b.specialcode = 'K' and " + 
        			"a.offtype = '0' and (to_char(a.offsdate,'yyyy-mm') = '" + myday + "' or " +
        			"to_char(a.offedate,'yyyy-mm') = '" + myday + "') and (a.remark <> '*' or a.remark is null)";
                        }
                        else if (station.equals("TPE"))//TPE CREW (FA, FS)
                        {
                                if (jobitem.equals("FA"))
                                {
                                        jobno1 = "110";
                                        jobno2 = "90";
                                        
                                        aa = "select to_char(a.offsdate, 'yyyy-mm-dd') offsdate, to_char(a.offedate, 'yyyy-mm-dd') offedate " +
                                    	"from EGTOFFS a, EGTCBAS b " + 
                                    	"where a.empn = b.empn and b.station = 'TPE' and " +
                                    	"(b.jobno = " + jobno1 + " or b.jobno = "+jobno2+" or (b.jobno = '95' and b.sex = 'M')) and NVL(b.specialcode, 'N') not in ('J','K') and " +
                                    	"a.offtype = '0' and (to_char(a.offsdate,'yyyy-mm') <= '" + myday + "' and " +
                                    	"to_char(a.offedate,'yyyy-mm') >= '" + myday + "') and (a.remark <> '*' or a.remark is null)";
                                }
                                else if (jobitem.equals("FS"))//FS
                                {
                                        jobno1 = "100";
                                        jobno2 = "120";
                                        
                                        aa = "select to_char(a.offsdate, 'yyyy-mm-dd') offsdate, to_char(a.offedate, 'yyyy-mm-dd') offedate " +
                                    	"from EGTOFFS a, EGTCBAS b " + 
                                    	"where a.empn = b.empn and b.station = 'TPE' and " +                                    	
                                    	"(b.jobno = " + jobno1 + " or b.jobno = "+jobno2+" or (b.jobno = '95' and b.sex = 'F')) and NVL(b.specialcode, 'N') not in ('J','K') and " +                                    	
                                    	"a.offtype = '0' and (to_char(a.offsdate,'yyyy-mm') <= '" + myday + "' and " +
                                    	"to_char(a.offedate,'yyyy-mm') >= '" + myday + "') and (a.remark <> '*' or a.remark is null)";
                                }
                                
                        }
                        else if (station.equals("KHH"))//KHH CREW
                        {
                                aa = "select to_char(a.offsdate, 'yyyy-mm-dd') offsdate, to_char(a.offedate, 'yyyy-mm-dd') offedate " +
                        	"from EGTOFFS a, EGTCBAS b " +
                        	"where a.empn = b.empn and b.station = 'KHH' and " +
        			"( b.jobno = '110' or b.jobno = '120' or b.jobno = '95' ) and " +
        			"a.offtype = '0' and (to_char(a.offsdate,'yyyy-mm') = '" + myday + "' or " +
        			"to_char(a.offedate,'yyyy-mm') = '" + myday + "') and (a.remark <> '*' or a.remark is null)";
                        }
                        myResultSet = stmt.executeQuery(aa);
                        if (myResultSet != null)
                        {
                                while (myResultSet.next())
                        	{ 
                        	        offsdate = myResultSet.getString("offsdate");
                        	        offedate = myResultSet.getString("offedate");
                        	        if (!offsdate.substring(0, 7).equals(myday)){offsdate = myday + "-01";}
                        	        if (!offedate.substring(0, 7).equals(myday)){offedate = myday + "-" + Integer.toString(lastday);}
                        	        for (int i = Integer.parseInt(offsdate.substring(8, 10)) - 1; i < Integer.parseInt(offedate.substring(8, 10)); i++)
                        	        {
                        	                alquota[i] = alquota[i] - 1;
                        	        }
                       	        }
                        }
                }
                catch (Exception e)
                {
                        System.out.println("AlQuotaCount 錯誤 : "+e.toString());
			//e.printStackTrace(System.out);
                } 
                finally{
                	try{if(stmt != null) stmt.close();}catch (Exception e){}
                	try{if(con != null) con.close();}catch (Exception e){}
                }
                return alquota;    
        }
        public int getQuota(){
        	return this.thequota;
        }
}
package credit;

import java.sql.*;
import java.text.*;
import java.util.*;

import ci.db.*;

/**
 * FullAttendanceForPickSkj 取得組員730 continue working days for pick skj.
 * 
 * 
 * @author cs71
 * @version 1.0 2008/06/10
 * 
 * Copyright: Copyright (c) 2008
 */
public class FullAttendanceForPickSkj 
{
	public static void main(String[] args) 
	{  
	    ArrayList fullAttendAL = new ArrayList();
	    FullAttendanceForPickSkj faps = new FullAttendanceForPickSkj("631372");
//	    faps.getCheckRange();
//	    fullAttendAL = faps.getFullAttendanceRange();

//	    faps.getCheckRange2();
//	    fullAttendAL = faps.getFullAttendanceRange2();
	    
	    faps.getCheckRange3();
	    fullAttendAL = faps.getFullAttendanceRange2();
//	    
////	    System.out.println(faps.getCheckRangeStartDate("2010/11/08"));
//System.out.println("*********************************");	    
		for(int i=0; i<fullAttendAL.size(); i++)
		{
			FullAttendanceForPickSkjObj obj = (FullAttendanceForPickSkjObj) fullAttendAL.get(i);
			System.out.println("*********************************");
			System.out.println((i+1)+"**"+obj.getCheck_range_start()+"**"+obj.getCheck_range_final_end()+"**");
//			System.out.println(obj.getCheck_range_start());
//	        System.out.println(obj.getCheck_range_final_end());
	        System.out.println(obj.getComments());	    
//	        System.out.println(obj.getEmpno());	    
		}
//System.out.println("*********************************");			
		
//	    for(int i=0; i<objAL.size(); i++)
//	    {
//	        FullAttendanceForPickSkjObj obj = (FullAttendanceForPickSkjObj) objAL.get(i);
//	        System.out.println(obj.getCheck_range_start());
//	        System.out.println(obj.getCheck_range_final_end());
//	        System.out.println(obj.getComments());	    
//	        System.out.println(obj.getEmpno());	    
//	        System.out.println("*********************************");	    
//	    }
//	    System.out.println(fullAttendAL.size());
	    System.out.println("Done");
	    
//	    SimpleDateFormat df = new SimpleDateFormat("yyyy/MM/dd");	  
//	    
//	    Calendar cal = new GregorianCalendar();
//	    Calendar cal2 = new GregorianCalendar();
//	    //get sysdate
//	    System.out.println(df.format(cal.getTime()));
//	    cal.add(Calendar.DATE, -1);  
//	    //get sysdate-1
//	    System.out.println(df.format(cal.getTime()));
//	    cal2.add(Calendar.DATE, -731);  
//	    //get sysdate -731
//	    System.out.println(df.format(cal2.getTime()));	    
//	    //get days between two dates
//	    long days=(cal.getTimeInMillis()-cal2.getTimeInMillis())/(24*60*60*1000);
//	    System.out.println(days);	    
//	    
//	    //compare
//	    System.out.println(cal.before(cal2));// cal2 早於 cal
//	    System.out.println(cal.after(cal2));// cal2 晚於 cal
//	    System.out.println(cal.equals(cal2));// cal2 等於 cal
	}

	private String empno;// 員工號	
	private String ifsuspend = "Y";
	private String nextstart = "";
	private SimpleDateFormat df = new SimpleDateFormat("yyyy/MM/dd");
	private FullAttendanceForPickSkjObj obj = new FullAttendanceForPickSkjObj();
	private ArrayList objAL = new ArrayList();
	private Driver dbDriver = null;
	private String dateline1 = "2012/09/01";
	private String dateline2 = "2010/09/01";
	
	/**
	 * @param empno
	 *            組員員工號
	 * @param swapYearAndMonth
	 *            換班年月,format: yyyymm
	 */
	public FullAttendanceForPickSkj(String empno) 
	{
		this.empno = empno;
	}

	public void getCheckRange() 
	{	
	    Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;		
		SimpleDateFormat f = new SimpleDateFormat("yyyy/MM/dd");
	   
	    //**************************************************
	    //Set inital check range sysdate-1 --> 730 days
		//2012/09/01 關始 check range 從2010/09/01,二年限制取消
	    Calendar cal = new GregorianCalendar();
	    Calendar cal2 = new GregorianCalendar();	
	    
	    Calendar cal_line = new GregorianCalendar();//2012/09/01	    
//	    cal_line.set(Calendar.YEAR,2012);
//	    cal_line.set(Calendar.MONTH,8);
//	    cal_line.set(Calendar.DATE,1);
//	    cal_line.set(Calendar.HOUR_OF_DAY,0);
//	    cal_line.set(Calendar.MINUTE,0);
//	    cal_line.set(Calendar.SECOND,0);
	    
	    cal_line.set(Calendar.YEAR,2012);
	    cal_line.set(Calendar.MONTH,7);
	    cal_line.set(Calendar.DATE,1);
	    cal_line.set(Calendar.HOUR_OF_DAY,0);
	    cal_line.set(Calendar.MINUTE,0);
	    cal_line.set(Calendar.SECOND,0);
	    
	    Calendar cal_startline = new GregorianCalendar();//2010/09/01	    
//	    cal_startline.set(Calendar.YEAR,2010);
//	    cal_startline.set(Calendar.MONTH,8);
//	    cal_startline.set(Calendar.DATE,1);
//	    cal_startline.set(Calendar.HOUR_OF_DAY,0);
//	    cal_startline.set(Calendar.MINUTE,0);
//	    cal_startline.set(Calendar.SECOND,0);
	    
	    cal_startline.set(Calendar.YEAR,2010);
	    cal_startline.set(Calendar.MONTH,7);
	    cal_startline.set(Calendar.DATE,1);
	    cal_startline.set(Calendar.HOUR_OF_DAY,0);
	    cal_startline.set(Calendar.MINUTE,0);
	    cal_startline.set(Calendar.SECOND,0);
	    
	    
	    
	    //get sysdate
	    df.format(cal.getTime());
	    cal.add(Calendar.DATE, -1);  
	    //get sysdate-1
	    obj.setCheck_range_start(df.format(cal.getTime()));	
	    obj.setTemp_working_date_start(df.format(cal.getTime()));	
//System.out.println(obj.getTemp_working_date_start());	    
//System.out.println(obj.getCheck_range_start());	    
	    
	    //2012/09/01 以前保留二年, otherwise 沒效期由 2010/09/01 計
	    if(cal.before(cal_line))
	    {//2012/09/01 以前
	        //get sysdate -731	 
	        cal2.add(Calendar.DATE, -731);  
	    }
	    else
	    {
	        cal2 = cal_startline;	    
	    }
	    
	    obj.setTemp_working_date_end(df.format(cal2.getTime()));
//System.out.println(obj.getTemp_working_date_end());	        
	    
	    
	    //***************************************************
	    boolean getCdate = false;
	    String latestdate = "";
	    String sql = "";
		try 
		{
			// connection Pool
		    ConnectionHelper ch = new ConnectionHelper();
	        conn = ch.getConnection();  
	        //conn.setCatalog("alter session set cursor_sharing=exact");
	        //alter session set cursor_sharing=exact
	        stmt = conn.createStatement();	
	        
	        if(cal.before(cal_line))
	        {
	             sql =  " SELECT CASE WHEN (SYSDATE-731) > To_Date(edate,'yyyy/mm/dd') " +
	             		" THEN To_Char((SYSDATE-731),'yyyy/mm/dd') ELSE edate END edate FROM ( " +
	             		" SELECT Nvl(edate, (SELECT To_Char(indate,'yyyy/mm/dd') edate FROM egtcbas " +
	             		" WHERE empn = '"+empno+"')) edate FROM ( " +
	             		" SELECT To_Char(Max(edate),'yyyy/mm/dd') edate FROM egtpick " +
	             		" WHERE reason = 1 AND valid_ind = 'Y' AND empno = '"+empno+"') ) ";
	        }
	        else
	        {//2012/09/01 以後
	            sql = " SELECT CASE WHEN To_Date('"+dateline2+"','yyyy/mm/dd') > To_Date(edate,'yyyy/mm/dd') " +
	         		  " THEN To_Char(To_Date('"+dateline2+"','yyyy/mm/dd'),'yyyy/mm/dd') ELSE edate END edate FROM ( " +
	         		  " SELECT Nvl(edate, (SELECT To_Char(indate,'yyyy/mm/dd') edate FROM egtcbas " +
	         		  " WHERE empn = '"+empno+"')) edate FROM ( " +
	         		  " SELECT To_Char(Max(edate),'yyyy/mm/dd') edate FROM egtpick " +
	         		  " WHERE reason = 1 AND valid_ind = 'Y' AND empno = '"+empno+"') ) ";
	        }

//System.out.println(sql);
		    rs = stmt.executeQuery(sql);
		    if (rs.next())
			{
		        latestdate = rs.getString("edate");			    
			}
		    else
		    {	
//		        latestdate = "2006/05/01";			
//		        //只保留730天 -731
		        //2012/09/01 始沒有期限限制
		        //2010/09/01 可永久有效
		        Calendar remainday = new GregorianCalendar();
		        if(cal.before(cal_line))
		        {
		            remainday.add(Calendar.DATE, -731);
		        }
		        else
		        {//2012/09/01 以後
		            remainday = cal_startline;
		        }
		        latestdate = df.format(remainday.getTime());	 
		    }

//System.out.println("lastapply date : "+latestdate);
		
		    //**********************************************	
	        while (getCdate==false)
	        {
		        sql = " SELECT Sum(recurdate-ssdate) suspdays FROM (SELECT ssdate, recurdate FROM egtsusp " +
		        	  " WHERE empn = '"+empno+"'  AND recurdate IS NOT NULL " +
		        	  " AND (To_Date('"+obj.getTemp_working_date_start()+"','yyyy/mm/dd') >= recurdate " +
		        	  " AND To_Date('"+obj.getTemp_working_date_end()+"','yyyy/mm/dd') < recurdate )  ) ";
//System.out.println(sql);
				rs = stmt.executeQuery(sql);
				
				if (rs.next())
				{
				    int suspdays = 0-rs.getInt("suspdays");
				    if(suspdays<0)
				    {
//System.out.println("Last end day : "+df.format(cal2.getTime()));				        
				        cal2.add(Calendar.DATE,suspdays);  
//System.out.println("Last end day - suspend days: "+df.format(cal2.getTime()));
				        obj.setTemp_working_date_start(obj.getTemp_working_date_end());
				        obj.setTemp_working_date_end(df.format(cal2.getTime()));
//System.out.println("Temp_working_date_start  "+obj.getTemp_working_date_start());				 
//System.out.println("Temp_working_date_end " +obj.getTemp_working_date_end());
				    }
				    else
				    {//suspdays==0 無留停
				        obj.setCheck_range_end(obj.getTemp_working_date_end());
//System.out.println("Check_range_end " +obj.getCheck_range_end());				        
					    getCdate = true;
				    }				    
				}
				else
				{
				    obj.setCheck_range_end(obj.getTemp_working_date_end());
				    getCdate = true;				    
				}
				rs.close();
	        }
	        
//System.out.println("final start date : "+obj.getCheck_range_start());
//System.out.println("final end  date : "+obj.getCheck_range_end());      
//System.out.println("final final end date : "+getLatestDate(obj.getCheck_range_end(),"2006/05/01",latestdate));
	        //****************************************************	       
	        obj.setCheck_range_final_end(getLatestDate(obj.getCheck_range_end(),"2006/05/01",latestdate));
	        //****************************************************
//System.out.println(obj.getCheck_range_final_end());	        
		} 
		catch (Exception e) 
		{
			System.out.println("A:"+e.toString());
		} 
		finally 
		{
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (stmt != null)
				try 
				{
					stmt.close();
				} catch (SQLException e) {}			
			if (conn != null)
				try {
//				    System.out.println("conn close ");
					conn.close();
				} catch (SQLException e) {}
		}

	}	
	
	private long getDiffDays(Calendar cal, Calendar cal2)
	{
	    return (cal.getTimeInMillis()-cal2.getTimeInMillis())/(24*60*60*1000);
	}
	
	private String getLatestDate(String normal,String aircrews,String latestdate)
	{
	    GregorianCalendar cal1 = new GregorianCalendar();
	    GregorianCalendar cal2 = new GregorianCalendar();
	    GregorianCalendar cal3 = new GregorianCalendar();
	    
	    //normal
	    cal1.set(Calendar.YEAR,Integer.parseInt(normal.substring(0,4)));
	    cal1.set(Calendar.MONTH,Integer.parseInt(normal.substring(5,7))-1);
	    cal1.set(Calendar.DATE,Integer.parseInt(normal.substring(8,10)));

	    //aircrews
	    cal2.set(Calendar.YEAR,Integer.parseInt(aircrews.substring(0,4)));
	    cal2.set(Calendar.MONTH,Integer.parseInt(aircrews.substring(5,7))-1);
	    cal2.set(Calendar.DATE,Integer.parseInt(aircrews.substring(8,10)));
		
	    //latestdate
	    cal3.set(Calendar.YEAR,Integer.parseInt(latestdate.substring(0,4)));
	    cal3.set(Calendar.MONTH,Integer.parseInt(latestdate.substring(5,7))-1);
	    cal3.set(Calendar.DATE,Integer.parseInt(latestdate.substring(8,10)));		
	    
	    
//System.out.println("normal  "+df.format(cal1.getTime()));
//System.out.println("aircrews "+df.format(cal2.getTime()));
//System.out.println("latestdate "+df.format(cal3.getTime()));
	    
	    if(cal1.after(cal2))
	    {
	        //then cal1 大
	        if(cal1.after(cal3))
	        {
	            return normal;
	        }
	        else
	        {
	            return latestdate;
	        }
	    }
	    else
	    {
	        //then cal2 大
	        if(cal2.after(cal3))
	        {
	            return aircrews;
	        }
	        else
	        {
	            return latestdate;
	        }
	    }
	}
	
	public ArrayList getFullAttendanceRange() 
	{
	    ArrayList absentSAL = new ArrayList();
	    ArrayList absentEAL = new ArrayList();
	    ArrayList absentCodeAL = new ArrayList();
	    Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;	
		String sql = "";
		try 
		{

			// connection Pool
	        ConnectionHelper ch = new ConnectionHelper();
	        conn = ch.getConnection();  
//	        conn.setCatalog("alter session set cursor_sharing=exact");
	        //alter session set cursor_sharing=exact
	        stmt = conn.createStatement();
	        
	        //*********************************************************************************
	        //Append  SD
	        sql = " SELECT To_Char(SYSDATE,'yyyy/mm/dd') str_dt, To_Char(SYSDATE,'yyyy/mm/dd') end_dt, 'SD' duty_cd FROM dual ";
//System.out.println(sql);
			rs = stmt.executeQuery(sql);
			
			while (rs.next())
			{//請假記錄
			    absentSAL.add(rs.getString("str_dt"));
			    absentEAL.add(rs.getString("end_dt"));
			    absentCodeAL.add(rs.getString("duty_cd"));
			}
			rs.close();
	        
			sql = " SELECT * FROM ( " +
	        	  " select To_Char(str_dt,'yyyy/mm/dd') str_dt, To_Char(end_dt,'yyyy/mm/dd') end_dt, duty_cd " +
	        	  " from fzdb.roster_v  " +
	        	  //" where ( duty_cd in ('PL','SL','EL','UL','LL','NS') " +
	        	  " where ( duty_cd in ('SL','PL','EL','UL','LL','NS','CL','CNCL') " +	        	  
	        	  "  or (duty_cd = 'LA' AND To_Char(end_dt,'hh24mi') = '2359')) " +
	        	  " and delete_ind='N' and staff_num = '"+empno+"' " +
	        	  " AND ( (str_dt >= To_Date('"+obj.getCheck_range_final_end()+" 0000','yyyy/mm/dd hh24mi') " +
	        	  " AND end_dt <= To_Date('"+obj.getCheck_range_start()+" 2359','yyyy/mm/dd hh24mi') ) " +
//	        	  " OR To_Date('"+obj.getCheck_range_start()+"','yyyy/mm/dd') BETWEEN str_dt AND end_dt " +  
	        	  " OR (str_dt <= To_Date('"+obj.getCheck_range_start()+"','yyyy/mm/dd') AND end_dt >= To_Date('"+obj.getCheck_range_start()+" 2359','yyyy/mm/dd hh24mi')) " +
	        	  " OR (str_dt <= To_Date('"+obj.getCheck_range_final_end()+"','yyyy/mm/dd') AND end_dt >= To_Date('"+obj.getCheck_range_final_end()+" 2359','yyyy/mm/dd hh24mi'))) " +	        	  
	        	  " ) ORDER BY str_dt desc ";	
//System.out.println(sql);
			rs = stmt.executeQuery(sql);
			
			while (rs.next())
			{//請假記錄
			    absentSAL.add(rs.getString("str_dt"));
			    absentEAL.add(rs.getString("end_dt"));
			    absentCodeAL.add(rs.getString("duty_cd"));
			}
			rs.close();
	        
			sql = " SELECT To_Char(To_Date('"+obj.getCheck_range_final_end()+"','yyyy/mm/dd'),'yyyy/mm/dd') str_dt, " +
	        	  " To_Char(To_Date('"+obj.getCheck_range_final_end()+"','yyyy/mm/dd'),'yyyy/mm/dd') end_dt, " +
	        	  " 'ED' duty_cd FROM dual ";
	
//System.out.println(sql);
			rs = stmt.executeQuery(sql);
			
			while (rs.next())
			{//請假記錄
			    absentSAL.add(rs.getString("str_dt"));
			    absentEAL.add(rs.getString("end_dt"));
			    absentCodeAL.add(rs.getString("duty_cd"));
			}
			rs.close();			
			
			//有請假記錄並包含sysdate and latest date
			if(absentSAL.size()>0)
			{
			    for(int i=0; i<absentSAL.size()-1; i++)
			    {
			        //計算working days, 二端點皆不計算
			        int sect_susp_days=0;
			        GregorianCalendar calsd = new GregorianCalendar();
				    calsd.set(Calendar.YEAR,Integer.parseInt(((String)absentSAL.get(i)).substring(0,4)));
				    calsd.set(Calendar.MONTH,Integer.parseInt(((String)absentSAL.get(i)).substring(5,7))-1);
				    calsd.set(Calendar.DATE,Integer.parseInt(((String)absentSAL.get(i)).substring(8,10)));
				    
				    GregorianCalendar caled = new GregorianCalendar();
				    caled.set(Calendar.YEAR,Integer.parseInt(((String)absentEAL.get(i+1)).substring(0,4)));
				    caled.set(Calendar.MONTH,Integer.parseInt(((String)absentEAL.get(i+1)).substring(5,7))-1);
				    caled.set(Calendar.DATE,Integer.parseInt(((String)absentEAL.get(i+1)).substring(8,10)));
				    
				    int days = (int)getDiffDays(calsd, caled)-1;
				    
//System.out.println(df.format(caled.getTime())+" >> "+df.format(calsd.getTime())+" >> "+ ((int)getDiffDays(calsd, caled)-1));

					if(days>=365)
					{//可能全勸才考慮留停記錄
				        //count suspend days in the period		
					    sql = " SELECT Nvl(sum(sedate-ssdate),0) suspd FROM ( " +
					    	  " SELECT " +
					    	  " CASE WHEN ssdate < To_Date('"+((String)absentEAL.get(i+1))+"','yyyy/mm/dd') " +
					    	  " THEN To_Date('"+((String)absentEAL.get(i+1))+"','yyyy/mm/dd') ELSE ssdate END ssdate, " +
					    	  " CASE WHEN recurdate >To_Date('"+((String)absentSAL.get(i))+"','yyyy/mm/dd') " +
					    	  " THEN To_Date('"+((String)absentSAL.get(i))+"','yyyy/mm/dd') ELSE (recurdate-1) END sedate " +
					    	  " FROM egtsusp  WHERE empn = '"+empno+"' AND recurdate IS NOT NULL  " +
					    	  " AND (To_Date('"+((String)absentEAL.get(i+1))+"','yyyy/mm/dd') < recurdate " +
					    	  " AND To_Date('"+((String)absentSAL.get(i))+"','yyyy/mm/dd') >= recurdate )) ";
//System.out.println(sql);
				        rs = stmt.executeQuery(sql);
			
				        if (rs.next())
				        {
				            sect_susp_days = rs.getInt("suspd");
				        }
				        rs.close();
					}
					
			        //actual working days between sl~sl
				    days = days - sect_susp_days;
//System.out.println("suspdays = "+sect_susp_days+"  working days = "+days);
				    
				    if(days>=730)
				    {					       
				       if(sect_susp_days>0)
				       {//有留停記錄	
//System.out.println("Here here>= 730   sect_susp_days>0 ");	
				           FullAttendanceForPickSkjObj faobj1 = new FullAttendanceForPickSkjObj();
				           FullAttendanceForPickSkjObj faobj2 = new FullAttendanceForPickSkjObj();
					       ArrayList suspSAL = new ArrayList();
					       ArrayList suspEAL = new ArrayList();
					       ArrayList suspDAL = new ArrayList();					           
		           
					       String comments = "";					       
					       sql =  " select To_Char(ssdate,'yyyy/mm/dd') ssdate, To_Char(sedate-1,'yyyy/mm/dd') sedate , " +
					       	   // " (sedate-ssdate-1) susdays from ( " +
					       		  " (sedate-ssdate) susdays from ( " +
					       		  " SELECT CASE WHEN ssdate < To_Date('"+((String)absentEAL.get(i+1))+"','yyyy/mm/dd') " +
					    	  	  " THEN To_Date('"+((String)absentEAL.get(i+1))+"','yyyy/mm/dd') ELSE ssdate END ssdate, " +
					    	      " CASE WHEN recurdate >To_Date('"+((String)absentSAL.get(i))+"','yyyy/mm/dd') " +
					    	      " THEN To_Date('"+((String)absentSAL.get(i))+"','yyyy/mm/dd') ELSE (recurdate-1) END sedate " +
					       		  " FROM egtsusp " +
					        	  " WHERE empn = '"+empno+"'  AND recurdate IS NOT NULL " +
					        	  " AND (To_Date('"+((String)absentEAL.get(i+1))+"','yyyy/mm/dd') < recurdate " +
					    	      " AND To_Date('"+((String)absentSAL.get(i))+"','yyyy/mm/dd') >= recurdate )) order by ssdate asc ";
//System.out.println(sql);
					       rs = stmt.executeQuery(sql);
							
							while (rs.next())
							{
							    String suss = rs.getString("ssdate");
							    String suse = rs.getString("sedate");		
							    String susd = rs.getString("susdays");	
							    suspSAL.add(suss);
							    suspEAL.add(suse);
							    suspDAL.add(susd);
//								comments = comments+" " + suss +" ~ "+ suse + " >> "+susd +" days<br>";								  
							}//while (rs.next())	
								
							//***************************************************************	
							faobj1.setCheck_range_final_end(((String)absentEAL.get(i+1)));
							faobj1.setTemp_working_date_start(((String)absentEAL.get(i+1)));
							int fulldays = 730;
							GregorianCalendar firstcal = new GregorianCalendar();
							firstcal.set(Calendar.YEAR,Integer.parseInt(((String)absentEAL.get(i+1)).substring(0,4)));
							firstcal.set(Calendar.MONTH,Integer.parseInt(((String)absentEAL.get(i+1)).substring(5,7))-1);
							firstcal.set(Calendar.DATE,Integer.parseInt(((String)absentEAL.get(i+1)).substring(8,10)));
//System.out.println("((String)absentEAL.get(i+1))  >> "+((String)absentEAL.get(i+1)));		
//System.out.println("firstcal  >> "+df.format(firstcal.getTime()));		

							boolean second = false;
							int daysleft =0;
							boolean secondfirst = true;
							GregorianCalendar secondcal = new GregorianCalendar();
							for(int j=0; j<suspSAL.size();j++)
							{							   
							    if (fulldays>0)
							    {							        
							        if(second == false)
							        {
								        if(j>0)
								        {
											faobj1.setTemp_working_date_start(((String)suspEAL.get(j-1)));
								        }
								        faobj1.setTemp_working_date_end(((String)suspSAL.get(j)));
								        
									    GregorianCalendar comparecals = new GregorianCalendar();
									    comparecals.set(Calendar.YEAR,Integer.parseInt(faobj1.getTemp_working_date_start().substring(0,4)));
									    comparecals.set(Calendar.MONTH,Integer.parseInt(faobj1.getTemp_working_date_start().substring(5,7))-1);
									    comparecals.set(Calendar.DATE,Integer.parseInt(faobj1.getTemp_working_date_start().substring(8,10)));
									    
									    GregorianCalendar comparecale = new GregorianCalendar();
									    comparecale.set(Calendar.YEAR,Integer.parseInt(faobj1.getTemp_working_date_end().substring(0,4)));
									    comparecale.set(Calendar.MONTH,Integer.parseInt(faobj1.getTemp_working_date_end().substring(5,7))-1);
									    comparecale.set(Calendar.DATE,Integer.parseInt(faobj1.getTemp_working_date_end().substring(8,10)));
									    
									    int diff = (int)getDiffDays(comparecale, comparecals);//working days
//System.out.println("comparecals >> "+df.format(comparecals.getTime())+" comparecale >> "+df.format(comparecale.getTime())+ " diff >>" + diff );
									    fulldays = fulldays - diff;
									    if(fulldays>365)
									    {									        
									        firstcal.add(Calendar.DATE, diff+Integer.parseInt(suspDAL.get(j).toString()));
									        comments = comments+" " + ((String)suspSAL.get(j)) +" ~ "+ ((String)suspEAL.get(j)) + " >> "+((String)suspDAL.get(j)) +" days (留停)<br>";									    	
									        suspDAL.set(j,"0");
									        //in case just one suspend period 
									        if((j+1) == suspSAL.size())
									        {
									            if(fulldays>365)
												{
												    firstcal.add(Calendar.DATE, fulldays-365);													   
												}
									            faobj1.setCheck_range_start(df.format(firstcal.getTime()));
									            faobj1.setComments(comments);
									            faobj1.setEmpno(empno);
									            objAL.add(faobj1);		
									            //add****************************
//System.out.println("df.format(firstcal.getTime()) " + df.format(firstcal.getTime()));									            
    								            firstcal.add(Calendar.DATE,+1);
//System.out.println("df.format(firstcal.getTime()) " + df.format(firstcal.getTime()));		
												//*******************************
												//faobj2.setCheck_range_final_end(faobj1.getCheck_range_start());
												faobj2.setCheck_range_final_end(df.format(firstcal.getTime()));
												//faobj2.setTemp_working_date_start(faobj1.getCheck_range_start());	    
												faobj2.setTemp_working_date_start(df.format(firstcal.getTime()));
									            fulldays = 365;
									            second = true;
									        }
									    }
									    else
									    {//fulldays<=365
									        firstcal.add(Calendar.DATE, diff+(fulldays-365));										    	
										    daysleft = 365-fulldays;
//System.out.println("daysleft >> "+daysleft);										    
										    faobj1.setCheck_range_start(df.format(firstcal.getTime()));
								            faobj1.setComments(comments);
								            faobj1.setEmpno(empno);
								            objAL.add(faobj1);
								            //add****************************
//System.out.println("df.format(firstcal.getTime()) " + df.format(firstcal.getTime()));									            
								            firstcal.add(Calendar.DATE,+1);
//System.out.println("df.format(firstcal.getTime()) " + df.format(firstcal.getTime()));								            
								            //*******************************
//								            faobj2.setCheck_range_final_end(faobj1.getCheck_range_start());
								            faobj2.setCheck_range_final_end(df.format(firstcal.getTime()));
//								            faobj2.setTemp_working_date_start(faobj1.getCheck_range_start());	    
								            faobj2.setTemp_working_date_start(df.format(firstcal.getTime()));	
								            fulldays = 365;
									        second = true;
									    }			
							        }				
//System.out.println("faobj2.getCheck_range_final_end " + faobj2.getCheck_range_final_end());
//System.out.println("faobj2.getTemp_working_date_start " + faobj2.getTemp_working_date_start());							        
							        
							        comments = "";
									if(second == true)
									{			
										if(secondfirst == false)
								        {
//System.out.println("secondfirst == false");
											faobj2.setTemp_working_date_start(((String)suspEAL.get(j-1)));
								        }
										secondfirst = false;										
								        faobj2.setTemp_working_date_end(((String)suspSAL.get(j)));									        
//System.out.println(faobj2.getTemp_working_date_start());
//System.out.println(faobj2.getTemp_working_date_end());	
//System.out.println(df.format(secondcal.getTime()));	
										secondcal.set(Calendar.YEAR,Integer.parseInt(faobj2.getTemp_working_date_start().substring(0,4)));
										secondcal.set(Calendar.MONTH,Integer.parseInt(faobj2.getTemp_working_date_start().substring(5,7))-1);
										secondcal.set(Calendar.DATE,Integer.parseInt(faobj2.getTemp_working_date_start().substring(8,10)));									   
										 									    
									    GregorianCalendar comparecals = new GregorianCalendar();
									    comparecals.set(Calendar.YEAR,Integer.parseInt(faobj2.getTemp_working_date_start().substring(0,4)));
									    comparecals.set(Calendar.MONTH,Integer.parseInt(faobj2.getTemp_working_date_start().substring(5,7))-1);
									    comparecals.set(Calendar.DATE,Integer.parseInt(faobj2.getTemp_working_date_start().substring(8,10)));
									    
									    GregorianCalendar comparecale = new GregorianCalendar();
									    comparecale.set(Calendar.YEAR,Integer.parseInt(faobj2.getTemp_working_date_end().substring(0,4)));
									    comparecale.set(Calendar.MONTH,Integer.parseInt(faobj2.getTemp_working_date_end().substring(5,7))-1);
									    comparecale.set(Calendar.DATE,Integer.parseInt(faobj2.getTemp_working_date_end().substring(8,10)));
									  
   								        int diff = (int)getDiffDays(comparecale, comparecals);//working days
//System.out.println("comparecals >> "+df.format(comparecals.getTime())+" comparecale >> "+df.format(comparecale.getTime())+ " diff >>" + diff );
									    fulldays = fulldays - diff;
									    if(fulldays>0)
									    {
//									        comments = comments+" " + ((String)suspSAL.get(j)) +" ~ "+ ((String)suspEAL.get(j)) + " >> "+((String)suspDAL.get(j)) +" days (留停)<br>";
									        secondcal.add(Calendar.DATE, diff+Integer.parseInt(suspDAL.get(j).toString()));
									        if(Integer.parseInt(suspDAL.get(j).toString()) > 0)
									        {    
									            comments = comments+" " + ((String)suspSAL.get(j)) +" ~ "+ ((String)suspEAL.get(j)) + " >> "+((String)suspDAL.get(j)) +" days (留停)<br>";
									        }
									    }
									    else
									    {
									        secondcal.add(Calendar.DATE, diff+fulldays);	
									    }
//System.out.println("ori second >> "+df.format(secondcal.getTime()));										    
									}//if(second == true)
//System.out.println("fulldays left >> "+fulldays);		
							    }//if(fulldays >0)				
							}//for(int j=0; j<suspSAL.size();j++)	
							
							if(fulldays>0)
							{
							    secondcal.add(Calendar.DATE, fulldays);		    
							}
							faobj2.setCheck_range_start(df.format(secondcal.getTime()));
//System.out.println("getCheck_range_start >> "+faobj2.getCheck_range_start());							
				            faobj2.setComments(comments);
				            faobj2.setEmpno(empno);
				            objAL.add(faobj2);										
					    }//if(sect_susp_days>0)
				        else
				        {//無留停記錄
//System.out.println("Here here>= 730   sect_susp_days==0 ");		
							FullAttendanceForPickSkjObj faobj1 = new FullAttendanceForPickSkjObj();
							FullAttendanceForPickSkjObj faobj2 = new FullAttendanceForPickSkjObj();
				            GregorianCalendar twicecal = new GregorianCalendar();
				            twicecal.set(Calendar.YEAR,Integer.parseInt(obj.getCheck_range_final_end().substring(0,4)));
				            twicecal.set(Calendar.MONTH,Integer.parseInt(obj.getCheck_range_final_end().substring(5,7))-1);
				            twicecal.set(Calendar.DATE,Integer.parseInt(obj.getCheck_range_final_end().substring(8,10)));
				            twicecal.add(Calendar.DATE, +364);  
						    
				            faobj1.setCheck_range_final_end(obj.getCheck_range_final_end());
				            faobj1.setCheck_range_start(df.format(twicecal.getTime()));
				            faobj1.setComments("");
				            faobj1.setEmpno(empno);
				            objAL.add(faobj1);		
				            
				            twicecal.add(Calendar.DATE, +1);  				            
				            faobj2.setCheck_range_final_end(df.format(twicecal.getTime()));
				            faobj2.setCheck_range_start(obj.getCheck_range_start());
				            faobj2.setComments("");
				            faobj2.setEmpno(empno);
				            objAL.add(faobj2);			
				        }
				        //****************************************************************************
				    }
				    else if (days >= 365)
				    {

				       FullAttendanceForPickSkjObj faobj = new FullAttendanceForPickSkjObj();
				       ArrayList suspSAL = new ArrayList();
				       ArrayList suspEAL = new ArrayList();
				       ArrayList suspDAL = new ArrayList();
				       if(sect_susp_days>0)
				       {//有留停記錄		
// System.out.println("Here here>= 365   sect_susp_days>0 ");				           
					       String comments = "";//					       
					       sql =  " select To_Char(ssdate,'yyyy/mm/dd') ssdate, To_Char(sedate-1,'yyyy/mm/dd') sedate , " +
//					       		  " (sedate-ssdate-1) susdays from ( " +
					       		  " (sedate-ssdate) susdays from ( " +
					       		  " SELECT CASE WHEN ssdate < To_Date('"+((String)absentEAL.get(i+1))+"','yyyy/mm/dd') " +
					    	  	  " THEN To_Date('"+((String)absentEAL.get(i+1))+"','yyyy/mm/dd') ELSE ssdate END ssdate, " +
					    	      " CASE WHEN recurdate >To_Date('"+((String)absentSAL.get(i))+"','yyyy/mm/dd') " +
					    	      " THEN To_Date('"+((String)absentSAL.get(i))+"','yyyy/mm/dd') ELSE (recurdate-1) END sedate " +
					       		  " FROM egtsusp " +
					        	  " WHERE empn = '"+empno+"'  AND recurdate IS NOT NULL " +
					        	  " AND (To_Date('"+((String)absentEAL.get(i+1))+"','yyyy/mm/dd') < recurdate " +
					    	      " AND To_Date('"+((String)absentSAL.get(i))+"','yyyy/mm/dd') >= recurdate )) order by ssdate asc ";
//System.out.println(sql);
					        rs = stmt.executeQuery(sql);
							
							while (rs.next())
							{
							    String suss = rs.getString("ssdate");
							    String suse = rs.getString("sedate");		
							    String susd = rs.getString("susdays");	
							    suspSAL.add(suss);
							    suspEAL.add(suse);
							    suspDAL.add(susd);
//								comments = comments+" " + suss +" ~ "+ suse + " >> "+susd +" days<br>";								  
							}//while (rs.next())	
							
							//***************************************************************	
							faobj.setCheck_range_final_end(((String)absentEAL.get(i+1)));
							faobj.setTemp_working_date_start(((String)absentEAL.get(i+1)));
							int fulldays = 365;
							GregorianCalendar oncecal = new GregorianCalendar();
							oncecal.set(Calendar.YEAR,Integer.parseInt(((String)absentEAL.get(i+1)).substring(0,4)));
							oncecal.set(Calendar.MONTH,Integer.parseInt(((String)absentEAL.get(i+1)).substring(5,7))-1);
							oncecal.set(Calendar.DATE,Integer.parseInt(((String)absentEAL.get(i+1)).substring(8,10)));
//System.out.println("((String)absentEAL.get(i+1))  >> "+((String)absentEAL.get(i+1)));		
//System.out.println("oncecal  >> "+df.format(oncecal.getTime()));								
							for(int j=0; j<suspSAL.size();j++)
							{							   
							    if (fulldays>0)
							    {
							        if(j>0)
							        {
										faobj.setTemp_working_date_start(((String)suspEAL.get(j-1)));
							        }
							        faobj.setTemp_working_date_end(((String)suspSAL.get(j)));
							        
								    GregorianCalendar comparecals = new GregorianCalendar();
								    comparecals.set(Calendar.YEAR,Integer.parseInt(faobj.getTemp_working_date_start().substring(0,4)));
								    comparecals.set(Calendar.MONTH,Integer.parseInt(faobj.getTemp_working_date_start().substring(5,7))-1);
								    comparecals.set(Calendar.DATE,Integer.parseInt(faobj.getTemp_working_date_start().substring(8,10)));
								    
								    GregorianCalendar comparecale = new GregorianCalendar();
								    comparecale.set(Calendar.YEAR,Integer.parseInt(faobj.getTemp_working_date_end().substring(0,4)));
								    comparecale.set(Calendar.MONTH,Integer.parseInt(faobj.getTemp_working_date_end().substring(5,7))-1);
								    comparecale.set(Calendar.DATE,Integer.parseInt(faobj.getTemp_working_date_end().substring(8,10)));
								    
								    int diff = (int)getDiffDays(comparecale, comparecals);//working days
//System.out.println("comparecals >> "+df.format(comparecals.getTime())+" comparecale >> "+df.format(comparecale.getTime())+ " diff >>" + diff );
								    fulldays = fulldays - diff;
								    if(fulldays>0)
								    {
								        oncecal.add(Calendar.DATE, diff+Integer.parseInt(suspDAL.get(j).toString()));
								        comments = comments+" " + ((String)suspSAL.get(j)) +" ~ "+ ((String)suspEAL.get(j)) + " >> "+((String)suspDAL.get(j)) +" days (留停)<br>";
								    }
								    else
								    {
								        oncecal.add(Calendar.DATE, diff+fulldays);			
								    }
//System.out.println("fulldays left >> "+fulldays);								    
							    }				
							}//for(int j=0; j<suspSAL.size();j++)
							
							if(fulldays>0)
							{
							    oncecal.add(Calendar.DATE, fulldays);		    
							}
							faobj.setCheck_range_start(df.format(oncecal.getTime()));
				            faobj.setComments(comments);
				            faobj.setEmpno(empno);
				            objAL.add(faobj);	
				        }//if(sect_susp_days>0)
				        else
				        {//無留停記錄
//System.out.println("Here here>= 365   sect_susp_days==0 ");						            
				            GregorianCalendar twicecal = new GregorianCalendar();
				            twicecal.set(Calendar.YEAR,Integer.parseInt(((String)absentEAL.get(i+1)).substring(0,4)));
				            twicecal.set(Calendar.MONTH,Integer.parseInt(((String)absentEAL.get(i+1)).substring(5,7))-1);
				            twicecal.set(Calendar.DATE,Integer.parseInt(((String)absentEAL.get(i+1)).substring(8,10)));
				            //the point is leave date 
				            twicecal.add(Calendar.DATE, +1);  
				            faobj.setCheck_range_final_end(df.format(twicecal.getTime()));
//System.out.println(df.format(twicecal.getTime()));
//				            twicecal.add(Calendar.DATE, +365); 
							twicecal.add(Calendar.DATE, +364);
				            faobj.setCheck_range_start(df.format(twicecal.getTime()));
				            faobj.setComments("");
				            faobj.setEmpno(empno);
				            objAL.add(faobj);	
				        }
				        //****************************************************************************				    			       
				    }//else if (days >= 365)			    
			    }//for(int i=0; i<absentSAL.size()-1; i++)
			}//if(absentSAL.size()>0)		
			
		} 
		catch (Exception e) 
		{
		    System.out.println(e.toString());
			return objAL;
		} 
		finally 
		{
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (stmt != null)
				try 
				{
					stmt.close();
				} catch (SQLException e) {}		
			if (conn != null)
				try {
	//			    System.out.println("conn close ");
					conn.close();
				} catch (SQLException e) {}
		}
	    return objAL;
	}
	
	public void getCheckRange2() 
	{	
	    //先取得上次申請之結束日期(latestdate),並計算到今天的天數(gap_days)
	    //if(gap_days)<=730天,則由(latestdate+1)的日期往後推
	    //if(gap_days)>730天,則取得留停天數(susp_days),Then (gap_days-susp_days)
	    //if(gap_days-susp_days) <=730天,則由(latestdate+1)的日期往後推
	    //if(gap_days-susp_days) >730天,則由sysdate的日期前推
	    //if latestdate is null,則由sysdate的日期前推 	  
	    Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;		
		String sql = "";
		String indate = "";
		String aircrewdate = "2006/05/01";
	    boolean getCdate = false;
	    int gap_days = 0;
	    //**************************************************
	    //Set inital check range 
	    Calendar cal = new GregorianCalendar();	    
	    //get sysdate
//	    df.format(cal.getTime());
	    //get sysdate-1
//	    cal.add(Calendar.DATE, -1); 
	    //**************************************************	    
		try 
		{
			// connection Pool
		    ConnectionHelper ch = new ConnectionHelper();
	        conn = ch.getConnection();  
	        stmt = conn.createStatement();
	        
	        sql = " SELECT To_Char(indate,'yyyy/mm/dd') indate FROM egtcbas WHERE empn = '"+empno+"'  ";
//System.out.println(sql);
		    rs = stmt.executeQuery(sql);
		    if (rs.next())
			{
		        indate = rs.getString("indate");
			}
		    rs.close();
		    //*********************************************************************************
            sql = " SELECT To_Char(Max(edate)+1,'yyyy/mm/dd') nextstart, Round((SYSDATE - Max(edate)),0) gapdays " +
             	  " FROM egtpick WHERE empno = '"+empno+"' AND reason = '1' AND VALID_IND ='Y'  ";
//System.out.println(sql);
		    rs = stmt.executeQuery(sql);
		    if (rs.next())
			{
		        nextstart = rs.getString("nextstart");	
		        gap_days = rs.getInt("gapdays");
			}
		    rs.close();
		    //********************************************************************************************
		    if(nextstart != null && !"".equals(nextstart))
		    {
		        if(gap_days<=730)
		        {
		            obj.setCheck_range_start(nextstart);
		            obj.setCheck_range_final_end(df.format(cal.getTime()));
		        }
		        else
		        {//gap_days>730	扣除suspend days and no pay leave days	            
		            sql = " SELECT ("+gap_days+" - nvl(Sum(edate-sdate),0)) working_days FROM ( " +
		            	  " SELECT ssdate sdate, recurdate edate FROM egtsusp " +
		            	  " WHERE empn = '"+empno+"' AND ssdate >= To_Date('"+nextstart+"','yyyy/mm/dd') " +
		            	  " AND recurdate < SYSDATE AND recurdate IS NOT NULL " +
		            	  " UNION ALL " +
		            	  " SELECT offsdate sdate, (offedate+1) edate FROM egtoffs " +
		            	  " WHERE offtype IN (9,24)  AND remark = 'Y' AND empn = '"+empno+"' " +
		            	  " AND offsdate >= To_Date('"+nextstart+"','yyyy/mm/dd')  AND offedate < SYSDATE ) ";
//System.out.println(sql);
					rs = stmt.executeQuery(sql);
					
					if (rs.next())
					{
					    if(rs.getInt("working_days")<=730)
					    {
					        obj.setCheck_range_start(nextstart);
					        obj.setCheck_range_final_end(df.format(cal.getTime()));
					    }
					    else //if(rs.getInt("working_days")>730)
					    {//由sysdate往前推					        
					        obj.setCheck_range_start(getLatestDate(getCheckRangeStartDate(df.format(cal.getTime())),aircrewdate,indate));
					        obj.setCheck_range_final_end(df.format(cal.getTime()));//sysdate-1
					    }
			        }    
		        }
		    }
		    else
		    {//由sysdate往前推
		        //沒有第一筆
		        obj.setCheck_range_start(getLatestDate(getCheckRangeStartDate(df.format(cal.getTime())),aircrewdate,indate));
		        obj.setCheck_range_final_end(df.format(cal.getTime()));//sysdate-1
		    } 
//System.out.println("getCheck_range_start = "+obj.getCheck_range_start());		
//System.out.println("getCheck_range_final_end = "+obj.getCheck_range_final_end());	
		} 
		catch (Exception e) 
		{
			System.out.println("A:"+e.toString());
		} 
		finally 
		{
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (stmt != null)
				try 
				{
					stmt.close();
				} catch (SQLException e) {}			
			if (conn != null)
				try {
//				    System.out.println("conn close ");
					conn.close();
				} catch (SQLException e) {}
		}
//System.out.println(fromsysdate);
	}
	
	public void getCheckRange3() 
	{	
	    //先取得上次申請之結束日期(latestdate),並計算到今天的天數(gap_days)
	    //if(gap_days)<=730天,則由(latestdate+1)的日期往後推
	    //if(gap_days)>730天,則取得留停天數(susp_days),Then (gap_days-susp_days)
	    //if(gap_days-susp_days) <=730天,則由(latestdate+1)的日期往後推
	    //if(gap_days-susp_days) >730天,則由sysdate的日期前推
	    //Since 2012/09/01  if(gap_days-susp_days) >730天,則由(latestdate+1)的日期往後推
	    //if latestdate is null,則由sysdate的日期前推 	  
	    //Since if latestdate is null,則由2010/09/01 往後推
	    Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;		
		String sql = "";
		String indate = "";
		String aircrewdate = "2006/05/01";
	    boolean getCdate = false;
	    int gap_days = 0;
	    //**************************************************
	    //Set inital check range 
	    Calendar cal = new GregorianCalendar();	    
	    //get sysdate
//	    df.format(cal.getTime());
	    //get sysdate-1
//	    cal.add(Calendar.DATE, -1); 
	    //**************************************************	    
		try 
		{
			// connection Pool
		    ConnectionHelper ch = new ConnectionHelper();
	        conn = ch.getConnection();  
	        stmt = conn.createStatement();
	        
	        sql = " SELECT To_Char(indate,'yyyy/mm/dd') indate FROM egtcbas WHERE empn = '"+empno+"'  ";
//System.out.println(sql);
		    rs = stmt.executeQuery(sql);
		    if (rs.next())
			{
		        indate = rs.getString("indate");
			}
		    rs.close();
		    //*********************************************************************************	    
		
	        sql = " SELECT To_Char(case when to_date('"+dateline2+"','yyyy/mm/dd') >= Max(edate)+1 " +
	        	  " then to_date('"+dateline2+"','yyyy/mm/dd') else Max(edate)+1 end,'yyyy/mm/dd') nextstart, " +
	        	  " Round((SYSDATE - case when to_date('"+dateline2+"','yyyy/mm/dd') >= Max(edate)+1 " +
	        	  " then to_date('"+dateline2+"','yyyy/mm/dd') else Max(edate)+1 end),0) gapdays " +
       	  		  " FROM egtpick WHERE empno = '"+empno+"' AND reason = '1' AND VALID_IND ='Y'  ";	
//System.out.println(sql);	        

		    rs = stmt.executeQuery(sql);
		    if (rs.next())
			{
		        nextstart = rs.getString("nextstart");	
		        gap_days = rs.getInt("gapdays")-1;
			}
		    rs.close();
		    
//System.out.println("nextstart = "+nextstart);		  
//System.out.println("gap_days = "+gap_days);	
		    //********************************************************************************************	
		    if(nextstart != null && !"".equals(nextstart))
		    {
		        obj.setCheck_range_start(nextstart);
	            obj.setCheck_range_final_end(df.format(cal.getTime()));		
		         //remark  in 2012/10/02  
//	            obj.setCheck_range_start(getLatestDate(getCheckRangeStartDate(df.format(cal.getTime()),gap_days),aircrewdate,indate));
//		        obj.setCheck_range_final_end(df.format(cal.getTime()));//sysdate-1
		    }
		    else
		    {
		        //沒有第一筆	        
		        obj.setCheck_range_start(getLatestDate(getCheckRangeStartDate(df.format(cal.getTime()),gap_days),aircrewdate,indate));
		        obj.setCheck_range_final_end(df.format(cal.getTime()));//sysdate-1
		    } 
//System.out.println("getCheck_range_start = "+obj.getCheck_range_start());		
//System.out.println("getCheck_range_final_end = "+obj.getCheck_range_final_end());	
		} 
		catch (Exception e) 
		{
			System.out.println("A:"+e.toString());
		} 
		finally 
		{
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (stmt != null)
				try 
				{
					stmt.close();
				} catch (SQLException e) {}			
			if (conn != null)
				try {
//				    System.out.println("conn close ");
					conn.close();
				} catch (SQLException e) {}
		}
//System.out.println(fromsysdate);
	}

	
	
	private String getCheckRangeStartDate(String range_end_date)
	{
	    String range_start_date = "";
	    ArrayList nocntSD = new ArrayList();
	    ArrayList nocntED = new ArrayList();
	    ArrayList nocntDAY = new ArrayList();
	    
	    Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;	
		String sql = "";
		
		try 
		{
			// connection Pool
	        ConnectionHelper ch = new ConnectionHelper();
	        conn = ch.getConnection();  
	        stmt = conn.createStatement();
	        
	        //*********************************************************************************
	        //GET suspend date and no pay leave
	        if(nextstart != null && !"".equals(nextstart))
	        {
		        sql = " SELECT * FROM ( " +
		        	  " SELECT to_char(ssdate,'yyyy/mm/dd') sdate, to_char(recurdate,'yyyy/mm/dd') edate, (recurdate-ssdate) suspdays FROM egtsusp " +
	            	  " WHERE empn = '"+empno+"' AND ssdate >= To_Date('"+nextstart+"','yyyy/mm/dd') " +
	            	  " AND recurdate < SYSDATE AND recurdate IS NOT NULL " +
	            	  " UNION ALL " +
	            	  " SELECT to_char(offsdate,'yyyy/mm/dd') sdate, to_char((offedate+1),'yyyy/mm/dd') edate, ((offedate+1)-offsdate) suspdays FROM egtoffs " +
	            	  " WHERE offtype IN (9,24)  AND remark = 'Y' AND empn = '"+empno+"' " +
	            	  " AND offsdate >= To_Date('"+nextstart+"','yyyy/mm/dd')  AND offedate < SYSDATE" +
	            	  " ) ORDER BY sdate desc";
	        }
	        else
	        {
	            sql = " SELECT * FROM ( " +
	                  " SELECT to_char(ssdate,'yyyy/mm/dd') sdate, to_char(recurdate,'yyyy/mm/dd') edate, (recurdate-ssdate) suspdays FROM egtsusp " +
		          	  " WHERE empn = '"+empno+"' AND recurdate < SYSDATE AND recurdate IS NOT NULL " +
		          	  " UNION ALL " +
		          	  " SELECT to_char(offsdate,'yyyy/mm/dd') sdate, to_char((offedate+1),'yyyy/mm/dd') edate, ((offedate+1)-offsdate) suspdays FROM egtoffs " +
		          	  " WHERE offtype IN (9,24)  AND remark = 'Y' AND empn = '"+empno+"' " +
		          	  " AND offedate < SYSDATE " +
		          	  " ) ORDER BY sdate desc";	        
	        }
//System.out.println(sql);
			rs = stmt.executeQuery(sql);
			
			while (rs.next())
			{
			    nocntSD.add(rs.getString("sdate"));
			    nocntED.add(rs.getString("edate"));
			    nocntDAY.add(rs.getString("suspdays"));
			}
			rs.close();
			
			int accudays = 0;
			int working730days = 730;
			
		    Calendar cal = new GregorianCalendar();	 
		    Calendar cal2 = new GregorianCalendar();//the end date of suspend or nopay 	 
		    cal.set(Calendar.YEAR,Integer.parseInt(range_end_date.substring(0,4)));
		    cal.set(Calendar.MONTH,Integer.parseInt(range_end_date.substring(5,7))-1);
		    cal.set(Calendar.DATE,Integer.parseInt(range_end_date.substring(8,10)));
//System.out.print("cal = "+df.format(cal.getTime()) +" ~ ");		    

		    for(int c=0; c<nocntSD.size(); c++)
		    {//suspend or np period
		        //get the working days from range_end_date to first period end date of suspend or nopay
		        cal2.set(Calendar.YEAR,Integer.parseInt(((String)nocntED.get(c)).substring(0,4)));
			    cal2.set(Calendar.MONTH,Integer.parseInt(((String)nocntED.get(c)).substring(5,7))-1);
			    cal2.set(Calendar.DATE,Integer.parseInt(((String)nocntED.get(c)).substring(8,10)));
		        int workingday = (int) getDiffDays(cal, cal2);//working days
//System.out.print("cal2 = "+df.format(cal2.getTime())+"  workingday = "+workingday+" ***** ");		  
				working730days = working730days - workingday;

//System.out.println("working730days = "+working730days+"  suspdays = "+(String)nocntDAY.get(c)+" ***** ");						
				if(working730days <= 0)
				{
				    accudays = accudays + workingday + working730days;	
				    break;
				}
				else
				{//working730days > 0
				    accudays = accudays + workingday + Integer.parseInt((String)nocntDAY.get(c));			    
				    cal.set(Calendar.YEAR,Integer.parseInt(((String)nocntSD.get(c)).substring(0,4)));
				    cal.set(Calendar.MONTH,Integer.parseInt(((String)nocntSD.get(c)).substring(5,7))-1);
				    cal.set(Calendar.DATE,Integer.parseInt(((String)nocntSD.get(c)).substring(8,10)));
//System.out.print("cal = "+df.format(cal.getTime()) +" ~ ");							    
				}
		    }	
		    
		    if(working730days > 0)
		    {
		        accudays = accudays + working730days;
		    }
		    
		    //range_end_date - accudays
		    Calendar cal3 = new GregorianCalendar();//the end date of suspend or nopay 	
		    cal3.add(Calendar.DATE, 0-accudays);
		    range_start_date = df.format(cal3.getTime());		    
		} 
		catch (Exception e) 
		{
			System.out.println("A:"+e.toString());
		} 
		finally 
		{
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (stmt != null)
				try 
				{
					stmt.close();
				} catch (SQLException e) {}			
			if (conn != null)
				try {
//				    System.out.println("conn close ");
					conn.close();
				} catch (SQLException e) {}
		}	
		
	    return range_start_date;
	}
	
	private String getCheckRangeStartDate(String range_end_date, int gap_days)
	{
	    String range_start_date = "";
	    ArrayList nocntSD = new ArrayList();
	    ArrayList nocntED = new ArrayList();
	    ArrayList nocntDAY = new ArrayList();
	    
	    Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;	
		String sql = "";
		
		try 
		{
			// connection Pool
	        ConnectionHelper ch = new ConnectionHelper();
	        conn = ch.getConnection();  
	        stmt = conn.createStatement();
	        
	        //*********************************************************************************
	        if(gap_days<=0)
	        {
	            sql = " SELECT Trunc(SYSDATE,'dd') - To_Date('"+dateline2+"','yyyy/mm/dd') c FROM dual ";
//System.out.println(sql);	            
	            rs = stmt.executeQuery(sql);
	            if (rs.next())
	            {
	                gap_days = rs.getInt("c");
	            }	
	            rs.close();
	        }
	        
	        //*********************************************************************************
	        //GET suspend date and no pay leave
	        if(nextstart != null && !"".equals(nextstart))
	        {
		        sql = " SELECT * FROM ( " +
		        	  " SELECT to_char(ssdate,'yyyy/mm/dd') sdate, to_char(recurdate,'yyyy/mm/dd') edate, (recurdate-ssdate) suspdays FROM egtsusp " +
	            	  " WHERE empn = '"+empno+"' AND ssdate >= To_Date('"+nextstart+"','yyyy/mm/dd') " +
	            	  " AND recurdate < SYSDATE AND recurdate IS NOT NULL " +
	            	  " UNION ALL " +
	            	  " SELECT to_char(offsdate,'yyyy/mm/dd') sdate, to_char((offedate+1),'yyyy/mm/dd') edate, ((offedate+1)-offsdate) suspdays FROM egtoffs " +
	            	  " WHERE offtype IN (9,24)  AND remark = 'Y' AND empn = '"+empno+"' " +
	            	  " AND offsdate >= To_Date('"+nextstart+"','yyyy/mm/dd')  AND offedate < SYSDATE" +
	            	  " ) ORDER BY sdate desc";
	        }
	        else
	        {
	            sql = " SELECT * FROM ( " +
	                  " SELECT to_char(ssdate,'yyyy/mm/dd') sdate, to_char(recurdate,'yyyy/mm/dd') edate, (recurdate-ssdate) suspdays FROM egtsusp " +
		          	  " WHERE empn = '"+empno+"' AND recurdate < SYSDATE AND recurdate IS NOT NULL " +
		          	  " UNION ALL " +
		          	  " SELECT to_char(offsdate,'yyyy/mm/dd') sdate, to_char((offedate+1),'yyyy/mm/dd') edate, ((offedate+1)-offsdate) suspdays FROM egtoffs " +
		          	  " WHERE offtype IN (9,24)  AND remark = 'Y' AND empn = '"+empno+"' " +
		          	  " AND offedate < SYSDATE " +
		          	  " ) ORDER BY sdate desc";	  
	        }
//System.out.println(sql);
			rs = stmt.executeQuery(sql);
			
			while (rs.next())
			{
			    nocntSD.add(rs.getString("sdate"));
			    nocntED.add(rs.getString("edate"));
			    nocntDAY.add(rs.getString("suspdays"));
			}
			rs.close();
			
			int accudays = 0;
			int working730days = gap_days;//不限730天
			
		    Calendar cal = new GregorianCalendar();	 
		    Calendar cal2 = new GregorianCalendar();//the end date of suspend or nopay 	 
		    cal.set(Calendar.YEAR,Integer.parseInt(range_end_date.substring(0,4)));
		    cal.set(Calendar.MONTH,Integer.parseInt(range_end_date.substring(5,7))-1);
		    cal.set(Calendar.DATE,Integer.parseInt(range_end_date.substring(8,10)));
		    
//System.out.println("working730days = "+working730days);		
//System.out.println("nocntSD = "+nocntSD.size());	

		    for(int c=0; c<nocntSD.size(); c++)
		    {//suspend or np period
		        //get the working days from range_end_date to first period end date of suspend or nopay
		        cal2.set(Calendar.YEAR,Integer.parseInt(((String)nocntED.get(c)).substring(0,4)));
			    cal2.set(Calendar.MONTH,Integer.parseInt(((String)nocntED.get(c)).substring(5,7))-1);
			    cal2.set(Calendar.DATE,Integer.parseInt(((String)nocntED.get(c)).substring(8,10)));
		        int workingday = (int) getDiffDays(cal, cal2);//working days
//System.out.print("cal2 = "+df.format(cal2.getTime())+"  workingday = "+workingday+" ***** ");		  
				working730days = working730days - workingday;

//System.out.println("working730days = "+working730days+"  suspdays = "+(String)nocntDAY.get(c)+" ***** ");						
				if(working730days <= 0)
				{
				    accudays = accudays + workingday + working730days;	
				    break;
				}
				else
				{//working730days > 0
				    accudays = accudays + workingday + Integer.parseInt((String)nocntDAY.get(c));			    
				    cal.set(Calendar.YEAR,Integer.parseInt(((String)nocntSD.get(c)).substring(0,4)));
				    cal.set(Calendar.MONTH,Integer.parseInt(((String)nocntSD.get(c)).substring(5,7))-1);
				    cal.set(Calendar.DATE,Integer.parseInt(((String)nocntSD.get(c)).substring(8,10)));
//System.out.print("cal = "+df.format(cal.getTime()) +" ~ ");							    
				}
		    }	
		    
		    if(working730days > 0)
		    {
		        accudays = accudays + working730days;
		    }
		    
		    //range_end_date - accudays
		    Calendar cal3 = new GregorianCalendar();//the end date of suspend or nopay 	
		    cal3.add(Calendar.DATE, 0-accudays);
//System.out.println("accudays = "+accudays );			    
		    range_start_date = df.format(cal3.getTime());	
//System.out.println("range_start_date = "+range_start_date +" end~~~~");		    
		} 
		catch (Exception e) 
		{
			System.out.println("A:"+e.toString());
		} 
		finally 
		{
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (stmt != null)
				try 
				{
					stmt.close();
				} catch (SQLException e) {}			
			if (conn != null)
				try {
//				    System.out.println("conn close ");
					conn.close();
				} catch (SQLException e) {}
		}	
		
	    return range_start_date;
	}
	
	public ArrayList getFullAttendanceRange2() 
	{
	    ArrayList absentSAL = new ArrayList();
	    ArrayList absentEAL = new ArrayList();
	    ArrayList absentCodeAL = new ArrayList();
	    Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;	
		String sql = "";
		try 
		{

			// connection Pool
	        ConnectionHelper ch = new ConnectionHelper();
	        conn = ch.getConnection();  
	        stmt = conn.createStatement();
	        
	        //*********************************************************************************
	        //全勤檢核起點
	        sql = " SELECT To_Char(To_Date('"+obj.getCheck_range_start()+"','yyyy/mm/dd')-1,'yyyy/mm/dd') str_dt, " +
		      	  " To_Char(To_Date('"+obj.getCheck_range_start()+"','yyyy/mm/dd')-1,'yyyy/mm/dd') end_dt, " +
		      	  " 'SD' duty_cd FROM dual ";
	        
//System.out.println("全勤檢核起點 "+sql);
			rs = stmt.executeQuery(sql);
			
			while (rs.next())
			{//請假記錄
			    absentSAL.add(rs.getString("str_dt"));
			    absentEAL.add(rs.getString("end_dt"));
			    absentCodeAL.add(rs.getString("duty_cd"));
			}
			rs.close();
	        
			sql = " SELECT * FROM ( " +
	        	  " select To_Char(str_dt,'yyyy/mm/dd') str_dt, To_Char(end_dt,'yyyy/mm/dd') end_dt, duty_cd " +
	        	  " from fzdb.roster_v  " +
	        	  " where ( duty_cd in ('SL','PL','EL','UL','LL','NS','CL','CNCL') " +	        	  
	        	  "  or (duty_cd = 'LA' AND To_Char(end_dt,'hh24mi') = '2359')) " +
	        	  " and delete_ind='N' and staff_num = '"+empno+"' " +
	        	  " AND ( (str_dt >= To_Date('"+obj.getCheck_range_start()+" 0000','yyyy/mm/dd hh24mi') " +
	        	  " AND end_dt <= To_Date('"+obj.getCheck_range_final_end()+" 2359','yyyy/mm/dd hh24mi') ) " +
	        	  " OR (str_dt <= To_Date('"+obj.getCheck_range_final_end()+"','yyyy/mm/dd') AND end_dt >= To_Date('"+obj.getCheck_range_final_end()+" 2359','yyyy/mm/dd hh24mi')) " +
	        	  " OR (str_dt <= To_Date('"+obj.getCheck_range_start()+"','yyyy/mm/dd') AND end_dt >= To_Date('"+obj.getCheck_range_start()+" 2359','yyyy/mm/dd hh24mi'))) " +	        	  
	        	  " ) ORDER BY str_dt asc ";	
//System.out.println(" 請假記錄 = "+sql);
			rs = stmt.executeQuery(sql);
			
			while (rs.next())
			{//請假記錄
			    absentSAL.add(rs.getString("str_dt"));
			    absentEAL.add(rs.getString("end_dt"));
			    absentCodeAL.add(rs.getString("duty_cd"));
			}
			rs.close();
	        
			//Sysdate
			sql = " SELECT To_Char(SYSDATE,'yyyy/mm/dd') str_dt, To_Char(SYSDATE,'yyyy/mm/dd') end_dt, 'ED' duty_cd FROM dual ";
//System.out.println("全勤檢核終點 "+sql);			
			rs = stmt.executeQuery(sql);
			
			while (rs.next())
			{//請假記錄
			    absentSAL.add(rs.getString("str_dt"));
			    absentEAL.add(rs.getString("end_dt"));
			    absentCodeAL.add(rs.getString("duty_cd"));
			}
			rs.close();		
		
			//有請假記錄並包含sysdate and latest date
			if(absentSAL.size()>0)
			{			    
				for(int i=0; i<absentSAL.size()-1; i++)
				{
				    GregorianCalendar calsd = new GregorianCalendar();
				    calsd.set(Calendar.YEAR,Integer.parseInt(((String)absentEAL.get(i)).substring(0,4)));
				    calsd.set(Calendar.MONTH,Integer.parseInt(((String)absentEAL.get(i)).substring(5,7))-1);
				    calsd.set(Calendar.DATE,Integer.parseInt(((String)absentEAL.get(i)).substring(8,10)));
				    
				    GregorianCalendar caled = new GregorianCalendar();
				    caled.set(Calendar.YEAR,Integer.parseInt(((String)absentSAL.get(i+1)).substring(0,4)));
				    caled.set(Calendar.MONTH,Integer.parseInt(((String)absentSAL.get(i+1)).substring(5,7))-1);
				    caled.set(Calendar.DATE,Integer.parseInt(((String)absentSAL.get(i+1)).substring(8,10)));
				//    System.out.println(" range "+ df.format(calsd.getTime())+" ~ "+ df.format(caled.getTime()));
				}			    
			    
			    for(int i=0; i<absentSAL.size()-1; i++)
			    {
			        //計算working days, 二端點皆不計算
			        String comments = "";
			        int accuworkingdays = 0;
			        int npdays =0;
			        String temp_str_date = "";
			        String temp_end_date = (String)absentSAL.get(i+1);
			        
			        ArrayList nocntSD = new ArrayList();
			        ArrayList nocntED = new ArrayList();
			        ArrayList nocntDAY = new ArrayList();
			        ArrayList nocntTP = new ArrayList();
			        
			        GregorianCalendar calsd = new GregorianCalendar();
				    calsd.set(Calendar.YEAR,Integer.parseInt(((String)absentEAL.get(i)).substring(0,4)));
				    calsd.set(Calendar.MONTH,Integer.parseInt(((String)absentEAL.get(i)).substring(5,7))-1);
				    calsd.set(Calendar.DATE,Integer.parseInt(((String)absentEAL.get(i)).substring(8,10)));
				    
				    GregorianCalendar caled = new GregorianCalendar();
				    caled.set(Calendar.YEAR,Integer.parseInt(((String)absentSAL.get(i+1)).substring(0,4)));
				    caled.set(Calendar.MONTH,Integer.parseInt(((String)absentSAL.get(i+1)).substring(5,7))-1);
				    caled.set(Calendar.DATE,Integer.parseInt(((String)absentSAL.get(i+1)).substring(8,10)));
				    
				    int days = (int)getDiffDays(caled,calsd)+1;
//System.out.println("days  "+days);				    
				    
//System.out.println(df.format(calsd.getTime())+" >> "+df.format(caled.getTime())+" >> "+ ((int)getDiffDays(caled,calsd)+1));
				    
					while(days>364)
				    {
//System.out.println("new faobj ");					    
						FullAttendanceForPickSkjObj faobj = new FullAttendanceForPickSkjObj();	
						nocntSD.clear();
				        nocntED.clear();
				        nocntDAY.clear();
				        nocntTP.clear();
						if("".equals(temp_str_date))
						{
						    calsd.add(Calendar.DATE,1);
						    faobj.setCheck_range_start(df.format(calsd.getTime()));
//						    faobj.setCheck_range_start((String)absentEAL.get(i));
						    faobj.setCheck_range_final_end(temp_end_date);
						}
						else
						{
						    faobj.setCheck_range_start(temp_str_date);
						    faobj.setCheck_range_final_end(temp_end_date);
						} 	
						
//System.out.println("faobj.getCheck_range_start "+faobj.getCheck_range_start());			
//System.out.println("faobj.getCheck_range_final_end "+faobj.getCheck_range_final_end());		
						
						//*****************************************************************
			            //計算該區間的留停天數
				        sql = " SELECT * FROM ( " +
				        	  " SELECT to_char(ssdate,'yyyy/mm/dd') sdate, to_char(recurdate,'yyyy/mm/dd') edate, (recurdate-ssdate) suspdays, 'SP' tp FROM egtsusp " +
				        	  " WHERE empn = '"+empno+"' AND ssdate >= To_Date('"+faobj.getCheck_range_start()+"','yyyy/mm/dd') " +
				        	  " AND recurdate < To_Date('"+faobj.getCheck_range_final_end()+"','yyyy/mm/dd') AND recurdate IS NOT NULL " +
				        	  " UNION ALL " +
				        	  " SELECT to_char(offsdate,'yyyy/mm/dd') sdate, to_char((offedate+1),'yyyy/mm/dd') edate, ((offedate+1)-offsdate) suspdays, 'NP' tp FROM egtoffs " +
				        	  " WHERE offtype IN (9,24)  AND remark = 'Y' AND empn = '"+empno+"' " +
				        	  " AND offsdate >= To_Date('"+faobj.getCheck_range_start()+"','yyyy/mm/dd')  AND offedate <= To_Date('"+faobj.getCheck_range_final_end()+"','yyyy/mm/dd')" +
				        	  " ) ORDER BY sdate asc";
//System.out.println("計算該區間的留停天數  "+sql);
				        rs = stmt.executeQuery(sql);
						while (rs.next())
						{						    
							nocntSD.add(rs.getString("sdate"));
						    nocntED.add(rs.getString("edate"));
						    nocntDAY.add(rs.getString("suspdays"));
						    nocntTP.add(rs.getString("tp"));
						}
						rs.close();
					        
						if(nocntSD.size()>0)
						{//got suspend or no pay records
							faobj.setTemp_working_date_start(faobj.getCheck_range_start());						
						    for(int s=0; s<nocntSD.size(); s++)
						    {
//System.out.println("run nocntAL.size() "+ s);						        
						        faobj.setTemp_working_date_end((String)nocntSD.get(s));
						        GregorianCalendar tempcalsd = new GregorianCalendar();
						        tempcalsd.set(Calendar.YEAR,Integer.parseInt(faobj.getTemp_working_date_start().substring(0,4)));
						        tempcalsd.set(Calendar.MONTH,Integer.parseInt(faobj.getTemp_working_date_start().substring(5,7))-1);
						        tempcalsd.set(Calendar.DATE,Integer.parseInt(faobj.getTemp_working_date_start().substring(8,10)));
							    
							    GregorianCalendar tempcaled = new GregorianCalendar();
							    tempcaled.set(Calendar.YEAR,Integer.parseInt(faobj.getTemp_working_date_end().substring(0,4)));
							    tempcaled.set(Calendar.MONTH,Integer.parseInt(faobj.getTemp_working_date_end().substring(5,7))-1);
							    tempcaled.set(Calendar.DATE,Integer.parseInt(faobj.getTemp_working_date_end().substring(8,10)));
							    
							    int tempworkingdays = (int)getDiffDays(tempcaled,tempcalsd) ;
//							    int tempworkingdays = (int)getDiffDays(tempcaled,tempcalsd) +1;
//System.out.println(df.format(tempcalsd.getTime())+" >> "+df.format(tempcaled.getTime())+" >> "+ tempworkingdays);							    
//System.out.println("accuworkingdays before = "+accuworkingdays);							    
						        accuworkingdays = accuworkingdays + tempworkingdays;
//System.out.println("accuworkingdays after = "+accuworkingdays);						        
						        
						        if(accuworkingdays<365)
						        {//working不足365天
//System.out.println("suspend  and accuworkingdays<365");						            
//System.out.println("initial days = "+ days);	
//System.out.println("suspend days = "+ nocntDAY.get(s));	
						            days = days - tempworkingdays - (Integer.parseInt((String)nocntDAY.get(s)));
//System.out.println("days = "+ days);						            
						            if("NP".equals(((String)nocntTP.get(s)).trim()))
						            {
						                npdays = npdays + (Integer.parseInt((String)nocntDAY.get(s)));
						            }
						            else
						            {
						                GregorianCalendar tempsuspend = new GregorianCalendar();
						                tempsuspend.set(Calendar.YEAR,Integer.parseInt(((String)nocntED.get(s)).substring(0,4)));
						                tempsuspend.set(Calendar.MONTH,Integer.parseInt(((String)nocntED.get(s)).substring(5,7))-1);
						                tempsuspend.set(Calendar.DATE,Integer.parseInt(((String)nocntED.get(s)).substring(8,10)));
						                tempsuspend.add(Calendar.DATE,-1);
						                comments = comments+" " + ((String)nocntSD.get(s)) +" ~ "+ df.format(tempsuspend.getTime()) + " >> "+((String)nocntDAY.get(s)) +" days (留停)<br>";
						            }

						            faobj.setTemp_working_date_start((String)nocntED.get(s));
//System.out.println("faobj.setTemp_working_date_start = "+ nocntED.get(s));							            
								}
						        else
						        {//working 已足365天 over (365-accuworkingdays) 天
//System.out.println("suspend  and accuworkingdays>=365");							            
//System.out.println("days = "+ days);	
//System.out.println("accuworkingdays = "+ accuworkingdays);	
						            days = days - tempworkingdays - (365-accuworkingdays);
//System.out.println("days = "+ days);						            
						            tempcaled.add(Calendar.DATE, (365-accuworkingdays));  
						            faobj.setTemp_working_date_end(df.format(tempcaled.getTime()));
						            faobj.setCheck_range_final_end(faobj.getTemp_working_date_end());
						            faobj.setComments(comments);
						            faobj.setEmpno(empno);						           
						            if(npdays>0)
						            {
						                faobj.setComments(faobj.getComments()+ npdays +" days (無薪休假)<br>");
						            }
						            objAL.add(faobj);
//System.out.println("faobj.getCheck_range_final_end() = "+ faobj.getCheck_range_final_end());						            
						            
							        comments ="";
							        accuworkingdays = 0;
							        npdays =0;
							        tempcaled.add(Calendar.DATE,1);
							        temp_str_date = df.format(tempcaled.getTime());		
//System.out.println("temp_str_date = "+temp_str_date);
//System.out.println("***************************************************************");
							        break;			        
						        }	
//System.out.println("break 2");										        
						    }//for(int s=0; s<nocntSD.size(); s++)		
						    
						    faobj.setTemp_working_date_end(faobj.getCheck_range_final_end());
						    GregorianCalendar tempcalsd = new GregorianCalendar();
					        tempcalsd.set(Calendar.YEAR,Integer.parseInt(faobj.getTemp_working_date_start().substring(0,4)));
					        tempcalsd.set(Calendar.MONTH,Integer.parseInt(faobj.getTemp_working_date_start().substring(5,7))-1);
					        tempcalsd.set(Calendar.DATE,Integer.parseInt(faobj.getTemp_working_date_start().substring(8,10)));
						    
						    GregorianCalendar tempcaled = new GregorianCalendar();
						    tempcaled.set(Calendar.YEAR,Integer.parseInt(faobj.getTemp_working_date_end().substring(0,4)));
						    tempcaled.set(Calendar.MONTH,Integer.parseInt(faobj.getTemp_working_date_end().substring(5,7))-1);
						    tempcaled.set(Calendar.DATE,Integer.parseInt(faobj.getTemp_working_date_end().substring(8,10)));
						    
//						    int tempworkingdays = (int)getDiffDays(tempcaled,tempcalsd);
						    int tempworkingdays = (int)getDiffDays(tempcaled,tempcalsd)+1;
						    
//System.out.println("### "+df.format(tempcalsd.getTime())+" >> "+df.format(tempcaled.getTime())+" >> "+ tempworkingdays);						    
//System.out.println("accuworkingdays before = "+accuworkingdays);						    
						    accuworkingdays = accuworkingdays + tempworkingdays;
//System.out.println("accuworkingdays after = "+accuworkingdays);	

					        if(accuworkingdays<365)
					        {//working不足365天
//System.out.println("suspend >> no suspend  and accuworkingdays<=365");	
//System.out.println("days before = "+ days);	
					            days = days - tempworkingdays;
//System.out.println("days after = "+ days);					           
							}
					        else
					        {//working 已足365天 over (365-accuworkingdays) 天
//System.out.println("suspend >> no suspend  and accuworkingdays>365");	
//System.out.println("days before = "+ days);	
					            days = days - tempworkingdays - (365-accuworkingdays);
//System.out.println("days after = "+ days);						            
					            tempcaled.add(Calendar.DATE, (365-accuworkingdays));  
					            faobj.setTemp_working_date_end(df.format(tempcaled.getTime()));
					            faobj.setCheck_range_final_end(faobj.getTemp_working_date_end());
					            faobj.setComments(comments);
					            faobj.setEmpno(empno);						           
					            if(npdays>0)
					            {
					                faobj.setComments(faobj.getComments()+ npdays +" days (無薪休假)<br>");
					            }
					            objAL.add(faobj);
					            
						        comments ="";
						        accuworkingdays = 0;
						        npdays =0;
						        tempcaled.add(Calendar.DATE,1);
						        temp_str_date = df.format(tempcaled.getTime());		
						        break;
					        }	
//System.out.println("break 3");										    
						}
						else//if(nocntSD.size()>0)
						{//no suspend or no pay records
						    faobj.setTemp_working_date_start(faobj.getCheck_range_start());		
						    faobj.setTemp_working_date_end(faobj.getCheck_range_final_end());
						    
//System.out.println("faobj.getTemp_working_date_start "+faobj.getTemp_working_date_start());	
//System.out.println("faobj.getTemp_working_date_end "+faobj.getTemp_working_date_end());	
						    
					        GregorianCalendar tempcalsd = new GregorianCalendar();
					        tempcalsd.set(Calendar.YEAR,Integer.parseInt(faobj.getTemp_working_date_start().substring(0,4)));
					        tempcalsd.set(Calendar.MONTH,Integer.parseInt(faobj.getTemp_working_date_start().substring(5,7))-1);
					        tempcalsd.set(Calendar.DATE,Integer.parseInt(faobj.getTemp_working_date_start().substring(8,10)));
						    
						    GregorianCalendar tempcaled = new GregorianCalendar();
						    tempcaled.set(Calendar.YEAR,Integer.parseInt(faobj.getTemp_working_date_end().substring(0,4)));
						    tempcaled.set(Calendar.MONTH,Integer.parseInt(faobj.getTemp_working_date_end().substring(5,7))-1);
						    tempcaled.set(Calendar.DATE,Integer.parseInt(faobj.getTemp_working_date_end().substring(8,10)));
						    
//						    int tempworkingdays = (int)getDiffDays(tempcaled,tempcalsd)+1;
						    int tempworkingdays = (int)getDiffDays(tempcaled,tempcalsd);
//System.out.println("tempworkingdays " + tempworkingdays);
						    accuworkingdays = accuworkingdays + tempworkingdays;
//System.out.println("accuworkingdays " + accuworkingdays);						    
					        if(accuworkingdays<365)
					        {//working不足365天
//System.out.println("no suspend  and accuworkingdays<365");						            
					            days = days - tempworkingdays;
							}
					        else
					        {//working 已足365天 over (365-accuworkingdays) 天
//System.out.println("no suspend  and accuworkingdays>=365");

//System.out.println("days " + days);	
//System.out.println("tempworkingdays " + tempworkingdays);
//System.out.println("accuworkingdays " + accuworkingdays);				            
					            days = days - tempworkingdays - (365-accuworkingdays);
					            
//System.out.println("days "+days);					            
					            tempcaled.add(Calendar.DATE, (365-accuworkingdays));  
					            faobj.setTemp_working_date_end(df.format(tempcaled.getTime()));
					            faobj.setCheck_range_final_end(faobj.getTemp_working_date_end());
					            faobj.setEmpno(empno);		
					            objAL.add(faobj);
					            
						        comments ="";
						        accuworkingdays = 0;
						        npdays =0;
						        tempcaled.add(Calendar.DATE,1);
						        temp_str_date = df.format(tempcaled.getTime());		
						        break;
					        }						        
						}
//System.out.println("break 4");										
				    }//while days >=365
			    }//for(int i=0; i<absentSAL.size()-1; i++)
			}//if(absentSAL.size()>0)	
		} 
		catch (Exception e) 
		{
		    //System.out.println(e.toString());
			return objAL;
		} 
		finally 
		{
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (stmt != null)
				try 
				{
					stmt.close();
				} catch (SQLException e) {}		
			if (conn != null)
				try {
	//			    //System.out.println("conn close ");
					conn.close();
				} catch (SQLException e) {}
		}
	    return objAL;
	}
	
}


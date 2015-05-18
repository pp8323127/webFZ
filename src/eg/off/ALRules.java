package eg.off;

import java.sql.*;
import java.text.*;
import java.util.*;

import eg.*;
import eg.GetEmpno;
import ci.db.*;

/**
 * @author cs71 Created on 2007/4/4
 * cs80 2013/01/07
 */
public class ALRules
{   
    private String sql = null;
    private String empno = "";
    private String offsdate = "";
    private String offedate = "";
    private String offtype = "";
    private String userid = "";
    private ALRulesObj obj = new ALRulesObj();

    public static void main(String[] args)
    {
        ALRules ar = new ALRules("633020","0","2013/03/14","2013/03/20","SYS"); 
        System.out.println(ar.isALOverSixDays()); 
//        System.out.println(ar.isBelow30Days());
//        System.out.println(ar.isBirthday());
//        System.out.println(ar.isNotDuplicated());
//        System.out.println(ar.isQuotaAvailable());
//        System.out.println(ar.isALDaysAvailable());
//        System.out.println(ar.isAvailableCancelAL("903150_1"));
        
        System.out.println("Done");
    }
    
    public ALRules (String empno, String offtype, String offsdate, String offedate, String userid)
    {
        this.empno = GetEmpno.getEmpno(empno);
        this.offsdate = offsdate;
        this.offedate = offedate;
        this.userid = userid;
        this.offtype = offtype;
        
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();

//          ******************************************************************************
            //get data from egtalco, egtcbas, hrvegemploy
            sql = " SELECT trim(cbas.empn) empno, cbas.sern sern, cbas.jobno jobno, cbas.station base, " +
            	  " To_Char(cbas.indate,'yyyy/mm/dd') indate, To_Char(aldt.aldate,'yyyy/mm/dd') hraldate, " +
            	  " cbas.status status, cbas.sex sex, Nvl(cbas.specialcode,'-') specialcode, " +
            	  " alco.offday offday, alco.openday openday, alco.opentime opentime, " +
//            	  " CASE WHEN cbas.station='KHH' THEN alco.openday_khh else alco.openday end openday, " +
//            	  " CASE WHEN cbas.station='KHH' THEN alco.opentime_khh ELSE alco.opentime END  opentime, " +
            	  " (to_date('" + offedate + "', 'yyyy/mm/dd') - to_date('"+ offsdate + "', 'yyyy/mm/dd'))+1 aldays " +
            	  " FROM egtcbas cbas , egtalco alco, egtaldt aldt " +
            	  " WHERE cbas.empn = '" + empno + "' " +
            	  " AND Trim(cbas.empn) = aldt.empno (+) " ;   
//System.out.println(sql);
            rs = stmt.executeQuery(sql);

            if (rs.next())
            {
                obj.setEmpno(rs.getString("empno"));
                obj.setSern(rs.getString("sern"));
                obj.setJobno(rs.getString("jobno"));
                obj.setJobtype(GetJobType.getEmpJobType(empno));
//                System.out.println(obj.jobtype);
                obj.setBase(rs.getString("base"));
                obj.setIndate(rs.getString("indate"));
                obj.setHraldate(rs.getString("hraldate"));//HT AL date
                obj.setStatus(rs.getString("status"));
                obj.setSex(rs.getString("sex"));
                obj.setSpecialcode(rs.getString("specialcode"));
                obj.setOffday(rs.getInt("offday"));
                obj.setOpenday(rs.getInt("openday"));
                obj.setOpentime(rs.getString("opentime"));
                obj.setOffsdate(offsdate);
                obj.setOffedate(offedate);
                obj.setOffdays(rs.getInt("aldays"));
                obj.setUserid(userid);
                obj.setOfftype(offtype);
            }
            //******************************************************************************
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
        }
        finally
        {
            try
            {
                if (rs != null)
                {
                    rs.close();
                }
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }
    }
    
    //  未扣假+預請假 是否大於30天
    public String isBelow30Days()
    {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
//          ******************************************************************************
            sql = " SELECT Count(*)+"+obj.getOffdays()+" c FROM egtoffs WHERE offtype IN ('0','15','27')  " +
            	  " AND remark = 'N' AND empn = '"+empno+"' " ;   
//System.out.println(sql);
            rs = stmt.executeQuery(sql);

            if (rs.next())
            {
                if (rs.getInt("c") > 30 | rs.getInt("c") <= 0 )
                {
                    return  "未扣假天數 + 預請假天數不可大於30日";
                }    
            }
            //******************************************************************************
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
        }
        finally
        {
            try
            {
                if (rs != null)
                {
                    rs.close();
                }
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }

        return "Y";
    }
    
    //  是否於可遞單期間
    public String isAvailabledPeriod()
    {
        try
        {
	        SimpleDateFormat f = new SimpleDateFormat("yyyy/MM/dd");
	        java.util.Date date1 = new java.util.Date();//next month and first day
	        java.util.Date date2 = new java.util.Date();//next three months and
	                                                    // last day
	        java.util.Date date3 = new java.util.Date();//next two months and first
	                                                    // day
	        java.util.Date date4 = new java.util.Date();//next four months and last
	                                                    // day
	        java.util.Date date5 = new java.util.Date();//next two months and 11th
	                                                    // day
	        java.util.Date mydate = new java.util.Date();
	        GregorianCalendar cal = new GregorianCalendar();
	        String myday = new SimpleDateFormat("dd", Locale.UK).format(mydate);        
//	        System.out.println("myday "+myday);
	        //**************************************
	        //date1
	        cal.setTime(mydate);
	        cal.add(Calendar.MONTH, 1);
	        cal.set(Calendar.DAY_OF_MONTH, 1);
	        cal.set(Calendar.HOUR_OF_DAY, 0);
	        cal.set(Calendar.MINUTE, 0);
	        cal.set(Calendar.SECOND, 0);
	        cal.set(Calendar.MILLISECOND, 0);
	        date1 = cal.getTime();
	//        		System.out.println(f.format(date1));
	        //**************************************
	        //		date2
	        cal.setTime(mydate);
	        cal.add(Calendar.MONTH, 4);
	        cal.set(Calendar.DAY_OF_MONTH, 1);
	        cal.add(Calendar.DAY_OF_MONTH, -1);
	        cal.set(Calendar.HOUR_OF_DAY, 0);
	        cal.set(Calendar.MINUTE, 0);
	        cal.set(Calendar.SECOND, 0);
	        cal.set(Calendar.MILLISECOND, 0);
	        date2 = cal.getTime();
	//        		System.out.println(f.format(date2));
	        //**************************************
	        //date3
	        cal.setTime(mydate);
	        cal.add(Calendar.MONTH, 2);
	        cal.set(Calendar.DAY_OF_MONTH, 1);
	        cal.set(Calendar.HOUR_OF_DAY, 0);
	        cal.set(Calendar.MINUTE, 0);
	        cal.set(Calendar.SECOND, 0);
	        cal.set(Calendar.MILLISECOND, 0);
	        date3 = cal.getTime();
	//        		System.out.println(f.format(date3));
	        //**************************************
	        //date4
	        cal.setTime(mydate);
	        cal.add(Calendar.MONTH, 5);
	        cal.set(Calendar.DAY_OF_MONTH, 1);
	        cal.add(Calendar.DAY_OF_MONTH, -1);
	        cal.set(Calendar.HOUR_OF_DAY, 0);
	        cal.set(Calendar.MINUTE, 0);
	        cal.set(Calendar.SECOND, 0);
	        cal.set(Calendar.MILLISECOND, 0);
	        date4 = cal.getTime();
	//        		System.out.println(f.format(date4));
	        //**************************************
	        //date5
	        cal.setTime(mydate);
	        //next month
	        cal.add(Calendar.MONTH, 2);
	        cal.set(Calendar.DAY_OF_MONTH, obj.getOffday() + 1);
	        cal.set(Calendar.HOUR_OF_DAY, 0);
	        cal.set(Calendar.MINUTE, 0);
	        cal.set(Calendar.SECOND, 0);
	        cal.set(Calendar.MILLISECOND, 0);
	        date5 = cal.getTime();
	//        		System.out.println(f.format(date5));
	        //**************************************
	        //set check range
	        java.util.Date range_s = null;
	        java.util.Date range_e = null;
	        
	//        System.out.println("myday  "+myday);
	//        System.out.println("obj.getOffday  "+obj.getOffday());
	//        System.out.println("obj.getOpenday  "+obj.getOpenday());
	        
	        GregorianCalendar opendaycal = new GregorianCalendar();
	        opendaycal.set(Calendar.DATE,obj.getOpenday());
	        opendaycal.set(Calendar.HOUR_OF_DAY,Integer.parseInt(obj.getOpentime().substring(0,2)));
	        opendaycal.set(Calendar.MINUTE,Integer.parseInt(obj.getOpentime().substring(3)));
	        opendaycal.set(Calendar.SECOND,0);
	        opendaycal.set(Calendar.MILLISECOND,0);
	        
	        GregorianCalendar nowcal = new GregorianCalendar();	
//	        System.out.println("nowcal.getTime() "+nowcal.getTime());
//	        System.out.println("opendaycal.getTime() "+opendaycal.getTime());
	       
	        if (Integer.parseInt(myday) <= obj.getOffday())
	        {	            
	            range_s = date1;
	            range_e = date2;
	        }
	//        else if (Integer.parseInt(myday) >= obj.getOpenday())
	//        {
	//            range_s = date3;
	//            range_e = date4;
	//        }
	        else if (nowcal.getTime().after(opendaycal.getTime()) | nowcal.getTime().equals(opendaycal.getTime()))
	        {
	            range_s = date3;
	            range_e = date4;
	        }
	        else
	        {
	            range_s = date5;
	            range_e = date2;
	        }
	        //		**************************************
//	        System.out.println("allow range = "+f.format(range_s)+" ~ "+f.format(range_e));       
	
	        java.util.Date myoffsdate = f.parse(obj.getOffsdate());
	        java.util.Date myoffedate = f.parse(obj.getOffedate());        
	        
//	        System.out.println("myoffsdate "+myoffsdate.toString());
//	        System.out.println("myoffedate "+myoffedate.toString());
//	        System.out.println("range_s "+range_s.toString());
//	        System.out.println("range_e "+range_e.toString());
//	        
//			System.out.println("myoffsdate = "+f.format(myoffsdate)+" ~ myoffedate = "+f.format(myoffedate));
//			System.out.println("range_s = "+f.format(range_s)+" ~ range_e = "+f.format(range_e));
//			System.out.println("myoffsdate.before(range_s)  "+myoffsdate.before(range_s));
//			System.out.println("myoffsdate.equals(range_s) "+ myoffsdate.equals(range_s));
//			System.out.println("myoffedate.after(range_e)  "+myoffedate.after(range_e));		
//			System.out.println("myoffedate.equals(range_e) "+ myoffedate.equals(range_e));
			
			
	
//	        if ((myoffsdate.before(range_s) == true && !f.format(myoffsdate).equals(f.format(range_s)))
//	                || (myoffedate.after(range_e) == true && !f.format(myoffedate).equals(f.format(range_e))))
	        if ((myoffsdate.before(range_s) == true && !myoffsdate.equals(range_s))
	             || (myoffedate.after(range_e) == true && !myoffedate.equals(range_e)))	  
	        {
	            return "非可遞單期間, 可遞單期間為 < " + f.format(range_s) + " ~ "
	            + f.format(range_e) + " > ";
	        }
        } 
        catch (ParseException e) 
        {
            return e.toString();
        }
        
        return "Y";
    }
    
    //  是否於可遞單期間
    public String isAvailabledPeriod_old()
    {
        SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date date1 = new java.util.Date();//next month and first day
        java.util.Date date2 = new java.util.Date();//next three months and
                                                    // last day
        java.util.Date date3 = new java.util.Date();//next two months and first
                                                    // day
        java.util.Date date4 = new java.util.Date();//next four months and last
                                                    // day
        java.util.Date date5 = new java.util.Date();//next two months and 11th
                                                    // day
        java.util.Date mydate = new java.util.Date();
        GregorianCalendar cal = new GregorianCalendar();
        String myday = new SimpleDateFormat("dd", Locale.UK).format(mydate);
//                System.out.println(myday);
        //**************************************
        //date1
        cal.setTime(mydate);
        cal.add(Calendar.MONTH, 1);
        cal.set(Calendar.DAY_OF_MONTH, 1);
        date1 = cal.getTime();
//        		System.out.println(f.format(date1));
        //**************************************
        //		date2
        cal.setTime(mydate);
        cal.add(Calendar.MONTH, 4);
        cal.set(Calendar.DAY_OF_MONTH, 1);
        cal.add(Calendar.DAY_OF_MONTH, -1);
        date2 = cal.getTime();
//        		System.out.println(f.format(date2));
        //**************************************
        //date3
        cal.setTime(mydate);
        cal.add(Calendar.MONTH, 2);
        cal.set(Calendar.DAY_OF_MONTH, 1);
        date3 = cal.getTime();
//        		System.out.println(f.format(date3));
        //**************************************
        //date4
        cal.setTime(mydate);
        cal.add(Calendar.MONTH, 5);
        cal.set(Calendar.DAY_OF_MONTH, 1);
        cal.add(Calendar.DAY_OF_MONTH, -1);
        date4 = cal.getTime();
//        		System.out.println(f.format(date4));
        //**************************************
        //date5
        cal.setTime(mydate);
        //next month
        cal.add(Calendar.MONTH, 2);
        cal.set(Calendar.DAY_OF_MONTH, obj.getOffday() + 1);
        date5 = cal.getTime();
//        		System.out.println(f.format(date5));
        //**************************************
        //set check range
        java.util.Date range_s = null;
        java.util.Date range_e = null;

        if (Integer.parseInt(myday) <= obj.getOffday())
        {
            range_s = date1;
            range_e = date2;
        }
        else if (Integer.parseInt(myday) >= obj.getOpenday())
        {
            range_s = date3;
            range_e = date4;
        }
        else
        {
            range_s = date5;
            range_e = date2;
        }
        //		**************************************
//        System.out.println("allow range = "+f.format(range_s)+" ~ "+f.format(range_e));
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
        
   
        java.util.Date myoffsdate=null;
        java.util.Date myoffedate=null;;
        try
        {
            myoffsdate = sdf.parse(obj.getOffsdate());//java.util.Date.valueOf(obj.getOffsdate().replaceAll("/", "-"));
            myoffedate = sdf.parse(obj.getOffedate());//java.util.Date.valueOf(obj.getOffedate().replaceAll("/", "-"));
        }
        catch(Exception ex)
        {
        }
//		System.out.println("off range = "+f.format(myoffsdate)+" ~ "+f.format(myoffedate));
//		System.out.println(myoffsdate.before(range_s));
//		System.out.println(myoffedate.after(range_e));
//		System.out.println(f.format(myoffsdate).equals(f.format(range_s)));
//		System.out.println(f.format(myoffedate).equals(f.format(range_e)));

        if ((myoffsdate.before(range_s) == true && !f.format(myoffsdate).equals(f.format(range_s)))
                || (myoffedate.after(range_e) == true && !f.format(myoffedate).equals(f.format(range_e))))
        {
//            return "Only the period " + f.format(range_s) + " to "
//                    + f.format(range_e) + " is allowed.";
            return "非可遞單期間, 可遞單期間為 < " + f.format(range_s) + " ~ "
            + f.format(range_e) + " > ";
        }

        return "Y";
    }

    //  is re-submit
    public String isNotDuplicated()
    {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        int dupdate = 0;
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
            //******************************************************************************
            sql = " SELECT Count(*) c FROM egtoffs WHERE remark <> '*' " +
            	  " AND empn = '"+empno+"' " +
		      	  " AND ( To_Date('"+offsdate+"','yyyy/mm/dd') BETWEEN offsdate AND offedate " ;
		      for(int i=1; i<obj.getOffdays(); i++)
		      {//逐日檢查是否已請過
		          sql = sql + " or To_Date('"+offsdate+"','yyyy/mm/dd')+"+i+" BETWEEN offsdate AND offedate ";
		      }
		      sql = sql +  " )";

//            System.out.println(sql);
            rs = stmt.executeQuery(sql);

            if (rs.next())
            {
                dupdate = rs.getInt("c");
            }
            //******************************************************************************

            if (dupdate > 0)
            {
//                return "The off-date is duplicate!!";
                return "請勿重複遞單!!";
            }
            else
            {
                return "Y";
            }
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            return e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                    rs.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }
    }    
    
    //if personal AL enough
    public String isALDaysAvailable()
    {       
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        int thisyear = 0; // 進假天數        
        int thisdaysused = 0;//己扣假天數         
        String thisyearstartdate = "";//有效天數起日
        String thisyearenddate = "";//有效天數起訖日       
        int thisyearundeduct =0;//未扣假天數       
        int thisyearthisform =0;//此次假單應預扣假天數     
        ArrayList objAL = new ArrayList();
        SimpleDateFormat f = new SimpleDateFormat("yyyy/MM/dd");
        java.util.Date date1 = new java.util.Date();
        java.util.Date date2 = new java.util.Date();        
        boolean isalavailable = true;
        int deduct =0;
        
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
            //******************************************************************************            
            //查詢有效假區間
            sql = " SELECT empno, sern, offquota, useddays, To_Char(eff_dt,'yyyy/mm/dd') eff_dt,  " +
            	  " To_Char(exp_dt,'yyyy/mm/dd') exp_dt FROM egtoffq WHERE empno = '"+empno+"' " +
//2009/05/25 remark            	  
//            	  " AND ( To_Date('"+offsdate+"','yyyy/mm/dd') BETWEEN eff_dt AND exp_dt " +
//            	  " or To_Date('"+offedate+"','yyyy/mm/dd') BETWEEN eff_dt AND exp_dt ) " +
//2009/05/25 remark  
            	  " AND offtype = '"+offtype+"' and offquota-useddays > 0 ORDER BY eff_dt ";
//System.out.println(sql);
            rs = stmt.executeQuery(sql);
            
            while (rs.next())
            {
                EmpALDataObj obj = new EmpALDataObj();
                obj.setEmpno(rs.getString("empno"));
                obj.setThisyear(rs.getInt("offquota"));
                obj.setThisdaysused(rs.getInt("useddays"));
                obj.setThisyearstartdate(rs.getString("eff_dt"));
                obj.setThisyearenddate(rs.getString("exp_dt"));
                objAL.add(obj);                
            }
            rs.close();
            
            if(objAL.size()>0)
            {//get 未扣假
                sql = " SELECT empn, To_Char(offsdate,'yyyymmdd') offsdate, " +
                	  " To_Char(offedate,'yyyymmdd') offedate, offdays FROM egtoffs " +
                	  " WHERE empn = '"+empno+"' AND remark = 'N' AND offtype = '"+offtype+"' ";
//System.out.println(sql);
                rs = stmt.executeQuery(sql);
                
                while (rs.next())
                {
                    String tempoffsdate = rs.getString("offsdate");
                    String tempoffedate = rs.getString("offedate");
                    int tempoffdays = rs.getInt("offdays");
                    String tempoffdate = "";
                    int tempcount = 0;
                    
//                    System.out.println(tempoffsdate+"**");
                    for(int x=0; x<tempoffdays; x++)
                    {//check 未扣假 by day                        
                        Calendar checkoffdate = new GregorianCalendar();                        
                        checkoffdate.set(Integer.parseInt(tempoffsdate.substring(0,4)),Integer.parseInt(tempoffsdate.substring(4,6))-1,Integer.parseInt(tempoffsdate.substring(6,8)));
                        checkoffdate.add(Calendar.DATE,x);
//                        date1=checkoffdate.getTime();
//                        System.out.println("add "+x+" = "+f.format(date1));

	                    int tempdeduct =1;
		                for(int i=0; i<objAL.size(); i++)
		                {//未扣假將扣除區間
//		                    System.out.println("###########");
		                    EmpALDataObj obj = (EmpALDataObj) objAL.get(i);
		                    Calendar chk_start = new GregorianCalendar();          
		                    chk_start.set(Integer.parseInt(obj.getThisyearstartdate().substring(0,4)),Integer.parseInt(obj.getThisyearstartdate().substring(5,7))-1,Integer.parseInt(obj.getThisyearstartdate().substring(8,10)));
		                    Calendar chk_end = new GregorianCalendar();          
		                    chk_end.set(Integer.parseInt(obj.getThisyearenddate().substring(0,4)),Integer.parseInt(obj.getThisyearenddate().substring(5,7))-1,Integer.parseInt(obj.getThisyearenddate().substring(8,10)));

//date1=chk_start.getTime();
//System.out.println("chk_start = "+f.format(date1));
//date2=chk_end.getTime();
//System.out.println("chk_end = "+f.format(date2));
//date1=checkoffdate.getTime();
//System.out.println("checkoffdate = "+f.format(date1));
	                        
		                    if( (checkoffdate.after(chk_start) || checkoffdate.equals(chk_start)) &&  (checkoffdate.before(chk_end) || checkoffdate.equals(chk_end)) && tempdeduct >= 1)
		                    {
//		                        System.out.println((checkoffdate.after(chk_start) || checkoffdate.equals(chk_start)) &&  (checkoffdate.before(chk_end) || checkoffdate.equals(chk_end)) && tempdeduct >= 1);
		                        if(obj.getThisyear()-obj.getThisdaysused()-obj.getThisyearundeduct()>=1)
		                        {
//		                            System.out.println("Deduct ....");
		                            obj.setThisyearundeduct(obj.getThisyearundeduct()+tempdeduct);
		                            tempdeduct = 0;
		                        }
		                    }
		                }//for(int i=0; i<objAL.size(); i++)
		                if(tempdeduct>=1)
		                {
		                    return "餘假不足";
		                }
                    }//for(int x=0; x<tempoffdays; x++)
                }//無未扣假
            }
            else
            {
                return "餘假不足";
            }
            //***************************************************************************************
            //check off date by day
            if(objAL.size()>0)
            {//get off date
                for(int x=0; x<obj.getOffdays(); x++)
                {//check off date by day 
                    String tempoffsdate = obj.getOffsdate();
                    String tempoffedate = obj.getOffedate();
                    String tempoffdate = "";
                    int tempcount = 0;
                    Calendar checkoffdate = new GregorianCalendar();                        
                    checkoffdate.set(Integer.parseInt(tempoffsdate.substring(0,4)),Integer.parseInt(tempoffsdate.substring(5,7))-1,Integer.parseInt(tempoffsdate.substring(8,10)));
                    checkoffdate.add(Calendar.DATE,x);
//                    date1=checkoffdate.getTime();
//                    System.out.println("add "+x+" = "+f.format(date1));
//
                    int tempdeduct =1;
	                for(int i=0; i<objAL.size(); i++)
	                {//欲請假將扣除區間
	                    EmpALDataObj obj = (EmpALDataObj) objAL.get(i);
	                    Calendar chk_start = new GregorianCalendar();          
	                    chk_start.set(Integer.parseInt(obj.getThisyearstartdate().substring(0,4)),Integer.parseInt(obj.getThisyearstartdate().substring(5,7))-1,Integer.parseInt(obj.getThisyearstartdate().substring(8,10)));
	                    Calendar chk_end = new GregorianCalendar();          
	                    chk_end.set(Integer.parseInt(obj.getThisyearenddate().substring(0,4)),Integer.parseInt(obj.getThisyearenddate().substring(5,7))-1,Integer.parseInt(obj.getThisyearenddate().substring(8,10)));
                        
	                    if( (checkoffdate.after(chk_start) || checkoffdate.equals(chk_start)) &&  (checkoffdate.before(chk_end) || checkoffdate.equals(chk_end)) && tempdeduct >= 1)
	                    {
	                        if(obj.getThisyear()-obj.getThisdaysused()-obj.getThisyearundeduct()-obj.getThisyearthisform()>=1)
	                        {
	                            //System.out.println("Deduct ....");
	                            obj.setThisyearthisform(obj.getThisyearthisform()+tempdeduct);
	                            tempdeduct = 0;
	                        }
	                    }
	                }//for(int i=0; i<objAL.size(); i++)
	                if(tempdeduct>=1)
	                {
	                    return "餘假不足";
	                }
                }//for(int x=0; x<obj.offdays; x++)
            }//if(objAL.size()>0)
            else
            {
                return "餘假不足";
            }   
            
            //************************************************************************
            //final check
            for(int i=0; i<objAL.size(); i++)
            {
                EmpALDataObj obj = (EmpALDataObj) objAL.get(i);
//                System.out.println(obj.getThisyearstartdate()+"*"+obj.getThisyearenddate()+"*"+obj.getThisyear()+"*"+obj.getThisyearundeduct()+"*"+obj.getThisyearthisform());
               
                if(obj.getThisyear()-obj.getThisdaysused()-obj.getThisyearundeduct()-obj.getThisyearthisform()<0)
                {
                    return "餘假不足";
                }
            }//for(int i=0; i<objAL.size(); i++)

            return "Y" ;    
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            return e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                    rs.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }    
    }
     
    //***************************************************************************************
    //  is quota full
    //**  the last one to check
    public String isQuotaAvailable()
    {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        boolean isquotaleft = true; 
        String offdate_overquota = "";
        String temprank = GetJobType.getEmpJobType(empno);
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
            //******************************************************************************
            for(int i=0; i<obj.getOffdays(); i++)
		    {//count 當日 leaverank 已請人數
                String offdate = "";
                sql = " select to_char(To_Date('"+offsdate+"','yyyy/mm/dd')+"+i+",'yyyy/mm/dd') offdate from dual ";
                rs = stmt.executeQuery(sql);
                if(rs.next())
                {
                    offdate = rs.getString("offdate");	                
                }
                rs.close();
                
	            sql = " SELECT Count(*) c FROM egtoffs WHERE offtype in ('0','15','16') " +
	            	  " and (remark <> '*' or alrelease = 'Y') " +
	            	  " and leaverank = '"+temprank+"' AND To_Date('"+offdate+"','yyyy/mm/dd') " +
	            	  " BETWEEN offsdate AND offedate  " +
	            	  " AND offsdate BETWEEN To_Date('"+offdate+"','yyyy/mm/dd')-32  AND To_Date('"+offdate+"','yyyy/mm/dd')+32 " ;
//	            System.out.println(sql);
	            rs = stmt.executeQuery(sql);
	            int quotaasked = 0;
	            if (rs.next())
	            {
	                quotaasked = rs.getInt("c");//己請人數
	            }	            
	            rs.close();
	            
                int totalquota = 0;	               
                eg.off.quota.ALQuota aq = new eg.off.quota.ALQuota (offdate, temprank);
                aq.getQuota();
                ArrayList objAL = aq.getObjAL();
                if(objAL.size()>0)
                {
                    eg.off.quota.ALQuotaObj obj = (eg.off.quota.ALQuotaObj)objAL.get(0);	                
                    totalquota = Integer.parseInt(obj.getQuota());
                }
                else
                {
                    totalquota = 0;
                }
                
//                System.out.println(totalquota+"/"+ quotaasked);
                if(totalquota - quotaasked <=0)
                {
                    offdate_overquota = offdate;
                    isquotaleft = false;
                }	
		    }//for(int i=0; i<obj.offdays; i++)

            //******************************************************************************
            if (isquotaleft == false)
            {
                return offdate_overquota + " 請假人數已滿!!";
            }
            else
            {
                return "Y";
            }
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            return e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                    rs.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }
    }
    
    //***************************************************************************************
    //is birthday 
    //若為生日當天,quota 為 0 也可請
    public boolean isBirthday()
    {
        boolean isbirthday = false;
        if(obj.getOffdays()>1 | obj.getOffdays() <=0)
        {
            isbirthday = false;
        }
        else
        {//請假天數為一天
	        Connection conn = null;
	        Statement stmt = null;
	        ResultSet rs = null;
	        
	        try
	        {
	            ConnectionHelper ch = new ConnectionHelper();
	            conn = ch.getConnection();
	            stmt = conn.createStatement();
	            //******************************************************************************           
	                
	            sql = " SELECT Count(*) c FROM egtcbas WHERE empn = '"+obj.getEmpno()+"' " +
	            	  " AND To_Char(birth,'mm/dd') = To_Char(To_Date('"+obj.getOffsdate()+"','yyyy/mm/dd'),'mm/dd') " ;
	//	            System.out.println(sql);
	            rs = stmt.executeQuery(sql);
	            if (rs.next())
	            {
	                if(rs.getInt("c")>=1)
	                {
	                    isbirthday = true;
	                }
	            }	           
		    
	        }
	        catch ( Exception e )
	        {
	            System.out.println(e.toString());
	            return false;
	        }
	        finally
	        {
	            try
	            {
	                if (rs != null)
	                    rs.close();
	            }
	            catch ( Exception e )
	            {
	            }
	            try
	            {
	                if (stmt != null)
	                    stmt.close();
	            }
	            catch ( Exception e )
	            {
	            }
	            try
	            {
	                if (conn != null)
	                    conn.close();
	            }
	            catch ( Exception e )
	            {
	            }
	        }
        }
        return isbirthday;
    }
    
    //*******************************************************************************
    //  是否可取消AL 
    public String isAvailableCancelAL(String deloffno)
    {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        String temp_offno = deloffno;
        String temp_opentime = obj.getOpenday()+" "+obj.getOpentime();//25 00:01
        boolean chkdeltime = false;    
       
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
            
            //若於出班表後才請的下下個月10號前的al,可自行消假       
            sql = " SELECT CASE WHEN newdate BETWEEN pubdt AND  To_Date(To_Char(Last_Day(newdate),'yyyy/mm/dd')||' 23:59','yyyy/mm/dd hh24:mi') THEN 'Y' ELSE 'N' END is_publish , " +
            	  " CASE WHEN offsdate between Trunc(Add_Months(pubdt,2),'mm') AND Trunc(Add_Months(pubdt,2),'mm')+9  THEN 'Y' ELSE 'N' END chk1 , " +
            	  " CASE WHEN offedate between Trunc(Add_Months(pubdt,2),'mm') AND Trunc(Add_Months(pubdt,2),'mm')+9  THEN 'Y' ELSE 'N' END chk2 , " +
            	  " CASE WHEN SYSDATE BETWEEN pubdt AND Trunc(Add_Months(pubdt,1),'mm')+10  THEN 'Y' ELSE 'N' END chk3 " +
            	  " FROM egtoffs, (SELECT Max(pubdate) pubdt FROM fztspub WHERE pubdate <= SYSDATE) sp " +
            	  " WHERE offno = '"+deloffno+"' and offtype in ('0','15','16') ";
//System.out.println(sql);
            rs = stmt.executeQuery(sql);

            if (rs.next())
            {
               if("Y".equals(rs.getString("is_publish").trim()) && "Y".equals(rs.getString("chk1").trim()) && "Y".equals(rs.getString("chk2").trim()) && "Y".equals(rs.getString("chk3").trim()))
               {
                   //return "Y";
                   chkdeltime = true;
//                   System.out.println("chkdeltime  "+chkdeltime);
               }
            }            
            //******************************************************************************
        }
        catch ( Exception e )
        {
//            System.out.println(e.toString());
            return e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                {
                    rs.close();
                }
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }
        
        //***************************************************
        SimpleDateFormat f = new SimpleDateFormat("yyyy/MM/dd");
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
            //******************************************************************************
            for(int x=0; x<obj.getOffdays(); x++)
            {//check off date by day 
                String tempoffsdate = obj.getOffsdate();
                String tempoffdate = "";
                int tempquota =0;
                int tempusedquota =0;
                Calendar checkoffdate = new GregorianCalendar();                        
                checkoffdate.set(Integer.parseInt(tempoffsdate.substring(0,4)),Integer.parseInt(tempoffsdate.substring(5,7))-1,Integer.parseInt(tempoffsdate.substring(8,10)));
                checkoffdate.add(Calendar.DATE,x);
                tempoffdate = f.format(checkoffdate.getTime());                
                int offdd = checkoffdate.get(Calendar.DAY_OF_MONTH);
                
                Calendar canceldeadline = new GregorianCalendar();   
                canceldeadline.set(Integer.parseInt(tempoffsdate.substring(0,4)),Integer.parseInt(tempoffsdate.substring(5,7))-1,Integer.parseInt(tempoffsdate.substring(8,10)));
                canceldeadline.add(Calendar.DATE,x);
//                System.out.println("before : checkoffdate "+f.format(checkoffdate.getTime())+"-->  cancelcheckdate "+f.format(cancelcheckdate.getTime()));
                //cancelcheckdate.set(Integer.parseInt(tempoffsdate.substring(0,4)),Integer.parseInt(tempoffsdate.substring(5,7))-1,Integer.parseInt(tempoffsdate.substring(8,10)));
   
//                System.out.println("offdd = "+offdd);
                if(offdd <= obj.getOffday())
                {
//                    System.out.println(offdd+" <= "+obj.openday+" 扣二個月的"+obj.offday);
                    canceldeadline.add(Calendar.MONTH, -2); 
                    canceldeadline.set(Calendar.DAY_OF_MONTH,obj.getOffday());
                }
                else
                {                    
//                    System.out.println(offdd+" > "+obj.openday+ " 扣一個月的"+obj.offday);
                    canceldeadline.add(Calendar.MONTH, -1); 
                    canceldeadline.set(Calendar.DAY_OF_MONTH,obj.getOffday());
                }
                
                Calendar todate = new GregorianCalendar();                   
//                System.out.println("canceldeadline "+f.format(canceldeadline.getTime()));
//                System.out.println("todate "+f.format(todate.getTime()));
//                System.out.println(todate.before(cancelcheckdate));
//                System.out.println(cancelcheckdate.before(todate));
                             
                if(canceldeadline.before(todate) && chkdeltime == false )
                {
                    return "必須於 "+f.format(canceldeadline.getTime())+" 前取消";
                }
                
//                System.out.println("After checkoffdate "+f.format(checkoffdate.getTime())+"-->  cancelcheckdate "+f.format(cancelcheckdate.getTime()));
            
//              ******************************************************************************	  
                
                //get quota of the date
	            sql = " SELECT nvl(quota,0) quota FROM egtqobd WHERE quota_dt = To_Date('"+tempoffdate+"','yyyy/mm/dd') " +
	            	  " AND leaverank = '"+obj.getJobtype()+"' ";
//	            System.out.println(sql);
	            rs = stmt.executeQuery(sql);
	
	            if (rs.next())
	            {
	                tempquota = rs.getInt("quota");
	            }
	            rs.close();
                //******************************************************************************	  
	            //get used quota of the date
	            sql = " SELECT count(*) c FROM egtoffs WHERE (offsdate <= To_Date('"+tempoffdate+"','yyyy/mm/dd') " +
	            	  " AND offedate >= To_Date('"+tempoffdate+"','yyyy/mm/dd')) AND leaverank = '"+obj.getJobtype()+"' " +
	            	  " AND (remark <> '*' or alrelease = 'Y')  AND (offtype = '0' or offtype = '16' or offtype = '15')  ";
//	            System.out.println(sql);
	            rs = stmt.executeQuery(sql);
	            if (rs.next())
	            {
	                tempusedquota = rs.getInt("c");
	            }
	            rs.close();
	            
	            if((tempquota-tempusedquota)<=0)
	            {
	                //新需求 5號 22:00 ~ 10號 23:59 quato <=0 不可銷單
	                SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	                GregorianCalendar cal_now = new GregorianCalendar();//now
	                GregorianCalendar deadline1 = new GregorianCalendar();//截止日-5
	                GregorianCalendar deadline2 = new GregorianCalendar();//截止日	                
//System.out.println(f.format(cal_now.getTime()));        
	                
	                //stop_start  2009/02/11 08:30   
	                deadline1.set(Calendar.DATE,obj.getOffday());
	                deadline1.set(Calendar.HOUR_OF_DAY,22);
	                deadline1.set(Calendar.MINUTE,0);
	                deadline1.set(Calendar.SECOND,0);
	                deadline1.add(Calendar.DATE,-5);	                
//System.out.println(f.format(deadline1.getTime()));


//	                stop_end  2009/02/11 10:30
					deadline2.set(Calendar.DATE,obj.getOffday());
					deadline2.set(Calendar.HOUR_OF_DAY,23);
					deadline2.set(Calendar.MINUTE,59);
					deadline2.set(Calendar.SECOND,59);
//System.out.println(f.format(deadline2.getTime()));

	        		if((deadline1.before(cal_now) && deadline2.after(cal_now)) | deadline1.equals(cal_now) | deadline2.equals(cal_now))
	        		{//deadline1 在 cal_now 之前 且 deadline2 在 cal_now 之後
	        		 //5日22:00 ~10日23:59
	        		    //System.out.println("true");
	        		    return tempoffdate+" 配額為零,不可銷假!!";
	        		}     
	        		else
	        		{
	        		    //System.out.println("false");
	        		    return "X"; //配額<0 //5日22:00 ~10日23:59 之外
	        		}
	                
	                //************************************************************************************
	                //return tempoffdate+" 配額為零,不可銷假!!";
	                //return "X"; //配額<0
	            }         
	            
            }//for(int x=0; x<obj.offdays; x++)
            return "Y";
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            return e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                    rs.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }
    }    
    
    
    public String trainMonthChk()
    {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        int dupdate = 0;
        String train_month = "";
        String train_chk_str = "Y";
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
            //******************************************************************************
            sql = " SELECT remarks FROM crew_v WHERE staff_num = '"+empno+"'";
            rs = stmt.executeQuery(sql);

            if (rs.next())
            {
                train_month = rs.getString("remarks");
            }
            //******************************************************************************

            if ("".equals(train_month) | train_month == null | (!offsdate.substring(5,7).equals(train_month) && !offedate.substring(5,7).equals(train_month)) )
            {                
                return "Y";
            }
            else
            {                
                sql = " SELECT CASE WHEN (To_Number(To_Char(Last_Day(To_Date('"+offsdate+"','yyyy/mm/dd')),'dd')) < 31  AND Count(*) >=21) THEN 'N' " +
                	  " WHEN (To_Number(To_Char(Last_Day(To_Date('"+offsdate+"','yyyy/mm/dd')),'dd')) >= 31  AND Count(*) >=22) THEN 'N' " +
                	  " ELSE 'Y' end train " +
                	  " FROM egtoffs WHERE empn = '"+empno+"' AND offtype IN ('0','16','15') " +
                	  " AND Trunc(offsdate,'mm') = Trunc(To_Date('"+offsdate+"','yyyy/mm/dd'),'mm') " +
                	  " AND remark <> '*' ";     
                
                rs = stmt.executeQuery(sql);

                if (rs.next())
                {
                    train_chk_str = rs.getString("train").trim();
                }
                
                return train_chk_str;
            }
        }
        catch ( Exception e )
        {
//            System.out.println(e.toString());
            return e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                    rs.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }
    }    
public String isALOverSixDays(){//2013/01/07 新增AL rule
        
        Connection conn = null;
        Statement stmt = null; 
        ResultSet rs = null;
        String over_six_str = "";
        String tempDate ="";
        int over=6;//不可超過六天連續請AL.2013/01/07
        int tempCount=0;
        ArrayList objALdate = new ArrayList(); 
        ArrayList objALSix = new ArrayList();
        
        try
        {            
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
            //想請假的範圍-------------------------------------------------------------
            sql = " select To_Char(offs.offsdate,'yyyy/mm/dd') SDATE "+ //,To_Char(offs.offedate,'yyyy/mm/dd') EDATE " +
                  " from egdb.egtoffs offs " +
                  " where ( offs.offsdate between to_date('"+offsdate+"','yyyy/mm/dd') and  to_date('"+offsdate+"','yyyy/mm/dd')+6 " + //請假起始日+6
                  " or offs.offedate between to_date('"+offedate+"','yyyy/mm/dd')-6 and  to_date('"+offedate+"','yyyy/mm/dd') ) " + //請假結束日-6
                  " and offs.empn = '"+empno+"' and offs.remark = 'N' and  offs.offtype IN ('0','15','27') " +
                  " order by offs.offsdate";
              
              rs = stmt.executeQuery(sql);
              while (rs.next()){
                objALSix.add(rs.getString("SDATE"));
//                  System.out.println(rs.getString("SDATE")+"已有"); 
              } 
              //加入需請假區間
              SimpleDateFormat f = new SimpleDateFormat("yyyy/MM/dd");
              for(int k=0; k<obj.getOffdays(); k++){
                  Calendar wantOff = new GregorianCalendar();                        
                  wantOff.set(Integer.parseInt(obj.getOffsdate().substring(0,4)),Integer.parseInt(obj.getOffsdate().substring(5,7))-1,Integer.parseInt(obj.getOffsdate().substring(8,10)));
                  wantOff.add(Calendar.DATE,k);               
                  objALSix.add(f.format(wantOff.getTime()));
//                System.out.println(f.format(wantOff.getTime())+"欲請");            
              }
//              Collections.sort(objALSix);
              
              //總區間-------------------------------------------------------------
              Calendar offAll = new GregorianCalendar();
              for(int j=0; j<=over; j++){//請假起始日 +6天內部不可連續            
                  offAll.set(Integer.parseInt(obj.getOffsdate().substring(0,4)),Integer.parseInt(obj.getOffsdate().substring(5,7))-1,Integer.parseInt(obj.getOffsdate().substring(8,10)));
                  offAll.add(Calendar.DATE,j);                  
                  objALdate.add(f.format(offAll.getTime()));
//                    System.out.println(f.format(offAll.getTime()));
              }

              for(int j=0; j>=(-over); j--){//請假結束日-6內部不可連續   
              offAll.set(Integer.parseInt(obj.getOffedate().substring(0,4)),Integer.parseInt(obj.getOffedate().substring(5,7))-1,Integer.parseInt(obj.getOffedate().substring(8,10)));
              offAll.add(Calendar.DATE,j);
                    if(objALdate.contains(f.format(offAll.getTime())) == false){//沒有此日期再加入
                        objALdate.add(f.format(offAll.getTime()));
                    }                   
//                  System.out.println(f.format(offAll.getTime()));
              }
              Collections.sort(objALdate);//要排序才能判斷是否連續
              //若想請的範圍,於總區間>連續7
              for(int k=0;k<objALdate.size();k++){
                  tempDate=(String)objALdate.get(k);
//                System.out.println(tempDate);  
                      if(objALSix.contains(tempDate)){
                          tempCount++; 
                          if(tempCount >= 7){
                                break;//AL不可連續請超過六天.
                          }
                      }else{
                          tempCount = 0;
                      }
              }
          if(tempCount >= 7){
            over_six_str = "AL不可連續請超過六天.";
          }else{
            over_six_str = "Y";
          }

        }catch( Exception e ){
            return e.toString();
        }finally{
            try
            {
                if (rs != null)
                    rs.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
            
        }
        return over_six_str;
    } 
    public ALRulesObj getALObj()
    {
        return obj;
    }
}
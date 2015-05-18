package fz.daysoff;

import java.io.*;
import java.sql.*;
import java.util.*;
import ci.db.*;
/*
 * @author cs71 Created on  2006/10/23
 * v02
 * v03 cs27 2009/07/30 mod for breakmonth trip
 * v04 2010/06/15 CS27 mod for CR 20090109 SR9042
 *     dps.duty_cd in ('BLO' , 'BLL' , 'BLG' , 'BLZ') is covered in roster_v.duty_cd='GRD'
 * v05 2010/07/26 cs27 mod 'XL' as 'ALT'  20090234/SR9085
 * V06 2010/12/14 cs27 add 'NPT' rduty
 * V6.1 2010/12/27 debug function dup-days  , modify add cop_dutY_cd NOT IN ('ECM','JPS','JCM')
 * v07 2012/03/05 cs57 add 'CPT' rduty
 * v08 2012/07/02 cs57 判斷ACT_str_DT_TM_GMT 為'GRD',若為00:00改為前一日的23:59
 * ----------------------------------------------------
 * Function getOffDays(String yyyymm)
 * Function calDupDays(String yyyymm) - 班表有一日多碼重覆計算問題
 * Function insDaysOff()
 * Function updInfo(String yyyymm)    - 找出組員rank_cd & dualrating 並更新
 */
public class DaysOff
{
    Driver dbDriver = null;
    Connection conn = null;
    Statement stmt = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String sql = "";
    int count = 0;
    ArrayList daysoffAL = new ArrayList();
    String yyyymm = "";
    
    public static void main(String[] args)
    {
        String yyyymm = "201206";        
        System.out.println(new java.util.Date());        
        DaysOff doff = new DaysOff();
        System.out.println(yyyymm);
        doff.getOffDays(yyyymm); //function 1
//        doff.calDupDays(yyyymm); //function 2
//        doff.insDaysOff(); 	 //function 3
//        doff.updInfo(yyyymm); 	 //function 4
        System.out.println(new java.util.Date());
        System.out.println("Done");
    }

    public void getOffDays(String yyyymm)
    {
        this.yyyymm = yyyymm;
        try
        {
            ConnDB cn = new ConnDB();
	        cn.setAOCIPROD();
	        java.lang.Class.forName(cn.getDriver());
	        conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());
	        stmt = conn.createStatement();

//	        cn.setAOCIPRODCP();
//	        dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//	        conn = dbDriver.connect(cn.getConnURL(), null);
//	        stmt = conn.createStatement();
	
//	        sql = 	" SELECT To_Char(yymm,'yyyymm') yymm,staff_num, Round(Sum(calcend-calcstr+1),0) OnDutyDays " +
//			        "   ,((To_Number(to_char(last_day(yymm),'dd')))- Round(Sum(calcend-calcstr+1),0)) daysoff " +
//			        " FROM " +
//			        " ( " +
//			        " SELECT yymm,ser_num,staff_num,ros_str,seg_str,seg_end,ros_end " +
//			        "   ,( CASE  WHEN ros_str<yymm THEN yymm ELSE Trunc(ros_str,'dd') end) calcstr " +
//			        "   ,( CASE WHEN rduty IN ('FLY','GRD','SBY') " +
//			        "               THEN  ( CASE  WHEN seg_str<yymm THEN (yymm-1)    " +
//			        "                             WHEN Trunc(seg_str,'mm')>yymm THEN  (Trunc(seg_str,'mm')-1)  " +
//			        "                             ELSE Trunc(seg_str,'dd') " +
//			        "                    end) " +
//			        "           WHEN rduty IN ('ALT','SLT','WLT','FLT','NBT','RDT','HST') " +
//			        "               THEN  ( CASE  WHEN seg_str<yymm THEN (yymm-1)    " +
//			        "                             ELSE Trunc(ros_str,'dd') " +
//			        "                     end) " +
//			        "           ELSE      ( CASE  WHEN ros_end<yymm THEN (yymm-1)    " +
//			        "                             WHEN Trunc(ros_end,'mm')>yymm THEN  (Trunc(ros_end,'mm')-1)  " +
//			        "                             ELSE Trunc(ros_end,'dd') " +
//			        "                     end) " +
//			        "       END ) calcend " +
//			        "       ,rduty,sduty,cop_duty_cd " +
//			        " FROM " +
//			        " (SELECT yymm, r.STAFF_NUM " +
//			        "     ,act_str_dt ros_str " +
//			        "     ,(CASE  WHEN r.series_num=0 THEN NULL " +
//			        "             ELSE (SELECT  ACT_str_DT_TM_GMT FROM " +
//			        "                     (SELECT * FROM DUTY_PRD_SEG_V seg2 ORDER BY ACT_str_DT_TM_GMT desc) seg WHERE r.series_num=seg.series_num AND rownum=1 ) " +
//			        "       END) SEG_str " +
//			        "      ,(CASE  WHEN r.series_num=0 THEN NULL " +
//			        "             ELSE (SELECT  ACT_end_DT_TM_GMT FROM " +
//			        "                     (SELECT * FROM DUTY_PRD_SEG_V seg2 ORDER BY  ACT_str_DT_TM_GMT desc) seg WHERE r.series_num=seg.series_num AND rownum=1 )"+
//			        "       END) SEG_end " +
//			        "     , act_end_dt ros_end " +
//			        "     ,r.duty_cd rduty " +
//			        "  	  ,(CASE  WHEN r.series_num=0 THEN NULL " +
//			        "             ELSE (SELECT  DUTY_CD FROM DUTY_PRD_SEG_V seg WHERE  r.series_num=seg.series_num AND duty_seq_num=99  ) " +
//			        "       END) SDUTY " +
//			        "  	  ,(CASE  WHEN r.series_num=0 THEN NULL " +
//			        "             ELSE (SELECT  cop_duty_cd FROM DUTY_PRD_SEG_V seg WHERE  r.series_num=seg.series_num AND duty_seq_num=1 AND ROWNUM=1  ) " +
//			        "       END) cop_duty_cd " +
//			        " 	  ,r.ROSTER_NUM ros_num,r.SERIES_NUM ser_num " +
//			        " FROM   ROSTER_V r, (SELECT to_DATE('"+yyyymm+"','YYYYMM') yymm FROM dual)" +
//			        " WHERE " +
//			        "     ( Trunc(ACT_STR_DT,'mm')=yymm OR " +
//			        "       ( Trunc(ACT_END_DT,'mm')=yymm and Trunc(ACT_STR_DT,'mm') < Trunc(ACT_END_DT,'mm') ) " +
//			        "     ) " +
//			        "    AND r.DELETE_IND='N'  " +
//			        //"    AND duty_published='Y' " +
//			        "    AND r.acting_rank IN ('CA','FO','FE','RP','FDT') " +
//			        "    AND NOT (r.duty_cd IN ( 'HLT','RDO','BXT','SUT','BOFF','ADO','PLT' ) ) " +
//			        " ) " +
//			        " WHERE cop_duty_cd<>'ECM' OR cop_duty_cd IS null " +
//			        " ) doff " +
//			        " GROUP BY yymm,staff_num " ;
	        
	        sql =   " SELECT yymm, staff_num,Sum(g1) flydays, Sum(g2) grddays, Sum(g3) leavedays, Sum(g4) othdays, lastdd   " +
			        " FROM (   " +
			        "    SELECT To_Char(yymm,'yyyymm') yymm,staff_num,rduty_count,  " +
			        "          Decode(rduty_count,'G1',Round(calcend-calcstr+1,0),0) g1,  " +
			        "          Decode(rduty_count,'G2',Round(calcend-calcstr+1,0),0) g2,  " +
			        "          Decode(rduty_count,'G3',Round(calcend-calcstr+1,0),0) g3,  " +
			        "          Decode(rduty_count,'G4',Round(calcend-calcstr+1,0),0) g4,   " +
			        "          To_Number(to_char(last_day(yymm),'dd')) lastdd   " +
			        "    FROM  (  " +
			        "              SELECT yymm,ser_num,staff_num,ros_str,seg_str,seg_end,ros_end,  " +
			        "                    (CASE  WHEN ros_str<yymm THEN yymm ELSE Trunc(ros_str,'dd') end) calcstr, " +
			        "                    (CASE WHEN rduty IN ('FLY','GRD','SBY') THEN ( CASE  WHEN seg_str<yymm THEN (yymm-1)  " +
			        "                                                                          WHEN Trunc(seg_str,'mm')>yymm THEN  (Trunc(seg_str,'mm')-1) " +
			        "                                                                    ELSE Trunc(seg_str,'dd') end) " +
			        "                          WHEN rduty IN ('ALT','SLT','WLT','FLT','NBT','RDT','HST','XL') " +   //v05
			        "                                                            THEN  ( CASE  WHEN seg_str<yymm THEN (yymm-1) " +
			        "                                                                    ELSE Trunc(ros_str,'dd') end)  " +
/** v03 */
                                "                          WHEN rduty IN ( 'HLT','RDO','BXT','SUT','BOFF','ADO','PLT','NPT','CPT' ) " +  //v06, v07 CPT
                                "                               THEN  (Trunc(ros_end,'dd')-1) " +
/** v03 */
			        "                          ELSE ( CASE  WHEN ros_end<yymm THEN (yymm-1) " +
			        "                                        WHEN Trunc(ros_end,'mm')>yymm THEN  (Trunc(ros_end,'mm')-1) " +
			        "                                        ELSE Trunc(ros_end,'dd') end) END ) calcend , " +
			        "                   rduty,rduty_count,sduty,cop_duty_cd  " +
			        "              FROM  (SELECT yymm, r.STAFF_NUM ,act_str_dt ros_str , " +
			        "                            (CASE  WHEN r.series_num=0 THEN NULL    " +
//			        "                                  ELSE (SELECT ACT_str_DT_TM_GMT FROM " +
			        "                                  ELSE (SELECT case when to_char(ACT_str_DT_TM_GMT,'hh24mi')='0000' and r.duty_cd = 'GRD' then ACT_str_DT_TM_GMT else ACT_str_DT_TM_GMT end ACT_str_DT_TM_GMT FROM " +
			        "                                                (SELECT * FROM DUTY_PRD_SEG_V seg2 ORDER BY ACT_str_DT_TM_GMT desc) seg " +
			        "                                                WHERE r.series_num=seg.series_num AND rownum=1 ) END) SEG_str, " +
			        "                            (CASE  WHEN r.series_num=0 THEN NULL " +
			        "                                  ELSE (SELECT  ACT_end_DT_TM_GMT FROM   " +
			        "                                                (SELECT * FROM DUTY_PRD_SEG_V seg2 ORDER BY  ACT_str_DT_TM_GMT desc) seg  " +
			        "                                                WHERE r.series_num=seg.series_num AND rownum=1 ) END) SEG_end , " +
			        "                            act_end_dt ros_end , r.duty_cd rduty ,  " +
			        "                            Decode(r.duty_cd,'FLY','G1','GRD','G2','SBY','G2','ALT','G3','XL','G3','SLT','G3','WLT','G3','FLT','G3', " +
			        "                                            'NBT','G3','RDT','G3','HST','G3','G4') rduty_count, " +   //v05
			        "                            (CASE  WHEN r.series_num=0 THEN NULL  " +
			        "                                  ELSE (SELECT  DUTY_CD FROM DUTY_PRD_SEG_V seg  " +
			        "                                                WHERE r.series_num=seg.series_num AND duty_seq_num=99  ) END) SDUTY , " +
			        "                            (CASE  WHEN r.series_num=0 THEN NULL  " +
			        "                                  ELSE (SELECT  cop_duty_cd FROM DUTY_PRD_SEG_V seg  " +
			        "                                                WHERE  r.series_num=seg.series_num AND duty_seq_num=1 AND ROWNUM=1) END) cop_duty_cd , " +
			        "                            r.ROSTER_NUM ros_num,r.SERIES_NUM ser_num  " +
			        "                      FROM ROSTER_V r, (SELECT to_DATE('"+yyyymm+"','YYYYMM') yymm FROM dual)   " +
			        "                      WHERE ( " +
//			        "				Trunc(ACT_STR_DT,'mm')=yymm OR " +
			        "				ACT_STR_DT between yymm and add_months(yymm, 1) - 1 / 1440 OR " +
			        " ( " +
//			        "				Trunc(ACT_END_DT,'mm')=yymm and Trunc(ACT_STR_DT,'mm') < Trunc(ACT_END_DT,'mm') " +
			        "				ACT_str_DT < yymm and ACT_end_DT between yymm and add_months(yymm, 1) - 1 / 1440 " +
			        " )) " +
			        "                            AND r.DELETE_IND='N' AND r.acting_rank IN ('CA','FO','FE','RP','FDT')  " +
// v03			        "                            AND NOT (r.duty_cd IN ( 'HLT','RDO','BXT','SUT','BOFF','ADO','PLT') )
                                "                             )  " +
			        "              WHERE cop_duty_cd NOT IN ('ECM','JPS','JCM') OR cop_duty_cd IS null  ) doff " +   //v6.1
			        "    )     " +
			        " GROUP BY yymm, staff_num,lastdd  " ;
System.out.println("sql 1 = "+ sql);

	        rs = stmt.executeQuery(sql);
	        
	        while (rs.next())
	        {
	            DaysOffObj obj = new DaysOffObj();
	            obj.setEmpno(rs.getString("staff_num"));
	            obj.setYymm(rs.getString("yymm"));
	            obj.setLastdd(rs.getString("lastdd"));
	            obj.setFlys(rs.getString("flydays"));
	            obj.setGrds(rs.getString("grddays"));
	            obj.setLeaves(rs.getString("leavedays"));
	            obj.setOths(rs.getString("othdays"));	            
	            daysoffAL.add(obj);
	        }     
        }
        catch(Exception e)
        {
        	System.out.print(e.toString());
        }
        finally
        {
        	try{if(rs != null) rs.close();}catch(SQLException e){}
        	try{if(stmt != null) stmt.close();}catch(SQLException e){}
        	try{if(conn != null) conn.close();}catch(SQLException e){}
        }
    }
    
    public void calDupDays(String yyyymm)
    {
        //StringBuffer sb = new StringBuffer();
        //sb.append("Empno,Roster_num, Series_num, Roster_str, Segment_str\r\n ");
        try
        {
            ConnDB cn = new ConnDB();
            
//	        cn.setAOCIPROD();
//	        java.lang.Class.forName(cn.getDriver());
//	        conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());
//	        stmt = conn.createStatement();
	   
	        cn.setAOCIPRODCP();
	        dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	        conn = dbDriver.connect(cn.getConnURL(), null);
	        stmt = conn.createStatement();

	        for(int al=0; al<daysoffAL.size(); al++)
	        {
	            DaysOffObj daysoffobj = (DaysOffObj) daysoffAL.get(al);          
		        String empno = daysoffobj.getEmpno();
		        int dup =0;
		        ArrayList objAL = new ArrayList();	 
		        
		        sql = 	" SELECT yymm,ser_num,staff_num,to_char(Trunc(ros_str,'dd'),'yyyy/mm/dd') ros_str, " +
		        		" to_char(Trunc(seg_str,'dd'),'yyyy/mm/dd') seg_str," +
		        		" seg_end,ros_end " +
				        "   ,( CASE  WHEN ros_str<yymm THEN yymm ELSE Trunc(ros_str,'dd') end) calcstr " +
				        "   ,( CASE WHEN rduty IN ('FLY','GRD','SBY') " +
				        "               THEN  ( CASE  WHEN seg_str<yymm THEN (yymm-1)    " +
				        "                             WHEN Trunc(seg_str,'mm')>yymm THEN  (Trunc(seg_str,'mm')-1)  " +
				        "                             ELSE Trunc(seg_str,'dd') " +
				        "                    end) " +
				        "           WHEN rduty IN ('ALT','XL','SLT','WLT','FLT','NBT','RDT','HST') " +
				        "               THEN  ( CASE  WHEN seg_str<yymm THEN (yymm-1)    " +
				        "                             ELSE Trunc(ros_str,'dd') " +
				        "                     end) " +
				        "           ELSE      ( CASE  WHEN ros_end<yymm THEN (yymm-1)    " +
				        "                             WHEN Trunc(ros_end,'mm')>yymm THEN  (Trunc(ros_end,'mm')-1)  " +
				        "                             ELSE Trunc(ros_end,'dd') " +
				        "                     end) " +
				        "       END ) calcend " +
				        "       ,rduty,sduty,cop_duty_cd,ros_num " +
				        " FROM " +
				        " (SELECT yymm, r.STAFF_NUM " +
				        "     ,act_str_dt ros_str " +
				        "     ,(CASE  WHEN r.series_num=0 THEN NULL " +
				        "             ELSE (SELECT ACT_str_DT_TM_GMT FROM " +
				        "             ELSE (SELECT (case when to_char(act_str_dt_tm_gmt,'hh24mi')='0000' and r.duty_cd = 'GRD' then ACT_str_DT_TM_GMT - 1/1440 else ACT_str_DT_TM_GMT end ) FROM " +
//				        "                   (SELECT * FROM DUTY_PRD_SEG_V seg2 ORDER BY ACT_str_DT_TM_GMT desc) seg WHERE r.series_num=seg.series_num AND rownum=1 ) " +
				        "       END) SEG_str " +
				        "      ,(CASE  WHEN r.series_num=0 THEN NULL " +
				        "             ELSE (SELECT  ACT_end_DT_TM_GMT FROM " +
				        "                     (SELECT * FROM DUTY_PRD_SEG_V seg2 ORDER BY  ACT_str_DT_TM_GMT desc) seg WHERE r.series_num=seg.series_num AND rownum=1 )"+
				        "       END) SEG_end " +
				        "     , act_end_dt ros_end " +
				        "     ,r.duty_cd rduty " +
				        "  	  ,(CASE  WHEN r.series_num=0 THEN NULL " +
				        "             ELSE (SELECT  DUTY_CD FROM DUTY_PRD_SEG_V seg WHERE  r.series_num=seg.series_num AND duty_seq_num=99  ) " +
				        "       END) SDUTY " +
				        "  	  ,(CASE  WHEN r.series_num=0 THEN NULL " +
				        "             ELSE (SELECT  cop_duty_cd FROM DUTY_PRD_SEG_V seg WHERE  r.series_num=seg.series_num AND duty_seq_num=1 AND ROWNUM=1  ) " +
				        "       END) cop_duty_cd " +
				        " 	  ,r.ROSTER_NUM ros_num,r.SERIES_NUM ser_num " +
				        " FROM   ROSTER_V r, (SELECT to_DATE('"+yyyymm+"','YYYYMM') yymm FROM dual) " +
				        " WHERE " +
				        "     ( Trunc(ACT_STR_DT,'mm')=yymm OR " +
				        "       ( Trunc(ACT_END_DT,'mm')=yymm and Trunc(ACT_STR_DT,'mm') < Trunc(ACT_END_DT,'mm') ) " +
				        "     ) " +
				        "    AND r.staff_num = '"+empno+"' " +
				        "    AND r.DELETE_IND='N'  " +
				        //"    AND duty_published='Y' " +
				        "	 AND r.series_num <>0 " +
				        "    AND r.acting_rank IN ('CA','FO','FE','RP','FDT') " +
				        "    AND NOT (r.duty_cd IN ( 'HLT','RDO','BXT','SUT','BOFF','ADO','PLT','NPT','CPT' ) ) " + //v6.1 NPT, v07 CPT
				        " ) " +
				        " WHERE cop_duty_cd NOT IN ('ECM','JPS','JCM') OR cop_duty_cd IS null  ORDER BY  ros_str " ;  //v6.1
//System.out.println("sql 2 "+ sql);	 
		        rs = stmt.executeQuery(sql);
		        
		        while (rs.next())
		        {
		            DaysOffObj obj = new DaysOffObj();
		            obj.setEmpno(rs.getString("staff_num"));
		            obj.setRos_str(rs.getString("ros_str"));
		            obj.setSeg_str(rs.getString("seg_str"));
		            obj.setRos_num(rs.getString("ros_num"));
		            obj.setSer_num(rs.getString("ser_num"));
		            objAL.add(obj);
		        }     
		        
		        if(objAL.size()>=2)
		        {
		            for(int i=0; i<objAL.size()-1; i++)
		            {
		                DaysOffObj obj1 = (DaysOffObj) objAL.get(i);
		                DaysOffObj obj2 = (DaysOffObj) objAL.get(i+1);
		                if(obj1.getSeg_str().equals(obj2.getRos_str()))
		                {
		                  dup ++;
		                  //sb.append(obj1.getEmpno()+","+obj1.getRos_num()+","+obj1.getSer_num()+","+obj1.getRos_str()+","+obj1.getSeg_str()+"\r\n");
		                }	                
		            }
		        }
		        rs.close();
		        //set dupday = dup
		        daysoffobj.setDups(Integer.toString(dup));
		        //System.out.println(al + ".  daysoffobj.getDupdays = "+daysoffobj.getDupdays());
	        }//end of for loop
	        
	        //FileWriter fw = new FileWriter("C://FZTemp/200704dup.csv",true);
	        //fw.write(sb.toString());
	        //fw.flush();
	        //fw.close();     
        }
        catch(Exception e)
        {
        	System.out.print(e.toString());
        }
        finally
        {
        	try{if(rs != null) rs.close();}catch(SQLException e){}
        	try{if(stmt != null) stmt.close();}catch(SQLException e){}
        	try{if(conn != null) conn.close();}catch(SQLException e){}
        }
    }
    
    public StringBuffer getSB(String yymm)
    {
        GetRank gr = new GetRank(yymm);
        GetFleet gf = new GetFleet(yymm);
        GetName gn = new GetName();
        StringBuffer sb = new StringBuffer();
        sb.append("Empno,Name,Fleet,Rank,Off Days,On Duty Days\r\n");  
        
        for(int i=0; i<daysoffAL.size(); i++ )
        {
            DaysOffObj obj = (DaysOffObj) daysoffAL.get(i);
           //sb.append(obj.getEmpno()+","+gn.getCname(obj.getEmpno())+","+gf.getFleet(obj.getEmpno())+","+gr.getRank(obj.getEmpno())+","+(Integer.parseInt(obj.getDaysoff())-Integer.parseInt(obj.getDupdays()))+","+obj.getOndutydays()+"\r\n");
        }

        
        try
        {
	        FileWriter fw = new FileWriter("C://FZTemp/200704daysoff.csv",true);
	        fw.write(sb.toString());
	        fw.flush();
	        fw.close();
        }
        catch(Exception e)
        {
        	System.out.print(e.toString());
        }
        finally
        {
        	
        }
        
        return sb;
        
    }
    
    public String insDaysOff()
    {
        try
        {
            ConnDB cn = new ConnDB();
            
//	        cn.setORP3FZUser();
//	        java.lang.Class.forName(cn.getDriver());
//	        conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());
//	        stmt = conn.createStatement();
	   
	        cn.setORP3FZUserCP();
	        dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	        conn = dbDriver.connect(cn.getConnURL(), null);
	        stmt = conn.createStatement();
	        
	        //Delete records
	        sql = "delete from  dfdb.dftdoff WHERE Trunc(yymm,'mm') = To_Date('"+yyyymm+"','yyyymm') ";
//	        System.out.println(sql);
	        pstmt=conn.prepareStatement(sql);
	        pstmt.executeUpdate();     
	        pstmt.close();
	        //*******************************************************************************************        
	        //Insert records
	        sql = "insert into dfdb.dftdoff (empno, yymm, dayson, daysoff, leaves, grds, flys, dups, oths) values (?,to_date(?,'yyyymm'),?,?,?,?,?,?,?)";
//	        System.out.println(sql);
	        pstmt = conn.prepareStatement(sql);
        
	        for(int i=0; i<daysoffAL.size(); i++ )
	        {
	            DaysOffObj obj = (DaysOffObj) daysoffAL.get(i); 
	            int j = 1;
	            int flys = Integer.parseInt(obj.getFlys());
	            int grds = Integer.parseInt(obj.getGrds());
	            int leaves = Integer.parseInt(obj.getLeaves());
	            int oths = Integer.parseInt(obj.getOths());
	            int lastdd = Integer.parseInt(obj.getLastdd());
	            int dups = Integer.parseInt(obj.getDups());
	            
	            //System.out.println(j+"/"+flys+"/"+grds+"/"+leaves+"/"+oths+"/"+lastdd+"/"+dups);
	            
	        	pstmt.setString(j, obj.getEmpno());
	        	pstmt.setString(++j, obj.getYymm());
	        	pstmt.setInt(++j, flys+grds+leaves+oths-dups);
	        	pstmt.setInt(++j, lastdd-(flys+grds+leaves+oths-dups));	 
	        	pstmt.setInt(++j, leaves);	 
	        	pstmt.setInt(++j, grds);	 
	        	pstmt.setInt(++j, flys);	 
	        	pstmt.setInt(++j, dups);	 
	        	pstmt.setInt(++j, oths);	 
	        	pstmt.addBatch();
	        	
				count++;
				if (count == 10)
				{
					pstmt.executeBatch();
					pstmt.clearBatch();
					count = 0;
				}
			}

			if (count > 0)
			{
				pstmt.executeBatch();
				pstmt.clearBatch();
			}   
			
			return "Y";
        }
        catch(Exception e)
        {
        	System.out.print(e.toString());
        	return "Error : "+ e.toString();
        }
        finally
        {
        	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
        	try{if(conn != null) conn.close();}catch(SQLException e){}
        }
    }
    
    public void updInfo(String yyyymm)
    {  
        count = 0;
        try
        {
            ConnDB cn = new ConnDB();
            
//	        cn.setORP3FZUser();
//	        java.lang.Class.forName(cn.getDriver());
//	        conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());
//	        stmt = conn.createStatement();
	   
	        cn.setORP3FZUserCP();
	        dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	        conn = dbDriver.connect(cn.getConnURL(), null);
	        stmt = conn.createStatement();
		        
		    sql = 	" SELECT v.fleet_cd,v.dualrating,v.rank_cd,d.empno  " +
		    		" FROM dfdb.dftdoff d, dfdb.dfvcrewfleetrank v " +
		    		" WHERE d.empno=v.staff_num AND  d.yymm = to_date("+yyyymm+",'yyyymm') " +
		    		" Group BY d.empno,v.fleet_cd,v.dualrating,v.rank_cd " +
		    		" ORDER BY v.fleet_cd,v.dualrating,v.rank_cd " ;
//	        System.out.println(sql);
	        rs = stmt.executeQuery(sql);     
	        
	        sql = " update dfdb.dftdoff set fleet_cd = ?, rank_cd = ?, dualrating = ? " +
	        	  " where yymm = to_date(?,'yyyymm') and empno = ? ";
	        pstmt = conn.prepareStatement(sql);
	        while (rs.next())
	        {
	            int j = 1;
	            pstmt.setString(j, rs.getString("fleet_cd"));
	        	pstmt.setString(++j, rs.getString("rank_cd"));
	        	pstmt.setString(++j, rs.getString("dualrating"));
	        	pstmt.setString(++j, yyyymm);	
	        	pstmt.setString(++j, rs.getString("empno"));	
	        	pstmt.addBatch();	        	
				count++;
				if (count == 10)
				{
					pstmt.executeBatch();
					pstmt.clearBatch();
					count = 0;
				}	            
	        }     
	        
	        if (count > 0)
			{
				pstmt.executeBatch();
				pstmt.clearBatch();
			}   		        
        }
        catch(Exception e)
        {
        	System.out.print(e.toString());
        }
        finally
        {
        	try{if(rs != null) rs.close();}catch(SQLException e){}
        	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
        	try{if(stmt != null) stmt.close();}catch(SQLException e){}
        	try{if(conn != null) conn.close();}catch(SQLException e){}
        }
    }


    public ArrayList getObjAL()
    {
        return daysoffAL;
    }
    
}

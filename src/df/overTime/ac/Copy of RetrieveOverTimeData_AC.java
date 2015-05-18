package df.overTime.ac;

import java.sql.*;
import java.util.*;
import java.util.Date;
import ci.db.*;

/**
 * RetrieveOverTimeData
 * 
 * @author cs71
 * @version 1.0 2005/12/29
 * 
 * Copyright: Copyright (c) 2005
 */
// 增加航班需修改 RetrieveOverTimeData_For16Hrs.java & SumOverTime_For16Hrs.java
//

public class RetrieveOverTimeData_AC
{

    public static void main(String[] args)
    {
        System.out.println(new Date());
        RetrieveOverTimeData_AC rot = new RetrieveOverTimeData_AC("2009", "10");
        System.out.println("rot.clrOverTimeData()");
        rot.clrOverTimeData();
        System.out.println("rot.getErrorStr() = "+rot.getErrorStr());   
        System.out.println("rot.retrieveOverTimeData()");
        rot.retrieveOverTimeData();
        System.out.println("rot.getErrorStr() = "+rot.getErrorStr());   
        System.out.println("rot.insOverTimeData()");       
        rot.insOverTimeData();
        System.out.println("rot.getErrorStr() = "+rot.getErrorStr());
        System.out.println("rot.adjSBIR()");       
        rot.adjSBIR();
        System.out.println("rot.adjSB()");     
        rot.adjSB();
        System.out.println(new Date());    
        System.out.println("Done");
    }

    

    private String year;
    private String month;
    private int count = 0;
    private String sql = "";
    private String sql2 =""; 
    ArrayList objAL = new ArrayList();
    ArrayList adjMinsAL = new ArrayList();
    private String errorstr = "";
    
    StringBuffer sb = new StringBuffer();
    
    public RetrieveOverTimeData_AC(String year, String month)
    {
        this.year = year;
        if(month.length()<2)
        {
            month = "0"+month;
        }
        this.month = month;
    }

    public void clrOverTimeData()
    {        
        Connection conn = null;
        Statement stmt = null;
    	Driver dbDriver = null;
        PreparedStatement pstmt = null;   
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();            
            
            //delete paymm belong  year||month           
            sql = "delete from dftovrp WHERE paymm = to_char(last_day(to_date('"+year+month+"01','yyyymmdd'))+1,'yyyymm')";
            //System.out.println(sql);
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        }
        catch ( SQLException e )
        {
            System.out.print("clrOverTimeData 1 -->" + e.toString());
        }
        catch ( Exception e )
        {
            System.out.print("clrOverTimeData 2 -->" + e.toString());
            e.printStackTrace();
        }
        finally
        {
            if (pstmt != null)
                try
                {
                    pstmt.close();
                }
                catch ( SQLException e )
                {
                }
            if (conn != null)
                try
                {
                    conn.close();
                }
                catch ( SQLException e )
                {
                }
        }

    }   
    
    public void retrieveOverTimeData()
    {//calculate workhrs      
        ConnDB cn = new ConnDB();
        Connection conn = null;
        Statement stmt = null;
    	ResultSet rs = null;	
    	Driver dbDriver = null;
        PreparedStatement pstmt = null;   

        try
        {
//            cn.setAOCIPRODCP();
//            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//            conn = dbDriver.connect(cn.getConnURL(), null);          
//            stmt = conn.createStatement();
            
          cn.setAOCIPROD();
          java.lang.Class.forName(cn.getDriver());
          conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
          stmt = conn.createStatement();
//System.out.println("Start>>>>>>>>>>>>>");    
            sql = " SELECT tdp.series_num , tdp.duty_seq_num,   Round((tdp.act_end_dt_tm_gmt- tdp.act_str_dt_tm_gmt)*24*60,0) wkhr,  " +
            	  " To_Char(tdp.act_str_dt_tm_gmt,'yyyy/mm/dd hh24:mi:ss') rep,  To_Char(tdp.act_end_dt_tm_gmt,'yyyy/mm/dd hh24:mi:ss') rel,  " +
            	  " To_Char(t3.str_dt_tm_gmt,'yyyy/mm/dd hh24:mi:ss') takeoff, To_Char(t3.act_end_dt_tm_gmt,'yyyy/mm/dd hh24:mi:ss') land,  " +
            	  " To_Char(t3.act_str_dt_tm_gmt-(8/24),'yyyy/mm/dd hh24:mi:ss') act_takeoff, r.staff_num, t3.flt_num, t3.port_a, t3.port_b,  " +
            	  " tdp.airport_cd port_ori, to_char(last_day(to_date('" + year + month + "01','yyyymmdd'))+1,'yyyymm') paymm " + 
            	  " FROM trip_duty_prd_v tdp, roster_v r , " + 
            	  "      ( SELECT t1.series_num, t1.port_a, t1.port_b, t1.str_dt_tm_gmt,  t1.act_str_dt_tm_gmt, " + 
            	  "               t1.act_end_dt_tm_gmt, t1.duty_seq_num, t1.flt_num " + 
            	  "        FROM  duty_prd_seg_v t1, " + 
            	  "             ( SELECT dps.series_num, dps.duty_seq_num, Max(dps.act_end_dt_tm_gmt) act_end_dt_tm_gmt " + 
            	  "               FROM duty_prd_seg_v dps, " + 
            	  "                    ( SELECT dps.series_num, dps.duty_seq_num FROM  duty_prd_seg_v dps " + 
            	  "                      WHERE dps.act_str_dt_tm_gmt BETWEEN to_date('" + year + month + "01 00:00:00','yyyymmdd hh24:mi:ss') +(8/24) " + 
            	  "                      AND Last_Day(to_date('" + year + month + "01 23:59:59','yyyymmdd hh24:mi:ss')) +(8/24) " + 
            	  "                      AND dps.fd_ind = 'N' AND  dps.delete_ind = 'N' AND  ( dps.duty_cd = 'FLY' or dps.duty_cd='TVL') " + 
            	  "                      GROUP BY dps.series_num, dps.duty_seq_num )  dps2 " + 
            	  "              WHERE dps.series_num = dps2.series_num AND dps.duty_seq_num = dps2.duty_seq_num " + 
            	  "              AND dps.fd_ind = 'N' AND  dps.delete_ind = 'N' AND  ( dps.duty_cd = 'FLY' or dps.duty_cd='TVL') " + 
            	  "        GROUP BY  dps.series_num, dps.duty_seq_num ) t2 " + 
            	  "       WHERE t1.series_num=t2.series_num  AND t1.act_end_dt_tm_gmt = t2.act_end_dt_tm_gmt and t1.delete_ind = 'N' " + 
            	  "             AND t1.duty_seq_num=t2.duty_seq_num and (t1.arln_cd is null or t1.arln_cd='CI' or t1.arln_cd='AE') ) t3 " + 
            	  " WHERE tdp.series_num = r.series_num  AND tdp.series_num = t3.series_num " + 
            	  "       AND tdp.duty_seq_num = t3.duty_seq_num " + 
            	  "       AND tdp.fd_ind = 'N' AND  tdp.delete_ind = 'N' " + 
            	  "       AND tdp.act_str_dt_tm_gmt BETWEEN to_date('" + year + month + "01 00:00:00','yyyymmdd hh24:mi:ss') -1 " + 
            	  "       AND Last_Day(to_date('" + year + month + "01 23:59:59','yyyymmdd hh24:mi:ss')) +1 " + 
            	  "       AND r.delete_ind = 'N' " + 
            	  "       AND (r.duty_cd = 'FLY' or r.duty_cd = 'TVL') AND   r.staff_num||''  like '6%' " + 
            	  //add on 2009/02/11*********
            	  "       AND r.act_str_dt BETWEEN to_date('" + year + month + "01 00:00:00','yyyymmdd hh24:mi:ss') -15 " + 
            	  "       AND Last_Day(to_date('" + year + month + "01 23:59:59','yyyymmdd hh24:mi:ss')) +1 " +
                  //add on 2009/02/11*********
//            	  "       AND tdp.act_str_dt_tm_gmt = r.act_str_dt " + //remark by betty  
            	  " ORDER BY t3.act_str_dt_tm_gmt, tdp.series_num , tdp.duty_seq_num, r.staff_num ";

//            System.out.println(sql);

            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
//System.out.println("end>>>>>>>>>>>>>");             
//          ************************************      
            RetrieveCrewBase cb = new RetrieveCrewBase(year,month);
            //************************************
            while (rs.next())
            {
                OverTimeObj obj = new OverTimeObj();
                obj.setSeries_num(rs.getString("series_num"));
                obj.setDuty_seq_num(rs.getString("duty_seq_num"));
                obj.setWorkmins(rs.getString("wkhr"));
                obj.setSkj_report_gmt(rs.getString("rep"));
                obj.setAct_release_gmt(rs.getString("rel"));
                obj.setSkj_takeoff_gmt(rs.getString("takeoff"));
                obj.setAct_land_gmt(rs.getString("land"));
                obj.setAct_takeoff_utc(rs.getString("act_takeoff"));
                obj.setEmpno(rs.getString("staff_num"));
                obj.setFltno(rs.getString("flt_num"));
                obj.setPort_a(rs.getString("port_a"));
                obj.setPort_b(rs.getString("port_b"));
                obj.setPort_base(rs.getString("port_ori"));
                obj.setBase(cb.getBase(rs.getString("staff_num")));    
                obj.setSbirflag("N");     
                obj.setPaymm(rs.getString("paymm"));
                obj.setOvermins("0");
                obj.setOvermins2("0");
                objAL.add(obj);
            }            
    
            //get transfer flt *******************      
            TransferFlt flt = new TransferFlt();
            flt.getTransferFlt();
            ArrayList transfltAL = new ArrayList();
            transfltAL = flt.getObjAL();            
            //************************************
            
            for(int i=0; i<objAL.size(); i++)
            {
//                System.out.println("i = "+i);
                OverTimeObj obj = (OverTimeObj) objAL.get(i);
                if("KHH".equals(obj.getBase()))
                {//khh base flt 
                    obj.setBasemins("660");
                }                             
                else
                {//TPE BASE flt maybe 區域flt or 越洋 flt
                    for(int j=0; j<transfltAL.size(); j++)
                    {
//                        System.out.println("j = "+j);
                    	obj.setBasemins("720");
                        TransferFltObj fltobj = (TransferFltObj) transfltAL.get(j);
                        if(obj.getPort_a().equals(fltobj.getSector()) | obj.getPort_b().equals(fltobj.getSector())|obj.getPort_base().equals(fltobj.getSector()))
                        {//越洋 flt
                            obj.setBasemins("840");
                            break;
                        }
                    }                
                }
                //calculate overtimemins
                int tempwkhr = Integer.parseInt(obj.getWorkmins());
                int tempbasetime = Integer.parseInt(obj.getBasemins());
                int tempovertime = 0;
                int tempovertime2 = 0;
                tempovertime = tempwkhr - tempbasetime;
                if(tempovertime<=0)
                {
                    tempovertime=0;
                }
                obj.setOvermins(Integer.toString(tempovertime));
                
                //2009Apr後則無二倍計算情形
                if(Integer.parseInt(year+month) < 200904)
                {
	                if(tempwkhr>960 && !"0061".equals(obj.getFltno()))
	                {//Besides ci0061, over 16 hrs, 以2倍計算
	                    obj.setOvermins(Integer.toString(960-Integer.parseInt(obj.getBasemins())));
	                    obj.setOvermins2(Integer.toString(tempwkhr-960));
	                }
                }                
//                System.out.println(obj.getOvermins()+"/"+obj.getOvermins2());
            }          
            errorstr = "Y";
        }
        catch ( SQLException e )
        {
            System.out.print("retrieveOverTimeData 1 -->" +e.toString());
            errorstr=sql +"  ****  "+ e.toString();
    		try { conn.rollback(); } //if fail rollback
    		catch (SQLException e1) { errorstr=e.toString(); }
        }
        catch ( Exception e )
        {            
            System.out.print("retrieveOverTimeData 2 -->" +e.toString());
            errorstr=e.toString();
        }
        finally
        {
            if (rs != null)
                try
                {
                    rs.close();
                }
                catch ( SQLException e )
                {
                }           
            if (pstmt != null)
                try
                {
                    pstmt.close();
                }
                catch ( SQLException e )
                {
                }
            if (conn != null)
                try
                {
                    conn.close();
                }
                catch ( SQLException e )
                {
                }
        }

    }
    
    public void insOverTimeData()
    {//insert overtime flt into dftovrp
        String str = "";
        Connection conn = null;
        Statement stmt = null;
    	ResultSet rs = null;	
    	Driver dbDriver = null;
        PreparedStatement pstmt = null;   
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();                    
			conn.setAutoCommit(false);	
            
            sql = " insert into dftovrp (series_num, duty_seq_num, skj_report_gmt, act_release_gmt, skj_takeoff_gmt, " +
            	  " act_land_gmt, act_takeoff_utc, workmins, basemins, empno, fltno, port_a, port_b, port_base, overmins, overmins2, " +
            	  " sbirflag, paymm, chguser, chgdt) values (?,?,to_date(?,'yyyy/mm/dd hh24:mi:ss')," +
            	  " to_date(?,'yyyy/mm/dd hh24:mi:ss'), to_date(?,'yyyy/mm/dd hh24:mi:ss')," +
            	  " to_date(?,'yyyy/mm/dd hh24:mi:ss'), to_date(?,'yyyy/mm/dd hh24:mi:ss')," +
            	  " ?,?,?,?,?,?,?,to_number(?),to_number(?),null,?,'SYS',sysdate) ";    
            
			pstmt = conn.prepareStatement(sql);			
			int count2 =0;
			for(int i=0; i<objAL.size(); i++)
			{
			    OverTimeObj obj = (OverTimeObj) objAL.get(i);			   
//			    if(Integer.parseInt(obj.getOvermins())>0)
//			    {
			        //System.out.println(obj.getSeries_num()+"/"+obj.getDuty_seq_num()+"/"+obj.getEmpno());
			        str =" insert into dftovrp (series_num, duty_seq_num, skj_report_gmt, act_release_gmt, skj_takeoff_gmt, " +
	            	  " act_land_gmt, act_takeoff_utc, workmins, basemins, empno, fltno, port_a, port_b, port_base, overmins, overmins2, " +
	            	  " sbirflag, paymm, chguser, chgdt) values ('"+obj.getSeries_num()+"','"+obj.getDuty_seq_num()+"',to_date('"+obj.getSkj_report_gmt()+"','yyyy/mm/dd hh24:mi:ss')," +
	            	  " to_date('"+obj.getAct_release_gmt()+"','yyyy/mm/dd hh24:mi:ss'), to_date('"+obj.getSkj_takeoff_gmt()+"','yyyy/mm/dd hh24:mi:ss')," +
	            	  " to_date('"+obj.getAct_land_gmt()+"','yyyy/mm/dd hh24:mi:ss'), to_date('"+obj.getAct_takeoff_utc()+"','yyyy/mm/dd hh24:mi:ss')," +
	            	  " '"+obj.getWorkmins()+"','"+obj.getBasemins()+"','"+obj.getEmpno()+"','"+obj.getFltno()+"','"+obj.getPort_a()+"','"+obj.getPort_b()+"','"+obj.getPort_base()+"',to_number('"+obj.getOvermins()+"'),to_number('"+obj.getOvermins2()+"'),null,'"+obj.getPaymm()+"','SYS',sysdate) ";
					int j = 1;
					pstmt.setString(j, obj.getSeries_num());
					pstmt.setString(++j, obj.getDuty_seq_num());  
					pstmt.setString(++j, obj.getSkj_report_gmt());  
					pstmt.setString(++j, obj.getAct_release_gmt());  
					pstmt.setString(++j, obj.getSkj_takeoff_gmt());  
					pstmt.setString(++j, obj.getAct_land_gmt());  
					pstmt.setString(++j, obj.getAct_takeoff_utc());  
					pstmt.setString(++j, obj.getWorkmins());  
					pstmt.setString(++j, obj.getBasemins());  
					pstmt.setString(++j, obj.getEmpno());  
					pstmt.setString(++j, obj.getFltno());  
					pstmt.setString(++j, obj.getPort_a());  
					pstmt.setString(++j, obj.getPort_b());  
					pstmt.setString(++j, obj.getPort_base());  
					pstmt.setString(++j, obj.getOvermins());  
					pstmt.setString(++j, obj.getOvermins2());  				
					pstmt.setString(++j, obj.getPaymm());  	
					pstmt.addBatch();
					count2++;
					if (count2 == 1)
					{
					    try
					    {
					        pstmt.executeBatch();
					    }
					    catch ( SQLException e )
				        {
					        sb.append(e.toString()+" \r\n ");
					        sb.append(str+" \r\n ");
//					        System.out.println(e.toString());
//					        System.out.println(str);
				        }
						pstmt.clearBatch();
						count2 = 0;
					}
//			    }
			}

			if (count2 > 0)
			{
				pstmt.executeBatch();
				pstmt.clearBatch();
			}

			conn.commit();	
			errorstr="Y";
        }
        catch ( SQLException e )
        {
            System.out.print("insOverTimeData 1 --> "+e.toString());
            errorstr=sql +"  ****  "+ e.toString();
    		try { conn.rollback(); } //if fail rollback
    		catch (SQLException e1) { errorstr=e.toString(); }
        }
        catch ( Exception e )
        {            
            System.out.print("insOverTimeData 2 --> "+ e.toString());
            errorstr=e.toString();
        }
        finally
        {            
            if (pstmt != null)
                try
                {
                    pstmt.close();
                }
                catch ( SQLException e )
                {
                }
            if (conn != null)
                try
                {
                    conn.close();
                }
                catch ( SQLException e )
                {
                }
        }

    } 
    
    public void adjSBIR()
    {
        Connection conn = null;
        Statement stmt = null;
    	ResultSet rs = null;	
    	Driver dbDriver = null;
        PreparedStatement pstmt = null;   
        try 
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();     
            conn.setAutoCommit(false);	
        	stmt = conn.createStatement();            
            
        	sql = " SELECT series_num, duty_seq_num, empno, fltno, port_a, port_b, port_base, " +
        		  " to_char(act_takeoff_utc,'yyyy/mm/dd hh24:mi:ss') act_takeoff_utc, " +
        		  " to_char(skj_report_gmt,'yyyy/mm/dd hh24:mi:ss') skj_report_gmt, " +
        		  " to_char(act_release_gmt,'yyyy/mm/dd hh24:mi:ss') act_release_gmt, " +
        		  " to_char(skj_takeoff_gmt,'yyyy/mm/dd hh24:mi:ss') skj_takeoff_gmt, " +      
        		  " to_char(act_land_gmt,'yyyy/mm/dd hh24:mi:ss') act_land_gmt, " +   
        		  " overmins, overmins2, paymm, chguser, to_char(chgdt,'yyyy/mm/dd hh24:mi:ss') chgdt " +
        		  " FROM dftsbir " +
        		  " WHERE paymm = to_char(last_day(to_date('"+year+month+"01','yyyymmdd'))+1,'yyyymm') ";
            
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);  
            
            while (rs.next())
            {
                OverTimeObj obj = new OverTimeObj();
                obj.setSeries_num(rs.getString("series_num"));
                obj.setDuty_seq_num(rs.getString("duty_seq_num"));
                obj.setEmpno(rs.getString("empno"));
                obj.setPort_a(rs.getString("Port_a"));
                obj.setPort_b(rs.getString("Port_b"));
                obj.setPort_base(rs.getString("port_base"));
                obj.setFltno(rs.getString("fltno"));
                obj.setAct_takeoff_utc(rs.getString("act_takeoff_utc"));
                obj.setSkj_report_gmt(rs.getString("skj_report_gmt"));
                obj.setAct_release_gmt(rs.getString("act_release_gmt"));
                obj.setSkj_takeoff_gmt(rs.getString("skj_takeoff_gmt"));
                obj.setAct_land_gmt(rs.getString("act_land_gmt"));
                obj.setOvermins(rs.getString("overmins"));
                obj.setOvermins2(rs.getString("overmins2"));
                obj.setPaymm(rs.getString("paymm"));
                obj.setChguser(rs.getString("chguser"));
                obj.setChgdt(rs.getString("chgdt"));                
                adjMinsAL.add(obj);
            } 
               
            if(adjMinsAL.size() > 0)
            {
                sql = " update dftovrp set overmins = to_number(?), overmins2 = to_number(?), " +
		          	  " sbirflag = 'Y', chguser = ?, chgdt= to_date(?,'yyyy/mm/dd hh24:mi:ss') " + 	  
		          	  " where port_a = ? and port_b = ? and skj_report_gmt = to_date(?,'yyyy/mm/dd hh24:mi:ss') " +
		          	  " and fltno = ? and duty_seq_num = to_number(?) and empno = ? " +
		          	  " and paymm = ? ";
                pstmt = conn.prepareStatement(sql);

                for (int i = 0; i < adjMinsAL.size(); i++)
                {
//                    System.out.println("do update or insert "+ adjMinsAL.size()+"-->"+ i);
                    OverTimeObj obj = (OverTimeObj) adjMinsAL.get(i);
                   
                    int j=1;
                    pstmt.setString(j , obj.getOvermins());
                    pstmt.setString(++j , obj.getOvermins2());
                    pstmt.setString(++j , obj.getChguser());
                    pstmt.setString(++j , obj.getChgdt());            
                    pstmt.setString(++j , obj.getPort_a());
                    pstmt.setString(++j , obj.getPort_b());
                    pstmt.setString(++j , obj.getSkj_report_gmt());
                    pstmt.setString(++j , obj.getFltno());
                    pstmt.setString(++j , obj.getDuty_seq_num());
                    pstmt.setString(++j , obj.getEmpno());
                    pstmt.setString(++j , obj.getPaymm());               
                    int x = pstmt.executeUpdate();
                    
                    if(x<1)
                    {
                    sql2 = " insert into dftovrp(series_num, duty_seq_num, skj_report_gmt, " +
                    	   " act_release_gmt, skj_takeoff_gmt, act_land_gmt, act_takeoff_utc, " +
                    	   " workmins, basemins, empno, fltno, port_a, port_b, port_base, overmins, overmins2, " +
	                  	   " sbirflag, paymm, chguser, chgdt) values ('"+obj.getSeries_num()+"'," +
	                  	   " '"+obj.getDuty_seq_num()+"',to_date('"+obj.getSkj_report_gmt()+"','yyyy/mm/dd hh24:mi:ss')," +
	                  	   " to_date('"+obj.getAct_release_gmt()+"','yyyy/mm/dd hh24:mi:ss'), " +
	                  	   " to_date('"+obj.getSkj_takeoff_gmt()+"','yyyy/mm/dd hh24:mi:ss')," +
	                  	   " to_date('"+obj.getAct_land_gmt()+"','yyyy/mm/dd hh24:mi:ss'), " +
	                  	   " to_date('"+obj.getAct_takeoff_utc()+"','yyyy/mm/dd hh24:mi:ss')," +
	                  	   " 0,0,'"+obj.getEmpno()+"', " +
	                  	   " '"+obj.getFltno()+"','"+obj.getPort_a()+"','"+obj.getPort_b()+"'," +
	                  	   " '"+obj.getPort_base()+"',to_number('"+obj.getOvermins()+"'),to_number('"+obj.getOvermins2()+"')," +
	                  	   " 'Y','"+obj.getPaymm()+"','"+obj.getChguser()+"',to_date('"+obj.getChgdt()+"','yyyy/mm/dd hh24:mi:ss')) ";
                   
	                    try
					    {
	                        stmt.executeUpdate(sql2);           
					    }
					    catch ( SQLException e )
				        {
					        sb.append(e.toString()+" -- "+sql2+" \r\n ");
//					        System.out.println(e.toString());
//					        System.out.println(sql2);
				        }                                
                    }
                }   
            }
            conn.commit();	 
   			errorstr="Y";
            
        } 
        catch (SQLException e) 
        {
            System.out.print("adjSBIR 1 -->"+e.toString());
            errorstr=e.toString();
    		try { conn.rollback(); } //if fail rollback
    		catch (SQLException e1) { errorstr=e.toString(); }
        } 
        catch (Exception e) 
        {
            System.out.print("adjSBIR 2 -->"+e.toString());
            e.printStackTrace();
        } 
        finally 
        {
            if ( rs != null ) try {
                rs.close();
            } catch (SQLException e) {}
            if ( stmt != null ) try {
                stmt.close();
            } catch (SQLException e) {}
            if ( pstmt != null ) try {
                pstmt.close();
            } catch (SQLException e) {}
            if ( conn != null ) try {
                conn.close();
            } catch (SQLException e) {}
        }
       
    }
    
    public void adjSB()
    {         
        ArrayList sbAL = new ArrayList();
        sb = new StringBuffer();
        Connection conn = null;
        Statement stmt = null;
    	ResultSet rs = null;	
    	Driver dbDriver = null;
        PreparedStatement pstmt = null;   
       try 
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();     
            //conn.setAutoCommit(false);	
        	stmt = conn.createStatement();            
            
        	sql = " SELECT rp.empno, To_Char(rp.erptdatetime,'yyyy/mm/dd hh24:mi') sbdate, ov.series_num, " +
        		  " ov.port_a, ov.port_b, ov.fltno, To_Char(ov.skj_report_gmt,'yyyy/mm/dd hh24:mi') skj_report_gmt, ov.paymm " +
        		  " FROM fztsbrpt  rp, dftovrp ov " +
        		  " where  rp.empno = ov.empno " +
        		  " AND rp.erptdatetime BETWEEN To_Date('"+year+month+"01 00:00','yyyymmdd hh24:mi')  " +
        		  " AND Last_Day(To_Date('"+year+month+"01 23:59','yyyymmdd hh24:mi') ) " +
        		  " AND rrptdatetime IS NOT NULL " +
        		  " AND ov.paymm = to_char(last_day(to_date('"+year+month+"01','yyyymmdd'))+1,'yyyymm') " +
        		  " AND Trunc(rp.erptdatetime,'dd') = Trunc(ov.skj_report_gmt,'dd')  AND ov.port_a IN ('KHH','TPE') " +
        		  " AND ov.skj_report_gmt > rp.erptdatetime AND ov.duty_seq_num = 1 ";       
        	
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);  
            
            while (rs.next())
            {
                OverTimeObj obj = new OverTimeObj();
                obj.setSeries_num(rs.getString("series_num"));
                obj.setEmpno(rs.getString("empno"));
                obj.setPort_a(rs.getString("Port_a"));
                obj.setPort_b(rs.getString("Port_b"));
                obj.setFltno(rs.getString("fltno"));               
                obj.setSkj_takeoff_gmt(rs.getString("skj_report_gmt"));
                obj.setSbdate(rs.getString("sbdate"));
                obj.setPaymm(rs.getString("paymm"));
                sbAL.add(obj);
            } 
               
            if(sbAL.size() > 0)
            {
                sql = " update dftovrp set sbdate = to_date(?,'yyyy/mm/dd hh24:mi'), sbmins = 0 " + 	  
		          	  " where series_num = to_number(?) and duty_seq_num = 1 and empno = ? " +
		          	  " and fltno = ? and port_a = ? and port_b = ? and paymm = ? ";
                pstmt = conn.prepareStatement(sql);
                
                int count2 =0;
                for (int i = 0; i < sbAL.size(); i++)
                {
                    OverTimeObj obj = (OverTimeObj) sbAL.get(i);                   
                    int j=1;
                    pstmt.setString(j , obj.getSbdate());
                    pstmt.setString(++j , obj.getSeries_num());
                    pstmt.setString(++j , obj.getEmpno());                    
                    pstmt.setString(++j , obj.getFltno());                    
                    pstmt.setString(++j , obj.getPort_a());
                    pstmt.setString(++j , obj.getPort_b());      
                    pstmt.setString(++j , obj.getPaymm());   
                    //pstmt.addBatch();
                    //count2++;
                    //if (count2 == 1)
					//{
					    try
					    {
					        //pstmt.executeBatch();
					        pstmt.executeUpdate();
					    }
					    catch ( SQLException e )
				        {
					        sb.append(e.toString()+"\r\n ");
					        System.out.println(e.toString());
				        }
						//pstmt.clearBatch();
						//count2 = 0;
					//}                    
                }   
                
//                if(count2>0)
//                { 
//                    try
//				    {
//					    pstmt.executeBatch();						    
//				    }
//				    catch ( SQLException e )
//			        {
//				        sb.append(e.toString()+" \r\n ");
//				        System.out.println(e.toString());
//			        }  
//				    pstmt.clearBatch();
//					count2 = 0;     
//				}                
             }
            //***************************************************************************************
            //Calculate standby mins
            sql = " update dftovrp set sbmins = CASE WHEN Round((skj_report_gmt-sbdate)*60*24,0) <=0 " +
            	  " THEN 0 ELSE Round((skj_report_gmt-sbdate)*60*24,0) END " +
            	  " where  paymm = to_char(last_day(to_date('"+year+month+"01','yyyymmdd'))+1,'yyyymm') " +
            	  " AND sbdate IS NOT NULL ";            
            stmt.executeUpdate(sql);
            
//            System.out.println("Done Calculate standby mins");
            
            //***************************************************************************************
            //update new overmins, sbirflag is null
            //SB crew 抓飛,且不是特殊航班
            sql = " update dftovrp set overmins = CASE WHEN ((workmins+sbmins) - basemins) <=0 THEN 0 " +
            	  " ELSE ((workmins+sbmins) - basemins) end, sbirflag = 'S' " +
            	  " WHERE paymm = to_char(last_day(to_date('"+year+month+"01','yyyymmdd'))+1,'yyyymm') " +
            	  " AND sbdate IS NOT NULL  AND sbirflag IS null ";            
            stmt.executeUpdate(sql);    
//            System.out.println("update new overmins, sbirflag is null");
//            //***************************************************************************************
//            //update new overmins, sbirflag = Y, 特殊航班, 且 overmins  > 0 
              //SB crew 抓飛,且為特殊航班
            sql = " update dftovrp set overmins = overmins+sbmins, sbirflag = 'I' " +
		      	  " WHERE paymm = to_char(last_day(to_date('"+year+month+"01','yyyymmdd'))+1,'yyyymm') " +
		      	  " AND sbdate IS NOT NULL  AND sbirflag = 'Y' and overmins>0 ";       
            stmt.executeUpdate(sql);
//            System.out.println("SB crew 抓飛,且為特殊航班");
//            //***************************************************************************************
//            //update new overmins, sbirflag = Y, 特殊航班, 且 overmins > basetime
              //特殊航班, overmins 超過 basemins, 須加至 overmins2
            sql = " update dftovrp set overmins = (960-basemins), overmins2 = overmins-(960-basemins)+ overmins2, " +
            	  " sbirflag = 'R' " +
		      	  " WHERE paymm = to_char(last_day(to_date('"+year+month+"01','yyyymmdd'))+1,'yyyymm') " +
		      	  " AND sbdate IS NOT NULL  AND sbirflag = 'I' and  overmins < (960-basemins) ";       
            stmt.executeUpdate(sql);  
//            System.out.println("特殊航班, overmins 超過 basemins, 須加至 overmins2");
////          ***************************************************************************************
//            //刪除無延長工時資料
            sql = " delete dftovrp " +
		      	  " WHERE paymm = to_char(last_day(to_date('"+year+month+"01','yyyymmdd'))+1,'yyyymm') " +
		      	  " AND overmins <= 0 ";       
            stmt.executeUpdate(sql);   
//            System.out.println("刪除無延長工時資料");
//            //***************************************************************************************
            //conn.commit();	 
   			errorstr="Y";
            
        } 
        catch (SQLException e) 
        {
            System.out.print("adjSB 1 -->"+e.toString());
            errorstr=e.toString();
//    		try { conn.rollback(); } //if fail rollback
//    		catch (SQLException e1) { errorstr=e.toString(); }
        } 
        catch (Exception e) 
        {
            System.out.print("adjSB 2 -->"+e.toString());
            errorstr=e.toString();
        } 
        finally 
        {
            if ( rs != null ) try {
                rs.close();
            } catch (SQLException e) {}
            if ( stmt != null ) try {
                stmt.close();
            } catch (SQLException e) {}
            if ( pstmt != null ) try {
                pstmt.close();
            } catch (SQLException e) {}
            if ( conn != null ) try {
                conn.close();
            } catch (SQLException e) {}
        }
       
    }
    
    public String getErrorStr()
    {
        return sb.toString() +" -- " +errorstr;
    }

}
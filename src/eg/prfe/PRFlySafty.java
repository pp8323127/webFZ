package eg.prfe;

import java.sql.*;
import java.util.*;
import ci.db.*;

/**
 * @author cs71 Created on  2009/6/6
 */
public class PRFlySafty
{
    private ArrayList objAL = new ArrayList();
    private String returnStr = "";   
    private String sql = "";     

    public static void main(String[] args)
    {
        PRFlySafty prfs = new PRFlySafty();
        prfs.getSchForMP("631442","201411");

        System.out.println(prfs.getObjAL().size());
//        System.out.println(prfs.getScore(prfe.getObjAL()));
    }
    
    //201410 add
    public void getSchForMP(String empno ,String yyyymm){
    	Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        
        try 
        {
			ConnDB cn = new ConnDB();
			cn.setAOCIPRODCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);
			stmt = conn.createStatement();
			
            sql = "select dps.flt_num fltno,  " +
            		"  to_char(dps.str_dt_tm_loc, 'yyyy/mm/dd') fdate," +
            		"  to_char(str_dt_tm_loc, 'yyyy/mm/dd hh24:mi') stdDt," +
            		"       to_char(dps.end_dt_tm_loc, 'yyyy/mm/dd') edate," +
            		"       to_char(end_dt_tm_loc, 'yyyy/mm/dd hh24:mi') endDt," +
            		"       dps.act_port_a dpt," +
            		"       dps.act_port_b arv," +
            		"       r.acting_rank qual," +
            		"       r.special_indicator," +
            		"       Nvl(da13_v.DA13_ACNO,'X') acno," +
            		"       Nvl(da13_v.DA13_ACTP,'XXX') actp" +
            		"  from duty_prd_seg_v dps, roster_v r, v_ittda13_ci da13_v" +
            		" where dps.series_num = r.series_num" +
            		"   and dps.flt_num = da13_v.da13_fltno(+)" +
            		"   and dps.act_port_a = da13_v.da13_fm_sector(+)" +
            		"   and dps.act_port_b = da13_v.da13_to_sector(+)" +
            		"   and dps.str_dt_tm_gmt - (8 / 24) between da13_v.da13_stdu(+) - 1 / 8 and" +
            		"       da13_v.da13_stdu(+) + 1 / 8    and dps.delete_ind = 'N'" +
            		"   AND r.delete_ind = 'N'" +
            		"   and r.staff_num = '"+empno+"'" +
            		"   AND da13_v.DA13_SCDATE_U(+) BETWEEN" +
            		"       to_date('"+yyyymm+"01 00:00', 'yyyymmdd hh24:mi') - 1 AND" +
            		"       Last_Day(To_Date('"+yyyymm+"01 23:59', 'yyyymmdd hh24:mi')) + 1" +
            		"   AND dps.act_str_dt_tm_gmt BETWEEN" +
            		"       to_date('"+yyyymm+"01 00:00', 'yyyymmdd hh24:mi') AND" +
            		"       Last_Day(To_Date('"+yyyymm+"01 23:59', 'yyyymmdd hh24:mi'))" +
            		"   AND r.duty_cd = 'FLY'   AND dps.duty_cd IN ('FLY', 'TVL') " +
            		"   AND Nvl(r.special_indicator,' ') in ('S','P') ";//·þ¾É­¸¦æ
            objAL = new ArrayList();
//			System.out.println(sql);
            rs = stmt.executeQuery(sql);        
			while (rs.next()) {
				PRFlySchObj obj = new PRFlySchObj();
				obj.setFdate(rs.getString("fdate").trim());
				obj.setFltno(rs.getString("fltno").trim());
				obj.setSdate(rs.getString("stdDt").trim());
				obj.setDep(rs.getString("dpt").trim());
				obj.setArv(rs.getString("arv").trim());
				obj.setAcno(rs.getString("acno").trim());
				obj.setActp(rs.getString("actp").trim());
				if(obj.getActp().substring(0,2).equals("74")){
					obj.setActp("744");
				}else if(obj.getActp().substring(0,2).equals("77")){
					obj.setActp("777");
				}else if(obj.getActp().substring(0,2).equals("33")){
					obj.setActp("330");
				}else if(obj.getActp().substring(0,2).equals("73")){
					obj.setActp("738");
				}else if(obj.getActp().substring(0,2).equals("34")){
					obj.setActp("343");
				}
				objAL.add(obj);
			}
			rs.close();
			stmt.close();
			conn.close();
			
            cn.setORP3FZUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            stmt   = conn.createStatement();
			
            if(objAL.size()>0){
				for(int i=0 ;i<objAL.size();i++){
					PRFlySchObj obj = (PRFlySchObj) objAL.get(i);
					sql = "select sern ,cname ,trim(empn) empn from egtcbas where trim(empn) in ( " +
							" select  r.staff_num"+//dps.flt_num fltno, str_dt_tm_loc,
							"	  from duty_prd_seg_v dps, roster_v r"+
							"	  where dps.series_num = r.series_num"+
							"	    and dps.delete_ind = 'N'"+
							"	    AND r.delete_ind = 'N'"+
							"	    AND dps.act_str_dt_tm_gmt between to_date('"+obj.getSdate()+"', 'yyyy/mm/dd hh24:mi') -1/8" +
							"   	AND to_date('"+obj.getSdate()+"', 'yyyy/mm/dd hh24:mi') +1/8" +
							"		AND dps.flt_num = '"+obj.getFltno()+"'"+ 
							"	    AND r.duty_cd = 'FLY'"+
							"	    AND dps.duty_cd IN ('FLY', 'TVL')"+
							"	    and r.acting_rank = 'PR'"+
							"	    AND Nvl(r.special_indicator, '') not in ('I', 'S', 'P')" +
							" )";
							rs = stmt.executeQuery(sql);
				    if(rs.next()){
				    	obj.setCmCname(rs.getString("cname"));
						obj.setCmSern(rs.getString("sern"));
						obj.setCmEmpn(rs.getString("empn"));						
				    }
					objAL.set(i, obj);
				}
				
				
			}
            /*for(int i=0; i<objAL.size(); i++)
            {
                rs.close();
                PRFlySaftyObj obj = (PRFlySaftyObj) objAL.get(i);                
                sql = " SELECT Count(*) c FROM egtstdt WHERE sernno = '"+obj.getSernno()+"' ";
//                System.out.println(sql);
                rs = stmt.executeQuery(sql);        
                while(rs.next())
                {
                    if(rs.getInt("c")>0)
                    {
                        obj.setFly_safty("Y");
                    }
                    else
                    {
                        obj.setFly_safty("N");
                    }
                }
               
            }*/
        } 
        catch (SQLException e) 
        {
            System.out.print(e.toString());
            returnStr = e.toString();
        } 
        catch (Exception e) 
        {
            System.out.print(e.toString());
            returnStr = e.toString();
        }
        finally 
        {

            if ( rs != null ) try {
                rs.close();
            } catch (SQLException e) {}
            if ( stmt != null ) try {
                stmt.close();
            } catch (SQLException e) {}
            if ( conn != null ) try {
                conn.close();
            } catch (SQLException e) {}

        }
    	
    }
    
    
    public void getCaseStatus(String sdate, String edate)
    {
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        
        try 
        {
            ConnDB cn = new ConnDB();
            cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            stmt   = conn.createStatement();
            
//            cn.setORP3EGUser();
//            cn.setORT1EG();
//            java.lang.Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() , cn.getConnPW());      
//            stmt = conn.createStatement();

            sql = " SELECT ti.sernno, To_Char(ti.fltd,'yyyy/mm/dd') fltd2, ti.fltno, ti.trip, " +
            	  " ti.pursern, cb.cname purname, cb.empn purempno, ti.instempno, hr.cname instname, " +
            	  " ti.caseclose, To_Char(ti.close_tmst,'yyyy/mm/dd hh24:mi') close_tmst2, " +
            	  " To_Char(ti.confirm_tmst,'yyyy/mm/dd hh24:mi') confirm_tmst2, ti.close_user  " +
            	  " FROM egtstti ti, egtcbas cb, hrvegemploy hr " +
            	  " WHERE ti.fltd BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+"','yyyy/mm/dd') " +
            	  " AND cb.sern = ti.pursern  AND ti.instempno = hr.employid (+) order by ti.fltd ";
            
//			System.out.println(sql);
            rs = stmt.executeQuery(sql);        
            while (rs.next()) 
            {
                PRFlySaftyObj obj = new PRFlySaftyObj();   
                obj.setSernno(rs.getString("sernno"));
                obj.setFltd(rs.getString("fltd2"));
                obj.setFltno(rs.getString("fltno"));
                obj.setTrip(rs.getString("trip"));
                obj.setPursern(rs.getString("pursern"));
                obj.setPurname(rs.getString("purname"));
                obj.setPurempno(rs.getString("purempno"));
                obj.setInstempno(rs.getString("instempno"));
                obj.setInstname(rs.getString("instname"));
                obj.setCaseclose(rs.getString("caseclose"));
                obj.setClose_tmst(rs.getString("close_tmst2"));    
                obj.setClose_user(rs.getString("close_user"));    
                obj.setConfirm_tmst(rs.getString("confirm_tmst2"));
                objAL.add(obj);
            }
           
            
            for(int i=0; i<objAL.size(); i++)
            {
                rs.close();
                PRFlySaftyObj obj = (PRFlySaftyObj) objAL.get(i);                
                sql = " SELECT Count(*) c FROM egtstdt WHERE sernno = '"+obj.getSernno()+"' ";
//                System.out.println(sql);
                rs = stmt.executeQuery(sql);        
                while(rs.next())
                {
                    if(rs.getInt("c")>0)
                    {
                        obj.setFly_safty("Y");
                    }
                    else
                    {
                        obj.setFly_safty("N");
                    }
                }
     
               //***************************************************************************
                sql = " SELECT Count(*) c FROM egtstcc WHERE sernno = '"+obj.getSernno()+"' ";
//                System.out.println(sql);
                rs = stmt.executeQuery(sql);        
                while(rs.next())
                {
                    if(rs.getInt("c")>0)
                    {
                        obj.setSelf_insp("Y");
                    }
                    else
                    {
                        obj.setSelf_insp("N");
                    }
                }

                //***************************************************************************
                sql = " SELECT Count(*) c FROM egtprfe WHERE sernno = '"+obj.getSernno()+"' ";
//                System.out.println(sql);
                rs = stmt.executeQuery(sql);        
                while(rs.next())
                {
                    if(rs.getInt("c")>0)
                    {
                        obj.setFunc_eval("Y");
                    }
                    else
                    {
                        obj.setFunc_eval("N");
                    }
                }    
            }
        } 
        catch (SQLException e) 
        {
            System.out.print(e.toString());
            returnStr = e.toString();
        } 
        catch (Exception e) 
        {
            System.out.print(e.toString());
            returnStr = e.toString();
        }
        finally 
        {

            if ( rs != null ) try {
                rs.close();
            } catch (SQLException e) {}
            if ( stmt != null ) try {
                stmt.close();
            } catch (SQLException e) {}
            if ( conn != null ) try {
                conn.close();
            } catch (SQLException e) {}

        }
    }
    
    public void getPRConfirmCase(String empno)
    {
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        
        try 
        {
            ConnDB cn = new ConnDB();
            cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            stmt   = conn.createStatement();
            
//            cn.setORP3EGUser();
//            cn.setORT1EG();
//            java.lang.Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() , cn.getConnPW());      
//            stmt = conn.createStatement();

            sql = " SELECT ti.sernno, To_Char(ti.fltd,'yyyy/mm/dd') fltd2, ti.fltno, ti.trip, " +
            	  " ti.pursern, cb.cname purname, cb.empn purempno, ti.instempno, hr.cname instname, " +
            	  " ti.caseclose, To_Char(ti.close_tmst,'yyyy/mm/dd hh24:mi') close_tmst2, " +
            	  " To_Char(ti.confirm_tmst,'yyyy/mm/dd hh24:mi') confirm_tmst2, ti.close_user  " +
            	  " FROM egtstti ti, egtcbas cb, hrvegemploy hr " +
            	  " WHERE ti.fltd BETWEEN sysdate-365 AND sysdate and caseclose='Y' and confirm_tmst is null " +
            	  " and cb.empn = '"+empno+"' AND cb.sern = ti.pursern  AND ti.instempno = hr.employid (+) " +
            	  " order by ti.fltd ";
            
//			System.out.println(sql);
            rs = stmt.executeQuery(sql);        
            while (rs.next()) 
            {
                PRFlySaftyObj obj = new PRFlySaftyObj();   
                obj.setSernno(rs.getString("sernno"));
                obj.setFltd(rs.getString("fltd2"));
                obj.setFltno(rs.getString("fltno"));
                obj.setTrip(rs.getString("trip"));
                obj.setPursern(rs.getString("pursern"));
                obj.setPurname(rs.getString("purname"));
                obj.setPurempno(rs.getString("purempno"));
                obj.setInstempno(rs.getString("instempno"));
                obj.setInstname(rs.getString("instname"));
                obj.setCaseclose(rs.getString("caseclose"));
                obj.setClose_tmst(rs.getString("close_tmst2"));    
                obj.setClose_user(rs.getString("close_user"));    
                obj.setConfirm_tmst(rs.getString("confirm_tmst2"));
                objAL.add(obj);
            }
        } 
        catch (SQLException e) 
        {
            System.out.print(e.toString());
            returnStr = e.toString();
        } 
        catch (Exception e) 
        {
            System.out.print(e.toString());
            returnStr = e.toString();
        }
        finally 
        {

            if ( rs != null ) try {
                rs.close();
            } catch (SQLException e) {}
            if ( stmt != null ) try {
                stmt.close();
            } catch (SQLException e) {}
            if ( conn != null ) try {
                conn.close();
            } catch (SQLException e) {}

        }
    }
    
    public void getPRChkCase(String sdate, String edate, String empno)
    {
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        
        try 
        {
            ConnDB cn = new ConnDB();
            cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            stmt   = conn.createStatement();
            
//            cn.setORP3EGUser();
//            cn.setORT1EG();
//            java.lang.Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() , cn.getConnPW());      
//            stmt = conn.createStatement();

            sql = " SELECT ti.sernno, To_Char(ti.fltd,'yyyy/mm/dd') fltd2, ti.fltno, ti.trip, " +
            	  " ti.pursern, cb.cname purname, cb.empn purempno, ti.instempno, hr.cname instname, " +
            	  " ti.caseclose, To_Char(ti.close_tmst,'yyyy/mm/dd hh24:mi') close_tmst2, " +
            	  " To_Char(ti.confirm_tmst,'yyyy/mm/dd hh24:mi') confirm_tmst2, ti.close_user  " +
            	  " FROM egtstti ti, egtcbas cb, hrvegemploy hr " +
            	  " WHERE ti.fltd BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+"','yyyy/mm/dd') " +
            	  " and caseclose='Y'  AND confirm_tmst IS NOT null " +
            	  " and cb.empn = '"+empno+"' AND cb.sern = ti.pursern  AND ti.instempno = hr.employid (+) " +
            	  " order by ti.fltd ";
            
//			System.out.println(sql);
            rs = stmt.executeQuery(sql);        
            while (rs.next()) 
            {
                PRFlySaftyObj obj = new PRFlySaftyObj();   
                obj.setSernno(rs.getString("sernno"));
                obj.setFltd(rs.getString("fltd2"));
                obj.setFltno(rs.getString("fltno"));
                obj.setTrip(rs.getString("trip"));
                obj.setPursern(rs.getString("pursern"));
                obj.setPurname(rs.getString("purname"));
                obj.setPurempno(rs.getString("purempno"));
                obj.setInstempno(rs.getString("instempno"));
                obj.setInstname(rs.getString("instname"));
                obj.setCaseclose(rs.getString("caseclose"));
                obj.setClose_tmst(rs.getString("close_tmst2"));    
                obj.setClose_user(rs.getString("close_user"));    
                obj.setConfirm_tmst(rs.getString("confirm_tmst2"));
                objAL.add(obj);
            }
        } 
        catch (SQLException e) 
        {
            System.out.print(e.toString());
            returnStr = e.toString();
        } 
        catch (Exception e) 
        {
            System.out.print(e.toString());
            returnStr = e.toString();
        }
        finally 
        {

            if ( rs != null ) try {
                rs.close();
            } catch (SQLException e) {}
            if ( stmt != null ) try {
                stmt.close();
            } catch (SQLException e) {}
            if ( conn != null ) try {
                conn.close();
            } catch (SQLException e) {}

        }
    }
    
    
    public String getReturnStr() {
		return returnStr;
	}

	public void setReturnStr(String returnStr) {
		this.returnStr = returnStr;
	}

	public ArrayList getObjAL()
    {
        return objAL;
    }
}

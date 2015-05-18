package fz.projectinvestigate;

import java.sql.*;
import java.util.*;
import ci.db.*;

/**
 * @author cs71 Created on  2008/9/25
 */
public class PRPJIssue
{

	private String jobtype = "";
	private String returnstr = "";
	ArrayList proj_noAL = new ArrayList();
	ArrayList bankobjAL = null;
	private String fleet = "";
	private String acno = "";
	
	
    public static void main(String[] args)
    {
        PRPJIssue pj = new PRPJIssue();
        
//        pj.getPRProj_no("2009/06/30","0011","ANC","TPE","630536","","");
        pj.getPRProj_no("2012/03/06","0601","TPE","HKG","630752","","");
//        pj.getBankItemno("1,3");
//        pj.getBankItemno("1,3", "2009/02/06", "0008", "TPE","LAX", "631451", "", "");
//        pj.getPRProj("2009/02/06", "0008", "TPELAX", "631451") ;
        System.out.println(pj.getProj_noAL().size());
        System.out.println("Done");
    }
    
    //取得專案調查題目
    public void getPRProj_no(String fltd, String fltno, String dpt, String arv, String empno, String tempfleet, String tempacno) 
    {   
        Connection conn = null;
    	Statement stmt = null;
    	ResultSet rs = null;	
    	String sql = null;
    	Driver dbDriver = null;    	
    	this.fleet = tempfleet;
    	this.acno = tempacno;
    	
        if("".equals(acno) | acno == null)
        {
            fz.pracP.GetFltInfo ft = new fz.pracP.GetFltInfo(fltd, fltno);
            ArrayList dataAL = new ArrayList();
            try 
            {
            	ft.RetrieveData();
            	dataAL = ft.getDataAL();
            	if(dataAL.size()>0)
            	{
            	    for(int i =0; i < dataAL.size(); i++)
            	    {
            	        fz.prObj.FltObj obj = (fz.prObj.FltObj) dataAL.get(i);
        				String temparv = obj.getArv();
        				String tempdpt = obj.getDpt();
        				if(temparv.equals(arv) && tempdpt.equals(dpt))
        				{
        				    acno = obj.getAcno();
        				}
            	    }            	    
            	}        	

            } catch (SQLException e) {
            	System.out.println(e.toString());
            } catch (Exception e) {
            	System.out.println(e.toString());
            }
        }//if("".equals(acno) | acno == null)
        //**********************************************************************************8
        if("".equals(fleet) | fleet == null)
        {
            try
            {           
                ConnDB cn = new ConnDB();
                ConnectionHelper ch = new ConnectionHelper();
                conn = ch.getConnection();
                stmt = conn.createStatement();	
    			
                //purser report SQL               
                
    			sql = " select dps.fleet_cd, dps.duty_cd,to_char(dps.str_dt_tm_loc,'yyyy/mm/dd') fdate, " +
	                 " dps.flt_num fltno,to_char(str_dt_tm_loc,'yyyy/mm/dd hh24:mi') stdDt, " +
	       		     " dps.port_a dpt,dps.port_b arv,r.acting_rank qual " +
	       		     " from fzdb.duty_prd_seg_v dps, fzdb.roster_v r where dps.series_num=r.series_num " +
	       		     " and dps.delete_ind = 'N' AND  r.delete_ind='N' " +
	       		     " and r.staff_num ='"+empno+"' AND dps.act_str_dt_tm_gmt BETWEEN  " +
	       		     " to_date('"+fltd+" 00:00','yyyy/mm/dd hh24:mi') AND " +
	       		     " To_Date('"+fltd+" 23:59','yyyy/mm/dd hh24:mi') " +
	       		     " and port_a = '"+dpt+"' and port_b = '"+arv+"' and flt_num = '"+fltno+"' " +
	       		     " AND r.duty_cd='FLY' AND dps.duty_cd IN ('FLY','TVL') AND  r.acting_rank='PR' " +
	       		     " order by str_dt_tm_gmt  ";
  		
//    			System.out.println(sql);
    			rs = stmt.executeQuery(sql);
    			while(rs.next())
    			{
    			    fleet = rs.getString("fleet_cd");
    			}
//    			System.out.println(fleet);
            }
            catch (Exception e)
            {               
                   System.out.println(e.toString());
            } 
            finally
            {
                try{if(rs != null) rs.close();}catch (Exception e){}
            	try{if(stmt != null) stmt.close();}catch (Exception e){}
            	try{if(conn != null) conn.close();}catch (Exception e){}        	
            }
        }//if("".equals(fleet) | fleet == null)
        
       //*****************************************************************************************
        try
        {  
            ArrayList tempAL = new ArrayList();
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
			
//            //purser report SQL
            // 各條件為 OR 關係
//            sql = " SELECT proj_no FROM ( " +
//		      	  " SELECT * FROM egtpjti " +
//		      	  " WHERE To_Date('"+fltd+"','yyyy/mm/dd') BETWEEN effdt AND expdt " +
//		      	  " AND ( (condi_col = 'FLEET' AND condi_val = RPad(SubStr('"+fleet+"',1,2),3,0)) or " +
//		      	  " (condi_col = 'FLTNO' AND condi_val = '"+fltno+"') " +
//		      	  " OR (condi_col = 'DEP' AND condi_val = '"+dpt+"') OR " +
//		      	  " (condi_col = 'ARV' AND condi_val = '"+arv+"') OR (condi_col = 'ACNO' AND condi_val = '"+acno+"') ) " +
//		      	  " AND projtype <> 'D' " +
//		      	  " UNION ALL " +
//		      	  " SELECT * FROM egtpjti " +
//		      	  " WHERE To_Date('"+fltd+"','yyyy/mm/dd') BETWEEN effdt AND expdt " +
//		      	  " AND ( (condi_col = 'FLEET' AND condi_val = RPad(SubStr('"+fleet+"',1,2),3,0)) or " +
//		      	  " (condi_col = 'FLTNO' AND condi_val = '"+fltno+"') " +
//		      	  " OR (condi_col = 'DEP' AND condi_val = '"+dpt+"') " +
//		      	  " OR (condi_col = 'ARV' AND condi_val = '"+arv+"') OR (condi_col = 'ACNO' AND condi_val = '"+acno+"') ) " +
//		      	  " AND empno in ( select r.staff_num from fzdb.duty_prd_seg_v dps, fzdb.roster_v r " +
//		      	  " where dps.series_num=r.series_num and dps.delete_ind = 'N' AND  r.delete_ind='N' " +
//		      	  " AND dps.act_str_dt_tm_gmt BETWEEN to_date('"+fltd+" 00:00','yyyy/mm/dd hh24:mi') " +
//		      	  " AND To_Date('"+fltd+" 23:59','yyyy/mm/dd hh24:mi') " +
//		      	  " and port_a = '"+dpt+"' and port_b = '"+arv+"' and flt_num = '"+fltno+"' " +
//		      	  " AND r.duty_cd='FLY' AND dps.duty_cd IN ('FLY','TVL') ) AND projtype = 'D' " +
//		      	  " ) GROUP BY proj_no ";
            
            sql = " SELECT proj_no FROM ( " +
		      	  " SELECT * FROM egtpjti " +
		      	  " WHERE To_Date('"+fltd+"','yyyy/mm/dd') BETWEEN effdt AND expdt " +
		      	  " AND ( (condi_col = 'FLEET' AND condi_val = RPad(SubStr('"+fleet+"',1,2),3,0)) or " +
		      	  " (condi_col = 'FLTNO' AND condi_val = '"+fltno+"') " +
		      	  " OR (condi_col = 'DEP' AND condi_val = '"+dpt+"') OR " +
		      	  " (condi_col = 'ARV' AND condi_val = '"+arv+"') OR (condi_col = 'ACNO' AND condi_val = '"+acno+"') ) " +
		      	  " AND projtype <> 'D' " +
		      	  " UNION ALL " +
		      	  " SELECT * FROM egtpjti " +
		      	  " WHERE To_Date('"+fltd+"','yyyy/mm/dd') BETWEEN effdt AND expdt " +
		      	  " AND ( (condi_col = 'FLEET' AND condi_val = RPad(SubStr('"+fleet+"',1,2),3,0)) or " +
		      	  " (condi_col = 'FLTNO' AND condi_val = '"+fltno+"') " +
		      	  " OR (condi_col = 'DEP' AND condi_val = '"+dpt+"') " +
		      	  " OR (condi_col = 'ARV' AND condi_val = '"+arv+"') OR (condi_col = 'ACNO' AND condi_val = '"+acno+"') ) " +
		      	  " AND empno in ( select r.staff_num from fzdb.duty_prd_seg_v dps, fzdb.roster_v r " +
		      	  " where dps.series_num=r.series_num and dps.delete_ind = 'N' AND  r.delete_ind='N' " +
		      	  " AND dps.act_str_dt_tm_gmt BETWEEN to_date('"+fltd+" 00:00','yyyy/mm/dd hh24:mi') " +
		      	  " AND To_Date('"+fltd+" 23:59','yyyy/mm/dd hh24:mi') " +
		      	  " and port_a = '"+dpt+"' and port_b = '"+arv+"' and flt_num = '"+fltno+"' " +
		      	  " AND r.duty_cd='FLY' AND dps.duty_cd IN ('FLY','TVL') ) AND projtype = 'D' " +
		      	  " ) GROUP BY proj_no ";
            
//			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			while(rs.next())
			{
			    tempAL.add(rs.getString("proj_no"));
			}
//System.out.println("tempAL.size() "+tempAL.size());			
			
			for(int i=0; i<tempAL.size(); i++)
			{
			    boolean ifmatchcondi = true;
			    //*******************************************************************************************
			    ArrayList tempfltnoAL = new ArrayList();
			    sql = " select condi_val from egtpjti where proj_no = '"+tempAL.get(i)+"' and condi_col = 'FLTNO'";			    
//System.out.println(sql);
			    rs = stmt.executeQuery(sql);			    
				while(rs.next())
				{
				    tempfltnoAL.add(rs.getString("condi_val"));		    
				}
				
				if(tempfltnoAL.size()>=1)
				{//代表有Fltno條件
				    int matchfltnocnt =0;
				    for(int j=0; j<tempfltnoAL.size(); j++)
				    {
				        if(fltno.equals(tempfltnoAL.get(j)))
				        {
				            matchfltnocnt++;
				        }
				    }
				    
				    if(matchfltnocnt<=0)
				    {
				        ifmatchcondi = false;	
				    }
				}		
			    //*******************************************************************************************
			    sql = " select * from egtpjti where proj_no = '"+tempAL.get(i)+"' and condi_col <> 'FLTNO' ";
			    
//System.out.println(sql);
			    rs = stmt.executeQuery(sql);
				while(rs.next())
				{
//				    System.out.println(rs.getString("condi_col"));
//				    System.out.println(rs.getString("condi_val"));
				    if("DEP".equals(rs.getString("condi_col")))
				    {
				      if(!dpt.equals(rs.getString("condi_val")))  
				      {
				          ifmatchcondi = false;
				      }
				    }
				    
				    if("ARV".equals(rs.getString("condi_col")))
				    {
				      if(!arv.equals(rs.getString("condi_val")))  
				      {
				          ifmatchcondi = false;
				      }
				    }
				    
				    if("ACNO".equals(rs.getString("condi_col")))
				    {
				      if(!acno.equals(rs.getString("condi_val")))  
				      {
				          ifmatchcondi = false;
				      }
				    }
				    
				    if("FLEET".equals(rs.getString("condi_col")))
				    {
			    				        
				      if(!fleet.substring(0,2).equals(rs.getString("condi_val").substring(0,2)))  
				      {
				          ifmatchcondi = false;
				      }
				    }				    
				}
				
				if(ifmatchcondi== true)
				{
				    proj_noAL.add(tempAL.get(i));
				}			    
			}//for(int i=0; i<tempAL.size(); i++)
        }
        catch (Exception e)
        {               
               System.out.println(e.toString());
        } 
        finally
        {
            try{if(rs != null) rs.close();}catch (Exception e){}
        	try{if(stmt != null) stmt.close();}catch (Exception e){}
        	try{if(conn != null) conn.close();}catch (Exception e){}        	
        }
   } 
    
    public void getBankItemno(String proj_no) //1,2,3 or 2
    {   
        Connection conn = null;
    	Statement stmt = null;
    	ResultSet rs = null;	
    	String sql = null;
    	Driver dbDriver = null;
    	
        try
        {  
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();	
            
			sql = " SELECT tb.proj_no proj_no, fm.subject subject, pe.proj_event event, tb.itemno itemno, fi.itemdesc itemdesc, " +
				  " fi.kin kin, fi.qtype qtype, ti.empno empno " +
				  " FROM egtpjtb tb,egtpsfi fi, egtpjpe pe, egtpsfm fm, " +
				  " (select proj_no, empno from  EGTPJTI WHERE proj_no IN ("+proj_no+") GROUP BY proj_no, empno ) ti  " +
				  " WHERE tb.proj_no in ("+proj_no+") AND tb.proj_no = pe.proj_no AND tb.proj_no = ti.proj_no (+) " +
				  " AND tb.itemno = fi.itemno AND fm.itemno = fi.kin " +
				  " ORDER BY tb.proj_no, itemno";
//					System.out.println(sql);
			
			bankobjAL = new ArrayList();
			PRPJIssueObj emptyobj = new PRPJIssueObj();
			bankobjAL.add(emptyobj);
			rs = stmt.executeQuery(sql);
			while(rs.next())
			{
			    PRPJIssueObj obj = new PRPJIssueObj();
			    obj.setProj_no(rs.getString("proj_no"));
			    obj.setProjtype(rs.getString("kin"));
			    obj.setSubject(rs.getString("subject"));
			    obj.setProj_event(rs.getString("event"));
			    obj.setBankno(rs.getString("itemno"));
			    obj.setBankdesc(rs.getString("itemdesc"));			    
			    obj.setKin(rs.getString("kin"));
			    obj.setQtype(rs.getString("qtype"));	
			    obj.setEmpno(rs.getString("empno"));
			    bankobjAL.add(obj);
			}			
			//return al size at least 1
        }
        catch (Exception e)
        {               
               System.out.println(e.toString());
        } 
        finally
        {
            try{if(rs != null) rs.close();}catch (Exception e){}
        	try{if(stmt != null) stmt.close();}catch (Exception e){}
        	try{if(conn != null) conn.close();}catch (Exception e){}        	
        }
   } 
    
    public void getBankItemno(String topic_no, String fltd, String fltno, String dpt, String arv, String empno, String tempfleet, String tempacno) //1,2,3 or 2
    {   
        Connection conn = null;
    	Statement stmt = null;
    	ResultSet rs = null;	
    	String sql = null;
    	Driver dbDriver = null;
    	
        try
        {                     
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();	
            
            sql = " SELECT tb.proj_no proj_no, tb.itemno itemno, fi.itemdesc itemdesc, fi.kin kin, " +
            	  " fi.qtype qtype, Nvl(sf.chkempno, ti.empno) chkempno2, pe.proj_event proj_event, " +
            	  " fm.subject subject, sf.* " +
            	  " FROM egtpjtb tb, egtpsfi fi , egtpsfm fm, " +
            	  " (SELECT * FROM egtprpj WHERE fltdt = To_Date('"+fltd+"','yyyy/mm/dd') " +
            	  "  AND sect = '"+dpt+arv+"'  AND fltno = '"+fltno+"' AND empno = '"+empno+"') sf, " +
            	  " (SELECT proj_no, empno FROM egtpjti GROUP BY proj_no, empno) ti, egtpjpe pe " +
            	  " WHERE tb.proj_no in ("+topic_no+") AND tb.itemno = fi.itemno   AND tb.proj_no = sf.proj_no (+) " +
            	  " AND tb.proj_no = ti.proj_no AND tb.proj_no = pe.proj_no AND fm.itemno = fi.kin " +
            	  " AND tb.itemno = sf.itemno (+) ORDER BY tb.proj_no, tb.itemno ";
            returnstr = sql;
//			sql = " SELECT tb.topic_no topic_no, tb.itemno itemno, fi.itemdesc itemdesc, fi.kin kin, " +
//				  " fi.qtype qtype, sf.* FROM egtpstb tb,egtpsfi fi ," +
//				  " (SELECT * FROM egtprsf WHERE fltdt = To_Date('"+fltd+"','yyyy/mm/dd') AND sect = '"+dpt+arv+"' " +
//				  " AND fltno = '"+fltno+"' AND empno = '"+empno+"') sf " +
//				  " WHERE tb.topic_no in ("+topic_no+") AND tb.itemno = fi.itemno   AND tb.topic_no = sf.topic_no (+)  " +
//				  " AND tb.itemno = sf.itemno (+) ORDER BY tb.topic_no, tb.itemno ";			
//			System.out.println(sql);
			bankobjAL = new ArrayList();
			PRProjIssueObj emptyobj = new PRProjIssueObj();
			bankobjAL.add(emptyobj);
			rs = stmt.executeQuery(sql);
			while(rs.next())
			{
			    PRProjIssueObj obj = new PRProjIssueObj();
			    obj.setProj_no(rs.getString("proj_no"));
			    obj.setItemno(rs.getString("itemno"));
			    obj.setItemdesc(rs.getString("itemdesc"));
			    obj.setKin(rs.getString("kin"));
			    obj.setQtype(rs.getString("qtype"));
			    obj.setSubject(rs.getString("subject"));
			    obj.setProj_event(rs.getString("proj_event"));
			    obj.setChkempno(rs.getString("chkempno2"));
			    //EGInfo egi = new EGInfo(obj.getChkempno());
		        //EgInfoObj empobj = egi.getEGInfoObj(obj.getChkempno()); 
			    //obj.setChksern(empobj.getSern());
			    //obj.setChkcname(empobj.getCname());			    
			    obj.setProjtype(rs.getString("projtype"));
			    obj.setFeedback(rs.getString("feedback"));
//			    obj.setFeedback2(rs.getString("feedback2"));
			    obj.setComments(rs.getString("comments"));
			    obj.setFltdt(fltd);
			    obj.setFltno(fltno);
			    obj.setSect(dpt+arv);
			    obj.setEmpno(empno);
			    obj.setAcno(rs.getString("acno"));
			    if(rs.getString("fleet") == null | "".equals(rs.getString("fleet")))
			    {
			        obj.setFleet(tempfleet);
			    }
			    else
			    {
			        obj.setFleet(rs.getString("fleet"));
			    }
			    
			    if(rs.getString("acno") == null | "".equals(rs.getString("acno")))
			    {
			        obj.setAcno(tempacno);
			    }
			    else
			    {
			        obj.setAcno(rs.getString("acno"));
			    }		
			    
			   

			    obj.setNewdate(rs.getString("newdate"));			    
			    bankobjAL.add(obj);
			}
        }
        catch (Exception e)
        {               
               System.out.println(e.toString());
        } 
        finally
        {
            try{if(rs != null) rs.close();}catch (Exception e){}
        	try{if(stmt != null) stmt.close();}catch (Exception e){}
        	try{if(conn != null) conn.close();}catch (Exception e){}        	
        }
   } 
    
    public void getPRProj(String fltd, String fltno, String sect, String empno) 
    {   
        Connection conn = null;
    	Statement stmt = null;
    	ResultSet rs = null;	
    	String sql = null;
    	Driver dbDriver = null;
    	
        try
        {           
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();		
            
            sql = " SELECT sf.*, pe.proj_event, fm.subject, fi.itemdesc, To_Char(sf.fltdt,'yyyy/mm/dd') fltdt2 " +
            	  " FROM egtprpj sf, egtpjpe pe, egtpsfm fm, egtpsfi fi " +
            	  " WHERE sf.proj_no = pe.proj_no AND sf.fltdt = To_Date('"+fltd+"','yyyy/mm/dd') " +
            	  " AND sf.sect = '"+sect+"' " +
            	  " AND sf.fltno = '"+fltno+"' AND sf.empno = '"+empno+"' " +
            	  " AND fm.itemno = sf.projtype AND sf.itemno = fi.itemno " +
            	  " ORDER BY sf.proj_no,sf.itemno ";
			
//			System.out.println(sql);
            bankobjAL = new ArrayList();
			PRProjIssueObj emptyobj = new PRProjIssueObj();
			bankobjAL.add(emptyobj);
			rs = stmt.executeQuery(sql);
			while(rs.next())
			{
			    PRProjIssueObj obj = new PRProjIssueObj();
			    obj.setFltdt(rs.getString("fltdt2"));
			    obj.setFltno(rs.getString("fltno"));
			    obj.setSect(rs.getString("sect"));
			    obj.setEmpno(rs.getString("empno"));
			    obj.setFleet(rs.getString("fleet"));
			    obj.setAcno(rs.getString("acno"));	
			    obj.setProj_no(rs.getString("proj_no"));
			    obj.setProjtype(rs.getString("projtype"));			    
			    obj.setItemno(rs.getString("itemno"));
			    obj.setChkempno(rs.getString("chkempno"));
			    obj.setFeedback(rs.getString("feedback"));
			    obj.setComments(rs.getString("comments"));
			    obj.setProj_event(rs.getString("proj_event"));
			    obj.setSubject(rs.getString("subject"));
			    obj.setItemdesc(rs.getString("itemdesc"));
			    obj.setNewuser(rs.getString("newuser"));
			    obj.setNewdate(rs.getString("newdate"));			    
			    bankobjAL.add(obj);
			}
        }        
        catch (SQLException e)
        {               
               System.out.println(e.toString());
        } 
        catch (Exception e)
        {               
               System.out.println(e.toString());
        } 
        finally
        {
            try{if(rs != null) rs.close();}catch (Exception e){}
        	try{if(stmt != null) stmt.close();}catch (Exception e){}
        	try{if(conn != null) conn.close();}catch (Exception e){}        	
        }
   } 
    
    
    public String getSQL()
    {
        return returnstr;
    }
    
    public ArrayList getProj_noAL()
    {
        return proj_noAL;
    }
    
    public ArrayList getBankObjAL()
    {
        return bankobjAL;
    }
    
    public String getFleet()
    {
        return fleet;
    }
    
    public String getAcno()
    {
        return acno;
    }
}

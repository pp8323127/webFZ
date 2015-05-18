package fz.psfly;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * @author cs71 Created on  2008/9/25
 */
public class PRSFlyIssue
{

	private String jobtype = "";
	private String returnstr = "";
	ArrayList topic_noAL = new ArrayList();
	ArrayList bankobjAL = null;
	private String fleet = "";
	private String acno = "";
	
	
    public static void main(String[] args)
    {
//        PRSFlyIssue psf = new PRSFlyIssue();
////        psf.getPsflyTopic_no("2008/10/30", "0002", "TPE", "HNL", "629094", "343","12356") ;
//          psf.getBankItemno("2","2008/11/05", "0052", "SYD", "TPE", "631451", "343","12356");
//         
////        System.out.println(psf.getlistObjAL().size());
//        System.out.println(psf.getBankObjAL().size());          
//          System.out.println("Done");
        
        PRSFlyIssue psf = new PRSFlyIssue();
//        ArrayList bankItemobjAL = new ArrayList();
        ArrayList objAL = new ArrayList();
//        psf.getBankItemno("2");//blank 
//        bankItemobjAL = psf.getBankObjAL();
//        System.out.println(bankItemobjAL.size());
//        psf.getBankItemno("2","2008/11/05", "0052", "SYDTPE".substring(0,3),"SYDTPE".substring(3),"631451","343","18606");
        psf.getPRSFLY("2008/12/26", "0031", "YVRTPE","631451");
        objAL = psf.getBankObjAL();      
//        out.println(objAL.size());
//        System.out.println(bankItemobjAL.size());
        System.out.println(objAL.size());


    }
    
    public void getPsflyTopic_no(String fltd, String fltno, String dpt, String arv, String empno, String tempfleet, String tempacno) 
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
//    			sql = " select dps.fleet_cd, dps.duty_cd,to_char(dps.str_dt_tm_loc,'yyyy/mm/dd') fdate, "
//                 +"dps.flt_num fltno,to_char(str_dt_tm_loc,'yyyy/mm/dd hh24:mi') stdDt, "
//       		     +"dps.port_a dpt,dps.port_b arv,r.acting_rank qual "
//       		     +"from fzdb.duty_prd_seg_v dps, fzdb.roster_v r where dps.series_num=r.series_num "
//       		     +"and dps.delete_ind = 'N' AND  r.delete_ind='N' "
//       		     +"and r.staff_num ='"+empno+"' AND dps.act_str_dt_tm_gmt BETWEEN  "
//       		     +"to_date('"+fltd+" 00:00','yyyy/mm/dd hh24:mi') AND "
//       		     +"Last_Day( To_Date('"+fltd+" 23:59','yyyy/mm/dd hh24:mi')) "
//       		     +"and port_a = '"+dpt+"' and port_b = '"+arv+"' and flt_num = '"+fltno+"' "
//       		     +"AND r.duty_cd='FLY' AND dps.duty_cd IN ('FLY','TVL') AND  r.acting_rank='PR' " 
//       		     +"order by str_dt_tm_gmt ";
    			
//    			purser report SQL
    			sql = " select dps.fleet_cd, dps.duty_cd,to_char(dps.str_dt_tm_loc,'yyyy/mm/dd') fdate, "
                 +"dps.flt_num fltno,to_char(str_dt_tm_loc,'yyyy/mm/dd hh24:mi') stdDt, "
       		     +"dps.port_a dpt,dps.port_b arv,r.acting_rank qual "
       		     +"from fzdb.duty_prd_seg_v dps, fzdb.roster_v r where dps.series_num=r.series_num "
       		     +"and dps.delete_ind = 'N' AND  r.delete_ind='N' "
       		     +"and r.staff_num ='"+empno+"' AND dps.act_str_dt_tm_gmt BETWEEN  "
       		     +"to_date('"+fltd+" 00:00','yyyy/mm/dd hh24:mi') AND "
       		     +"To_Date('"+fltd+" 23:59','yyyy/mm/dd hh24:mi') "
       		     +"and port_a = '"+dpt+"' and port_b = '"+arv+"' and flt_num = '"+fltno+"' "
       		     +"AND r.duty_cd='FLY' AND dps.duty_cd IN ('FLY','TVL') AND  r.acting_rank='PR' " 
       		     +"order by str_dt_tm_gmt  ";
  		
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
        
//    	System.out.println("acno = "+acno);
        //*****************************************************************************************
        try
        { 
            ArrayList tempAL = new ArrayList();
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
			
            //purser report SQL
			sql = " SELECT topic_no FROM egtpsti " +
				  " WHERE To_Date('"+fltd+"','yyyy/mm/dd') BETWEEN effdt AND expdt  " +
				  " AND ( (condi_col = 'FLEET' AND condi_val = RPad(SubStr('"+fleet+"',1,2),3,0)) or " +
				  " (condi_col = 'FLTNO' AND condi_val = '"+fltno+"') OR (condi_col = 'DEP' AND condi_val = '"+dpt+"') OR " +
				  " (condi_col = 'ARV' AND condi_val = '"+arv+"') OR (condi_col = 'ACNO' AND condi_val = '"+acno+"') ) " +
				  " GROUP BY topic_no ";
			
//			System.out.println(sql);
			rs = stmt.executeQuery(sql);

			while(rs.next())
			{
			    tempAL.add(rs.getString("topic_no"));
			}
			
			for(int i=0; i<tempAL.size(); i++)
			{
			    boolean ifmatchcondi = true;
//			  *******************************************************************************************
			    ArrayList tempfltnoAL = new ArrayList();
			    sql = " select condi_val from egtpsti where topic_no = '"+tempAL.get(i)+"' and condi_col = 'FLTNO'";			    
//			    System.out.println(sql);
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
			    sql = " select * from egtpsti where topic_no = '"+tempAL.get(i)+"' and condi_col <> 'FLTNO' ";
//			    System.out.println(sql);
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
				      if(!fleet.equals(rs.getString("condi_val")))  
				      {
				          ifmatchcondi = false;
				      }
				    }				    
				}
				
				if(ifmatchcondi== true)
				{
				    topic_noAL.add(tempAL.get(i));
				}			    
			}//for(int i=0; i<tempAL.size(); i++)
			//System.out.println(topic_noAL.size());
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
    
    public void getBankItemno(String topic_no) //1,2,3 or 2
    {   
        Connection conn = null;
    	Statement stmt = null;
    	ResultSet rs = null;	
    	String sql = null;
    	Driver dbDriver = null;
    	
        try
        {           
            ConnDB cn = new ConnDB();
            
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();	
            
			sql = " SELECT tb.topic_no topic_no, tb.itemno itemno, fi.itemdesc itemdesc, " +
				  " fi.kin kin, fi.qtype qtype FROM egtpstb tb,egtpsfi fi " +
				  " WHERE tb.topic_no in ("+topic_no+") AND tb.itemno = fi.itemno " +
				  " ORDER BY topic_no, itemno";			
//			System.out.println(sql);
			bankobjAL = new ArrayList();
			rs = stmt.executeQuery(sql);
			while(rs.next())
			{
			    PSFlyIssueObj obj = new PSFlyIssueObj();
			    obj.setTopic_no(rs.getString("topic_no"));
			    obj.setItemno(rs.getString("itemno"));
			    obj.setItemdesc(rs.getString("itemdesc"));
			    obj.setKin(rs.getString("kin"));
			    obj.setQtype(rs.getString("qtype"));			       
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
            
			sql = " SELECT tb.topic_no topic_no, tb.itemno itemno, fi.itemdesc itemdesc, fi.kin kin, " +
				  " fi.qtype qtype, sf.* FROM egtpstb tb,egtpsfi fi ," +
				  " (SELECT * FROM egtprsf WHERE fltdt = To_Date('"+fltd+"','yyyy/mm/dd') AND sect = '"+dpt+arv+"' " +
				  " AND fltno = '"+fltno+"' AND empno = '"+empno+"') sf " +
				  " WHERE tb.topic_no in ("+topic_no+") AND tb.itemno = fi.itemno   AND tb.topic_no = sf.topic_no (+)  " +
				  " AND tb.itemno = sf.itemno (+) ORDER BY tb.topic_no, tb.itemno ";			
//			System.out.println(sql);
			bankobjAL = new ArrayList();
			rs = stmt.executeQuery(sql);
			while(rs.next())
			{
			    PRSFlyFactorObj obj = new PRSFlyFactorObj();
			    obj.setTopic_no(rs.getString("topic_no"));
			    obj.setItemno(rs.getString("itemno"));
			    obj.setItemdesc(rs.getString("itemdesc"));
			    obj.setKin(rs.getString("kin"));
			    obj.setQtype(rs.getString("qtype"));
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
			   
			    obj.setNum_satisfy(rs.getString("num_satisfy"));
			    obj.setDuty_satisfy(rs.getString("duty_satisfy"));
			    obj.setNum_needtoimprove(rs.getString("num_needtoimprove"));
			    obj.setDuty_needtoimprove(rs.getString("duty_needtoimprove"));
			    obj.setDesc_needtoimprove(rs.getString("desc_needtoimprove"));
			    obj.setFactor_no(rs.getString("factor_no"));
			    obj.setFactor_sub_no(rs.getString("factor_sub_no"));
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
    
    public void getPRSFLY(String fltd, String fltno, String sect, String empno) 
    {   
        Connection conn = null;
    	Statement stmt = null;
    	ResultSet rs = null;	
    	String sql = null;
    	Driver dbDriver = null;
    	PRSFlyItemDesc prid = new PRSFlyItemDesc();
    	prid.getBankItemData();	   
	    prid.getFactorData();
	    prid.getFactorSubData();
    	
        try
        {           
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();	
		
//			sql = " SELECT tb.topic_no topic_no, tb.itemno itemno, fi.itemdesc itemdesc, fi.kin kin,  " +
//				  " fi.qtype qtype, sf.*, To_Char(fltdt,'yyyy/mm/dd') fltdt2, ff.factor_desc factor_desc, " +
//				  " fs.factor_sub_desc  factor_sub_desc " +
//				  " FROM egtpstb tb,egtpsfi fi, egtpsff ff, egtpsfs fs, " +
//				  " (SELECT * FROM egtprsf WHERE fltdt = To_Date('"+fltd+"','yyyy/mm/dd') AND sect = '"+sect+"' " +
//				  " AND fltno = '"+fltno+"' AND empno = '"+empno+"') sf " +
//				  " WHERE sf.topic_no = tb.topic_no  AND sf.itemno = tb.itemno " +
//				  " AND sf.factor_no = ff.factor_no (+)  AND sf.factor_sub_no = fs.factor_sub_no (+) " +
//				  " and tb.itemno = fi.itemno " +
//				  " AND ((fs.kin = ff.factor_no AND  num_needtoimprove <> 0) or num_needtoimprove = 0  )   " +
//				  " ORDER BY tb.topic_no, tb.itemno, sf.factor_no, sf.factor_sub_no ";
            
            sql = " SELECT sf.*, To_Char(sf.fltdt,'yyyy/mm/dd') fltdt2, Nvl(factor_no,' ') factor_no2, " +
            	   " Nvl(factor_sub_no,' ') factor_sub_no2 FROM egtprsf sf " +
            	  " WHERE fltdt = To_Date('"+fltd+"','yyyy/mm/dd') AND sect = '"+sect+"' " +
            	  " AND fltno = '"+fltno+"' AND empno = '"+empno+"' " +
            	  " ORDER BY topic_no,itemno, factor_no, factor_sub_no ";
			
//			System.out.println(sql);
			bankobjAL = new ArrayList();
			rs = stmt.executeQuery(sql);
			while(rs.next())
			{
			    PRSFlyFactorObj obj = new PRSFlyFactorObj();
			    obj.setTopic_no(rs.getString("topic_no"));
			    obj.setItemno(rs.getString("itemno"));
			    obj.setItemdesc(prid.getBankItemDesc(rs.getString("itemno")));
//			    System.out.println(prid.getBankItemDesc(rs.getString("itemno")));
			    obj.setKin("A");
			    obj.setQtype("S");
			    obj.setFltdt(rs.getString("fltdt2"));
			    obj.setFltno(rs.getString("fltno"));
			    obj.setSect(rs.getString("sect"));
			    obj.setEmpno(rs.getString("empno"));
			    obj.setAcno(rs.getString("acno"));
			    obj.setFleet(rs.getString("fleet"));
			    obj.setAcno(rs.getString("acno"));			   
			    obj.setNum_satisfy(rs.getString("num_satisfy"));
			    obj.setDuty_satisfy(rs.getString("duty_satisfy"));
			    obj.setNum_needtoimprove(rs.getString("num_needtoimprove"));
			    obj.setDuty_needtoimprove(rs.getString("duty_needtoimprove"));
			    obj.setDesc_needtoimprove(rs.getString("desc_needtoimprove"));
			    obj.setFactor_no(rs.getString("factor_no2"));
			    obj.setFactor_sub_no(rs.getString("factor_sub_no2"));
			    obj.setFactor_desc(prid.getFactorDesc(rs.getString("factor_no2")));
//			    System.out.println(prid.getFactorDesc(rs.getString("factor_no")));
			    obj.setFactor_sub_desc(prid.getFactorSubDesc(rs.getString("factor_no2"),rs.getString("factor_sub_no2")));
//			    System.out.println(prid.getFactorSubDesc(rs.getString("factor_no"),rs.getString("factor_sub_no")));
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
    
    public ArrayList getTopic_noAL()
    {
        return topic_noAL;
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

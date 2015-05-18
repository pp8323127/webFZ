package eg.prfe;

import java.sql.*;
import java.util.*;
import ci.db.*;

/**
 * @author cs71 Created on  2009/6/6
 */
public class PRBriefEval
{
    private ArrayList objAL = new ArrayList();
    private Hashtable objHT = new Hashtable();
    private String returnStr = "";   
    private String sql = "";     
    private String flag = "A";// 判?題庫

    public static void main(String[] args)
    {
        PRBriefEval prbe = new PRBriefEval();
////        prfe.getPRFuncEvalEmpty();
//        prbe.getPRBriefEval("2009/07/01","2009/08/16","");
        prbe.getPRBriefEvalStat("2011/01/01","2011/06/30","ALL","","","","");
//        prbe.getPRBriefEvalStat2("2009","TPE");
//        Hashtable tempHT = prbe.getObjHT();
//        if (tempHT.size()> 0) 
//        {
//		    Set keyset = tempHT.keySet();
//	        Iterator i = keyset.iterator();
//	        while(i.hasNext())
//	    	{
//	    	    String key = String.valueOf(i.next());
//	    	    PRBriefEvalStatObj obj = (PRBriefEvalStatObj)tempHT.get(key);
//	    	    System.out.println("getPurempno "+obj.getPurempno());
////	    	    System.out.println("getScore_str "+obj.getScore_str());
////	    	    System.out.println(obj.getMyHT().get("01"));
////	    	    System.out.println(obj.getMyHT().get("02"));
////	    	    System.out.println(obj.getMyHT().get("03"));
////	    	    System.out.println(obj.getMyHT().get("06"));
////	    	    System.out.println("***************");
//	    	} 	                
//        } 
//        System.out.println(prbe.getObjHT().size());
        
//        prbe.getPRBriefEval_CaseStatus("2009", "06", "2009", "07", "ALL");    
//        prbe.getPRChkCase("2009/07", "2009/07", "631451");
    }
    
    public void setFlag(String flag)
    {
        this.flag = flag;
    }
    
    public void getPRBriefEval(String sdate, String edate, String purempno)
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
            
            if("".equals(purempno) || purempno == null)
            {
	            sql = " SELECT be.*, cb.sern pursern, cb.cname purname, hr.cname newname, " +
	            	  " Round(To_Number(chk1_score)+To_Number(chk2_score)+To_Number(chk3_score)+To_Number(chk4_score)+To_Number(chk5_score),0) ttlscore, " +
	            	  " To_Char(be.brief_dt,'yyyy/mm/dd') brief_dt2, To_Char(be.newdate,'yyyy/mm/dd') newdate2 " +
	            	  " FROM egtprbe be, egtcbas cb, hrvegemploy hr " +
	            	  " WHERE be.brief_dt between To_Date('"+sdate+"','yyyy/mm/dd') and To_Date('"+edate+"','yyyy/mm/dd') " +
	            	  " AND be.purempno = Trim(cb.empn) AND be.newuser = hr.employid (+) order by be.brief_dt";
            }
            else
            {
                sql = " SELECT be.*, cb.sern pursern, cb.cname purname, hr.cname newname, " +
		          	  " Round(To_Number(chk1_score)+To_Number(chk2_score)+To_Number(chk3_score)+To_Number(chk4_score)+To_Number(chk5_score),0) ttlscore, " +
		          	  " To_Char(be.brief_dt,'yyyy/mm/dd') brief_dt2, To_Char(be.newdate,'yyyy/mm/dd') newdate2 " +
		          	  " FROM egtprbe be, egtcbas cb, hrvegemploy hr " +
		          	  " WHERE be.brief_dt between To_Date('"+sdate+"','yyyy/mm/dd') and To_Date('"+edate+"','yyyy/mm/dd') " +
		          	  " AND be.purempno = '"+purempno+"' " +
		          	  " AND be.purempno = Trim(cb.empn) AND be.newuser = hr.employid (+) order by be.brief_dt ";    
            }
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);     
            objAL.clear();
            while (rs.next()) 
            {
                PRBriefEvalObj obj = new PRBriefEvalObj();              
                obj.setBrief_dt(rs.getString("brief_dt2"));
                obj.setBrief_time(rs.getString("brief_time"));
                obj.setFltno(rs.getString("fltno"));
                obj.setPurempno(rs.getString("purempno"));
                obj.setPursern(rs.getString("pursern"));
                obj.setPurname(rs.getString("purname"));
                obj.setChk1_score(rs.getString("chk1_score"));
                obj.setChk2_score(rs.getString("chk2_score"));
                obj.setChk3_score(rs.getString("chk3_score"));
                obj.setChk4_score(rs.getString("chk4_score"));
                obj.setChk5_score(rs.getString("chk5_score"));
                obj.setTtlscore(rs.getString("ttlscore"));
                obj.setComm(rs.getString("comm"));
                obj.setNewuser(rs.getString("newuser"));
                obj.setNewname(rs.getString("newname"));
                obj.setNewdate(rs.getString("newdate"));
                obj.setSubScoreObjAL(getPRBriefEvalSubScore(obj.getBrief_dt(),obj.getPurempno()));
                objAL.add(obj);
            }
            returnStr = "Y";
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
    
    public void getPRBriefEval(String sdate, String edate, String purempno, String base)
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
            
            if("".equals(purempno) || purempno == null)
            {
                if("ALL".equals(base))
                {
		            sql = " SELECT be.*, cb.sern pursern, cb.cname purname, hr.cname newname, " +
		            	  " Round(To_Number(chk1_score)+To_Number(chk2_score)+To_Number(chk3_score)+To_Number(chk4_score)+To_Number(chk5_score),0) ttlscore, " +
		            	  " To_Char(be.brief_dt,'yyyy/mm/dd') brief_dt2, To_Char(be.newdate,'yyyy/mm/dd') newdate2 " +
		            	  " FROM egtprbe be, egtcbas cb, hrvegemploy hr " +
		            	  " WHERE be.brief_dt between To_Date('"+sdate+"','yyyy/mm/dd') and To_Date('"+edate+"','yyyy/mm/dd') " +
		            	  " AND be.purempno = Trim(cb.empn) AND be.newuser = hr.employid (+) order by be.brief_dt";
                }
                else
                {
                    sql = " SELECT be.*, cb.sern pursern, cb.cname purname, hr.cname newname, " +
		            	  " Round(To_Number(chk1_score)+To_Number(chk2_score)+To_Number(chk3_score)+To_Number(chk4_score)+To_Number(chk5_score),0) ttlscore, " +
		            	  " To_Char(be.brief_dt,'yyyy/mm/dd') brief_dt2, To_Char(be.newdate,'yyyy/mm/dd') newdate2 " +
		            	  " FROM egtprbe be, egtcbas cb, hrvegemploy hr " +
		            	  " WHERE be.brief_dt between To_Date('"+sdate+"','yyyy/mm/dd') and To_Date('"+edate+"','yyyy/mm/dd') " +
		            	  " and cb.station = '"+base+"' AND be.purempno = Trim(cb.empn) AND be.newuser = hr.employid (+) order by be.brief_dt";                    
                }
            }
            else
            {
                sql = " SELECT be.*, cb.sern pursern, cb.cname purname, hr.cname newname, " +
		          	  " Round(To_Number(chk1_score)+To_Number(chk2_score)+To_Number(chk3_score)+To_Number(chk4_score)+To_Number(chk5_score),0) ttlscore, " +
		          	  " To_Char(be.brief_dt,'yyyy/mm/dd') brief_dt2, To_Char(be.newdate,'yyyy/mm/dd') newdate2 " +
		          	  " FROM egtprbe be, egtcbas cb, hrvegemploy hr " +
		          	  " WHERE be.brief_dt between To_Date('"+sdate+"','yyyy/mm/dd') and To_Date('"+edate+"','yyyy/mm/dd') " +
		          	  " AND be.purempno = '"+purempno+"' " +
		          	  " AND be.purempno = Trim(cb.empn) AND be.newuser = hr.employid (+) order by be.brief_dt ";    
            }
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);     
            objAL.clear();
            while (rs.next()) 
            {
                PRBriefEvalObj obj = new PRBriefEvalObj();              
                obj.setBrief_dt(rs.getString("brief_dt2"));
                obj.setBrief_time(rs.getString("brief_time"));
                obj.setFltno(rs.getString("fltno"));
                obj.setPurempno(rs.getString("purempno"));
                obj.setPursern(rs.getString("pursern"));
                obj.setPurname(rs.getString("purname"));
                obj.setChk1_score(rs.getString("chk1_score"));
                obj.setChk2_score(rs.getString("chk2_score"));
                obj.setChk3_score(rs.getString("chk3_score"));
                obj.setChk4_score(rs.getString("chk4_score"));
                obj.setChk5_score(rs.getString("chk5_score"));
                obj.setTtlscore(rs.getString("ttlscore"));
                obj.setComm(rs.getString("comm"));
                obj.setNewuser(rs.getString("newuser"));
                obj.setNewname(rs.getString("newname"));
                obj.setNewdate(rs.getString("newdate"));
                obj.setSubScoreObjAL(getPRBriefEvalSubScore(obj.getBrief_dt(),obj.getPurempno()));
                objAL.add(obj);
            }
            returnStr = "Y";
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
    
    public ArrayList getPRBriefEvalSubScore(String brief_dt, String purempno)
    {
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        ArrayList scoreAL = new ArrayList();
        
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
            
            
	          sql = " SELECT To_Char(brief_dt,'yyyy/mm/dd') brief_dt2, purempno, be2.item_no item_no, " +
	          		" mi.item_desc, si.subitem_desc, be2.subitem_no subitem_no, score, " +
	          		" si.percentage subpercentage, mi.percentage mainpercentage, REPLACE(be2.comm,',','，') comm " +
	          		" FROM egtprbe2 be2, egtbemi mi, egtbesi si " +
	          		" WHERE be2.purempno= '"+purempno+"' AND be2.brief_dt = To_Date('"+brief_dt+"','yyyy/mm/dd') " +
	          		" AND mi.item_no = be2.item_no AND be2.subitem_no = si.subitem_no " +
	          		" and mi.flag = '"+flag+"'" + //2012/10/26 依題庫flag顯示
	          		" ORDER BY be2.item_no, be2.subitem_no ";
                
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);    
            while (rs.next()) 
            {
                PRBriefSubScoreObj obj = new PRBriefSubScoreObj();              
                obj.setBrief_dt(rs.getString("brief_dt2"));
                obj.setPurempno(rs.getString("purempno"));
                obj.setItem_no(rs.getString("item_no"));
                obj.setItem_desc(rs.getString("item_desc"));
                obj.setSubitem_no(rs.getString("subitem_no"));
                obj.setSubitem_desc(rs.getString("subitem_desc"));
                obj.setScore(rs.getString("score"));
                obj.setComm(rs.getString("comm"));
                obj.setSub_percentage(rs.getString("subpercentage"));
                obj.setMain_percentage(rs.getString("mainpercentage"));
                scoreAL.add(obj);
            }
            returnStr = "Y";
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
        return scoreAL;
    }
    
    public ArrayList getPRBriefEvalSubScoreEmpty()
    {
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        ArrayList scoreAL = new ArrayList();
        
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
            
            
	          sql = " SELECT si.subitem_no subitem_no, si.subitem_desc,si.percentage subpercentage," +
	          		" mi.item_no item_no, mi.item_desc, mi.percentage mainpercentage " +
	          		" FROM egtbemi mi, egtbesi si WHERE mi.item_no = si.item_no " +
	          		" and mi.flag = '"+flag+"'" + //2012/10/26 依題庫flag顯示
	          		" ORDER BY mi.item_no, si.subitem_no ";
                
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);    
            while (rs.next()) 
            {
                PRBriefSubScoreObj obj = new PRBriefSubScoreObj(); 
                obj.setItem_no(rs.getString("item_no"));
                obj.setItem_desc(rs.getString("item_desc"));
                obj.setSubitem_no(rs.getString("subitem_no"));
                obj.setSubitem_desc(rs.getString("subitem_desc"));
                obj.setSub_percentage(rs.getString("subpercentage"));
                obj.setMain_percentage(rs.getString("mainpercentage"));
                scoreAL.add(obj);
            }
            returnStr = "Y";
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
        return scoreAL;
    }
    
    public void getPRBriefEvalStat(String sdate, String edate, String base, String empno, String f_score, String t_score, String inspector)
    {
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        StringBuffer sb = new StringBuffer();
        
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
            
            sb.append(" SELECT be.*, cb.sern pursern, cb.cname purname, hr.cname newname, " +
		          	  " Round(To_Number(chk1_score)+To_Number(chk2_score)+To_Number(chk3_score)+To_Number(chk4_score)+To_Number(chk5_score),0) ttlscore, " +
		          	  " To_Char(be.brief_dt,'yyyy/mm/dd') brief_dt2, To_Char(be.newdate,'yyyy/mm/dd') newdate2 " +
		          	  " FROM egtprbe be, egtcbas cb, hrvegemploy hr " +
		          	  " WHERE be.brief_dt between To_Date('"+sdate+"','yyyy/mm/dd') and To_Date('"+edate+"','yyyy/mm/dd') " +		          	  
		          	  " AND be.purempno = Trim(cb.empn) AND be.newuser = hr.employid (+) ");
            
            if(!"ALL".equals(base))
            {
                sb.append(" and cb.station = '"+base+"' ");
            }
            
            if(!"".equals(empno) && empno != null)
            {
                sb.append(" and be.purempno = '"+empno+"' ");
            }
            
            if(!"".equals(f_score) && f_score != null)
            {
                sb.append(" and (Round(To_Number(chk1_score)+To_Number(chk2_score)+To_Number(chk3_score)+To_Number(chk4_score)+To_Number(chk5_score),0)) >= to_number("+f_score+") " +
                " and Round(To_Number(chk1_score)+To_Number(chk2_score)+To_Number(chk3_score)+To_Number(chk4_score)+To_Number(chk5_score),0) <= to_number("+t_score+") ");
            }
     
            if(!"".equals(inspector) && inspector != null)
            {
                sb.append(" and be.newuser = '"+inspector+"' ");
            }
            
            sb.append(" order by be.brief_dt ");
                         
    
//            System.out.println(sb.toString());
            rs = stmt.executeQuery(sb.toString());     
            objAL.clear();
            while (rs.next()) 
            {
                PRBriefEvalObj obj = new PRBriefEvalObj();              
                obj.setBrief_dt(rs.getString("brief_dt2"));
                obj.setBrief_time(rs.getString("brief_time"));
                obj.setFltno(rs.getString("fltno"));
                obj.setPurempno(rs.getString("purempno"));
                obj.setPursern(rs.getString("pursern"));
                obj.setPurname(rs.getString("purname"));
                obj.setChk1_score(rs.getString("chk1_score"));
                obj.setChk2_score(rs.getString("chk2_score"));
                obj.setChk3_score(rs.getString("chk3_score"));
                obj.setChk4_score(rs.getString("chk4_score"));
                obj.setChk5_score(rs.getString("chk5_score"));
                obj.setTtlscore(rs.getString("ttlscore"));
                obj.setComm(rs.getString("comm"));
                obj.setNewuser(rs.getString("newuser"));
                obj.setNewname(rs.getString("newname"));
                obj.setNewdate(rs.getString("newdate"));
                obj.setSubScoreObjAL(getPRBriefEvalSubScore(obj.getBrief_dt(),obj.getPurempno()));
                objAL.add(obj);
            }
            returnStr = "Y";
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
    
    public void getPRBriefEvalStat2(String yyyy, String base)
    {
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        StringBuffer sb = new StringBuffer();
        StringBuffer sb2 = new StringBuffer();
        
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
            
            sb2.append(" SELECT Trim(empn) empno, sern, cname, station  FROM egtcbas WHERE jobno in ('80','70') " +
            		" and (status = '1' or status = '2') "); 
            if(!"ALL".equals(base))
            {
                sb2.append(" and station = '"+base+"' ");
            }
            sb2.append(" order by station, empn ");
//System.out.println(sb2.toString());            
            rs = stmt.executeQuery(sb2.toString());    
            while (rs.next()) 
            {
                PRBriefEvalStatObj obj = new PRBriefEvalStatObj();
                Hashtable tempHT = new Hashtable();
                tempHT.put("01","0");
                tempHT.put("02","0");
                tempHT.put("03","0");
                tempHT.put("04","0");
                tempHT.put("05","0");
                tempHT.put("06","0");
                tempHT.put("07","0");
                tempHT.put("08","0");
                tempHT.put("09","0");
                tempHT.put("10","0");
                tempHT.put("11","0");
                tempHT.put("12","0");
                obj.setMyHT(tempHT);
                obj.setBase(rs.getString("station"));
                obj.setPurempno(rs.getString("empno"));
                obj.setPursern(rs.getString("sern"));
                obj.setPurname(rs.getString("cname"));                
                objHT.put(rs.getString("empno"),obj);
                objAL.add(rs.getString("empno"));
            }
            rs.close();
            //**********************************************************************************
           
            sb.append(" SELECT be.purempno, To_Char(brief_dt,'mm') brief_mm, cb.sern pursern, " +
            		" cb.cname purname, cb.station, " +
            		" Round(To_Number(chk1_score)+To_Number(chk2_score)+To_Number(chk3_score)+To_Number(chk4_score)+To_Number(chk5_score),0) ttlscore " +
            		" FROM egtprbe be, egtcbas cb " +
            		" WHERE be.brief_dt between To_Date('"+yyyy+"/01/01','yyyy/mm/dd') AND To_Date('"+yyyy+"/12/31','yyyy/mm/dd') " +
            		" AND be.purempno = Trim(cb.empn) ");
            
            if(!"ALL".equals(base))
            {
                sb.append(" and cb.station = '"+base+"' ");
            }          
            
            sb.append(" order by cb.station, be.purempno ");
    
//            System.out.println(sb.toString());
            rs = stmt.executeQuery(sb.toString());     

            while (rs.next()) 
            {
                PRBriefEvalStatObj obj = (PRBriefEvalStatObj) objHT.get(rs.getString("purempno"));
                if(obj != null)
                {
	                obj.setScore_str(obj.getScore_str()+rs.getString("ttlscore")+"/");
	                obj.setChk_times(obj.getChk_times()+1);
	                Hashtable tempHT = obj.getMyHT();
	                String temptimes = (String)tempHT.get(rs.getString("brief_mm"));
	                int tempinttimes = Integer.parseInt(temptimes)+1;
	                tempHT.put(rs.getString("brief_mm"), Integer.toString(tempinttimes));
	                obj.setMyHT(tempHT);
	                objHT.put(rs.getString("purempno"),obj);
                }
            }
            returnStr = "Y";
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
    
    public void getPRBriefEval_CaseStatus(String syy, String smm, String eyy, String emm, String base)
    {
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;        
        StringBuffer sb = new StringBuffer();
        
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
            
            sb.append(" SELECT to_char(brief_dt,'yyyy/mm') brief_mm, Sum(Decode(caseclose,'Y',0,1)) sum_close, " +
            		" Max(To_Char(close_tmst,'yyyy/mm/dd hh24:mi')) close_tmst FROM egtprbe be, egtcbas cb " +
            		" WHERE  be.purempno = Trim(cb.empn) ");
            if(!"ALL".equals(base))
            {
                sb.append(" and cb.station = '"+base+"' ");
            }
            
            sb.append( " AND brief_dt BETWEEN to_date('"+syy+"/"+smm+"/01','yyyy/mm/dd')  " +
            		   " AND Last_Day(to_date('"+eyy+"/"+emm+"/01','yyyy/mm/dd')) GROUP BY to_char(brief_dt,'yyyy/mm') ");
          
            rs = stmt.executeQuery(sb.toString());     
            objAL.clear();
            while (rs.next()) 
            {
                PRBriefEvalObj obj = new PRBriefEvalObj();              
                obj.setBrief_dt(rs.getString("brief_mm"));
                int sum_close = rs.getInt("sum_close");
                if(sum_close>=1)
                {
                    obj.setCaseclose("N");
                }
                else
                {
                    obj.setCaseclose("Y");
                }
                
                obj.setClose_tmst(rs.getString("close_tmst"));   
                objAL.add(obj);
            }
            
            if(objAL.size()>0)
            {
                for(int i=0; i<objAL.size(); i++)
                {
                    ArrayList tempobjAL = new ArrayList();
                    PRBriefEvalObj obj = (PRBriefEvalObj) objAL.get(i);  
	                sql = " SELECT be.*,To_Char(close_tmst,'yyyy/mm/dd hh24:mi') close_tmst2, " +
	            		  " To_Char(confirm_tmst,'yyyy/mm/dd hh24:mi') confirm_tmst2, cb.sern pursern, " +
	            		  " cb.cname purname, hr.cname newname, " +
			          	  " Round(To_Number(chk1_score)+To_Number(chk2_score)+To_Number(chk3_score)+To_Number(chk4_score)+To_Number(chk5_score),0) ttlscore, " +
			          	  " To_Char(be.brief_dt,'yyyy/mm/dd') brief_dt2, To_Char(be.newdate,'yyyy/mm/dd') newdate2 " +
			          	  " FROM egtprbe be, egtcbas cb, hrvegemploy hr " +
			          	  " WHERE be.brief_dt between To_Date('"+obj.getBrief_dt()+"/01','yyyy/mm/dd') and last_day(To_Date('"+obj.getBrief_dt()+"/01','yyyy/mm/dd')) " +		          	  
			          	  " AND be.purempno = Trim(cb.empn) AND be.newuser = hr.employid (+) ";
	                if(!"ALL".equals(base))
	                {
	                    sql = sql + " and cb.station = '"+base+"' ";
	                }
	                
	                sql = sql + " order by be.brief_dt ";
	                
	                System.out.println(sql);
	                rs = stmt.executeQuery(sql); 
	                while (rs.next()) 
	                {	                    
	                    PRBriefEvalObj obj2 = new PRBriefEvalObj();              
	                    obj2.setBrief_dt(rs.getString("brief_dt2"));
	                    obj2.setBrief_time(rs.getString("brief_time"));
	                    obj2.setFltno(rs.getString("fltno"));
	                    obj2.setPurempno(rs.getString("purempno"));
	                    obj2.setPursern(rs.getString("pursern"));
	                    obj2.setPurname(rs.getString("purname"));
	                    obj2.setChk1_score(rs.getString("chk1_score"));
	                    obj2.setChk2_score(rs.getString("chk2_score"));
	                    obj2.setChk3_score(rs.getString("chk3_score"));
	                    obj2.setChk4_score(rs.getString("chk4_score"));
	                    obj2.setChk5_score(rs.getString("chk5_score"));
	                    obj2.setTtlscore(rs.getString("ttlscore"));
	                    obj2.setComm(rs.getString("comm"));
	                    obj2.setNewuser(rs.getString("newuser"));
	                    obj2.setNewname(rs.getString("newname"));
	                    obj2.setNewdate(rs.getString("newdate"));
	                    obj2.setCaseclose(rs.getString("caseclose"));
	                    obj2.setConfirm_tmst(rs.getString("confirm_tmst2"));
	                    obj2.setClose_user(rs.getString("close_user"));
	                    obj2.setClose_tmst(rs.getString("close_tmst2"));
	                    obj2.setSubScoreObjAL(getPRBriefEvalSubScore(obj2.getBrief_dt(),obj2.getPurempno()));
	                    tempobjAL.add(obj2);	                    
	                }
	                obj.setBeObjAL(tempobjAL);	                
                }            
            }
            returnStr = "Y";
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

            sql = " SELECT To_Char(brief_dt,'yyyy/mm') brief_dt2 FROM egtprbe " +
            	  " WHERE purempno = '"+empno+"' AND caseclose = 'Y' AND confirm_tmst IS null " +
            	  " GROUP BY To_Char(brief_dt,'yyyy/mm') ";
            
//			System.out.println(sql);
            rs = stmt.executeQuery(sql);     
            objAL.clear();
            while (rs.next()) 
            {
                PRBriefEvalObj obj = new PRBriefEvalObj();                  
                obj.setBrief_dt(rs.getString("brief_dt2"));
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
    
    public void getPRChkCase(String syyyymm, String eyyyymm, String empno)
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

            sql = " SELECT be.*,To_Char(close_tmst,'yyyy/mm/dd hh24:mi') close_tmst2, " +
        		  " To_Char(confirm_tmst,'yyyy/mm/dd hh24:mi') confirm_tmst2, cb.sern pursern, " +
        		  " cb.cname purname, hr.cname newname, " +
	          	  " Round(To_Number(chk1_score)+To_Number(chk2_score)+To_Number(chk3_score)+To_Number(chk4_score)+To_Number(chk5_score),0) ttlscore, " +
	          	  " To_Char(be.brief_dt,'yyyy/mm/dd') brief_dt2, To_Char(be.newdate,'yyyy/mm/dd') newdate2 " +
	          	  " FROM egtprbe be, egtcbas cb, hrvegemploy hr " +
	          	  " WHERE be.brief_dt between To_Date('"+syyyymm+"/01','yyyy/mm/dd') and last_day(To_Date('"+eyyyymm+"/01','yyyy/mm/dd')) " +		          	  
	          	  " AND be.purempno = '"+empno+"' and be.purempno = Trim(cb.empn) AND be.newuser = hr.employid (+) " +
	          	  " order by be.brief_dt ";
            
//			System.out.println(sql);
            rs = stmt.executeQuery(sql);     
            objAL.clear();
            while (rs.next()) 
            {               
                PRBriefEvalObj obj2 = new PRBriefEvalObj();              
                obj2.setBrief_dt(rs.getString("brief_dt2"));
                obj2.setBrief_time(rs.getString("brief_time"));
                obj2.setFltno(rs.getString("fltno"));
                obj2.setPurempno(rs.getString("purempno"));
                obj2.setPursern(rs.getString("pursern"));
                obj2.setPurname(rs.getString("purname"));
                obj2.setChk1_score(rs.getString("chk1_score"));
                obj2.setChk2_score(rs.getString("chk2_score"));
                obj2.setChk3_score(rs.getString("chk3_score"));
                obj2.setChk4_score(rs.getString("chk4_score"));
                obj2.setChk5_score(rs.getString("chk5_score"));
                obj2.setTtlscore(rs.getString("ttlscore"));
                obj2.setComm(rs.getString("comm"));
                obj2.setNewuser(rs.getString("newuser"));
                obj2.setNewname(rs.getString("newname"));
                obj2.setNewdate(rs.getString("newdate"));
                obj2.setCaseclose(rs.getString("caseclose"));
                obj2.setConfirm_tmst(rs.getString("confirm_tmst2"));
                obj2.setClose_user(rs.getString("close_user"));
                obj2.setClose_tmst(rs.getString("close_tmst2"));
                obj2.setSubScoreObjAL(getPRBriefEvalSubScore(obj2.getBrief_dt(),obj2.getPurempno()));
                objAL.add(obj2);
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
    
    public ArrayList getObjAL()
    {
        return objAL;
    } 
    
    public Hashtable getObjHT()
    {
        return objHT;
    } 
   
}

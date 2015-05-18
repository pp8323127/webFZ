package eg.prfe;

import java.sql.*;
import java.util.*;

import ws.prac.SFLY.MP.MPEvalObj2;
import ws.prac.SFLY.MP.MemofbkObj;
import ws.prac.SFLY.MP.SaveReportMpFileObj;

import ci.db.*;
import ftp.FtpUrl;

/**
 * @author cs71 Created on  2009/6/6
 */
public class PRFuncEval
{
    private ArrayList objAL = new ArrayList();
    private Hashtable objHT = new Hashtable();
    private String returnStr = "";   
    private String sql = "";     

    public static void main(String[] args)
    {
        PRFuncEval prfe = new PRFuncEval();
        prfe.getPRFuncEvalEmpty();
//        prfe.getPRFuncEval("13665");
//        prfe.getPRFuncEvalStat("2009/06/01", "2009/06/30", "ALL", "","", "", "");
//        prfe.getPRFuncEvalStat2("2009", "ALL");
//        prfe.getPRFuncEvalStat4("2012/06/01", "2013/08/30");
        System.out.println(prfe.getObjAL().size());
//        System.out.println(prfe.getScore(prfe.getObjAL()));
        
        
    }
    
    //201410 cs80 add
    public void getPRFuncEval_2(String sernno)
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

            sql = " SELECT pr.*, pi.kpi_itemdesc, si.eval_subitemdesc, mi.eval_itemdesc, ti.fe_score " +
                  " FROM egtprfe pr, egtfekpi pi, egtfesi si, egtfemi mi, egtstti ti " +
                  " WHERE pr.sernno = '"+sernno+"' AND pr.sernno = ti.sernno " +
                  " AND pr.kpino = pi.kpi_itemno AND pr.sitemno = si.eval_subitemno " +
                  " AND pr.mitemno = mi.eval_itemno ORDER BY mi.eval_itemno, si.eval_subitemno, kpino ";
//                        System.out.println(sql);
            rs = stmt.executeQuery(sql);            
            
            objAL = new ArrayList();
            PRFuncEvalObj objempty = new PRFuncEvalObj();
            objAL.add(objempty);            
            while (rs.next()) 
            {
                PRFuncEvalObj obj = new PRFuncEvalObj();   
                obj.setSernno(rs.getString("sernno"));
                obj.setMitemno(rs.getString("mitemno"));
                obj.setMitemdesc(rs.getString("eval_itemdesc"));
                obj.setSitemno(rs.getString("sitemno"));
                obj.setSitemdesc(rs.getString("eval_subitemdesc"));
                obj.setGrade_percentage(rs.getString("grade_percentage"));
                obj.setKpino(rs.getString("kpino"));
                obj.setKpidesc(rs.getString("kpi_itemdesc"));   
                obj.setKpi_eval(rs.getString("kpi_eval"));
                obj.setKpi_score(rs.getString("fe_score"));                
                objAL.add(obj);
            }
            
            if(objAL.size()>1)
            {
                ArrayList memoAL = new ArrayList();
                PRFuncEvalObj obj =(PRFuncEvalObj) objAL.get(1);  
                sql = " SELECT * FROM egtprfe2 WHERE sernno = '"+sernno+"' ";
                rs = stmt.executeQuery(sql);                   
                while (rs.next()) 
                {
                    MPEvalObj2 obj2 = new MPEvalObj2();            
                    obj2.setSernno(rs.getString("sernno"));
                    obj2.setSeqno(rs.getString("seqno"));
                    obj2.setMemo_type(rs.getString("memo_type"));
                    obj2.setSect(rs.getString("sect"));
                    obj2.setSeatno(rs.getString("seatno"));
                    obj2.setSeat_class(rs.getString("seat_class"));
                    obj2.setCust_name(rs.getString("cust_name"));
                    obj2.setCust_type(rs.getString("cust_type"));
                    obj2.setCardNo(rs.getString("cardNo"));
                    obj2.setEvent_type(rs.getString("event_type"));
                    obj2.setEvent(rs.getString("event"));
                    obj2.setMemo(rs.getString("memo"));
                    memoAL.add(obj2);
                }   
                obj.setMemoAL(memoAL); 
                
                if(obj.getMemoAL()!=null && obj.getMemoAL().size() > 0){
                    //建議事項
                    ArrayList sugAL = new ArrayList();
                    sql = "  SELECT i.itemNo itemno ,i.itemdsc itemdsc ,sernno,feedback FROM " +
                          " (select * from egtprfs where sernno = '"+sernno+"') d, egtprsug i WHERE i.itemno = d.itemno(+) and flag = 'Y' ";
                    rs = stmt.executeQuery(sql);  
                    while (rs.next()) 
                    {
                        MemofbkObj objm = new MemofbkObj();            
                        objm.setSernno(rs.getString("sernno"));
                        objm.setQuesNo(rs.getString("itemno"));//序號
                        objm.setQuesDsc(rs.getString("itemdsc"));
                        objm.setFeedback(rs.getString("feedback"));  
                        
                        sugAL.add(objm);
                    }
                    obj.setSugAL(sugAL); 
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
    //201410 cs80 add
    public void getPRFuncEvalCus(String sernno,String seqno){
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        String sql = "";
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

            objAL = new ArrayList();
            String temp = "";
            //旅客反映
            sql = "select c.itemno itemno,c.itemdsc itemdsc ,feedback, seqno ,sernno ,c.selectitem from " +
                " (select * from egtprfc where sernno = '"+sernno+"' and seqno = '"+seqno+"') d," +
                " egtprcus c where   c.itemno = d.itemno(+) and flag = 'Y' order by c.itemno ";
            rs = stmt.executeQuery(sql);  
            while (rs.next()) 
            {
                PREvalCusObj obj = new PREvalCusObj();  
                obj.setSernno(rs.getString("sernno"));
                obj.setSeqno(rs.getString("seqno"));
                obj.setQuesNo(rs.getString("itemno"));//題目序號
                obj.setQuesDsc(rs.getString("itemdsc"));//題目描述
                obj.setFeedback(rs.getString("feedback"));    
                temp = rs.getString("selectitem");
                if(null!=temp && !"".equals(temp)){
                    obj.setSeletItem(temp.split("/"));
                } 
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
    //201410 cs80 add
    public void getEvalFile(String sernno,String fileType,String subType){
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        String sql = "";
        try 
        {
            FtpUrl url = new FtpUrl();//統一設定ftp Url.
            ConnDB cn = new ConnDB();
            cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            stmt   = conn.createStatement();
            
//            cn.setORP3EGUser();
//            cn.setORT1EG();
//            java.lang.Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() , cn.getConnPW());      
//            stmt = conn.cresateStatement();

            objAL = new ArrayList();
          
            sql = " select sernno,fltd,fltno,sect,filename,filedsc,upduser,upddate,src,app_filename,type,subtype from egtmpfile WHERE sernno = '"+sernno+"' ";
            if(null != fileType && !"".equals(fileType)){
                sql += "and type = '"+fileType+"'";
            }
            if(null != subType && !"".equals(subType)){
                sql += "and subtype = '"+subType+"'";
            }
            rs = stmt.executeQuery(sql);  
            while (rs.next()) 
            {
                SaveReportMpFileObj objf = new SaveReportMpFileObj();  
                objf.setSernno(rs.getString("sernno"));
                objf.setFltd(rs.getString("fltd"));
                objf.setFltno(rs.getString("fltno"));
                objf.setSect(rs.getString("sect"));
                objf.setFilename(rs.getString("filename"));
                objf.setApp_filename(rs.getString("app_filename"));
                objf.setFiledsc(rs.getString("filedsc"));
                objf.setSubtype(rs.getString("subtype"));
                objf.setType(rs.getString("type"));
                objf.setFileLink(url.getUrl()+"MP/"+rs.getString("filename"));//filename
                objAL.add(objf);
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
    
    public void getPRFuncEvalEmpty()
    {
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        boolean ifNewPercentage = false;
        
        try 
        {
            ConnDB cn = new ConnDB();
            cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            stmt   = conn.createStatement();
            
//            cn.setORP3EGUser();
////            cn.setORT1EG();
//            java.lang.Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() , cn.getConnPW());      
//            stmt = conn.createStatement();
            
            sql= " SELECT CASE  WHEN SYSDATE>=To_Date('20140501','yyyymmdd') THEN 'Y' ELSE 'N' END ifnewpercentage FROM dual ";
            rs = stmt.executeQuery(sql);
            if(rs.next())
            {
                
                if("Y".equals(rs.getString("ifnewpercentage").trim()))
                {
                    ifNewPercentage = true;
                }
            }

            if(ifNewPercentage == true)
            {
                sql = " SELECT mi.eval_itemno, mi.eval_itemdesc, si.eval_subitemno, si.eval_subitemdesc, " +
                        " Decode(si.eval_subitemno,3,20,9,15,10,15,eval_grade_percentage) eval_grade_percentage, " +
                        " pi.* FROM egtfekpi pi, egtfesi si, egtfemi mi  " +
                        " WHERE  kpi_flag = 'Y' AND pi.kpi_kin = si.eval_subitemno AND mi.eval_itemno = si.eval_kin " +
                        " ORDER BY mi.eval_itemno, To_Number(si.eval_subitemno), To_Number(pi.kpi_kin), " +
                        " To_Number(pi.kpi_itemno) ";                
            }
            else
            {
                sql = " SELECT mi.eval_itemno, mi.eval_itemdesc, si.eval_subitemno, si.eval_subitemdesc, " +
                	  " eval_grade_percentage, pi.* FROM egtfekpi pi, egtfesi si, egtfemi mi  " +
                	  " WHERE  kpi_flag = 'Y' AND pi.kpi_kin = si.eval_subitemno AND mi.eval_itemno = si.eval_kin " +
                	  " ORDER BY mi.eval_itemno, To_Number(si.eval_subitemno), To_Number(pi.kpi_kin), " +
                	  " To_Number(pi.kpi_itemno) ";
            }
//          System.out.println(sql);
            rs = stmt.executeQuery(sql);            
            
            objAL = new ArrayList();
            PRFuncEvalObj objempty = new PRFuncEvalObj();
            objAL.add(objempty);            
            while (rs.next()) 
            {
                PRFuncEvalObj obj = new PRFuncEvalObj();              
                obj.setMitemno(rs.getString("eval_itemno"));
                obj.setMitemdesc(rs.getString("eval_itemdesc"));
                obj.setSitemno(rs.getString("eval_subitemno"));
                obj.setSitemdesc(rs.getString("eval_subitemdesc"));
                obj.setGrade_percentage(rs.getString("eval_grade_percentage"));
                obj.setKpino(rs.getString("kpi_itemno"));
                obj.setKpidesc(rs.getString("kpi_itemdesc"));                    
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
    
    public void getPRFuncEval(String sernno)
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


            sql = " SELECT pr.*, pi.kpi_itemdesc, si.eval_subitemdesc, mi.eval_itemdesc, ti.fe_score " +
                    " FROM egtprfe pr, egtfekpi pi, egtfesi si, egtfemi mi, egtstti ti " +
                    " WHERE pr.sernno = '"+sernno+"' AND pr.sernno = ti.sernno " +
                    " AND pr.kpino = pi.kpi_itemno AND pr.sitemno = si.eval_subitemno " +
                    " AND pr.mitemno = mi.eval_itemno ORDER BY mi.eval_itemno, si.eval_subitemno, kpino ";
                       
//                        System.out.println(sql);
            rs = stmt.executeQuery(sql);            
            
            objAL = new ArrayList();
            PRFuncEvalObj objempty = new PRFuncEvalObj();
            objAL.add(objempty);            
            while (rs.next()) 
            {
                PRFuncEvalObj obj = new PRFuncEvalObj();   
                obj.setSernno(rs.getString("sernno"));
                obj.setMitemno(rs.getString("mitemno"));
                obj.setMitemdesc(rs.getString("eval_itemdesc"));
                obj.setSitemno(rs.getString("sitemno"));
                obj.setSitemdesc(rs.getString("eval_subitemdesc"));
                obj.setGrade_percentage(rs.getString("grade_percentage"));
                obj.setKpino(rs.getString("kpino"));
                obj.setKpidesc(rs.getString("kpi_itemdesc"));   
                obj.setKpi_eval(rs.getString("kpi_eval"));
                obj.setKpi_score(rs.getString("fe_score"));                
                objAL.add(obj);
            }
            
            if(objAL.size()>1)
            {
                ArrayList memoAL = new ArrayList();
                PRFuncEvalObj obj =(PRFuncEvalObj) objAL.get(1);  
                sql = " SELECT * FROM egtprfe2 WHERE sernno = '"+sernno+"' ";
                rs = stmt.executeQuery(sql);   
                while (rs.next()) 
                {
                    PRFuncEvalObj2 obj2 = new PRFuncEvalObj2();            
                    obj2.setSernno(rs.getString("sernno"));
                    obj2.setMemo_type(rs.getString("memo_type"));
                    obj2.setSect(rs.getString("sect"));
                    obj2.setSeatno(rs.getString("seatno"));
                    obj2.setSeat_class(rs.getString("seat_class"));
                    obj2.setCust_name(rs.getString("cust_name"));
                    obj2.setCust_type(rs.getString("cust_type"));
                    obj2.setEvent_type(rs.getString("event_type"));
                    obj2.setEvent(rs.getString("event"));
                    obj2.setMemo(rs.getString("memo"));
                    memoAL.add(obj2);
                }
                obj.setMemoAL(memoAL);                
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
    
    
    public ArrayList getObjAL()
    {
        return objAL;
    }
    
    public Hashtable getObjHT()
    {
        return objHT;
    }     
    
    public String getScore(ArrayList scoreAL)
    {  
        PRFuncEvalObj objempty = new PRFuncEvalObj();              
        scoreAL.add(objempty);
        int totalscore =0;  
        int sinum =0;
        int subscore =0;
        for(int i=1; i<scoreAL.size()-1; i++ )
        {
            PRFuncEvalObj objp =(PRFuncEvalObj) scoreAL.get(i-1);
            PRFuncEvalObj obj =(PRFuncEvalObj) scoreAL.get(i);  
            PRFuncEvalObj objn =(PRFuncEvalObj) scoreAL.get(i+1);          
            if(!objp.getSitemno().equals(obj.getSitemno()))
            {//子標不同
                sinum=1;
                subscore = Integer.parseInt(obj.getKpi_eval());
            }
            else
    		{
                subscore = subscore + Integer.parseInt(obj.getKpi_eval());
                sinum++;   
    		}
            
            if(!objn.getSitemno().equals(obj.getSitemno()))
            {
                //計算avg score
                totalscore = totalscore+((subscore/sinum)*Integer.parseInt(obj.getGrade_percentage()));
            }
        }
        
        return Integer.toString(totalscore);
    }
    
    public void getPRFuncEvalStat(String sdate, String edate, String base, String empno, String f_score, String t_score, String inspector)
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
            
            sb.append(" SELECT ti.*, Trim(cb.empn) empno, cb.sern sern, cb.cname, hr.cname hrinstname, " +
            		  " ti.fe_score, To_Char(ti.fltd,'yyyy/mm/dd') fltd2 " +
            		  " FROM egtstti ti, egtcbas cb, hrvegemploy hr, (SELECT DISTINCT(sernno) FROM egtprfe) fe " +
            		  " WHERE ti.fltd between To_Date('"+sdate+"','yyyy/mm/dd') and To_Date('"+edate+"','yyyy/mm/dd') " +
            		  " AND ti.pursern = Trim(cb.sern) AND ti.instempno = hr.employid (+) and ti.sernno = fe.sernno ");
            
            if(!"ALL".equals(base))
            {
                sb.append(" and cb.station = '"+base+"' ");
            }
            
            if(!"".equals(empno) && empno != null)
            {
                sb.append(" and (cb.sern = '"+empno+"' or cb.empn = '"+empno+"') ");
            }
            
            if(!"".equals(f_score) && f_score != null)
            {
                sb.append(" and ti.fe_score >= to_number("+f_score+") and ti.fe_score <= to_number("+t_score+") ");
            }
     
            if(!"".equals(inspector) && inspector != null)
            {
                sb.append(" and ti.instempno = '"+inspector+"' ");
            }

            sb.append(" order by ti.fltd, ti.pursern ");
    
//            System.out.println(sb.toString());
            rs = stmt.executeQuery(sb.toString());     
            objAL.clear();
            while (rs.next()) 
            {
                PRFlySaftyObj obj = new PRFlySaftyObj();              
                obj.setFltd(rs.getString("fltd2"));
                obj.setFltno(rs.getString("fltno"));
                obj.setTrip(rs.getString("trip"));
                obj.setPursern(rs.getString("sern"));
                obj.setPurname(rs.getString("cname"));
                obj.setPurempno(rs.getString("empno"));
                obj.setInstname(rs.getString("hrinstname"));
                obj.setInstempno(rs.getString("instempno"));
                obj.setFe_score(rs.getString("fe_score"));                
                obj.setCaseclose(rs.getString("caseclose"));
                obj.setClose_tmst(rs.getString("close_tmst"));
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
    
    public void getPRFuncEvalStat2(String yyyy, String base)
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
            
            sb2.append(" SELECT Trim(empn) empno, sern, cname, station  FROM egtcbas " +
            		   " WHERE jobno = '80' and (status = '1' or status = '2') "); 
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
           
            sb.append(" select fe.sernno, trim(cb.empn) purempno, To_Char(ti.fltd,'mm') flt_mm, cb.sern pursern, " +
            		" cb.cname purname, cb.station, ti.fe_score fe_score " +
            		" FROM egtstti ti, egtcbas cb, (SELECT DISTINCT(sernno) FROM egtprfe) fe " +
            		" WHERE ti.fltd between To_Date('"+yyyy+"/01/01','yyyy/mm/dd') AND To_Date('"+yyyy+"/12/31','yyyy/mm/dd') " +
            		" AND ti.pursern = Trim(cb.sern) and ti.sernno = fe.sernno ");
            
            if(!"ALL".equals(base))
            {
                sb.append(" and cb.station = '"+base+"' ");
            }                     
       
//            System.out.println(sb.toString());
            rs = stmt.executeQuery(sb.toString());     

            while (rs.next()) 
            {
                PRBriefEvalStatObj obj = (PRBriefEvalStatObj) objHT.get(rs.getString("purempno"));
                if(obj != null)
                {
	                obj.setScore_str(obj.getScore_str()+rs.getString("fe_score")+"/");
	                obj.setChk_times(obj.getChk_times()+1);
	                Hashtable tempHT = obj.getMyHT();
	                String temptimes = (String)tempHT.get(rs.getString("flt_mm"));
	                int tempinttimes = Integer.parseInt(temptimes)+1;
	                tempHT.put(rs.getString("flt_mm"), Integer.toString(tempinttimes));
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
    
    public void getPRFuncEvalStat2(String sdate,String edate, String base)
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
            
            sb2.append(" SELECT Trim(empn) empno, sern, cname, station, groups  FROM egtcbas " +
                       " WHERE jobno = '80' and (status = '1' or status = '2') "); 
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
                obj.setPurgrp(rs.getString("groups"));
                objHT.put(rs.getString("empno"),obj);
                objAL.add(rs.getString("empno"));
            }
            rs.close();
            //**********************************************************************************
           
            sb.append(" select fe.sernno, trim(cb.empn) purempno, To_Char(ti.fltd,'mm') flt_mm, cb.sern pursern, " +
                    " cb.cname purname, cb.station, ti.fe_score fe_score " +
                    " FROM egtstti ti, egtcbas cb, (SELECT DISTINCT(sernno) FROM egtprfe) fe " +
                    " WHERE ti.fltd between To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+"','yyyy/mm/dd') " +
                    " AND ti.pursern = Trim(cb.sern) and ti.sernno = fe.sernno ");
            
            if(!"ALL".equals(base))
            {
                sb.append(" and cb.station = '"+base+"' ");
            }                     
       
//            System.out.println(sb.toString());
            rs = stmt.executeQuery(sb.toString());     

            while (rs.next()) 
            {
                PRBriefEvalStatObj obj = (PRBriefEvalStatObj) objHT.get(rs.getString("purempno"));
                if(obj != null)
                {
                    obj.setScore_str(obj.getScore_str()+rs.getString("fe_score")+"/");
                    obj.setChk_times(obj.getChk_times()+1);
                    Hashtable tempHT = obj.getMyHT();
                    String temptimes = (String)tempHT.get(rs.getString("flt_mm"));
                    int tempinttimes = Integer.parseInt(temptimes)+1;
                    tempHT.put(rs.getString("flt_mm"), Integer.toString(tempinttimes));
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
    
//  旅客反應分?分析
    public void getPRFuncEvalStat3(String sdate, String edate, String sect, String event_type)
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
            
            sb.append(" SELECT fe2.sernno, fe2.sect, fe2.seatno, fe2.seat_class, nvl(fe2.cust_name,' ') cust_name, " +
            		" nvl(fe2.cust_type,' ') cust_type, nvl(fe2.event_type,' ') event_type, " +
            		" nvl(fe2.event,' ') event, " +
            		" To_Char(ti.fltd,'yyyy/mm/dd') fltd2, ti.fltno, ti.trip, ti.fleet, ti.acno " +
            		" FROM egtstti ti, egtprfe2 fe2 " +
            		" WHERE ti.sernno = fe2.sernno AND ti.fltd between To_Date('"+sdate+"','yyyy/mm/dd') " +
            		" and To_Date('"+edate+"','yyyy/mm/dd') AND memo_type = 'C' ");
          
          if(!"ALL".equals(event_type))
          {
              sb.append(" AND event_type LIKE '%"+event_type+"%' ");
          }
          
          if(!"".equals(sect) && sect != null)
          {
              sb.append(" AND sect LIKE '%"+sect+"%' ");
          }

          sb.append(" ORDER BY ti.fltd, fe2.sernno, memo_type ");
  
//          System.out.println(sb.toString());
          rs = stmt.executeQuery(sb.toString());     
          objAL.clear();
          while (rs.next()) 
          {
              PRFuncEvalObj2 obj = new PRFuncEvalObj2();      
              obj.setFltd(rs.getString("fltd2"));
              obj.setFltno(rs.getString("fltno"));
              obj.setTrip(rs.getString("trip"));
              obj.setAcno(rs.getString("acno"));
              obj.setSeatno(rs.getString("seatno"));
              obj.setSeat_class(rs.getString("seat_class"));
              obj.setCust_name(rs.getString("cust_name"));
              obj.setCust_type(rs.getString("cust_type"));
              obj.setEvent_type(rs.getString("event_type"));
              obj.setEvent(rs.getString("event"));
              obj.setFleet(rs.getString("fleet"));     
              obj.setSect(rs.getString("sect"));
              objAL.add(obj);
          }
          returnStr = "Y";
      } 
      catch (SQLException e) 
      {
//          System.out.print(e.toString());
          returnStr = e.toString();
      } 
      catch (Exception e) 
      {
//          System.out.print(e.toString());
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
  //201410 cs80 add
    public void getPRFuncEvalStat3_2(String sdate, String edate, String sect, String event_type)
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
            
            sb.append(" SELECT fe2.sernno, fe2.sect, fe2.seatno, fe2.seat_class, nvl(fe2.cust_name,' ') cust_name, " +
                    "   nvl(tp.itemdsc, ' ') event_type, nvl(cc.feedback , ' ') event," +                   
                    " To_Char(ti.fltd,'yyyy/mm/dd') fltd2, ti.fltno, ti.trip, ti.fleet, ti.acno " +
                    " FROM egtstti ti, egtprfe2 fe2 ,egtprfc cc ,egtprcus tp" +
                    " WHERE ti.sernno = fe2.sernno  AND ti.sernno = cc.sernno" +
                    " AND fe2.seqno = cc.seqno AND cc.itemno = tp.itemno " +
                    " AND ti.sernno = cc.sernno  AND fe2.seqno = cc.seqno AND cc.itemno = tp.itemno " +
                    " AND ti.fltd between To_Date('"+sdate+"','yyyy/mm/dd') " +
                    " and To_Date('"+edate+"','yyyy/mm/dd') AND memo_type = 'C' ");
          
          if(!"ALL".equals(event_type))
          {
              sb.append(" AND event_type LIKE '%"+event_type+"%' ");
          }
          
          if(!"".equals(sect) && sect != null)
          {
              sb.append(" AND sect LIKE '%"+sect+"%' ");
          }

          sb.append(" ORDER BY ti.fltd, fe2.sernno, memo_type ");
  
//          System.out.println(sb.toString());
          rs = stmt.executeQuery(sb.toString());     
          objAL.clear();
          while (rs.next()) 
          {
              PRFuncEvalObj2 obj = new PRFuncEvalObj2();      
              obj.setFltd(rs.getString("fltd2"));
              obj.setFltno(rs.getString("fltno"));
              obj.setTrip(rs.getString("trip"));
              obj.setAcno(rs.getString("acno"));
              obj.setSeatno(rs.getString("seatno"));
              obj.setSeat_class(rs.getString("seat_class"));
              obj.setCust_name(rs.getString("cust_name"));
              obj.setCust_type(rs.getString("cust_type"));
              obj.setEvent_type(rs.getString("event_type"));
              obj.setEvent(rs.getString("event"));
              obj.setFleet(rs.getString("fleet"));     
              obj.setSect(rs.getString("sect"));
              objAL.add(obj);
          }
          returnStr = "Y";
      } 
      catch (SQLException e) 
      {
//          System.out.print(e.toString());
          returnStr = e.toString();
      } 
      catch (Exception e) 
      {
//          System.out.print(e.toString());
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

//  客艙管理觀察
    public void getPRFuncEvalStat4(String sdate, String edate)
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
            //cn.setORT1EG();
            //java.lang.Class.forName(cn.getDriver());
            //conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() , cn.getConnPW());      
            //stmt = conn.createStatement();
            
            sb.append(" SELECT To_Char(fltd,'yyyy/mm/dd') fltd, fltno, trip, purname, groups, instname, nvl(fe.memo,' ') memo " +
            		  " FROM egtstti ti, egtprfe2 fe , egtcbas cb " +
            		  " WHERE ti.fltd between To_Date('"+sdate+"','yyyy/mm/dd') and To_Date('"+edate+"','yyyy/mm/dd') " +
            		  " AND ti.sernno = fe.sernno AND memo_type ='A' AND ti.pursern = cb.sern ");
            sb.append(" ORDER BY ti.fltd, ti.fltno, instempno ");
  
//          System.out.println(sb.toString());
          rs = stmt.executeQuery(sb.toString());     
          objAL.clear();
          while (rs.next()) 
          {
              PRFuncEvalObj3 obj = new PRFuncEvalObj3();      
              obj.setFltd(rs.getString("fltd"));
              obj.setFltno(rs.getString("fltno"));
              obj.setSect(rs.getString("trip"));
              obj.setPurname(rs.getString("purname"));
              obj.setPurgrp(rs.getString("groups"));
              obj.setInstname(rs.getString("instname"));              
              obj.setMemo(rs.getString("memo"));
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

}

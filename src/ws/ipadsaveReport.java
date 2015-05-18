package ws;

import java.io.*;
import java.sql.*;
import java.util.*;
import ftp.*;

import org.apache.commons.fileupload.*;
import org.apache.commons.httpclient.methods.*;
import ws.header.*;

/**
 * @author 640790 Created on  2013/8/19 
 * cs80 2015/03/13 newdate => sysdate
 */
public class ipadsaveReport
{
    public static void main(String[] args)
    {
        saveReportCfltObj[] al = new saveReportCfltObj[1];
        ipadsaveReport obj = new ipadsaveReport();
        saveReportCfltObj  obj1 = new saveReportCfltObj();      
        
        String v= "07851Z";
        System.out.println(v.replaceAll("Z", ""));
        
        obj1.setFltd("2013/09/23");
        obj1.setFltno("0156");
        obj1.setSect("TPEKIX");
//        obj1.setCpname(null);
//        obj1.setCpno(null);
        obj1.setAcno("18316");
        obj1.setPsrempn("630304");
        obj1.setPsrsern("7314");
        obj1.setPsrname("jjj");
        obj1.setPgroups("2");  
        obj1.setChguser("630304");
        obj1.setChgdate("2013/09/26 10:43:10");
//        obj1.setRemark("");
//        obj1.setBook_f("0");
//        obj1.setBook_c("16");
//        obj1.setBook_y("199");
//        obj1.setPxac("244");
//        obj1.setUpd("Y");
//        obj1.setInf("0");
//        obj1.setReject("");
//        obj1.setReject_dt("");
//        obj1.setReply("");
//        obj1.setBdot("N");
//        obj1.setBdtime("");
//        obj1.setBdreason("");
//        obj1.setSh_st1("2013/08/19 12:00");
//        obj1.setSh_et1("2013/08/19 14:00");
//        obj1.setSh_st2("2013/08/19 14:00");
//        obj1.setSh_et2("2013/08/19 16:00");
//        obj1.setSh_st3(null);
//        obj1.setSh_et3(null);
//        obj1.setSh_st4(null);
//        obj1.setSh_et4(null);
//        obj1.setSh_remark("");
//        obj1.setShift("N");
//        obj1.setNoshift("");
//        obj1.setSh_cm("0");
        obj1.setUpdate_time("2013/09/25 10:43:10");    
        obj1.setNew_time("2013/09/24 10:43:10");       
        
        saveReportCrewScoreObj[] scoreobjAL = new saveReportCrewScoreObj[20];
        for(int i = 0; i<10; i++)
        {
	        saveReportCrewScoreObj crewobj1 = new saveReportCrewScoreObj();
	        crewobj1.setEmpn("63586"+i);
	        crewobj1.setSern("1740"+i);
	        crewobj1.setCrew("AAA"+i);
	        crewobj1.setScore("8");
	        crewobj1.setDuty("1R");
	        crewobj1.setGrp("1"); 
	        crewobj1.setSh_session("1");
	        crewobj1.setFd_ind("");
	        crewobj1.setNewuser("630304");
	        crewobj1.setChguser("630304");
	        crewobj1.setNewdate("2013/08/19 12:11");
	        crewobj1.setChgdate("2013/08/20 12:35");
	        scoreobjAL[i]=crewobj1;
        }
        obj1.setScoreobjAL(scoreobjAL);
        //***************************************
//        ArrayList gdobjAL = new ArrayList();
//        saveReportCrewGdObj obj2 = new saveReportCrewGdObj();
//        obj2.setYearsern("987654");
//        obj2.setEmpn("635851");
//        obj2.setSern("17401");
//        obj2.setFltd("2013/08/19");
//        obj2.setFltno("0006");
//        obj2.setSect("TPELAX");
//        obj2.setGdtype("GD1");
//        obj2.setComments("no comments");
//        obj2.setNewuser("630304");
//        obj2.setChguser("630304");
//        obj2.setNewdate("2013/08/19 12:13");
//        obj2.setChgdate("2013/08/19 12:19");
//        gdobjAL.add(obj2);
//        
//        obj2 = new saveReportCrewGdObj();
//        obj2.setEmpn("635852");
//        obj2.setSern("17402");
//        obj2.setFltd("2013/08/19");
//        obj2.setFltno("0006");
//        obj2.setSect("TPELAX");
//        obj2.setGdtype("GD2");
//        obj2.setComments("no comments");
//        obj2.setNewuser("630304");
//        obj2.setChguser("630304");
//        obj2.setNewdate("2013/08/19 12:13");
//        obj2.setChgdate("2013/08/19 12:19");
//        gdobjAL.add(obj2);
//        
//        obj1.setGdobjAL(gdobjAL);
//        //*************************************
//        
//        ArrayList fileobjAL = new ArrayList();
//        saveReportFileObj fobj = new saveReportFileObj();
//        fobj.setFltd("2013/08/19");
//        fobj.setFltno("0006");
//        fobj.setSect("TPELAX");
//        fobj.setFilename("20130819.jpg");
//        fobj.setFiledsc("test for upload file");
//        fobj.setUpduser("630304");
//        fobj.setUpddate("2013/08/20 12:30:12");
//        fileobjAL.add(fobj);
//        
//        obj1.setFileobjAL(fileobjAL);
        
        ArrayList fltirrobjAL = new ArrayList();
//      saveReportFileObj fobj = new saveReportFileObj();
//      fobj.setFltd("2013/08/19");
//      fobj.setFltno("0006");
//      fobj.setSect("TPELAX");
//      fobj.setFilename("20130819.jpg");
//      fobj.setFiledsc("test for upload file");
//      fobj.setUpduser("630304");
//      fobj.setUpddate("2013/08/20 12:30:12");
//      fileobjAL.add(fobj);
//      
//      obj1.setFileobjAL(fileobjAL);
        
        al[0]=obj1;
        System.out.println(obj.dosync(al));
    }
    
    private Connection con = null;
    private PreparedStatement pstmt = null;
	private Statement stmt = null;
	private ResultSet rs = null;
	private Driver dbDriver = null;
	private String sql ="";
	private String error_sql ="";
	private String error_step ="";
	private String path = "/apsource/csap/projfz/txtin/appLogs/";
	private FileWriter fw = null;
	private String error_str ="";	
	private String insert_sql ="";
	
  public String dosync2(saveReportCfltObj[] saverptAL, String sysPwd) 
  {
      
      boolean wsAuth = false;
      ThreeDes d = new ThreeDes();
      wsAuth = d.auth(sysPwd);
      if(wsAuth)
      {
          return dosync(saverptAL);  
      }
      else
      {
          return "No Auth.";              
      }
         
  }

  public String dosync(saveReportCfltObj[] saverptAL) 
    {        
        ci.db.ConnDB cn = new ci.db.ConnDB();
	    StringBuffer sqlsb = new StringBuffer();
	    String ifupdate = "Y";
	    String seqno_str = ""; 
	    String cfltReject = null;
	    String clftRejDT = null;
	    try
	    {
	        cn.setORP3EGUserCP();
	    	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	    	con = dbDriver.connect(cn.getConnURL(), null);
	    	
	    	//connect ORT1 EG            
//	    	cn.setORT1EG();
//	    	Class.forName(cn.getDriver());
//	    	con = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());	
	    	
	    	con.setAutoCommit(false);	
	    	stmt = con.createStatement();
	    		
	    	if(saverptAL.length>0)
	    	{
	        for(int i=0; i<saverptAL.length; i++)
	        { 
	            ifupdate = "Y";
	            //saveReportCfltObj saverptobj = (saveReportCfltObj)saverptAL[i];
	            if(!"".equals(saverptAL[i].getFltd()) && !"".equals(saverptAL[i].getFltno()) && !"".equals(saverptAL[i].getSect()) && saverptAL[i].getFltd() != null && saverptAL[i].getFltno() != null && saverptAL[i].getSect() != null)
	            {
	                  saverptAL[i].setPsrempn(saverptAL[i].getPsrempn().trim());//去空格
                      //檢查是否為delay 航班, 是否需修改 fltd & fltno +Z
                      //**************************************************************
                      String fdate_aircrews = saverptAL[i].getFltd();//aircrews 調整後的日期
                      String fltno_cflt = saverptAL[i].getFltno();//判斷是否加Z後的航班號碼
                      
                      sql =" select to_char(dps.str_dt_tm_loc,'yyyy/mm/dd') fdate," +
                           " dps.flt_num fltno,to_char(str_dt_tm_loc,'yyyy/mm/dd hh24:mi') stdDt, " +
                           " to_char(str_dt_tm_loc,'hh24mi') ftime, dps.act_port_a dpt,dps.act_port_b arv " +
                           " from duty_prd_seg_v dps, roster_v r where dps.series_num=r.series_num " +
                           " and dps.delete_ind = 'N' AND  r.delete_ind='N' " +
                           " and r.staff_num ='"+saverptAL[i].getPsrempn()+"' " +
                           " AND dps.str_dt_tm_loc BETWEEN  to_date('"+saverptAL[i].getFltd()+" 00:00','yyyy/mm/dd hh24:mi') " +
                           " AND to_date('"+saverptAL[i].getFltd()+" 23:59','yyyy/mm/dd hh24:mi') +1 " +
                           " AND dps.port_a||dps.port_b ='"+saverptAL[i].getSect()+"' " +
                           " AND r.duty_cd='FLY' AND dps.duty_cd IN ('FLY','TVL') " +
                           " AND ( r.acting_rank IN ('PR','MC')  OR Nvl(r.special_indicator,' ') = 'J') order by str_dt_tm_gmt ";
                             
                      rs = stmt.executeQuery(sql);
                  
                      if (rs.next()) 
                      {
                            fdate_aircrews = rs.getString("fdate");      
                            fz.pracP.GetFltnoWithSuffix gf = new fz.pracP.GetFltnoWithSuffix(fdate_aircrews.substring(0, 4)+fdate_aircrews.substring(5, 7)+fdate_aircrews.substring(8),rs.getString("fltno"), rs.getString("dpt")+rs.getString("arv"),rs.getString("stdDt"));
                            if (gf.getFltnoWithSuffix().indexOf("Z") > -1) 
                            {
                                // 最後一碼為Z時，不檢查delay班次號碼
                                fltno_cflt =gf.getFltnoWithSuffix();
                            }
                     }              
                      
                     if(!saverptAL[i].getFltd().equals(fdate_aircrews) || !saverptAL[i].getFltno().equals(fltno_cflt))
                     {//更改存入的fltd & fltno
                         saverptAL[i].setFltd(fdate_aircrews);
                         saverptAL[i].setFltno(fltno_cflt);
                     }
                     //*************************************************************************************
	                
	                //check if ipad's is updated data
	                //saverptAL[i].getUpdate_time() 較小或已送出則無需覆蓋(更新)
//	                if(saverptAL[i].getUpdate_time()!=null && !"".equals(saverptAL[i].getUpdate_time()) && !"N".equals(saverptAL[i].getUpd()))
	                if(saverptAL[i].getUpdate_time()!=null && !"".equals(saverptAL[i].getUpdate_time()))
	                {
	                    //check report status
	                    saveRptCheck src = new saveRptCheck();
	                    String status_str = src.doSaveReportCheck(saverptAL[i].getFltd(),saverptAL[i].getFltno(),saverptAL[i].getSect());
	                    
	                    if("Y".equals(status_str))
	                    {	                    
        	                sql = "select CASE WHEN To_Date('"+saverptAL[i].getUpdate_time()+"','yyyy/mm/dd hh24:mi:ss') <= chgdate THEN 'N' ELSE 'Y' END ifupdated from egtcflt where fltd = to_date('"+saverptAL[i].getFltd()+"','yyyy/mm/dd') and fltno = '"+saverptAL[i].getFltno()+"' and sect = '"+saverptAL[i].getSect()+"'";	                
        	                rs = stmt.executeQuery(sql);
        
        	                if (rs.next()) 
        	    			{
        	                    ifupdate = rs.getString("ifupdated");	   
        	                    ifupdate = ifupdate.trim();        	                    
        	    			}
	                    }
	                    else
	                    {
	                        return status_str;
	                    }
	                }
//	                else if ("N".equals(saverptAL[i].getUpd()))
//	                {
//	                    saveRptCheck src = new saveRptCheck();
//                        String status_str = src.doSaveReportCheck(saverptAL[i].getFltd(),saverptAL[i].getFltno(),saverptAL[i].getSect());
//	                    error_str = status_str;
//	                    if("Y".equals(error_str))
//	                    {}
//	                    else
//	                    {
//	                        return status_str;
//	                    }
//	                }
	                else
	                {
	                    error_str = "資料不完整，資料同步失敗";
	                    return "資料不完整，資料同步失敗";
	                }
	                
	                //檢查是否有其它CM已編輯
	                if("Y".equals(ifupdate))
                    {
    	              //先檢查是否已有其它CM已編輯
                        sql = "select count(*) c from egtcflt where fltd = to_date('"+saverptAL[i].getFltd()+"','yyyy/mm/dd') and fltno = '"+saverptAL[i].getFltno()+"' and sect = '"+saverptAL[i].getSect()+"' and psrempn <> '"+saverptAL[i].getPsrempn()+"' and psrempn <> null ";
                        rs = stmt.executeQuery(sql);
                        
                        if (rs.next()) 
                        {
                            if(rs.getInt("c")>0)
                            {
                                return "該班報告已存在,請勿重複編輯!!";
                            }
                        }
                        rs.close();
                    }
	                //2015/03/11
	                //檢查是否被退報告,存regect time 
	                if("Y".equals(ifupdate))
                    {
                      //檢查是否被退報告,存regect time 
                        sql = "select  reject, to_char(reject_dt,'yyyy/mm/dd hh24:mi') reject_dt from egtcflt where fltd = to_date('"+saverptAL[i].getFltd()+"','yyyy/mm/dd') and fltno = '"+saverptAL[i].getFltno()+"' and sect = '"+saverptAL[i].getSect()+"' and psrempn = '"+saverptAL[i].getPsrempn()+"' ";
                        rs = stmt.executeQuery(sql);
                        if (rs.next()) 
                        {
                            cfltReject = rs.getString("reject");
                            clftRejDT = rs.getString("reject_dt");
                        }
                        rs.close();
                    }
	                //檢查組員名單是否為空
	                if("Y".equals(ifupdate))                    
	                {
	                    if(saverptAL[i].getScoreobjAL() != null)
                        {                           
                            saveReportCrewScoreObj insertcrewobj = saverptAL[i].getScoreobjAL()[0];                                                             
                            if(insertcrewobj==null)
                            {   
                                return "AirCrews班表資訊有異動 ，請重新整理月班表 ，再進My Flight更新資訊!";
                            }     
                            else
                            {
                                if(insertcrewobj.getEmpn()==null | "".equals(insertcrewobj.getEmpn()))
                                {
                                    return "AirCrews班表資訊有異動 ，請重新整理月班表 ，再進My Flight更新資訊!";
                                }else{
                                    for(int j =0; j<saverptAL[i].getScoreobjAL().length; j++)   
                                    {
                                        insertcrewobj = saverptAL[i].getScoreobjAL()[j];
                                                                         
                                        if(insertcrewobj!=null)
                                        {  
                                            if(insertcrewobj.getEmpn().length() > 6 || insertcrewobj.getSern().length() > 5)
                                            {
                                                return "儲存失敗-組員名單:員工號及序號輸入錯誤,請確認!";
                                            }
                                        }
                                    }
                                }                               
                            }
                        }
	                    else
	                    {
	                        return "AirCrews班表資訊有異動 ，請重新整理月班表 ，再進My Flight更新資訊!";
	                    }
                    }
	                //檢查cflt參數
	                if(saverptAL[i].getBook_f().length() > 3 || saverptAL[i].getBook_c().length() > 3 ||
                        saverptAL[i].getBook_y().length() > 3 || saverptAL[i].getBook_w().length() > 3 ||
                        saverptAL[i].getInf().length() >3 || saverptAL[i].getPxac().length() >3)
                    {
                        ifupdate = "N";
                        return "儲存失敗-航班艙等人數有誤,請確認!";
                    }else{
                        ifupdate = "Y";
                    }
	                
	                
	                if("Y".equals(ifupdate))
	                {
	                    
//						System.out.println("saverptAL[i].scoreobjAL.size() = "+saverptAL[i].scoreobjAL.size());
	                    
		                //delete egtcflt then insert 
						sql = " delete from egtcflt where fltd = to_date('"+saverptAL[i].getFltd()+"','yyyy/mm/dd') and fltno = '"+saverptAL[i].getFltno()+"' and sect = '"+saverptAL[i].getSect()+"'";
						stmt.executeUpdate(sql); 
						
						error_step = "儲存組員名單";
						
						sqlsb = new StringBuffer();
		                sqlsb.append("insert into egtcflt (fltd,fltno,sect,cpname,cpno,acno,psrempn,psrsern,psrname,pgroups,");
		                for(int j =1; j<=20; j++)
		                {
		                    sqlsb.append("empn"+j+",sern"+j+",crew"+j+",score"+j+",duty"+j+",sh_crew"+j+",");
		                }		                
		                sqlsb.append("chguser,chgdate,remark,book_f,book_c,book_y,book_w,pxac,upd,inf,reject,reject_dt,reply,bdot,bdtime,bdreason,sh_st1,sh_et1,sh_st2,sh_et2,sh_st3,sh_et3,sh_st4,sh_et4,sh_remark,shift,noshift,sh_cm,mp_empn,sh_mp)");
		                
		                sqlsb.append(" values (to_date(?,'yyyy/mm/dd'),?,?,?,?,?,?,?,?,?,");
		                
//			            for(int j =0; j<saverptAL[i].scoreobjAL.length; j++)
		                for(int j =1; j<=20; j++)
		                {			                   
		                    sqlsb.append("?,?,?,?,?,?,");		                    
		                }      
		                
		                sqlsb.append("?,to_date(?,'yyyy/mm/dd hh24:mi:ss'),?,?,?,?,?,?,?,?,?,to_date(?,'yyyy/mm/dd hh24:mi'),?,?,to_date(?,'yyyy/mm/dd hh24:mi'),?,to_date(?,'yyyy/mm/dd hh24:mi'),to_date(?,'yyyy/mm/dd hh24:mi'),to_date(?,'yyyy/mm/dd hh24:mi'),to_date(?,'yyyy/mm/dd hh24:mi'),to_date(?,'yyyy/mm/dd hh24:mi'),to_date(?,'yyyy/mm/dd hh24:mi'),to_date(?,'yyyy/mm/dd hh24:mi'),to_date(?,'yyyy/mm/dd hh24:mi'),?,?,?,?,?,?)");
		                              
//error_str=sqlsb.toString();
		                
		                pstmt = con.prepareStatement(sqlsb.toString());

		                int idx =0;
		    			pstmt.setString(++idx, saverptAL[i].getFltd());
		    			pstmt.setString(++idx, saverptAL[i].getFltno());
		    			pstmt.setString(++idx, saverptAL[i].getSect());
		    			pstmt.setString(++idx, saverptAL[i].getCpname());
		    			pstmt.setString(++idx, saverptAL[i].getCpno());
		    			pstmt.setString(++idx, saverptAL[i].getAcno());
		    			pstmt.setString(++idx, saverptAL[i].getPsrempn());
		    			pstmt.setString(++idx, saverptAL[i].getPsrsern());
		    			pstmt.setString(++idx, saverptAL[i].getPsrname());
		    			pstmt.setString(++idx, saverptAL[i].getPgroups());	
    			
		    			if(saverptAL[i].getScoreobjAL() != null)
		    			{
    		    			for(int j =0; j<saverptAL[i].getScoreobjAL().length; j++)   
    		                {
    		                    saveReportCrewScoreObj insertcrewobj = saverptAL[i].getScoreobjAL()[j];
    	                    		                             
    		                    if(insertcrewobj==null)
                                {  
                                    pstmt.setString(++idx, "000000");
                                    pstmt.setString(++idx, "0");
                                    pstmt.setString(++idx, null);
                                    pstmt.setString(++idx, "0");
                                    pstmt.setString(++idx, null);
                                    pstmt.setString(++idx, "0");                          
                                }
                                else //if(insertcrewobj.getEmpn()!=null)
                                {
                                    pstmt.setString(++idx, insertcrewobj.getEmpn());
                                    pstmt.setString(++idx, insertcrewobj.getSern());
                                    pstmt.setString(++idx, insertcrewobj.getCrew());
                                    pstmt.setString(++idx, insertcrewobj.getScore());
                                    pstmt.setString(++idx, insertcrewobj.getDuty());
                                    pstmt.setString(++idx, insertcrewobj.getSh_session());   
                                }                    
    		                    
    		                }
    		    			
    		    			for(int j =saverptAL[i].getScoreobjAL().length; j<20; j++)   
                            {
                                pstmt.setString(++idx, "000000");
                                pstmt.setString(++idx, "0");
                                pstmt.setString(++idx, null);
                                pstmt.setString(++idx, "0");
                                pstmt.setString(++idx, null);
                                pstmt.setString(++idx, "0");                       
                            }  
		    			}
		    			else//if(saverptAL[i].getScoreobjAL() != null)
		    			{
		    			    for(int j = 0; j<20; j++)   
                            {
                                pstmt.setString(++idx, "000000");
                                pstmt.setString(++idx, "0");
                                pstmt.setString(++idx, null);
                                pstmt.setString(++idx, "0");
                                pstmt.setString(++idx, null);
                                pstmt.setString(++idx, "0");                       
                            }  		    			    
		    			}
		    			
		    			pstmt.setString(++idx, saverptAL[i].getChguser());
		    			pstmt.setString(++idx, saverptAL[i].getChgdate());
		    			pstmt.setString(++idx, saverptAL[i].getRemark());
		    			pstmt.setString(++idx, saverptAL[i].getBook_f());
		    			pstmt.setString(++idx, saverptAL[i].getBook_c());
		    			pstmt.setString(++idx, saverptAL[i].getBook_y());
		    			pstmt.setString(++idx, saverptAL[i].getBook_w());
		    			pstmt.setString(++idx, saverptAL[i].getPxac());
//		    			pstmt.setString(++idx, saverptAL[i].getUpd());
		    			pstmt.setString(++idx, "Y");
		    			pstmt.setString(++idx, saverptAL[i].getInf());
		    			pstmt.setString(++idx, cfltReject);//saverptAL[i].getReject()
		    			pstmt.setString(++idx, clftRejDT);//saverptAL[i].getReject_dt()
		    			pstmt.setString(++idx, saverptAL[i].getReply());
		    			pstmt.setString(++idx, saverptAL[i].getBdot());
		    			pstmt.setString(++idx, saverptAL[i].getBdtime());
		    			pstmt.setString(++idx, saverptAL[i].getBdreason());
		    			pstmt.setString(++idx, saverptAL[i].getSh_st1());
		    			pstmt.setString(++idx, saverptAL[i].getSh_et1());
		    			pstmt.setString(++idx, saverptAL[i].getSh_st2());
		    			pstmt.setString(++idx, saverptAL[i].getSh_et2());
		    			pstmt.setString(++idx, saverptAL[i].getSh_st3());
		    			pstmt.setString(++idx, saverptAL[i].getSh_et3());
		    			pstmt.setString(++idx, saverptAL[i].getSh_st4());
		    			pstmt.setString(++idx, saverptAL[i].getSh_et4());		    			
		    			pstmt.setString(++idx, saverptAL[i].getSh_remark());
		    			pstmt.setString(++idx, saverptAL[i].getShift());
		    			pstmt.setString(++idx, saverptAL[i].getNoshift());
		    			pstmt.setString(++idx, saverptAL[i].getSh_cm());	
		    			pstmt.setString(++idx, saverptAL[i].getMp_empn());
		    			pstmt.setString(++idx, saverptAL[i].getSh_mp());	
		    			
		    			//*************************************************
		    			error_sql = error_sql + "insert into egtcflt (fltd,fltno,sect,cpname,cpno,acno,psrempn,psrsern,psrname,pgroups,";
                        for(int j =1; j<=20; j++)
                        {
                            error_sql = error_sql + "empn"+j+",sern"+j+",crew"+j+",score"+j+",duty"+j+",sh_crew"+j+",";
                        }                       
                        error_sql = error_sql + "chguser,chgdate,remark,book_f,book_c,book_y,book_w,pxac,upd,inf,reject,reject_dt,reply,bdot,bdtime,bdreason,sh_st1,sh_et1,sh_st2,sh_et2,sh_st3,sh_et3,sh_st4,sh_et4,sh_remark,shift,noshift,sh_cm,mp_empn,sh_mp)";
                        
                        error_sql = error_sql + " values (to_date('"+saverptAL[i].getFltd()+"','yyyy/mm/dd'),'"+saverptAL[i].getFltno()+"','"+saverptAL[i].getSect()+"','"+saverptAL[i].getCpname()+"','"+saverptAL[i].getCpno()+"','"+saverptAL[i].getAcno()+"','"+saverptAL[i].getPsrempn()+"','"+saverptAL[i].getPsrsern()+"','"+saverptAL[i].getPsrname()+"','"+saverptAL[i].getPgroups()+"',";
                        
                                            
                        for(int j =0; j<saverptAL[i].getScoreobjAL().length; j++)   
                        {
                            saveReportCrewScoreObj insertcrewobj = saverptAL[i].getScoreobjAL()[j];
                                                             
                            if(insertcrewobj==null)
                            {  
                                error_sql = error_sql + " ,'000000','0',null,'0',null,'0'";                     
                            }
                            else //if(insertcrewobj.getEmpn()!=null)
                            {
                                error_sql = error_sql + " '"+insertcrewobj.getEmpn()+"','"+insertcrewobj.getSern()+"','"+insertcrewobj.getCrew()+"','"+insertcrewobj.getScore()+"','"+insertcrewobj.getDuty()+"','"+insertcrewobj.getSh_session()+"',";
                            }                    
                            
                        }
                        
                        for(int j =saverptAL[i].getScoreobjAL().length; j<20; j++)   
                        {
                            error_sql = error_sql + " ,'000000','0',null,'0',null,'0'";                       
                        } 
                        
                        error_sql = error_sql + " '"+saverptAL[i].getChguser()+"',to_date('"+saverptAL[i].getChgdate()+"','yyyy/mm/dd hh24:mi:ss'),'"+saverptAL[i].getRemark()+"','"+saverptAL[i].getBook_f()+"','"+saverptAL[i].getBook_w()+"','"+saverptAL[i].getBook_c()+"','"+saverptAL[i].getBook_y()+"','"+saverptAL[i].getPxac()+"','"+saverptAL[i].getUpd()+"','"+saverptAL[i].getInf()+"','"+cfltReject+"', to_date('"+clftRejDT+"','yyyy/mm/dd hh24:mi'),'"+saverptAL[i].getReply()+"','"+saverptAL[i].getBdot()+"','"+saverptAL[i].getBdtime()+"','"+saverptAL[i].getBdreason()+"',to_date('"+saverptAL[i].getSh_st1()+"','yyyy/mm/dd hh24:mi'),to_date('"+saverptAL[i].getSh_et1()+"','yyyy/mm/dd hh24:mi'),to_date('"+saverptAL[i].getSh_st2()+"','yyyy/mm/dd hh24:mi'),to_date('"+saverptAL[i].getSh_et2()+"','yyyy/mm/dd hh24:mi'),to_date('"+saverptAL[i].getSh_st3()+"','yyyy/mm/dd hh24:mi'),to_date('"+saverptAL[i].getSh_et3()+"','yyyy/mm/dd hh24:mi'),to_date('"+saverptAL[i].getSh_st4()+"','yyyy/mm/dd hh24:mi'),to_date('"+saverptAL[i].getSh_et4()+"','yyyy/mm/dd hh24:mi'),'"+saverptAL[i].getSh_remark()+"','"+saverptAL[i].getShift()+"','"+saverptAL[i].getNoshift()+"','"+saverptAL[i].getSh_cm()+"','"+saverptAL[i].getMp_empn()+"','"+saverptAL[i].getSh_mp()+"')";
                        //*************************************************
                        insert_sql = saverptAL[i].getFltd()+" - "+ saverptAL[i].getFltno()+" - "+saverptAL[i].getSect()+" - "+saverptAL[i].getPsrempn()+" - "+ new java.util.Date();
                        
		    			pstmt.executeUpdate();
		    			
		    			error_step = "儲存組員分數";
		    			error_sql = "";
		    			//delete egtgddt then insert score record
						sql = " delete FROM egtgddt where fltd = to_date('"+saverptAL[i].getFltd()+"','yyyy/mm/dd') and fltno = '"+saverptAL[i].getFltno()+"' and sect = '"+saverptAL[i].getSect()+"'";
						stmt.executeUpdate(sql);  
						
						if(saverptAL[i].getScoreobjAL()!= null)
						{
							sqlsb = new StringBuffer();
							sqlsb.append("insert into egtgddt (yearsern,gdyear,empn,sern,fltd,fltno,sect,gdtype,score,comments,newuser,newdate,chguser,chgdate) values ");
							sqlsb.append("(EGQGDYS.NEXTVAL,(SELECT CASE WHEN To_Number(To_Char(to_date(?,'yyyy/mm/dd'),'mm'))>=11 THEN To_Number(To_Char(to_date(?,'yyyy/mm/dd'),'yyyy'))+1 ELSE To_Number(To_Char(to_date(?,'yyyy/mm/dd'),'yyyy')) END gdyear FROM dual),?,?,to_date(?,'yyyy/mm/dd'),?,?,null,?,null,?,sysdate,?,to_date(?,'yyyy/mm/dd hh24:mi:ss'))");
							
							pstmt.clearParameters();
							pstmt=null;
							pstmt = con.prepareStatement(sqlsb.toString());
							
							for(int j =0; j<saverptAL[i].getScoreobjAL().length; j++)
			                {
							    idx =0;
			                    saveReportCrewScoreObj insertcrewobj = saverptAL[i].getScoreobjAL()[j];
			                    if(insertcrewobj.getScore() != null && !"0".equals(insertcrewobj.getScore()) && !"X".equals(insertcrewobj.getScore()) && !"".equals(insertcrewobj.getScore()))
			                    {
				                    pstmt.setString(++idx, saverptAL[i].getFltd());
				                    pstmt.setString(++idx, saverptAL[i].getFltd());
				                    pstmt.setString(++idx, saverptAL[i].getFltd());
				                    pstmt.setString(++idx, insertcrewobj.getEmpn());
				                    pstmt.setString(++idx, insertcrewobj.getSern());
				                    pstmt.setString(++idx, saverptAL[i].getFltd());
				                    pstmt.setString(++idx, saverptAL[i].getFltno());
				                    pstmt.setString(++idx, saverptAL[i].getSect());			                    
				                    pstmt.setString(++idx, insertcrewobj.getScore());
				                    pstmt.setString(++idx, insertcrewobj.getNewuser());
//				                    pstmt.setString(++idx, insertcrewobj.getNewdate());
				                    pstmt.setString(++idx, insertcrewobj.getChguser());
				                    pstmt.setString(++idx, insertcrewobj.getChgdate());
				                    error_sql += insertcrewobj.getEmpn()+","+insertcrewobj.getSern()+","+insertcrewobj.getScore()+"\n";
				                    pstmt.addBatch();
			                    }
			                }
							pstmt.executeBatch();
							pstmt.clearBatch();	
						}
						
//						insert GDitem has no yearsern#
						if(saverptAL[i].getGdobjAL()!=null)
						{
						    error_step = "儲存組員新的考評";
							sqlsb = new StringBuffer();
							sqlsb.append("insert into egtgddt (yearsern,gdyear,empn,sern,fltd,fltno,sect,gdtype,score,comments,newuser,newdate,chguser,chgdate) values ");
							sqlsb.append("(EGQGDYS.NEXTVAL,(SELECT CASE WHEN To_Number(To_Char(to_date(?,'yyyy/mm/dd'),'mm'))>=11 THEN To_Number(To_Char(to_date(?,'yyyy/mm/dd'),'yyyy'))+1 ELSE To_Number(To_Char(to_date(?,'yyyy/mm/dd'),'yyyy')) END gdyear FROM dual),?,?,to_date(?,'yyyy/mm/dd'),?,?,?,null,?,?,sysdate,?,to_date(?,'yyyy/mm/dd hh24:mi:ss'))");
							
							pstmt=null;
							pstmt = con.prepareStatement(sqlsb.toString());
							
							for(int j =0; j<saverptAL[i].getGdobjAL().length; j++)
			                {
							    idx =0;
							    saveReportCrewGdObj insertgdobj = saverptAL[i].getGdobjAL()[j];
							    if("".equals(insertgdobj.getYearsern()) || insertgdobj.getYearsern() == null)
							    {
							        if(!"".equals(insertgdobj.getGdtype()) && insertgdobj.getGdtype() != null && insertgdobj.getEmpn() != null && !"".equals(insertgdobj.getEmpn()))
							        {
    			                        pstmt.setString(++idx, saverptAL[i].getFltd());
    				                    pstmt.setString(++idx, saverptAL[i].getFltd());
    				                    pstmt.setString(++idx, saverptAL[i].getFltd());
    				                    pstmt.setString(++idx, insertgdobj.getEmpn());
    				                    pstmt.setString(++idx, insertgdobj.getSern());
    				                    pstmt.setString(++idx, saverptAL[i].getFltd());
    				                    pstmt.setString(++idx, saverptAL[i].getFltno());
    				                    pstmt.setString(++idx, saverptAL[i].getSect());			                    
    				                    pstmt.setString(++idx, insertgdobj.getGdtype());
    				                    pstmt.setString(++idx, insertgdobj.getComments());
    				                    pstmt.setString(++idx, insertgdobj.getNewuser());
//    				                    pstmt.setString(++idx, insertgdobj.getNewdate());
    				                    pstmt.setString(++idx, insertgdobj.getChguser());
    				                    pstmt.setString(++idx, insertgdobj.getChgdate());
    				                    pstmt.addBatch();
							        }
							    }			                    
			                }	
							pstmt.executeBatch();
							pstmt.clearBatch();	
						}
						
//							//insert GDitem has yearsern#

						if(saverptAL[i].getGdobjAL()!= null)
						{
						    error_step = "儲存組員原考評";
						    error_sql = "";
							sqlsb = new StringBuffer();
							sqlsb.append("insert into egtgddt (yearsern,gdyear,empn,sern,fltd,fltno,sect,gdtype,score,comments,newuser,newdate,chguser,chgdate) values ");
							sqlsb.append("(?,(SELECT CASE WHEN To_Number(To_Char(to_date(?,'yyyy/mm/dd'),'mm'))>=11 THEN To_Number(To_Char(to_date(?,'yyyy/mm/dd'),'yyyy'))+1 ELSE To_Number(To_Char(to_date(?,'yyyy/mm/dd'),'yyyy')) END gdyear FROM dual),?,?,to_date(?,'yyyy/mm/dd'),?,?,?,null,?,?,sysdate,?,to_date(?,'yyyy/mm/dd hh24:mi:ss'))");
							pstmt=null;
							
							pstmt = con.prepareStatement(sqlsb.toString());
							
							for(int j =0; j<saverptAL[i].getGdobjAL().length; j++)
			                {
							    idx =0;
							    saveReportCrewGdObj insertgdobj = saverptAL[i].getGdobjAL()[j];
							    if(!"".equals(insertgdobj.getYearsern()) && insertgdobj.getYearsern() != null)
							    {
							        if(!"".equals(insertgdobj.getGdtype()) && insertgdobj.getGdtype() != null && insertgdobj.getEmpn() != null && !"".equals(insertgdobj.getEmpn()))
                                    {
    							        pstmt.setString(++idx, insertgdobj.getYearsern());
    							        error_sql += insertgdobj.getYearsern()+"\n";
    			                        pstmt.setString(++idx, saverptAL[i].getFltd());
    				                    pstmt.setString(++idx, saverptAL[i].getFltd());
    				                    pstmt.setString(++idx, saverptAL[i].getFltd());
    				                    pstmt.setString(++idx, insertgdobj.getEmpn());
    				                    pstmt.setString(++idx, insertgdobj.getSern());
    				                    pstmt.setString(++idx, saverptAL[i].getFltd());
    				                    pstmt.setString(++idx, saverptAL[i].getFltno());
    				                    pstmt.setString(++idx, saverptAL[i].getSect());			                    
    				                    pstmt.setString(++idx, insertgdobj.getGdtype());
    				                    pstmt.setString(++idx, insertgdobj.getComments());
    				                    pstmt.setString(++idx, insertgdobj.getNewuser());
//    				                    pstmt.setString(++idx, insertgdobj.getNewdate());
    				                    pstmt.setString(++idx, insertgdobj.getChguser());
    				                    pstmt.setString(++idx, insertgdobj.getChgdate());
    				                    pstmt.addBatch();
                                    }
							    }
			                }	
							pstmt.executeBatch();
							pstmt.clearBatch();	
						}
							
						//delete egtcmdt then insert 客艙動態							
						sql = " delete FROM egtcmdt where fltd = to_date('"+saverptAL[i].getFltd()+"','yyyy/mm/dd') and fltno = '"+saverptAL[i].getFltno()+"' and sect = '"+saverptAL[i].getSect()+"'";
						stmt.executeUpdate(sql);  
						
						//insert 客艙動態 has no yearsern#
						if(saverptAL[i].getFltirrobjAL()!= null)
						{
						    error_step = "儲存新的客艙動態";
						    error_sql = "";
							sqlsb = new StringBuffer();
							sqlsb.append(" INSERT INTO egtcmdt(yearsern,fltd,fltno,sect,acno,psrname,psrsern,itemno,itemdsc,comments,depmt,caseclose,newdate,newuser,chgdate,chguser,flag,depcomm,reply,clb,mcr,rca,emg) ");
							sqlsb.append(" VALUES (egqcmys.nextval,To_Date(?,'yyyy/mm/dd'),?,?,?,?,?,?,?,?,?,nvl(?,'N'),sysdate,?,to_date(?,'yyyy/mm/dd hh24:mi:ss'),?,?,?,?,?,?,?,?)");
							
							pstmt=null;
							pstmt = con.prepareStatement(sqlsb.toString());
							
							for(int j =0; j<saverptAL[i].getFltirrobjAL().length; j++)
			                {		
							    idx=0;
							    saveReportFltIrrObj fltirrobj = saverptAL[i].getFltirrobjAL()[j];
							    if("".equals(fltirrobj.getYearsern()) || fltirrobj.getYearsern() == null)
							    {
							        if(!"".equals(fltirrobj.getItemno()) && fltirrobj.getItemno() != null)
							        {
							            if("I01".equals(fltirrobj.getItemno()) && "低於服務派遣".equals(fltirrobj.getItemno_dsc()))
							            {
							                fltirrobj.setItemno_dsc("低於服務派遣一人");
							            }
    									pstmt.setString(++idx,saverptAL[i].getFltd());
    									pstmt.setString(++idx,saverptAL[i].getFltno());
    									pstmt.setString(++idx,saverptAL[i].getSect());
    									pstmt.setString(++idx,saverptAL[i].getAcno());
    									pstmt.setString(++idx,saverptAL[i].getPsrname());
    									pstmt.setString(++idx,saverptAL[i].getPsrsern());
    									pstmt.setString(++idx,fltirrobj.getItemno());
    									pstmt.setString(++idx,fltirrobj.getItemno_dsc());
    									pstmt.setString(++idx,fltirrobj.getComments());
    									pstmt.setString(++idx,fltirrobj.getDepmt());
    									pstmt.setString(++idx,fltirrobj.getCaseclose());
//    									pstmt.setString(++idx,fltirrobj.getNewdate());
    									pstmt.setString(++idx,fltirrobj.getNewuser());
    									pstmt.setString(++idx,fltirrobj.getChgdate());
    									pstmt.setString(++idx,fltirrobj.getChguser());
    									pstmt.setString(++idx,fltirrobj.getFlag());
    									pstmt.setString(++idx,fltirrobj.getDepcomm());
    									pstmt.setString(++idx,fltirrobj.getReply());
    									pstmt.setString(++idx,fltirrobj.getClb());
    									pstmt.setString(++idx,fltirrobj.getMcr());
    									pstmt.setString(++idx,fltirrobj.getRca());
    									pstmt.setString(++idx,fltirrobj.getEmg());
    									error_sql += saverptAL[i].getPsrname() +","+saverptAL[i].getPsrsern()+","+fltirrobj.getItemno()+","+fltirrobj.getItemno_dsc()+","+fltirrobj.getComments()+","+
    									        fltirrobj.getDepmt()+","+fltirrobj.getCaseclose()+","+fltirrobj.getFlag()+","+fltirrobj.getDepcomm()+","+fltirrobj.getReply()+","+
    									        fltirrobj.getClb()+","+fltirrobj.getMcr()+","+fltirrobj.getRca()+","+fltirrobj.getEmg()+"\n";
    									pstmt.addBatch();
							        }
							    }
			                }
							pstmt.executeBatch();
							pstmt.clearBatch();	
						}
						
						//insert 客艙動態 has yearsern#
						if(saverptAL[i].getFltirrobjAL()!= null)
						{
						    error_step = "儲存原客艙動態";
						    error_sql = "";
							sqlsb = new StringBuffer();
							sqlsb.append(" INSERT INTO egtcmdt(yearsern,fltd,fltno,sect,acno,psrname,psrsern,itemno,itemdsc,comments,depmt,caseclose,newdate,newuser,chgdate,chguser,flag,depcomm,reply,clb,mcr,rca,emg) ");
							sqlsb.append(" VALUES (?,To_Date(?,'yyyy/mm/dd'),?,?,?,?,?,?,?,?,?,nvl(?,'N'),sysdate,?,to_date(?,'yyyy/mm/dd hh24:mi:ss'),?,?,?,?,?,?,?,?)");
							pstmt=null;
							pstmt = con.prepareStatement(sqlsb.toString());
							
							for(int j =0; j<saverptAL[i].getFltirrobjAL().length; j++)
			                {		
							    idx=0;
							    saveReportFltIrrObj fltirrobj = saverptAL[i].getFltirrobjAL()[j];
							    if(!"".equals(fltirrobj.getYearsern()) && fltirrobj.getYearsern() != null)
							    {
							        if(!"".equals(fltirrobj.getItemno()) && fltirrobj.getItemno() != null)
                                    {
							            if("I01".equals(fltirrobj.getItemno()) && "低於服務派遣".equals(fltirrobj.getItemno_dsc()))
                                        {
                                            fltirrobj.setItemno_dsc("低於服務派遣一人");
                                        }
    							        pstmt.setString(++idx,fltirrobj.getYearsern());
    									pstmt.setString(++idx,saverptAL[i].getFltd());
    									pstmt.setString(++idx,saverptAL[i].getFltno());
    									pstmt.setString(++idx,saverptAL[i].getSect());
    									pstmt.setString(++idx,saverptAL[i].getAcno());
    									pstmt.setString(++idx,saverptAL[i].getPsrname());
    									pstmt.setString(++idx,saverptAL[i].getPsrsern());
    									pstmt.setString(++idx,fltirrobj.getItemno());
    									pstmt.setString(++idx,fltirrobj.getItemno_dsc());
    									pstmt.setString(++idx,fltirrobj.getComments());
    									pstmt.setString(++idx,fltirrobj.getDepmt());
    									pstmt.setString(++idx,fltirrobj.getCaseclose());
//    									pstmt.setString(++idx,fltirrobj.getNewdate());
    									pstmt.setString(++idx,fltirrobj.getNewuser());
    									pstmt.setString(++idx,fltirrobj.getChgdate());
    									pstmt.setString(++idx,fltirrobj.getChguser());
    									pstmt.setString(++idx,fltirrobj.getFlag());
    									pstmt.setString(++idx,fltirrobj.getDepcomm());
    									pstmt.setString(++idx,fltirrobj.getReply());
    									pstmt.setString(++idx,fltirrobj.getClb());
    									pstmt.setString(++idx,fltirrobj.getMcr());
    									pstmt.setString(++idx,fltirrobj.getRca());
    									pstmt.setString(++idx,fltirrobj.getEmg());
    									error_sql += fltirrobj.getYearsern()+","+saverptAL[i].getPsrname() +","+saverptAL[i].getPsrsern()+","+fltirrobj.getItemno()+","+fltirrobj.getItemno_dsc()+","+fltirrobj.getComments()+","+
                                                fltirrobj.getDepmt()+","+fltirrobj.getCaseclose()+","+fltirrobj.getFlag()+","+fltirrobj.getDepcomm()+","+fltirrobj.getReply()+","+
                                                fltirrobj.getClb()+","+fltirrobj.getMcr()+","+fltirrobj.getRca()+","+fltirrobj.getEmg()+"\n";
    									pstmt.addBatch();
                                    }
							    }
			                }
							pstmt.executeBatch();
							pstmt.clearBatch();	
						}
						
                        //delete egtfile then insert Cabin report file upload
						sql = "select filename from egtfile where fltd = to_date('"+saverptAL[i].getFltd()+"','yyyy/mm/dd') and fltno = '"+saverptAL[i].getFltno()+"' and sect = '"+saverptAL[i].getSect()+"' and src='IPAD' ";                  
                        rs = stmt.executeQuery(sql);
    
                        while (rs.next()) 
                        {
                            fz.pracP.uploadFile.DeleteFile df = new fz.pracP.uploadFile.DeleteFile(rs.getString("filename"));               
                            df.DoDelete();
                        }
                        
                        sql = " delete FROM egtfile where fltd = to_date('"+saverptAL[i].getFltd()+"','yyyy/mm/dd') and fltno = '"+saverptAL[i].getFltno()+"' and sect = '"+saverptAL[i].getSect()+"' and src='IPAD' ";
                        stmt.executeUpdate(sql);  
                        
                        error_step = "儲存上傳檔案 ";
                        error_sql = "";
                        //get byte[] convert to zip then unzip then upload (ftp) to server
                        if(saverptAL[i].getFileobjAL()!=null)//有上傳檔案有
                        {
                            for(int fi=0; fi<saverptAL[i].getFileobjAL().length; fi++)
                            {
                                //error_step = "儲存上傳檔案  fileobj.length = "+saverptAL[i].getFileobjAL().length;
                                saveReportFileObj fileobj = saverptAL[i].getFileobjAL()[fi];                                
    //                              String zipFile = "c:\\zip\\test.zip"; 
                                String tempfilename = fileobj.getFilename().substring(0,fileobj.getFilename().indexOf("."));
                                String zipFile = "/apsource/csap/projfz/webap/uploadfile/"+tempfilename+".zip"; 
    //                              String targetDirectory = "c:\\zip";                              
                                String targetDirectory = "/apsource/csap/projfz/webap/uploadfile/";
                                String saveDirectory = "/apsource/csap/projfz/webap/uploadfile/";
                                
                                UnZipBean uzb = new UnZipBean(zipFile, targetDirectory);  
                                byte[] file_byte = fileobj.getZipfile();
                                uzb.writeByteToZip(zipFile,file_byte);  
                                boolean succ = uzb.unzip();
                                String[] unzipAL = null;                            
                                unzipAL = uzb.getFileAL();
                                if(unzipAL.length>0)
                                {  
                                    //insert Cabin report file upload
                                    sqlsb = new StringBuffer();
                                    sqlsb.append(" insert into egtfile (fltd,fltno,sect,filename,filedsc,upduser,upddate,src,app_filename)");
                                    sqlsb.append(" values (to_date(?,'yyyy/mm/dd'),?,?,?,?,?,to_date(?,'yyyy/mm/dd hh24:mi:ss'),'IPAD',?)");
                                    pstmt=null;
                                    pstmt = con.prepareStatement(sqlsb.toString());
                                    for(int j=0; j<unzipAL.length; j++)
                                    { //已unzip的檔案名稱                                    
                                      
                                      //****************file 上傳至ftp server                                          
                                        updFilePath ufp = new updFilePath();
                                        String newFilename =  ufp.getFilename() + unzipAL[j].substring(unzipAL[j].lastIndexOf(".")); //取副檔名
                                        
                                        try
                                        {
                                            //*************************************FTP to 202.165.148.99
//                                          FtpUtility example = new FtpUtility("202.165.148.99","/EG/","egftp01","cseg#01");
//                                            FtpUtility example = new FtpUtility("202.165.148.99","/EGTEST/","egtestftp01","egtest#01");
                                            FtpUrl url = new FtpUrl();//統一設定ftp Url.
                                            FtpUtility example = new FtpUtility(url.getIp(), url.getDirectory(), url.getAccount(), url.getPass());
                                            example.connect();
//                                            example.setDirectory("/EGTEST/");
//                                          example.setDirectory("/EG/");
                                            example.setDirectory(url.getDirectory());   
                                            example.putBinFile(saveDirectory + unzipAL[j],newFilename);
                                            example.close();
                                        }
                                        catch(Exception e)
                                        {
                                            error_step = "儲存上傳檔案 "+ e.toString();
                                            System.out.println(e);
                                        } 
                                        //******delete weblogic server temp file
                                        File f = new File(saveDirectory+unzipAL[j]);
                                        f.delete();                                  
                                        File zipf = new File(saveDirectory+tempfilename+".zip");
                                        zipf.delete();
                                        
                                        idx=0;                                                                     
                                        //pstmt.setString(++idx,fileobj.getFltd());
										pstmt.setString(++idx,saverptAL[i].getFltd());
                                        //pstmt.setString(++idx,fileobj.getFltno());
										pstmt.setString(++idx,saverptAL[i].getFltno());
                                        //pstmt.setString(++idx,fileobj.getSect());
										pstmt.setString(++idx,fileobj.getSect());
                                        pstmt.setString(++idx,newFilename);
                                        pstmt.setString(++idx,"N/A");
                                        pstmt.setString(++idx,fileobj.getUpduser());
                                        pstmt.setString(++idx,fileobj.getUpddate());
                                        pstmt.setString(++idx,unzipAL[j]);
                                        error_sql += newFilename +","+unzipAL[j]+"\n";
                                        pstmt.executeUpdate();
                                        con.commit();
                                    }    
                                }
                            }
                        }//if(fileAL.size()>0)//有上傳檔案有
                        
						//delete egtprpj then insert 專案調查
						sql = " delete FROM egtprpj where fltdt = to_date('"+saverptAL[i].getFltd()+"','yyyy/mm/dd') and fltno = '"+saverptAL[i].getFltno()+"' and sect = '"+saverptAL[i].getSect()+"'";
						stmt.executeUpdate(sql);  
						
						//insert 專案調查 
						if(saverptAL[i].getProjobjAL()!= null)    
						{
						    error_step = "儲存專案調查";
						    error_sql = "";
							sqlsb = new StringBuffer();
							sqlsb.append(" insert into egtprpj (fltdt,fltno,sect,empno,fleet,acno,proj_no,projtype, itemno,chkempno,feedback,comments,newdate,newuser)");
							sqlsb.append(" values (to_date(?,'yyyy/mm/dd'),?,?,?,?,?,?,?,?,?,?,?,sysdate,?)");
							pstmt=null;
							pstmt = con.prepareStatement(sqlsb.toString());
							
							for(int j =0; j<saverptAL[i].getProjobjAL().length; j++)
			                {		
							    idx=0;
							    saveReportPrpjObj prpjobj = saverptAL[i].getProjobjAL()[j];							    
								//pstmt.setString(++idx,prpjobj.getFltdt());
								//pstmt.setString(++idx,prpjobj.getFltno());
								pstmt.setString(++idx,saverptAL[i].getFltd());
								pstmt.setString(++idx,saverptAL[i].getFltno());
								pstmt.setString(++idx,prpjobj.getSect());
								pstmt.setString(++idx,prpjobj.getEmpno());
								pstmt.setString(++idx,prpjobj.getFleet());
								pstmt.setString(++idx,prpjobj.getAcno());
								pstmt.setString(++idx,prpjobj.getProj_no());
								pstmt.setString(++idx,prpjobj.getProjtype());
								pstmt.setString(++idx,prpjobj.getItemno());
								pstmt.setString(++idx,prpjobj.getChkempno());
								pstmt.setString(++idx,prpjobj.getFeedback());
								pstmt.setString(++idx,prpjobj.getComments());
//								pstmt.setString(++idx,prpjobj.getNewdate());
								pstmt.setString(++idx,prpjobj.getNewuser());	
								error_sql += prpjobj.getProj_no()+","+prpjobj.getProjtype()+","+prpjobj.getItemno()+","+prpjobj.getChkempno()+","+prpjobj.getFeedback()+","+prpjobj.getComments()+"\n";
								pstmt.addBatch();
							    
			                }
							pstmt.executeBatch();
							pstmt.clearBatch();	
						}
						
//						//delete egtprsf then insert 自我督察 (type A)或服儀 egtprsf(type E)
						sql = " delete FROM egtprsf where fltdt = to_date('"+saverptAL[i].getFltd()+"','yyyy/mm/dd') and fltno = '"+saverptAL[i].getFltno()+"' and sect = '"+saverptAL[i].getSect()+"'";
						stmt.executeUpdate(sql);
						
						//insert 自我督察 (type A)或服儀 egtprsf(type E) 
						if(saverptAL[i].getPrsfobjAL()!= null)
						{
						    error_step = "儲存自我督察或服儀";
						    error_sql = "";
							sqlsb = new StringBuffer();
							sqlsb.append(" insert into egtprsf (fltdt,fltno,sect,empno,fleet,acno,topic_no,itemno,num_satisfy,duty_satisfy,num_needtoimprove,duty_needtoimprove,factor_no,factor_sub_no,newdate,desc_needtoimprove,psfm_itemno)");
							sqlsb.append(" values (to_date(?,'yyyy/mm/dd'),?,?,?,?,?,decode(?,'',null,?),decode(?,'',null,?),decode(?,'',null,?),?,decode(?,'',null,?),?,?,?,sysdate,?,?)");
							pstmt=null;
							pstmt = con.prepareStatement(sqlsb.toString());
							
							for(int j =0; j<saverptAL[i].getPrsfobjAL().length; j++)
			                {		
							    idx=0;
							    saveReportPrsfObj prsfobj = saverptAL[i].getPrsfobjAL()[j];							    
								//pstmt.setString(++idx,prsfobj.getFltdt());
								//pstmt.setString(++idx,prsfobj.getFltno());
								pstmt.setString(++idx,saverptAL[i].getFltd());
								pstmt.setString(++idx,saverptAL[i].getFltno());
								pstmt.setString(++idx,prsfobj.getSect());
								pstmt.setString(++idx,prsfobj.getEmpno());
								pstmt.setString(++idx,prsfobj.getFleet());
								pstmt.setString(++idx,prsfobj.getAcno());
								pstmt.setString(++idx,prsfobj.getTopic_no());
								pstmt.setString(++idx,prsfobj.getTopic_no());
								pstmt.setString(++idx,prsfobj.getItemno());
								pstmt.setString(++idx,prsfobj.getItemno());
								pstmt.setString(++idx,prsfobj.getNum_satisfy());
								pstmt.setString(++idx,prsfobj.getNum_satisfy());
								pstmt.setString(++idx,prsfobj.getDuty_satisfy());
								pstmt.setString(++idx,prsfobj.getNum_needtoimprove());
								pstmt.setString(++idx,prsfobj.getNum_needtoimprove());
								pstmt.setString(++idx,prsfobj.getDuty_needtoimprove());
								pstmt.setString(++idx,prsfobj.getFactor_no());
								pstmt.setString(++idx,prsfobj.getFactor_sub_no());								
//								pstmt.setString(++idx,prsfobj.getNewdate());
								pstmt.setString(++idx,prsfobj.getDesc_needtoimprove());			
								pstmt.setString(++idx,prsfobj.getPsfm_itemno());		
								error_sql += prsfobj.getTopic_no()+","+prsfobj.getItemno()+","+prsfobj.getNum_satisfy()+
								        ","+prsfobj.getDuty_satisfy()+","+prsfobj.getNum_needtoimprove()+","+prsfobj.getDuty_needtoimprove()+
								        ","+prsfobj.getFactor_no()+","+prsfobj.getFactor_sub_no()+","+prsfobj.getDesc_needtoimprove()+
								        ","+prsfobj.getPsfm_itemno()+"\n";
								pstmt.addBatch();							    
			                }
							pstmt.executeBatch();
							pstmt.clearBatch();	
						}
						
						//delete egtchkitd and egtchkrdm then insert 人工救生衣示範
						sql = " delete from egtchkrdd where checkrdseq in ( SELECT seqno FROM egtchkrdm where fltd = to_date('"+saverptAL[i].getFltd()+"','yyyy/mm/dd') " +
							  " and fltno = '"+saverptAL[i].getFltno()+"' and sector = '"+saverptAL[i].getSect()+"')";
						stmt.executeUpdate(sql); 
						
						sql = " delete FROM egtchkrdm where fltd = to_date('"+saverptAL[i].getFltd()+"','yyyy/mm/dd') and fltno = '"+saverptAL[i].getFltno()+"' and sector = '"+saverptAL[i].getSect()+"'";
						stmt.executeUpdate(sql); 
						
						//insert 人工救生衣示範
						if(saverptAL[i].getChkrdmobjAL()!= null)					    
						{
						    error_step = "儲存人工救生衣示範";
						    error_sql = "";
							sqlsb = new StringBuffer();
							sqlsb.append(" insert into egtchkrdm (fltd,fltno,sector,psrempn,seqno,checkseqno,executestatus,evalstatus,comments)");
							sqlsb.append(" values (to_date(?,'yyyy/mm/dd'),?,?,?,?,?,?,?,?)");
							pstmt=null;
							pstmt = con.prepareStatement(sqlsb.toString());
							
							for(int j =0; j<saverptAL[i].getChkrdmobjAL().length; j++)
			                {		
							    String tempCheckSeqno = "";
	                            sql = "SELECT Nvl(Max(seqno),0)+1 mx FROM  egtchkrdm";
	                            rs = stmt.executeQuery(sql);
	                            if(rs.next())
	                            {
	                                tempCheckSeqno = rs.getString("mx");
	                            }
							    idx=0;
							    saveReportChkrdmObj chkrdmobj = saverptAL[i].getChkrdmobjAL()[j];
							    chkrdmobj.setSeqno(tempCheckSeqno);							    
								//pstmt.setString(++idx,chkrdmobj.getFltd());
								//pstmt.setString(++idx,chkrdmobj.getFltno());
								pstmt.setString(++idx,saverptAL[i].getFltd());
								pstmt.setString(++idx,saverptAL[i].getFltno());

								pstmt.setString(++idx,chkrdmobj.getSector());
								pstmt.setString(++idx,chkrdmobj.getPsrempn());
								pstmt.setString(++idx,chkrdmobj.getSeqno());
								pstmt.setString(++idx,chkrdmobj.getCheckseqno());
								pstmt.setString(++idx,chkrdmobj.getExecutestatus());
								pstmt.setString(++idx,chkrdmobj.getEvalstatus());
								pstmt.setString(++idx,chkrdmobj.getComments());
								error_sql += chkrdmobj.getSeqno()+","+chkrdmobj.getExecutestatus()+","+chkrdmobj.getEvalstatus()+","+chkrdmobj.getComments() +"/n";
								pstmt.executeUpdate();
								
//								saveReportChkrddObj[] rddAL = chkrdmobj.getRddAL();
								if(chkrdmobj.getRddAL() != null)
								{//有執行未達標準時
								    for(int k=0;k<chkrdmobj.getRddAL().length; k++)
								    {		
								        saveReportChkrddObj rddobj = chkrdmobj.getRddAL()[k];
						                sql = "INSERT INTO egtchkrdd(checkseqno,checkdetailseq,checkrdseq,comments,correct) VALUES ('"+rddobj.getCheckseqno()+"','"+rddobj.getCheckdetailseq()+"','"+tempCheckSeqno+"','"+rddobj.getComments()+"','"+rddobj.getCorrect()+"')";
						                error_sql += sql+"/n";
						                stmt.executeUpdate(sql); 
								    }//for(int k=0;k<rddAL.size();k++)
								}
			                }
						}					
                        
                        //delete egtpads & egtpadm then insert PA record
                        sql = " select seqno from egtpadm where fltd = to_date('"+saverptAL[i].getFltd()+"','yyyy/mm/dd') and fltno = '"+saverptAL[i].getFltno()+"' and sect = '"+saverptAL[i].getSect()+"'";
                        rs = stmt.executeQuery(sql);

                        while (rs.next()) 
                        {
                            seqno_str = rs.getString("seqno") + "," + seqno_str ;
                        }
                        
                        if(!"".equals(seqno_str))
                        {
                            sql = " delete FROM egtpadm where seqno in ("+seqno_str+"0"+")"; //seqno_str like 3,4,
                            stmt.executeUpdate(sql);    
                        
                            sql = " delete FROM egtpads where seqno in ("+seqno_str+"0"+")"; //seqno_str like 3,4,
                            stmt.executeUpdate(sql);    
                        }
                    
                        
                        //insert PA record (egtpadm) 
                        if(saverptAL[i].getPaobjAL()!= null)
                        {
                            error_step = "儲存PA record";          
                            error_sql ="";
                            sqlsb = new StringBuffer();
                            sqlsb.append(" insert into egtpadm (seqno,gdyear,fltd,fltno,sect,empno,upddate,upduser)");
                            sqlsb.append(" values (?,?,to_date(?,'yyyy/mm/dd'),?,?,?,to_date(?,'yyyy/mm/dd hh24:mi:ss'),?)");
                            pstmt=null;
                            pstmt = con.prepareStatement(sqlsb.toString());
                            
                            for(int j =0; j<saverptAL[i].getPaobjAL().length; j++)
                            {       
                                idx=0;
                                saveReportPAObj paobj = saverptAL[i].getPaobjAL()[j]; 
                                
                                if("".equals(paobj.getSeqno()) | paobj.getSeqno() == null)
                                {
                                    sql = " select Max(seqno)+1 seqno from egtpadm ";
                                    rs = stmt.executeQuery(sql);
                                    
                                    if (rs.next()) 
                                    {
                                        paobj.setSeqno(rs.getString("seqno"));
                                    }
                                }
                                error_sql += 
                                "insert into egtpadm (seqno,gdyear,fltd,fltno,sect,empno,upddate,upduser)" +
                                " values ("+paobj.getSeqno()+","+paobj.getGdyear()+",to_date("+saverptAL[i].getFltd()+",'yyyy/mm/dd'),"+saverptAL[i].getFltno()+","+paobj.getSect()+","+paobj.getEmpno()+",to_date("+paobj.getUpddate()+",'yyyy/mm/dd hh24:mi:ss'),"+paobj.getUpduser()+")";
                               
                                pstmt.setString(++idx,paobj.getSeqno());
                                pstmt.setString(++idx,paobj.getGdyear());
                                //pstmt.setString(++idx,paobj.getFltd());
                                //pstmt.setString(++idx,paobj.getFltno());
								pstmt.setString(++idx,saverptAL[i].getFltd());
                                pstmt.setString(++idx,saverptAL[i].getFltno());
                                pstmt.setString(++idx,paobj.getSect());
                                pstmt.setString(++idx,paobj.getEmpno());
                                pstmt.setString(++idx,paobj.getUpddate());
                                pstmt.setString(++idx,paobj.getUpduser());
                                pstmt.executeUpdate();   
                                
                            }
                             //insert PA record (egtpads)
                            error_sql ="";
                            error_step = "儲存PA record2";
                            sqlsb = new StringBuffer();
                            sqlsb.append(" insert into egtpads (seqno,scoretype,score,comm)");
                            sqlsb.append(" values (?,?,?,?)");
                            pstmt = null;
                            pstmt = con.prepareStatement(sqlsb.toString());
                            
                            for(int j =0; j<saverptAL[i].getPaobjAL().length; j++)                            
                            {                                  
                                saveReportPAObj paobj = saverptAL[i].getPaobjAL()[j];         
                                
                                pstmt.setString(1,paobj.getSeqno());
                                pstmt.setString(2,"1");
                                pstmt.setString(3,paobj.getPa_duty());
                                pstmt.setString(4,paobj.getPa_duty_comm());
                                error_sql += "1"+paobj.getPa_duty()+","+paobj.getPa_duty_comm();
                                pstmt.addBatch();  
                                pstmt.setString(1,paobj.getSeqno());
                                pstmt.setString(2,"2");
                                pstmt.setString(3,paobj.getPa_item1());
                                pstmt.setString(4,paobj.getPa_item1_comm());
                                error_sql += "2"+paobj.getPa_item1()+","+paobj.getPa_item1_comm();
                                pstmt.addBatch();  
                                pstmt.setString(1,paobj.getSeqno());
                                pstmt.setString(2,"3");
                                pstmt.setString(3,paobj.getPa_item2());
                                pstmt.setString(4,paobj.getPa_item2_comm());
                                error_sql += "3"+paobj.getPa_item2()+","+paobj.getPa_item2_comm();
                                pstmt.addBatch();
                                pstmt.setString(1,paobj.getSeqno());
                                pstmt.setString(2,"4");
                                pstmt.setString(3,paobj.getPa_item3());
                                pstmt.setString(4,paobj.getPa_item3_comm());
                                error_sql += "4"+paobj.getPa_item3()+","+paobj.getPa_item3_comm();
                                pstmt.addBatch();
                                pstmt.setString(1,paobj.getSeqno());
                                pstmt.setString(2,"5");
                                pstmt.setString(3,paobj.getPa_item4());
                                pstmt.setString(4,paobj.getPa_item4_comm());
                                error_sql += "5"+paobj.getPa_item4()+","+paobj.getPa_item4_comm();
                                pstmt.addBatch();
                                pstmt.setString(1,paobj.getSeqno());
                                pstmt.setString(2,"6");
                                pstmt.setString(3,paobj.getPa_item5());
                                pstmt.setString(4,paobj.getPa_item5_comm());
                                error_sql += "6"+paobj.getPa_item5()+","+paobj.getPa_item5_comm();
                                pstmt.addBatch();  
                            }
                            pstmt.executeBatch();
                            pstmt.clearBatch(); 
                        }
                        
                      //delete egtzcds & egtzcdm then insert ZC(PR) record
                        sql = " select seqno from egtzcdm where fltd = to_date('"+saverptAL[i].getFltd()+"','yyyy/mm/dd') and fltno = '"+saverptAL[i].getFltno()+"' and sect = '"+saverptAL[i].getSect()+"'";
                        rs = stmt.executeQuery(sql);
                        seqno_str ="";
                        while (rs.next()) 
                        {
                            seqno_str = rs.getString("seqno") + "," + seqno_str ;
                        }
                        
                        if(!"".equals(seqno_str))
                        {
                            sql = " delete FROM egtzcdm where seqno in ("+seqno_str+"0"+")"; //seqno_str like 3,4,
                            stmt.executeUpdate(sql);    
                        
                            sql = " delete FROM egtzcds where seqno in ("+seqno_str+"0"+")"; //seqno_str like 3,4,
                            stmt.executeUpdate(sql);    
                        }
                    
                        
                        //insert ZC record (egtzcdm) 
                        if(saverptAL[i].getProbjAL() != null)
                        {
                            error_step = "儲存ZC record";
                            error_sql ="";
                            sqlsb = new StringBuffer();
                            sqlsb.append(" insert into egtzcdm (seqno,gdyear,fltd,fltno,sect,empno,upddate,upduser)");
                            sqlsb.append(" values (?,?,to_date(?,'yyyy/mm/dd'),?,?,?,to_date(?,'yyyy/mm/dd hh24:mi:ss'),?)");
                            pstmt=null;
                            pstmt = con.prepareStatement(sqlsb.toString());
                            
                            for(int j =0; j<saverptAL[i].getProbjAL().length; j++)
                            {       
                                idx=0;
                                saveReportPRObj probj = saverptAL[i].getProbjAL()[j]; 
                                
                                if("".equals(probj.getSeqno()) | probj.getSeqno() == null)
                                {
                                    sql = " select Max(seqno)+1 seqno from egtzcdm ";
                                    rs = stmt.executeQuery(sql);
                                    
                                    if (rs.next()) 
                                    {
                                        probj.setSeqno(rs.getString("seqno"));
                                    }
                                }
                                
                                pstmt.setString(++idx,probj.getSeqno());
                                pstmt.setString(++idx,probj.getGdyear());
                                //pstmt.setString(++idx,probj.getFltd());
                                //pstmt.setString(++idx,probj.getFltno());
								pstmt.setString(++idx,saverptAL[i].getFltd());
                                pstmt.setString(++idx,saverptAL[i].getFltno());
                                pstmt.setString(++idx,probj.getSect());
                                pstmt.setString(++idx,probj.getEmpno());
                                pstmt.setString(++idx,probj.getUpddate());
                                pstmt.setString(++idx,probj.getUpduser());
                                pstmt.addBatch();      
                            }
                            pstmt.executeBatch();
                            pstmt.clearBatch(); 
                       
                        
                            //insert ZC(PR) report (egtzcds) 
                            sqlsb = new StringBuffer();
                            sqlsb.append(" insert into egtzcds (seqno,scoretype,score,comm)");
                            sqlsb.append(" values (?,?,?,?)");
                            pstmt=null;
                            pstmt = con.prepareStatement(sqlsb.toString());
                            
                            for(int j =0; j<saverptAL[i].getProbjAL().length; j++)                            
                            {  
                                saveReportPRObj probj = saverptAL[i].getProbjAL()[j];                                  
                                pstmt.setString(1,probj.getSeqno());
                                pstmt.setString(2,"1");
                                pstmt.setString(3,probj.getPr_item1());
                                pstmt.setString(4,probj.getPr_item1_comm());
                                pstmt.addBatch();  
                                pstmt.setString(1,probj.getSeqno());
                                pstmt.setString(2,"2");
                                pstmt.setString(3,probj.getPr_item2());
                                pstmt.setString(4,probj.getPr_item2_comm());
                                pstmt.addBatch();  
                                pstmt.setString(1,probj.getSeqno());
                                pstmt.setString(2,"3");
                                pstmt.setString(3,probj.getPr_item3());
                                pstmt.setString(4,probj.getPr_item3_comm());
                                pstmt.addBatch();
                                pstmt.setString(1,probj.getSeqno());
                                pstmt.setString(2,"4");
                                pstmt.setString(3,probj.getPr_item4());
                                pstmt.setString(4,probj.getPr_item4_comm());
                                pstmt.addBatch();
                                pstmt.setString(1,probj.getSeqno());
                                pstmt.setString(2,"5");
                                pstmt.setString(3,probj.getPr_item5());
                                pstmt.setString(4,probj.getPr_item5_comm());
                                pstmt.addBatch();
                                pstmt.setString(1,probj.getSeqno());
                                pstmt.setString(2,"6");
                                pstmt.setString(3,probj.getPr_item6());
                                pstmt.setString(4,probj.getPr_item6_comm());
                                pstmt.addBatch();
                                pstmt.setString(1,probj.getSeqno());
                                pstmt.setString(2,"7");
                                pstmt.setString(3,probj.getPr_item7());
                                pstmt.setString(4,probj.getPr_item7_comm());
                                pstmt.addBatch();
                                pstmt.setString(1,probj.getSeqno());
                                pstmt.setString(2,"8");
                                pstmt.setString(3,probj.getPr_item8());
                                pstmt.setString(4,probj.getPr_item8_comm());
                                pstmt.addBatch();
                                pstmt.setString(1,probj.getSeqno());
                                pstmt.setString(2,"9");
                                pstmt.setString(3,probj.getPr_item9());
                                pstmt.setString(4,probj.getPr_item9_comm());
                                pstmt.addBatch();
                                pstmt.setString(1,probj.getSeqno());
                                pstmt.setString(2,"10");
                                pstmt.setString(3,probj.getPr_item10());
                                pstmt.setString(4,probj.getPr_item10_comm());
                                pstmt.addBatch();
                            }
                            pstmt.executeBatch();
                            pstmt.clearBatch(); 
                        }
						
						//更新最後更新時間
						sql = " update egtcflt set chgdate = to_date('"+saverptAL[i].getUpdate_time()+"','yyyy/mm/dd hh24:mi:ss'), src = 'IPAD', src_tmst = sysdate where fltd = to_date('"+saverptAL[i].getFltd()+"','yyyy/mm/dd') and fltno = '"+saverptAL[i].getFltno()+"' and sect = '"+saverptAL[i].getSect()+"' and psrempn = '"+saverptAL[i].getPsrempn()+"'";
						stmt.executeUpdate(sql); 
						
						int cnt = 0;
	                    sql = "select count(*) c from egtcrpt where fltd = to_date('"+saverptAL[i].getFltd()+"','yyyy/mm/dd') and fltno = '"+saverptAL[i].getFltno()+"' and sect = '"+saverptAL[i].getSect()+"'";	                                        
	                    rs = stmt.executeQuery(sql);
	                    
	                    if (rs.next()) 
	                    {
	                        cnt = rs.getInt("c");
	                    }
	                    
	                    sqlsb = new StringBuffer();
	                    if(cnt > 0)//update 
	                    {
	                        sqlsb.append(" update egtcrpt set empno = ?, chguser =?, chgdate=to_date(?,'yyyy/mm/dd hh24:mi:ss'), newdate=to_date(?,'yyyy/mm/dd hh24:mi:ss'), flag=? ");
	                        sqlsb.append(" where fltd = to_date('"+saverptAL[i].getFltd()+"','yyyy/mm/dd') and fltno = '"+saverptAL[i].getFltno()+"' and sect = '"+saverptAL[i].getSect()+"'");
	                        pstmt=null;
	                        pstmt = con.prepareStatement(sqlsb.toString());
	                        idx=0;                                                      
	                        pstmt.setString(++idx,saverptAL[i].getPsrempn());
	                        pstmt.setString(++idx,saverptAL[i].getPsrempn());
	                        pstmt.setString(++idx,saverptAL[i].getUpdate_time());
	                        pstmt.setString(++idx,saverptAL[i].getNew_time());
	                        pstmt.setString(++idx,"N");
	                        pstmt.executeUpdate(); 
	                    }
	                    else //insert
	                    {
	                        sqlsb.append(" insert into egtcrpt (fltd,fltno,sect,empno,chguser,chgdate,newdate,flag)");
	                        sqlsb.append(" values (to_date(?,'yyyy/mm/dd'),?,?,?,?,to_date(?,'yyyy/mm/dd hh24:mi:ss'),sysdate,?)");
	                        pstmt=null;
	                        pstmt = con.prepareStatement(sqlsb.toString());
	                        idx=0;                                                      
	                        pstmt.setString(++idx,saverptAL[i].getFltd());
	                        pstmt.setString(++idx,saverptAL[i].getFltno());
	                        pstmt.setString(++idx,saverptAL[i].getSect());
	                        pstmt.setString(++idx,saverptAL[i].getPsrempn());
	                        pstmt.setString(++idx,saverptAL[i].getPsrempn());
	                        pstmt.setString(++idx,saverptAL[i].getUpdate_time());
//	                        pstmt.setString(++idx,saverptAL[i].getNew_time());
	                        pstmt.setString(++idx,"N");
	                        pstmt.executeUpdate(); 
	                    }   
		                con.commit();
		                
		                //檢查是否為delay 航班, 是否需修改 fltd & fltno +Z
		                //**************************************************************
//		                String fdate_aircrews = saverptAL[i].getFltd();//aircrews 調整後的日期
//		                String fltno_cflt = saverptAL[i].getFltno();//判斷是否加Z後的航班號碼
//		                
//		                sql =" select to_char(dps.str_dt_tm_loc,'yyyy/mm/dd') fdate," +
//		                	 " dps.flt_num fltno,to_char(str_dt_tm_loc,'yyyy/mm/dd hh24:mi') stdDt, " +
//		                	 " to_char(str_dt_tm_loc,'hh24mi') ftime, dps.act_port_a dpt,dps.act_port_b arv " +
//		                	 " from duty_prd_seg_v dps, roster_v r where dps.series_num=r.series_num " +
//		                	 " and dps.delete_ind = 'N' AND  r.delete_ind='N' " +
//		                	 " and r.staff_num ='"+saverptAL[i].getPsrempn()+"' " +
//		                	 " AND dps.str_dt_tm_loc BETWEEN  to_date('"+saverptAL[i].getFltd()+" 00:00','yyyy/mm/dd hh24:mi') " +
//		                	 " AND to_date('"+saverptAL[i].getFltd()+" 23:59','yyyy/mm/dd hh24:mi') +1 " +
//		                	 " AND dps.port_a||dps.port_b ='"+saverptAL[i].getSect()+"' " +
//		                	 " AND r.duty_cd='FLY' AND dps.duty_cd IN ('FLY','TVL') " +
//		                	 " AND ( r.acting_rank IN ('PR','MC')  OR Nvl(r.special_indicator,' ') = 'J') order by str_dt_tm_gmt ";
//		                
//		         	                
//		                rs = stmt.executeQuery(sql);
//		                
//                        while (rs.next()) 
//                        {
//                            fdate_aircrews = rs.getString("fdate");      
//                            fz.pracP.GetFltnoWithSuffix gf = new fz.pracP.GetFltnoWithSuffix(fdate_aircrews.substring(0, 4)+fdate_aircrews.substring(5, 7)+fdate_aircrews.substring(8),rs.getString("fltno"), rs.getString("dpt")+rs.getString("arv"),rs.getString("stdDt"));
//                            if (gf.getFltnoWithSuffix().indexOf("Z") > -1) 
//                            {
//                                // 最後一碼為Z時，不檢查delay班次號碼
//                                fltno_cflt =gf.getFltnoWithSuffix();
//                            }
//                        }                        
//                       
//                        if(!saverptAL[i].getFltd().equals(fdate_aircrews) || !saverptAL[i].getFltno().equals(fltno_cflt))
//                        {//更改存入的fltd & fltno
////                            SELECT * FROM egtcflt where fltd = to_date('2014/02/08','yyyy/mm/dd') and fltno = '0061' and sect = 'TPEFRA' AND psrempn=''
////                            SELECT * FROM egtgddt WHERE fltd = to_date('2014/02/08','yyyy/mm/dd') and fltno = '0061' and sect = 'TPEFRA' AND newuser =''
////                            SELECT * FROM egtcmdt WHERE fltd = to_date('2014/02/08','yyyy/mm/dd') and fltno = '0061' and sect = 'TPEFRA'  AND newuser = ''
////                            SELECT * FROM egtfile WHERE fltd = to_date('2014/02/08','yyyy/mm/dd') and fltno = '0061' and sect = 'TPEFRA'  AND upduser =''
////                            SELECT * FROM egtpadm WHERE fltd = to_date('2014/02/08','yyyy/mm/dd') and fltno = '0061' and sect = 'TPEFRA' AND upduser =''
////                            SELECT * FROM egtzcdm WHERE fltd = to_date('2014/02/08','yyyy/mm/dd') and fltno = '0061' and sect = 'TPEFRA' AND upduser =''
////                            SELECT * FROM egtcrpt WHERE fltd = to_date('2014/02/08','yyyy/mm/dd') and fltno = '0061' and sect = 'TPEFRA' AND empno =''
////                            SELECT * FROM egtprpj WHERE fltdt = to_date('2014/02/08','yyyy/mm/dd') and fltno = '0061' and sect = 'TPEFRA' AND newuser = ''
////                            SELECT * FROM egtprsf WHERE fltdt = to_date('2014/02/08','yyyy/mm/dd') and fltno = '0061' and sect = 'TPEFRA' AND empno = ''
////                            SELECT * FROM egtchkrdm  WHERE fltd = to_date('2014/02/08','yyyy/mm/dd') and fltno = '0061' and sector = 'TPEFRA'  AND psrempn=''
//
//                              sql = " update egtcflt set fltd = to_date('"+fdate_aircrews+"','yyyy/mm/dd'), fltno='"+fltno_cflt+"' where fltd = to_date('"+saverptAL[i].getFltd()+"','yyyy/mm/dd') and fltno = '"+saverptAL[i].getFltno()+"' and sect = '"+saverptAL[i].getSect()+"' AND psrempn='"+saverptAL[i].getPsrempn()+"' ";
//                              stmt.executeUpdate(sql);
//                              sql = " update egtgddt set fltd = to_date('"+fdate_aircrews+"','yyyy/mm/dd'), fltno='"+fltno_cflt+"' where fltd = to_date('"+saverptAL[i].getFltd()+"','yyyy/mm/dd') and fltno = '"+saverptAL[i].getFltno()+"' and sect = '"+saverptAL[i].getSect()+"' AND newuser='"+saverptAL[i].getPsrempn()+"' ";
//                              stmt.executeUpdate(sql);
//                              sql = " update egtcmdt set fltd = to_date('"+fdate_aircrews+"','yyyy/mm/dd'), fltno='"+fltno_cflt+"' where fltd = to_date('"+saverptAL[i].getFltd()+"','yyyy/mm/dd') and fltno = '"+saverptAL[i].getFltno()+"' and sect = '"+saverptAL[i].getSect()+"' AND newuser='"+saverptAL[i].getPsrempn()+"' ";
//                              stmt.executeUpdate(sql);
//                              sql = " update egtfile set fltd = to_date('"+fdate_aircrews+"','yyyy/mm/dd'), fltno='"+fltno_cflt+"' where fltd = to_date('"+saverptAL[i].getFltd()+"','yyyy/mm/dd') and fltno = '"+saverptAL[i].getFltno()+"' and sect = '"+saverptAL[i].getSect()+"' AND upduser='"+saverptAL[i].getPsrempn()+"' ";
//                              stmt.executeUpdate(sql);
//                              sql = " update egtpadm set fltd = to_date('"+fdate_aircrews+"','yyyy/mm/dd'), fltno='"+fltno_cflt+"' where fltd = to_date('"+saverptAL[i].getFltd()+"','yyyy/mm/dd') and fltno = '"+saverptAL[i].getFltno()+"' and sect = '"+saverptAL[i].getSect()+"' AND upduser='"+saverptAL[i].getPsrempn()+"' ";
//                              stmt.executeUpdate(sql);
//                              sql = " update egtzcdm set fltd = to_date('"+fdate_aircrews+"','yyyy/mm/dd'), fltno='"+fltno_cflt+"' where fltd = to_date('"+saverptAL[i].getFltd()+"','yyyy/mm/dd') and fltno = '"+saverptAL[i].getFltno()+"' and sect = '"+saverptAL[i].getSect()+"' AND upduser='"+saverptAL[i].getPsrempn()+"' ";
//                              stmt.executeUpdate(sql);
//                              sql = " update egtcrpt set fltd = to_date('"+fdate_aircrews+"','yyyy/mm/dd'), fltno='"+fltno_cflt+"' where fltd = to_date('"+saverptAL[i].getFltd()+"','yyyy/mm/dd') and fltno = '"+saverptAL[i].getFltno()+"' and sect = '"+saverptAL[i].getSect()+"' AND empno='"+saverptAL[i].getPsrempn()+"' ";
//                              stmt.executeUpdate(sql);
//                              sql = " update egtprpj set fltdt = to_date('"+fdate_aircrews+"','yyyy/mm/dd'), fltno='"+fltno_cflt+"' where fltdt = to_date('"+saverptAL[i].getFltd()+"','yyyy/mm/dd') and fltno = '"+saverptAL[i].getFltno()+"' and sect = '"+saverptAL[i].getSect()+"' AND newuser='"+saverptAL[i].getPsrempn()+"' ";
//                              stmt.executeUpdate(sql);
//                              sql = " update egtprsf set fltdt = to_date('"+fdate_aircrews+"','yyyy/mm/dd'), fltno='"+fltno_cflt+"' where fltdt = to_date('"+saverptAL[i].getFltd()+"','yyyy/mm/dd') and fltno = '"+saverptAL[i].getFltno()+"' and sect = '"+saverptAL[i].getSect()+"' AND empno='"+saverptAL[i].getPsrempn()+"' ";
//                              stmt.executeUpdate(sql);
//                              sql = " update egtchkrdm set fltd = to_date('"+fdate_aircrews+"','yyyy/mm/dd'), fltno='"+fltno_cflt+"' where fltd = to_date('"+saverptAL[i].getFltd()+"','yyyy/mm/dd') and fltno = '"+saverptAL[i].getFltno()+"' and sector = '"+saverptAL[i].getSect()+"' AND psrempn='"+saverptAL[i].getPsrempn()+"' ";
//                              stmt.executeUpdate(sql);                              
//                              con.commit();
//                        }
		                //***************************************************************
	                }//if("Y".equals(ifupdate))	     
	                else
	                {
	                    error_str = "WEB資料 已更新，無需同步";
	                    return "WEB資料 已更新，無需同步";	                    
	                }
	            }// if(!"".equals(saverptAL[i].getFltd()) && !"".equals(saverptAL[i].getFltno()) && !"".equals(saverptAL[i].getSect()))
	            else
	            {
	                error_str = "資料輸入不完整"; 
	                return "資料輸入不完整";    
	            }
	        }//for(int i=0; i<saverptAL.length; i++)
	            return "Y";
	    	}
	    	else
	    	{
	    	    error_str = "無需更新資料"; 
	    	    return "無需更新資料";	    	    
	    	}
	    } 
	    catch(Exception e) 
	    {
			//System.out.println(e.toString());
	        try
	        {
	            fw = new FileWriter(path+"serviceLog.txt",true);
	            fw.write(new java.util.Date()+"\r\n");       
	            fw.write(e.toString() + " ** " +error_step +" Failed \r\n");   
	            fw.write(error_sql+"/r/n");  
	            fw.write("****************************************************************\r\n");
	            fw.flush();
                fw.close();
	        }
	        catch (Exception e1)
	        {
//	            System.out.println("e1"+e1.toString());
	        }
	        finally
	        {	            
	        }	        
	        try{con.rollback();}catch(SQLException se){ return se.toString();}	        
	        return " ** " +error_step +" Failed";			
		}
		finally 
		{
			try{if(rs != null) rs.close();}catch(SQLException e){}
	  		try{if(stmt != null) stmt.close();}catch(SQLException e){}
	  		try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
	   		try{if(con != null) con.close();}catch(SQLException e){}
	   		
	   		try
            {
                fw = new FileWriter(path+"serviceLog.txt",true);
                fw.write("insert_sql --> "+insert_sql +"\r\n");  
                fw.flush();
                fw.close();
            }
            catch (Exception e1)
            {
//              System.out.println("e1"+e1.toString());
            }
            finally
            {               
            }
		}  
    }
   
   
       public String error_str()
       {       
           return error_str;
       }
}

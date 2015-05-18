package ws;

import java.io.*;
import java.sql.*;
import java.util.*;

import ws.header.*;
import fz.pracP.*;
import fz.pracP.dispatch.*;

/**
 * @author 640790 Created on  2013/8/19
 * cs80 2014/12/23 add egtcflt upd�P�_
 * cs80 2015/03/13 newdate => sysdate
 */
public class ipadsendReport
{
    public static void main(String[] args)
    {
        
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
	
	public String doSendReportCheck(sendReportCrptObj sendrptobj) 
	{        
        if(!"".equals(sendrptobj.getFltd()) && !"".equals(sendrptobj.getFltno()) && !"".equals(sendrptobj.getSect()))
        { 
            //��������Z�O�_��g
            CheckShift chk = new CheckShift();
            String ifdutyshift = chk.getChickShift(sendrptobj.getFltd(),sendrptobj.getFltno(),sendrptobj.getSect());
            
            //�u���B�z
            boolean iflessdisp_pass = false;
            boolean iflessdisp = true;
            String tempfltno = "";
            String tempfleet = "";
            String lessdispstr = "";
            if(sendrptobj.getFltno().length()>= 4)
            {
                tempfltno = sendrptobj.getFltno().substring(1,4);
            }
            else
            {
                tempfltno = sendrptobj.getFltno();
            }

            FlexibleDispatch fd = new FlexibleDispatch();
            iflessdisp = fd.ifFlexibleDispatch(sendrptobj.getFltd(),sendrptobj.getFltno(),sendrptobj.getSect(),sendrptobj.getEmpno());
            tempfleet = fd.getFleetCd();
            int pax_count =0;
            int disp_count =0 ;
            int acm_count = 0;
            if(iflessdisp == false)
            {
                iflessdisp_pass = true;
            }
            else //if(iflessdisp == true)
            {
                //get pax �H��
                pax_count = fd.getPaxCount(sendrptobj.getFltd(),sendrptobj.getFltno(),sendrptobj.getSect()); 
                //get �u���H��
                disp_count = fd.getFlexibleNum(sendrptobj.getFltno(), tempfleet, sendrptobj.getSect(), pax_count) ;
                //get ACM �H��
                acm_count = fd.getACMCount(sendrptobj.getFltd(),sendrptobj.getFltno(),sendrptobj.getSect()) ;
                if(disp_count <= acm_count | pax_count <=0 )
                {
                    iflessdisp_pass = true;
                }
                else //if(disp_count != acm_count )
                {
                    int i13_count  = fd.getI13Count(sendrptobj.getFltd(),sendrptobj.getFltno(),sendrptobj.getSect()) ;
                    if(i13_count>0)
                    {
                        iflessdisp_pass = true;
                    }
                }
            }            
            
            //Check �ȫȤH�ƬO�_��J
            saveRptCheck src = new saveRptCheck();
            String ifpasspaxcnt = src.paxCountCheck(sendrptobj.getFltd(),sendrptobj.getFltno(),sendrptobj.getSect());
            
            //�O�_����ժ������
            String ifmphasshift = src.shiftMPCheck(sendrptobj.getFltd(),sendrptobj.getFltno(),sendrptobj.getSect());
            
            //chk �d�ֶ��جO�_����
            String ifchkItem = src.chkItem(sendrptobj.getFltd(),sendrptobj.getFltno(),sendrptobj.getSect() ,sendrptobj.getEmpno());
            
            //Send Report Check
            //******************************************************************************************
            if(!"N".equals(ifdutyshift))
            {                        
                //return "���Z����ɶ�������!\n�|���g����ɶ�,���o�e�X���i!!\n";
                return chk.getMsg()+"!!\n";
            }
            else if (iflessdisp_pass == false)
            {
                return "DFA�H�Ƥ����T,�нT�{,�Ω�<Flt Irregularity>��������]!!\n";                                   
            }    
            else if(!"Y".equals(ifmphasshift))
            {
                return ifmphasshift;                
            }
            else if (!"Y".equals(ifpasspaxcnt))
            {                
                return ifpasspaxcnt;
            }
            else if (!"Y".equals(ifchkItem))
            {                
                return ifchkItem;
            }
        }// if(!"".equals(sendrptobj.getFltd()) && !"".equals(sendrptobj.getFltno()) && !"".equals(sendrptobj.getSect()))
        else
        {
            return "��Ƥ�����";                    
        }
        return "Y";       
	}
	 
	public String doSendReport2(sendReportCrptObj[] sendrptAL,  String sysPwd) 
	{
	      boolean wsAuth = false;
	      ThreeDes d = new ThreeDes();
	      wsAuth = d.auth(sysPwd);
	      if(wsAuth)
	      {
	          return doSendReport(sendrptAL) ;
	      }
	      else
	      {
	          return "No Auth.";	          
	      }
	}
	
    public String doSendReport(sendReportCrptObj[] sendrptAL) 
    {        
        ci.db.ConnDB cn = new ci.db.ConnDB();
	    StringBuffer sqlsb = new StringBuffer();
	    int idx = 0;
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
	    	
	        for(int i=0; i<sendrptAL.length; i++)
	        {	            
	            sendReportCrptObj sendrptobj = sendrptAL[i];   
	            if(!"".equals(sendrptobj.getFltd()) && !"".equals(sendrptobj.getFltno()) && !"".equals(sendrptobj.getSect()))
	            { 
	                
	                //
	               sendrptobj.setEmpno(sendrptobj.getEmpno().trim());
	              //�ˬd�O�_��delay ��Z, �O�_�ݭק� fltd & fltno +Z
                    //**************************************************************
                    String fdate_aircrews = sendrptAL[i].getFltd();//aircrews �վ�᪺���
                    String fltno_cflt = sendrptAL[i].getFltno();//�P�_�O�_�[Z�᪺��Z���X
                    
                    sql =" select to_char(dps.str_dt_tm_loc,'yyyy/mm/dd') fdate," +
                         " dps.flt_num fltno,to_char(str_dt_tm_loc,'yyyy/mm/dd hh24:mi') stdDt, " +
                         " to_char(str_dt_tm_loc,'hh24mi') ftime, dps.act_port_a dpt,dps.act_port_b arv " +
                         " from duty_prd_seg_v dps, roster_v r where dps.series_num=r.series_num " +
                         " and dps.delete_ind = 'N' AND  r.delete_ind='N' " +
                         " and r.staff_num ='"+sendrptAL[i].getEmpno()+"' " +
                         " AND dps.str_dt_tm_loc BETWEEN  to_date('"+sendrptAL[i].getFltd()+" 00:00','yyyy/mm/dd hh24:mi') " +
                         " AND to_date('"+sendrptAL[i].getFltd()+" 23:59','yyyy/mm/dd hh24:mi') +1 " +
                         " AND dps.port_a||dps.port_b ='"+sendrptAL[i].getSect()+"' " +
                         " AND r.duty_cd='FLY' AND dps.duty_cd IN ('FLY','TVL') " +
                         " AND ( r.acting_rank IN ('PR','MC')  OR Nvl(r.special_indicator,' ') = 'J') order by str_dt_tm_gmt ";
                           
                    rs = stmt.executeQuery(sql);
                
                    if (rs.next()) 
                    {
                          fdate_aircrews = rs.getString("fdate");      
                          fz.pracP.GetFltnoWithSuffix gf = new fz.pracP.GetFltnoWithSuffix(fdate_aircrews.substring(0, 4)+fdate_aircrews.substring(5, 7)+fdate_aircrews.substring(8),rs.getString("fltno"), rs.getString("dpt")+rs.getString("arv"),rs.getString("stdDt"));
                          if (gf.getFltnoWithSuffix().indexOf("Z") > -1) 
                          {
                              // �̫�@�X��Z�ɡA���ˬddelay�Z�����X
                              fltno_cflt =gf.getFltnoWithSuffix();
                          }
                   }              
                    
                   if(!sendrptAL[i].getFltd().equals(fdate_aircrews) || !sendrptAL[i].getFltno().equals(fltno_cflt))
                   {//���s�J��fltd & fltno
                       sendrptAL[i].setFltd(fdate_aircrews);
                       sendrptAL[i].setFltno(fltno_cflt);
                   }
                   //********************************************************************************** 
	                
	                //check report status
	                saveRptCheck src = new saveRptCheck();
	                String status_str = src.doSaveReportCheck(sendrptobj.getFltd(),sendrptobj.getFltno(),sendrptobj.getSect());
	                
	                if("Y".equals(status_str))
	                {	                
    	                String ispasscheck = doSendReportCheck(sendrptobj);
    	                if(!"Y".equals(ispasscheck))
    	                {
    	                    return ispasscheck;	                    
    	                }
    	                else //pass check
    	                {	                
    	                    String statusRpt = "";
    	                    sql = "select Nvl(upd,'') upd from egtcflt where fltd = to_date('"+sendrptobj.getFltd()+"','yyyy/mm/dd') and fltno = '"+sendrptobj.getFltno()+"' and sect = '"+sendrptobj.getSect()+"'";
                            rs = stmt.executeQuery(sql);
                            

                            if (rs.next()) 
                            {
                                statusRpt = rs.getString("upd");
                            }
                            
                            if(!"".equals(statusRpt)){
                              //update Cabin report status
                                int cnt = 0;
                                sql = "select count(*) c from egtcrpt where fltd = to_date('"+sendrptobj.getFltd()+"','yyyy/mm/dd') and fltno = '"+sendrptobj.getFltno()+"' and sect = '"+sendrptobj.getSect()+"'";
                                rs = stmt.executeQuery(sql);
                                
                                if (rs.next()) 
                                {
                                    cnt = rs.getInt("c");
                                }
                                
                                sqlsb = new StringBuffer();
                                if(cnt > 0)//update 
                                {
                                    sqlsb.append(" update egtcrpt set empno = ?, chguser =?, chgdate=to_date(?,'yyyy/mm/dd hh24:mi:ss'), newdate=sysdate, trip_num = ?, flag=?, caseclose=?, sendr_dt=sysdate ");
                                    sqlsb.append(" where fltd = to_date('"+sendrptobj.getFltd()+"','yyyy/mm/dd') and fltno = '"+sendrptobj.getFltno()+"' and sect = '"+sendrptobj.getSect()+"'");
                                    if(null!=sendrptobj.getTrip_num()&&sendrptobj.getTrip_num().contains("null")){
                                        sendrptobj.setTrip_num(null);
                                    }
                                    error_sql = " update egtcrpt set empno = '"+sendrptobj.getEmpno()+"', chguser ='"+sendrptobj.getEmpno()+"', chgdate=to_date('"+sendrptobj.getChgdate()+"','yyyy/mm/dd hh24:mi:ss'), newdate=sysdate, trip_num = '"+sendrptobj.getTrip_num()+"', flag='Y', caseclose='N', sendr_dt=sysdate where fltd = to_date('"+sendrptobj.getFltd()+"','yyyy/mm/dd') and fltno = '"+sendrptobj.getFltno()+"' and sect = '"+sendrptobj.getSect()+"'";

                                    pstmt=null;
                                    pstmt = con.prepareStatement(sqlsb.toString());
                                    idx=0;                                                      
                                    pstmt.setString(++idx,sendrptobj.getEmpno());
                                    pstmt.setString(++idx,sendrptobj.getEmpno());
                                    pstmt.setString(++idx,sendrptobj.getChgdate());
//                                    pstmt.setString(++idx,sendrptobj.getNewdate());
                                    pstmt.setString(++idx,sendrptobj.getTrip_num());
                                    pstmt.setString(++idx,"Y");
                                    pstmt.setString(++idx,"N");
                                    pstmt.executeUpdate(); 
                                }
                                else //insert
                                {
                                    sqlsb.append(" insert into egtcrpt (fltd,fltno,sect,empno,chguser,chgdate,newdate,flag,caseclose,trip_num, sendr_dt )");
                                    sqlsb.append(" values (to_date(?,'yyyy/mm/dd'),?,?,?,?,to_date(?,'yyyy/mm/dd hh24:mi:ss'),sysdate,?,?,?, sysdate)");
                                    error_sql = sqlsb.toString();
                                    pstmt=null;
                                    pstmt = con.prepareStatement(sqlsb.toString());
                                    idx=0;                                                      
                                    pstmt.setString(++idx,sendrptobj.getFltd());
                                    pstmt.setString(++idx,sendrptobj.getFltno());
                                    pstmt.setString(++idx,sendrptobj.getSect());
                                    pstmt.setString(++idx,sendrptobj.getEmpno());
                                    pstmt.setString(++idx,sendrptobj.getEmpno());
                                    pstmt.setString(++idx,sendrptobj.getChgdate());
//                                    pstmt.setString(++idx,sendrptobj.getNewdate());
                                    pstmt.setString(++idx,"Y");
                                    pstmt.setString(++idx,"N");
                                    pstmt.setString(++idx,sendrptobj.getTrip_num());
                                    pstmt.executeUpdate();                         
                                }
                                
                                sql =" update egtcflt set upd='N' where fltd = to_date('"+sendrptobj.getFltd()+"','yyyy/mm/dd') and fltno = '"+sendrptobj.getFltno()+"' and sect = '"+sendrptobj.getSect()+"' ";
                                stmt.executeUpdate(sql);    
                                con.commit();
                            }else{
                                return "�ȿ����i�e�X����";
                            }        
    	                }
	                }
                    else//if("Y".equals(status_str))
                    {
                        return status_str;
                    }	                
	            }// if(!"".equals(sendrptobj.getFltd()) && !"".equals(sendrptobj.getFltno()) && !"".equals(sendrptobj.getSect()))
                else
                {
                    return "��Ƥ�����A�e�X���i����";                    
                }
	        }//for(int i=0; i<sendrptAL.length; i++)	        
	    } 
	    catch(Exception e) 
	    {
	        try
            {
                fw = new FileWriter(path+"serviceLog.txt",true);
                fw.write(new java.util.Date()+"\r\n");       
                fw.write(e.toString() + " ** " +error_step +" Failed /r/n");   
                fw.write(error_sql+"/r/n");  
                fw.write("****************************************************************/r/n");
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
			//System.out.println(e.toString());
	        try{con.rollback();}catch(SQLException se){ return se.toString();}
	        return e.toString();			
		}
		finally 
		{
			try{if(rs != null) rs.close();}catch(SQLException e){}
	  		try{if(stmt != null) stmt.close();}catch(SQLException e){}
	  		try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
	   		try{if(con != null) con.close();}catch(SQLException e){}
		} 
	    
        return "Y";
    }
}

package swap3ac;

import java.io.*;
import java.sql.*;
import java.text.*;
import java.util.*;

import ci.db.*;

/**
 * CheckFullAttentance ���o�խ��e���d���O���έp��O�_���Ԫ����,���Z�ӽХ�.
 * 
 * 
 * @author cs71
 * @version 1.0 2008/05/08
 * 
 * Copyright: Copyright (c) 2008
 */
public class CheckFullAttendance {

    public static void main(String[] args) 
    {
        CheckFullAttendance cs = new CheckFullAttendance("641571", "201203");
//      System.out.println(new java.util.Date());
//      System.out.println(cs.getCheckMonth());
        System.out.println(cs.isFullAttentancd("201405","201202"));
//      System.out.println(new java.util.Date());
        
        System.out.println("Done");
    }

    private String empno;// ���u��
    private String swapYearAndMonth;// ���Z�~��,format: yyyymm
    private String ifsuspend = "Y";
    private String cleanmonth1 = "";
    private String cleanmonth2 = "";
    private CleanMonthObj obj = new CleanMonthObj();// ���԰�Ǥ��
    private String sql =""; 
    private String path = "/apsource/csap/projfz/webap/FZ/credit/";
//  private String path = "c://FZTemp/credit/";
    FileWriter fw = null;   
    
    /**
     * @param empno
     *            �խ����u��
     * @param swapYearAndMonth
     *            ���Z�~��,format: yyyymm
     */
    public CheckFullAttendance(String empno, String swapYearAndMonth) 
    {
        this.empno = empno;
        this.swapYearAndMonth = swapYearAndMonth;       
        try
        {
            fw = new FileWriter(path+"CheckFullAttendance.txt",true);
            fw.write(new java.util.Date()+"********************* Start***************************\r\n");
            fw.write(" Empno : "+empno + " swapYearAndMonth : "+swapYearAndMonth);          
        }
        catch (Exception e)
        {
            
        }
    }

    /**
     * ���o���,�íp����԰�Ǥ��
     * 
     * check egtsusp get check clean months 
     * then check roster_v
     */
    public String getCheckMonth() 
    {   
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;    
        Driver dbDriver = null;
        int count = 0;
        String returnstr = "";
        
        
        Hashtable suspHT = new Hashtable();
        SimpleDateFormat format = new SimpleDateFormat("yyyyMM");
        try 
        {
            ConnDB cn = new ConnDB();           
//          User connection pool  ********
//            ConnectionHelper ch = new ConnectionHelper();
//            conn = ch.getConnection();
//            stmt = conn.createStatement();
            
            cn.setORP3FZUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            stmt = conn.createStatement();
            
            // �����s�u
//           cn.setAOCIPRODFZUser();
//           cn.setORP3FZUser();
//           java.lang.Class.forName(cn.getDriver());
//           conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
//             stmt = conn.createStatement();

            //if suspend in two months
//          sql = " SELECT t1.m1 m1, t1.m2 m2, t1.empno empno, t2.ssdate ssdate, (t2.recurdate-1) recurdate, " +
//                " CASE WHEN nvl((t2.recurdate-1),add_months(To_Date('"+swapYearAndMonth+"01','yyyymmdd'),-3)) " +
//                " < add_months(To_Date('"+swapYearAndMonth+"01','yyyymmdd'),-2)  " +
//                " THEN 'N' ELSE 'Y' END susp FROM  " +
//                " (SELECT '"+empno+"' empno, To_Char(add_months(To_Date('"+swapYearAndMonth+"01','yyyymmdd'),-1),'yyyymm') m1, " +
//                " To_Char(add_months(To_Date('"+swapYearAndMonth+"01','yyyymmdd'),-2),'yyyymm') m2, 'Y' s1 FROM dual) t1 , " +
//                " ( SELECT Trunc(ssdate,'mm') ssdate, Nvl(Trunc((recurdate-1),'mm'),sysdate) recurdate, 'Y' s2 " +
//                " FROM egtsusp WHERE empn = '"+empno+"'  " +
//                " AND ssdate = (SELECT Max(ssdate) FROM egtsusp WHERE empn = '"+empno+"' AND recurdate IS NOT NULL) ) t2 " +
//                " WHERE  t1.s1 = t2.s2(+) ";
            
            sql = " SELECT t1.m1 m1, t1.m2 m2, t1.empno empno, " +
                  " CASE WHEN ((t2.ssdate > t3.max_act_str_dt) OR t3.max_act_str_dt IS NULL) " +
                  " THEN t2.ssdate ELSE t3.max_act_str_dt end ssdate, " +
                  " CASE WHEN (((t2.recurdate-1) > t3.max_act_end_dt) OR t3.max_act_str_dt IS NULL ) " +
                  " THEN (t2.recurdate-1) ELSE t3.max_act_end_dt END recurdate, " +
                  " CASE WHEN  Nvl((CASE WHEN ((t2.recurdate-1) > t3.max_act_end_dt OR t3.max_act_end_dt IS NULL ) THEN (t2.recurdate-1) ELSE t3.max_act_end_dt END), " +
                  " add_months(To_Date('"+swapYearAndMonth+"01','yyyymmdd'),-3)) < add_months(To_Date('"+swapYearAndMonth+"01','yyyymmdd'),-2) THEN 'N' ELSE 'Y' END susp " +
                  " FROM   (SELECT '"+empno+"' empno, To_Char(add_months(To_Date('"+swapYearAndMonth+"01','yyyymmdd'),-1),'yyyymm') m1, " +
                  " To_Char(add_months(To_Date('"+swapYearAndMonth+"01','yyyymmdd'),-2),'yyyymm') m2, 'Y' s1 FROM dual) t1 , " +
                  " ( SELECT Trunc(ssdate,'mm') ssdate, Nvl(Trunc((recurdate-1),'mm'),sysdate) recurdate, 'Y' s2 " +
                  " FROM egtsusp WHERE empn = '"+empno+"'AND ssdate = " +
                  " (SELECT Max(ssdate) FROM egtsusp WHERE empn = '"+empno+"' AND recurdate IS NOT NULL) ) t2, " +
                  " (SELECT Max(act_str_dt) max_act_str_dt , Max(act_end_dt) max_act_end_dt, 'Y' s3 FROM roster_v " +
                  " WHERE staff_num = '"+empno+"' AND duty_cd = 'NP' AND delete_ind <> 'Y' ) t3 " +
                  " WHERE  t1.s1 = t2.s2(+) AND t1.s1 = t3.s3(+) ";
//          System.out.println(sql);
            rs = stmt.executeQuery(sql);
            
            if (rs.next())
            {
                ifsuspend = rs.getString("susp").trim();
                if("N".equals(ifsuspend))
                {
                    obj.setCleanMonthStart(rs.getString("m1"));
                    obj.setCleanMonthEnd(rs.getString("m2"));
                    count =2;
                }
            }
            rs.close();
            
            //has suspend record in two months or have required NP leave
            if("Y".equals(ifsuspend))
            {               
                //suspend records
//              sql = " SELECT To_Char(Trunc(ssdate,'mm'),'yyyymm') ssdate, " +
//                    " To_Char(Trunc(nvl((recurdate-1),sysdate),'mm'),'yyyymm') recurdate " +
//                    " FROM egtsusp WHERE empn = '"+empno+"' and recurdate IS NOT NULL order by ssdate desc ";
                
                sql = "  SELECT To_Char(Trunc(ssdate,'mm'),'yyyymm') ssdate, " +
                      " To_Char(Trunc(nvl((recurdate-1),sysdate),'mm'),'yyyymm') recurdate " +
                      " FROM egtsusp WHERE empn = '"+empno+"' and recurdate IS NOT NULL UNION ALL " +
                      " SELECT To_Char(act_str_dt,'yyyymm') ssdate , To_Char(act_end_dt,'yyyymm') recurdate " +
                      " FROM roster_v WHERE staff_num = '"+empno+"' AND duty_cd = 'NP' AND delete_ind <> 'Y' " +
                      " GROUP BY To_Char(act_str_dt,'yyyymm') , To_Char(act_end_dt,'yyyymm') " +
                      " order by ssdate desc";
//              System.out.println(sql);
                rs = stmt.executeQuery(sql);
                while(rs.next())
                {
                    String sdate = rs.getString("ssdate");
                    String edate = rs.getString("recurdate");
                    
                    //get every suspend month in the period                     
                    java.util.Date datestart = format.parse(sdate);
                    java.util.Date dateend = format.parse(edate);
                    GregorianCalendar calstart = new GregorianCalendar();
                    GregorianCalendar calend = new GregorianCalendar();
                    calstart.setTime(datestart);
                    calend.setTime(dateend);                    
//                  System.out.println(format.format(calstart.getTime()) +"/"+format.format(calend.getTime()));
                    while (!format.format(calstart.getTime()).equals(format.format(calend.getTime())))
                    {
//                      System.out.println(format.format(calstart.getTime()) +"/"+format.format(calend.getTime()));
                        suspHT.put(format.format(calstart.getTime()),"Y");
                        calstart.add(Calendar.MONTH, +1);
                    }
                    //when equals
                    suspHT.put(format.format(calstart.getTime()),"Y");
                }               
             //*********************************
//              Set keyset = suspHT.keySet();
//              Iterator i = keyset.iterator();
//              while(i.hasNext())  
//              {
//                  String key = String.valueOf(i.next());
//                  String value = (String)suspHT.get(key);
//                  System.out.println(key+" -- "+value);
//              }
            //*********************************
                
//          set check clean months          
            java.util.Date swapmonth = format.parse(swapYearAndMonth);
//          java.util.Date aircrewsmonth = format.parse("200605");
            java.util.Date aircrewsmonth = format.parse("200604");
            GregorianCalendar checkmonthstart = new GregorianCalendar();
            GregorianCalendar aircrewsmonthend = new GregorianCalendar();
            checkmonthstart.setTime(swapmonth);
            aircrewsmonthend.setTime(aircrewsmonth);
            checkmonthstart.add(Calendar.MONTH, -1);
//          System.out.println(format.format(checkmonthstart.getTime())+"/"+format.format(aircrewsmonthend.getTime()));
                    
            count=0;
            while (!format.format(checkmonthstart.getTime()).equals(format.format(aircrewsmonthend.getTime())))
            {//check clean month till 200605 aircrews publish
                String findmonth = format.format(checkmonthstart.getTime());
//              System.out.println(findmonth + "-->"+suspHT.get(findmonth));        
                if(suspHT.get(findmonth)==null )//not found suspend month
                {
                    count ++;
                    if(count==1)
                    {
                        obj.setCleanMonthStart(findmonth);
                    }   
                    
                    if(count==2)
                    {
                        obj.setCleanMonthEnd(findmonth);
//                      System.out.println("before break 1");
                        break ;
                    }                       
                }
//              System.out.println("before break 2");
                checkmonthstart.add(Calendar.MONTH, -1);
            }    
//          System.out.println("before break out");    
            }//if("Y".equals(ifsuspend))
            
            //Add by Betty on 2009/02/09
            fw.write(" Clean month : "+obj.getCleanMonthStart()+"/"+obj.getCleanMonthEnd()+"\r\n");
            
            if(count<2)
            {               
//              System.out.println("clean month 1 --> "+ obj.getCleanMonthStart()+"/"+obj.getCleanMonthEnd());
                returnstr = "�ЦܲդW��z";
                //return "�ЦܲդW��z";
            }
            else
            {
//              System.out.println("clean month 2 --> "+ obj.getCleanMonthStart()+"/"+obj.getCleanMonthEnd());
                String isfullattendance = "";
                isfullattendance = isFullAttentancd(obj.getCleanMonthStart(), obj.getCleanMonthEnd()) ;
                
                //20140527 �s�ͧP�_
                if("Y".equals(isfullattendance))
                {
                    returnstr = "Y";
//                  return "Y";
                    sql = " select count(empn) cnt from egtcbas c where indate <= add_months(to_date('"+swapYearAndMonth+"01','yyyymmdd'),-2)" +
                          " and trim(empn) = '"+empno+"'";
//                      System.out.println(sql);
                    rs = stmt.executeQuery(sql);
                    if (rs.next())
                    {
                        
                        if(rs.getInt("cnt") == 0)
                        {
                            returnstr = "���歸����Ȼݺ���Ӥ�~�i���Z";
                        }else{
                            returnstr = "Y";
                        }
                    }
                }
                else
                {
                    returnstr = empno+" �� "+obj.getCleanMonthStart()+" �� "+obj.getCleanMonthEnd()+" ���а��O���ιH�W�O��, �ॢ���Z��� ";
//                  return empno+" �� "+obj.getCleanMonthStart()+" �� "+obj.getCleanMonthEnd()+" ���а��O���ιH�W�O��, �ॢ���Z��� ";
                }
            }
        } 
        catch (Exception e) 
        {
            returnstr = "Error : "+e.toString();
//          return e.toString();
        } 
        finally 
        {
            if (rs != null)
                try {
                    rs.close();
                } catch (SQLException e) {}
            if (stmt != null)
                try 
                {
                    stmt.close();
                } catch (SQLException e) {}
            
            if (conn != null)
                try {
//                   System.out.println("********conn close ***********");
                    conn.close();
                } catch (SQLException e) {}
                
            try
            {
                fw.write(new java.util.Date()+"********************* end ***************************\r\n"); 
                fw.flush();
                fw.close();
            }
            catch (Exception e) 
            {
                
            }
                
        }
        
        return returnstr;
    }

    /**
     * ��check month �P�_�O�_����
     * 
     * @throws Exception
     * 
     */
    public String isFullAttentancd(String m1, String m2) 
    {       
        Connection conn = null;
        Statement stmt = null;      
        ResultSet rs = null;    
        Driver dbDriver = null;
        String returnstr = "N";
        
        try 
        {
//            ConnDB cn = new ConnDB();
            
            // connection Pool
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();      
            
//            cn.setAOCIPRODCP();
//            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//            conn = dbDriver.connect(cn.getConnURL(), null);
//            stmt = conn.createStatement();
            
//           �����s�u
//           cn.setORP3FZUser();
//           java.lang.Class.forName(cn.getDriver());
//           conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
//             stmt = conn.createStatement();
            
            //if absent, �����ҶqSL/PL
            sql = " select count (*) c from roster_v  where ( duty_cd in ('EL','UL','LL','NS','CL','CNCL') " +
                  " or (duty_cd = 'LA' AND To_Char(end_dt,'hh24mi') = '2359')) and " +
                  " delete_ind='N' and staff_num = '"+empno+"' " +
                  " and ( Trunc(str_dt,'mm') =  To_Date('"+m1+"01','yyyymmdd') " +
                  " OR Trunc(str_dt,'mm') =  To_Date('"+m2+"01','yyyymmdd') ) ";
//System.out.println(sql);
            rs = stmt.executeQuery(sql);
            int count = 0;
            if (rs.next())
            {
                count = rs.getInt("c");
            }
            
            if(count >0)
            {   //�Y���i���Z
                returnstr = "N";
            }
            else
            {
                //�Y�e�G�Ӥ����(���]�tSL/PL),�ˮ֫e�G�Ӥ�O�_����SL/PL
                //2015/03/10 �|�����Z �� �а��ɯZ�W�h,PL ���P����
                rs.close();
                count = 0;
                sql = "";               
                sql = " select count (*) c from roster_v  where duty_cd = 'SL' and " +//in ('SL','PL')
                      " delete_ind='N' and staff_num = '"+empno+"' " +
                      " and ( Trunc(str_dt,'mm') =  To_Date('"+m1+"01','yyyymmdd') " +
                      " OR Trunc(str_dt,'mm') =  To_Date('"+m2+"01','yyyymmdd') ) ";            
                
                rs = stmt.executeQuery(sql);
                if (rs.next())
                {
                    count = rs.getInt("c");
                }
                
                if(count <=0)
                {
                    //�e�G�Ӥ�S��SL/PL,�Y�i���Z
                    returnstr = "Y";
                }
                else
                {    //�e�G�Ӥ릳��SL/PL,�ˮִ��Z��~��(���]�t���Z���)SL/PL�O�_�C�󤭤�
                     //2012 3������Z��l��I       
                     //2013/01/03 �אּ���Z������e12�Ӥ�
//                  if(Integer.parseInt(swapYearAndMonth) >= 201203)
//                  {
//                      if("01".equals(swapYearAndMonth.substring(4,6)))
//                      {//�Y���Z������@��
//                          returnstr = "Y";
//                      }
//                      else
//                      {
//                          //�ˮִ��Z��~��(���]�t���Z���)SL/PL�O�_�C�󤭤�
//                          rs.close();
//                          count = 0;
//                          sql = "";
//                          sql = " select count (*) c from roster_v  where duty_cd in ('SL','PL') and " +
//                                " delete_ind='N' and staff_num = '"+empno+"' " +
//                                " and str_dt between  To_Date('"+swapYearAndMonth.substring(0,4)+"0101','yyyymmdd') " +
//                                " and To_Date('"+swapYearAndMonth+"01 2359','yyyymmdd hh24mi')-1 ";
//  //                      System.out.println(sql);
//                          rs = stmt.executeQuery(sql);
//                          if (rs.next())
//                          {
//                              count = rs.getInt("c");
//                          }
//                          
//                          if(count <= 5)
//                          {
//                              returnstr = "Y";
//                          }   
//                          else
//                          {
//                              returnstr = "N";
//                          }
//                      }
//                  }
//                  else
//                  {//201203�H�e����SL/PL�����i���Z                     
//                      returnstr = "N";
//                  }
                    
                  //2013/01/03 �אּ���Z������e12�Ӥ�(���]�t���Z���)SL/PL�O�_�C�󤭤�
                  //2014/01/27 �ݨD�אּ2014/01/01 �ͮ�
                  //2015/03/10 �|�����Z �� �а��ɯZ�W�h,PL ���P����,
                  rs.close();
                  count = 0;
                  sql = "";
                  sql = " select count (*) c from roster_v  where duty_cd ='SL' and " +//in ('SL','PL')
                        " delete_ind='N' and staff_num = '"+empno+"' " +
                        " and str_dt between  ADD_MONTHS(To_Date('"+swapYearAndMonth+"01','yyyymmdd'), -12) " +
                        " and Last_Day(ADD_MONTHS(To_Date('"+swapYearAndMonth+"01 2359','yyyymmdd hh24mi'), -1)) " +
                        " and str_dt >= To_Date('20140101','yyyymmdd') ";
//                      System.out.println(sql);
                  rs = stmt.executeQuery(sql);
                  if (rs.next())
                  {
                      count = rs.getInt("c");
                  }
                  
                  if(count <= 5)
                  {
                      returnstr = "Y";
                  }   
                  else
                  {
                      returnstr = "N";
                  }
                }
            }
        } 
        catch (Exception e) 
        {
            returnstr = e.toString();
//          return e.toString();
        } 
        finally 
        {
            if (rs != null)
                try {
                    rs.close();
                } catch (SQLException e) {}
            if (stmt != null)
                try 
                {
                    stmt.close();
                } catch (SQLException e) {}         
            if (conn != null)
                try {
//                  System.out.println("conn close 2");
                    conn.close();
                } catch (SQLException e) {}
        }
        return returnstr;
    }

    public String getEmpno() {
        return empno;
    }

    public void setEmpno(String empno) {
        this.empno = empno;
    }

    public String getSwapYearAndMonth() {
        return swapYearAndMonth;
    }

    public void setSwapYearAndMonth(String swapYearAndMonth) {
        this.swapYearAndMonth = swapYearAndMonth;
    }

    public CleanMonthObj getCleanMonthObj() {
        return obj;
    }
    
     public String getSQL()
     {
         return sql;
     }
}


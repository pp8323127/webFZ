package df.overTime.ac;

import java.sql.*;
import java.util.*;

import ci.db.*;


/**
 * RetrieveOverTimeData
 * 
 * @author cs66
 * @version 1.0 2005/12/29
 * 
 * Copyright: Copyright (c) 2005
 */

public class SumOverTime_AC
{
    public static void main(String[] args) 
    {
        SumOverTime_AC ovr = new SumOverTime_AC("2009", "11");        
        //set overpay rate to pock
        ovr.setOverRate();
        //update ovrhrs, ovrpayrate, ovrpay to dftpock
        ovr.sumOverPay();
        System.out.println("Done"); 
    }

    public SumOverTime_AC(String year, String month) 
    {
        this.year = year;
        this.month = month;
    }

    private String year = "";
    private String month = "";
    private int count =0;    
//    Connection conn = null;
//    Statement stmt = null;
//	private ResultSet rs = null;	
//    PreparedStatement pstmt = null;   
    private String sql = "";
    private ArrayList empnoAL = new ArrayList();
    private ArrayList ovrhrsAL = new ArrayList();
    private ArrayList ovrhrs2AL = new ArrayList();
   
    //*********************************************************
    public void setOverRate() 
    {//set overpayrate to pock
        Connection conn = null;
        Statement stmt = null;
    	ResultSet rs = null;	
    	Driver dbDriver = null;
        PreparedStatement pstmt = null;   
        try 
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();    
            stmt = conn.createStatement();
            
            sql = 	" SELECT p.empno empno, Round((Nvl( case when To_Date(To_char(s.vardt,'yyyymm')||'01','yyyymmdd') <= "
	                + " To_Date('"+year+month+"'||'01','yyyymmdd') then saryamt ELSE osaryamt END ,0) + " 
	                + " Nvl(r.flpa,0))/240*1.66,0 ) ovrrate "
	                + " FROM hrdb.hrvegsalary s, dftflrk r , dftpock p "
	                + " WHERE p.yyyy = '"+year+"' and p.mm = '"+month+"' AND p.cabin <> 'A' " 
	                //Add in 2007/07/03  cabin crew manager 不得領取加班費
	                //***************************************************
	                + " and r.rkcode <> 'FM-01'"
	                //***************************************************
	                //Add in 2009/09/14 職位代號191G &191H 不發加班費	                
	                + " and (p.post NOT IN ('191G','191H') OR p.post IS NULL) "
//	              ***************************************************
	                + " AND p.empno = s.employid AND Decode(trim(p.nflrk),NULL,trim(p.oflrk),trim(p.nflrk)) = " 
	                + " trim(r.rkcode(+)) ORDER BY p.empno";
//           System.out.println(sql);
           rs = stmt.executeQuery(sql);  
           
           sql = " update dftpock set ovrpayratedd = to_number(?), ovrmindd = 0, ovrmindd2 =0, ovrpaydd = 0 " +
           		 " where empno = ? and yyyy = ? and mm = ? ";
           pstmt = conn.prepareStatement(sql);
           count =0;
           while (rs.next())
           {
               pstmt.setString(1 , rs.getString("ovrrate"));
               pstmt.setString(2 , rs.getString("empno"));
               pstmt.setString(3 , year);
               pstmt.setString(4 , month);               
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
           
           
           
        } catch (SQLException e) {
            System.out.print(e.toString());
        } catch (Exception e) {
            System.out.print(e.toString());
            e.printStackTrace();
        } finally {
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
     
     public void sumOverPay() 
     {// calculate dftovrp overpay    
         Connection conn = null;
         Statement stmt = null;
     	 ResultSet rs = null;	
     	 Driver dbDriver = null;
         PreparedStatement pstmt = null;   
         try 
         {
             ConnectionHelper ch = new ConnectionHelper();
             conn = ch.getConnection();    
             stmt = conn.createStatement();

             sql = " SELECT empno, Sum(nvl(overmins,0)) s_overmins, Sum(Nvl(overmins2,0)) s_overmins2 " +
             	   " FROM ( SELECT empno, overmins, overmins2 FROM dftovrp " +
             	   " WHERE paymm = to_char(last_day(to_date(?,'yyyymmdd'))+1,'yyyymm') ) " +
             	   " GROUP BY  empno ";
//             System.out.println(sql);
             pstmt = conn.prepareStatement(sql);
             pstmt.setString(1 ,year+month+"01");
             rs = pstmt.executeQuery(); 
             empnoAL.clear();
             ovrhrsAL.clear();             
             ovrhrs2AL.clear();
             
             while (rs.next())
             {
                 ovrhrsAL.add(rs.getString("s_overmins"));   
                 ovrhrs2AL.add(rs.getString("s_overmins2"));          
                 empnoAL.add(rs.getString("empno"));    
             }                       
             rs.close();
             	
             if (ovrhrsAL.size() > 0 )
             {               
                 sql =  " update dftpock set ovrmindd = to_number(?), ovrmindd2 = to_number(?), " +
                 		" ovrpayratedd = decode(ovrpayratedd,null,'0',ovrpayratedd), " +
                	    " ovrpaydd = round(nvl(ovrpayratedd,0) * round(?/60,3),0) + round(Round(nvl(ovrpayratedd,0)/1.66*2,0) * round(?/60,3),0) " +
                	    " where empno = ? and yyyy = ? and mm = ? ";  
                 
                 pstmt = conn.prepareStatement(sql);
                 count =0;
                 for(int i=0; i<ovrhrsAL.size(); i++ )
                 {
//                     String sqlstr =  " update dftpock set ovrmindd = to_number("+(String)ovrhrsAL.get(i)+"), ovrmindd2 = to_number("+(String)ovrhrs2AL.get(i)+"), " +
//              		" ovrpayratedd = decode(ovrpayratedd,null,'0',ovrpayratedd), " +
//             	    " ovrpaydd = round(nvl(ovrpayratedd,0) * round("+(String)ovrhrsAL.get(i)+"/60,3),0) + round(Round(nvl(ovrpayratedd,0)/1.66*2,0) * round("+(String)ovrhrs2AL.get(i)+"/60,3),0) " +
//             	    " where empno = '"+(String)empnoAL.get(i)+"' and yyyy = '"+year+"' and mm = '"+month+"' ";   
//                    System.out.println(sqlstr); 
                     
                     pstmt.setString(1 , (String)ovrhrsAL.get(i));
                     pstmt.setString(2 , (String)ovrhrs2AL.get(i));
                     pstmt.setString(3 , (String)ovrhrsAL.get(i));
                     pstmt.setString(4 , (String)ovrhrs2AL.get(i));
                     pstmt.setString(5 , (String)empnoAL.get(i));
                     pstmt.setString(6 , year);
                     pstmt.setString(7 , month);
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
             
         } catch (SQLException e) {
             System.out.print(e.toString());
         } catch (Exception e) {
             System.out.print(e.toString());
             e.printStackTrace();
         } finally {
             if ( rs != null ) try {
                 rs.close();
             } catch (SQLException e) {}
             if ( pstmt != null ) try {
                 pstmt.close();
             } catch (SQLException e) {}
             if ( conn != null ) try {
                 conn.close();
             } catch (SQLException e) {}
         }

     }

}
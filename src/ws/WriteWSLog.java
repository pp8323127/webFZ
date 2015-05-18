package ws;

import java.sql.*;
import java.util.*;

import ci.db.*;

public class WriteWSLog
{

    /**
     * @param args
     */
    private String serviceName = null;
    private String startTime = null;
    private String endTime = null;
    private String fltd = null;
    private String fltno = null;
    private String sect = null;
    private String userid = null;
    
    
    public static void main(String[] args)
    {
        // TODO Auto-generated method stub
        String serviceName = "XXXX";
        String startTime = "2015/01/01 12:00:02";
        String endTime = "2015/01/01 13:00:02";
        String fltd = "2015/01/02";
        String fltno = "0006";
        String sect = "TPELAX";
        String userid = "123456";
        
        WriteWSLog fun = new WriteWSLog(serviceName, startTime, endTime, fltd, fltno, sect, userid);
        System.out.println(fun.WriteLog());

    }
    
    
    public WriteWSLog(String serviceName, String startTime, String endTime,
            String fltd, String fltno, String sect, String userid)
    {
        super();
        this.serviceName = serviceName;
        this.startTime = startTime;
        this.endTime = endTime;
        if(fltd.indexOf("/") > 0){
            this.fltd = fltd.substring(0,10);
        }else if(fltd.length()>0){
            this.fltd = fltd.substring(0,4)+"/"+fltd.substring(4,6)+"/"+fltd.substring(6,8);
        }else{
            this.fltd = "";
        }
        this.fltno = fltno;
        this.sect = sect;
        this.userid = userid;
    }

    public String WriteLog(){
        
        String result = null;
        Connection conn = null;
        PreparedStatement pstmt = null;   
        String sql = "";
        boolean getCdate = false;
        int gap_days = 0;
        //**************************************************
        //Set inital check range 
        Calendar cal = new GregorianCalendar();     
      
        //**************************************************        
        try 
        {
            // connection Pool            
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            if(fltd != null && !"".equals(fltd)){
                sql = " insert into fztwslog (ws_name ,start_ts ,end_ts ,fltd , fltno,  sect,  userid)  " +
                        "values( ?, to_date(?,'yyyy/mm/dd hh24:mi:ss'), to_date(?,'yyyy/mm/dd hh24:mi:ss') ,to_date(?,'yyyy/mm/dd') ,?,?,?)";         
            }else{
                sql = " insert into fztwslog (ws_name ,start_ts ,end_ts , fltno,  sect,  userid)  " +
                        "values( ?, to_date(?,'yyyy/mm/dd hh24:mi:ss'), to_date(?,'yyyy/mm/dd hh24:mi:ss') ,?,?,?)";       
            }
            conn.setAutoCommit(false);   
            pstmt = conn.prepareStatement(sql);
            int idx =0;
            pstmt.setString(++idx, serviceName);
            pstmt.setString(++idx, startTime);
            pstmt.setString(++idx, endTime);
            if( fltd != null && !"".equals(fltd) ){
                pstmt.setString(++idx, fltd);
            }
            pstmt.setString(++idx, fltno);
            pstmt.setString(++idx, sect);
            pstmt.setString(++idx, userid);
            
            
            idx = pstmt.executeUpdate();
            if(idx == 1){
                conn.commit();
                result = "Y";
            }else{
                result = "N";
                try{
                    conn.rollback();
                }catch(SQLException se){
                    result = se.toString();
                }    
            }
            
           
       } 
        catch (Exception e) 
        {
            result =e.toString();
            System.out.println("WS log:"+e.toString()+fltd+","+fltno+","+sect+","+userid);
        } 
        finally 
        {
            if (pstmt != null)
                try 
                {
                    pstmt.close();
                } catch (SQLException e) {}         
            if (conn != null)
                try {
//                  System.out.println("conn close ");
                    conn.close();
                } catch (SQLException e) {}
        }
        
        
        return result;
    }

}

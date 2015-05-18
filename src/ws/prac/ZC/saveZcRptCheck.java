package ws.prac.ZC;

import java.sql.*;

import ws.*;

public class saveZcRptCheck
{
//    public static void main(String[] args)
//    {
//        saveZcRptCheck src = new saveZcRptCheck();
//        System.out.println(src.doSaveReportCheck("2010/02/05","0064","VIETPE","630304"));
//        
//    }
    
    private Connection con = null;
    private Statement stmt = null;
    private ResultSet rs = null;
    private Driver dbDriver = null;
    private String sql ="";
     
   public String doSaveReportCheck(String fltd, String fltno, String sect,String zcEmpn) 
    {        
        ci.db.ConnDB cn = new ci.db.ConnDB();
        
        try
        {
            cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            con = dbDriver.connect(cn.getConnURL(), null);
            
            //connect ORT1 EG     
//              cn.setORP3EGUser();
//              cn.setORT1EG();
//              Class.forName(cn.getDriver());
//              con = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());   
            
            stmt = con.createStatement();  
            
            sql = "select Count(*) c from egtzcflt where fltd = to_date('"+fltd+"','yyyy/mm/dd') and fltno = '"+fltno+"' and sect = '"+sect+"' and zcempn <> '"+zcEmpn+"'";
            rs = stmt.executeQuery(sql);
            
            if (rs.next()) 
            {
                //是否報告已存在
                if(rs.getInt("c")>0)
                {
                    return "報告已存在，不可重複撰寫。";                    
                }                
            }
            
            sql = "SELECT Count(*) c FROM dual WHERE to_date('"+fltd+"','yyyy/mm/dd') > Trunc(SYSDATE,'dd') ";
            rs = stmt.executeQuery(sql);
            
            if (rs.next()) 
            {
                //fltd > sysdate 報告不可編輯
                if(rs.getInt("c")>0)
                {
                    return "報告尚無法編輯。";                    
                }                
            }    
            
            sql = "select count(*) c from egtzcflt where fltd = to_date('"+fltd+"','yyyy/mm/dd') and fltno = '"+fltno+"' and sect = '"+sect+"' and ifsent = 'Y' and zcempn = '"+zcEmpn+"'";
            rs = stmt.executeQuery(sql);
            
            if (rs.next()) 
            {
                //ifsent=Y 報告已送出
                if(rs.getInt("c")>0)
                {
                    return "報告已送出，即不得更改。";                    
                }                
            } 
        } 
        catch(Exception e) 
        {
            //System.out.println(e.toString());
            try{con.rollback();}catch(SQLException se){ return se.toString();}
            return e.toString();            
        }
        finally 
        {
            try{if(rs != null) rs.close();}catch(SQLException e){}
            try{if(stmt != null) stmt.close();}catch(SQLException e){}
            try{if(con != null) con.close();}catch(SQLException e){}
        }  
        return "Y";
    }
   
  
}

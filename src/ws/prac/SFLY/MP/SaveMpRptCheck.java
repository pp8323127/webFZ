package ws.prac.SFLY.MP;

import java.sql.*;

public class SaveMpRptCheck
{

    /**
     * @param args
     */
    
    private Connection con = null;
    private Statement stmt = null;
    private ResultSet rs = null;
    private Driver dbDriver = null;
    private String sql ="";
    
    
    public static void main(String[] args)
    {
        // TODO Auto-generated method stub

    }

    public String doSaveReportCheck(String fltd, String fltno, String trip,String instempno){
          
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
            
            sql = "select Count(*) c from EGTSTTI where fltd = to_date('"+fltd+"','yyyy/mm/dd') and fltno like '"+fltno+"%' and trip like '"+trip+"%' and instempno <> '"+instempno+"'";
            rs = stmt.executeQuery(sql);
            
            if (rs.next()) 
            {
                //�O�_���i�w�s�b
                if(rs.getInt("c")>0)
                {
                    return "���i�w�s�b�A���i���Ƽ��g�C";                    
                }                
            }
            
            sql = "SELECT Count(*) c FROM dual WHERE to_date('"+fltd+"','yyyy/mm/dd') > Trunc(SYSDATE,'dd') ";
            rs = stmt.executeQuery(sql);
            
            if (rs.next()) 
            {
                //fltd > sysdate ���i���i�s��
                if(rs.getInt("c")>0)
                {
                    return "���i�|�L�k�s��C";                    
                }                
            }    
            
            sql = "select count(*) c from EGTSTTI where fltd = to_date('"+fltd+"','yyyy/mm/dd') and fltno like '"+fltno+"%' and trip  like '"+trip+"%' and send = 'Y' and instempno = '"+instempno+"'";
            rs = stmt.executeQuery(sql);
            
            if (rs.next()) 
            {
                //ifsent=Y ���i�w�e�X
                if(rs.getInt("c")>0)
                {
                    return "���i�w�e�X�A�Y���o���C";                    
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

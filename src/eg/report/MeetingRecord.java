package eg.report;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import ci.db.ConnDB;
import ci.db.ConnectionHelper;

public class MeetingRecord {

	/**
	 * @param args
	 */
	public static void main(String[] args)
    {
		MeetingRecord MR = new MeetingRecord();
//		System.out.println(MR.ifLSWOKDate("2015/03/19", "2015/03/19", "633020"));
		System.out.println(MR.ifEDnoList("2015/04/20"));
//		System.out.println(MR.getObjAL().size());
    }
	//會議是否為控管日 控管日 不可申請預約
    public String ifLSWOKDate(String sdate,String edate,String empno)
    {             
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        Driver dbDriver = null;
        String iflswok = "Y";
        String sql = "";
        
        int count = 0;
        int count1 = 0;
        int ckCount = 0;
        try
        {           
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement(); 
            
            sql = " SELECT Count(*) c FROM EGTNoMT " +
                  " WHERE To_Date('"+sdate+"','yyyy/mm/dd') BETWEEN sdate AND edate " +
                  " OR To_Date('"+edate+"','yyyy/mm/dd') BETWEEN sdate AND edate " +
                  " OR sdate between To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+"','yyyy/mm/dd') " +
                  " OR edate between To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+"','yyyy/mm/dd') ";
           
//		            System.out.println(sql);
            rs = stmt.executeQuery(sql);

            if (rs.next())
            {
                count = rs.getInt("c");
            }
              
            sql = " select count(*) c from EGTMTDT where empn = '"+empno+"' and mt_date = to_date('"+sdate+"','yyyy/mm/dd')";
             
//  		            System.out.println(sql);
              rs = stmt.executeQuery(sql);

              if (rs.next())
              {
            	  count1 = rs.getInt("c");
              }
            //請假日落在控管日
            if(count > 0)
            {
            	return "請假日為會議預約管制日";
            }
            else if (count1 > 0)
            {
            	return sdate+" 不可重複預約";
            }
            else
            {//check 是否落在六日
                sql = " select To_Char(allday,'yyyy/mm/dd') eachdate, " +
                      " to_char(allday,'DY','NLS_DATE_LANGUAGE=AMERICAN') dayofweek from ( " +
                      " select to_date('"+sdate.substring(0,8)+"'||jday,'yyyy/mm/dd') allday from fztdate " +
                      " WHERE  jday <= To_Char(Last_Day(To_Date('"+sdate+"','yyyy/mm/dd')),'dd') " +
                      " and to_date('"+sdate.substring(0,8)+"'||jday,'yyyy/mm/dd') " +
                      "   BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') and To_Date('"+edate+"','yyyy/mm/dd') " +
                      " UNION select to_date('"+edate.substring(0,8)+"'||jday,'yyyy/mm/dd') allday from fztdate " +
                      " WHERE  jday <= To_Char(Last_Day(To_Date('"+edate+"','yyyy/mm/dd')),'dd') " +
                      " and to_date('"+edate.substring(0,8)+"'||jday,'yyyy/mm/dd') " +
                      "   BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') and To_Date('"+edate+"','yyyy/mm/dd')) ";
//		                  System.out.println(sql);
                  rs.close();
                  count = 0;
                  rs = stmt.executeQuery(sql);
                  while (rs.next())
                  {
                      //System.out.println(rs.getString("eachdate")+"  "+rs.getString("dayofweek"));
                      
	                    if("SAT".equals(rs.getString("dayofweek")) | "SUN".equals(rs.getString("dayofweek")))
	                    {
	                        return "會議預約管制日,無法申請";
	                    }      
                      
                  }
                  
                  return "Y";
            }        
            
            
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            return "Error : "+e.toString()+sql;
        }
        finally
        {
            try
            {
                if (rs != null)
                {
                    rs.close();
                }
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }                 
    }
    
    public String ifEDnoList(String sdate){
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		Driver dbDriver = null;
		ConnDB cn = new ConnDB();
	    String sql = null;
	    int  ckCount = 0;
		try
		{
//			ConnectionHelper ch = new ConnectionHelper();
//			conn = ch.getConnection();
//				
			cn.setORP3FZUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);

//			cn.setORT1FZUser();
//	        Class.forName(cn.getDriver());
//	        conn = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());            
	        
	        stmt = conn.createStatement();            

            sql = " select count(*) c from dual where "+
          		  " (SELECT To_Char(Trunc(Max(setedate))+1,'yyyy/mm/dd') d "+
          		  " FROM fztsetd  WHERE SYSDATE BETWEEN Trunc(setdate)+13/24 AND Trunc(setedate)+1)= '"+sdate+"' ";

            ckCount = 0;
            rs = stmt.executeQuery(sql);
            if (rs.next())
                {
          		  ckCount = rs.getInt("c");
                }    

//              System.out.println(ckCount + sql);
            
            if(ckCount > 0){
          	  return "會議預約期限已過";
            }else{
            	return "Y";
            }
				
			
		}
		catch (Exception e)
		{
//			 System.out.println(e.toString());
			return  e.toString();
		}
		finally
		{
			try{if(rs != null) rs.close();}catch(SQLException e){}
			try{if(stmt != null) stmt.close();}catch(SQLException e){}
			try{if(conn != null) conn.close();}catch(SQLException e){}
		}
    }
}

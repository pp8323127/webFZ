package credit;

import java.sql.*;
import java.util.*;
import ci.db.*;

/**
 * @author cs71 Created on  2012/05/29
 */
public class EPickSkj
{

    public static void main(String[] args)
    {
        EPickSkj eps = new EPickSkj();      
        eps.getSkjPickQual("635863");       
        System.out.println(eps.getObjAL().size());
    }
    
	private String sql = "";
	private ArrayList objAL = new ArrayList();
	
	public String getSkjPickQual(String empno) 
	{	
	    Connection conn = null;
		Statement stmt = null;
		Driver dbDriver = null;
		ResultSet rs = null;	
		
		try 
		{
			// connection Pool
		    ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();  
            stmt = conn.createStatement();
            
            sql = " SELECT pick.sno, pick.empno, cb.cname cname, cb.ename, cb.station, cb.sern sern, " +
            	  " To_Char(new_tmst,'yyyy/mm/dd hh24:mi') new_tmst, valid_ind, " +
            	  " CASE WHEN reason = 1 THEN To_Char(new_tmst+30,'yyyy/mm/dd') ELSE NULL END deadline, " +
            	  " Decode(reason,'1','全勤選班','2','積點選班','3','其它選班') reason, " +
            	  " To_Char(sdate,'yyyy/mm/dd') sdate, To_Char(edate,'yyyy/mm/dd') edate, " +
            	  " pick.comments, ed_user, To_Char(ed_tmst,'yyyy/mm/dd hh24:mi') ed_tmst, ef_user, " +
            	  " To_Char(ef_tmst,'yyyy/mm/dd hh24:mi') ef_tmst, credit3 " +
            	  " FROM egtpick pick, egtcbas cb WHERE empno ='"+empno+"' AND empno = Trim(empn) " +
            	  " AND valid_ind='Y' AND ed_tmst IS null ORDER BY reason ";           
			
//			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			
			while (rs.next())
			{
			    SkjPickObj obj = new SkjPickObj();
			    obj.setSno(rs.getInt("sno"));
			    obj.setEmpno(rs.getString("empno"));
			    obj.setSern(rs.getString("sern"));
			    obj.setCname(rs.getString("cname"));
			    obj.setEname(rs.getString("ename"));
			    obj.setBase(rs.getString("station"));
			    obj.setNew_tmst(rs.getString("new_tmst"));
			    obj.setDeadline(rs.getString("deadline"));
			    obj.setReason(rs.getString("reason"));
			    obj.setValid_ind(rs.getString("valid_ind"));
			    obj.setSdate(rs.getString("sdate"));
			    obj.setEdate(rs.getString("edate"));
			    obj.setComments(rs.getString("comments"));
			    obj.setEd_user(rs.getString("ed_user"));
			    obj.setEd_tmst(rs.getString("ed_tmst"));
			    obj.setEf_user(rs.getString("ef_user"));
			    obj.setEf_tmst(rs.getString("ef_tmst"));
			    obj.setCredit3(rs.getString("credit3"));
			    objAL.add(obj);
			}
			
			return "Y";
		} 
		catch (Exception e) 
		{
			return e.toString();
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
					conn.close();
				} catch (SQLException e) {}
		}		
	}
	
	public ArrayList getObjAL()
	 {
	     return objAL;
	 }  
	
	 public String getSQL()
	 {
	     return sql;
	 }
}

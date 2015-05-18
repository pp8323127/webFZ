package credit;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * @author cs71 Created on  2012/05/29
 */
public class MaintainPickSKj
{

    public static void main(String[] args)
    {
        MaintainPickSKj ims = new MaintainPickSKj();      
//        ims.getPickSkj("201207","TPE");
//        ims.generatePickSkj("201207");
//        ims.generateGDay("201207",1,12,15,15,15,"sys");
        ims.getMonthlyDate("201207","TPE") ;
        System.out.println(ims.getObjAL().size());
    }
    
	private String sql = "";
	private ArrayList objAL = new ArrayList();
	private ArrayList skjobjAL = new ArrayList();
	
	public String getPickSkj(String yyyymm, String station) 
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
            
            sql = " SELECT * FROM fztpskj WHERE fltd BETWEEN To_Date(To_Char(To_Date('"+yyyymm+"01','yyyymmdd')-1,'yyyymm')||'01','yyyymmdd') " +
            	  " AND To_Date(To_Char(To_Date('"+yyyymm+"01','yyyymmdd')-1,'yyyymm')||'07','yyyymmdd') " +
            	  " and station = '"+station+"'  AND published = 'Y' AND (delete_flag <> 'Y' OR delete_flag IS NULL) ";           
			
//			System.out.println(sql);
			rs = stmt.executeQuery(sql);			
			while (rs.next())
			{
			    EPickSkjObj obj = new EPickSkjObj();
			    obj.setSeq(rs.getString("seq"));
			    obj.setFltd(rs.getString("fltd"));
			    obj.setWeekday(rs.getString("weekday"));
			    obj.setFltno(rs.getString("fltno"));
			    obj.setTrip_sect(rs.getString("trip_sect"));
			    obj.setFlt_length(rs.getString("flt_length"));
			    obj.setFleet(rs.getString("fleet"));
			    obj.setLongrange(rs.getString("longrange"));
			    obj.setStation(rs.getString("station"));
			    obj.setPublished(rs.getString("published"));
			    obj.setPublished_date(rs.getString("published_date"));
			    obj.setNew_user(rs.getString("new_user"));
			    obj.setNew_date(rs.getString("new_date"));
			    obj.setDelete_flag(rs.getString("delete_flag"));
			    obj.setDelete_user(rs.getString("delete_user"));
			    obj.setDelete_date(rs.getString("delete_date"));
			    obj.setChg_user(rs.getString("chg_user"));
			    obj.setChg_date(rs.getString("chg_date"));
			    obj.setPr(rs.getString("pr"));
			    obj.setFf(rs.getString("ff"));
			    obj.setFy(rs.getString("fy"));
			    obj.setFc(rs.getString("fc"));
			    obj.setMy(rs.getString("my"));
			    objAL.add(obj);    
			}
			
			for(int i=0; i<objAL.size(); i++)
			{
			    EPickSkjObj obj = (EPickSkjObj) objAL.get(i);
			    ArrayList detailAL = new ArrayList();
			    
			    sql = " SELECT seq, To_Char(fltd,'yyyy/mm/dd hh24:mi') fltd, duty, fltno, dep, arr, cd " +
			    	  " FROM fztskjd where seq = '"+obj.getSeq()+"' ORDER BY seq, fltd ";
			    rs = stmt.executeQuery(sql);			
				while (rs.next())
				{
				    EPickSkjDetailObj detailObj = new EPickSkjDetailObj();
				    detailObj.setSeq(rs.getString("seq"));
				    detailObj.setFltno(rs.getString("fltno"));
	                detailObj.setFltd(rs.getString("fltd"));
	                detailObj.setDuty(rs.getString("duty"));
	                detailObj.setDep(rs.getString("dep"));
	                detailObj.setArr(rs.getString("arr"));
	                detailObj.setCd(rs.getString("cd"));
	                detailAL.add(detailObj);
				}
				obj.setDetailAL(detailAL);
				rs.close();			    
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
	
//	public String generatePickSkj(String yyyymm, String userid) 
//	{	
//	    Connection conn = null;
//		Statement stmt = null;
//		Driver dbDriver = null;
//		ResultSet rs = null;	
//		ArrayList pickdateAL = new ArrayList();
//		ArrayList pickweekAL = new ArrayList();
//		
//		try 
//		{
//			// connection Pool
//		    ConnectionHelper ch = new ConnectionHelper();
//            conn = ch.getConnection();  
//            stmt = conn.createStatement();
//            
//            sql = " select To_Char(allday,'yyyy/mm/dd') eachdate, " +
//            	  " to_char(allday,'DY','NLS_DATE_LANGUAGE=AMERICAN') dayofweek " +
//            	  " from ( select to_date('"+yyyymm+"'||jday,'yyyymmdd') allday from fztdate " +
//            	  " WHERE jday <= To_Char(Last_Day(To_Date('"+yyyymm+"01','yyyymmdd')),'dd'))"; 
//			
////			System.out.println(sql);
//			rs = stmt.executeQuery(sql);			
//			while (rs.next())
//			{
//			    pickdateAL.add(rs.getString("eachdate"));
//			    pickdateAL.add(rs.getString("dayofweek"));			   
//			}	
//			
//			for(int j=0; j<objAL.size(); j++)
//			{
//			    EPickSkjObj obj = (EPickSkjObj) objAL.get(j);
//			    String tempdayofweek = obj.getWeekday(); 
//				for(int i=0; i<pickdateAL.size(); i++)
//				{
//				    if(tempdayofweek.equals(pickdateAL.get(i)))
//				    {
//				        EPickSkjObj nobj = new EPickSkjObj();
//				        nobj.setSeq(obj.getSeq());
//				        nobj.setFltd((String)pickdateAL.get(i));
//				        nobj.setWeekday(obj.getWeekday());
//				        nobj.setFltno(obj.getFltno());
//				        nobj.setTrip_sect(obj.getTrip_sect());
//				        nobj.setFlt_length(obj.getFlt_length());
//				        nobj.setFleet(obj.getFleet());
//				        nobj.setLongrange(obj.getLongrange());
//				        nobj.setStation(obj.getStation());
//				        nobj.setPublished("N");
//				        nobj.setNew_user(userid);
//				        nobj.setDelete_flag("N");
//				        nobj.setPr(obj.getPr());
//				        nobj.setFf(obj.getFf());
//				        nobj.setFy(obj.getFy());
//				        nobj.setFc(obj.getFc());
//				        nobj.setMy(obj.getMy());
//				        skjobjAL.add(nobj);    				    
//				    }				
//				}			
//			}
//			return "Y";
//		} 
//		catch (Exception e) 
//		{
//			return e.toString();
//		} 
//		finally 
//		{
//			if (rs != null)
//				try {
//					rs.close();
//				} catch (SQLException e) {}
//			if (stmt != null)
//				try 
//				{
//					stmt.close();
//				} catch (SQLException e) {}			
//			if (conn != null)
//				try {
//					conn.close();
//				} catch (SQLException e) {}
//		}		
//	}	
	
	public String generateGDay(String yyyymm, int pr, int ff,int fy, int fc, int my, String userid, String station) 
	{	
	    Connection conn = null;
	    PreparedStatement pstmt = null;
		Statement stmt = null;
		Driver dbDriver = null;
		ResultSet rs = null;	
		ArrayList pickdateAL = new ArrayList();
		ArrayList pickweekAL = new ArrayList();
		
		try 
		{
			// connection Pool
		    ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();  
            stmt = conn.createStatement();
            
            sql = " select To_Char(allday,'yyyy/mm/dd') eachdate, " +
            	  " to_char(allday,'DY','NLS_DATE_LANGUAGE=AMERICAN') dayofweek " +
            	  " from ( select to_date('"+yyyymm+"'||jday,'yyyymmdd') allday from fztdate " +
            	  " WHERE jday <= To_Char(Last_Day(To_Date('"+yyyymm+"01','yyyymmdd')),'dd'))"; 
			
//			System.out.println(sql);
			rs = stmt.executeQuery(sql);			
			while (rs.next())
			{
			    pickdateAL.add(rs.getString("eachdate"));
			    pickweekAL.add(rs.getString("dayofweek"));			   
			}	
			
//			System.out.println("pickdateAL = "+pickdateAL.size());
			//*****************************************************************************************
			sql = " insert into fztgday(seq,gdate,weekday,station,published,published_date,new_user,new_date," +
		      	  " delete_flag,delete_user,delete_date,chg_user,chg_date,pr,ff,fy,fc,my) values " +
		      	  " ((SELECT Nvl(Max(seq),0)+1 FROM fztgday),to_date(?,'yyyy/mm/dd'), ?, " +
		      	  " ?,'Y',sysdate,'SYS',sysdate,null,null,null,null,null,"+pr+","+ff+","+fy+","+fc+","+my+") ";
			
			pstmt = conn.prepareStatement(sql);
			
			for(int k=0; k<pickdateAL.size(); k++)
			{			    
//			    System.out.println(k);
                pstmt.setString(1, (String)pickdateAL.get(k));
                pstmt.setString(2, (String)pickweekAL.get(k));  
                pstmt.setString(3, station);  
        		pstmt.executeUpdate();			   			
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
			if (pstmt != null)
				try 
				{
					pstmt.close();
				} catch (SQLException e) {}			
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {}
		}		
	}
	
	public String getMonthlyDate(String yyyymm,String station) 
	{	
	    Connection conn = null;
	    PreparedStatement pstmt = null;
		Statement stmt = null;
		Driver dbDriver = null;
		ResultSet rs = null;	
		ArrayList pickdateAL = new ArrayList();
		ArrayList pickweekAL = new ArrayList();
		
		try 
		{
			// connection Pool
		    ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();  
            stmt = conn.createStatement();
            
            sql = " SELECT seq, To_Char(gdate,'yyyy/mm/dd') gdate, weekday, pr,ff,fy,fc,my FROM fztgday " +
            	  " where gdate between to_date('"+yyyymm+"01','yyyymmdd') and last_day(to_date('"+yyyymm+"01','yyyymmdd')) " +
            	  " and station = '"+station+"' ORDER BY gdate "; 
			
//			System.out.println(sql);
			rs = stmt.executeQuery(sql);			
			while (rs.next())
			{
			    EPickSkjObj obj = new EPickSkjObj();
			    obj.setSeq(rs.getString("seq"));
			    obj.setFltd(rs.getString("gdate"));
			    obj.setWeekday(rs.getString("weekday"));
			    obj.setPr(rs.getString("pr"));
			    obj.setFf(rs.getString("ff"));
			    obj.setFy(rs.getString("fy"));
			    obj.setFc(rs.getString("fc"));
			    obj.setMy(rs.getString("my"));
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
			if (pstmt != null)
				try 
				{
					pstmt.close();
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

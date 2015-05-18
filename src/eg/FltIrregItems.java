package eg;

import java.sql.*;
import ci.db.*;

public class FltIrregItems
{
	private Connection dbCon = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private Driver dbDriver = null;
	private String sql = "";

	public String fltirreg_item2() throws Exception{
		String ItemString = "";
		ConnDB cn = new ConnDB();
		
		try{
			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			dbCon = dbDriver.connect(cn.getConnURL(), null);
			
			sql = "select itemno, itemdsc " +
			"from egtcmpi " +
			"order by itemno";
			
			pstmt = dbCon.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				ItemString = ItemString + "<option value='"+rs.getString("itemno")+"'>"+rs.getString("itemdsc")+"</option>";
			}
			rs.close();
			pstmt.close();
			return ItemString;
		}
		catch (Exception e)
		{
			  throw e;
		}
		finally
		{
			try{if(rs != null) rs.close();}catch(SQLException e){}
			try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
			try{if(dbCon != null) dbCon.close();}catch(SQLException e){}
		}
	}
	public String fltirreg_item3() throws Exception{
		String ItemString = "";
		ConnDB cn = new ConnDB();
		
		try{
			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			dbCon = dbDriver.connect(cn.getConnURL(), null);
			
			sql = "select itemdsc " +
			      "from egtcmpd " +
			      "order by itemno, itemdsc";
			
			pstmt = dbCon.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				ItemString = ItemString + "<option value='"+rs.getString("itemdsc")+"'>"+rs.getString("itemdsc")+"</option>";
			}
			rs.close();
			pstmt.close();
			return ItemString;
		}
		catch (Exception e)
		{
			  throw e;
		}
		finally
		{
			try{if(rs != null) rs.close();}catch(SQLException e){}
			try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
			try{if(dbCon != null) dbCon.close();}catch(SQLException e){}
		}
	}
	public String fltirreg_dept() throws Exception{
		String ItemString = "";
		ConnDB cn = new ConnDB();
		
		try{
			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			dbCon = dbDriver.connect(cn.getConnURL(), null);
			
			sql = "select itemdsc from egthdli order by 1";
			
			pstmt = dbCon.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				ItemString = ItemString + "<option value='"+rs.getString("itemdsc")+"'>"+rs.getString("itemdsc")+"</option>";
			}
			rs.close();
			pstmt.close();
			return ItemString;
		}
		catch (Exception e)
		{
			  throw e;
		}
		finally
		{
			try{if(rs != null) rs.close();}catch(SQLException e){}
			try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
			try{if(dbCon != null) dbCon.close();}catch(SQLException e){}
		}
	}
}
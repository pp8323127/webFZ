/*
 * �b 2004/9/8 �إ�
 *
 * �Y�n�ܧ�o�Ӳ��ͪ��ɮת��d���A�в���
 * ���� > �ߦn�]�w > Java > �{���X���� > �{���X�M����
 */
package catii;

import ci.db.ConnDB;
import java.sql.*;
/**
 * @author cs55
 *
 * �Y�n�ܧ�o�Ӳ��ͪ����O���Ѫ��d���A�в���
 * ���� > �ߦn�]�w > Java > �{���X���� > �{���X�M����
 */
public class MatchCatiiCnt {
	private Connection con = null;
	private Statement stmt = null;
	private ResultSet rs = null;
	/*
	 public static void main(String[] args)
	    {
	     MatchCatiiCnt rd = new MatchCatiiCnt();	        
	        System.out.println(rd.getCnt("310002", "2004-10-25"));
	    }
	*/
	public int getCnt(String empno, String rdate){
		int cnt = -3;
		rdate = rdate.substring(5,10) + "-" + rdate.substring(2,4);
		try{
			//connect DA (dbf file)
	                ConnDB cn = new ConnDB();
			cn.setDBFDA();
			Class.forName(cn.getDriver());
			con = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());
			stmt = con.createStatement();
			
			rs = stmt.executeQuery("select cnt from catii where em1 = " + empno + " and rdate = {" + rdate + "}");
			if(rs.next()){
				cnt = rs.getInt("cnt");
			}
			return cnt;
		} catch(Exception e) {
			return -9; //fail
		}
		finally {
			try{if(rs != null) rs.close();}catch(SQLException e){}
		 	try{if(stmt != null) stmt.close();}catch(SQLException e){}
		 	try{if(con != null) con.close();}catch(SQLException e){}
		}
	}
}

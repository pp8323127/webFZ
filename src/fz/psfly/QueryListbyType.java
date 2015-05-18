package fz.psfly;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import ci.db.ConnDB;

public class QueryListbyType {

	/**
	 * @param args
	 */
	ArrayList objAL = null;
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}
	public String QueryList(String type ,String flsd ,String fled,String userid){

		String syy  =   flsd.substring(0,4);
		String smm  =   flsd.substring(5,7);
		String sdd  =   flsd.substring(8,10);

		String eyy  =   fled.substring(0,4);
		String emm  =   fled.substring(5,7);
		String edd  =   fled.substring(8,10);


		ConnDB cn = new ConnDB();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		Driver dbDriver = null;
		
		objAL = new ArrayList();	

		try{
			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			if(userid.equals("643937")){
				sql = "select sernno, trip,  fltno,  To_char(fltd,'yyyy/mm/dd') as fltd, acno, fleet, pursern, purname, instempno ,instname from egtstti where  sernno in (select sernno from egtstcc) and fltd between  to_date('"+flsd+"','yyyy/mm/dd') and to_date('"+fled+"','yyyy/mm/dd') order by fltd desc";
			}else{
				sql = "select sernno, trip,  fltno,  To_char(fltd,'yyyy/mm/dd') as fltd, acno, fleet, pursern, purname, instempno ,instname from egtstti where instempno = '" + userid + "' and fltd between  to_date('"+flsd+"','yyyy/mm/dd') and to_date('"+fled+"','yyyy/mm/dd') order by fltd";
			}			
			rs = stmt.executeQuery(sql);
			isNewCheckForSFLY check = new isNewCheckForSFLY();
			while(rs.next())
			{
				QueryListObj obj = new QueryListObj();
				obj.setSernno(rs.getString("sernno"));
				obj.setTrip(rs.getString("trip"));
				obj.setFltno(rs.getString("fltno"));
				obj.setFltd(rs.getString("fltd"));
				obj.setPursern(rs.getString("pursern"));
				obj.setPurname(rs.getString("purname"));
				obj.setInstempno(rs.getString("instempno"));
				obj.setInstname(rs.getString("instname"));
				obj.setAcno(rs.getString("acno"));
				obj.setFleet(rs.getString("fleet"));
				
				obj.setNew(check.checkTime("", obj.getFltd()));
				objAL.add(obj);
			}
			
		}catch(Exception e){
//			System.out.print(e.toString());
			return e.toString();
		}finally{
			try{if(rs != null) rs.close();}catch(SQLException e){}				
			try{if(stmt != null) stmt.close();}catch(SQLException e){}
			try{if(conn != null) conn.close();}catch(SQLException e){}
		}
		return "Y";
	}
	public ArrayList getObjAL() {
		return objAL;
	}
	public void setObjAL(ArrayList objAL) {
		this.objAL = objAL;
	}
	
	
}

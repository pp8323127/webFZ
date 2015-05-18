package al;

import ci.db.ConnDB;
import java.sql.*;
import al.*;

public class CheckOff
{
	private Connection con = null;
	private Statement stmt = null;
	private Statement stmt2 = null;
	private Driver dbDriver = null;
	ResultSet myResultSet = null;
	
	private String sql = null;
	
	//check offsheet
        public String doCheck(String sern)
        {
        	ConnDB cn = new ConnDB();
        	String lastoffno = null;
        	int dCount = 0;
        	
        	int lastdays = 0;
        	int thisdays = 0;
        	int nextdays = 0;
        	        	
		try{
			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			con = dbDriver.connect(cn.getConnURL(), null);
			stmt = con.createStatement();
			stmt2 = con.createStatement();
			
			//�ˬd�@�p�ɤ�������
			sql = "select offno, offdays from egtoffs where sern=" + sern + " and newdate > (sysdate - (1/24)) order by newdate";
			myResultSet = stmt.executeQuery(sql);
			while(myResultSet.next()){
				lastoffno = myResultSet.getString("offno");
				//���椣�i�p�󵥩�0�ѩΤj��30��
				if(myResultSet.getInt("offdays") <= 0 || myResultSet.getInt("offdays") > 30){
					stmt2.executeUpdate("delete egtoffs where offno='" + lastoffno + "'");
					new Loger().setCommonInfoLog("CheckOff.java", sern, "offno -- " + lastoffno + " deleted("+myResultSet.getString("offdays")+" day) !");
					dCount++;
				}
			}
			ALInfo ai = new ALInfo();
			if("0".equals(ai.setALDays(sern))){
	        		lastdays = Integer.parseInt(ai.getLastdays());
	        		thisdays = Integer.parseInt(ai.getThisdays());
	        		nextdays = Integer.parseInt(ai.getNextdays());
		        }
		        //�p�⥼�����S�𰲤ѼƤ��i�j��Ѿl�S��
		        if((lastdays + thisdays + nextdays) < (new CheckUpdateAl().getCutday(sern))){
		        	if(lastoffno != null){
		        		stmt2.executeUpdate("delete egtoffs where offno='" + lastoffno + "'");
		        		new Loger().setCommonInfoLog("CheckOff.java", sern, "offno -- " + lastoffno + " deleted(�Ѿl�S�𰲤���) !");
		        		dCount++;
		        	}
		        }
		        if(dCount > 0){
				return "-1";
			}
			else{
				return "0";
			}
		}
		catch(Exception e){
			//error
			new Loger().setErrorLog("CheckOff.java", sern, e);
			return e.toString();
		}
		finally{
			try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
			try{if(stmt != null) stmt.close();}catch(SQLException e){}
			try{if(stmt2 != null) stmt2.close();}catch(SQLException e){}
			try{if(con != null) con.close();}catch(SQLException e){}
		}
        }
}
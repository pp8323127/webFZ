package eg;

import javax.naming.*;
import javax.sql.DataSource;
import java.sql.*;
import java.io.*;
import java.util.*;
 
public class matchAL {
	private Context initContext = null;
	private DataSource ds = null;
	private Connection con = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	FileWriter fw = null;
	
	/*public static void main(String[] args) {
		matchAL mal = new matchAL
		System.out.println(mal.doMatchAL(........));
	}*/

	public String doMatchAL(String s_date, String e_date, ArrayList empno, ArrayList sern, ArrayList cname, ArrayList offsdate, ArrayList offdays, ArrayList station) {
	    	//EG AL offsheet match AirCrews
		String sql = null;
		String theday = null;
		try{
			initContext = new InitialContext();
			//connect to AOCITEST / AOCIPROD by Datasource
               		ds = (javax.sql.DataSource)initContext.lookup("CAL.FZDS03");
               		con = ds.getConnection();
               		
			fw =new FileWriter("/apsource/csap/projfz/webap/matchegal.csv", false);
			//write tital
			fw.write("Not Match " + s_date + " to " + e_date + " AL Offsheet Report\n");
			fw.write("EmpNo,SerNo,CName,Station,Date\n");
			for(int i = 0; i < empno.size(); i++){
				for(int j = 0; j < Integer.parseInt((String)offdays.get(i)); j++){
					sql = "select to_char(to_date(?,'yyyy-mm-dd') + " + j + ",'yyyy-mm-dd') from dual";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, (String)offsdate.get(i));
					rs = pstmt.executeQuery();
					if(rs.next()) theday = rs.getString(1);
					rs.close();
					pstmt.close();
					
					sql = "select count(*) " + 
					"from roster_v " + 
					"where act_str_dt between to_date('"+theday+"0000','yyyy-mm-ddHH24MI') " +
					"and to_date('"+theday+"2359','yyyy-mm-ddHH24MI') " +
					"and duty_cd = 'AL' " +
					"and delete_ind='N' " +
					"and staff_num = '"+empno.get(i)+"'";
					
					pstmt = con.prepareStatement(sql);
					rs = pstmt.executeQuery();
					if(rs.next()){
						//fw.write(rs.getString(1)+","+sql+"\n");
						if(rs.getInt(1) == 0){
							fw.write(empno.get(i)+","+sern.get(i)+","+cname.get(i)+","+station.get(i)+","+theday+"\n");
						}
					}
					try{if(rs != null) rs.close();}catch(SQLException e){}
	  				try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
				}
			}
			return "0";
		}catch(Exception e) {
			return e.toString(); //connect error or retrieve date error
		}
		finally {
			try{fw.flush();}catch(Exception e){}
		   	try{if(fw != null) fw.close();}catch(Exception e){}
			try{if(rs != null) rs.close();}catch(SQLException e){}
	  		try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
	   		try{if(con != null) con.close();}catch(SQLException e){}
		}
	}
}
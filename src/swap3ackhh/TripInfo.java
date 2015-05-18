package swap3ackhh;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * TripInfo
 * 
 * @author cs66
 * @version 1.0 2006/1/17
 * 
 * 
 * Copyright: Copyright (c) 2006
 */
public class TripInfo {

	// public static void main(String[] args) {
	// TripInfo ti = new TripInfo("378027");
	// ti.SelectData();
	// ArrayList dataAL = ti.getTripnoAL();
	// System.out.println(dataAL.size());
	// for(int i=0;i<dataAL.size();i++){
	// TripInfoObj obj = (TripInfoObj)dataAL.get(i);
	// System.out.println(obj.getFdate()+"\t"+obj.getDpt());
	// }
	// }

	private String tripno;
	private ArrayList tripnoAL;

	public TripInfo(String tripno) {
		this.tripno = tripno;
	}

	public void SelectData() {
		if (tripno == null) {
			return;
		}

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ConnDB cn = new ConnDB();
//		 ConnAOCI cna = new ConnAOCI();
		Driver dbDriver = null;


		try {
			
//			 cna.setAOCIFZUser();
//			 java.lang.Class.forName(cna.getDriver());
//			 conn = DriverManager.getConnection(cna.getConnURL() ,cna
//			 .getConnID() ,cna.getConnPW());
			 
			cn.setAOCIPRODCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			pstmt = conn
					.prepareStatement("SELECT Decode(dps.duty_cd,'TVL',floor(duration_mins*0.5), duration_mins) duration_mins, " 
							+ "dps.trip_num,To_Char(str_dt_tm_loc,'yyyy/mm/dd') fdate,"
							+ "(CASE WHEN dps.duty_cd='FLY' THEN dps.flt_num ELSE dps.duty_cd END ) duty,"
							+ "port_a dpt,port_b arv,To_Char(str_dt_tm_loc,'yyyy/mm/dd hh24:mi') btime,"
							+ "To_Char(end_dt_tm_loc,'yyyy/mm/dd hh24:mi') etime from duty_prd_seg_v dps "
							+ "WHERE  dps.series_num=?  AND dps.duty_cd NOT IN ('RST' ,'LO') "
							+ "ORDER BY duty_seq_num");

			pstmt.setString(1, tripno);
			rs = pstmt.executeQuery();
			ArrayList al = new ArrayList();
			ArrayList seriesAL = new ArrayList();
			while (rs.next()) {
				TripInfoObj obj = new TripInfoObj();
				obj.setArv(rs.getString("arv"));
				obj.setBtime(rs.getString("btime"));
				obj.setDpt(rs.getString("dpt"));
				obj.setEtime(rs.getString("etime"));
				obj.setFdate(rs.getString("fdate"));
				obj.setDuty(rs.getString("duty"));
				obj.setTripno(rs.getString("trip_num"));
				obj.setCrInMin(rs.getString("duration_mins"));

				al.add(obj);

			}
			rs.close();
			pstmt.close();

			setTripnoAL(al);
		} catch (SQLException e) {
			System.out.print(e.toString());
		} catch (Exception e) {
			System.out.print(e.toString());
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {}

		}

	}

	public ArrayList getTripnoAL() {
		if (tripno == null | "".equals(tripno)) {
			return null;
		}
		return tripnoAL;
	}

	public void setTripnoAL(ArrayList tripnoAL) {
		this.tripnoAL = tripnoAL;
	}
}
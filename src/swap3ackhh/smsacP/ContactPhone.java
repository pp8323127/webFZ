package swap3ackhh.smsacP;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * ContactPhone 後艙組員家屬聯絡電話(手機)
 * 
 * 
 * @author cs66
 * @version 1.0 2007/12/22
 * 
 * Copyright: Copyright (c) 2007
 */
public class ContactPhone {

//	public static void main(String[] args) {
//		ContactPhone cp = new ContactPhone();
//		try {
//			cp.SelectData();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		if (cp.getDataAL() != null) {
//			for (int i = 0; i < cp.getDataAL().size(); i++) {
//				ContactPhoneObj obj = (ContactPhoneObj) cp.getDataAL().get(i);
//				System.out
//						.println(obj.getEmpno() + "\t" + obj.getFirstName()
//								+ "\t" + obj.getSurName() + "\t"
//								+ obj.getPhoneNumber());
//			}
//		}

//	}

	private ArrayList dataAL;// 儲存 ContactPhoneObj

	public void SelectData() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		 ConnDB cn = new ConnDB();
		//ConnAOCI cna = new ConnAOCI();
		 Driver dbDriver = null;

		try {

			cn.setAOCIPRODCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);


			StringBuffer sb = new StringBuffer();
			sb.append("SELECT h.staff_num,surname,first_name,");
			sb.append(" contact_phone_num  ");
			sb.append("FROM crew_next_of_kin_v h,crew_rank_v k, rank_tp_v p ");
			sb.append("where p.display_rank_cd=k.rank_cd ");
			sb.append("AND h.staff_num = k.staff_num ");
			sb.append("AND p.fd_ind='N' ");
			sb.append("AND Length(contact_phone_num)=10 ");
			sb.append("AND k.eff_dt<=SYSDATE AND ");
			sb.append("(k.exp_dt IS NULL OR k.exp_dt >=SYSDATE) ");

			pstmt = conn.prepareStatement(sb.toString());
			rs = pstmt.executeQuery();
			ArrayList al = null;
			while (rs.next()) {
				if (al == null)
					al = new ArrayList();
				ContactPhoneObj obj = new ContactPhoneObj();
				obj.setEmpno(rs.getString("staff_num"));
				obj.setSurName(ci.tool.UnicodeStringParser.removeExtraEscape(rs
						.getString("surname")));
				obj.setFirstName(ci.tool.UnicodeStringParser
						.removeExtraEscape(rs.getString("first_name")));
				obj.setPhoneNumber(rs.getString("contact_phone_num"));
				al.add(obj);
			}
			setDataAL(al);
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			throw e;
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {

				}
				conn = null;
			}
		}
	}
	public ArrayList getDataAL() {
		return dataAL;
	}

	public void setDataAL(ArrayList dataAL) {
		this.dataAL = dataAL;
	}
}

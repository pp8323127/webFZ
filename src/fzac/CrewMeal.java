package fzac;

import java.sql.*;
import java.util.*;
import ci.db.*;

/**
 * CrewMeal 取得組員餐資料
 * 
 * DB: AirCrews
 * 
 * 
 * @author cs66
 * @version 1.0 2006/8/1
 * 
 * Copyright: Copyright (c) 2006
 */
public class CrewMeal {

	public static void main(String[] args) {
		CrewMeal cm = new CrewMeal();
		try {
			cm.SelectData();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("639434 的餐：" + cm.getMeal("639434"));
		System.out.println("640073 的餐：" + cm.getMeal("640073"));
	}

	private String year;
	private String month;
	private String day;
	private boolean isToday;
	private ArrayList empnoAL;
	private ArrayList mealAL;

	public CrewMeal() {
		this.isToday = true;
	}
	public CrewMeal(String year, String month, String day) {
		this.year = year;
		this.month = month;
		this.day = day;
		this.isToday = false;
	}
	public void SelectData() throws SQLException, Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ConnDB cn = new ConnDB();

		Driver dbDriver = null;

		try {

			cn.setAOCIPRODCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			if (isToday) {
				pstmt = conn.prepareStatement("SELECT staff_num, meal_type "
						+ "FROM acdba.crew_special_meals_t "
						+ "WHERE eff_fm_dt <= SYSDATE "
						+ "AND (eff_to_dt >= SYSDATE OR eff_to_dt IS NULL )");
			} else {
				pstmt = conn
						.prepareStatement("SELECT staff_num, meal_type "
								+ "FROM acdba.crew_special_meals_t "
								+ "WHERE eff_fm_dt <= to_date(?,'yyyymmdd') "
								+ "AND (eff_to_dt >= to_date(?,'yyyymmdd') OR eff_to_dt IS NULL )");
				pstmt.setString(1, year + month + day);
				pstmt.setString(2, year + month + day);
			}

			rs = pstmt.executeQuery();
			empnoAL = new ArrayList();
			mealAL = new ArrayList();
			while (rs.next()) {
				empnoAL.add(rs.getString("staff_num"));
				mealAL.add(rs.getString("meal_type"));
			}
			pstmt.close();
			rs.close();

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

	public String getMeal(String empno) {
		String meal = "";

		int index = -1;
		index = empnoAL.indexOf(empno);
		if (-1 != index) {
			meal = (String) mealAL.get(index);
		}

		return meal;
	}
}

<%@page import="ci.db.ConnAOCI"%>
<%@page import="ci.db.ConnDB"%>
<%@page contentType="text/html; charset=big5" language="java"%>
<%@page import="fz.*,java.sql.*,java.util.*,df.flypay.*"%>
<%
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
	String userid = (String) session.getAttribute("userid"); //get user id if already login
	if (session.isNew() || userid == null) { //check user session start first or not login
%>
<jsp:forward page="sendredirect.jsp" />
<%
	} else {
		if (userid.equals("643937")) {
			userid = "628542";
		}
		Driver dbDriver = null;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		String FT = "";
		String DP = "";

		try {
			/*ConnDB cn = new ConnDB();
			cn.setAOCIPRODCP();
			dbDriver = (Driver) Class.forName(cn.getDriver())
					.newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);
			stmt = conn.createStatement();*/
			//live
			ConnAOCI cna = new ConnAOCI();
			cna.setAOCIFZUser();
            java.lang.Class.forName(cna.getDriver());
            conn = DriverManager.getConnection(cna.getConnURL(),cna.getConnID(), cna.getConnPW());
            stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			sql = " select "
					+ " (TRUNC( ft/60) || ' hr: ' || TRUNC(( ft / 60 - TRUNC( ft /60) ) * 60) || ' min') showFT, "
					+ " (TRUNC( dp/60) || ' hr: ' || TRUNC(( dp / 60 - TRUNC( dp /60) ) * 60) || ' min') showDP "
					+ " from (select sum(non_std_fly_hours) ft, sum(cum_dp+act_home_stby_mins) dp  "
					+ " from crew_cum_hr_cc_v where cal_dt between sysdate-30 and sysdate and staff_num='"
					+ userid + "')";

			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				FT = rs.getString("showFT");
				DP = rs.getString("showDP");
			}
		} catch (Exception e) {
			out.println("error : " + e.toString() + sql);
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (SQLException e) {
			}
			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException e) {
			}
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
			}
		}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>個人飛時(FT),工時(DP)查詢</title>
<link href="../menu.css" rel="stylesheet" type="text/css">
<link href="menu.css" rel="stylesheet" type="text/css">
</head>
<body>
	<table width="500" border="0" align="center" cellpadding="5" cellspacing="4">
		<tr bgcolor="#EBF3FA">
			<td height="44" colspan="2">
				<div align="center" class="txttitletop">個人飛時(FT),工時(DP)查詢</div>
			</td>
		</tr>
		<tr class="tablehead2">
			<td class="txttitletop" width=50%><div align="right" class="sect">
					<div align="center">個人飛時(FT):</div>
				</div></td>
			<td class="tablehead2"><%=FT%></td>
		</tr>
		<tr class="tablehead2">
			<td class="txttitletop" width=50%><div align="right" class="sect">
					<div align="center">個人工時(DP):</div>
				</div></td>
			<td class="tablehead2"><%=DP%></td>
		</tr>
		<tr>
			<td align="center" class="txtxred" colspan="2"><br> <br>
				<span>*組員登錄日(含) 往前算29日,共30日</span> <br> <span>*組員僅能查詢自己紀錄</span>
			</td>
		</tr>
	</table>
	<%
		}
	%>
</body>
</html>

package swap3ackhh;

import java.sql.*;

import ci.db.*;

/**
 * ED處理換班申請單
 * 
 * @version 2 2007/01/06 高雄版換班
 * 
 * @author cs66 at 2005/8/10
 */
public class SwapFormConfirm {

//	 public static void main(String[] args) {
//		SwapFormConfirm sfc = new SwapFormConfirm();
//		String[] formno = {"2007010670", "2007010673"};
//		String[] confirmStatus = {"Y", "Y"};
//		String[] textComm = {"tt", "test"};
//		String[] comments = {"Agree", "Agree"};
//		String user = "640073";
//		try {
//			sfc.UpdateConfirm(formno, confirmStatus, textComm, comments, user);
//			System.out.println("是否update成功:" + sfc.isUpdSuccess());
//			if (!sfc.isUpdSuccess()) {
//				System.out.println(sfc.getErrorMessage());
//			} else {
//				System.out.println("更新成功");
//			}
//		} catch (Exception e) {
//			System.out.println(e.toString());
//		}
//	}

	private boolean updSuccess = false;
	private String errorMessage = "";

	public void UpdateConfirm(String[] formno, String[] confirmStatus,
			String[] textComm, String[] comments, String user)
			throws SQLException, Exception {

		ConnDB cn = new ConnDB();
		Connection conn = null;
		PreparedStatement pstmt = null;

		Driver dbDriver = null;

		try {

			cn.setORP3FZUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			// cn.setORT1FZUser();
			// java.lang.Class.forName(cn.getDriver());
			// conn = DriverManager.getConnection(cn.getConnURL(), "fzap",
			// "FZ921002");

			pstmt = conn
					.prepareStatement("update fztformf set ed_check=?, comments=?, "
							+ "checkuser=?, checkdate=sysdate where station='KHH' and formno=?");

			for (int i = 0; i < formno.length; i++) {
				pstmt.setString(1, confirmStatus[i].trim());
				pstmt.setString(2, (textComm[i] + comments[i]).trim());
				pstmt.setString(3, user);
				pstmt.setString(4, formno[i].trim());
				pstmt.executeUpdate();
			}

			setUpdSuccess(true);
		} catch (SQLException e) {
			errorMessage += e.toString();

		} catch (ClassNotFoundException e) {

			errorMessage += e.toString();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {
					errorMessage += e.toString();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {
					errorMessage += e.toString();
				}
		}
		setErrorMessage(errorMessage);
	}

	public boolean isUpdSuccess() {
		return updSuccess;
	}

	private void setUpdSuccess(boolean updSuccess) {
		this.updSuccess = updSuccess;
	}

	public String getErrorMessage() {
		return errorMessage;
	}

	private void setErrorMessage(String errMsg) {
		this.errorMessage = errMsg;
	}

}
package swap3ackhh;

import java.sql.*;

/**
 * 
 * RetireSwapCheck 屆退人員換班申請時數限制,換後上限為90hrs
 * 
 * 依照申請者與被換者的Prjcr及換後飛時,設定是否符合換班時數限制
 * 
 * 
 * @author cs66
 * @version 1.0 2006/5/16
 * @versino 2.0 2007/01/04 高雄版，下限為67
 * Copyright: Copyright (c) 2005
 */
public class RetireSwapCheck {
	//
//	public static void main(String[] args) {
//		RetireSwapCheck s = new RetireSwapCheck("8238", "8510", "7708", "9040");
//		s.setEmploy("593579", "593027");
//		System.out.println(s.getFlow());
//		System.out.println(s.getErrorMsg());
//	}

	private String aPrjcr;
	private String rPrjcr;
	private String aSwapCr;
	private String rSwapCr;
	private boolean aRetire = false;
	private boolean rRetire = false;
	private int aCeiling = 10000;
	private int rCeiling = 10000;
	private int flow;
	private boolean exchangeable = false;
	private String errorMsg;

	/**
	 * 判斷換班雙方,是否有一為屆退人員
	 * 
	 * @param aEmpno
	 * @param rEmpno
	 * 
	 */
	public void setEmploy(String aEmpno, String rEmpno) {
		CheckRetire cr = new CheckRetire(aEmpno);

		try {
			cr.RetrieveDate();

			if (cr.isRetire()) {

				aRetire = true;
				aCeiling = 9000;
			}

			cr = new CheckRetire(rEmpno);
			cr.RetrieveDate();
			if (cr.isRetire()) {

				rRetire = true;
				rCeiling = 9000;
			}

		} catch (ClassNotFoundException e) {

		} catch (SQLException e) {

		} catch (InstantiationException e) {

		} catch (IllegalAccessException e) {

		}
		setFlow();
	}
	public RetireSwapCheck(String aPrjcr, String rPrjcr, String aSwapCr,
			String rSwapCr) {
		this.aPrjcr = aPrjcr;
		this.rPrjcr = rPrjcr;
		this.aSwapCr = aSwapCr;
		this.rSwapCr = rSwapCr;

	}

	private void setFlow() {
		int aPr = Integer.parseInt(aPrjcr);
		int rPr = Integer.parseInt(rPrjcr);
		int aSwap = Integer.parseInt(aSwapCr);
		int rSwap = Integer.parseInt(rSwapCr);

		if (aPr > aCeiling) {
			if (rPr > rCeiling) {
				// flow = 11;
				if ((aSwap <= aPr) && (rSwap <= rPr)) {
					setExchangeable(true);
				} else {
					setErrorMsg(1);
				}

			} else if (rPr >= 6700 && rPr <= rCeiling) {
				// flow = 12;

				if (aSwap <= aPr && (rSwap >= 6700 && rSwap <= rCeiling)) {
					setExchangeable(true);
				} else {
					setErrorMsg(2);
				}
			} else if (rPr < 6700) {
				// flow = 13;
				if ((aSwap <= aPr) && (rSwap >= rPr)) {
					setExchangeable(true);
				} else {
					setErrorMsg(3);
				}

			}
		} else if (aPr >= 6700 && aPr <= aCeiling) {
			if (rPr > rCeiling) {
				// flow = 21;
				if ((aSwap >= 6700 && aSwap <= aCeiling) && (rSwap <= rPr)) {
					setExchangeable(true);
				} else {
					setErrorMsg(4);
				}

			} else if (rPr >= 6700 && rPr <= rCeiling) {
				// flow = 22;
				if ((aSwap >= 6700 && aSwap <= aCeiling)
						&& (rSwap >= 6700 && rSwap <= rCeiling)) {
					setExchangeable(true);
				} else {
					setErrorMsg(5);
				}
			} else if (rPr < 6700) {
				// flow = 23;
				if ((aSwap >= 6700 && aSwap <= aCeiling) && (rSwap >= rPr)) {
					setExchangeable(true);
				} else {
					setErrorMsg(6);
				}

			}
		} else if (aPr < 6700) {
			if (rPr > rCeiling) {
				// flow = 31;
				if ((aSwap >= aPr) && (rSwap <= rPr)) {
					setExchangeable(true);
				} else {
					setErrorMsg(7);
				}

			} else if (rPr >= 6700 && rPr <= rCeiling) {
				// flow = 32;
				if ((aSwap >= aPr) && ((rSwap >= 6700 && rSwap <= rCeiling))) {
					setExchangeable(true);
				} else {
					setErrorMsg(8);
				}
			} else if (rPr < 6700) {
				// flow = 33;
				if ((aSwap >= aPr) && (rSwap >= rPr)) {
					setExchangeable(true);
				} else {
					setErrorMsg(9);
				}
			}
		}

	}

	public int getFlow() {
		return flow;
	}

	public boolean isExchangeable() {
		return exchangeable;
	}

	private void setExchangeable(boolean exchangeable) {
		this.exchangeable = exchangeable;
	}

	private void setErrorMsg(int errorCode) {
		errorMsg = "";
		switch (errorCode) {
			case 1 :

				errorMsg = "申請者與被換者,,換後飛時均需大於或小於換前飛時.";
				break;
			case 2 :


				if (aRetire && rRetire) {
					errorMsg = "申請者需換較低時數,<br>被換者換後飛時，需介於 90 與 67 小時之間";
				} else if (aRetire) {
					errorMsg = "申請者需換較低時數,<br>被換者換後飛時，需介於 95 與 67 小時之間";
				} else if (rRetire) {
					errorMsg = "申請者需換較低時數,<br>被換者換後飛時，需介於 90 與 67 小時之間";
				} else {
					errorMsg = "申請者需換較低時數,<br>被換者換後飛時，需介於 95 與 67 小時之間";
				}

				break;
			case 3 :
				errorMsg = "申請者需換較低時數,<br>被換者需換較高時數";
				break;
			case 4 :


				if (aRetire && rRetire) {
					errorMsg = "申請者換後飛時需介於 90 與 67 小時之間.<br>被換者需換較低時數";
				} else if (aRetire) {
					errorMsg = "申請者換後飛時需介於 90 與 67 小時之間.<br>被換者需換較低時數";
				} else if (rRetire) {
					errorMsg = "申請者換後飛時需介於 95 與 67 小時之間.<br>被換者需換較低時數";
				} else {
					errorMsg = "申請者換後飛時需介於 95 與 67 小時之間.<br>被換者需換較低時數";
				}

				break;
			case 5 :
				if (aRetire && rRetire) {
					errorMsg = "申請者與被換者,換後飛時均需介於 90 與 67 小時之間.";
				} else if (aRetire) {
					errorMsg = "申請者換後飛時均需介於 90 與 67 小時之間<br>"
							+ "被換者,換後飛時均需介於 95 與 67 小時之間.";

				} else if (rRetire) {
					errorMsg = "申請者換後飛時均需介於 95 與 67 小時之間<br>"
							+ "被換者,換後飛時均需介於 90 與 67 小時之間.";
				} else {
					errorMsg = "申請者與被換者,換後飛時均需介於 95 與 67 小時之間.";
				}

				break;
			case 6 :

				if (aRetire && rRetire) {
					errorMsg = "申請者換後飛時需介於 90 與 67 小時之間.<br>被換者需換較高時數";
				} else if (aRetire) {
					errorMsg = "申請者換後飛時需介於 90 與 67 小時之間.<br>被換者需換較高時數";
				} else if (rRetire) {
					errorMsg = "申請者換後飛時需介於 95 與 67 小時之間.<br>被換者需換較高時數";
				} else {
					errorMsg = "申請者換後飛時需介於 95 與 67 小時之間.<br>被換者需換較高時數";
				}

				break;
			case 7 :
				errorMsg = "申請者需換較高時數,<br>被換者需換較低時數";
				break;
			case 8 :
				if (aRetire && rRetire) {
					errorMsg = "申請者需換較高時數,<br>被換者換後飛時，需介於 90 與 67 小時之間";
				} else if (aRetire) {
					errorMsg = "申請者需換較高時數,<br>被換者換後飛時，需介於 95 與 67 小時之間";
				} else if (rRetire) {
					errorMsg = "申請者需換較高時數,<br>被換者換後飛時，需介於 90 與 67 小時之間";
				} else {
					errorMsg = "申請者需換較高時數,<br>被換者換後飛時，需介於 95 與 67 小時之間";
				}

				break;
			case 9 :

				errorMsg = "申請者與被換者,換後飛時均需大於或等於換前飛時.";
				break;

			default :
				errorMsg = "";
				break;
		}

	}

	public String getErrorMsg() {
		return errorMsg;
	}
}
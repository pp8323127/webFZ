package swap3ackhh;

/**
 * 
 * SwapCheck ㄌ酚ビ叫籔砆传Prjcrの传,砞﹚琌才传痁计
 * 
 * 蔼动 67~95 Hrs
 * 
 * @author cs66
 * @version 1.0 2007/01/03
 * 
 * Copyright: Copyright (c) 2005
 */
public class SwapCheck {

	private String aPrjcr;
	private String rPrjcr;
	private String aSwapCr;
	private String rSwapCr;
	private int flow;
	private boolean exchangeable = false;
	private String errorMsg;

	public SwapCheck(String aPrjcr, String rPrjcr, String aSwapCr,
			String rSwapCr) {
		this.aPrjcr = aPrjcr;
		this.rPrjcr = rPrjcr;
		this.aSwapCr = aSwapCr;
		this.rSwapCr = rSwapCr;
		setFlow();
	}

	private void setFlow() {
		int aPr = Integer.parseInt(aPrjcr);
		int rPr = Integer.parseInt(rPrjcr);
		int aSwap = Integer.parseInt(aSwapCr);
		int rSwap = Integer.parseInt(rSwapCr);

		if (aPr > 9500) {
			if (rPr > 9500) {
				// flow = 11;
				if ((aSwap <= aPr) && (rSwap <= rPr)) {
					setExchangeable(true);
				} else {
					setErrorMsg(1);
				}

			} else if (rPr >= 6700 && rPr <= 9500) {
				// flow = 12;

				if (aSwap <= aPr && (rSwap >= 6700 && rSwap <= 9500)) {
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
		} else if (aPr >= 6700 && aPr <= 9500) {
			if (rPr > 9500) {
				// flow = 21;
				if ((aSwap >= 6700 && aSwap <= 9500) && (rSwap <= rPr)) {
					setExchangeable(true);
				} else {
					setErrorMsg(4);
				}

			} else if (rPr >= 6700 && rPr <= 9500) {
				// flow = 22;
				if ((aSwap >= 6700 && aSwap <= 9500)
						&& (rSwap >= 6700 && rSwap <= 9500)) {
					setExchangeable(true);
				} else {
					setErrorMsg(5);
				}
			} else if (rPr < 6700) {
				// flow = 23;
				if ((aSwap >= 6700 && aSwap <= 9500) && (rSwap >= rPr)) {
					setExchangeable(true);
				} else {
					setErrorMsg(6);
				}

			}
		} else if (aPr < 6700) {
			if (rPr > 9500) {
				// flow = 31;
				if ((aSwap >= aPr) && (rSwap <= rPr)) {
					setExchangeable(true);
				} else {
					setErrorMsg(7);
				}

			} else if (rPr >= 6700 && rPr <= 9500) {
				// flow = 32;
				if ((aSwap >= aPr) && ((rSwap >= 6700 && rSwap <= 9500))) {
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

				errorMsg = "ビ叫籔砆传,传А惠┪传玡.";
				break;
			case 2 :

				errorMsg = "ビ叫惠传耕计,<br>砆传传惠ざ 95 籔 67 ぇ丁";
				break;
			case 3 :

				errorMsg = "ビ叫惠传耕计,<br>砆传惠传耕蔼计";
				break;
			case 4 :

				errorMsg = "ビ叫传惠ざ 95 籔 67 ぇ丁.<br>砆传惠传耕计";
				break;
			case 5 :
				errorMsg = "ビ叫籔砆传,传А惠ざ 95 籔 67 ぇ丁.";
				break;
			case 6 :

				errorMsg = "ビ叫传惠ざ 95 籔 67 ぇ丁.<br>砆传惠传耕蔼计";
				break;
			case 7 :

				errorMsg = "ビ叫惠传耕蔼计,<br>砆传惠传耕计";
				break;
			case 8 :

				errorMsg = "ビ叫惠传耕蔼计,<br>砆传传惠ざ 95 籔 67 ぇ丁";
				break;
			case 9 :
				errorMsg = "ビ叫籔砆传,传А惠┪单传玡.";
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
package swap3ackhh;

/**
 * 
 * SwapCheck �̷ӥӽЪ̻P�Q���̪�Prjcr�δ��᭸��,�]�w�O�_�ŦX���Z�ɼƭ���
 * 
 * �������G 67~95 Hrs
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

				errorMsg = "�ӽЪ̻P�Q����,���᭸�ɧ��ݤj��Τp�󴫫e����.";
				break;
			case 2 :

				errorMsg = "�ӽЪ̻ݴ����C�ɼ�,<br>�Q���̴��᭸�ɡA�ݤ��� 95 �P 67 �p�ɤ���";
				break;
			case 3 :

				errorMsg = "�ӽЪ̻ݴ����C�ɼ�,<br>�Q���̻ݴ������ɼ�";
				break;
			case 4 :

				errorMsg = "�ӽЪ̴��᭸�ɻݤ��� 95 �P 67 �p�ɤ���.<br>�Q���̻ݴ����C�ɼ�";
				break;
			case 5 :
				errorMsg = "�ӽЪ̻P�Q����,���᭸�ɧ��ݤ��� 95 �P 67 �p�ɤ���.";
				break;
			case 6 :

				errorMsg = "�ӽЪ̴��᭸�ɻݤ��� 95 �P 67 �p�ɤ���.<br>�Q���̻ݴ������ɼ�";
				break;
			case 7 :

				errorMsg = "�ӽЪ̻ݴ������ɼ�,<br>�Q���̻ݴ����C�ɼ�";
				break;
			case 8 :

				errorMsg = "�ӽЪ̻ݴ������ɼ�,<br>�Q���̴��᭸�ɡA�ݤ��� 95 �P 67 �p�ɤ���";
				break;
			case 9 :
				errorMsg = "�ӽЪ̻P�Q����,���᭸�ɧ��ݤj��ε��󴫫e����.";
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
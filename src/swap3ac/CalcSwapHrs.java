package swap3ac;

import java.util.*;

import ci.tool.*;

/**
 * �iAirCrews�������j <br>
 * CalcSwapHrs �p�⴫�Z�ɼơB����t�B��
 * 
 * @author cs66
 * @version 1.0 2006/01/10
 * 
 * Copyright: Copyright (c) 2005
 */
public class CalcSwapHrs {

	// public static void main(String[] args) {
	// CalcSwapHrs c = new CalcSwapHrs();
	// System.out.println(c.getTotalMin(null));
	// }

	private ArrayList aSkjAL;
	private ArrayList rSkjAL;
	private CrewInfoObj aCrewObj;
	private CrewInfoObj rCrewObj;
	private String[] aSwapCr;// �ӽЪ̧󴫪�CR,�C�ӥ��Ȥ@��
	private String[] rSwapCr;// �Q���̧󴫪�CR,�C�ӥ��Ȥ@��
	private String aCrAfterSwap;// �ӽЪ� �����`����
	private String rCrAfterSwap;// �Q���� �����`����
	private String aSwapDiffCr;// �ӽЪ� ���᭸�ɮt�B
	private String rSwapDiffCr;// �Q���� ���᭸�ɮt�B
	private String aSwapTotalCr;// �ӽЪ� �`������
	private String rSwapTotalCr;// �Q���� �`������
	private ArrayList aSwapSkjAL;// �ӽЪ� �󴫪��Z��
	private ArrayList rSwapSkjAL;// �Q���� �󴫪��Z��
	private int aAlCr =0;// �ӽЪ� ���al credit hours(mins)
	private int rAlCr =0;// �Q���� ���al credit hours(mins)

	/**
	 * @param aSkjAL
	 *            �ӽЪ̪��Z��
	 * @param rSkjAL
	 *            �Q���̪��Z��
	 */
	public void setCrewSkj(ArrayList aSkjAL, ArrayList rSkjAL) {
		this.aSkjAL = aSkjAL;
		this.rSkjAL = rSkjAL;
	}

	public void setCrewInfo(CrewInfoObj aCrewObj, CrewInfoObj rCrewObj) {
		this.aCrewObj = aCrewObj;
		this.rCrewObj = rCrewObj;
	}

	/**
	 * @param aSkj
	 *            �ӽЪ̧󴫪��Z(index)
	 * @param rSkj
	 *            �Q���̧󴫪��Z(index) ���o�Ŀ�󴫯Z��CR
	 */
	public boolean setSwapSkj(String[] aSwapSkjIdx, String[] rSwapSkjIdx) {
		if (aSkjAL == null && rSkjAL == null) 
		{
			return false;
		} 
		else 
		{
			try 
			{
				if (aSwapSkjIdx == null) 
				{
					aSwapCr = null;
				} 
				else 
				{
					aSwapSkjAL = new ArrayList();
					aSwapCr = new String[aSwapSkjIdx.length];
					for (int i = 0; i < aSwapCr.length; i++) 
					{
						CrewSkjObj obj = (CrewSkjObj) aSkjAL.get(Integer.parseInt(aSwapSkjIdx[i]));
						if(!"AL".equals(obj.getDutycode()))
						{
						    aSwapCr[i] = obj.getCr();
						}
						else
						{
						    aSwapCr[i] = "0000";
						    aAlCr = aAlCr+120;
						    
						}
						aSwapSkjAL.add(obj);
					}
				}
			} 
			catch (IndexOutOfBoundsException e) 
			{
				aSwapCr = null;
			}

			try 
			{
				if (rSwapSkjIdx == null) 
				{
					rSwapCr = null;
				} 
				else 
				{
					rSwapSkjAL = new ArrayList();
					rSwapCr = new String[rSwapSkjIdx.length];
					for (int i = 0; i < rSwapCr.length; i++) 
					{
						CrewSkjObj obj = (CrewSkjObj) rSkjAL.get(Integer.parseInt(rSwapSkjIdx[i]));
						if(!"AL".equals(obj.getDutycode()))
						{
						    rSwapCr[i] = obj.getCr();
						}
						else
						{
						    rSwapCr[i] = "0000";
						    rAlCr = rAlCr+120;
						}
						rSwapSkjAL.add(obj);
					}
				}
			} 
			catch (IndexOutOfBoundsException e) 
			{
				rSwapCr = null;
			}

			return true;
		}

	}

	public void CalcHr() 
	{
		int aSwapMin = 0;
		int rSwapMin = 0;
//		aSwapMin = Integer.parseInt(TimeUtil.hhmmToMin(aCrewObj.getPrjcr()))
//				+ getTotalMin(rSwapCr) - getTotalMin(aSwapCr);
//
//		rSwapMin = Integer.parseInt(TimeUtil.hhmmToMin(rCrewObj.getPrjcr()))
//				+ getTotalMin(aSwapCr) - getTotalMin(rSwapCr);
		
		aSwapMin = Integer.parseInt(TimeUtil.hhmmToMin(aCrewObj.getPrjcr()))
				+ getTotalMin(rSwapCr) - getTotalMin(aSwapCr) - aAlCr;

		rSwapMin = Integer.parseInt(TimeUtil.hhmmToMin(rCrewObj.getPrjcr()))
				+ getTotalMin(aSwapCr) - getTotalMin(rSwapCr) - rAlCr;

		setACrAfterSwap(TimeUtil.minToHHMM(Integer.toString(aSwapMin)));
		setRCrAfterSwap(TimeUtil.minToHHMM(Integer.toString(rSwapMin)));
	}

	public boolean job(CrewInfoObj aCrewObj, CrewInfoObj rCrewObj,
			ArrayList aSkjAL, ArrayList rSkjAL, String[] aSwapSkjIdx,
			String[] rSwapSkjIdx) 
	{
		if (aSwapSkjIdx == null && rSwapSkjIdx == null) 
		{
			return false;
		} 
		else 
		{
			setCrewSkj(aSkjAL, rSkjAL);
			setCrewInfo(aCrewObj, rCrewObj);
			setSwapSkj(aSwapSkjIdx, rSwapSkjIdx);
			CalcHr();
			setSwaptotalCr(aSwapCr, rSwapCr);
			setTotalSwapCr(aSwapCr, rSwapCr);
			return true;
		}

	}

	/**
	 * @param hhmmArray
	 * @return �NHHMM�}�C�ഫ������
	 */
	public int getTotalMin(String[] hhmmArray) 
	{
		int min = 0;
		if (hhmmArray == null) 
		{
			min = 0;
		} 
		else 
		{
			for (int i = 0; i < hhmmArray.length; i++) 
			{
				min += Integer.parseInt(TimeUtil.hhmmToMin(hhmmArray[i]));
			}
		}
		return min;
	}

	private void setSwaptotalCr(String[] aSwapCr, String[] rSwapCr) 
	{

		if (getTotalMin(rSwapCr) > getTotalMin(aSwapCr)) 
		{
			aSwapDiffCr = TimeUtil.minToHHMM(Integer.toString(getTotalMin(rSwapCr) - getTotalMin(aSwapCr)));
			rSwapDiffCr = "-" + aSwapDiffCr;
		} 
		else if (getTotalMin(rSwapCr) < getTotalMin(aSwapCr)) 
		{
			rSwapDiffCr = TimeUtil.minToHHMM(Integer.toString(getTotalMin(aSwapCr) - getTotalMin(rSwapCr)));
			aSwapDiffCr = "-" + rSwapDiffCr;
		} 
		else 
		{
			aSwapDiffCr = "0000";
			rSwapDiffCr = "0000";
		}
	}

	private void setTotalSwapCr(String[] aSwapCr, String[] rSwapCr) 
	{
		if (aSwapCr == null) 
		{
			aSwapTotalCr = "0000";
		} 
		else 
		{
			aSwapTotalCr = TimeUtil.minToHHMM(Integer.toString(getTotalMin(aSwapCr)));
		}

		if (rSwapCr == null) 
		{
			rSwapTotalCr = "0000";
		} 
		else 
		{
			rSwapTotalCr = TimeUtil.minToHHMM(Integer.toString(getTotalMin(rSwapCr)));
		}

	}	

	private void setACrAfterSwap(String crAfterSwap) {
		aCrAfterSwap = crAfterSwap;
	}

	private void setRCrAfterSwap(String crAfterSwap) {
		rCrAfterSwap = crAfterSwap;
	}

	public String getACrAfterSwap() {
		return aCrAfterSwap;
	}

	public String getRCrAfterSwap() {
		return rCrAfterSwap;
	}

	public String getASwapDiffCr() {
		return aSwapDiffCr;
	}

	public String getRSwapDiffCr() {
		return rSwapDiffCr;
	}

	public String getASwapTotalCr() {
		return aSwapTotalCr;
	}

	public String getRSwapTotalCr() {
		return rSwapTotalCr;
	}

	public ArrayList getASwapSkjAL() {
		return aSwapSkjAL;
	}

	public ArrayList getRSwapSkjAL() {
		return rSwapSkjAL;
	}
}
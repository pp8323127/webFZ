package ws.crew;

import java.util.*;

public class CrewSwapDetailRObj extends CrewSwapRObj
{

    public CrewSwapDetailRObj()
    {
        super();
        // TODO Auto-generated constructor stub
    }
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
    
    private int aTimes = 0;
    private int rTimes = 0;
    
    private int type = 0;
//  3�� TPE:1 
//  3�� KHH:2
//  �n�I TPE:3,4
//  �n�I KHH:5   
    
    public int getType()
    {
        return type;
    }
    public void setType(int type)
    {
        this.type = type;
    }
    public String getaCrAfterSwap()
    {
        return aCrAfterSwap;
    }
    public void setaCrAfterSwap(String aCrAfterSwap)
    {
        this.aCrAfterSwap = aCrAfterSwap;
    }
    public String getrCrAfterSwap()
    {
        return rCrAfterSwap;
    }
    public void setrCrAfterSwap(String rCrAfterSwap)
    {
        this.rCrAfterSwap = rCrAfterSwap;
    }
    public String getaSwapDiffCr()
    {
        return aSwapDiffCr;
    }
    public void setaSwapDiffCr(String aSwapDiffCr)
    {
        this.aSwapDiffCr = aSwapDiffCr;
    }
    public String getrSwapDiffCr()
    {
        return rSwapDiffCr;
    }
    public void setrSwapDiffCr(String rSwapDiffCr)
    {
        this.rSwapDiffCr = rSwapDiffCr;
    }
    public String getaSwapTotalCr()
    {
        return aSwapTotalCr;
    }
    public void setaSwapTotalCr(String aSwapTotalCr)
    {
        this.aSwapTotalCr = aSwapTotalCr;
    }
    public String getrSwapTotalCr()
    {
        return rSwapTotalCr;
    }
    public void setrSwapTotalCr(String rSwapTotalCr)
    {
        this.rSwapTotalCr = rSwapTotalCr;
    }
    public ArrayList getaSwapSkjAL()
    {
        return aSwapSkjAL;
    }
    public void setaSwapSkjAL(ArrayList aSwapSkjAL)
    {
        this.aSwapSkjAL = aSwapSkjAL;
    }
    public ArrayList getrSwapSkjAL()
    {
        return rSwapSkjAL;
    }
    public void setrSwapSkjAL(ArrayList rSwapSkjAL)
    {
        this.rSwapSkjAL = rSwapSkjAL;
    }
    public int getaAlCr()
    {
        return aAlCr;
    }
    public void setaAlCr(int aAlCr)
    {
        this.aAlCr = aAlCr;
    }
    public int getrAlCr()
    {
        return rAlCr;
    }
    public void setrAlCr(int rAlCr)
    {
        this.rAlCr = rAlCr;
    }
    public int getaTimes()
    {
        return aTimes;
    }
    public void setaTimes(int aTimes)
    {
        this.aTimes = aTimes;
    }
    public int getrTimes()
    {
        return rTimes;
    }
    public void setrTimes(int rTimes)
    {
        this.rTimes = rTimes;
    }
    
    
}

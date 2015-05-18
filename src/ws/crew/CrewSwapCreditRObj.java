package ws.crew;

import credit.*;

public class CrewSwapCreditRObj extends CrewSwapRObj
{
    
    public CrewSwapCreditRObj()
    {
        super();
        // TODO Auto-generated constructor stub
    }
    //是否有積點資格
    private int aEmpnoAvb = 0;//1:積點
    private int rEmpnoAvb = 0;//1:積點, 2:三次
    //<CreditObj>
    private CreditObj[] aCrewCtAr = null;
    private CreditObj[] rCrewCtAr = null;
    
    
    public int getaEmpnoAvb()
    {
        return aEmpnoAvb;
    }
    public void setaEmpnoAvb(int aEmpnoAvb)
    {
        this.aEmpnoAvb = aEmpnoAvb;
    }
    public int getrEmpnoAvb()
    {
        return rEmpnoAvb;
    }
    public void setrEmpnoAvb(int rEmpnoAvb)
    {
        this.rEmpnoAvb = rEmpnoAvb;
    }
    public CreditObj[] getaCrewCtAr()
    {
        return aCrewCtAr;
    }
    public void setaCrewCtAr(CreditObj[] aCrewCtAr)
    {
        this.aCrewCtAr = aCrewCtAr;
    }
    public CreditObj[] getrCrewCtAr()
    {
        return rCrewCtAr;
    }
    public void setrCrewCtAr(CreditObj[] rCrewCtAr)
    {
        this.rCrewCtAr = rCrewCtAr;
    }

    
    
    
    
}

package ws.crew;

import ws.*;
import credit.*;

public class CrewPickCreditRObj extends CrewMsgObj
{
    
    public CrewPickCreditRObj()
    {
        super();
        // TODO Auto-generated constructor stub
    }
    //<CreditObj>
    private CreditObj[] crewCtAr = null;

    public CreditObj[] getCrewCtAr()
    {
        return crewCtAr;
    }

    public void setCrewCtAr(CreditObj[] crewCtAr)
    {
        this.crewCtAr = crewCtAr;
    }
    
    
}

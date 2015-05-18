package ws.crew;

import ws.*;
import credit.*;

public class CrewPickFullAttRObj extends CrewMsgObj
{

    
    public CrewPickFullAttRObj()
    {
        super();
        // TODO Auto-generated constructor stub
    }

    FullAttendanceForPickSkjObj[] CrewAttAr = null;

    public FullAttendanceForPickSkjObj[] getCrewAttAr()
    {
        return CrewAttAr;
    }

    public void setCrewAttAr(FullAttendanceForPickSkjObj[] crewAttAr)
    {
        CrewAttAr = crewAttAr;
    }

    

    
    
}

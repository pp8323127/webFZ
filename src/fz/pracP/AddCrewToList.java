package fz.pracP;

import java.util.*;

import fzac.*;

/**
 * AddCrewToList �s�W��Z�խ� <br>
 * DB: AriCrews
 * 
 * 
 * @author cs66
 * @version 1.0 2006/2/23
 * 
 * Copyright: Copyright (c) 2006
 */
public class AddCrewToList {

    public static void main(String[] args) {
    }

    private ArrayList crewObjList;

    public AddCrewToList(ArrayList crewObjList) {
        this.crewObjList = crewObjList;
    }

    public void addCrew(String sern) {
        CrewInfo c = new CrewInfo(sern);
        CrewInfoObj o = c.getCrewInfo();
        crewObjList.add(o);
    }

    public ArrayList getCrewObjList() {
        return crewObjList;
    }
}
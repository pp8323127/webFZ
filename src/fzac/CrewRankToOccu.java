package fzac;


/**
 * CrewRankToOccu Âà´« aircrews rank_CD to FZ occu
 *  
 * 
 * 
 * @author cs66
 * @version 1.0 2007/1/2
 * 
 * Copyright: Copyright (c) 2007
 */
public class CrewRankToOccu {
	public static String getOccu(String crewRank){ 
		String occu = "";
		if("MF".equals(crewRank) | "MC".equals(crewRank)| "MY".equals(crewRank)){
			occu = "FA";
		}else if("FF".equals(crewRank) | "FC".equals(crewRank)| "FY".equals(crewRank)){
			occu = "FS";
		}else{			
			occu = crewRank;
		}
		return occu;
	}
}

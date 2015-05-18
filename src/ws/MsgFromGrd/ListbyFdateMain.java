package ws.MsgFromGrd;

import java.util.ArrayList;

import ws.header.*;
import ws.prac.*;

public class ListbyFdateMain {
	public ListbyFdateRObj getListbyFdate(String fdate,String rank,String fltno,String sect){
		ListbyFdateFun ls = new ListbyFdateFun();
		ls.getShowList(fdate, rank, fltno, sect);
		return ls.cObj;
	}
	public String[] getRankCode(){
		ListbyFdateFun ls = new ListbyFdateFun();
		return ls.showRank();		
	}
	public InfoByPNR_RObj getInfoFromPNR(String userid ,String PNR){
	    InfoByPNRfun pnr = new InfoByPNRfun();
	    pnr.getPNRinfo(userid, PNR);
	    return pnr.PNRObj;
	}
	public NotesMailRObj getListofNotes(String sysPwd){
	    boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        NotesMailFun notes = new NotesMailFun();
        if(wsAuth){    	    
    	    notes.getNotesMail();
        }else{
            notes.noteMailObj = new NotesMailRObj();
            notes.noteMailObj.setResultMsg("0");
            notes.noteMailObj.setErrorMsg("No Auth");
        }
	    return notes.noteMailObj;
	    
	}
	
	public NotesMailRObj getListofNotesSita(String sitaCode,String sysPwd){
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        NotesMailFun notes = new NotesMailFun();
        if(wsAuth){         
            notes.getNotesMail(sitaCode);
        }else{
            notes.noteMailObj = new NotesMailRObj();
            notes.noteMailObj.setResultMsg("0");
            notes.noteMailObj.setErrorMsg("No Auth");
        }
        return notes.noteMailObj;
        
    }
	
	public NotesMailRObj getSitaCode(String sysPwd){
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        NotesMailFun notes = new NotesMailFun();
        if(wsAuth){         
            notes.getSitaCode();
        }else{
            notes.noteMailObj = new NotesMailRObj();
            notes.noteMailObj.setResultMsg("0");
            notes.noteMailObj.setErrorMsg("No Auth");
        }
        return notes.noteMailObj;
        
    }
}

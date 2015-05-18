package ws.prac.PA;

import java.util.ArrayList;

import fz.pracP.pa.EvaluationType;
import fz.pracP.pa.EvaluationTypeObj;
import fz.pracP.pa.PACrewEvalData;
import fz.pracP.pa.PACrewEvalObj;

public class PA {

	public PAEvalItemRObj paItemObj = null;
	public PAEvalCrewRObj paCrewObj = null;
	
    public void getPAEvalItem(){
    	//取得PA考評項目、敘述
    	EvaluationType evalType = new EvaluationType();
    	ArrayList evalTypeAL = evalType.getDataAL();
    	try
    	{
    		paItemObj = new PAEvalItemRObj();
    		if(evalTypeAL.size()>0){
    		EvaluationTypeObj[] arrayType = new EvaluationTypeObj[evalTypeAL.size()];    		
	    		for(int i=0; i<evalTypeAL.size();i++){
	    			arrayType[i] = (EvaluationTypeObj )evalTypeAL.get(i);
	    		}
	    		paItemObj.setTypeObj(arrayType);
	    		paItemObj.setResultMsg("1");
    		}else{
    			paItemObj.setErrorMsg("N0 date!");
    			paItemObj.setResultMsg("0");
    		}
    	}catch(Exception e){
    		paItemObj.setErrorMsg(e.toString());
    		paItemObj.setResultMsg("0");
    	}
    }
    
    public void getPACrewData(String fdate,String fltno,String sect ,String empno){
    	//取得PA考評資料
    	PACrewEvalData paData = new PACrewEvalData(fdate,fltno,sect,empno);
    	ArrayList evalScoreDataAL = null;
    	try
    	{
        	paCrewObj = new PAEvalCrewRObj();
    		paData.SelectData();
    		evalScoreDataAL = paData.getDataAL();
    		
    		if(evalScoreDataAL.size()>0){
    		PACrewEvalObj[] arrayCrew = new PACrewEvalObj[evalScoreDataAL.size()];
	    		for(int i=0; i<evalScoreDataAL.size();i++){
	    			arrayCrew[i] = (PACrewEvalObj )evalScoreDataAL.get(i);
	    		}
	    		paCrewObj.setPaCrewObj(arrayCrew);
	    		paCrewObj.setResultMsg("1");
    		}else{
    			paCrewObj.setErrorMsg("No Data!");
    			paCrewObj.setResultMsg("0");
    		}
    		
    	}catch(Exception e){
    		paCrewObj.setErrorMsg(e.toString());
    		paCrewObj.setResultMsg("0");
    	}
    }
    
}

package ws.prac.ZC;

import java.util.ArrayList;

import fz.pracP.zc.*;



public class ZC {

	public ZcEvalItemRObj zcItemObj = null;
	public ZcEvalCrewRObj zcCrewObj = null;
	
	 public void getZCEvalItem(){
		//取得ZC考評項目、敘述
		 EvaluationType evalType = new EvaluationType();
		 ArrayList evalTypeAL = evalType.getDataAL();
	    	try
	    	{
	    		zcItemObj = new ZcEvalItemRObj();
	    		if(evalTypeAL.size()>0){
	    		EvaluationTypeObj[] arrayType = new EvaluationTypeObj[evalTypeAL.size()];    		
		    		for(int i=0; i<evalTypeAL.size();i++){
		    			arrayType[i] = (EvaluationTypeObj )evalTypeAL.get(i);
		    		}
		    		zcItemObj.setTypeObj(arrayType);
		    		zcItemObj.setResultMsg("1");
	    		}else{
	    			zcItemObj.setErrorMsg("N0 date!");
	    			zcItemObj.setResultMsg("0");
	    		}
	    	}catch(Exception e){
	    		zcItemObj.setErrorMsg(e.toString());
	    		zcItemObj.setResultMsg("0");
	    	}
	    }
	    
	    public void getZCCrewData(String fdate,String fltno,String sect ,String empno){
	    	//取得ZC考評資料
	    	fz.pracP.zc.ZoneChiefEvalData zcData = new fz.pracP.zc.ZoneChiefEvalData(fdate,fltno,sect,empno);
	    	ArrayList evalScoreDataAL = null;
	    	try
	    	{
	    		zcCrewObj = new ZcEvalCrewRObj();
	    		zcData.SelectData();
	    		evalScoreDataAL = zcData.getDataAL();
	    		
	    		if(evalScoreDataAL.size()>0){
	    		ZoneChiefEvalObj[] arrayCrew = new ZoneChiefEvalObj[evalScoreDataAL.size()];
		    		for(int i=0; i<evalScoreDataAL.size();i++){
		    			arrayCrew[i] = (ZoneChiefEvalObj )evalScoreDataAL.get(i);
		    		}
		    		zcCrewObj.setZcCrewObj(arrayCrew);
		    		zcCrewObj.setResultMsg("1");
	    		}else{
	    			zcCrewObj.setErrorMsg("No Data!");
	    			zcCrewObj.setResultMsg("0");
	    		}
	    		
	    	}catch(Exception e){
	    		zcCrewObj.setErrorMsg(e.toString());
	    		zcCrewObj.setResultMsg("0");
	    	}
	    }
}

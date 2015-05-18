package ws.prac.PA;

import java.util.ArrayList;

import fz.pracP.pa.EvaluationType;
import fz.pracP.pa.EvaluationTypeObj;
import fz.pracP.pa.PACrewEvalData;
import fz.pracP.pa.PACrewEvalObj;

public class PAFun {

	public PAEvalItemRObj paItemObj = null;
	public PAEvalCrewRObj paCrewObj = null;
	
    public void getPAEvalItem(){
    	//取得PA考評項目、敘述
    	EvaluationType evalType = new EvaluationType();
    	ArrayList evalTypeAL = evalType.getDataAL();
    	ArrayList tempAL = new ArrayList();
    	try
    	{
    		paItemObj = new PAEvalItemRObj();
    		if(evalTypeAL.size()>0){
    		EvaluationTypeObj[] arrayType = new EvaluationTypeObj[evalTypeAL.size()];    		
	    		for(int i=0; i<evalTypeAL.size();i++){
	    			arrayType[i] = (EvaluationTypeObj )evalTypeAL.get(i);
	    			int type = Integer.parseInt(arrayType[i].getScoreType());
	    			switch (type) {
					case 2:
						tempAL.add(type+"/中文");
						tempAL.add(type+"/英文");
						tempAL.add(type+"/台語");
						tempAL.add(type+"/清晰");
						tempAL.add(type+"/須加強");
						break;
					case 3:
						tempAL.add(type+"/重點訊息表達");
						tempAL.add(type+"/善用Falling Pitch");
						tempAL.add(type+"/未表達重點");
						tempAL.add(type+"/未善用Falling Pitch");
						tempAL.add(type+"/語氣太重");
						break;
					case 4:
						tempAL.add(type+"/流利");
						tempAL.add(type+"/自然");
						tempAL.add(type+"/不急不徐");
						tempAL.add(type+"/稍快");
						tempAL.add(type+"/熟悉度不足");
						break;
					case 5:
						tempAL.add(type+"/按廣播內容正確表達情感");
						tempAL.add(type+"/音量剛好");
						tempAL.add(type+"/Mic 技巧不好");
						tempAL.add(type+"/音量太小");	
						tempAL.add(type+"/聲音未開");	
						break;
					case 6:
						tempAL.add(type+"/誠懇");
						tempAL.add(type+"/用心");
						tempAL.add(type+"/Individual Attention");
						tempAL.add(type+"/機械性");
						tempAL.add(type+"/情感不足");
						break;
					default:
						break;
					}
	    			/*
	    			if(tempAL.size() > 0){
		    			String[] Arraytemp = new String[tempAL.size()];
		    			for(int j=0; j<tempAL.size();j++){
		    				Arraytemp[j] = (String)tempAL.get(j);
		    			}	 
		    		    paItemObj.setTempObj(Arraytemp);   			
	    			}	 */
	    		}
	    		paItemObj.setTempObj(tempAL);
	    		paItemObj.setTypeObj(arrayType);
	    		paItemObj.setResultMsg("1");
    		}else{
    			paItemObj.setErrorMsg("N0 date!");
    			paItemObj.setResultMsg("1");
    		}
    	}catch(Exception e){
    		paItemObj.setErrorMsg(e.toString());
    		paItemObj.setResultMsg("0");
    	}
    }
    
    public void getPACrewData(String fdate,String fltno,String sect ,String empno){
    	//取得PA考評資料
    	PACrewEvalData paData = new PACrewEvalData(fdate,fltno,sect,empno);
    	ArrayList evalScoreDataAL = new ArrayList();
    	try
    	{
        	paCrewObj = new PAEvalCrewRObj();
    		paData.SelectData();
    		evalScoreDataAL = paData.getDataAL();
    		
    		if(evalScoreDataAL!=null && evalScoreDataAL.size()>0){
    		PACrewEvalObj[] arrayCrew = new PACrewEvalObj[evalScoreDataAL.size()];
	    		for(int i=0; i<evalScoreDataAL.size();i++){
	    			arrayCrew[i] = (PACrewEvalObj )evalScoreDataAL.get(i);
	    		}
	    		paCrewObj.setPaCrewObj(arrayCrew);
	    		paCrewObj.setResultMsg("1");
    		}else{
    			paCrewObj.setErrorMsg("No Data!");
    			paCrewObj.setResultMsg("1");
    		}
    		
    	}catch(Exception e){
    		paCrewObj.setErrorMsg(e.toString());
    		paCrewObj.setResultMsg("0");
    	}
    }
    
}

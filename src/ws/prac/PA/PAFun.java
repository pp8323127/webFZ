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
    	//���oPA�ҵ����ءB�ԭz
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
						tempAL.add(type+"/����");
						tempAL.add(type+"/�^��");
						tempAL.add(type+"/�x�y");
						tempAL.add(type+"/�M��");
						tempAL.add(type+"/���[�j");
						break;
					case 3:
						tempAL.add(type+"/���I�T����F");
						tempAL.add(type+"/����Falling Pitch");
						tempAL.add(type+"/����F���I");
						tempAL.add(type+"/������Falling Pitch");
						tempAL.add(type+"/�y��ӭ�");
						break;
					case 4:
						tempAL.add(type+"/�y�Q");
						tempAL.add(type+"/�۵M");
						tempAL.add(type+"/���椣�}");
						tempAL.add(type+"/�y��");
						tempAL.add(type+"/���x�פ���");
						break;
					case 5:
						tempAL.add(type+"/���s�����e���T��F���P");
						tempAL.add(type+"/���q��n");
						tempAL.add(type+"/Mic �ޥ����n");
						tempAL.add(type+"/���q�Ӥp");	
						tempAL.add(type+"/�n�����}");	
						break;
					case 6:
						tempAL.add(type+"/����");
						tempAL.add(type+"/�Τ�");
						tempAL.add(type+"/Individual Attention");
						tempAL.add(type+"/�����");
						tempAL.add(type+"/���P����");
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
    	//���oPA�ҵ����
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

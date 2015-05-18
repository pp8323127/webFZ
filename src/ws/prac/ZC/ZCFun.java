package ws.prac.ZC;

import java.util.*;

import fz.pracP.zc.*;



public class ZCFun {
    /**
     * @param args
     */
	public ZcEvalItemRObj zcItemObj = null;
	public ZcEvalCrewRObj zcCrewObj = null;
	

    public static void main(String[] args)
    {

    }
    
	//CM取得ZC考評項目、敘述
	public void getZCEvalItem(){
	
		 EvaluationType evalType = new EvaluationType();
		 ArrayList evalTypeAL = evalType.getDataAL();
	     ArrayList tempAL = new ArrayList();
	    	try
	    	{
	    		zcItemObj = new ZcEvalItemRObj();
	    		if(evalTypeAL.size()>0){
	    		EvaluationTypeObj[] arrayType = new EvaluationTypeObj[evalTypeAL.size()];    		
		    		for(int i=0; i<evalTypeAL.size();i++){
		    			arrayType[i] = (EvaluationTypeObj )evalTypeAL.get(i);
		    			int type = Integer.parseInt(arrayType[i].getScoreType());
		    			switch (type) {
		    			case 1://領導統御 
							tempAL.add(type+"/具組織力與決斷力");
							tempAL.add(type+"/溝通協調能力佳");
							tempAL.add(type+"/判斷力與決斷力不足");
							tempAL.add(type+"/缺乏溝通技巧");
							break;
						case 2://團隊合作
							tempAL.add(type+"/善用人物資源");
							tempAL.add(type+"/團隊工作績效佳");
							tempAL.add(type+"/自我意識強、無法善用人物資源");
							tempAL.add(type+"/團隊工作績效差");
							break;
						case 3://作業認知
							tempAL.add(type+"/具客艙安全作業職能");
							tempAL.add(type+"/落實服務程序");
							tempAL.add(type+"/判斷力與決斷力不足");
							tempAL.add(type+"/缺乏溝通技巧");
							break;
						case 4://顧客導向
							tempAL.add(type+"/能掌握旅客資訊");
							tempAL.add(type+"/能滿足顧客期待");
							tempAL.add(type+"/無法正確掌握旅客資訊");
							tempAL.add(type+"/缺乏服務熱忱");
							break;
						case 5://語言能力
							tempAL.add(type+"/外語表達能力佳");
							tempAL.add(type+"/表達能力佳、掌握溝通技巧");
							tempAL.add(type+"/外語表達能力弱");
							tempAL.add(type+"/表達、應對須加強");	
							break;
						case 6://情感模式
							tempAL.add(type+"/情緒管理佳");
							tempAL.add(type+"/具同理心、具親和力");
							tempAL.add(type+"/情緒管理須加強");
							tempAL.add(type+"/冷淡、不易融入人群");
							break;
						case 7://危機處理
                            tempAL.add(type+"/從容應變、事件掌控能力佳");
                            tempAL.add(type+"/警覺性高");
                            tempAL.add(type+"/慌亂、缺乏應變能力");
                            tempAL.add(type+"/情境警覺不足");
                            break;
						case 8://外顯行為
                            tempAL.add(type+"/服儀整潔");
                            tempAL.add(type+"/笑容親切、謙恭有禮");
                            tempAL.add(type+"/缺乏笑容");
                            tempAL.add(type+"/服儀不符儀容規定");
                            tempAL.add(type+"/態度散漫、紀律不足");
                            break;
						case 9://人格特質
                            tempAL.add(type+"/樂觀進取");
                            tempAL.add(type+"/認真負責");
                            tempAL.add(type+"/投機取巧");
                            tempAL.add(type+"/察言觀色、進退有節");
                            tempAL.add(type+"/無法信賴");
                            break;
						case 10://專業素養
                            tempAL.add(type+"/跨部作業整合能力佳");
                            tempAL.add(type+"/具飛航安全相關知識");
                            tempAL.add(type+"/具空服專業知識");
                            tempAL.add(type+"/服務技巧純熟");
                            tempAL.add(type+"/跨部作業整合能力薄弱");
                            tempAL.add(type+"/缺乏飛航安全知識");
                            tempAL.add(type+"/空服專業知識不足");
                            tempAL.add(type+"/服務技巧不足");
                            break;
						default:
							break;
						}
		    		}

		    		zcItemObj.setTempObj(tempAL);
		    		zcItemObj.setTypeObj(arrayType);
		    		zcItemObj.setResultMsg("1");
	    		}else{
	    			zcItemObj.setErrorMsg("N0 date!");
	    			zcItemObj.setResultMsg("1");
	    		}
	    	}catch(Exception e){
	    		zcItemObj.setErrorMsg(e.toString());
	    		zcItemObj.setResultMsg("0");
	    	}
	    }
	//CM取得ZC考評資料 
    public void getZCCrewData(String fdate,String fltno,String sect ,String empno){
    	
        fz.pracP.zc.ZoneChiefEvalData zcData = new fz.pracP.zc.ZoneChiefEvalData(fdate,fltno,sect,empno);
        ArrayList evalScoreDataAL = null;
        try
        {
        	zcCrewObj = new ZcEvalCrewRObj();
        	zcData.SelectData();
        	evalScoreDataAL = zcData.getDataAL();
        	
        	if(evalScoreDataAL!= null && evalScoreDataAL.size()>0){
        	ZoneChiefEvalObj[] arrayCrew = new ZoneChiefEvalObj[evalScoreDataAL.size()];
        		for(int i=0; i<evalScoreDataAL.size();i++){
        			arrayCrew[i] = (ZoneChiefEvalObj )evalScoreDataAL.get(i);
        		}
        		zcCrewObj.setZcCrewObj(arrayCrew);
        		zcCrewObj.setResultMsg("1");
        	}else{
        		zcCrewObj.setErrorMsg("No Data!");
        		zcCrewObj.setResultMsg("1");
        	}
        	
        }catch(Exception e){
        	zcCrewObj.setErrorMsg(e.toString());
        	zcCrewObj.setResultMsg("0");
    	}
    }

   
}

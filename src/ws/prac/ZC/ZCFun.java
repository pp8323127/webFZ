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
    
	//CM���oZC�ҵ����ءB�ԭz
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
		    			case 1://��ɲαs 
							tempAL.add(type+"/���´�O�P�M�_�O");
							tempAL.add(type+"/���q��կ�O��");
							tempAL.add(type+"/�P�_�O�P�M�_�O����");
							tempAL.add(type+"/�ʥF���q�ޥ�");
							break;
						case 2://�ζ��X�@
							tempAL.add(type+"/���ΤH���귽");
							tempAL.add(type+"/�ζ��u�@�Z�Ĩ�");
							tempAL.add(type+"/�ۧڷN�ѱj�B�L�k���ΤH���귽");
							tempAL.add(type+"/�ζ��u�@�Z�Įt");
							break;
						case 3://�@�~�{��
							tempAL.add(type+"/��ȿ��w���@�~¾��");
							tempAL.add(type+"/����A�ȵ{��");
							tempAL.add(type+"/�P�_�O�P�M�_�O����");
							tempAL.add(type+"/�ʥF���q�ޥ�");
							break;
						case 4://�U�ȾɦV
							tempAL.add(type+"/��x���ȫȸ�T");
							tempAL.add(type+"/�ມ���U�ȴ���");
							tempAL.add(type+"/�L�k���T�x���ȫȸ�T");
							tempAL.add(type+"/�ʥF�A�ȼ���");
							break;
						case 5://�y����O
							tempAL.add(type+"/�~�y��F��O��");
							tempAL.add(type+"/��F��O�ΡB�x�����q�ޥ�");
							tempAL.add(type+"/�~�y��F��O�z");
							tempAL.add(type+"/��F�B���ﶷ�[�j");	
							break;
						case 6://���P�Ҧ�
							tempAL.add(type+"/�����޲z��");
							tempAL.add(type+"/��P�z�ߡB��˩M�O");
							tempAL.add(type+"/�����޲z���[�j");
							tempAL.add(type+"/�N�H�B�����ĤJ�H�s");
							break;
						case 7://�M���B�z
                            tempAL.add(type+"/�q�e���ܡB�ƥ�x����O��");
                            tempAL.add(type+"/ĵı�ʰ�");
                            tempAL.add(type+"/�W�áB�ʥF���ܯ�O");
                            tempAL.add(type+"/����ĵı����");
                            break;
						case 8://�~��欰
                            tempAL.add(type+"/�A�����");
                            tempAL.add(type+"/���e�ˤ��B������§");
                            tempAL.add(type+"/�ʥF���e");
                            tempAL.add(type+"/�A�����Ż��e�W�w");
                            tempAL.add(type+"/�A�״����B���ߤ���");
                            break;
						case 9://�H��S��
                            tempAL.add(type+"/���[�i��");
                            tempAL.add(type+"/�{�u�t�d");
                            tempAL.add(type+"/�������");
                            tempAL.add(type+"/��[��B�i�h���`");
                            tempAL.add(type+"/�L�k�H��");
                            break;
						case 10://�M�~���i
                            tempAL.add(type+"/�󳡧@�~��X��O��");
                            tempAL.add(type+"/�㭸��w����������");
                            tempAL.add(type+"/��ŪA�M�~����");
                            tempAL.add(type+"/�A�ȧޥ��¼�");
                            tempAL.add(type+"/�󳡧@�~��X��O���z");
                            tempAL.add(type+"/�ʥF����w������");
                            tempAL.add(type+"/�ŪA�M�~���Ѥ���");
                            tempAL.add(type+"/�A�ȧޥ�����");
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
	//CM���oZC�ҵ���� 
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

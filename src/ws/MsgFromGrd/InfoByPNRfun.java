package ws.MsgFromGrd;

import java.util.ArrayList;
import java.util.regex.Pattern;

import tool.splitString;

import eg.mvc.ConnectionUtility;

public class InfoByPNRfun {

    /**
     * @param args
     */
    InfoByPNR_RObj PNRObj = null;
    
    public static void main(String[] args) {
        // TODO Auto-generated method stub
        InfoByPNRfun i = new InfoByPNRfun();
        i.getPNRinfo("", "K8UIM8");
        System.out.println("done");
        i.getPNRinfo("", "K3GIK4");
//        System.out.println("done");
//        i.getPNRinfo("", "K62M6D");
//        System.out.println("done");
//        i.getPNRinfo("", "K5F47W");
//        i.getPNRinfo("", "KGIT5U");//訂位已取消
//        i.getPNRinfo("", "KE3L4Y");//ALCS已經Purge
        System.out.println("done");
        
    }
    
    public void getPNRinfo(String userid,String PNR){
//        String hostResponse="            
//               *** ELECTRONIC TICKET ISSUED ***\n\n" +
//              "***   G5 MASK AD HOC PNR    ***\n" +
//              "  1.  1HOSONO/IZUMIMS   2.  1HOSONO/MATSUHIROMR\n" +
//              "  3.  1HOSONO/NANAKOMISS   4.  1HOSONO/CHIKAKOMISS\n" +
//              "  5.  1MATSUKAWA/NAOEMS   6.  1TSUBOI/MASAYAMR\n" +
//              "  7.  1YAMAUCHI/MEGUMIMS   8.  1MOCHIZUKI/MARIEMS\n" +
//              "  9.  1ISHIBASHI/JUNMS  10.  1SATO/YURIMS\n" +
//              " 11.  1NAKAMURA/TOMOMIMS  12.  1YANAI/TOMOYOMS\n" +
//              ")>";           
//      String hostResponse = 
//              " 1 CI  101 G  25AUG NRTTPE HK52 1430 1710/E *7 | S Y CABIN\n" +
//              " 2 CI 2771 G  25AUG TPEDPS HK52 2010 0115/E *7 | S Y CABIN\n" +
//              " IN DPS 0113/0123\n" +
//              " 3 CI 2772 G  29AUG DPSTPE HK52 0215 0735/E *4 | S Y CABIN\n" +
//              " 4 CI  100 G  29AUG TPENRT HK52 0855 1305/E *4 | S Y CABIN\n";
        String hostResponse = "";
//        String alcs_session = "MVCPNR01";//live
        String alcs_sine_code ="BSIA8155CS/PD";//live        
        ConnectionUtility myConnector = new ConnectionUtility();
        InfoByPNRfun info = null;
        PNRObj = new InfoByPNR_RObj();

//        myConnector.setUser(userid);
        myConnector.setsession();
//        myConnector.setsession(alcs_session);
        myConnector.setdoconnect();
        myConnector.setdata("UR");
        myConnector.setdata(alcs_sine_code);
        myConnector.setdata("W.23/64"); //調正格式
        myConnector.setdata("*"+PNR);  
        hostResponse = myConnector.getdata();
//        System.out.println(hostResponse);        
        
        if(hostResponse.contains("NO ITIN")){
        	PNRObj.setResultMsg("0");
            PNRObj.setErrorMsg("訂位已取消.");
//            System.out.println("訂位已取消");
        }else if(hostResponse.contains("INVALID FILE REFERENCE")){
        	PNRObj.setResultMsg("0");
            PNRObj.setErrorMsg("Purge.");
//            System.out.println("Purge");
        }else{ 
        	//***針對姓名**************************************
        	myConnector.setdata("*N"); 
        	hostResponse = myConnector.getdata();
//        	System.out.println(hostResponse);//第一頁               
	        int page = 1; 
	        hostResponse= hostResponse.trim();//去頭尾空白,取")",進入下一頁
	//        System.out.println(hostResponse.substring(hostResponse.length()-2,hostResponse.length()-1)+"****末行****");
	        while(hostResponse.substring(hostResponse.length()-2,hostResponse.length()-1).equals(")")){
	            myConnector.setdata("MD");
	            page ++;
	            //先去掉末"(>"
	            hostResponse = hostResponse.substring(0,hostResponse.length()-2);           
	            //加入下頁內容
	            hostResponse += myConnector.getdata();
	            if(page > 5){
	                break;
	            }
	        }      
//        System.out.println(hostResponse);//全部       
        	//---------------------------------------------
            info= new InfoByPNRfun();
            //取name        
            ArrayList spiltNameAL = info.getName(hostResponse);
            if(spiltNameAL.size() > 0){
                String[] arrayN = new String[spiltNameAL.size()];
                for(int k=0; k < spiltNameAL.size();k++){
                    arrayN[k] = (String)spiltNameAL.get(k); 
                }
                PNRObj.setHeadCount(spiltNameAL.size());
                PNRObj.setName(arrayN);
                PNRObj.setResultMsg("1");
                //***針對flt**************************************
                myConnector.setdata("*I");
                hostResponse = myConnector.getdata();
//                System.out.print(hostResponse);         
                //取fltno 
                ArrayList spiltFltAL = info.getFltInfo(hostResponse);
//                System.out.println(spiltFltAL.size());
                if(spiltFltAL.size() > 0){
                    InfoByPNRObj[] arrayFlt = new InfoByPNRObj[spiltFltAL.size()];
                    for(int k=0; k < spiltFltAL.size();k++){
                        arrayFlt[k] = (InfoByPNRObj)spiltFltAL.get(k); 
                    }
                    PNRObj.setFltObj(arrayFlt);
                    PNRObj.setResultMsg("1");
                }else{
                    PNRObj.setResultMsg("0");
                    PNRObj.setErrorMsg("NO data of Flt.");
                }
            	//***針對flt end**************************************
            }else{
                PNRObj.setResultMsg("0");
                PNRObj.setErrorMsg("NO data of Name.");
            }
        	
//        	System.out.println("正常");
        }
        
        //close
        myConnector.endDoconnect();
    }
    
    public ArrayList getName(String hostResponse){
        splitString p = null;//切割
        String tempName = "";//存Name String
        ArrayList objAL_local = new ArrayList(); //個別Name AL
        
        //取得response, 存入tempName
        if(hostResponse.length()>0){                      
            p = new splitString();
            ArrayList strResAL = p.doSplit2(hostResponse,"\n");
            for(int i=0; i < strResAL.size(); i++){
                //去表頭
                if(((String)strResAL.get(i)).indexOf(">")<0 && strResAL.get(i).toString().contains(".")){
                    tempName += strResAL.get(i).toString().replaceAll("[\\d\\s]","").trim(); //去掉數字 ,前後空白                   
                }               
            }
//          System.out.println(tempName);
        }    
        //取得旅客姓名 , 存入AL
        if(tempName.length() > 0){
            p = new splitString();
//            int a = 0;
            ArrayList strNameAL = p.doSplit2(tempName,".");
            for(int i=0; i < strNameAL.size(); i++){
//              System.out.println(strNameAL.get(i));
                if(!objAL_local.contains(strNameAL.get(i)) && !strNameAL.get(i).equals("")){//去掉重複
                objAL_local.add(strNameAL.get(i));
//                a++;
              System.out.println(":"+strNameAL.get(i));
                }
            }
        }     
        return objAL_local;
    }
    
    public ArrayList getFltInfo(String hostResponse){
        splitString p = null;//切割
        String tempInfo = "";//
        ArrayList objAL_local = new ArrayList(); //個別item AL
        //切行
        if(hostResponse.length()>0){                      
            p = new splitString();
            ArrayList strResAL = p.doSplit2(hostResponse,"\n");
            for(int i=0; i < strResAL.size(); i++){
                if(strResAL.get(i).toString().contains("CI")){
                    tempInfo = strResAL.get(i).toString().substring(0,26).trim().replaceAll("  "," ");//留單空白,去前後空白
//                  System.out.println(tempInfo);
                    if(tempInfo.length() > 0){
                        //切空白
                        InfoByPNRObj obj = new InfoByPNRObj();
                        obj.setFltInfo(tempInfo);//整段訊息
                        ArrayList fltInfoAL = p.doSplit2(tempInfo, " ");
                        for(int j=0;j<fltInfoAL.size();j++){
//                          System.out.println(fltInfoAL.get(j));
//                          1 CI 101 G 25AUG NRTTPE
                            switch(j){
                                case 2:
                                    obj.setFltno(fltInfoAL.get(j).toString());//fltno
                                    break;
                                case 4:
                                    obj.setFltd(fltInfoAL.get(j).toString());//日期
                                    break;
                                case 5:
                                    obj.setSect(fltInfoAL.get(j).toString());//航段
                                    break;
                            }//switch
                        }//for j
                        objAL_local.add(obj);   
                    }//tempInfo.length() 
                }//strResAL.get(i).toString().contains("CI")
            }//for i
            
        }    
        return objAL_local;
    }
}

package ws;

import java.util.*;
import eg.mvc.ConnectionUtility;

public class testALCS
{
    public static void main(String[] args) {
        // TODO Auto-generated method stub
        String hostResponse = "";
//      String alcs_session = "MVCPNR01";//live
      String alcs_sine_code ="BSIA8155CS/PD";//live        
      ConnectionUtility myConnector = new ConnectionUtility();

//      myConnector.setUser(userid);
      myConnector.setsession();
//      myConnector.setsession(alcs_session);
      myConnector.setdoconnect();
      myConnector.setdata("UR");
      myConnector.setdata(alcs_sine_code);
//      myConnector.setdata("W.23/64"); //調正格式
      myConnector.setdata("LDCI0008/29OCTTPELAX-D");//可看整班班機訂位
//      myConnector.setdata("*AL0000000");  //全部
      hostResponse = myConnector.getdata();
//      System.out.println(hostResponse);        
      
     
      //***針對姓名**************************************
//      myConnector.setdata("*N"); 
      hostResponse = myConnector.getdata();
      System.out.println(hostResponse);//第一頁               
      int page = 1; 
      hostResponse= hostResponse.trim();//去頭尾空白,取")",進入下一頁
//      System.out.println(hostResponse.substring(hostResponse.length()-2,hostResponse.length()-1)+"****末行****");
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
//      System.out.println(hostResponse);//全部       
      
      System.out.println("正常");
      
      
      //close
      myConnector.endDoconnect();
      System.out.println("close");
    }
}

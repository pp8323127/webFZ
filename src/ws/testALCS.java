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
//      myConnector.setdata("W.23/64"); //�ե��榡
      myConnector.setdata("LDCI0008/29OCTTPELAX-D");//�i�ݾ�Z�Z���q��
//      myConnector.setdata("*AL0000000");  //����
      hostResponse = myConnector.getdata();
//      System.out.println(hostResponse);        
      
     
      //***�w��m�W**************************************
//      myConnector.setdata("*N"); 
      hostResponse = myConnector.getdata();
      System.out.println(hostResponse);//�Ĥ@��               
      int page = 1; 
      hostResponse= hostResponse.trim();//�h�Y���ť�,��")",�i�J�U�@��
//      System.out.println(hostResponse.substring(hostResponse.length()-2,hostResponse.length()-1)+"****����****");
      while(hostResponse.substring(hostResponse.length()-2,hostResponse.length()-1).equals(")")){
          myConnector.setdata("MD");
          page ++;
          //���h����"(>"
          hostResponse = hostResponse.substring(0,hostResponse.length()-2);           
          //�[�J�U�����e
          hostResponse += myConnector.getdata();
          if(page > 5){
              break;
          }
      }      
//      System.out.println(hostResponse);//����       
      
      System.out.println("���`");
      
      
      //close
      myConnector.endDoconnect();
      System.out.println("close");
    }
}

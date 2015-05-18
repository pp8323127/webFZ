package comx.wrox.cars;

import java.net.*;
import java.io.*;
import java.util.*;
import java.io.Serializable;

public class ConnectionUtility implements Serializable 
{
    public static void main(String[] args)
    {
//      sckClient = new Socket(DEFAULT_SERVER_IP,DEFAULT_SERVER_PORT);
        //sckClient.setSoTimeout(sckTimeout);
        String test = "",hostResponse="";
        ConnectionUtility myConnector = new ConnectionUtility();
        myConnector.setsession("TPEZZ300");
        myConnector.setdata("UR");
        myConnector.setdata("BSA");
        myConnector.setdata("BSIA6356TM/PD");
        myConnector.setdata("UC");
        myConnector.setdata("*CI0052/22MAR/SYD");
        myConnector.setdata("@P/VC");   
        
//        myConnector.setsession("TPEZZ300");
//        myConnector.setdata("UR");
//        myConnector.setdata("BSA");
//        myConnector.setdata("BSIA6356TM/PD");
//        myConnector.setdata("UC");
//        myConnector.setdata("PMLCI0052/22MARSYD");
//        myConnector.setdata("@P/VC"); 
        hostResponse = myConnector.getdata();
        System.out.println(hostResponse);
    }

//�D�����(IP,Port Number,CRN Name,EOM)
  private final String DEFAULT_SERVER_IP = "192.168.23.2";   //Specific IP Address : 192.168.23.2
  //private final int DEFAULT_SERVER_PORT = 4021;            //Specific Port Number : 4021 (For ALCSTEST)
  //private final int DEFAULT_SERVER_PORT = 4035;              //Specific Port Number : 4035 (For ALCSPRE)
  //(PC9220)private int DEFAULT_SERVER_PORT = 4036;            //Specific Port Number : 4036 (For ALCSLIVE)
  private int DEFAULT_SERVER_PORT = 4042;                    //(PC9220)change connection port number from 4036 to 4042(WEBSERC2) in case interacting with other applications   
  private String sCRNForDSP = "";                            //CRN for DSP session
  private String sEOM = "+";                                 //EOM used by CI host

//Socket���
  private String serverIP = DEFAULT_SERVER_IP;
  private int serverPort = DEFAULT_SERVER_PORT;
  private Socket sckClient = null;
  int sckTimeout = 0;                                   //Infinite Timeout

//inputStream & outputStream
  private DataInputStream dataIn;
  private DataOutputStream dataOut;
  private BufferedReader br;
  private BufferedWriter bw;

//Relevant variables
  private String strRtn = "error";
  private boolean connector = true;
  private String connectOK = "Connect OK";
  private String connectFail = "Connect failed";
  private String Sean = "Didn't catch any thing!";
  private String rtnLineHeader = null;
  private char WUS=35,ctrlN=21,LF=10,space=37,end=43,ACK=109,sp=65,separatorFromHost=124,separatorForASCII=35,nulla=0;

//strat
  public ConnectionUtility()
  {
         //Because JavaBeans has to use empty constructor
  }

  public void setsession (String CRN)
  {
      sCRNForDSP = CRN;
  }
  public String getsession ()
  {
      return sCRNForDSP;
  }
  public void setport (int port)
  {
      DEFAULT_SERVER_PORT = port; 	 
  }	
  public int getport ()
  {
      return DEFAULT_SERVER_PORT;
  }
  public void setdoconnect (String entry)
  {
    /*
    try {
       	  InetAddress myLocalHost = InetAddress.getLocalHost();
	  System.out.println(myLocalHost);
        } catch (java.net.UnknownHostException e)
	{
	  System.out.println("�L�k���oIP��}");
	}
    */ 	
    /*
    try{

      s1 = new Socket(DEFAULT_SERVER_IP,DEFAULT_SERVER_PORT);
      s1.setSoTimeout(readTimeout);
      dataIn=new Datainputstream(new BufferedInputStream(s1.getInputStream()));
      dataOut=new DataOutputStream(new BufferedOutputStream(s1.getOutputStream()));
    }
    catch (IOException io){
      connector = !connector;
    }
    */

  }

  public String getDoconnect()
  {
        if (connector)
          return connectOK;
        else
          return connectFail;
  }

  public String getdata()
  {
      return strRtn;
  }

  public void setdata(String entry)
  {
    String rtnLine = "",rtnLine1 = "";
    
    try
    {
          //sckClient = new Socket(DEFAULT_SERVER_IP,DEFAULT_SERVER_PORT);
          //sckClient.setSoTimeout(sckTimeout);
          dataIn=new DataInputStream(new BufferedInputStream(sckClient.getInputStream()));
          dataOut=new DataOutputStream(new BufferedOutputStream(sckClient.getOutputStream()));
          //sckClient.setReceiveBufferSize(400); 

          //System.out.println("getReceiveBufferSize"+sckClient.getReceiveBufferSize());
          Date timeOfServerEntry = new Date();
//          System.out.println("["+sCRNForDSP+"]");
//          System.out.println("[ENTRY]("+timeOfServerEntry.toString()+"):");
//          System.out.println(entry);
          dataOut.writeUTF(sCRNForDSP+entry+sEOM);
          dataOut.flush();
          
          int iTimeOut_seconds = 60; //�D��RESPONSE�W�L60��N�^�Ŧr�굹APPLICATION�èq "Host response time out!"
          int iElapseTime = 0;
          String CRNInResponse = "";
                   
          while(iElapseTime<=iTimeOut_seconds*10)                      //while (�b���ݮɶ�����)  
          {                       
             if(dataIn.available()>0)
             {                                //�����ƤF
                int iBufferSize = dataIn.available();                 //��y���٦��h�֭�byte����ƥi�HŪ��
                byte [] bytReadBuffer = new byte[iBufferSize];        //�ŧi�@��byte array�x�s�ó]�w���j�p  
                int iRcvBytes = 0;                                    
                int tempiRcvBytes = 0;
             
                dataIn.skip(2);                                       //�o���b�קK�D���^�Ъ���l Response �� Length (In Header)�Q�զ��@�Ӥ���r�A
                iBufferSize=iBufferSize-2;                            //�y���n�R���D���e����Header�ɺI��u���һݭnResponse���Ĥ@�Ӧr�C
             
                do
                {                                                   //�P�_�æ������
                   //System.out.println("tempiRcvBytes Before"+tempiRcvBytes); 
                   tempiRcvBytes = dataIn.read(bytReadBuffer,iRcvBytes,iBufferSize-iRcvBytes);
                   //System.out.println("tempiRcvBytes After"+tempiRcvBytes);
                   iRcvBytes = iRcvBytes + tempiRcvBytes;   
                   rtnLine = rtnLine + new String(bytReadBuffer);
                }while(tempiRcvBytes<iBufferSize);                  
             
//                System.out.println("%%%%");
//                System.out.println(rtnLine);
//                System.out.println("%%%%");            
                
                CRNInResponse = rtnLine.substring(0,8);               //��쥿�T��l���       
                if(CRNInResponse.equals(sCRNForDSP))                  //���쥿�T�� Response
                {                 
                   rtnLine = rtnLine.substring(10);                   //�h���Y��� bytes �� Gabbage �H��8�� bytes �� CRN name�C
                   rtnLine = rtnLine.replace(ctrlN,LF);
                   rtnLine = rtnLine.replace(space,LF);
                   //rtnLine = rtnLine.replace(space,nulla);
                   //rtnLine = rtnLine.replace(end,LF);
                   rtnLine = rtnLine.replace(end,nulla);
                   Date timeOfServerResponse1 = new Date();
//                   System.out.println("");
//                   System.out.println("[RESPONSE]("+timeOfServerResponse1.toString()+"):");
//                   System.out.println(rtnLine);
                   break;                                             //���}�^��
                }
                else
                {
                   rtnLine = "";                                      //�M��
                }      
             }
             Thread.sleep(100);                                       //timer
             iElapseTime+=1;
//             System.out.print(">");
             if(iElapseTime>iTimeOut_seconds*10)
             {
             	Date timeOfServerTimeout = new Date();
//                System.out.println("");
//                System.out.println("[RESPONSE]("+timeOfServerTimeout.toString()+"):");
//                System.out.println("Host Response Timeout(Over "+iTimeOut_seconds+" Seconds)!");
                rtnLine = "";                                         //web application�����ۦ�B�z�Ǧ^�Ŧr�걡�p(�D���b"iTimeOut_seconds"���������^��)
                break;                                                //���}�^��
             }
          }                                                           //end while  
          //IATCI Response Handling
          if(rtnLine.indexOf("*** EDI PROCESSING ***") != -1)         //IATCI Response Handling
          {        
             iElapseTime = 0;                                         //reset timer
             
             while(iElapseTime<=iTimeOut_seconds*10)
             {                    //while (�b���ݮɶ�����)     
                if(dataIn.available()>0)
                {                                //�����ƤF
                   int iBufferSize = dataIn.available();                 //��y���٦��h�֭�byte����ƥi�HŪ��
                   byte [] bytReadBuffer = new byte[iBufferSize];        //�ŧi�@��byte array�x�s�ó]�w���j�p  
                   int iRcvBytes = 0;                                    
                   int tempiRcvBytes = 0;
             
                   dataIn.skip(2);                                       //�o���b�קK�D���^�Ъ���l Response �� Length (In Header)�Q�զ��@�Ӥ���r�A
                   iBufferSize=iBufferSize-2;                            //�y���n�R���D���e����Header�ɺI��u���һݭnResponse���Ĥ@�Ӧr�C
             
                   do
                   {                                                   //�P�_�æ������
                      //System.out.println("tempiRcvBytes Before"+tempiRcvBytes); 
                      tempiRcvBytes = dataIn.read(bytReadBuffer,iRcvBytes,iBufferSize-iRcvBytes);
                      //System.out.println("tempiRcvBytes After"+tempiRcvBytes);
                      iRcvBytes = iRcvBytes + tempiRcvBytes;   
                      rtnLine1 = rtnLine1 + new String(bytReadBuffer);
                   }while(tempiRcvBytes<iBufferSize);                  

                   CRNInResponse = rtnLine1.substring(0,8);               //��쥿�T��l���       
                   if(CRNInResponse.equals(sCRNForDSP))
                   {                 //���쥿�T�� Response
                      rtnLine1 = rtnLine1.substring(10);                   //�h���Y��� bytes �� Gabbage �H��8�� bytes �� CRN name�C
                      rtnLine1 = rtnLine1.replace(ctrlN,LF);
                      rtnLine1 = rtnLine1.replace(space,LF);
                      //rtnLine1 = rtnLine1.replace(end,LF);
                      rtnLine1 = rtnLine1.replace(end,nulla);
                      rtnLine = rtnLine.substring(0,23);
                      Date timeOfServerResponse1 = new Date();
//                      System.out.println("");
//                      System.out.println("[RESPONSE OF EDI PROCESSING]("+timeOfServerResponse1.toString()+"):");
//                      System.out.println(rtnLine1);
                      break;                                             //���}�^��
                   }
                   else
                   {
                      rtnLine1 = "";                                      //�M��
                   }      
                }
                Thread.sleep(100);                                       //timer
                iElapseTime+=1;
//                System.out.print(">");
                if(iElapseTime>iTimeOut_seconds*10)
                {
                   Date timeOfServerTimeout = new Date();
//                   System.out.println("");
//                   System.out.println("[RESPONSE OF EDI PROCESSING]("+timeOfServerTimeout.toString()+"):");
//                   System.out.println("Host Response Timeout(Over "+iTimeOut_seconds+" Seconds)!");
                   rtnLine1 = "";                                         //web application�����ۦ�B�z�Ǧ^�Ŧr�걡�p(�D���b"iTimeOut_seconds"���������^��)
                   break;                                                //���}�^��
                }
             }                                                           //end while 
          }                                                              //end if(EDI PROCESSING)
          strRtn = rtnLine+rtnLine1;
          dataIn.close();
          dataOut.close();
      }
      catch (Exception E)
      {
          Date timeOfServerException1 = new Date();
//          System.out.println("");
//          System.err.println("[EXCEPTION]["+timeOfServerException1.toString()+"]:");
//          System.err.println(E);
          rtnLine = rtnLine.replace(ctrlN,LF);
          rtnLine = rtnLine.replace(space,LF);
          rtnLine = rtnLine.replace(end,LF);
          strRtn = "";                                                //�Ǧ^�Ŧr��
      }
      finally
      {
          try
          {
              if(sckClient != null)
              {
                  sckClient.close();                                  //�����P�D�����s�u
              }    
          }
          catch(Exception exp)
          {
              Date timeOfServerException2 = new Date();
//              System.out.println("");
//              System.out.println("[EXCEPTION OF CLOSING SOCKET]("+timeOfServerException2.toString()+"):");
//              System.err.println(exp);
              strRtn = "";                                            //�Ǧ^�Ŧr��
          }
      }
  }
}


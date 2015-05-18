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

//主機資料(IP,Port Number,CRN Name,EOM)
  private final String DEFAULT_SERVER_IP = "192.168.23.2";   //Specific IP Address : 192.168.23.2
  //private final int DEFAULT_SERVER_PORT = 4021;            //Specific Port Number : 4021 (For ALCSTEST)
  //private final int DEFAULT_SERVER_PORT = 4035;              //Specific Port Number : 4035 (For ALCSPRE)
  //(PC9220)private int DEFAULT_SERVER_PORT = 4036;            //Specific Port Number : 4036 (For ALCSLIVE)
  private int DEFAULT_SERVER_PORT = 4042;                    //(PC9220)change connection port number from 4036 to 4042(WEBSERC2) in case interacting with other applications   
  private String sCRNForDSP = "";                            //CRN for DSP session
  private String sEOM = "+";                                 //EOM used by CI host

//Socket資料
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
	  System.out.println("無法取得IP位址");
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
          
          int iTimeOut_seconds = 60; //主機RESPONSE超過60秒就回空字串給APPLICATION並秀 "Host response time out!"
          int iElapseTime = 0;
          String CRNInResponse = "";
                   
          while(iElapseTime<=iTimeOut_seconds*10)                      //while (在等待時間之內)  
          {                       
             if(dataIn.available()>0)
             {                                //收到資料了
                int iBufferSize = dataIn.available();                 //串流中還有多少個byte的資料可以讀取
                byte [] bytReadBuffer = new byte[iBufferSize];        //宣告一個byte array儲存並設定的大小  
                int iRcvBytes = 0;                                    
                int tempiRcvBytes = 0;
             
                dataIn.skip(2);                                       //這兩行在避免主機回覆的原始 Response 的 Length (In Header)被組成一個中文字，
                iBufferSize=iBufferSize-2;                            //造成要刪掉主機前面的Header時截到真正所需要Response的第一個字。
             
                do
                {                                                   //判斷並收齊資料
                   //System.out.println("tempiRcvBytes Before"+tempiRcvBytes); 
                   tempiRcvBytes = dataIn.read(bytReadBuffer,iRcvBytes,iBufferSize-iRcvBytes);
                   //System.out.println("tempiRcvBytes After"+tempiRcvBytes);
                   iRcvBytes = iRcvBytes + tempiRcvBytes;   
                   rtnLine = rtnLine + new String(bytReadBuffer);
                }while(tempiRcvBytes<iBufferSize);                  
             
//                System.out.println("%%%%");
//                System.out.println(rtnLine);
//                System.out.println("%%%%");            
                
                CRNInResponse = rtnLine.substring(0,8);               //抓到正確原始資料       
                if(CRNInResponse.equals(sCRNForDSP))                  //收到正確的 Response
                {                 
                   rtnLine = rtnLine.substring(10);                   //去掉頭兩個 bytes 的 Gabbage 以及8個 bytes 的 CRN name。
                   rtnLine = rtnLine.replace(ctrlN,LF);
                   rtnLine = rtnLine.replace(space,LF);
                   //rtnLine = rtnLine.replace(space,nulla);
                   //rtnLine = rtnLine.replace(end,LF);
                   rtnLine = rtnLine.replace(end,nulla);
                   Date timeOfServerResponse1 = new Date();
//                   System.out.println("");
//                   System.out.println("[RESPONSE]("+timeOfServerResponse1.toString()+"):");
//                   System.out.println(rtnLine);
                   break;                                             //離開回圈
                }
                else
                {
                   rtnLine = "";                                      //清空
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
                rtnLine = "";                                         //web application必須自行處理傳回空字串情況(主機在"iTimeOut_seconds"秒之內未有回應)
                break;                                                //離開回圈
             }
          }                                                           //end while  
          //IATCI Response Handling
          if(rtnLine.indexOf("*** EDI PROCESSING ***") != -1)         //IATCI Response Handling
          {        
             iElapseTime = 0;                                         //reset timer
             
             while(iElapseTime<=iTimeOut_seconds*10)
             {                    //while (在等待時間之內)     
                if(dataIn.available()>0)
                {                                //收到資料了
                   int iBufferSize = dataIn.available();                 //串流中還有多少個byte的資料可以讀取
                   byte [] bytReadBuffer = new byte[iBufferSize];        //宣告一個byte array儲存並設定的大小  
                   int iRcvBytes = 0;                                    
                   int tempiRcvBytes = 0;
             
                   dataIn.skip(2);                                       //這兩行在避免主機回覆的原始 Response 的 Length (In Header)被組成一個中文字，
                   iBufferSize=iBufferSize-2;                            //造成要刪掉主機前面的Header時截到真正所需要Response的第一個字。
             
                   do
                   {                                                   //判斷並收齊資料
                      //System.out.println("tempiRcvBytes Before"+tempiRcvBytes); 
                      tempiRcvBytes = dataIn.read(bytReadBuffer,iRcvBytes,iBufferSize-iRcvBytes);
                      //System.out.println("tempiRcvBytes After"+tempiRcvBytes);
                      iRcvBytes = iRcvBytes + tempiRcvBytes;   
                      rtnLine1 = rtnLine1 + new String(bytReadBuffer);
                   }while(tempiRcvBytes<iBufferSize);                  

                   CRNInResponse = rtnLine1.substring(0,8);               //抓到正確原始資料       
                   if(CRNInResponse.equals(sCRNForDSP))
                   {                 //收到正確的 Response
                      rtnLine1 = rtnLine1.substring(10);                   //去掉頭兩個 bytes 的 Gabbage 以及8個 bytes 的 CRN name。
                      rtnLine1 = rtnLine1.replace(ctrlN,LF);
                      rtnLine1 = rtnLine1.replace(space,LF);
                      //rtnLine1 = rtnLine1.replace(end,LF);
                      rtnLine1 = rtnLine1.replace(end,nulla);
                      rtnLine = rtnLine.substring(0,23);
                      Date timeOfServerResponse1 = new Date();
//                      System.out.println("");
//                      System.out.println("[RESPONSE OF EDI PROCESSING]("+timeOfServerResponse1.toString()+"):");
//                      System.out.println(rtnLine1);
                      break;                                             //離開回圈
                   }
                   else
                   {
                      rtnLine1 = "";                                      //清空
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
                   rtnLine1 = "";                                         //web application必須自行處理傳回空字串情況(主機在"iTimeOut_seconds"秒之內未有回應)
                   break;                                                //離開回圈
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
          strRtn = "";                                                //傳回空字串
      }
      finally
      {
          try
          {
              if(sckClient != null)
              {
                  sckClient.close();                                  //關閉與主機的連線
              }    
          }
          catch(Exception exp)
          {
              Date timeOfServerException2 = new Date();
//              System.out.println("");
//              System.out.println("[EXCEPTION OF CLOSING SOCKET]("+timeOfServerException2.toString()+"):");
//              System.err.println(exp);
              strRtn = "";                                            //傳回空字串
          }
      }
  }
}


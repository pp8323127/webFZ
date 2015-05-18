package eg.mvc;

import java.net.*;
import java.io.*;
import java.sql.*;
import java.util.*;
import ci.db.*;
import tool.*;

public class ConnectionUtility implements Serializable 
{
    public static void main(String[] args)
    {        
        String test = "";
        String hostResponse="";
//        String alcs_session = "TPEZZ300";//live
//        String alcs_sine_code ="BSIA6356TM/PD";//live
//        String alcs_sine_code ="BSIA1688TA/TA";//live
        
        String alcs_sine_code ="BSIA8155CS/PD";//live
//       String  alcs_session = "MVCPNR01";//test
//       String alcs_sine_code ="BSIA6666CI/GS";//test
        ArrayList objAL = new ArrayList();
        
        ConnectionUtility myConnector = new ConnectionUtility();  
        myConnector.setUser("640790");        
//        myConnector.setsession(alcs_session);
        myConnector.setsession();
        myConnector.setdoconnect();
        myConnector.setdata("UR");        
        myConnector.setdata("BSA");
        myConnector.setdata(alcs_sine_code);
        myConnector.setdata("UC");        
//        myConnector.setdata("DF//");
//        myConnector.setdata("DF/22mar");
//        myConnector.setdata("*CI0680/30MAR/HKG");
//        myConnector.setdata("*CI0005/22MAR/LAX");
        myConnector.setdata("*CI0018/25OCT/TPE");
        myConnector.setdata("@P/VC");  
//        myConnector.setdata("UR");        
//        myConnector.setdata("BSX");
        hostResponse = myConnector.getdata();
        if(hostResponse.length()>0)
        {
            //get customer num
            String cus_num = "";
	        splitString p = new splitString();
	        ArrayList strAL = p.doSplit2(hostResponse,"\n");        
	        for(int i=0; i < strAL.size(); i++)
	        { 
	            if(((String)strAL.get(i)).indexOf(">")<0)
	            {
	                objAL.add(strAL.get(i));
	            }
	//            System.out.println(strAL.get(i));                
	        } 
	        
	        while(hostResponse.indexOf("END NAMES")<0 && hostResponse.indexOf("FULL FLT ASSIGNMENT REQUIRED")<0)
	        {
	            myConnector.setdata("MD");  
	            hostResponse = myConnector.getdata();
	            strAL.clear();
	            strAL = p.doSplit2(hostResponse,"\n");    
	            
	            for(int i=0; i < strAL.size(); i++)
	            {
                    if(((String)strAL.get(i)).indexOf(">")<0)
    	            {
                        objAL.add(strAL.get(i));
    	            }	    
	            } 
	        }       
        }
        //connection close
        myConnector.endDoconnect();
        
        Hashtable cardnumHT = new Hashtable();
        for(int i=1; i<objAL.size(); i++)
        {
            if(((String) objAL.get(i)).indexOf(".") >=0 | ((String) objAL.get(i)).indexOf("END NAMES") >=0)
            {
                    cardnumHT.put(objAL.get(i-1),"");
            }
//            System.out.println(objAL.get(i));           
        }
        
        Set keyset = cardnumHT.keySet();
	    Iterator i = keyset.iterator();
        while(i.hasNext())
    	{
            String key = String.valueOf(i.next());
    	    System.out.println(key.replaceAll(" ",""));
    	}
    }

//主機資料(IP,Port Number,CRN Name,EOM)
  private final String DEFAULT_SERVER_IP = "192.168.23.2";   //Specific IP Address : 192.168.23.2
  //private final int DEFAULT_SERVER_PORT = 4021;            //Specific Port Number : 4021 (For ALCSTEST)
  //private final int DEFAULT_SERVER_PORT = 4035;            //Specific Port Number : 4035 (For ALCSPRE)
  
  private int DEFAULT_SERVER_PORT = 4036; //live           
//  private int DEFAULT_SERVER_PORT = 4038; //test           
  private String sCRNForDSP = "";                            //CRN for DSP session
  private String sEOM = "+";                                 //EOM used by CI host

//Socket資料
  private String serverIP = DEFAULT_SERVER_IP;
  private int serverPort = DEFAULT_SERVER_PORT;
  private Socket sckClient = null;
  int sckTimeout = 0;                                         //Infinite Timeout

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
  private char WUS=35;
  private char ctrlN=21;
  private char LF=10;
  private char space=37;
  private char end=43;
  private char ACK=109;
  private char sp=65;
  private char separatorFromHost=124;
  private char separatorForASCII=35;
  private char nulla=0;
  private String userid = "";
  private ArrayList strAL = new ArrayList();

//strat
  public ConnectionUtility()
  {
         //Because JavaBeans has to use empty constructor
  }
  
  public void setUser (String userid)
  {
      this.userid = userid;
  }
  
  public void setsession (String CRN)
  {
      sCRNForDSP = CRN;
  }
  
  public void setsession ()
  {
      Statement stmt = null;
      ResultSet rs = null;
      Connection conn = null;
      Driver dbDriver = null;
      String sql = "";
      
      try 
      {
          ConnectionHelper ch = new ConnectionHelper();
          conn = ch.getConnection();
          stmt = conn.createStatement();	

          sql = " SELECT Max(session_name) sess FROM fztsess WHERE isavailable ='0' ";
//          System.out.println(sql);
          rs = stmt.executeQuery(sql);            
          
          if (rs.next()) 
          {
              sCRNForDSP = rs.getString("sess");
              
          }
          
          sql = " update fztsess set isavailable = '1', userid='"+userid+"', stime = sysdate, etime = null " +
          		" WHERE isavailable ='0' and  session_name in ('"+sCRNForDSP+"') ";
          stmt.executeUpdate(sql);     
      } 
      catch (SQLException e) 
      {
          System.out.print(e.toString());
      } 
      catch (Exception e) 
      {
          System.out.print(e.toString());
      }
      finally 
      {

          if ( rs != null ) try {
              rs.close();
          } catch (SQLException e) {}
          if ( stmt != null ) try {
              stmt.close();
          } catch (SQLException e) {}
          if ( conn != null ) try {
              conn.close();
          } catch (SQLException e) {}

      }
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
  public void setdoconnect()
  {      
      try
      {
          sckClient = new Socket(DEFAULT_SERVER_IP,DEFAULT_SERVER_PORT);
          sckClient.setSoTimeout(sckTimeout);
	  }
	  catch (IOException io)
	  {
	      connector = !connector;
	  }
//	  System.out.println(connector);
      
      
      
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
  
  public void endDoconnect()
  {
      Statement stmt = null;
      ResultSet rs = null;
      Connection conn = null;
      Driver dbDriver = null;
      String sql = "";
      
      try 
      {
          ConnectionHelper ch = new ConnectionHelper();
          conn = ch.getConnection();
          stmt = conn.createStatement();          
          sql = " update fztsess set isavailable = '0',etime = sysdate  " +
          		" WHERE isavailable ='1' and  session_name in ('"+sCRNForDSP+"') ";          
          stmt.executeUpdate(sql);     
      } 
      catch (SQLException e) 
      {
          System.out.print(e.toString());
      } 
      catch (Exception e) 
      {
          System.out.print(e.toString());
      }
      finally 
      {

          if ( rs != null ) try {
              rs.close();
          } catch (SQLException e) {}
          if ( stmt != null ) try {
              stmt.close();
          } catch (SQLException e) {}
          if ( conn != null ) try {
              conn.close();
          } catch (SQLException e) {}

      }
      //*******************************************************************************
      try
      {          
          if(sckClient != null)
          {
              sckClient.close();                                  //關閉與主機的連線
          }    
      }
      catch(Exception exp)
      {
          System.out.println(exp.toString());
      }
      	
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
          java.util.Date timeOfServerEntry = new java.util.Date();
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
             { 	//收到資料了
                int iBufferSize = dataIn.available();                 //串流中還有多少個byte的資料可以讀取
                byte [] bytReadBuffer = new byte[iBufferSize];        //宣告一個byte array儲存並設定的大小  
                int iRcvBytes = 0;                                    
                int tempiRcvBytes = 0;
             
                dataIn.skip(2);                                       //這兩行在避免主機回覆的原始 Response 的 Length (In Header)被組成一個中文字，
                iBufferSize=iBufferSize-2;                            //造成要刪掉主機前面的Header時截到真正所需要Response的第一個字。
             
                do
                {                                                   //判斷並收齊資料
//                   System.out.println("tempiRcvBytes Before"+tempiRcvBytes); 
                   tempiRcvBytes = dataIn.read(bytReadBuffer,iRcvBytes,iBufferSize-iRcvBytes);
//                   System.out.println("tempiRcvBytes After"+tempiRcvBytes);
                   iRcvBytes = iRcvBytes + tempiRcvBytes;   
//                   System.out.println("rtnLine before "+rtnLine);
                   rtnLine = rtnLine + new String(bytReadBuffer);			
//                   System.out.println("rtnLine after "+rtnLine);
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
                   java.util.Date timeOfServerResponse1 = new java.util.Date();
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
                 java.util.Date timeOfServerTimeout = new java.util.Date();
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
                      java.util.Date timeOfServerResponse1 = new java.util.Date();
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
                    java.util.Date timeOfServerTimeout = new java.util.Date();
//                   System.out.println("");
//                   System.out.println("[RESPONSE OF EDI PROCESSING]("+timeOfServerTimeout.toString()+"):");
//                   System.out.println("Host Response Timeout(Over "+iTimeOut_seconds+" Seconds)!");
                   rtnLine1 = "";                                         //web application必須自行處理傳回空字串情況(主機在"iTimeOut_seconds"秒之內未有回應)
                   break;                                                //離開回圈
                }
             }                                                           //end while 
          }                                                              //end if(EDI PROCESSING)
          strRtn = rtnLine+rtnLine1;        
          
//          System.out.println("## "+strRtn);
//          dataIn.close();
//          dataOut.close();
      }
      catch (Exception E)
      {
          java.util.Date timeOfServerException1 = new java.util.Date();
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
//              if(sckClient != null)
//              {
//                  sckClient.close();                                  //關閉與主機的連線
//              }    
          }
          catch(Exception exp)
          {
              java.util.Date timeOfServerException2 = new java.util.Date();
//              System.out.println("");
//              System.out.println("[EXCEPTION OF CLOSING SOCKET]("+timeOfServerException2.toString()+"):");
//              System.err.println(exp);
              strRtn = "";                                            //傳回空字串
          }
      }
  }  
}


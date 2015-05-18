package tool;

import java.util.*;

//?Ie-mail address
public class splitString
{
    
      public static void main(String []args)
      {
	      splitString p = new splitString();
//	      String str = "256/11/58/025/066/058/014/1258/0259/025864/222/02233/025/028/026/315/598/365/5454/";
//	      System.out.println(str.substring(0,str.length()-1));
	      String str = "2012/6/3";
	      String[] s = p.doSplit(str,"/");
	      for(int i=0; i<s.length; i++)
	      {
	         System.out.println(s[i]);    
	      }
	      
	     
	      //System.out.println(9%10);
//	      String[] rs = p.doSplit("256/11/58/025/066/058/014/1258/0259/025864/222/02233/025/028/026/315/598/365/5454/","/");
//	      ArrayList strAL = p.doSplit2(str,"/");
//	      for(int i=0; i < strAL.size(); i++)
//	      {
//	          System.out.println(strAL.get(i));
//	      }
//	      System.out.println("***********************************************************************");
//	      for(int i=0; i<strAL.size();i++)
//	      {
//	          System.out.println(strAL.get(i));
//	      }
      }
   
      public String[] doSplit(String strSource, String strMark)
      {
              String [] rstr = new String[30];//Max 20
              int intPos;
              int x = 0;

              while((intPos=strSource.indexOf(strMark))!=-1)
              {       //System.out.println(intPos);
                      rstr[x] = strSource.substring(0,intPos);
                      strSource = strSource.substring(intPos+1);
                      x++;
              }
              rstr[x] = strSource;

              return rstr;
      }
      
      public ArrayList doSplit2(String strSource, String strMark)
      {
              ArrayList strAL = new ArrayList();
              int intPos;

              while((intPos=strSource.indexOf(strMark))!=-1)
              {       //System.out.println(intPos);
                      strAL.add(strSource.substring(0,intPos));
                      strSource = strSource.substring(intPos+1);
              }
              
              if(!"".equals(strSource) && strSource !=null)
              {
                  strAL.add(strSource);
              }  

              return strAL;
      }
}
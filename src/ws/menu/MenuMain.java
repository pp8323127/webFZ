package ws.menu;

import java.text.*;
import java.util.GregorianCalendar;

import ws.*;
import ws.header.ThreeDes;
import ws.personal.mvc.*;


/*2015/03/20 Q2 */
public class MenuMain
{
//   public static void main(String[] args) 
//   {
//      // TODO Auto-generated method stub
//    
//       MenuMain m = new MenuMain();
//       m.MenuDetail("0066", "2014/08/10", "FRATPE", "990bed230967321c840c5b83b68c76e9");
//    
//    
//   }
    private SimpleDateFormat ft = new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
    private String startTime = null;
    private String endTime = null;
    
  public MenuFunRObj MenuDetail(String fltno, String fltd, String sect, String sysPwd)
  {
    boolean wsAuth = false;
    ThreeDes d = new ThreeDes();
    wsAuth = d.auth(sysPwd);
    MenuFun m = new MenuFun();
    int year = Integer.parseInt(fltd.substring(0, 4));
    int mm = Integer.parseInt(fltd.substring(5, 7));
    int dd = Integer.parseInt(fltd.substring(8, 10));
    startTime = ft.format(new java.util.Date());
    if (wsAuth) {
      GregorianCalendar cal1 = new GregorianCalendar();//fltd
      cal1.set(1, year);
      cal1.set(2, mm-1);
      cal1.set(5, dd);
      cal1.set(10, 0);
      cal1.set(12, 0);
      cal1.set(13, 0);
//      System.out.println("fltd:"+cal1.getTime());
//      System.out.println(year+""+mm+""+dd);
      GregorianCalendar cal2 = new GregorianCalendar();//生效日
      cal2.set(1, 2015);
      cal2.set(2, 4-1);
      cal2.set(5, 1);
      cal2.set(10, 0);
      cal2.set(12, 0);
      cal2.set(13, 0);
      
//      System.out.println("生效日:"+cal2.getTime());
      if (cal1.after(cal2) || cal1.equals(cal2))
      {
//          System.out.println("NEW");
          m.getMenuList2(fltno, fltd, sect);//Q2 777
          
          
      }
      else 
      {
//          System.out.println("OLD");
          m.getMenuList(fltno, fltd, sect);//2015/01/01 Q1
          
          
      }
    }
    else {
      m.menu = new MenuFunRObj();
      m.menu.setResultMsg("0");
      m.menu.setErrorMsg("No Auth");
    }
    endTime = ft.format(new java.util.Date());
    WriteWSLog lg = new WriteWSLog("MenuDetail", startTime, endTime, "", "", "", "");
    lg.WriteLog();
    return m.menu;
  }

//  存回DB
  public SavaCusRObj SaveOrderData(SaveMenuFbkRobj[] saveArr, String sysPwd) {
      boolean wsAuth = false;
      ThreeDes d = new ThreeDes();
      wsAuth = d.auth(sysPwd);
      MenuFun fun = new MenuFun();
      if(wsAuth){            
          fun.saveMenuFbk(saveArr);
      }else{
          SavaCusRObj re = new SavaCusRObj();
          fun.setSaveReturn(re);
          fun.getSaveReturn().setErrorMsg("0") ;
          fun.getSaveReturn().setResultMsg("No Auth!!");
      }
      return fun.getSaveReturn();
  }
}
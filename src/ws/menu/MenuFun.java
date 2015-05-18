package ws.menu;

import java.io.*;
import java.sql.*;
import java.util.*;

import ws.personal.mvc.*;
import ci.db.*;

public class MenuFun {

    /**
     * @param args
     */
    

    
    MenuFunRObj menu = null;//live
    /*2015/03/20 Q2 */
//  0004/0003ÀYµ¥¿µ
//  0006/0005/0008/0007  »¨µØ°Ó°È¿µ
//  0061/0062/0063/0064/0032/0031/0051(TPE/SYD)/0052(SYD/TPE) °Ó°È¿µ
    
    private SavaCusRObj saveReturn = null;
//    static MenuFunRObj menu = null;   
//  public static void main(String[] args) 
//  {
//      // TODO Auto-generated method stub
//    MenuFun f = new MenuFun();
//    f.getMenuList2("0017", "2014/07/31", "HNLNRT");
//    for(int i=0;i<menu.getMenuMarr().length;i++){
//        System.out.println(menu.getMenuMarr()[i].getName());
//    }
////    for(int i=0;i<menu.getMenuMarr().length;i++){
////        System.out.println(menu.getMenuMarr()[i].geteName());
////    }
////      String fltno = "004z";
////      fltno = fltno.replace("Z", "").replace("z", "");
////      if(fltno.length()!=4){
////          fltno = "0000".substring(0, 4 - fltno.length()) + fltno;
////          System.out.println(fltno);
////      }
//  }
//  2014/04/01  
    public void getMenuList_bak(String fltno ,String fltd, String sect){
//      2014/04/01
        fltno = fltno.replace("Z", "").replace("z", "");
        if(fltno.length()!=4){
            fltno = "0000".substring(0, 4 - fltno.length()) + fltno;
//            System.out.println(fltno);
        }
        menu = new MenuFunRObj();
        ArrayList drink = new ArrayList();
        ArrayList mainMeal = new ArrayList();
        
        /**************************************/
        String dType= null; 
        String dClassType = null;
        
        //¶¼®Æ
        MenuDrinkObj dObj = null;
        dClassType="F";  
        /***F¿µ***/
        dType = "Soft Drink";            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Juice");
            dObj.setDetail("O/J,A/J,T/J,Ice");
            drink.add(dObj);
            dObj = null;
                        
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Sparkling Drink");
            dObj.setDetail("Coke,Pepsi,7up,Soda,Tonic,Perrier,Ginger Ale,Ice,Lite,Lime");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
                        
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Milk");
            dObj.setDetail("Cold,Warm,Hot,Low Fat");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Mineral Water");
            dObj.setDetail("Ice,Warm,Hot,Lime");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
        //--------------------
        dType = "Cosy Lounge";
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Gin");
            //dObj.setQuantity(5);       
            dObj.setDetail("Tonic,Martini,7up,Coke,Ice");
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Vodka");
            //dObj.setQuantity(5);        
            dObj.setDetail("Tomato Juice(Bloody Mary),Orange Juice(Screwdriver),Martini,Tonic,Pepper & Salt,Tabasco,Ice");
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Whisky");
            dObj.setDetail("Jonnie Waker Blue Label Jim Beam,Kavalan,Single Malt,Scotch,Ice");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;  
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Rum");
            //dObj.setQuantity(5);   
            dObj.setDetail("coke,Ice");
            drink.add(dObj);
            dObj = null;
              
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Brandy");
            dObj.setDetail("Deau Cognac XO,Courvoisier Napoleon,Ice");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Port");
            //dObj.setQuantity(5);     
            dObj.setDetail("Taylor's,Ice");
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Cherry Brandy");
            //dObj.setQuantity(5);        
            dObj.setDetail("Ice");
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Bailey's Irish Cream");
            dObj.setDetail("Ice,Milk");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;

            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Chinese Rice Wine: Premium Shaohsing 10 Years (For Japan Routes Only)");
            //dObj.setQuantity(5);    
            drink.add(dObj);
            dObj = null;
                   
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Kizakura Ginjo  (For Japan Routes Only)");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Beer");
            //dObj.setQuantity(5);        
            dObj.setDetail("Golden Medal Taiwan,Heineken,Sapporo");
            drink.add(dObj);
            dObj = null;
        //--------------------
        dType = "Champagne/Wine";
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.setName("Champagne");
            //dObj.setQuantity(5);      
            dObj.setDetail("ªk°ê-Pol Roger¡D2000/France-Pol Roger 2000");
            drink.add(dObj);
            dObj = null;
            
            //¥Õ°s
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("¥Õ°s/White Wine");
            dObj.setDetail("ªk°ê-®L¥¬§Q¡D®L¦h¤º:2009/Chablis Chardonnay 2009,¼w°ê-¿p²ïªe¨¦¡DÄRµ·¬Â¡D2012/Germany-Mosel Valley Riesling 2012");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;   
            
            //¬õ°s            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("¬õ°s/Red Wine");
            dObj.setDetail("ªk°ê¡V¸t¦¶§Q¦w°Ï¡D®Ô°ª¤Ú¹y 1997:Saint-Julien/France-Chateau Langoa Barton 1997,¿D¬w¡V¤ÚÃ¹¨Fªe¨¦¡D§Æ«¢¡D2009/Australia-Barossa Valley Shiraz 2009,¬ü°ê-¯Ç©¬ªe¨¦¡D¬ü¬¥  2009/U.S.A.-Napa Valley Merlot Reserve 2009");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;            
        //--------------------
        dType = "Coffee / Tea";
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Coffee");
            dObj.setDetail("Latte,Cappuccino,Decaffeinated,Hot,Ice,Sugar,Cream");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Tea");
            dObj.setDetail("Oolong,Jasmine,Green tea,Darjeeling,Regular,Ice,Sugar,Cream,Black");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
            
        dClassType="C";  
        /***C¿µ***/
            dType = "Soft Drink";            
                dObj = new MenuDrinkObj();
                dObj.setType(dType);
                dObj.setClassType(dClassType);
                dObj.seteName("Juice");
                dObj.setDetail("O/J,A/J,T/J,Ice");
                drink.add(dObj);
                dObj = null;
                            
                dObj = new MenuDrinkObj();
                dObj.setType(dType);
                dObj.setClassType(dClassType);
                dObj.seteName("Sparkling Drink");
                dObj.setDetail("Coke,Pepsi,7up,Soda,Tonic,Perrier,Ginger Ale,Ice,Lite,Lime");
                //dObj.setQuantity(5);        
                drink.add(dObj);
                dObj = null;
                            
                dObj = new MenuDrinkObj();
                dObj.setType(dType);
                dObj.setClassType(dClassType);
                dObj.seteName("Milk");
                dObj.setDetail("Cold,Warm,Hot,Low Fat");
                //dObj.setQuantity(5);        
                drink.add(dObj);
                dObj = null;
                
                dObj = new MenuDrinkObj();
                dObj.setType(dType);
                dObj.setClassType(dClassType);
                dObj.seteName("Mineral Water");
                dObj.setDetail("Ice,Warm,Hot,Lime");
                //dObj.setQuantity(5);        
                drink.add(dObj);
                dObj = null;
        //--------------------
        dType = "Cosy Lounge";
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Gin");
            //dObj.setQuantity(5);       
            dObj.setDetail("Tonic,Martini,7up,Coke,Ice");
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Vodka");
            //dObj.setQuantity(5);        
            dObj.setDetail("Tomato Juice(Bloody Mary),Orange Juice(Screwdriver),Martini,Tonic,Pepper & Salt,Tabasco,Ice");
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Whisky");
            dObj.setDetail("Jonnie Waker Blue Label Jim Beam,Kavalan,Single Malt,Scotch,Ice");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;  
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Rum");
            //dObj.setQuantity(5);   
            dObj.setDetail("coke,Ice");
            drink.add(dObj);
            dObj = null;
              
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Brandy");
            dObj.setDetail("Deau Cognac XO,Courvoisier Napoleon,Ice");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Port");
            //dObj.setQuantity(5);     
            dObj.setDetail("Taylor's,Ice");
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Cherry Brandy");
            //dObj.setQuantity(5);        
            dObj.setDetail("Ice");
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Bailey's Irish Cream");
            dObj.setDetail("Ice,Milk");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
    
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Chinese Rice Wine: Premium Shaohsing 10 Years (For Japan Routes Only)");
            //dObj.setQuantity(5);    
            dObj.setDetail("Ice");
            drink.add(dObj);
            dObj = null;
                   
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Kizakura Ginjo  (For Japan Routes Only)");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Beer");
            //dObj.setQuantity(5);        
            dObj.setDetail("Golden Medal Taiwan,Heineken,Sapporo");
            drink.add(dObj);
            dObj = null;
        //--------------------
        dType = "Champagne/Wine";
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.setName("Champagne");
            //dObj.setQuantity(5);      
            dObj.setDetail("ªk°ê GREMILLET­»Âb/France Champagne Gremillet");
            drink.add(dObj);
            dObj = null;
            
            //¥Õ°s
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("¥Õ°s/White Wine");
            dObj.setDetail("ªk°ê ¡V®L¥¬§Q¤@¯Å¸²µå¶é ®L¦h¤º 2010/France-Chablis 1er Cru Chardonnay 2010,¼w°ê -¿p²ïªe¨¦¡DÄRµ·¬Â¡D2012/Germany-Mosel Valley Riesling 2012");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;   
            
            //¬õ°s            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("¬õ°s/Red Wine");
            dObj.setDetail("ªk°ê¡D©Ô°ª³ù¡D2006/France-Chateau La Gorce 2006,¸q¤j§Q - ©_´­²Ä¬ÃÂÃ¡A2011/Italy-Chianti Riserva DOCG 2011,¬ü°ê¡D¯Ç©¬ªe¨¦¡D¬ü¬¥ 2009/U.S.A.-Napa Valley Merlot Reserve 2009");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null; 
        //--------------------
        dType = "Coffee/Tea";
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Coffee");
            dObj.setDetail("Latte,Cappuccino,Decaffeinated,Hot,Ice,Sugar,Cream");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Tea");
            dObj.setDetail("Oolong,Jasmine,Green tea,Darjeeling,Regular,Ice,Sugar,Cream,Black");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
            
        //return array  
        MenuDrinkObj[] dArr= new MenuDrinkObj[drink.size()];
        for(int i=0;i<drink.size();i++){
            dArr[i] = (MenuDrinkObj) drink.get(i);
        }
        menu.setMenuDarr(dArr);
    
 /**************************************/
        
        String mType= null; 
        String mClassType = null;
        String alacart = null;
        //À\ÂI
        MenuMealTypeObj mObj = null;
        
        mClassType="F";  
        /***F¿µ***/
        
        
//        if(sect.substring(0,3).equals("TPE"))
//        {
//        if(sect.substring(0,3).equals("TPE"))
        if("0004".equals(fltno) || "0008".equals(fltno) )
        {
            mType = "Late night supper";//®d©]«KÀ\
                alacart = "Appetizer";//«eµæ
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»»¶¤û¸x¡B¨~ªGÂA¤z¨©¡BÂù¦â¬v½µ¦èªà¨F©Ô");
                mObj.seteName("Chinese deluxe cold plateSpicy beef tendon, mango with scallop, onion mixed celery salad");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Às½¼­á¦õ¿»­X¡BÀÍ¥Ê¡B¯õ­»¨F©Ôºó¾í¥Ö");
                mObj.seteName("Lobster jelly with dried tomato, zucchini, and fennel salad and orange skin");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                alacart = "Soup";//´ö«~
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("®üÂA«n¥Ê´ö");
                mObj.seteName("Pumpkin stock with seafood");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("³¥Û£²M´öºó½¼¦i½µ");
                mObj.seteName("Wild mushroom consomme with chive");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Main course";//¥Dµæ
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ªQªO³¥Û£±²¡Bº½¬W¤Tµ·Àí®ß¤lÆCÂû¤Î»¶´ÔÆC½¼¼ß¦õ¤­¦â½­µæ");
                mObj.setDetail("µ·­]¦Ì¶º(steamed rice),¤QâB¦Ì¶º(healthy multi grains rice)");
                mObj.seteName("Pork with shimeji mushroom roll Chicken rolls stuffed with chestnut and scallop with " +
                		"vegetables sauce, stuffed shrimp paste in chili Five-color vegetables, steamed rice");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                             
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¯NÁ÷­°¤û±Æ¡BªQÅSÂæ¡BÂt¬v½µ");
//                mObj.setDetail("­»®Æ¿»­X¥¤ªoÂæ¥Ä(pesto-tomato cream sauce),ªi¯S°sÂæ¥Ä(port wine sauce)");
                mObj.seteName("Roasted beef tenderloin with truffle sauce and smoked onion");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                              
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("®ü³°Âù«÷ ¡V­»·Î°ö®Ú¦Ï±Æ/¤z¨©ÂD³½±²¦õ«n¥Ê¡Bµf­X¡B«Cªáµæ¡B¨¡»T¤Î¥¤ªo«CÂæ");
//                mObj.setDetail("­»®Æ¿»­X¥¤ªoÂæ¥Ä(pesto-tomato cream sauce),ªi¯S°sÂæ¥Ä(port wine sauce)");
                mObj.seteName("SURF AND TURF - pan fried lamb wrapped with bacon/ salmon with scallop roll pumpkin, tomato, broccoli, " +
                		"taromash potato, creamy pesto sauce");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "The bakery";//ºë¿ïÄÑ¥]
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¬P³¥ÆQÄÑ¥]");
                mObj.seteName("French rye baguette");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¶Â³Á°à°s¥]");
                mObj.seteName("Dark rye beer bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("©@°Ø®Ö®ç¥]");
                mObj.seteName("Coffee walnut bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤é¦¡³nÄÑ¥]");
                mObj.seteName("Soft roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»»[ÄÑ¥]");
                mObj.seteName("Garlic bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Sweet finale";//²¢»e§¹¬üºë¿ï
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("®É¥O¤ôªG");
                mObj.seteName("Fresh fruits of the season");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ºë¿ï°_¥q½L");
                mObj.seteName("Selection of cheese");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("®Ûªá¬õ¨§­á");
                mObj.seteName("Jelly red bean and osmanthus");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¶Â¥©§J¤O»PµJ¿}³J¿|");
                mObj.seteName("Black Chocolate and Caramel");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen¡VDazs ¦B²N²O");
                mObj.seteName("Haagen¡VDazs ice cream");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
             mType = "Light bites menu";//»´­¹
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("¬õ¿N¥xÆW¤û¦×ÄÑ (¥i¨É¥Î§Ö³tºë½oÄÑÂI)");
                mObj.seteName("Authentic Taiwanese beef noodle soup ( Fast and delicate of Taiwan delight)");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("ª÷¥Ê¦Ì¯»");
                mObj.seteName("Fried rice noodle with pumpkin");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("ÅÚ½³±Æ°©¶p´ö");
                mObj.seteName("Turnips with pork ribs soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("»[­]ÂD³½¬£");
                mObj.seteName("Salmon and leek pie");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("¯À­¹§Y­¹ÄÑ");
                mObj.seteName("Vegetarian instant noodle");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("ºë¿ï°_¥q½L");
                mObj.seteName("Cheese platter");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("ºë¿ïªG¨§");
                mObj.seteName("Mixed nuts");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
             mType = "Breakfast menu";//    ¦­À\µæ³æ
                mObj = new MenuMealTypeObj();
                alacart = "dirnk";
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¬h¾í¥Ä");
                mObj.seteName("Orange");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Ä«ªG¥Ä");
                mObj.seteName("Apple");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                         
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("µf­X¥Ä");
                mObj.seteName("Tomato");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                              
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("²Î¤@¨§¼ß");
                mObj.seteName("Soy bean milk");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "others";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("®É¥O¤ôªG");
                mObj.seteName("FRESH FRUITS OF THE SEASON");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("âBÃþ¯Ü¤ù");
                mObj.seteName("Cereals are also available upon your choice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;                
         
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Àu®æ");
                mObj.seteName("Yogurt ");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;    
                

                alacart="ºë¿ïÄÑ¥]¦õ¥¤ªo¤ÎªGÂæ";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("°sÆC®Û¶êÄÑ¥]");
                mObj.seteName("Longan bread mixed with red wine");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥i¹|ÄÑ¥]");
                mObj.seteName("Croissant");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                             
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("»ñ±ù¤¦³ÁÄÑ¥]");
                mObj.seteName("Pineapple danish");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("«p¤ù¥Õ¦R¥q");
                mObj.seteName("Toast");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                
                alacart="Main course";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ÂtÂD»[°_¤h³J¥]¦õ¤p¤û¦×¸z¡BªÛ³ÂÁ¦»æ¡B¥Íµæ¨F©Ô°tÄ«ªGªo¾L");
                mObj.seteName("Smoked salmon and garlic boursin cheese omelet " +
                		"veal sausage, sesame potato cake, mixed salad with cider vinaigrette");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ªk¦¡°ö®Ú¬v½µÄÐ¬£¦õµÔµæ¡Bµf­X¡BÄ¨Û£¡BÂû¦×¸z¤Î·¬¸­¿}¼ßÃP»æ");
                mObj.seteName("Quiche Lorraine spinach, tomato, mushroom, chicken sausage, waffle with maple syrup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ª÷¨FÂAµ«¡BxoÂæªã¡BÂÅ»ÈªÞÂûµ·¡BµÔµæÂAÛ£©Õ¦×,¯S¿ï¦×ÃP¡B¤¤¦¡ÄCÀY¡BÅÚ½³µ·»æ¡B·Î¨¡ÀY¿|");
                mObj.setDetail("²Mµ°(Plain congee),Âû»Tµ°(chicken congee with yam and mushroom)");
                mObj.seteName("Egg yolk chop with bamboo shoot,Kai lan with xo sauce," +
                		"Marinated chicken with bean sprout,Tossed spinach with shiitake mushroom and minced," +
                		"Shredded dry pork, Taiwanese bun and savory." +
                		"Traditional Taiwanese side dishes are available upon request");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
               
                
        }
        else if("0006".equals(fltno))
        {
            mType = "Dinner menu";//±ßÀ\
            alacart = "Appetizer";//«eµæ
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»»¶¤û¸x¡B¨~ªGÂA¤z¨©¡BÂù¦â¬v½µ¦èªà¨F©Ô");
                mObj.seteName("Chinese deluxe cold plate, Spicy beef tendon, mango with " +
                		"scallop, onion mixed celery salad");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
        
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Às½¼­á¦õ¿»­X¡BÀÍ¥Ê¡B¯õ­»¨F©Ôºó¾í¥Ö");
                mObj.seteName("Lobster jelly with dried tomato, zucchini, and fennel salad and orange skin");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
        
                alacart = "Soup";//´ö«~
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("®üÂA«n¥Ê´ö");
                mObj.seteName("Pumpkin stock with seafood");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("³¥Û£²M´öºó½¼¦i½µ");
                mObj.seteName("Wild mushroom consomme with chive");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Salad";//¨F©Ô
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ºë½o¨F©Ô¦õºë¿ï°t®Æ");
                mObj.setDetail("¯S¯Å¾ñÆVªo(extra virgin olive oil),¸q¤j§Q³¯¦~¸²µå¾L(balsamic vinegar),±ö­»ªÛ³ÂÂæ(sesame plum dressing)");
                mObj.seteName("Garden salad served with selected condiments");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Main course";//¥Dµæ
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ªQªO³¥Û£±²¡Bº½¬W¤Tµ·Àí®ß¤lÆCÂû¤Î»¶´ÔÆC½¼¼ß¦õ¤­¦â½­µæ");
                mObj.setDetail("µ·­]¦Ì¶º(steamed rice),¤QâB¦Ì¶º(healthy multi grains rice)");
                mObj.seteName("Pork with shimeji mushroom roll Chicken rolls stuffed with chestnut and scallop with" +
                		       " vegetables sauce, stuffed shrimp paste in chili Five-color vegetables, steamed rice");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                           
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¯NÁ÷­°¤û±Æ¡BªQÅSÂæ¡BÂt¬v½µ");
//                mObj.setDetail("­»®Æ¿»­X¥¤ªoÂæ¥Ä(pesto-tomato cream sauce),ªi¯S°sÂæ¥Ä(port wine sauce)");
                mObj.seteName("Roasted beef tenderloin with truffle sauce and smoked onion");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                                          
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("®ü³°Âù«÷ ¡V­»·Î°ö®Ú¦Ï±Æ/¤z¨©ÂD³½±²¦õ«n¥Ê¡Bµf­X¡B«Cªáµæ¡B¨¡»T¤Î¥¤ªo«CÂæ");
//                mObj.setDetail("­»®Æ¿»­X¥¤ªoÂæ¥Ä(pesto-tomato cream sauce),ªi¯S°sÂæ¥Ä(port wine sauce)");
                mObj.seteName("SURF AND TURF - pan fried lamb wrapped with bacon/salmon with " +
                		"scallop roll pumpkin, tomato, broccoli, taromash potato, creamy pesto sauce");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                        
                alacart = "The bakery";//ºë¿ïÄÑ¥]
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¬P³¥ÆQÄÑ¥]");
                mObj.seteName("Hoshino salty bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¶Â³Á°à°s¥]");
                mObj.seteName("Dark rye beer bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("©@°Ø®Ö®ç¥]");
                mObj.seteName("Coffee walnut bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤é¦¡³nÄÑ¥]");
                mObj.seteName("Soft roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»»[ÄÑ¥]");
                mObj.seteName("Garlic bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Sweet finale";//²¢»e§¹¬üºë¿ï
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("®É¥O¤ôªG");
                mObj.seteName("Fresh fruits of the season");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ºë¿ï°_¥q½L");
                mObj.seteName("Selection of cheese");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("®Ûªá¬õ¨§­á");
                mObj.seteName("Jelly red bean and osmanthus");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¶Â¥©§J¤O»PµJ¿}³J¿|");
                mObj.seteName("Black Chocolate and Caramel");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen¡VDazs ¦B²N²O");
                mObj.seteName("Haagen¡VDazs ice cream");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;                
                       
             mType = "Light bites menu";//»´­¹
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("¬õ¿N¥xÆW¤û¦×ÄÑ (¥i¨É¥Î§Ö³tºë½oÄÑÂI)");
                mObj.seteName("Authentic Taiwanese beef noodle soup ( Fast and delicate of Taiwan delight)");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("ª÷¥Ê¦Ì¯»");
                mObj.seteName("Fried rice noodle with pumpkin");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("ÅÚ½³±Æ°©¶p´ö");
                mObj.seteName("Turnips with pork ribs soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("»[­]ÂD³½¬£");
                mObj.seteName("Salmon and leek pie");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("¯À­¹§Y­¹ÄÑ");
                mObj.seteName("Vegetarian instant noodle");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("ºë¿ï°_¥q½L");
                mObj.seteName("Cheese platter");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("ºë¿ïªG¨§");
                mObj.seteName("Mixed nuts");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
            mType = "Breakfast menu";//    ¦­À\µæ³æ
                mObj = new MenuMealTypeObj();
                alacart = "dirnk";
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¬h¾í¥Ä");
                mObj.seteName("Orange juice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
            
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Ä«ªG¥Ä");
                mObj.seteName("Apple juice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                     
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("µf­X¥Ä");
                mObj.seteName("Tomato juice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                          
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("²Î¤@¨§¼ß");
                mObj.seteName("Soy bean milk");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
            
                alacart = "others";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("®É¥O¤ôªG");
                mObj.seteName("FRESH FRUITS OF THE SEASON");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("âBÃþ¯Ü¤ù");
                mObj.seteName("Cereals are also available upon your choice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);       
                mainMeal.add(mObj);
                mObj = null;                
         
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Àu®æ");
                mObj.seteName("Yogurt");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;                    
    
                alacart="ºë¿ïÄÑ¥]¦õ¥¤ªo¤ÎªGÂæ";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("°sÆC®Û¶êÄÑ¥]");
                mObj.seteName("Longan bread mixed with red wine");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥i¹|ÄÑ¥]");
                mObj.seteName("Croissant");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                             
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("»ñ±ù¤¦³ÁÄÑ¥]");
                mObj.seteName("Pineapple danish");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("«p¤ù¥Õ¦R¥q");
                mObj.seteName("Toast");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                
                alacart="Main course";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ÂtÂD»[°_¤h³J¥]¦õ¤p¤û¦×¸z¡BªÛ³ÂÁ¦»æ¡B¥Íµæ¨F©Ô°tÄ«ªGªo¾L");
                mObj.seteName("Smoked salmon and garlic boursin cheese omelet " +
                		"veal sausage, sesame potato cake, mixed salad with cider vinaigrette");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ªk¦¡°ö®Ú¬v½µÄÐ¬£¦õµÔµæ¡Bµf­X¡BÄ¨Û£¡BÂû¦×¸z¤Î·¬¸­¿}¼ßÃP»æ");
                mObj.seteName("Quiche Lorraine spinach, tomato, mushroom, chicken sausage, waffle with maple syrup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ª÷¨FÂAµ«¡BxoÂæªãÂÅ¡B»ÈªÞÂûµ·¡BµÔµæÂAÛ£©Õ¦×,¯S¿ï¦×ÃP¡B¤¤¦¡¤â¤uÄCÀY¡BÅÚ½³µ·»æ¡B·Î¨¡ÀY¿|");
                mObj.setDetail("²Mµ°(Plain congee),Âû»Tµ°(chicken congee with yam and mushroom)");
                mObj.seteName("Egg yolk chop with bamboo shoot,Kai lan with xo sauce," +
                		"Marinated chicken with bean sprout,Tossed spinach with shiitake mushroom and minced" +
                		"Shredded dry pork, Taiwanese bun and savory");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
          }
              
//        }
//        else
//        {//if(sect.substring(4).equals("TPE"))
        
//        if(sect.substring(4).equals("TPE"))    
        if("0003".equals(fltno) || "0007".equals(fltno))
        {
            mType = "Late night supper";//®d©]«KÀ\
                alacart = "Appetizer";//«eµæ
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Àj³½¡Bº±Âû¦×¡BÃÉ¸}¦×");
                mObj.seteName("Abalone sliced, marinated soya chicken, crab claw");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ÃÉ¦×¶ð¦õ¹T±ù¤Îµf­X¡BÄªµ«¨F©Ô");
                mObj.seteName("Crab meat tartare with avocado, tomato, asparagus,micro greens");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                alacart = "Soup";//´ö«~
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("±Æ°©ªá¥Í½¬ÃÂ´ö");
                mObj.seteName("Braised lotus root with peanuts and pork rib soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¬õÅÚ½³¨¾­·¯ó´ö°t¬µ¿¾ãR");
                mObj.seteName("Carrot and parsnip soup with turnip chips");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Main course";//¥Dµæ
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¶Â­J´Ô¤û¥J°© ¡BÁ¤½µÃzÀs½¼¦õªãÄõ¤Îµ·­]¦Ì¶º");
                mObj.seteName("Wok fried beef short ribs in black pepper sauce Wok fried lobster with ginger onion sauce kai lan, steamed rice");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¿L¦Ï½¥¦õºî¦X®É½­¤Îµf¬õªá¦Ì¶º");
                mObj.seteName("Braised lamb shank assorted seasonal vegetables, saffron rice");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»·ÎÆt³½¦õ¸`¥Ê¡B¬õÅÚ½³¡B­·°®µf­X¥_«D¤p¦Ì¤Î®ÉÅÚµÜ©i¥ÕÂæ¥Ä");
                mObj.seteName("Seared sea bass zucchini, carrot, sun-dried tomato with couscous, " +
                		"dill and lime cream sauce");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "The bakery";//ºë¿ïÄÑ¥]                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¸q¦¡©ì¾cÄÑ¥]");
                mObj.seteName("Ciabatta bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Twist roll");
                mObj.seteName("Brioche roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¾ñÆVÄÑ¥]");
                mObj.seteName("Olive roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("°g­¡­»ÄÑ¥]");
                mObj.seteName("Rosemary roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»»[ÄÑ¥]");
                mObj.seteName("Garlic bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Dessert ";//²¢ÂI
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("©u¸`ÂAªG");
                mObj.seteName("Fresh fruits of the season");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ºë¿ï°_¥q½L");
                mObj.seteName("Cheese selections");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("»È¦Õ·¦¥¤¥É¦ÌÅS ");
//                mObj.setDetail("·Å¼ö (warm),§N­¹(cold)");
                mObj.seteName("White fungus, sweet corn with coconut milk sweet soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("©@°Ø¼}´µ¦õÂÐ¬Ö¤lÂæ");
                mObj.seteName("Coffee mousse with raspberry jam");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen¡VDazs ¦B²N²O");
                mObj.seteName("Haagen¡VDazs ice cream");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
             mType = "Light bites menu";//»´­¹
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("ºë½o¬õ¿N¤û¦×ÄÑ");
                mObj.seteName("Authentic Taiwanese beef noodle soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("¤@«~®üÂA´öÄÑ");
                mObj.seteName("Imperial seafood noodle soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("°ö®ÚµÔµæÄÐ¬£");
                mObj.seteName("Bacon and spinach quiche");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("¯À­¹§Y­¹ÄÑ");
                mObj.seteName("Vegetarian instant noodle");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("¦õ°s°_¥q½L");
                mObj.seteName("Cheese platter");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("ºë¿ïªG¨§");
                mObj.seteName("Mixed nuts");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
             mType = "Breakfast menu";//    ¦­À\µæ³æ
                mObj = new MenuMealTypeObj();
                alacart = "dirnk";
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¬h¾í¥Ä");
                mObj.seteName("Orange juice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);   
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Ä«ªG¥Ä");
                mObj.seteName("Apple juice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                         
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("µf­X¥Ä");
                mObj.seteName("Tomato juice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);    
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "others";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("®É¥O¤ôªG");
                mObj.seteName("Fresh fruits of the season");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);  
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("âBÃþ¯Ü¤ù");
                mObj.seteName("Cereals");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);  
                mainMeal.add(mObj);
                mObj = null;                
         
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Àu¹T¨Å");
                mObj.seteName("Drinking yogurt");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);      
                mainMeal.add(mObj);
                mObj = null;    
                
    
                alacart="ºë¿ïÄÑ¥]¦õ¥¤ªo¤ÎªGÂæ";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥i¹|ÄÑ¥]");
                mObj.seteName("Croissant");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¿P³Á°¨ªâ");
                mObj.seteName("Oatmeal muffin");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                             
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»¿¼°íªG³J¿|");
                mObj.seteName("Banana nut cake");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("«p¤ù¦R¥q");
                mObj.seteName("Thick white toast");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                
                alacart="Main course";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ÄÑ¥]¥¬¤B¦õÂø²ù¤Î­»¯óÂæ");
                mObj.seteName("Nutella bread pudding mixed berries, vanilla sauce");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¦è¦¡±m´Ôµf­X³J¥Õ³J¥]¦õÄªµ«¡Bµf­X¡B¥[®³¤j¤õ»L¡B¬v¨¡»æ¤Î±m´Ôµf­X²ï²ï");
                mObj.seteName("Egg white omelet with bell pepper and tomato" +
                		" asparagus, tomato, Canadian ham, potato cake, bell" +
                		" pepper and tomato salsa");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("²Mµ°--  ªø¨§¦×¥½·Î³J¡B­»ªàª£Âûµ·¡B²D©Õ¤sÃÄ¡B¤­±m½¼¤¯¡Bºë¿ï¦×ÃP¡B¬ü¨ý¤p³ì³ÁÄCÀY¡B¤e¿N¶p¡B¥t³Æ¦³ÃhÂÂÂæµæ¨Ñ®È«È¿ï¥Î");
                mObj.seteName("Plain congee--  Pan fried string bean and minced pork omelet," +
                        "Wok fried chicken with celery," +
                        "Marinated yam," +
                        "Prawn, sweet corn and soya bean," +
                        "Shredded dry pork, home made whole wheat steamed bun,barbecue pork pastry");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
        }
        else if("0005".equals(fltno))
        {
            mType = "Dinner menu";//±ßÀ\
                alacart = "Appetizer";//«eµæ
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Àj³½¡Bº±Âû¦×¡BÃÉ¸}¦×");
                mObj.seteName("Abalone sliced, marinated soya chicken, crab claw");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ÃÉ¦×¶ð¦õ¹T±ù¤Îµf­X¡BÄªµ«¨F©Ô");
                mObj.seteName("Crab meat tartare with avocado, tomato, asparagus,micro greens");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                alacart = "Soup";//´ö«~
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("±Æ°©ªá¥Í½¬ÃÂ´ö");
                mObj.seteName("Braised lotus root with peanuts and pork rib soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¬õÅÚ½³¨¾­·¯ó´ö°t¬µ¿¾ãR");
                mObj.seteName("Carrot and parsnip soup with turnip chips");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Salad";//¨F©Ô
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ºë½o¨F©Ô¦õºë¿ï°t®Æ¥i·f°t:");
                mObj.setDetail("¯S¯ÅÂfÂc¾ñÆVªo(virgin olive oil),¸²µå°s¾L(virgin olive oil),¤d®qÂæ(sesame plum dressing)");
                mObj.seteName("Assorted salad served with selected condiments.");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);  
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Main course";//¥Dµæ
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¶Â­J´Ô¤û¥J°© ¡BÁ¤½µÃzÀs½¼¦õªãÄõ¤Îµ·­]¦Ì¶º");
                mObj.seteName("Wok fried beef short ribs in black pepper sauce " +
                		"Wok fried lobster with ginger onion sauce " +
                		"kai lan, steamed rice");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¿L¦Ï½¥¦õºî¦X®É½­¤Îµf¬õªá¦Ì¶º");
                mObj.seteName("Braised lamb shank assorted seasonal vegetables, saffron rice");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»·ÎÆt³½¦õ¸`¥Ê¡B¬õÅÚ½³¡B­·°®µf­X¥_«D¤p¦Ì¤Î®ÉÅÚµÜ©i¥ÕÂæ¥Ä");
                mObj.seteName("Seared sea bass zucchini, carrot, sun-dried tomato with couscous, " +
                		"dill and lime cream sauce");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "The bakery";//ºë¿ïÄÑ¥]                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¸q¦¡©ì¾cÄÑ¥]");
                mObj.seteName("Ciabatta bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤â±²ÄÑ¥]");
                mObj.seteName("Twist roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¾ñÆVÄÑ¥]");
                mObj.seteName("Olive roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("°g­¡­»ÄÑ¥]");
                mObj.seteName("Rosemary roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»»[ÄÑ¥]");
                mObj.seteName("Garlic bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Dessert ";//²¢ÂI
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("©u¸`ÂAªG");
                mObj.seteName("Fresh fruits of the season");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ºë¿ï°_¥q½L");
                mObj.seteName("Cheese selections");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("»È¦Õ·¦¥¤¥É¦ÌÅS");
//                mObj.setDetail("·Å¼ö (warm),§N­¹(cold)");
                mObj.seteName("White fungus, sweet corn with coconut milk sweet soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                        
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("©@°Ø¼}´µ¦õÂÐ¬Ö¤lÂæ");
                mObj.seteName("Coffee mousse with raspberry jam");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen¡VDazs ¦B²N²O");
                mObj.seteName("Haagen¡VDazs ice cream");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
             mType = "Light bites menu";//»´­¹
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("ºë½o¬õ¿N¤û¦×ÄÑ");
                mObj.seteName("Authentic Taiwanese beef noodle soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("¤@«~®üÂA´öÄÑ");
                mObj.seteName("Imperial seafood noodle soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("°ö®ÚµÔµæÄÐ¬£");
                mObj.seteName("Bacon and spinach quiche");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("¯À­¹§Y­¹ÄÑ");
                mObj.seteName("Vegetarian instant noodle");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("¦õ°s°_¥q½L");
                mObj.seteName("Cheese platter");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("ºë¿ïªG¨§");
                mObj.seteName("Mixed nuts");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
             mType = "Breakfast menu";//    ¦­À\µæ³æ
                mObj = new MenuMealTypeObj();
                alacart = "dirnk";
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¬h¾í¥Ä");
                mObj.seteName("Orange juice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);     
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Ä«ªG¥Ä");
                mObj.seteName("Apple juice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);     
                mainMeal.add(mObj);
                mObj = null;
                         
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("µf­X¥Ä");
                mObj.seteName("Tomato juice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);    
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "others";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("®É¥O¤ôªG");
                mObj.seteName("Fresh fruits of the season");
                mObj.setClassType(mClassType);              
    //          mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("âBÃþ¯Ü¤ù");
                mObj.seteName("Cereals");
                mObj.setClassType(mClassType);              
    //          mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;                
         
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Àu¹T¨Å");
                mObj.seteName("Drinking yogurt");
                mObj.setClassType(mClassType);              
    //          mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;    
                
    
                alacart="ºë¿ïÄÑ¥]¦õ¥¤ªo¤ÎªGÂæ";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥i¹|ÄÑ¥]");
                mObj.seteName("Croissant");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¿P³Á°¨ªâ");
                mObj.seteName("Oatmeal muffin");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                             
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»¿¼°íªG³J¿|");
                mObj.seteName("Banana nut cake");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("«p¤ù¦R¥q");
                mObj.seteName("Thick white toast");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                
                alacart="Main course";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ÄÑ¥]¥¬¤B¦õÂø²ù¤Î­»¯óÂæ");
                mObj.seteName("Nutella bread pudding mixed berries, vanilla sauce");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¦è¦¡±m´Ôµf­X³J¥Õ³J¥]¦õÄªµ«¡Bµf­X¡B¥[®³¤j¤õ»L¡B¬v¨¡»æ¤Î±m´Ôµf­X²ï²ï");
                mObj.seteName("Egg white omelet with bell pepper and tomato asparagus, " +
                		"tomato, Canadian ham, potato cake, bell " +
                		"pepper and tomato salsa");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("²Mµ°--  ªø¨§¦×¥½·Î³J¡B­»ªàª£Âûµ·¡B²D©Õ¤sÃÄ¡B¤­±m½¼¤¯¡Bºë¿ï¦×ÃP¡B¬ü¨ý¤p³ì³ÁÄCÀY¡B¤e¿N¶p¡B ¥t³Æ¦³ÃhÂÂÂæµæ¨Ñ®È«È¿ï¥Î");
                mObj.seteName("Plain congee--   Pan fried string bean and minced pork omelet," +
                        "Wok fried chicken with celery," +
                        "Marinated yam," +
                        "Prawn, sweet corn and soya bean," +
                        "Shredded dry pork, home made whole wheat steamed bun,barbecue pork pastry");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
        }
        
//0061        
        mClassType="C";  
        /***C¿µ***/
        if("TPEFRA".equals(sect) 
//              ||"0004".equals(fltno.substring(0,4)) || "0008".equals(fltno.substring(0,4))
//              ||"0006".equals(fltno.substring(0,4)) || "0003".equals(fltno.substring(0,4))
//              ||"0005".equals(fltno.substring(0,4)) || "0007".equals(fltno.substring(0,4))
                )
        {
            mType = "Late night supper";//®d©]«KÀ\
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("¨F©Ô");
                mObj.setName("¬K¤Ñ¦Ê¶×¨F©Ô¦õ¨~ªGÀu®æÂæ");
                mObj.seteName("Mixed green salad with mango yogurt dressing");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;            
                
                alacart = "¥Dµæ";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("µØ¯èªÅ¤¤¤å¤ÆÅW®b-¥x¦¡ºë¿ï±Æ°©ÄÑ¦õºë¿ï¤pµæ");
                mObj.seteName("Taiwanese signature dish ¡V Taiwanese style deep fried pork chop noodle soup " +
                        "with assorted side dishes");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ªQÅSÂæµá¤O¦õ¬v¨¡");
                mObj.seteName("Pan fried beef tenderloin with truffle sauce and potatoes with parsley");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ºÒ¯NÂû»L¦õªi¯S°sÂæ¥Ä¤Î¸q¦¡¦ÌÄÑ");
                mObj.seteName("Grilled chicken thigh with port wine sauce and orzo pasta");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "ºë¿ïÄÑ¥]¦õ¤â¤u¥¤ªo";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¬P³¥ÆQÄÑ¥]");
                mObj.seteName("Hoshino salty bread");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤é¦¡³nÄÑ¥]");
                mObj.seteName("soft roll");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»»[ÄÑ¥]");
                mObj.seteName("Garlic bread");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;         
                                
                alacart = "ºë¿ï²¢ÂI¶°";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ºë¿ï²¢ÂI¶°(¯N¬õ¿}¥¬¤B)");
                mObj.seteName("Dessert(Brown sugar pudding)");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
            mType ="Light bites menu";
            alacart = "ªÅ¤¤¤pÂI";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¶Ç²Î¾|¦×¶º");
                mObj.seteName("Traditional braised minced pork with braised tofu, soy egg," +
                		"yellow pickle, steamed rice");
                mObj.setClassType(mClassType);              
    //          mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("»[­]ÂD³½¬£");
                mObj.seteName("Salmon and leek pie");
                mObj.setClassType(mClassType);              
    //          mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
            mType = "Breakfast menu";//¦­À\
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("Western breakfast");
                mObj.setName("®ÉÂA¤ôªG\n" +
                        "Àu®æ\n  " +
                        "ªk¦¡°ö®ÚÖK³J:¦õÂû¦×¸z¡BÄ¨Û£¡BµÔµæ¤Î¬v½µ°ö®Úª£¬v¨¡\n" +
                        "°sÆC®Û¶êÄÑ¥]¡B¥i¹|ÄÑ¥]¡B«p¤ù¦R¥q");
                mObj.seteName("FRESH FRUITS OF THE SEASON \n" +
                        "Yogurt \n" +
                        "Baked eggs in piperade and bacon,chicken sausage, sauteed fresh spinach, sauteed button mushroom with parsley,fried potatoes with onion and bacon \n" +
                        "Longan bread mixed with red wine, croissant, white toast");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("Chinese breakfast");
                mObj.setName("²Î¤@¨§¼ß\n" +
                        "²Mµ°-ª÷¨FÂAµ«¡BXOÂæªãÂÅ¡B»ÈªÞ©ÕÂûµ·¡Bºë¿ï¦×ÃP¡BÄÐ³J¡BÅÚ½³µ·»æ");
                mObj.seteName("SOYBEAN MILK\n" +
                        "PLAIN CONGEE-Egg yolk chop with bamboo shoot,Kai lan with xo sauce,Marinated chicken with bean sprout ,Shredded dry pork, salty egg,Baked turnip cake");
                mObj.setClassType(mClassType);              
    //          mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
        }   
//0062
        if("FRATPE".equals(sect) 
//              ||"0004".equals(fltno.substring(0,4)) || "0008".equals(fltno.substring(0,4))
//              ||"0006".equals(fltno.substring(0,4)) || "0003".equals(fltno.substring(0,4))
//              ||"0005".equals(fltno.substring(0,4)) || "0007".equals(fltno.substring(0,4))
                )
        {
            mType = "Lunch menu";//¤ÈÀ\
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("«eµæ");
                mObj.setName("¼Ú¦¡®üÂAµf­X¬Ø");
                mObj.seteName("Marinated seafood stuffed in tomato cup");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                alacart = "¨F©Ô";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥Ð¶é¨F©Ô¦õ¸q¦¡ªo¾LÂæ");
                mObj.seteName("Garden salad with Italian dressing");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                alacart = "¥Dµæ";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤¤¦¡­»»[³½¬h¦õ¦Ì¶º¤Î½­µæ");
                mObj.seteName("Fried red snapper in hot garlic sauce with steamed rice and oriental vegetables");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¬õ°s½Þ±Æ¦õ¬v¨¡ªd¤ÎÂA½­");
                mObj.seteName("Seared pork in red wine sauce with mashed potato, broccoli and red pepper stripes");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»·Î¤z¨¶­»Ä«Âû±Æ¦õ¬v¨¡¤Î¬õÅÚ½³");
                mObj.seteName("Roasted chicken breast in calvados sauce with fried potato, French bean and baby carrot");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "ºë¿ïÄÑ¥]¦õ¤â¤u¥¤ªo";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("»ÄÄÑ¥]");
                mObj.seteName("Sourdough roll");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;

                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ªk¦¡ÄÑ¥]");
                mObj.seteName("baguette roll");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»»[ÄÑ¥]");
                mObj.seteName("garlic bread");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "®ÉÂA¤ôªG";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("®ÉÂA¤ôªG");
                mObj.seteName("Freshe fruits of the season");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "²¢ÂI";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥©§J¤O°_¤h³J¿|¦õÂÐ¬Ö¤lÂæ");
                mObj.seteName("Chocolate cheese cake with raspberry coulis");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
            mType = "Refreshment";//«KÀ\
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("Western refreshment");
                mObj.setName("¥Ð¶é¨F©Ô¦õªo¾LÂæ\n" +
                        "½­µæ¯N³J¬£¦õ­»·ÎÂû¬h\n" +
                        "¶Â³ÁÄÑ¥]¡B´ÔÆQÄÑ¥] \n" +
                        "ºë¿ï©u¸`ÂAªG");
                mObj.seteName("Garden salad with vinaigrette dressing\n" +
                        "Garden salad with vinaigrette dressing\n" +
                        "Pretzel roll, rye roll\n" +
                        "Freshe fruits of the season");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("Chinese refreshment");
                mObj.setName("°ö®Úª£·¦µæ¡B­»½µÃz­»¸z \n" +
                        "¥VÛ£¤e¿N´öÄÑ\n" +
                        "ºë¿ï©u¸`ÂAªG");
                mObj.seteName("Sauteed cabbage with bacon,Fried sausage with spring onion \n" +
                        "Chinese noodle soup with pork\n" +
                        "Fresh fruits of the season");
                mObj.setClassType(mClassType);              
    //          mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
        }
        

        if(mainMeal.size()<=0)
        {
            mType = "Beverage Order 1";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType("");
            mObj.setName("");
            mObj.seteName("");
            mObj.setClassType("F");              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
            
            mType = "Beverage Order 2";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType("");
            mObj.setName("");
            mObj.seteName("");
            mObj.setClassType("F");              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
            
            mType = "Beverage Order 3";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType("");
            mObj.setName("");
            mObj.seteName("");
            mObj.setClassType("F");              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
            
            mType = "Beverage Order 1";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType("");
            mObj.setName("");
            mObj.seteName("");
            mObj.setClassType("C");              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
            
            mType = "Beverage Order 2";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType("");
            mObj.setName("");
            mObj.seteName("");
            mObj.setClassType("C");              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
            
            mType = "Beverage Order 3";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType("");
            mObj.setName("");
            mObj.seteName("");
            mObj.setClassType("C");              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;            
        }
         //return array  
         MenuMealTypeObj[] mArr= new MenuMealTypeObj[mainMeal.size()];
         for(int i=0;i<mainMeal.size();i++){
            mArr[i] = (MenuMealTypeObj) mainMeal.get(i);
         }
         menu.setMenuMarr(mArr);
        
        
    }


//  2014/10/01 Q4
//  2015/01/01 Q1
    public void getMenuList(String fltno ,String fltd, String sect){

        fltno = fltno.replace("Z", "").replace("z", "");
        if(fltno.length()!=4){
            fltno = "0000".substring(0, 4 - fltno.length()) + fltno;
//            System.out.println(fltno);
        }
        menu = new MenuFunRObj();
        ArrayList drink = new ArrayList();
        ArrayList mainMeal = new ArrayList();
        
        /**************************************/
        String dType= null; 
        String dClassType = null;
        
        //¶¼®Æ
        MenuDrinkObj dObj = null;
        dClassType="F";  
        /***F¿µ***/
        dType = "Soft Drink";            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Juice");
            dObj.setDetail("O/J,A/J,T/J,Ice");
            drink.add(dObj);
            dObj = null;
                        
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Sparkling Drink");
            dObj.setDetail("Coke,Pepsi,7up,Soda,Tonic,Perrier,Ginger Ale,Ice,Lite,Lime");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
                        
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Milk");
            dObj.setDetail("Cold,Warm,Hot,Low Fat");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Mineral Water");
            dObj.setDetail("Ice,Warm,Hot,Lime");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
        //--------------------
        dType = "Cosy Lounge";
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Gin");
            //dObj.setQuantity(5);       
            dObj.setDetail("Tonic,Martini,7up,Coke,Ice");
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Vodka");
            //dObj.setQuantity(5);        
            dObj.setDetail("Tomato Juice(Bloody Mary),Orange Juice(Screwdriver),Martini,Tonic,Pepper & Salt,Tabasco,Ice");
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Whisky");
            dObj.setDetail("Jonnie Waker Blue Label Jim Beam,Kavalan,Single Malt,Scotch,Ice");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;  
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Rum");
            //dObj.setQuantity(5);   
            dObj.setDetail("coke,Ice");
            drink.add(dObj);
            dObj = null;
              
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Brandy");
            dObj.setDetail("Deau Cognac XO,Courvoisier Napoleon,Ice");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Port");
            //dObj.setQuantity(5);     
            dObj.setDetail("Taylor's,Ice");
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Cherry Brandy");
            //dObj.setQuantity(5);        
            dObj.setDetail("Ice");
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Bailey's Irish Cream");
            dObj.setDetail("Ice,Milk");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;

            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Chinese Rice Wine: Premium Shaohsing 10 Years (For Japan Routes Only)");
            //dObj.setQuantity(5);    
            drink.add(dObj);
            dObj = null;
                   
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Kizakura Ginjo  (For Japan Routes Only)");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Beer");
            //dObj.setQuantity(5);        
            dObj.setDetail("Golden Medal Taiwan,Heineken,Sapporo");
            drink.add(dObj);
            dObj = null;
        //--------------------
        dType = "Champagne/Wine";
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.setName("Champagne");
            //dObj.setQuantity(5);      
            dObj.setDetail("ªk°ê-Pol Roger¡D2000/France-Pol Roger 2000");
            drink.add(dObj);
            dObj = null;
            
            //¥Õ°s
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("¥Õ°s/White Wine");
            dObj.setDetail("ªk°ê-®L¥¬§Q¡D®L¦h¤º:2009/Chablis Chardonnay 2009,¼w°ê-¿p²ïªe¨¦¡DÄRµ·¬Â¡D2012/Germany-Mosel Valley Riesling 2012");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;   
            
            //¬õ°s            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("¬õ°s/Red Wine");
            dObj.setDetail("ªk°ê¡V¸t¦¶§Q¦w°Ï¡D®Ô°ª¤Ú¹y 1997:Saint-Julien/France-Chateau Langoa Barton 1997,¿D¬w¡V¤ÚÃ¹¨Fªe¨¦¡D§Æ«¢¡D2009/Australia-Barossa Valley Shiraz 2009,¬ü°ê-¯Ç©¬ªe¨¦¡D¬ü¬¥  2009/U.S.A.-Napa Valley Merlot Reserve 2009");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;            
        //--------------------
        dType = "Coffee / Tea";
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Coffee");
            dObj.setDetail("Latte,Cappuccino,Decaffeinated,Hot,Ice,Sugar,Cream");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Tea");
            dObj.setDetail("Oolong,Jasmine,Green tea,Darjeeling,Regular,Ice,Sugar,Cream,Black");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
            
        dClassType="C";  
        /***C¿µ***/
            dType = "Soft Drink";            
                dObj = new MenuDrinkObj();
                dObj.setType(dType);
                dObj.setClassType(dClassType);
                dObj.seteName("Juice");
                dObj.setDetail("O/J,A/J,T/J,Ice");
                drink.add(dObj);
                dObj = null;
                            
                dObj = new MenuDrinkObj();
                dObj.setType(dType);
                dObj.setClassType(dClassType);
                dObj.seteName("Sparkling Drink");
                dObj.setDetail("Coke,Pepsi,7up,Soda,Tonic,Perrier,Ginger Ale,Ice,Lite,Lime");
                //dObj.setQuantity(5);        
                drink.add(dObj);
                dObj = null;
                            
                dObj = new MenuDrinkObj();
                dObj.setType(dType);
                dObj.setClassType(dClassType);
                dObj.seteName("Milk");
                dObj.setDetail("Cold,Warm,Hot,Low Fat");
                //dObj.setQuantity(5);        
                drink.add(dObj);
                dObj = null;
                
                dObj = new MenuDrinkObj();
                dObj.setType(dType);
                dObj.setClassType(dClassType);
                dObj.seteName("Mineral Water");
                dObj.setDetail("Ice,Warm,Hot,Lime");
                //dObj.setQuantity(5);        
                drink.add(dObj);
                dObj = null;
        //--------------------
        dType = "Cosy Lounge";
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Gin");
            //dObj.setQuantity(5);       
            dObj.setDetail("Tonic,Martini,7up,Coke,Ice");
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Vodka");
            //dObj.setQuantity(5);        
            dObj.setDetail("Tomato Juice(Bloody Mary),Orange Juice(Screwdriver),Martini,Tonic,Pepper & Salt,Tabasco,Ice");
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Whisky");
            dObj.setDetail("Jonnie Waker Blue Label Jim Beam,Kavalan,Single Malt,Scotch,Ice");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;  
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Rum");
            //dObj.setQuantity(5);   
            dObj.setDetail("coke,Ice");
            drink.add(dObj);
            dObj = null;
              
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Brandy");
            dObj.setDetail("Deau Cognac XO,Courvoisier Napoleon,Ice");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Port");
            //dObj.setQuantity(5);     
            dObj.setDetail("Taylor's,Ice");
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Cherry Brandy");
            //dObj.setQuantity(5);        
            dObj.setDetail("Ice");
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Bailey's Irish Cream");
            dObj.setDetail("Ice,Milk");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
    
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Chinese Rice Wine: Premium Shaohsing 10 Years (For Japan Routes Only)");
            //dObj.setQuantity(5);    
            dObj.setDetail("Ice");
            drink.add(dObj);
            dObj = null;
                   
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Kizakura Ginjo  (For Japan Routes Only)");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Beer");
            //dObj.setQuantity(5);        
            dObj.setDetail("Golden Medal Taiwan,Heineken,Sapporo");
            drink.add(dObj);
            dObj = null;
        //--------------------
        dType = "Champagne/Wine";
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.setName("Champagne");
            //dObj.setQuantity(5);      
            dObj.setDetail("ªk°ê GREMILLET­»Âb/France Champagne Gremillet");
            drink.add(dObj);
            dObj = null;
            
            //¥Õ°s
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("¥Õ°s/White Wine");
            dObj.setDetail("ªk°ê ¡V®L¥¬§Q¤@¯Å¸²µå¶é ®L¦h¤º 2010/France-Chablis 1er Cru Chardonnay 2010,¼w°ê -¿p²ïªe¨¦¡DÄRµ·¬Â¡D2012/Germany-Mosel Valley Riesling 2012");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;   
            
            //¬õ°s            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("¬õ°s/Red Wine");
            dObj.setDetail("ªk°ê¡D©Ô°ª³ù¡D2006/France-Chateau La Gorce 2006,¸q¤j§Q - ©_´­²Ä¬ÃÂÃ¡A2011/Italy-Chianti Riserva DOCG 2011,¬ü°ê¡D¯Ç©¬ªe¨¦¡D¬ü¬¥ 2009/U.S.A.-Napa Valley Merlot Reserve 2009");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null; 
        //--------------------
        dType = "Coffee/Tea";
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Coffee");
            dObj.setDetail("Latte,Cappuccino,Decaffeinated,Hot,Ice,Sugar,Cream");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Tea");
            dObj.setDetail("Oolong,Jasmine,Green tea,Darjeeling,Regular,Ice,Sugar,Cream,Black");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
            
        //return array  
        MenuDrinkObj[] dArr= new MenuDrinkObj[drink.size()];
        for(int i=0;i<drink.size();i++){
            dArr[i] = (MenuDrinkObj) drink.get(i);
        }
        menu.setMenuDarr(dArr);
    
 /**************************************/
        
        String mType= null; 
        String mClassType = null;
        String alacart = null;
        //À\ÂI
        MenuMealTypeObj mObj = null;        
            
        if("0004".equals(fltno))
        {
            mClassType="F";  
            /***F¿µ***/   
            mType = "Late night supper";//®d©]«KÀ\
                alacart = "Appetizer";//«eµæ
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¯Q³½¤l§N½L");
                mObj.seteName("Roasted karasumi");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Àn¨x¬£¦õµLªáªG¾®½¦¤Î»eº{¤ôªG");
                mObj.seteName("Duck liver pate with fig jelly and confit fruits");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                alacart = "Soup";//´ö«~
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("³·±ù»È¦Õ¿LÂû´ö");
                mObj.seteName("Stewed pear and white fungus chicken soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¸q¦¡³¯¾Lµf­X«C»[´ö");
                mObj.seteName("Cream soup of vine tomatoes and spring leek with aged balsamic vinegar");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
//                alacart = "Salad";//¨F©Ô
//                mObj = new MenuMealTypeObj();
//                mObj.setMealType(mType);
//                mObj.setAlacartType(alacart);
//                mObj.setName("ºë½o¨F©Ô¦õºë¿ï°t®Æ");
//                mObj.setDetail("¯S¯Å¾ñÆVªo(extra virgin olive oil),¸q¤j§Q³¯¦~¸²µå¾L(balsamic vinegar),±ö­»ªÛ³ÂÂæ(sesame plum dressing)");
//                mObj.seteName("Garden salad served with selected condiments");
//                mObj.setClassType(mClassType);              
//    //            mObj.setQuantity(5);        
//                mainMeal.add(mObj);
//                mObj = null;
                
                alacart = "Main course";//¥Dµæ
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ªO®ß¥ÕªG¿N¦×¡B¨§¶p÷«³½¡B¤õ»Lµ·«½«½µæ¤Î¥Õ¶º");
                mObj.setDetail("¤QâB¦Ì¶º(healthy multi grains rice)");
                mObj.seteName("Stewed chestnut ginkgo nut pork bell, steamed cod fish with pan-fried crisp bean Stir fried ham cabbage and steamed rice");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                             
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»·Î®üÆt³½µá¤O¦õÂAµð¦×¤Î®ü±aÂæ¥Ä");
//                mObj.setDetail("­»®Æ¿»­X¥¤ªoÂæ¥Ä(pesto-tomato cream sauce),ªi¯S°sÂæ¥Ä(port wine sauce)");
                mObj.seteName("Sea bass filet with clam and seaweed sauce");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                              
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¦Ï¨{µßÂû»L±²¡B¸q¦¡Àí®É½­¡BªQÅSÂæ¼eÄÑ");
//                mObj.setDetail("­»®Æ¿»­X¥¤ªoÂæ¥Ä(pesto-tomato cream sauce),ªi¯S°sÂæ¥Ä(port wine sauce)");
                mObj.seteName("Pan-fried morel stuffed chicken thigh with port balsamic sauce Ratatouille and fettuccine with truffle oil");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "The bakery";//ºë¿ïÄÑ¥]
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¬P³¥ÆQÄÑ¥]");
                mObj.seteName("Hoshino salty bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¸ªªá¤lÄÑ¥]");
                mObj.seteName("Sunflower seed roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥ÛÆQ°_¤hÄÑ¥]");
                mObj.seteName("Rock salt and cheese bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤é¦¡³nÄÑ¥]");
                mObj.seteName("Italian style spice bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»»[ÄÑ¥]");
                mObj.seteName("Garlic bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Sweet finale";//²¢»e§¹¬üºë¿ï
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("®É¥O¤ôªG");
                mObj.seteName("Seasonal fresh fruit");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ºë¿ï°_¥q½L");
                mObj.seteName("Selection of cheese");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ª÷®Ü¿L­»±ùÅS");
                mObj.seteName("Stewed kumquat and pear soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥©§J¤OµJ¿}»q­»®Æ¦õ¦Ê­»ªG¥¤ªo¤Î©Ù¯ù§ö¤¯");
                mObj.seteName("Chocolate fudge with spices, passion fruit cream and matcha almonds");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen¡VDazs ¦B²N²O");
                mObj.seteName("Haagen¡VDazs ice cream");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
             mType = "Light bites menu";//»´­¹
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("¬õ¿N¥xÆW¤û¦×ÄÑ (¥i¨É¥Î§Ö³tºë½oÄÑÂI)");
                mObj.seteName("Authentic Taiwanese beef noodle soup (Beef is originated from Taiwan)");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("­W¯ùªoÄÑ½u");
                mObj.seteName("White angel hair noodles with camellia oil");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("¤sÃÄ¿LªQ¦×´ö");
                mObj.seteName("Stewed Chinese yam with pork jowl meat");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("³¥Û£¤û¦×¶p");
                mObj.seteName("Fresh mushrooms beef puff (Beef is originated from New Zealand)");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("¯À­¹§Y­¹ÄÑ");
                mObj.seteName("Vegetarian instant noodle");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("ºë¿ï°_¥q½L");
                mObj.seteName("Cheese platter");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("ºë¿ïªG¨§");
                mObj.seteName("Mixed nuts");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
             mType = "Breakfast menu";//    ¦­À\µæ³æ
                mObj = new MenuMealTypeObj();
                alacart = "dirnk";
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¬h¾í¥Ä");
                mObj.seteName("Orange");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Ä«ªG¥Ä");
                mObj.seteName("Apple");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                         
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("µf­X¥Ä");
                mObj.seteName("Tomato");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                              
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("²Î¤@¨§¼ß");
                mObj.seteName("Soy bean milk");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "others";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("®É¥O¤ôªG");
                mObj.seteName("Fresh fruits of the season");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("âBÃþ¯Ü¤ù");
                mObj.seteName("Cereals");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;                
         
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Àu®æ");
                mObj.seteName("Yogurt ");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;    
                

                alacart="ºë¿ïÄÑ¥]¦õ¥¤ªo¤ÎªGÂæ";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("°sÆC®Û¶êÄÑ¥]");
                mObj.seteName("Longan bread mixed with red wine");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥i¹|ÄÑ¥]");
                mObj.seteName("Chocolate bread with dried orange peel");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                             
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¾í¥Ö¥i¥i¨È");
                mObj.seteName("Danish with rum raisin");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("«p¤ù¥Õ¦R¥q");
                mObj.seteName("White Toast");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                
                alacart="Main course";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("©¬º¿°_¤hÖK³J¡B½Þ¦×¸z¡Bª£­»®Æ¬v¨¡");
                mObj.seteName("Parma ham and cheese in baked egg, pork sausage, sauteed potatoes with herbs");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("»[°_¤hÂtÂD¦õ«n¥Ê¯M³J¡BÂû¦×¸z¡B½¼¦i½µ¬v¨¡");
                mObj.seteName("Smoked salmon and boursin cheese on pumpkin omelette, chicken sausage,boiled new potatoes with chive");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¶³¦Õª£ÂAµ«¡B¦×¥½¥|©u¨§¡BÂæ¥Ä¨§»G­X¡B²D©Õ¶À¨§ªÞ,ÄÐ³J¡B¤¤¦¡¤â¤uÄCÀY¡B¤¤¦¡¤â¤uÄCÀY");
                mObj.setDetail("²Mµ°(Plain congee),¤p¦Ìµ°(millet porridge)");
                mObj.seteName("Stir fried bamboo shoot and fungus," +
                        " Stir fried pork mince and green beans with soy sauce," +
                        " Tofu and eggplant with garlic soy paste," +
                        " Bean sprouts salad" +
                        " Salty egg, homemade Chinese steamed bun" +
                        "Traditional Taiwanese side dishes are available upon request");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
             
        }
        else if("0006".equals(fltno))//#777
        {
            mClassType="C";  
            /***C¿µ***/   
            mType = "Dinner menu";//±ßÀ\
//            
                alacart = "Appetizer,Salad,Soup";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("«eµæ-ÂtÂD³½ªá ¬c¤l­á\n" +
                        "¨F©Ô-ºî¦X¨F©Ô¦õ©M­·ªÛ³ÂÂæ\n" +
                        "´ö«~-¤sÃÄ¬e§û±Æ°©´ö");
                mObj.seteName("Smoked salmon rose and pomelo lemon jelly\n" +
                        "Mixed green saladwith sesame mayonnaise\n"+
                        "Pork rib with yam and wolfberry soup\n");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(40);        
                mainMeal.add(mObj);
                mObj = null;  
                alacart = "Main course";//¥Dµæ
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("©yÄõ¤T¬P½µ¿N¤l±Æ\n ©u¸`ÂA½­ ¥Õ¶º");
                mObj.seteName("Braised pork ribs with Yi-Lanspring onion\n" +
                        "Stir-fried vegetables and steamedrice");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                           
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»·ÎÆt³½µá¤O\n©u¸`ÂA½­ ¬õ¬v¨¡\nµð¸Ä²Hµæ¥Õ°sÂæ");
//                mObj.setDetail("­»®Æ¿»­X¥¤ªoÂæ¥Ä(pesto-tomato cream sauce),ªi¯S°sÂæ¥Ä(port wine sauce)");
                mObj.seteName("Pan friedsea bass filet\n" +
                        "Seasonal vegetables and new potatoes\n" +
                        "Clam and mussel basewithwine sauce");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                                          
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¦Ï¨{µßÂû»L±²\n¸q¦¡Àí®É½­ ªQÅSÂæ¼eÄÑ");
//                mObj.setDetail("­»®Æ¿»­X¥¤ªoÂæ¥Ä(pesto-tomato cream sauce),ªi¯S°sÂæ¥Ä(port wine sauce)");
                mObj.seteName("Pan-fried morel stuffed chicken thigh with port balsamic sauce\n" +
                        "Ratatouille andfettuccine witht ruffle oil");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                        
                alacart = "Assorted bread selection";//ÄÑ¥]
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¬P³¥ÆQÄÑ¥]");
                mObj.seteName("Hoshino salty bread");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤é¦¡³n¥]");
                mObj.seteName("Japanese soft roll");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(40);        
                mainMeal.add(mObj);
                mObj = null;

                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»»[ÄÑ¥]");
                mObj.seteName("Garlic bread");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;                
                
                alacart = "Sweet finale";//²¢»e§¹¬üºë¿ï
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("©u¸`¤ôªG");
                mObj.seteName("fresh fruits of the season");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(40);  
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("°_¤h½L");
                mObj.seteName("Cheese platter");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(40);       
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥©§J¤OµJ¿}»q­»®Æ¦õ¦Ê­»ªG¥¤ªo¤Î©Ù¯ù§ö¤¯");
                mObj.seteName("Chocolate Fudge with OrientalSpices, Passion Fruit Cream andMatcha Almonds");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(40);         
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen¡VDazs ¦B²N²O");
                mObj.seteName("Haagen¡VDazs ice cream");
                mObj.setClassType(mClassType);    
                mObj.setDetail("­»¯ó,¯ó²ù");
                mObj.setQuantity(40);        
                mainMeal.add(mObj);
                mObj = null;                
                       
             mType = "Gourmet savory";
                alacart = "ºë¬üÂI¤ß";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("º±¦×¶º");
                mObj.seteName("Traditional Taiwan bolognaise meat sauce Served with soy sauce-braised egg, takuwan, steamed rice");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("³¥Û£¤û¦×¶p(¤û¦×¨Ó·½¡G ¯Ã¦èÄõ)");
                mObj.seteName("Fresh mushrooms beef puff");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
               
            mType = "Breakfast menu";//¦­À\µæ³æBreakfast menu
                alacart = "Breakfast";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¦è¦¡-\n" +
                        "®ÉÂA¤ôªG Àu®æ\n" +
                        "¥Dµæ-ÂtÂDµÔµæªk¦¡³J±²\nÄ¨Û£ ¿»­X ªá·¦µæ");
                mObj.setDetail("°sÆC®Û¶êÄÑ¥](Longan bread mixed with red wine),¥i¹|(Croissant),¥Õ¦R¥q(White toast)");
                mObj.seteName("Fresh fruits of the season, Yogurt\n" +
                        "Main course-\nSmoked salmon spinach scrambled eggs crepe\n" +
                        "Button mushroom, tomato, broccoli");
                mObj.setClassType(mClassType);             
                mObj.setDetail("­»Âb¯ñºwÂûºë");
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
//                alacart = "Chinese breakfast";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤¤¦¡-\n" +
                        "²Î¤@¨§¼ß  ®ÉÂA¤ôªG\n" +
                        "¤pµæºë¿ï:¶³¦Õª£ÂAµ«,¦×¥½¥|©u¨§,­X¤l¨§»G²D©Õ¶À¨§ªÞ,²Mµ°,¤¤¦¡¬üÂI");
//                mObj.setDetail("²Mµ°(Plain congee),¿P³Áµ°(mung bean congee)");
                mObj.seteName("Soy bean milk ,Fresh fruits of the season \n" +
                        "Assorted delicatessen:\n" +
                        "Stir-fried bamboo shoot with fungus,\n" +
                        "Stir-fried pork and green beans with soy sauce,\n" +
                        "Tofu and eggplant with garlic soy paste,\n" +
                        "Bean sprouts salad,salty egg,\n " +
                        "Plain congee\n" +
                        "Steamed bun");
                mObj.setClassType(mClassType);              
                mObj.setDetail("­»Âb¯ñºwÂûºë");
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
          }
          else if( "0008".equals(fltno) ) //#777
          {
              mClassType="C";  
              /***C¿µ***/   
          mType = "Late night supper";//®d©]«KÀ\
              alacart = "Salad,Soup,Sweet finale";
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("¨F©Ô-ºî¦X¨F©Ô¦õ©M­·ªÛ³ÂÂæ\n" +
                      "´ö«~-¤sÃÄ¬e§û±Æ°©´ö\n" +
                      "²¢ÂI-Haagen¡VDazs ¦B²N²O(­»¯ó/¯ó²ù)");
              mObj.seteName("Salad-Mixed green saladwith sesame mayonnaise\n"+
                      "Soup-Pork rib with yam and wolfberry soup\n" +
                      "Sweet finale-Haagen¡VDazs ice cream");
              mObj.setClassType(mClassType);  
              mObj.setDetail("­»¯ó,¯ó²ù");
              mObj.setQuantity(40);        
              
              mainMeal.add(mObj);
              mObj = null;  
              alacart = "Main course";//¥Dµæ
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("©yÄõ¤T¬P½µ¿N¤l±Æ\n ©u¸`ÂA½­ ¥Õ¶º");
              mObj.seteName("Braised pork ribs with Yi-Lanspring onion\n" +
                      "Stir-fried vegetables and steamedrice");
              mObj.setClassType(mClassType);              
//              mObj.setQuantity(10);        
              mainMeal.add(mObj);
              mObj = null; 
                         
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("­»·ÎÆt³½µá¤O\n©u¸`ÂA½­ ¬õ¬v¨¡\nµð¸Ä²Hµæ¥Õ°sÂæ");
//              mObj.setDetail("­»®Æ¿»­X¥¤ªoÂæ¥Ä(pesto-tomato cream sauce),ªi¯S°sÂæ¥Ä(port wine sauce)");
              mObj.seteName("Pan friedsea bass filet\n" +
                      "Seasonal vegetables and new potatoes\n" +
                      "Clam and mussel basewithwine sauce");
              mObj.setClassType(mClassType);              
//              mObj.setQuantity(10);        
              mainMeal.add(mObj);
              mObj = null; 
                                        
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("¦Ï¨{µßÂû»L±²\n¸q¦¡Àí®É½­ ªQÅSÂæ¼eÄÑ");
//              mObj.setDetail("­»®Æ¿»­X¥¤ªoÂæ¥Ä(pesto-tomato cream sauce),ªi¯S°sÂæ¥Ä(port wine sauce)");
              mObj.seteName("Pan-fried morel stuffed chicken thigh with port balsamic sauce\n" +
                      "Ratatouille andfettuccine witht ruffle oil");
              mObj.setClassType(mClassType);              
//              mObj.setQuantity(10);        
              mainMeal.add(mObj);
              mObj = null;
                      
              alacart = "Assorted bread selection";//ÄÑ¥]
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("¬P³¥ÆQÄÑ¥]");
              mObj.seteName("Hoshino salty bread");
              mObj.setClassType(mClassType);              
              mObj.setQuantity(20);        
              mainMeal.add(mObj);
              mObj = null;
              
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("¤é¦¡³n¥]");
              mObj.seteName("Japanese soft roll");
              mObj.setClassType(mClassType);              
              mObj.setQuantity(40);        
              mainMeal.add(mObj);
              mObj = null;

              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("­»»[ÄÑ¥]");
              mObj.seteName("Garlic bread");
              mObj.setClassType(mClassType);              
              mObj.setQuantity(20);        
              mainMeal.add(mObj);
              mObj = null;                
                     
           mType = "Gourmet savory";//»´­¹
              alacart = "ºë¬üÂI¤ß";
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setName("º±¦×¶º");
              mObj.seteName("Traditional Taiwan bolognaise meat sauce Served with soy sauce-braised egg, takuwan, steamed rice");
              mObj.setClassType(mClassType);              
//              mObj.setQuantity(20);        
              mainMeal.add(mObj);
              mObj = null;
              
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setName("³¥Û£¤û¦×¶p(¤û¦×¨Ó·½¡G ¯Ã¦èÄõ)");
              mObj.seteName("Fresh mushrooms beef puff");
              mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
              mainMeal.add(mObj);
              mObj = null;
              
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setName("°_¤h½L");
              mObj.seteName("Cheese platter");
              mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
              mainMeal.add(mObj);
              mObj = null;
                           
          mType = "breakfast menu";//¦­À\µæ³æBreakfast menu
              alacart = "Breakfast";
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("¦è¦¡-\n" +
                      "®ÉÂA¤ôªG Àu®æ\n" +
                      "¥Dµæ-ÂtÂDµÔµæªk¦¡³J±²\nÄ¨Û£ ¿»­X ªá·¦µæ");
              mObj.setDetail("°sÆC®Û¶êÄÑ¥](Longan bread mixed with red wine),¥i¹|(Croissant),¥Õ¦R¥q(White toast)");
              mObj.seteName("Fresh fruits of the season, Yogurt\n" +
                      "Main course-\nSmoked salmon spinach scrambled eggs crepe\n" +
                      "Button mushroom, tomato, broccoli");
              mObj.setClassType(mClassType);          
              mObj.setDetail("­»Âb¯ñºwÂûºë");
  //            mObj.setQuantity(5);        
              mainMeal.add(mObj);
              mObj = null;
              
//              alacart = "Chinese breakfast";
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("¤¤¦¡-\n" +
                      "²Î¤@¨§¼ß  ®ÉÂA¤ôªG\n" +
                      "¤pµæºë¿ï:¶³¦Õª£ÂAµ«,¦×¥½¥|©u¨§,­X¤l¨§»G²D©Õ¶À¨§ªÞ,²Mµ°,¤¤¦¡¬üÂI");
//              mObj.setDetail("²Mµ°(Plain congee),¿P³Áµ°(mung bean congee)");
              mObj.seteName("Soy bean milk ,Fresh fruits of the season \n" +
                      "Assorted delicatessen:\n" +
                      "Stir-fried bamboo shoot with fungus,\n" +
                      "Stir-fried pork and green beans with soy sauce,\n" +
                      "Tofu and eggplant with garlic soy paste,\n" +
                      "Bean sprouts salad,salty egg,\n " +
                      "Plain congee\n" +
                      "Steamed bun");
              mObj.setClassType(mClassType);  
              mObj.setDetail("­»Âb¯ñºwÂûºë");
  //            mObj.setQuantity(5);        
              mainMeal.add(mObj);
              mObj = null;
        }
       
//        if(sect.substring(4).equals("TPE"))    
        if("0003".equals(fltno))
        {
            mClassType="F";  
            /***F¿µ***/  
            mType = "Late night supper";//®d©]«KÀ\
                alacart = "Appetizer";//«eµæ
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("§¶µMªÛ³Â¦Ï±Æ¡B²D©Õ®ü­õ¥Ö¡BÁ¤¥ÄÂû");
                mObj.seteName("Cumin lamb chop, marinated jelly fish, chicken with ginger sauce");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥§´µ¨F©Ô ¡X ÂC³½¡B¥|©u¨§¡B¬v¨¡¡Bµf­X¡B¶Â¾ñÆV");
                mObj.seteName("Nicoise salad ¡X tuna, green beans, potato, tomato, black olive");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                alacart = "Soup";//´ö«~
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥V©u´þ¸É´ö ¡X ®üÁ³ÂÎ®Lªá¿L´ö");
                mObj.seteName("Braised chinese soup ¡X conch, mushroom, yam, Chinese herbs");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Âû¦×Ä¨Û£´ö");
                mObj.seteName("Chicken and mushroom consomme, garnish with mushroom flan");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Main course";//¥Dµæ
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¿LµN»[¨ý®ü°Ñ¦×¤Y¡Bª÷µØ¤õ»LÂû¦õºî¦X®É½­¤Î¦Ì¶º");
                mObj.seteName("Braised sea cucumber and meat balls in garlic sauce, steamed chicken with Chinese ham, assorted mixed vegetables, steamed rice");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ºÒ¯N¤ûµá¤O¦õ«Cªáµæ¡Bªá·¦µæ¡B±m´Ô¡B¯N¬v¨¡»T¤Î¬õ°sÂæ¥Ä");
                mObj.seteName("Grilled beef tenderloin, broccoli, cauliflower, bell pepper, duchess potato, red wine sauce");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¸q¤j§QÀs½¼»å¡B©ú½¼¦õ½­µæ±²¤Îµf­XÀs½¼¥¤ªoÂæ");
                mObj.seteName("Lobster ravioli with prawn vegetable bundle, lobster tomato cream sauce");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "The bakery";//ºë¿ïÄÑ¥]                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¸q¦¡©ì¾cÄÑ¥]");
                mObj.seteName("Ciabatta bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ÂøÂ³ÄÑ¥]");
                mObj.seteName("Multi grain roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥¤ªoÄÑ¥]");
                mObj.seteName("Brioche roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»®ÆÄÑ¥]");
                mObj.seteName("Focaccia roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»»[ÄÑ¥]");
                mObj.seteName("Garlic bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Dessert ";//²¢ÂI
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("©u¸`ÂAªG");
                mObj.seteName("Fresh fruits of the season");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ºë¿ï°_¥q½L");
                mObj.seteName("Selection of cheese");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¿LÀs²´¬õ´Ç´ö ");
                mObj.setDetail("·Å¼ö (warm),§N­¹(cold)");
                mObj.seteName("Braised longan, Chinese date");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥©§J¤OÄÑ¥]¥¬¤B¦õÂø²ù¤Î­»¯óÂæ");
                mObj.seteName("Chocolate bread pudding, mixed berries, vanilla sauce");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen¡VDazs ¦B²N²O");
                mObj.seteName("Haagen¡VDazs ice cream");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
             mType = "Light bites menu";//»´­¹
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("ºë½o¬õ¿N¤û¦×ÄÑ");
                mObj.seteName("Authentic Taiwanese beef noodle soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("±Æ°©´öÄÑ");
                mObj.seteName("Deep fired pork cutlet with noodle soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("Âû¦×«ÂÆF¹y¦õ¨F©Ô");
                mObj.seteName("Chicken wellington");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("¯À­¹§Y­¹ÄÑ");
                mObj.seteName("Vegetarian instant noodle");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("¦õ°s°_¥q½L");
                mObj.seteName("Cheese platter");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("ºë¿ïªG¨§");
                mObj.seteName("Mixed nuts");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
             mType = "Breakfast menu";//    ¦­À\µæ³æ
                mObj = new MenuMealTypeObj();
                alacart = "dirnk";
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¬h¾í¥Ä");
                mObj.seteName("Orange juice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);   
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Ä«ªG¥Ä");
                mObj.seteName("Apple juice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                         
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("µf­X¥Ä");
                mObj.seteName("Tomato juice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);    
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "others";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("®ÉÂA¤ôªG");
                mObj.seteName("Fresh fruits of the season");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);  
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("âBÃþ¯Ü¤ù");
                mObj.seteName("Cereals");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);  
                mainMeal.add(mObj);
                mObj = null;                
         
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Àu¹T¨Å");
                mObj.seteName("Drinking yogurt");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);      
                mainMeal.add(mObj);
                mObj = null;    
                
    
                alacart="ºë¿ïÄÑ¥]¦õ¥¤ªo¤ÎªGÂæ";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¬õÅÚ½³®Ö®ç°¨ªâ");
                mObj.seteName("Chocolate muffin");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("§ö¤¯¥i¹|");
                mObj.seteName("Almond croissant");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                             
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ÂÅ²ù¯N»æ");
                mObj.seteName("Blueberry scone");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("«p¤ù¦R¥q");
                mObj.seteName("Thick white toast");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                
                alacart="Main course";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¦è¦¡ª£³J°t»Ä¥¤¦õ¸`¥Ê¡Bµf­X¡BÂû¦×¸z¤Î¬v¨¡»æ");
                mObj.seteName("Cheese omelet portabella mushroom, tomato, chicken sausage, fingerling potato");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ºdªG¥©§J¤OÄÑ¥]¥¬¤B¦õÂø²ù¡B½Þ¨½¦Ù¤Î­»¯óÂæ");
                mObj.seteName("Corn and scallion pancake peach compote, tomato, chicken sausage");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("²Mµ°--¶}¶§¥Õµæ¡B¬õ¿N¦Ë²Æ¦×µ·¨§»G¡Bª÷µØÀpÀm¤ì¦Õ¡B²D©Õ¤zµ·¡B  ºë¿ï¦×ÃP¡B¬ü¨ý¤pÄCÀY¡B ¥t³Æ¦³ÃhÂÂÂæµæ¨Ñ®È«È¿ï¥Î");
                mObj.seteName("Plain congee--  Stir-fried Napa cabbage with dried shrimp," +
                        "Braised bean curd with bamboo pith and pork julienne in brown sauce," +
                        "Stir-fried double color fungus," +
                        "Marinated bean curd sheet with shredded vegetables." +
                        "Shredded dry pork, homemade steamed bun." +
                        "Traditional Taiwanese side dishes are available upon request");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
        }
        else if ("0005".equals(fltno))//#777
        {
            mClassType="C";  
            /***C¿µ***/   
            mType = "Dinner menu";//±ßÀ\
            alacart = "Appetizer,Salad,Soup";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("«eµæ-®ü¸½¡E ÂA½¼¡E ¯N¤û¦×¦õ»[­»³J¶ÀÂæ¤Î¼sªFªwµæ\n" +
                    "¨F©Ô-ºî¦X¨F©Ô¤Î¸q¤j§Qªo¾L\n" +
                    "´ö«~-ª÷°w±Æ°©´ö");
            mObj.seteName("Appetizer-Roast beef rosette with pesto aioli & steamed flower prawn, jelly fish salad\n" +
                    "Salad-Seasonal leafy salad- Italian balsamic olive dressing\n"+
                    "Soup-Braised pork ribs with lily flower soup\n");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(40);        
            mainMeal.add(mObj);
            mObj = null;  
            alacart = "Main course";//¥Dµæ
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("Ä®ªoÀj³½Âû¦×\n ©u¸`ÂA½­ ¥Õ¶º");
            mObj.seteName("Braised abalone and chicken with oyster sauce\n" +
                    "Stir-fried vegetable, steamed rice");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null; 
                       
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("­»·Îµá¤O¤û±Æ\n¬v¨¡»T ªá·¦µæ ¬õ°sÂæ");
//            mObj.setDetail("­»®Æ¿»­X¥¤ªoÂæ¥Ä(pesto-tomato cream sauce),ªi¯S°sÂæ¥Ä(port wine sauce)");
            mObj.seteName("Pan seared beef filet\n" +
                    "Duchess pomme, heirloom cauliflower with bordelaise sauce\n");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null; 
                                      
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("¨ýäø´¼§Q®üÆt\n®É½­  ¬v¨¡  ´¶Ã¹©ô´µÂæ");
//            mObj.setDetail("­»®Æ¿»­X¥¤ªoÂæ¥Ä(pesto-tomato cream sauce),ªi¯S°sÂæ¥Ä(port wine sauce)");
            mObj.seteName("Miso glazed Chilean sea bass\n" +
                    "Vegetable, buttered potato, pancetta provencal sauce");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
                    
            alacart = "Assorted bread selection";//ÄÑ¥]
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("­»»[ÄÑ¥]");
            mObj.seteName("Garlic bread");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(40);        
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("¥¤ªoÄÑ¥]");
            mObj.seteName("brioche roll");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(40);        
            mainMeal.add(mObj);
            mObj = null;

            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("¤p³ÁÄÑ¥]");
            mObj.seteName("wheat roll");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(40);        
            mainMeal.add(mObj);
            mObj = null;                
            
            alacart = "Sweet finale";//²¢»e§¹¬üºë¿ï
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("¤ôªG");
            mObj.seteName("fresh fruits of the season");
            mObj.setClassType(mClassType);
            mObj.setQuantity(40);       
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("°_¤h½L");
            mObj.seteName("Cheese platter");
            mObj.setClassType(mClassType); 
            mObj.setQuantity(40);       
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("¤ñ§Q®É¥©§J¤O¼}µ·³J¿|");
            mObj.seteName("Belgium chocolate mousse cake");
            mObj.setClassType(mClassType);
            mObj.setQuantity(40);       
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("Haagen¡VDazs ¦B²N²O");
            mObj.seteName("Haagen¡VDazs ice cream");
            mObj.setClassType(mClassType);
            mObj.setDetail("­»¯ó,¯ó²ù");
            mObj.setQuantity(40);          
            mainMeal.add(mObj);
            mObj = null;                
                   
         mType = "Gourmet savory";
            alacart = "ºë¬üÂI¤ß";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setName("ºë¿ï´ä¦¡¤pÂI");
            mObj.seteName("Assorted delicate dim sum");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(20);        
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setName("¨Å¹T³J¶ð");
            mObj.seteName("Four cheese quiche");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
           
        mType = "Breakfast menu";//¦­À\µæ³æBreakfast menu
            alacart = "Breakfast";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("¦è¦¡-\n" +
                    "®ÉÂA¤ôªG Àu®æ\n" +
                    "¥Dµæ-·Î¦³¾÷Âû³J¦õ¿»­X²ï²ï\n¬v¨¡ Âû¦×¸z");
            mObj.setDetail("¥i¹|(Croissant),Ä«ªG¤¦³Á(apple Danish),¥Õ¦R¥q(White toast)");
            mObj.seteName("Fresh fruits of the season, Yogurt\n" +
                    "Main course-\nBaked organic eggs with tomato salsa\n" +
                    "Yukon potato and chicken sausage");
            mObj.setClassType(mClassType);   
//            mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
            
//            alacart = "Chinese breakfast";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("¤¤¦¡-\n" +
                    "®ÉÂA¤ôªG\n" +
                    "¤pµæºë¿ï:¶}¶§¥Õµæ,¬õ¿N¦Ë²Æ¦×µ·¨§»G,ª÷µØÀpÀm¤ì¦Õ,ºë¿ï¦×ÃP,²Mµ°,¤¤¦¡¬üÂI");
//            mObj.setDetail("²Mµ°(Plain congee),¿P³Áµ°(mung bean congee)");
            mObj.seteName("Fresh fruits of the season\n" +
                    "Assorted delicatessen:\n" +
                    "Stir-fried Napa cabbage with dried shrimp," +
                    "Braised bean curd with bamboo pith and pork julienne in brown sauce\n" +
                    "Stir-fried double color fungus,Shredded dry pork\n " +
                    "Plain congee\n" +
                    "Steamed bun");
            mObj.setClassType(mClassType);      
//            mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
            
        }
        else if("0007".equals(fltno))//#777
        {

            mClassType="C";  
            /***C¿µ***/   
            mType = "Late night supper";//®d©]«KÀ\
                alacart = "Salad,Soup,Sweet finale";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¨F©Ô-ºî¦X¨F©Ô¤Î¸q¤j§Qªo¾L\n" +
                        "´ö«~-ª÷°w±Æ°©´ö\n" +
                        "²¢ÂI-Haagen¡VDazs ¦B²N²O(­»¯ó/¯ó²ù)");
                mObj.seteName("Salad-Seasonal leafy salad- Italian balsamic olive dressing\n"+
                        "Soup-Braised pork ribs with lily flower soup\n" +
                        "Sweet finale-Haagen¡VDazs ice cream");
                mObj.setClassType(mClassType);         
                mObj.setDetail("­»¯ó,¯ó²ù");
                mObj.setQuantity(40);        
                mainMeal.add(mObj);
                
                mObj = null;  
                alacart = "Main course";//¥Dµæ
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Ä®ªoÀj³½Âû¦×\n ©u¸`ÂA½­ ¥Õ¶º");
                mObj.seteName("Braised abalone and chicken with oyster sauce\n" +
                        "Stir-fried vegetable, steamed rice");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                           
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»·Îµá¤O¤û±Æ\n¬v¨¡»T ªá·¦µæ ¬õ°sÂæ");
    //            mObj.setDetail("­»®Æ¿»­X¥¤ªoÂæ¥Ä(pesto-tomato cream sauce),ªi¯S°sÂæ¥Ä(port wine sauce)");
                mObj.seteName("Pan seared beef filet\n" +
                        "Duchess pomme, heirloom cauliflower with bordelaise sauce");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                                          
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¨ýäø´¼§Q®üÆt\n®É½­ ¬v¨¡  ´¶Ã¹©ô´µÂæ");
    //            mObj.setDetail("­»®Æ¿»­X¥¤ªoÂæ¥Ä(pesto-tomato cream sauce),ªi¯S°sÂæ¥Ä(port wine sauce)");
                mObj.seteName("Miso glazed Chilean sea bass\n" +
                        "Vegetable, buttered potato, pancetta provencal sauce");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                        
                alacart = "Assorted bread selection";//ÄÑ¥]
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»»[ÄÑ¥]");
                mObj.seteName("Garlic bread");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(40);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥¤ªoÄÑ¥]");
                mObj.seteName("brioche roll");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(40);        
                mainMeal.add(mObj);
                mObj = null;
    
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤p³ÁÄÑ¥]");
                mObj.seteName("wheat roll");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(40);        
                mainMeal.add(mObj);
                mObj = null;                
                       
             mType = "Gourmet savory";//»´­¹
                alacart = "ºë¬üÂI¤ß";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("ºë¿ï´ä¦¡¤pÂI");
                mObj.seteName("Assorted delicate dim sum");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("¨Å¹T³J¶ð");
                mObj.seteName("Four cheese quiche");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("°_¤h½L");
                mObj.seteName("Cheese platter");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                             
            mType = "Breakfast menu";//¦­À\µæ³æBreakfast menu
                alacart = "Breakfast";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¦è¦¡-\n" +
                        "®ÉÂA¤ôªG Àu®æ\n" +
                        "¥Dµæ-·Î¦³¾÷Âû³J¦õ¿»­X²ï²ï\n¬v¨¡ Âû¦×¸z");
                mObj.setDetail("¥i¹|(Croissant),Ä«ªG¤¦³Á(apple Danish),¥Õ¦R¥q(White toast)");
                mObj.seteName("Fresh fruits of the season, Yogurt\n" +
                        "Main course-\nBaked organic eggs with tomato salsa\n" +
                        "Yukon potato and chicken sausage");
                mObj.setClassType(mClassType); 
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
//                alacart = "Chinese breakfast";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤¤¦¡-\n" +
                        "®ÉÂA¤ôªG\n" +
                        "¤pµæºë¿ï:¶}¶§¥Õµæ,¬õ¿N¦Ë²Æ¦×µ·¨§»G,ª÷µØÀpÀm¤ì¦Õ,ºë¿ï¦×ÃP,²Mµ°,¤¤¦¡¬üÂI");
    //            mObj.setDetail("²Mµ°(Plain congee),¿P³Áµ°(mung bean congee)");
                mObj.seteName("Fresh fruits of the season\n" +
                        "Assorted delicatessen:\n" +
                        "Stir-fried Napa cabbage with dried shrimp," +
                        "Braised bean curd with bamboo pith and pork julienne in brown sauce\n" +
                        "Stir-fried double color fungus,Shredded dry pork\n " +
                        "Plain congee\n" +
                        "Steamed bun");
                mObj.setClassType(mClassType); 
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
        }
        
        
        mClassType="C";  
        /***C¿µ***/
        if("TPEFRA".equals(sect))
        {
            mType = "Late night supper";//®d©]«KÀ\
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("¨F©Ô");
                mObj.setName("¥Ð¶é¨F©Ô¦õ©M­·ªÛ³ÂÂæ");
                mObj.seteName("Garden salad with sesame dressing");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;            
                
                alacart = "¥Dµæ";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("µØ¯èªÅ¤¤¤å¤ÆÅW®b-¥x¦¡ºë¿ï±Æ°©ÄÑ¦õºë¿ï¤pµæ");
                mObj.seteName("Taiwanese signature dish ¡VTaiwanese style deep fried pork chop noodle soup with assorted side dishes(Beef is originated from Taiwan)");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»·ÎÆt³½µá¤O-©u¸`ÂA½­¡B¬õ¬v¨¡¡Bµð¸Ä²Hµæ¥Õ°sÂæ");
                mObj.seteName("v,Clam & mussel base with wine sauce");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»·Î´Ô³ÂÂû¦õ¥¤­X­»­TÂæ-¤°ÀAÂA½­¡B¸q¤j§Q²ÓÄÑ");
                mObj.seteName("Pan fried chicken thigh with lemon grass and tomato creamy sauce,Assorted vegetables and angel hair pasta ");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "ºë¿ïÄÑ¥]¦õ¤â¤u¥¤ªo";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¬P³¥ÆQÄÑ¥]");
                mObj.seteName("Hoshino salty bread");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»»[ÄÑ¥]");
                mObj.seteName("garlic bread");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤é¦¡³n¥]");
                mObj.seteName("Japanese soft roll,");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;         
                                
                alacart = "ºë¿ï²¢ÂI¶°";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ºë¿ï²¢ÂI¶°");
                mObj.seteName("Dessert");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
            mType ="Light bites menu";
            alacart = "ªÅ¤¤¤pÂI";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¶Ç²Î¾|¦×¶º");
                mObj.seteName("Traditional Taiwanese bolognaise meat sauce Served with soy sauce braised egg, takuwan, steamed rice");
                mObj.setClassType(mClassType);              
    //          mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("³¥Û£¤û¦×¶p¡]¤û¦×¨Ó·½¡G¯Ã¦èÄõ¡^");
                mObj.seteName("Fresh mushrooms beef puff (Beef is originated from New Zealand)");
                mObj.setClassType(mClassType);              
    //          mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
            mType = "Breakfast menu";//¦­À\
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("Western breakfast");
                mObj.setName("®ÉÂA¤ôªG\n" +
                        "Àu®æ\n  " +
                        "ÂtÂDµÔµæªk¦¡³J±² :Ä¨Û£¡Bµf­X¡Bªá·¦µæ\n" +
                        "°sÆC®Û¶êÄÑ¥]¡B¥i¹|¡B«p¤ù¦R¥q");
                mObj.seteName("FRESH FRUITS OF THE SEASON \n" +
                        "Yogurt \n" +
                        "Scrambled egg crepe with smoked salmon and spinach Button mushroom, tomato, broccoli " +
                        "Longan bread mixed with red wine and Croissant, white toast");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("Chinese breakfast");
                mObj.setName("²Î¤@¨§¼ß\n" +
                        "²Mµ°-¶³¦Õª£ÂAµ«¡B¦×¥½¥|©u¨§¡B­X¤l¨§»G¡B²D©Õ¶À¨§ªÞ¡B¤¤¦¡¬üÂI");
                mObj.seteName("SOYBEAN MILK\n" +
                        "Plain congee:Stir-fried bamboo shoot with fungus, " +
                        "Stir-fried pork and green beans with soy sauce, " +
                        "Tofu and eggplant with garlic soy paste,Bean sprouts salad,Steamed bun");
                mObj.setClassType(mClassType);              
    //          mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
        }   
//0062
        if("FRATPE".equals(sect) )
        {
            mType = "Lunch menu";//¤ÈÀ\
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("«eµæ");
                mObj.setName("ÃZ¨x­á ¿L¬v½µ ¯N¸`¥Ê¤Î¬õ¾L®ß");
                mObj.seteName("Duck liver terrine, onion confit, grilled zucchini, red currant");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                alacart = "¨F©Ô";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥Ð¶é¨F©Ô¦õ©¬°¨´Ë°_¥q¤Î³Í¼»Âæ");
                mObj.seteName("Mixed mesculin salad, parmesan cheese, caesar dressing");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                alacart = "¥Dµæ";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Âæ¿N½Þ¦× ¤¤¦¡®É½­ µæ¶º");
                mObj.seteName("Braised pork in soy sauce,Assorted oriental vegetables, pak choy, steamed rice");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»·Î©ú½¼ Äªµ« ±m´Ô µf­X ÂfÂc¦Ê¨½­»¿L¶º");
                mObj.seteName("Pan seared prawn, Asparagus, bell pepper, tomato, lemon thyme risotto" );
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»¯NÂû¯Ý¦×Å¨µf­X °_¥q ²¢µæ®Ú «Cªáµæ «CÂæ¸q¦¡¼eÄÑ");
                mObj.seteName("Roasted chicken breast with tomato, mozzarella,Beetroot, broccoli, tagliatelle with pesto sauce");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "ºë¿ïÄÑ¥]¦õ¤â¤u¥¤ªo";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("©ì¾cÄÑ¥]");
                mObj.seteName("Ciabatta bread");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;

                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ªk°êÄÑ¥]");
                mObj.seteName("French baguette");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»»[ÄÑ¥]");
                mObj.seteName("garlic bread");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "®ÉÂA¤ôªG";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("®ÉÂA¤ôªG");
                mObj.seteName("Freshe fruits of the season");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "²¢ÂI";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥©§J¤O³J¿|");
                mObj.seteName("Praline chocolate cake");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
            mType = "Refreshment";//«KÀ\
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("Western refreshment");
                mObj.setName("¥Ð¶é¨F©Ô¦õ¤d®qÂæ\n" +
                        "ÖK¯NÄ¨Û£Âû¦×Á¡»æ¡B½­µæ¡Bµf­X¡Bªk¦¡¥ÕÂæ\n" +
                        "¥i¹|¡B¿P³ÁÄÑ¥] \n" +
                        "ºë¿ï©u¸`ÂAªG");
                mObj.seteName("Garden salad with Thousand Island dressing\n" +
                        "Chicken, mushroom crepe,Spinach, tomato, bechamel sauce\n" +
                        "Croissant, oatmeal bread\n" +
                        "Fresh fruits of the season");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("Chinese refreshment");
                mObj.setName("¿P³ÁÄÑ¥]¡BÂû¦×¦Ëµ«\n" +
                        "¤û¦×¦Ì¯»´ö\n" +
                        "ºë¿ï©u¸`ÂAªG");
                mObj.seteName("Braised mushroom with tofu,Wok fried chicken with bamboo shoot\n" +
                        "Beef rice noodle soup\n" +
                        "Fresh fruits of the season");
                mObj.setClassType(mClassType);              
    //          mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
        }
        
//0051
        if("TPESYD".equals(sect) )//¥x¥_-³·±ù
        {
            mType = "Late night supper";//®d©]«KÀ\
                mObj = new MenuMealTypeObj();
//                mObj.setMealType(mType);
//                mObj.setAlacartType("«eµæ");
//                mObj.setName("µf­X¡B¹T±ù¡BÃÉ¦×¨F©Ô¦õµf¬õªá¬ü¥¤´þ");
//                mObj.seteName("Crab meat tartare tomato, avocado, micro greens, saffron mayonnaise");
//                mObj.setClassType(mClassType);              
////              mObj.setQuantity(5);        
//                mainMeal.add(mObj);
//                mObj = null;
            
//                alacart = "¨F©Ô";
//                mObj = new MenuMealTypeObj();
//                mObj.setMealType(mType);
//                mObj.setAlacartType(alacart);
//                mObj.setName("ÂA±m¬ü¨F©Ô¦õª÷®Ü®Ûªáªo¾LÂæ");
//                mObj.seteName("Garden salad with citrus onion ponzu dressing");
//                mObj.setClassType(mClassType);              
////              mObj.setQuantity(5);        
//                mainMeal.add(mObj);
//                mObj = null;
            
                alacart = "¥Dµæ";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¨F©Ô:¥Ð¶é¨F©Ô¦õ©M­·ªÛ³ÂÂæ\n" +
                            "¥Dµæ:½µ¿N¤l±Æ ©u¸`ÂA½­ ¥Õ¶º\n" +
                            "ºë¿ïÄÑ¥]¦õ¥¤ªo"+
                            "ºë¿ï²¢ÂI¶°");
                mObj.setDetail("¬P³¥ÆQÄÑ¥] (Hoshino salty bread),¤é¦¡³n¥](Japanese soft roll),­»»[ÄÑ¥](garlic bread)");
                mObj.seteName("Salad:Garden salad with sesame dressing\n" +
                        "Main course:Braised pork ribs with spring onion,Stir-fried vegetables and steamed rice" +
                        "Assorted bread served with homemade butter" +
                        "Dessert Platter");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¨F©Ô:¥Ð¶é¨F©Ô¦õ©M­·ªÛ³ÂÂæ\n" +
                            "¥Dµæ:¬õ°sÀí¤û¦× ®É½­ ¬v¨¡\n"+
                            "ºë¿ïÄÑ¥]¦õ¥¤ªo"+
                            "ºë¿ï²¢ÂI¶°");
                mObj.setDetail("¬P³¥ÆQÄÑ¥] (Hoshino salty bread),¤é¦¡³n¥](Japanese soft roll),­»»[ÄÑ¥](garlic bread)");
                mObj.seteName("Salad:Garden salad with sesame dressing\n" +
                        "Main course:Beef goulash with red wine sauce (Beef is originated from Panama) Broccoli, cauliflower, pumpkin stick and new potatoes with chive" +
                        "Assorted bread served with homemade butter" +
                        "Dessert Platter");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¨F©Ô:¥Ð¶é¨F©Ô¦õ©M­·ªÛ³ÂÂæ\n" +
                            "¥Dµæ:­»·Î´Ô³ÂÂû¦õ¥¤­X­»­TÂæ ¤°ÀAÂA½­ ¸q¤j§Q²ÓÄÑ\n" +
                            "ºë¿ïÄÑ¥]¦õ¥¤ªo"+
                            "ºë¿ï²¢ÂI¶°");
                mObj.setDetail("¬P³¥ÆQÄÑ¥] (Hoshino salty bread),¤é¦¡³n¥](Japanese soft roll),­»»[ÄÑ¥](garlic bread)");
                mObj.seteName("Salad:Garden salad with sesame dressing\n" +
                        "Main course:Pan fried chicken thigh with lemon grass and tomato creamy sauce Assorted vegetables and angel hair pasta" +
                        "Assorted bread served with homemade butter" +
                        "Dessert Platter");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
//                alacart = "ºë¿ïÄÑ¥]¦õ¥¤ªo";
//                mObj = new MenuMealTypeObj();
//                mObj.setMealType(mType);
//                mObj.setAlacartType(alacart);
//                mObj.setName("¬P³¥ÆQÄÑ¥]");
//                mObj.seteName("Ciabatta bread");
//                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
//                mainMeal.add(mObj);
//                mObj = null;
//
//                mObj = new MenuMealTypeObj();
//                mObj.setMealType(mType);
//                mObj.setAlacartType(alacart);
//                mObj.setName("¸q¦¡­»¯óÄÑ¥]");
//                mObj.seteName("pretzel roll");
//                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
//                mainMeal.add(mObj);
//                mObj = null;
//                
//                mObj = new MenuMealTypeObj();
//                mObj.setMealType(mType);
//                mObj.setAlacartType(alacart);
//                mObj.setName("­»»[ÄÑ¥]");
//                mObj.seteName("garlic bread");
//                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
//                mainMeal.add(mObj);
//                mObj = null;
                                
//                alacart = "ºë¿ï²¢ÂI¶°";
//                mObj = new MenuMealTypeObj();
//                mObj.setMealType(mType);
//                mObj.setAlacartType(alacart);
//                mObj.setName("ºë¿ï²¢ÂI¶°");
//                mObj.seteName("Passion fruit mousse cake with raspberry sauce");
//                mObj.setClassType(mClassType);              
////              mObj.setQuantity(5);        
//                mainMeal.add(mObj);
//                mObj = null;
                
                mType = "Breakfast menu";//¦­À\
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("Western breakfast");
                mObj.setName("®ÉÂA¤ôªG\n" +
                        "Àu®æ\n  " +
                        "ÂtÂDµÔµæªk¦¡³J±² Ä¨Û£ µf­X ªá·¦µæ\n" +
                        "°sÆC®Û¶êÄÑ¥]¡B¥i¹|¡B«p¤ù¦R¥q");
                mObj.setDetail("¦­À\½\Ãþ(Cereals)");
                mObj.seteName("FRESH FRUITS OF THE SEASON \n" +
                        "Yogurt\n" +
                        "Scrambled egg crepe with smoked salmon and spinach Button mushroom, tomato, broccoli" +
                        "Longan bread mixed with red wine, Croissant, white toast");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("Chinese breakfast");
                mObj.setName("²Î¤@¨§¼ß\n" +
                        "²Mµ°-¶³¦Õª£ÂAµ«¡B¦×¥½¥|©u¨§¡B­X¤l¨§»G¡B¤¤¦¡¬üÂI");
                mObj.seteName("SOYBEAN MILK\n" +
                        "Stir-fried bamboo shoot with fungus, " +
                        "Stir-fried pork and green beans with soy sauce, " +
                        "Tofu and eggplant with garlic soy paste, Bean sprouts salad,Steamed bun");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;                
           
        }
        
//0052
        if("SYDTPE".equals(sect) )//³·±ù-¥x¥_ 
        {
            mType = "Late night supper";//®d©]«KÀ\
            
            alacart = "Main course";//¥Dµæ
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("«eµæ:ºë¿ï­»¾í©ú½¼¨F©Ô¦õ¸q¤j§Qªo¾LÂæ\n" +
                    "¥Dµæ:¤z¨©X.O. ÂæªãÄõµæ ­»Û£ ¬õÅÚ½³ ¶Àª÷ª£¶º\n" +
                    "ºë¿ïÄÑ¥]¦õ¥¤ªo \n" +
                    "ºë¿ï²¢ÂI¶°");
            mObj.setDetail("ªk°êÄÑ¥](French baguette), ©ì¾cÄÑ¥](ciabatta bread), ÂøÂ³ÄÑ¥](Multigrain torpedo roll)"); 
            mObj.seteName("Starter:Prawn, orange, cherry tomato, asparagus, dill, micro salad Italian vinaigrette dressing\n" +
                    "Main course:Wok fried scallop with x.o. sauce Chinese broccoli, shiitake mushroom, carrot, egg fried rice\n" +
                    "Assorted bread served with homemade butter\n" +
                    "Dessert Platter");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null; 
                            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("«eµæ:ºë¿ï­»¾í©ú½¼¨F©Ô¦õ¸q¤j§Qªo¾LÂæ\n" +
                    "¥Dµæ:µf­X «C¨§¤¯ ÖK¯N¸q¦¡±×ºÞÄÑ ¬õ°sÂæ\n" +
                    "ºë¿ïÄÑ¥]¦õ¥¤ªo \n" +
                    "ºë¿ï²¢ÂI¶°");
            mObj.setDetail("ªk°êÄÑ¥](French baguette), ©ì¾cÄÑ¥](ciabatta bread), ÂøÂ³ÄÑ¥](Multigrain torpedo roll)");                
            mObj.seteName("Starter:Prawn, orange, cherry tomato, asparagus, dill, micro salad Italian vinaigrette dressing\n" +
                    "Main course: Australian beef tenderloin Grilled tomato, green peas, gratin penne pasta, red wine sauce\n" +
                    "Assorted bread served with homemade butter\n" +
                    "Dessert Platter");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("«eµæ:ºë¿ï­»¾í©ú½¼¨F©Ô¦õ¸q¤j§Qªo¾LÂæ\n" +
                    "¥Dµæ:Âû¦×Âæ¦õ¸q¦¡¨Å¹TÄÑ¨÷ §ÆÃ¾¦Ï¥¤°_¤h «Cªáµæ\n" +
                    "ºë¿ïÄÑ¥]¦õ¥¤ªo \n" +
                    "ºë¿ï²¢ÂI¶°");
            mObj.setDetail("ªk°êÄÑ¥](French baguette), ©ì¾cÄÑ¥](ciabatta bread), ÂøÂ³ÄÑ¥](Multigrain torpedo roll)"); 
            mObj.seteName("Starter:Prawn, orange, cherry tomato, asparagus, dill, micro salad Italian vinaigrette dressing\n" +
                    "Main course:Ricotta cannelloni with chicken ragout Sauteed broccoli, cauliflower\n" +
                    "Assorted bread served with homemade butter\n" +
                    "Dessert Platter");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;              
            
         mType = "Breakfast menu";//    ¦­À\µæ³æ
            mObj = new MenuMealTypeObj();
            alacart = "Western breakfast";//"¦è¦¡ºë¿ï";
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("®ÉÂA¤ôªG\n" +
                    "Àu®æ\n" +
                    "¥Dµæ(¦è¦¡ª£³J ¦õÄ¨Û£, Äªµ«, Âû¦×¸z¤Î¬v¨¡²y)\n" +
                    "ºë¿ïÄÑ¥]¦õ¥¤ªo¤ÎªGÂæ");
            mObj.seteName("Fresh fruits of the season,\n" +
                    "Yogurt,\n" +
                    "Main course:Scrambled egg,Button mushroom, asparagus, chicken sausage, rosti potato)\n" +
                    "Assorted bread served with butter and jam");
            mObj.setDetail("¦­À\½\Ãþ(Cereals),¥i¹|ÄÑ¥](Croissant),¥Õ¦R¥q(toast)");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(20);   
            mainMeal.add(mObj);
            mObj = null;
            
            alacart = "Chinese breakfast";//"¤¤¦¡ºë¿ï";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("²Mµ°\n" +
                    "¤pµæºë¿ï:µæ²ã³J¡BÄ¨Û£¥|©u¨§¡B¤¤¦¡¬üÂI");
            mObj.seteName("Plain congee\n" +
                    "Pan fried dry turnips with egg omelet, Stir fried green bean and mushroom with pork,The bakery\n");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(20);  
            mainMeal.add(mObj);
            mObj = null;
        }
//0031 YVR-TPE        
        if("0031".equals(fltno))
        {
            mType = "Late night supper";//®d©]«KÀ\
            alacart = "Appetizer";//«eµæ
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("­»·ÎÂû¯Ý¤ÎÅÁ³½¦õ¨F©Ô");
            mObj.seteName("Seared chicken and teriyaki eel with salad");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
                        
            alacart = "Main course";//¥Dµæ
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("Á¤Âæ©ú½¼ ¦õªãÂÅ ¬õÅÚ½³ ¦Ì¶º");
            mObj.seteName("Wok-fried prawn with ginger sauce Kailan, carrot, steamed rice");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null; 
                            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("¦Ï¨{µßÛ£Âæ¯NÂû ¦õºî¦X®É½­ ¬õ¬v¨¡");
            mObj.seteName("Roasted chicken breast with morel sauce,Sauteed seasonal vegetables, red potato");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("Âæ¿NÀn¯Ý ¦õ¥Õµæ ¬õÅÚ½³ ºî¦X¦ÌÄÑ");
            mObj.seteName("Duck breast with sauce Chinese cabbage, carrot, mixed couscous, beans, orzo pasta, red quinoa");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
            
            alacart = "The bakery";//ºë¿ïÄÑ¥]¦õ¥¤ªo                              
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("¬v½µÄÑ¥]");
            mObj.seteName("Onion roll");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("ªk¦¡ÄÑ¥]");
            mObj.seteName("French roll");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("­»»[ÄÑ¥]");
            mObj.seteName("Garlic bread");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
                           
            alacart = "Fresh fruits of the season ";//ÂAªG
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("ºë¿ï©u¸`ÂAªG");
            mObj.seteName("Fresh fruits of the season");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
            
            alacart = "Dessert ";//²¢ÂI
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("Chapman¡¦s ¦B²N²O");
            mObj.seteName("Chapman¡¦s Ice cream");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
            
//         mType = "Light bites menu";//    ªÅ¤¤¤pÂI
//            
//            alacart = "ªÅ¤¤¤pÂI";//"¦è¦¡ºë¿ï";
//            mObj = new MenuMealTypeObj();
//            mObj.setMealType(mType);
//            mObj.setAlacartType(alacart);
//            mObj.setName("¶Ç²Îº±¦×¶º");
//            mObj.seteName("Traditional Taiwan bolognaise meat sauce Served with soy sauce-braised egg, takuwan, steamed rice");
//            mObj.setClassType(mClassType);              
//            mObj.setQuantity(20);   
//            mainMeal.add(mObj);
//            mObj = null;   
//            
//            mObj = new MenuMealTypeObj();
//            mObj.setMealType(mType);
//            mObj.setAlacartType(alacart);
//            mObj.setName("¨½¬_¤jµÔµæ¤õ»L¤ñÂÄ¥]");
//            mObj.seteName("Ham ricotta spinach pizza calzone");
//            mObj.setClassType(mClassType);              
//            mObj.setQuantity(20);   
//            mainMeal.add(mObj);
//            mObj = null;  
            
         mType = "Breakfast menu";//    ¦­À\µæ³æ                
            alacart = "Western breakfast";//"¦è¦¡ºë¿ï";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("®ÉÂA¤ôªG¡BÀu®æ¡B¥Dµæ(¤õ»L³J»æ¡BÄªµ«¡Bµf­X¤Î¬õ¬v¨¡)¡Bºë¿ïÄÑ¥]¦õ¥¤ªo¤ÎªGÂæ");
            mObj.seteName("Fresh fruits of the season,\n" +
                    "Yogurt,\n" +
                    "Main course(Egg crepe with black forest ham and scrambled egg and Cherry tomato, asparagus, red potato),\n" +
                    "Assorted bread served with butter and jam."); 
            mObj.setDetail("Ä«ªG¤¦³ÁÄÑ¥](Apple Danish),¥i¹|ÄÑ¥](croissant)");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(10);   
            mainMeal.add(mObj);
            mObj = null;
            
            alacart = "Chinese breakfast";//"¤¤¦¡ºë¿ï";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("²Î¤@¨§¼ß¡B¤pµæºë¿ï(º^µæª£Âû¦×¡Bµæ²ã³J¡B½¬ÃÂ¤ì¦Õ¡Bºë¿ï¦×ÃP)¡B²Mµ°¡B¤¤¦¡¬üÂI");
            mObj.seteName("Soy bean milk,\nAssorted delicatessen(" +
                    "Preserved mustard with chicken,Preserved turnips with egg omelet,Marinated asparagus,Shredded dry pork),\n" +
                    "Plain congee,Steamed bun");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(10);  
            mainMeal.add(mObj);
            mObj = null;
                
        }          
//0032 TPE-YVR        
        if("0032".equals(fltno))
        {
            mType = "Late night supper";//®d©]«KÀ\
                alacart = "Salad";//¨F©Ô
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥Ð¶é¨F©Ô¦õ©M­·ªÛ³ÂÂæ");
                mObj.seteName("Garden salad with sesame dressing");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                            
                alacart = "Main course";//¥Dµæ
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("½µ¿N¤l±Æ ©u¸`ÂA½­ ¥Õ¶º");
                mObj.seteName("Braised pork ribs with spring onion Stir-fried vegetables and steamed rice");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¬õ°sÀí¤û¦×¡]¤û¦×¨Ó·½¡G¤Ú®³°¨¡^®É½­ ¬v¨¡");
                mObj.seteName("Beef goulash with red wine sauce (Beef is originated from Panama),Broccoli, cauliflower, pumpkin stick and new potatoes with chive");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»·Î´Ô³ÂÂû¦õ¥¤­X­»­TÂæ,¤°ÀAÂA½­ ¸q¤j§Q²ÓÄÑ");
                mObj.seteName("Pan fried chicken thigh with lemon grass and tomato creamy sauce ,Assorted vegetables and angel hair pasta");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "The bakery";//ºë¿ïÄÑ¥]¦õ¥¤ªo                              
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¬P³¥ÆQÄÑ¥]");
                mObj.seteName("Hoshino salty bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤é¦¡³n¥]");
                mObj.seteName("Japanese soft roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»»[ÄÑ¥]");
                mObj.seteName("Garlic bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                               
                alacart = "Fresh fruits of the season ";//ÂAªG
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ºë¿ï©u¸`ÂAªG");
                mObj.seteName("Fresh fruits of the season");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Dessert ";//²¢ÂI
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen¡VDazs ¦B²N²O");
                mObj.seteName("Haagen¡VDazs");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
             mType = "Light bites menu";//    ªÅ¤¤¤pÂI
                
                alacart = "ªÅ¤¤¤pÂI";//"¦è¦¡ºë¿ï";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¶Ç²Îº±¦×¶º");
                mObj.seteName("Traditional Taiwan bolognaise meat sauce Served with soy sauce-braised egg, takuwan, steamed rice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);   
                mainMeal.add(mObj);
                mObj = null;   
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("³¥Û£¤û¦×¶p¡]¤û¦×¨Ó·½¡G¯Ã¦èÄõ¡^");
                mObj.seteName("Fresh mushrooms beef puff (Beef is originated from New Zealand)");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);   
                mainMeal.add(mObj);
                mObj = null;  
                
             mType = "Breakfast menu";//    ¦­À\µæ³æ                
                alacart = "Western breakfast";//"¦è¦¡ºë¿ï";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("®ÉÂA¤ôªG¡BÀu®æ¡B¥Dµæ(ÂtÂDµÔµæªk¦¡³J±²¡BÄ¨Û£ ¡Bµf­X ¡Bªá·¦µæ)¡Bºë¿ïÄÑ¥]¦õ¥¤ªo¤ÎªGÂæ");
                mObj.seteName("Fresh fruits of the season,\n" +
                        "Yogurt,\n" +
                        "Main course(Scrambled egg crepe with smoked salmon and spinach,Button mushroom, tomato, broccoli ),\n" +
                        "Assorted bread served with butter and jam."); 
                mObj.setDetail("¦­À\½\Ãþ(Cereals),°sÆC®Û¶êÄÑ¥](Longan bread mixed with red wine),¥i¹|(Croissant),«p¤ù¦R¥q(white toast)");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(10);   
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Chinese breakfast";//"¤¤¦¡ºë¿ï";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("²Î¤@¨§¼ß¡B¤pµæºë¿ï(¶³¦Õª£ÂAµ«¡B¦×¥½¥|©u¨§¡B­X¤l¨§»G¡B²D©Õ¶À¨§ªÞ)¡B²Mµ°¡B¤¤¦¡¬üÂI");
                mObj.seteName("Soy bean milk,\nAssorted delicatessen(Stir-fried bamboo shoot with fungus," +
                        "Stir-fried pork and green beans with soy sauce,Tofu and eggplant with garlic soy paste, Bean sprouts salad,Steamed bun),\n" +
                        "Plain congee\n");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(10);  
                mainMeal.add(mObj);
                mObj = null;
                
        }        
  
//0063 TPE-VIE       
        if("0063".equals(fltno))
        {
            mType = "Late night supper";//®d©]«KÀ\
                alacart = "Salad";//¨F©Ô
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥Ð¶é¨F©Ô¦õ©M­·ªÛ³ÂÂæ");
                mObj.seteName("Garden salad with sesame dressing");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                            
                alacart = "Main course";//¥Dµæ
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("µØ¯èªÅ¤¤¤å¤ÆÅW®b-¥x¦¡¬õ¿N¤û¦×ÄÑ¦õºë¿ï¤pµæ");
                mObj.seteName("Taiwanese signature dish ¡V Authentic Taiwanese Beef noodle soup with assorted side dishes (Beef is originated from Taiwan)");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»·ÎÆt³½µá¤O ©u¸`ÂA½­ ¬õ¬v¨¡ µð¸Ä²Hµæ¥Õ°sÂæ");
                mObj.seteName("Pan fried sea bass filet Seasonal vegetables and new potatoes Clam & mussel base with wine sauce");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»·Î´Ô³ÂÂû¦õ¥¤­X­»­TÂæ ¤°ÀAÂA½­ ¸q¤j§Q²ÓÄÑ");
                mObj.seteName("Pan fried chicken thigh with lemon grass and tomato creamy sauce Assorted vegetables and angel hair pasta");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "The bakery";//ºë¿ïÄÑ¥]¦õ¥¤ªo                              
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¬P³¥ÆQÄÑ¥]");
                mObj.seteName("Hoshino salty bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤é¦¡³n¥]");
                mObj.seteName("Japanese soft roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»»[ÄÑ¥]");
                mObj.seteName("Garlic bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                 
             mType = "Light bites menu";//    ªÅ¤¤¤pÂI                
                alacart = "ªÅ¤¤¤pÂI";//"¦è¦¡ºë¿ï";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¶Ç²Îº±¦×¶º");
                mObj.seteName("Traditional Taiwan bolognaise meat sauce Served with soy sauce-braised egg, takuwan, steamed rice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);   
                mainMeal.add(mObj);
                mObj = null;   
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("³¥Û£¤û¦×¶p¡]¤û¦×¨Ó·½¡G¯Ã¦èÄõ¡^");
                mObj.seteName("Fresh mushrooms beef puff (Beef is originated from New Zealand)");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(10);   
                mainMeal.add(mObj);
                mObj = null;  
                
             mType = "Breakfast menu";//    ¦­À\µæ³æ                
                alacart = "Western breakfast";//"¦è¦¡ºë¿ï";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("®ÉÂA¤ôªG¡BÀu®æ¡B¥Dµæ(ÂtÂDµÔµæªk¦¡³J±²¡BÄ¨Û£ ¡Bµf­X ¡Bªá·¦µæ)¡Bºë¿ïÄÑ¥]¦õ¥¤ªo¤ÎªGÂæ");
                mObj.seteName("Fresh fruits of the season,\n" +
                        "Yogurt,\n" +
                        "Main course(Scrambled egg crepe with smoked salmon and spinach,Button mushroom, tomato, broccoli ),\n" +
                        "Assorted bread served with butter and jam."); 
                mObj.setDetail("¦­À\½\Ãþ(Cereals),°sÆC®Û¶êÄÑ¥](Longan bread mixed with red wine),¥i¹|(Croissant),«p¤ù¦R¥q(white toast)");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(10);   
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Chinese breakfast";//"¤¤¦¡ºë¿ï";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("²Î¤@¨§¼ß¡B¤pµæºë¿ï(¶³¦Õª£ÂAµ«¡B¦×¥½¥|©u¨§¡B­X¤l¨§»G¡B²D©Õ¶À¨§ªÞ)¡B²Mµ°¡B¤¤¦¡¬üÂI");
                mObj.seteName("Soy bean milk,\nAssorted delicatessen(Stir-fried bamboo shoot with fungus," +
                        "Stir-fried pork and green beans with soy sauce,Tofu and eggplant with garlic soy paste, Bean sprouts salad,Steamed bun),\n" +
                        "Plain congee\n");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(10);  
                mainMeal.add(mObj);
                mObj = null;
                
        }    
        
//0064 VIE-TPE        
        if("0064".equals(fltno))
        {
            mType = "Lunch menu";//¤ÈÀ\µæ³æ
                alacart = "Appetizer";//«eµæ
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤pÀs½¼¨F©Ô¦õµf­X¤Î½¼¦i½µ");
                mObj.seteName("Crayfish salad with tomato, chopped chives, Balsamic reduction, aioli and pesto");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                            
                alacart = "Salad";//¨F©Ô
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("§ÆÃ¾°_¤hµf­X¨F©Ô¦õ«n¥Ê¬óªo¾LÂæ");
                mObj.seteName("Mesclun salad with feta cheese, tomato, pumpkin seed dressing");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Main course";//¥Dµæ
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥|¤t¤f¨ý³Â»¶Âû µÔµæ ¥É¦Ìµ« ¬õÅÚ½³ ¦Ì¶º");
                mObj.seteName("Wok fried spicy chicken-Sichuan style Chinese vegetable, baby corn, carrot, steamed rice");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ª¥¯N¤ûµá¤O ÖK¯N¬v¨¡ ¯N½­µæ ­»®Æ¥¤ªo ");
                mObj.seteName("Grilled beef tenderloin Grilled mediterranean vegetables, gratin potato, cafe de Paris");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»·ÎÄK³½ ºî¦X®É½­ ¯N°g­¡­»¬v¨¡ »Ä¨§ÂfÂc¤ûªoÂæ");
                mObj.seteName("Pan seared dorade fillet Grilled assorted vegetables, roasted rosemary potato, caper lemon butter sauce");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Assorted bread served with homemade butter";//ºë¿ïÄÑ¥]¦õ¥¤ªo                              
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¾ñÆV©ì¾cÄÑ¥]");
                mObj.seteName("Olive ciabatta bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¼w¦¡ÄÑ¥]");
                mObj.seteName("laugen roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»»[ÄÑ¥]");
                mObj.seteName("garlic bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                               
                alacart = "Fresh fruits of the season ";//ÂAªG
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ºë¿ï©u¸`ÂAªG");
                mObj.seteName("Fresh fruits of the season");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Dessert ";//²¢ÂI
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»¿@¨~ªG¥¤¹T");
                mObj.seteName("Mango panna cotta");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;                
          
             mType = "Refreshment";//                  
                alacart = "Western refreshment";//"¦è¦¡«KÀ\";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥Ð¶é¨F©Ô¦õ¤d®qÂæ¡B¥Dµæ(­»·ÎÂû¦×¦õ­XÂæ¡B¯N¸`¥Ê¡BÄ¨Û£¥¤ªo¸q¤j§Q»å)¡Bºë¿ïÄÑ¥]¦õ¤â¤u¥¤ªo¡Bºë¿ï©u¸`ÂAªG");
                mObj.seteName("Salad:Garden salad with Thousand Island dressing,\n" +
                        "Main course(Pan seared chicken medallion on tomato salsa sauce Zucchini creamy truffle tortellini),\n" +
                        "Assorted bread served with homemade butter\n" +
                        "resh fruits of the season.");
                mObj.setDetail("³nÄÑ¥](Soft roll),ºû¤]¯ÇÄÐÄÑ¥](Viennese salted roll)");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(10);   
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Chinese refreshment";//"¤¤¦¡«KÀ\";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤pµæºë¿ï(¤KÄ_»¶Âæ¡B¶}¶§¥Õµæ)¡B¥Dµæ(¤¤¦¡¤e¿NÀ_¶»´öÄÑ)¡Bºë¿ï©u¸`ÂAªG");
                mObj.seteName("Assorted delicatessen(Eight treasures-minced meat, soy bean curd and mixed vegetables,Braised Chinese cabbage with dried shrimps),\n" +
                        "Main course(Chinese B.B.Q pork with wonton noodle soup),\n" +
                        "Fresh fruits of the season.");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(10);  
                mainMeal.add(mObj);
                mObj = null;
                
        }    
        
        if(mainMeal.size()<=0)
        {
            mType = "Beverage Order 1";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType("");
            mObj.setName("");
            mObj.seteName("");
            mObj.setClassType("F");              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
            
            mType = "Beverage Order 2";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType("");
            mObj.setName("");
            mObj.seteName("");
            mObj.setClassType("F");              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
            
            mType = "Beverage Order 3";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType("");
            mObj.setName("");
            mObj.seteName("");
            mObj.setClassType("F");              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
            
            mType = "Beverage Order 1";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType("");
            mObj.setName("");
            mObj.seteName("");
            mObj.setClassType("C");              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
            
            mType = "Beverage Order 2";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType("");
            mObj.setName("");
            mObj.seteName("");
            mObj.setClassType("C");              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
            
            mType = "Beverage Order 3";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType("");
            mObj.setName("");
            mObj.seteName("");
            mObj.setClassType("C");              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;            
        }
        

         //return array  
         MenuMealTypeObj[] mArr= new MenuMealTypeObj[mainMeal.size()];
         for(int i=0;i<mainMeal.size();i++){
            mArr[i] = (MenuMealTypeObj) mainMeal.get(i);
         }
         menu.setMenuMarr(mArr);
          
        
    }


//  2014/12/01 Q4#777
//  2015/04/01 Q2
    public void getMenuList2(String fltno ,String fltd, String sect){

        fltno = fltno.replace("Z", "").replace("z", "");
        if(fltno.length()!=4){
            fltno = "0000".substring(0, 4 - fltno.length()) + fltno;
//            System.out.println(fltno);
        }
        menu = new MenuFunRObj();
        ArrayList drink = new ArrayList();
        ArrayList mainMeal = new ArrayList();
        
        /**************************************/
        String dType= null; 
        String dClassType = null;
        
        //¶¼®Æ
        MenuDrinkObj dObj = null;
        dClassType="F";  
        /***F¿µ***/
        dType = "Soft Drink";            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Juice");
            dObj.setDetail("O/J,A/J,T/J,Ice");
            drink.add(dObj);
            dObj = null;
                        
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Sparkling Drink");
            dObj.setDetail("Coke,Pepsi,7up,Soda,Tonic,Perrier,Ginger Ale,Ice,Lite,Lime");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
                        
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Milk");
            dObj.setDetail("Cold,Warm,Hot,Low Fat");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Mineral Water");
            dObj.setDetail("Ice,Warm,Hot,Lime");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
        //--------------------
        dType = "Cosy Lounge";
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Gin");
            //dObj.setQuantity(5);       
            dObj.setDetail("Tonic,Martini,7up,Coke,Ice");
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Vodka");
            //dObj.setQuantity(5);        
            dObj.setDetail("Tomato Juice(Bloody Mary),Orange Juice(Screwdriver),Martini,Tonic,Pepper & Salt,Tabasco,Ice");
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Whisky");
            dObj.setDetail("Jonnie Waker Blue Label Jim Beam,Kavalan,Single Malt,Scotch,Ice");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;  
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Rum");
            //dObj.setQuantity(5);   
            dObj.setDetail("coke,Ice");
            drink.add(dObj);
            dObj = null;
              
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Brandy");
            dObj.setDetail("Deau Cognac XO,Courvoisier Napoleon,Ice");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Port");
            //dObj.setQuantity(5);     
            dObj.setDetail("Taylor's,Ice");
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Cherry Brandy");
            //dObj.setQuantity(5);        
            dObj.setDetail("Ice");
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Bailey's Irish Cream");
            dObj.setDetail("Ice,Milk");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;

            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Chinese Rice Wine: Premium Shaohsing 10 Years (For Japan Routes Only)");
            //dObj.setQuantity(5);    
            drink.add(dObj);
            dObj = null;
                   
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Kizakura Ginjo  (For Japan Routes Only)");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Beer");
            //dObj.setQuantity(5);        
            dObj.setDetail("Golden Medal Taiwan,Heineken,Sapporo");
            drink.add(dObj);
            dObj = null;
        //--------------------
        dType = "Champagne/Wine";
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.setName("Champagne");
            //dObj.setQuantity(5);      
            dObj.setDetail("ªk°ê-Pol Roger¡D2000/France-Pol Roger 2000");
            drink.add(dObj);
            dObj = null;
            
            //¥Õ°s
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("¥Õ°s/White Wine");
            dObj.setDetail("ªk°ê-®L¥¬§Q¡D®L¦h¤º:2009/Chablis Chardonnay 2009,¼w°ê-¿p²ïªe¨¦¡DÄRµ·¬Â¡D2012/Germany-Mosel Valley Riesling 2012");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;   
            
            //¬õ°s            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("¬õ°s/Red Wine");
            dObj.setDetail("ªk°ê¡V¸t¦¶§Q¦w°Ï¡D®Ô°ª¤Ú¹y 1997:Saint-Julien/France-Chateau Langoa Barton 1997,¿D¬w¡V¤ÚÃ¹¨Fªe¨¦¡D§Æ«¢¡D2009/Australia-Barossa Valley Shiraz 2009,¬ü°ê-¯Ç©¬ªe¨¦¡D¬ü¬¥  2009/U.S.A.-Napa Valley Merlot Reserve 2009");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;            
        //--------------------
        dType = "Coffee / Tea";
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Coffee");
            dObj.setDetail("Latte,Cappuccino,Decaffeinated,Hot,Ice,Sugar,Cream");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Tea");
            dObj.setDetail("Oolong,Jasmine,Green tea,Darjeeling,Regular,Ice,Sugar,Cream,Black");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
            
        dClassType="C";  
        /***C¿µ***/
            dType = "Soft Drink";            
                dObj = new MenuDrinkObj();
                dObj.setType(dType);
                dObj.setClassType(dClassType);
                dObj.seteName("Juice");
                dObj.setDetail("O/J,A/J,T/J,Ice");
                drink.add(dObj);
                dObj = null;
                            
                dObj = new MenuDrinkObj();
                dObj.setType(dType);
                dObj.setClassType(dClassType);
                dObj.seteName("Sparkling Drink");
                dObj.setDetail("Coke,Pepsi,7up,Soda,Tonic,Perrier,Ginger Ale,Ice,Lite,Lime");
                //dObj.setQuantity(5);        
                drink.add(dObj);
                dObj = null;
                            
                dObj = new MenuDrinkObj();
                dObj.setType(dType);
                dObj.setClassType(dClassType);
                dObj.seteName("Milk");
                dObj.setDetail("Cold,Warm,Hot,Low Fat");
                //dObj.setQuantity(5);        
                drink.add(dObj);
                dObj = null;
                
                dObj = new MenuDrinkObj();
                dObj.setType(dType);
                dObj.setClassType(dClassType);
                dObj.seteName("Mineral Water");
                dObj.setDetail("Ice,Warm,Hot,Lime");
                //dObj.setQuantity(5);        
                drink.add(dObj);
                dObj = null;
        //--------------------
        dType = "Cosy Lounge";
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Gin");
            //dObj.setQuantity(5);       
            dObj.setDetail("Tonic,Martini,7up,Coke,Ice");
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Vodka");
            //dObj.setQuantity(5);        
            dObj.setDetail("Tomato Juice(Bloody Mary),Orange Juice(Screwdriver),Martini,Tonic,Pepper & Salt,Tabasco,Ice");
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Whisky");
            dObj.setDetail("Jonnie Waker Blue Label Jim Beam,Kavalan,Single Malt,Scotch,Ice");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;  
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Rum");
            //dObj.setQuantity(5);   
            dObj.setDetail("coke,Ice");
            drink.add(dObj);
            dObj = null;
              
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Brandy");
            dObj.setDetail("Deau Cognac XO,Courvoisier Napoleon,Ice");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Port");
            //dObj.setQuantity(5);     
            dObj.setDetail("Taylor's,Ice");
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Cherry Brandy");
            //dObj.setQuantity(5);        
            dObj.setDetail("Ice");
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Bailey's Irish Cream");
            dObj.setDetail("Ice,Milk");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
    
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Chinese Rice Wine: Premium Shaohsing 10 Years (For Japan Routes Only)");
            //dObj.setQuantity(5);    
            dObj.setDetail("Ice");
            drink.add(dObj);
            dObj = null;
                   
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Kizakura Ginjo  (For Japan Routes Only)");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Beer");
            //dObj.setQuantity(5);        
            dObj.setDetail("Golden Medal Taiwan,Heineken,Sapporo");
            drink.add(dObj);
            dObj = null;
        //--------------------
        dType = "Champagne/Wine";
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.setName("Champagne");
            //dObj.setQuantity(5);      
            dObj.setDetail("ªk°ê GREMILLET­»Âb/France Champagne Gremillet");
            drink.add(dObj);
            dObj = null;
            
            //¥Õ°s
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("¥Õ°s/White Wine");
            dObj.setDetail("ªk°ê ¡V®L¥¬§Q¤@¯Å¸²µå¶é ®L¦h¤º 2010/France-Chablis 1er Cru Chardonnay 2010,¼w°ê -¿p²ïªe¨¦¡DÄRµ·¬Â¡D2012/Germany-Mosel Valley Riesling 2012");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;   
            
            //¬õ°s            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("¬õ°s/Red Wine");
            dObj.setDetail("ªk°ê¡D©Ô°ª³ù¡D2006/France-Chateau La Gorce 2006,¸q¤j§Q - ©_´­²Ä¬ÃÂÃ¡A2011/Italy-Chianti Riserva DOCG 2011,¬ü°ê¡D¯Ç©¬ªe¨¦¡D¬ü¬¥ 2009/U.S.A.-Napa Valley Merlot Reserve 2009");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null; 
        //--------------------
        dType = "Coffee/Tea";
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Coffee");
            dObj.setDetail("Latte,Cappuccino,Decaffeinated,Hot,Ice,Sugar,Cream");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("Tea");
            dObj.setDetail("Oolong,Jasmine,Green tea,Darjeeling,Regular,Ice,Sugar,Cream,Black");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;
            
        //return array  
        MenuDrinkObj[] dArr= new MenuDrinkObj[drink.size()];
        for(int i=0;i<drink.size();i++){
            dArr[i] = (MenuDrinkObj) drink.get(i);
        }
        menu.setMenuDarr(dArr);
    
 /**************************************/
        
        String mType= null; 
        String mClassType = null;
        String alacart = null;
        //À\ÂI
        MenuMealTypeObj mObj = null;        
            
        if("0004".equals(fltno))
        {
            mClassType="F";  
            /***F¿µ***/   
            mType = "Late night supper";//®d©]«KÀ\
                alacart = "Appetizer";//«eµæ
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Àj³½ºñÄª¯û§N½L");
                mObj.seteName("Stewed abalone and green asparagus");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("»Aºñ½v±aÂtÂD³½");
                mObj.seteName("Smoke salmon in zucchini net pattern");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                alacart = "Soup";//´ö«~
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¶Â»[­ì¬ØÂû´ö");
                mObj.seteName("raised chicken and black garlic soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤û¦×²M´ö");
                mObj.seteName("Beef consomme");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
//                alacart = "Salad";//¨F©Ô
//                mObj = new MenuMealTypeObj();
//                mObj.setMealType(mType);
//                mObj.setAlacartType(alacart);
//                mObj.setName("ºë½o¨F©Ô¦õºë¿ï°t®Æ");
//                mObj.setDetail("¯S¯Å¾ñÆVªo(extra virgin olive oil),¸q¤j§Q³¯¦~¸²µå¾L(balsamic vinegar),±ö­»ªÛ³ÂÂæ(sesame plum dressing)");
//                mObj.seteName("Garden salad served with selected condiments");
//                mObj.setClassType(mClassType);              
//    //            mObj.setQuantity(5);        
//                mainMeal.add(mObj);
//                mObj = null;
                
                alacart = "Main course";//¥Dµæ
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("³Â­»¬ÃÛ£½Þ ª÷»[ªÜ»T»]÷«³½ ¦õ¦Ì¶º ,Âù¦â¤sÃÄ ½¬ÃÂ «n¥Ê µ·¥Ê");
                mObj.setDetail("¤QâB¦Ì¶º(healthy multi grains rice)");
                mObj.seteName("Stir-fried pork and mushroom  Steamed halibut and tofu  with steamed rice or multi grains rice White and purple yam  lotus root  pumpkin  loofah");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                             
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("°g­¡­»ºñ­J´ÔÂæµá¤O ¦õ¬õ¬v¨¡,¡@¡@ÀÍ¥ÊÂE³ßÂùÛ£®i");
//                mObj.setDetail("­»®Æ¿»­X¥¤ªoÂæ¥Ä(pesto-tomato cream sauce),ªi¯S°sÂæ¥Ä(port wine sauce)");
                mObj.seteName("Grilled beef tenderloin in rosemary and green pepper sauce with new potato Abalone mushroom zucchini round");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                              
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ÂfÂc¥¤ªoÂæ¥ÄµÔµæ÷«³½²y  ¦õ­XÂæ±²ÄÑ,±m²yÀÍ¥Ê²î");
//                mObj.setDetail("­»®Æ¿»­X¥¤ªoÂæ¥Ä(pesto-tomato cream sauce),ªi¯S°sÂæ¥Ä(port wine sauce)");
                mObj.seteName("Dried shrimp spinach with pasta in tomato sauce Vegetables balls in zucchini section");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "The bakery";//ºë¿ïÄÑ¥]
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¶ð­»°_¤hÄÑ¥]");
                mObj.seteName("French bread with cheese fresh basil ");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ªk°ê¿iÛ£¥]");
                mObj.seteName("French mushroom roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ªÛ³ÂÄÑ¥]±ø");
                mObj.seteName("Grissini with sesame");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¶Â´Ô¬v½µ¥]");
                mObj.seteName("Onion bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»»[ÄÑ¥]");
                mObj.seteName("Garlic bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Sweet finale";//²¢»e§¹¬üºë¿ï
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("©u¸`ÂAªG");
                mObj.seteName("Seasonal fresh fruit");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ºë¿ï°_¥q");
                mObj.seteName("Selection of cheese");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­[²úªá¯ù¿L³J");
                mObj.seteName("Jasmin tea with egg pudding");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ÂÐ¬Ö¤l°_¤h³J¿|");
                mObj.seteName("Raspberry cheese cake");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen¡VDazs ¦B²N²O");
                mObj.seteName("Haagen¡VDazs ice cream");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
             mType = "Light bites menu";//»´­¹
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("¬õ¿N¥xÆW¤û¦×ÄÑ (¥i¨É¥Î§Ö³tºë½oÄÑÂI)");
                mObj.seteName("Authentic Taiwanese beef noodle soup ( Fast and delicate of Taiwan delight)");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("¦×Àê¦Ì­a¥Ø");
                mObj.seteName("Hakka rice noodle with minced pork and shallot");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("ÅÚ½³¥]À`³½¤Y´ö");
                mObj.seteName("Stuffed fish ball and turnip soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("¾¥¦è­ô¤û¦×°_¤h¾Ø");
                mObj.seteName("Mexico beef cheese tart ");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("¯À­¹§Y­¹ÄÑ");
                mObj.seteName("Vegetarian instant noodle");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("ºë¿ï°_¥q½L");
                mObj.seteName("Cheese platter");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("ºë¿ïªG¨§");
                mObj.seteName("Mixed nuts");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
             mType = "Breakfast menu";//    ¦­À\µæ³æ
                mObj = new MenuMealTypeObj();
                alacart = "dirnk";
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¬h¾í¥Ä");
                mObj.seteName("Orange");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Ä«ªG¥Ä");
                mObj.seteName("Apple");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                         
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("µf­X¥Ä");
                mObj.seteName("Tomato");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                              
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤û¥¤");
                mObj.seteName("Milk");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "others";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("®ÉÂA¤ôªG");
                mObj.seteName("Fresh fruits of the season");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("âBÃþ¯Ü¤ù");
                mObj.seteName("Cereals");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;                
         
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Àu®æ");
                mObj.seteName("Yogurt ");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;    
                

                alacart="ºë¿ïÄÑ¥]¦õ¥¤ªo¤ÎªGÂæ";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("°sÆC®Û¶êÄÑ¥]");
                mObj.seteName("fermented with red wine s");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¾í¥Ö¥i¥i¨È");
                mObj.seteName("Chocolate bread with dried orange peel ");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                             
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥i¹|");
                mObj.seteName("Croissant");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("«p¤ù¥Õ¦R¥q");
                mObj.seteName("White Toast");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                
                alacart="Main course";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Äªµ«°_¤h­JÅÚ½³³J¥]  ¦õ¬v¨¡ «Cªáµæ  µf­X  Àj³½Û£  ·ÏÂt±a¥Ö¤õ»L");
                mObj.seteName("Asparagus cheese carrot omelette with potatoes Broccoli  tomato  oyster mushroom  smoked virginia ham");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ªQÅSÂæª£³J  ¦õ­^¦¡ÃP»æ³ù °ö®ÚÀÍ¥Ê  ¬vÛ£ µf­X  ·ÏÂt±a¥Ö¤õ»L");
                mObj.seteName("Scrambled eggs in truffle mushroom sauce with muffin Squash with bacon  button mushroom  smoked virginia ham");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("²Mµ° --µæ¨j½µªá·Î³J¡B¥Ê¤l¦×»æ¡B­»³ÂÂæ¹L¿ß¡B²D©Õ®ü¸½,·sªF¶§¦×ÃP¡BÄÐ³J");
//                mObj.setDetail("²Mµ°(Plain congee),¤­½\ÂøÂ³µ°(Oat congee)");
                mObj.seteName("Plain congee--Assorted delicatessen,Pan-fried eggs with pickled turnip,Pork and pickled cucumber patties," +
                		"Vegetable fern with sesame dressing,Jelly fish salad,Shredded dry pork Salted egg, " +
                		"homemade Chinese steamed bun, Traditional Taiwanese side dishes are available upon request");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
               
                
        }//004
        else if("0006".equals(fltno))//#777
        {
            mClassType="C";  
            /***C¿µ***/   
            mType = "Dinner menu";//±ßÀ\
//            
                alacart = "Appetizer,Salad,Soup";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("«eµæ-¥Ð¶é¨F©Ô ¦õ©M­·ªÛ³ÂÂæ\n" +
                        "¨F©Ô-¶}¤ßªG°_¤hÂtÂD³½\n" +
                        "´ö«~-«½«½µæ¿L¦Ëµ·Âû´ö");
                mObj.seteName("Garden salad with sesame salad dressing\n" +
                        "Smoked salmon with pistachios cream cheese\n"+
                        "Chicken soup with baby cabbage blanched\n");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(40);        
                mainMeal.add(mObj);
                mObj = null;  
                alacart = "Main course";//¥Dµæ
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("³Â­»¬ÃÛ£½Þ  ¦õ¦Ì¶º\n ¥ÕªG  «C¦¿µæ  ­JÅÚ½³");
                mObj.seteName("Stir-fried pork and mushroom with steamed rice ginko nut  pak choy  carrot");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                           
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¬õ°sÀíµæ¿L¤û¦× ¦õ¬õ¬v¨¡ ÂE³ßÛ£ ÀÍ¥Ê");
//                mObj.setDetail("­»®Æ¿»­X¥¤ªoÂæ¥Ä(pesto-tomato cream sauce),ªi¯S°sÂæ¥Ä(port wine sauce)");
                mObj.seteName("Braised beef in red wine vegetables sauce with new potatoes abalone mushroom  zucchini");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                                          
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ÂfÂc¥¤ªoÂæ¥ÄµÔµæ÷«³½²y  ¦õ­XÂæ±²ÄÑ ÂE³ßÛ£ ÀÍ¥Ê");
//                mObj.setDetail("­»®Æ¿»­X¥¤ªoÂæ¥Ä(pesto-tomato cream sauce),ªi¯S°sÂæ¥Ä(port wine sauce)");
                mObj.seteName("Dried shrimp spinach in lemon butter sauce with tomato sauce pasta abalone mushroom  zucchini");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                        
                alacart = "Assorted bread selection";//ÄÑ¥]
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¶ð­»°_¤hÄÑ");
                mObj.seteName("French bread with cheese  fresh basil");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤é¦¡³nÄÑ¥]");
                mObj.seteName("Japanese soft roll");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(40);        
                mainMeal.add(mObj);
                mObj = null;

                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»»[ÄÑ¥]");
                mObj.seteName("Garlic bread");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;                
                
                alacart = "Sweet finale";//²¢»e§¹¬üºë¿ï
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("°_¤h½L");
                mObj.seteName("Cheese platter");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(40);       
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ÂÐ¬Ö¤l°_¤h³J¿|");
                mObj.seteName("Raspberry cheese cake");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(40);         
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen¡VDazs ¦B²N²O");
                mObj.seteName("Haagen¡VDazs ice cream");
                mObj.setClassType(mClassType);    
                mObj.setDetail("­»¯ó,¯ó²ù");
                mObj.setQuantity(40);        
                mainMeal.add(mObj);
                mObj = null;                
                       
             mType = "Gourmet savory";
                alacart = "ºë¬üÂI¤ß";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("¦×Àê¦Ì­a¥Ø");
                mObj.seteName("Hakka rice noodle with minced pork and shallot");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("¾¥¦è­ô¤û¦×°_¤h¾Ø");//(¤û¦×¨Ó·½¡G ¯Ã¦èÄõ)
                mObj.seteName("Mexican style beef and cheese tart");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
               
            mType = "Breakfast menu";//¦­À\µæ³æBreakfast menu
                alacart = "Breakfast";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¦è¦¡-\n" +
                		"®ÉÂA¤ôªG Àu®æ\n" +
                		"¥Dµæ-µÔµæ¯Z¥§´µ³J¥] ¦õªÛ³Â¬v¨¡\n©¬º¿¤õ»L  µf­X «Cªáµæ");
                mObj.setDetail("°sÆC®Û¶êÄÑ¥](Longan bread mixed with red wine),¥i¹|(Croissant),¥Õ¦R¥q(White toast)");
                mObj.seteName("Fresh fruits of the season, Yogurt\n" +
                		"Main course-\nBaked omelette in spinach bearnaise sauce with sesame parsley potatoes Parma ham, tomato, broccoli\n" );
                mObj.setClassType(mClassType);             
//                mObj.setDetail("­»Âb¯ñºwÂûºë");
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
//                alacart = "Chinese breakfast";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤¤¦¡-\n" +
                		"®ÉÂA¤ôªG\n" +
                		"²Mµ°  »P  ¤pµæºë¿ï:µæ¨j½µªá·Î³J,¥Ê¤l¦×»æ,­»³ÂÂæ¹L¿ß,ÄÐ³J,·sªF¶§¦×ÃP,¤¤¦¡¬üÂI");
//                mObj.setDetail("²Mµ°(Plain congee),¿P³Áµ°(mung bean congee)");
                mObj.seteName("Plain congee ,Seasonal fresh fruits\n" +
                        "Assorted delicatessen:\n" +
                		"Pan-fried eggs with pickled turnip,\n" +
                		"Pork and pickled cucumber patties,\n" +
        		        "Vegetable fern with sesame dressing,\n" +
        		        "Shredded dry pork  salted egg,\n " +
        		        "Steamed bun");
                mObj.setClassType(mClassType);              
//                mObj.setDetail("­»Âb¯ñºwÂûºë");
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
          }//0006
          else if( "0008".equals(fltno) ) //#777
          {
              mClassType="C";  
              /***C¿µ***/   
          mType = "Late night supper";//®d©]«KÀ\
          alacart = "Salad,Soup,Sweet finale";
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("¨F©Ô-¥Ð¶é¨F©Ô  ¦õ©M­·ªÛ³ÂÂæ\n" +
                      "´ö«~-«½«½µæ¿L¦Ëµ·Âû´ö\n" );
              mObj.seteName("Salad-Garden salad with sesame salad dressing\n"+
                      "Soup-Chicken soup with baby cabbage blanched\n");
              mObj.setClassType(mClassType);  
//              mObj.setDetail("­»¯ó,¯ó²ù");
              mObj.setQuantity(40);        
              
              mainMeal.add(mObj);
              mObj = null;  
           alacart = "Main course";//¥Dµæ
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("³Â­»¬ÃÛ£½Þ  ¦õ¦Ì¶º ¥ÕªG  «C¦¿µæ  ­JÅÚ½³");
              mObj.seteName("Stir-fried pork and mushroom with steamed rice ginko nut  pak choy  carrot");
              mObj.setClassType(mClassType);              
//              mObj.setQuantity(10);        
              mainMeal.add(mObj);
              mObj = null; 

              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("¬õ°sÀíµæ¿L¤û¦×   ¦õ¬õ¬v¨¡  ÂE³ßÛ£ ÀÍ¥Ê");
//              mObj.setDetail("­»®Æ¿»­X¥¤ªoÂæ¥Ä(pesto-tomato cream sauce),ªi¯S°sÂæ¥Ä(port wine sauce)");
              mObj.seteName("Braised beef in red wine vegetables sauce with new potatoes abalone mushroom zucchini");
              mObj.setClassType(mClassType);              
//              mObj.setQuantity(10);        
              mainMeal.add(mObj);
              mObj = null; 
                                        
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("ÂfÂc¥¤ªoÂæ¥ÄµÔµæ÷«³½²y  ¦õ­XÂæ±²ÄÑ ÂE³ßÛ£ ÀÍ¥Ê");
//              mObj.setDetail("­»®Æ¿»­X¥¤ªoÂæ¥Ä(pesto-tomato cream sauce),ªi¯S°sÂæ¥Ä(port wine sauce)");
              mObj.seteName("Dried shrimp spinach in lemon butter sauce with tomato sauce pasta abalone mushroom  zucchini");
              mObj.setClassType(mClassType);              
//              mObj.setQuantity(10);        
              mainMeal.add(mObj);
              mObj = null;
                      
           alacart = "Assorted bread selection";//ÄÑ¥]
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("¶ð­»°_¤hÄÑ");
              mObj.seteName("French bread with cheese  fresh basil");
              mObj.setClassType(mClassType);              
              mObj.setQuantity(20);        
              mainMeal.add(mObj);
              mObj = null;
              
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("¤é¦¡³nÄÑ¥]");
              mObj.seteName("Japanese soft roll");
              mObj.setClassType(mClassType);              
              mObj.setQuantity(40);        
              mainMeal.add(mObj);
              mObj = null;

              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("­»»[ÄÑ¥]");
              mObj.seteName("Garlic bread");
              mObj.setClassType(mClassType);              
              mObj.setQuantity(20);        
              mainMeal.add(mObj);
              mObj = null;                
              
           alacart = "Sweet finale";//²¢»e§¹¬üºë¿ï              
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("°_¤h½L");
              mObj.seteName("Cheese platter");
              mObj.setClassType(mClassType);              
              mObj.setQuantity(40);       
              mainMeal.add(mObj);
              mObj = null;
              
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("ÂÐ¬Ö¤l°_¤h³J¿|");
              mObj.seteName("Raspberry cheese cake");
              mObj.setClassType(mClassType);              
              mObj.setQuantity(40);         
              mainMeal.add(mObj);
              mObj = null;
              
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("Haagen¡VDazs ¦B²N²O");
              mObj.seteName("Haagen¡VDazs ice cream");
              mObj.setClassType(mClassType);    
              mObj.setDetail("­»¯ó,¯ó²ù");
              mObj.setQuantity(40);        
              mainMeal.add(mObj);
              mObj = null;                
                     
           mType = "Gourmet savory";
              alacart = "ºë¬üÂI¤ß";
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setName("¦×Àê¦Ì­a¥Ø");
              mObj.seteName("Hakka rice noodle with minced pork and shallot");
              mObj.setClassType(mClassType);              
//              mObj.setQuantity(20);        
              mainMeal.add(mObj);
              mObj = null;
              
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setName("¾¥¦è­ô¤û¦×°_¤h¾Ø");//(¤û¦×¨Ó·½¡G ¯Ã¦èÄõ)
              mObj.seteName("Mexican style beef and cheese tart");
              mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
              mainMeal.add(mObj);
              mObj = null;
                                         
              mType = "Breakfast menu";//¦­À\µæ³æBreakfast menu
              alacart = "Breakfast";
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("¦è¦¡-\n" +
                      "®ÉÂA¤ôªG Àu®æ\n" +
                      "¥Dµæ-µÔµæ¯Z¥§´µ³J¥] ¦õªÛ³Â¬v¨¡\n©¬º¿¤õ»L  µf­X «Cªáµæ");
              mObj.setDetail("°sÆC®Û¶êÄÑ¥](Longan bread mixed with red wine),¥i¹|(Croissant),¥Õ¦R¥q(White toast)");
              mObj.seteName("Fresh fruits of the season, Yogurt\n" +
                      "Main course-\nBaked omelette in spinach bearnaise sauce with sesame parsley potatoes Parma ham, tomato, broccoli\n" );
              mObj.setClassType(mClassType);             
//              mObj.setDetail("­»Âb¯ñºwÂûºë");
  //            mObj.setQuantity(5);        
              mainMeal.add(mObj);
              mObj = null;
              
//              alacart = "Chinese breakfast";
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("¤¤¦¡-\n" +
                      "®ÉÂA¤ôªG \n" +
                      "²Mµ°  »P  ¤pµæºë¿ï:µæ¨j½µªá·Î³J,¥Ê¤l¦×»æ,­»³ÂÂæ¹L¿ß,ÄÐ³J,·sªF¶§¦×ÃP, ¤¤¦¡¬üÂI");
//              mObj.setDetail("²Mµ°(Plain congee),¿P³Áµ°(mung bean congee)");
              mObj.seteName("Plain congee  ,Soy bean milk ,Seasonal fresh fruits\n" +
                      "Assorted delicatessen:\n" +
                      "Pan-fried eggs with pickled turnip,\n" +
                      "Pork and pickled cucumber patties,\n" +
                      "Vegetable fern with sesame dressing,\n" +
                      "Shredded dry pork  salted egg,\n " +
                      "Steamed bun");
              mObj.setClassType(mClassType);              
//              mObj.setDetail("­»Âb¯ñºwÂûºë");
  //            mObj.setQuantity(5);        
              mainMeal.add(mObj);
              mObj = null;
        }//008
   
//        if(sect.substring(4).equals("TPE"))    
        if("0003".equals(fltno))
        {
            mType = "Late night supper";//®d©]«KÀ\
                alacart = "Appetizer";//«eµæ
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Àj³½ º±Âû¦× ÃÉ¸}¦×");
                mObj.seteName("Abalone sliced  marinated soya chicken  crab claw");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ÃÉ¦×¶ð  ¦õ¹T±ù µf­X Äªµ«¨F©Ô");
                mObj.seteName("Crab meat tartar with avocado  tomato  asparagus micro greens");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                alacart = "Soup";//´ö«~
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("±Æ°©ªá¥Í½¬ÃÂ´ö");
                mObj.seteName("Braised lotus root with peanuts and pork rib soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¬õÅÚ½³¨¾­·¯ó´ö°t¬µ¿¾ãR");
                mObj.seteName("Carrot and parsnip soup with turnip chips");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Main course";//¥Dµæ
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¶Â­J´Ô¤û¥J°©  Á¤½µÃzÀs½¼  ªãÄõ ¦õµ·­]¦Ì¶º");
                mObj.seteName("Stir- fried beef short ribs in black pepper sauce Stir- fried lobster with ginger onion sauce¡@kai lan  steamed rice");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¿L¦Ï½¥  ºî¦X®É½­  ¦õµf¬õªá¦Ì¶º");
                mObj.seteName("Braised lamb shank assorted seasonal vegetables, saffron rice");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»·ÎÆt³½  ÀÍ¥Ê ¬õÅÚ½³ ­·°®µf­X  ¦õ¥_«D¤p¦Ì  ®ÉÅÚµÜ©i¥ÕÂæ¥Ä");
                mObj.seteName("Seared sea bass Zucchini  carrot  sun-dried tomato with couscous¡@dill and lime cream sauce");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "The bakery";//ºë¿ïÄÑ¥]                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¸q¦¡©ì¾cÄÑ¥]");
                mObj.seteName("Ciabatta bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤â±²ÄÑ¥]");
                mObj.seteName("Twist roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¾ñÆVÄÑ¥]");
                mObj.seteName("Olive roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("°g­¡­»ÄÑ¥]");
                mObj.seteName("Rosemary roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»»[ÄÑ¥]");
                mObj.seteName("Garlic bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Dessert ";//²¢ÂI
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("©u¸`ÂAªG");
                mObj.seteName("Fresh fruits of the season");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ºë¿ï°_¥q½L");
                mObj.seteName("Selection of cheese");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("»È¦Õ·¦¥¤¥É¦ÌÅS");
//                mObj.setDetail("·Å¼ö (warm),§N­¹(cold)");
                mObj.seteName("A White fungus, sweet corn with coconut milk sweet soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("©@°Ø¼}´µ¦õÂÐ¬Ö¤lÂæ");
                mObj.seteName("Coffee mousse with raspberry jam");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen¡VDazs ¦B²N²O");
                mObj.seteName("Haagen¡VDazs ice cream");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
             mType = "Light bites menu";//»´­¹
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("ºë½o¬õ¿N¤û¦×ÄÑ");
                mObj.seteName("Authentic Taiwanese beef noodle soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("¤@«~®üÂA´öÄÑ");
                mObj.seteName("Imperial seafood noodle soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("°ö®ÚµÔµæÄÐ¬£");
                mObj.seteName("Bacon and spinach quiche");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("¯À­¹§Y­¹ÄÑ");
                mObj.seteName("Vegetarian instant noodle");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("¦õ°s°_¥q½L");
                mObj.seteName("Cheese platter");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("ºë¿ïªG¨§");
                mObj.seteName("Mixed nuts");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
             mType = "Breakfast menu";//    ¦­À\µæ³æ
                mObj = new MenuMealTypeObj();
                alacart = "dirnk";
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¬h¾í¥Ä");
                mObj.seteName("Orange juice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);   
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Ä«ªG¥Ä");
                mObj.seteName("Apple juice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                         
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("µf­X¥Ä");
                mObj.seteName("Tomato juice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);    
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "others";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("®ÉÂA¤ôªG");
                mObj.seteName("Fresh fruits of the season");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);  
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("âBÃþ¯Ü¤ù");
                mObj.seteName("Cereals");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);  
                mainMeal.add(mObj);
                mObj = null;                
         
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Àu¹T¨Å");
                mObj.seteName("Drinking yogurt");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);      
                mainMeal.add(mObj);
                mObj = null;    
                
    
                alacart="ºë¿ïÄÑ¥]¦õ¥¤ªo¤ÎªGÂæ";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥i¹|ÄÑ¥]");
                mObj.seteName("Croissant");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¿P³Á°¨ªâ");
                mObj.seteName("Oatmeal muffin");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                             
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»¿¼°íªG³J¿|");
                mObj.seteName("Banana nut cake");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("«p¤ù¦R¥q");
                mObj.seteName("Thick white toast");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                
                alacart="Main course";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¦è¦¡±m´Ôµf­X³J¥Õ³J¥]  ¦õ¬v¨¡»æ Äªµ« µf­X ¥[®³¤j¤õ»L  ±m´Ôµf­X²ï²ï  ");
                mObj.seteName("Egg white omelet with potato cake  asparagus tomato Canadian ham bell pepper and tomato salsa ");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥¬¤B¦õÂø²ù¤Î­»¯óÂæ");
                mObj.seteName("Nutella bread pudding mixed berries  vanilla sauce");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("²Mµ°--  ¦×Àêµæ¤ß¡B ½¼¤¯½µªá·Î³Jv³·µæª£¤zµ·¡B ²D©Õ½¬ÃÂÄ¨Û£¡B ºë¿ï¦×ÃP¡B ¥þ³ÁÄCÀY¡B ¥t³Æ¦³ÃhÂÂÂæµæ¨Ñ®È«È¿ï¥Î");
                mObj.seteName("Plain congee--   Stir-fried Choy Sum with minced pork sauce ," +
                        "Pan-fried egg with shrimp and green onion," +
                        "Marinated lotus roots with beech mushroom," +
                        "tir-fried mustard green with bean curd sheet." +
                        "Shredded dry pork, Steamed whole wheat bun." +
                        "Traditional Taiwanese side dishes are available upon request");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
        }//003
        else if ("0005".equals(fltno))//#777
        {mClassType="C";  
        /***C¿µ***/   
        mType = "Dinner menu";//±ßÀ\
            alacart = "Appetizer,Salad,Soup";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("«eµæ-©¬º¿¤õ»L ÂA½¼¦õ¨~ªG²ï²ï\n" +
                    "¨F©Ô-¥Ð¶é¨F©Ô ¦õ¸q¤j§Qªo¾LÂæ\n" +
                    "´ö«~-§öÀjÛ£»È¦ÕÂû´ö");
            mObj.seteName("Appetizer-Prosciutto di parma and shrimp with mango salsa\n" +
                    "Salad-Garden salad with Italian balsamic olive dressing\n"+
                    "Soup-Chicken soup with king oyster mushroom and snow fungus\n");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(40);        
            mainMeal.add(mObj);
            mObj = null;  
            alacart = "Main course";//¥Dµæ
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("µL¿ü±Æ°© ¦õ¦Ì¶º «C¦¿µæ ¬õ´Ô ¥ÕªG");//\n
            mObj.seteName("Braised pork spareribs Wu-shi style with steamed rice Chinese green  red pepper  gingko nuts");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null; 
                       
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("ª¥¯N¤ûµá¤O¦Ê¨½­»Âæ ¦õªk°ê¥¤­»ÖK¯N¬v¨¡ ­JÅÚ½³ ªá·¦µæ ");
//            mObj.setDetail("­»®Æ¿»­X¥¤ªoÂæ¥Ä(pesto-tomato cream sauce),ªi¯S°sÂæ¥Ä(port wine sauce)");
            mObj.seteName("Grilled beef tenderloin with gratin potato baby carrots  broccoli  thyme jus");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null; 
                                      
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("Ã¹°Çµf­XÂæ½¼¤Î¤z¨© ¦õ»[­»¸q¤j§Q«ó¥­²ÓÄÑ ºñÄªµ«");
//            mObj.setDetail("­»®Æ¿»­X¥¤ªoÂæ¥Ä(pesto-tomato cream sauce),ªi¯S°sÂæ¥Ä(port wine sauce)");
            mObj.seteName("Sauteed shrimp and scallop in tomato basil sauce with garlic basil linguini asparagus");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
                    
            alacart = "Assorted bread selection";//ÄÑ¥]
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("ªk¦¡¥¤ªo³J±²");
            mObj.seteName("Roll brioche");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(40);        
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("¥þ³ÁÄÑ¥]");
            mObj.seteName("Wheat bread");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(40);        
            mainMeal.add(mObj);
            mObj = null;

            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("­»»[ÄÑ¥]");
            mObj.seteName("wheat roll");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(40);        
            mainMeal.add(mObj);
            mObj = null;                
            
            alacart = "Sweet finale";//²¢»e§¹¬üºë¿ï
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("¤ôªG");
            mObj.seteName("fresh fruits of the season");
            mObj.setClassType(mClassType);
            mObj.setQuantity(40);       
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("°_¤h½L");
            mObj.seteName("Cheese platter");
            mObj.setClassType(mClassType); 
            mObj.setQuantity(40);       
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("¼¯¥d¼}´µ³J¿|");
            mObj.seteName("Mocha mousse cake  ");
            mObj.setClassType(mClassType);
            mObj.setQuantity(40);       
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("Haagen¡VDazs ¦B²N²O");
            mObj.seteName("Haagen¡VDazs ice cream");
            mObj.setClassType(mClassType);
            mObj.setDetail("­»¯ó,¯ó²ù");
            mObj.setQuantity(40);          
            mainMeal.add(mObj);
            mObj = null;                
                   
         mType = "Gourmet savory";
            alacart = "ºë¬üÂI¤ß";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setName("¼s¦¡ÂI¤ß ÂA½¼¸z¯» Âû¦×¿N½æ µÔµæ»å ");
            mObj.seteName("Dim sim,steamed,shrimp rice roll,chicken siew mai,spinach dumpling");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(20);        
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setName("Âû¦×¬£");
            mObj.seteName("Chicken pot pie");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
           
        mType = "Breakfast menu";//¦­À\µæ³æBreakfast menu
            alacart = "Breakfast";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("¦è¦¡-\n" +
                    "®ÉÂA¤ôªG Àu®æ\n" +
                    "¥Dµæ-°_¤h³J¥] ¦õ­ì¨ý¬v¨¡ Âû¦×¸z ¯N¨§µf­X¬Ø ªá·¦µæ");
            mObj.setDetail("¥i¹|(Croissant),Ä«ªG¤¦³Á¶p(apple Danish),¥Õ¦R¥q(White toast)");
            mObj.seteName("Fresh fruits of the season, Yogurt\n" +
                    "Main course-\nPepper Jack cheese omelette with steamed potato chicken sausage  baked bean  broccoli ");
            mObj.setClassType(mClassType);   
//            mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
            
//            alacart = "Chinese breakfast";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("¤¤¦¡-\n" +
                    "®ÉÂA¤ôªG\n" +
                    "¤pµæºë¿ï:¦×Àêµæ¤ß ,½¼¤¯½µªá·Î³J ,²D©Õ½¬ÃÂ¤ÎÄ¨Û£ ,¦×ÃP,¤¤¦¡¬üÂI");
//            mObj.setDetail("²Mµ°(Plain congee),¿P³Áµ°(mung bean congee)");
            mObj.seteName("Fresh fruits of the season\n" +
            		" Plain congee\n " +
            		" Assorted delicatessen\n" +
            		" stir-fried Choy Sum with minced pork sauce\n " +
            		" pan-fried egg with shrimp and green onion\n" +
            		" marinated lotus roots with beech mushroom\n" +
            		" shredded dry pork\n" +
            		" Steamed whole wheat bun");
            mObj.setClassType(mClassType);      
//            mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
            
        }//005
        else if("0007".equals(fltno))//#777
        {

            mClassType="C";  
            /***C¿µ***/   
            mType = "Late night supper";//®d©]«KÀ\
                alacart = "Salad,Soup,Sweet finale";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¨F©Ô-ºî¦X¨F©Ô¤Î¸q¤j§Qªo¾L\n" +
                        "´ö«~-§öÀjÛ£»È¦ÕÂû´ö\n");
                mObj.seteName("Salad-Garden salad with Italian balsamic olive dressing\n"+
                        "Soup-Chicken soup with king oyster mushroom and snow fungus\n");
                mObj.setClassType(mClassType);         
                mObj.setDetail("­»¯ó,¯ó²ù");
                mObj.setQuantity(40);        
                mainMeal.add(mObj);
                
                mObj = null;  
                alacart = "Main course";//¥Dµæ
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("µL¿ü±Æ°© ¦õ¦Ì¶º «C¦¿µæ ¬õ´Ô ¥ÕªG");
                mObj.seteName("Braised pork spareribs Wu-shi style with steamed rice Chinese green  red pepper  gingko nuts");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                           
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ª¥¯N¤ûµá¤O¦Ê¨½­»Âæ ¦õªk°ê¥¤­»ÖK¯N¬v¨¡ ­JÅÚ½³ ªá·¦µæ");
    //            mObj.setDetail("­»®Æ¿»­X¥¤ªoÂæ¥Ä(pesto-tomato cream sauce),ªi¯S°sÂæ¥Ä(port wine sauce)");
                mObj.seteName("Grilled beef tenderloin with gratin potato baby carrots  broccoli  thyme jus");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                                          
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Ã¹°Çµf­XÂæ½¼¤Î¤z¨© ¦õ»[­»¸q¤j§Q«ó¥­²ÓÄÑ ºñÄªµ« ");
    //            mObj.setDetail("­»®Æ¿»­X¥¤ªoÂæ¥Ä(pesto-tomato cream sauce),ªi¯S°sÂæ¥Ä(port wine sauce)");
                mObj.seteName("Sauteed shrimp and scallop in tomato basil sauce with garlic basil linguini asparagus");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                        
                alacart = "Assorted bread selection";//ÄÑ¥]
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ªk¦¡¥¤ªo³J±²");
                mObj.seteName("Roll brioche");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(40);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥þ³ÁÄÑ¥]");
                mObj.seteName("wheat bread ");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(40);        
                mainMeal.add(mObj);
                mObj = null;
    
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤p³ÁÄÑ¥]");
                mObj.seteName("garlic bread");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(40);        
                mainMeal.add(mObj);
                mObj = null;          
                
             alacart = "Sweet finale";//²¢»e§¹¬üºë¿ï
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤ôªG");
                mObj.seteName("fresh fruits of the season");
                mObj.setClassType(mClassType);
                mObj.setQuantity(40);       
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("°_¤h½L");
                mObj.seteName("Cheese platter");
                mObj.setClassType(mClassType); 
                mObj.setQuantity(40);       
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¼¯¥d¼}´µ³J¿|");
                mObj.seteName("Mocha mousse cake  ");
                mObj.setClassType(mClassType);
                mObj.setQuantity(40);       
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen¡VDazs ¦B²N²O");
                mObj.seteName("Haagen¡VDazs ice cream");
                mObj.setClassType(mClassType);
                mObj.setDetail("­»¯ó,¯ó²ù");
                mObj.setQuantity(40);          
                mainMeal.add(mObj);
                mObj = null;            
                
             mType = "Gourmet savory";//»´­¹
                alacart = "ºë¬üÂI¤ß";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("ÂA½¼¸z¯» Âû¦×¿N½æ µÔµæ»å");
                mObj.seteName("Dim sim steamed shrimp rice roll,¡@chicken siew mai,¡@¡@spinach dumpling");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("Âû¦×¬£");
                mObj.seteName("Chicken pot pie");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("°_¤h½L");
                mObj.seteName("Cheese platter");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                             
            mType = "Breakfast menu";//¦­À\µæ³æBreakfast menu
                alacart = "Breakfast";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¦è¦¡-\n" +
                        "®ÉÂA¤ôªG Àu®æ\n" +
                        "¥Dµæ- °_¤h³J¥] ¦õ­ì¨ý¬v¨¡  Âû¦×¸z ¯N¨§µf­X¬Ø ªá·¦µæ");
                mObj.setDetail("¥i¹|(Croissant),Ä«ªG¤¦³Á¶p(apple Danish),¥Õ¦R¥q(White toast)");
                mObj.seteName("Fresh fruits of the season, Plain yogurt \n" +
                        "Main course-\nPepper Jack cheese omelette with steamed potato chicken sausage  baked bean  broccoli ");
                mObj.setClassType(mClassType); 
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
//                alacart = "Chinese breakfast";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤¤¦¡-\n" +
                        "®ÉÂA¤ôªG\n" +
                        "¤pµæºë¿ï:¦×Àêµæ¤ß ,½¼¤¯½µªá·Î³J ,²D©Õ½¬ÃÂ¤ÎÄ¨Û£ ,¦×ÃP,¤¤¦¡¬üÂI");
//                mObj.setDetail("²Mµ°(Plain congee),¿P³Áµ°(mung bean congee)");
                mObj.seteName("Fresh fruits of the season\n" +
                        " Plain congee\n" +
                        " Assorted delicatessen\n" +
                        " stir-fried Choy Sum with minced pork sauce\n " +
                        " pan-fried egg with shrimp and green onion\n" +
                        " marinated lotus roots with beech mushroom\n" +
                        " shredded dry pork\n" +
                        " Steamed whole wheat bun");
                mObj.setClassType(mClassType); 
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
        }//0007
        
        
        mClassType="C";  
        /***C¿µ***/
        if("TPEFRA".equals(sect))
        {
            mType = "Late night supper";//®d©]«KÀ\
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("¨F©Ô");
                mObj.setName("¥Ð¶é¨F©Ô ¦õ©M­·ªÛ³ÂÂæ");
                mObj.seteName("Garden salad with sesame dressing");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;            
                
                alacart = "¥Dµæ";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ªQ¨Á¦×»æ±² ¦õ±²ÄÑ ¬õÅÚ½³ ªá·¦µæ µf­X");
                mObj.seteName("Pork meat roll with noodle carrots  broccoli  tomato  ");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»¯N»Ä¥¤¦h§Q³½ ¦õÂfÂc­»®Æ¥¤ªo¤Î¶ÀÁ¤¶º  »[­»½¼¤¯ ªá·¦µæ ªQ¤l");
                mObj.seteName("Roasted sour cream fish with lemon and turmeric rice sauteed shrimp with garlic  broccoli  pine nut");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                
//                mObj = new MenuMealTypeObj();
//                mObj.setMealType(mType);
//                mObj.setAlacartType(alacart);
//                mObj.setName("Áú¦¡³J¶ÀÂæÂû»L-¦õ»[¨ý½¼¤¯¡B®É½­¤Î¥Õ¶º");
//                mObj.seteName("Grilled chicken thigh with burdock spicy sauce sauteed shrimp with garlic, mixed vegetables and steamed rice");
//                mObj.setClassType(mClassType);              
////                mObj.setQuantity(10);        
//                mainMeal.add(mObj);
//                mObj = null;
                
                alacart = "ºë¿ïÄÑ¥]¦õ¤â¤u¥¤ªo";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¶ð­»°_¤hÄÑ¥]");
                mObj.seteName("Hoshino salty bread");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤é¦¡³n¥]");
                mObj.seteName("garlic bread");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤j»[ÄÑ¥]");
                mObj.seteName("Italian style spice bread");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;         
                  
                alacart = "Taste of Taiwan";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥x¦¡¬õ¿N¤û¦×ÄÑ ºë¿ï¤pµæ");
                mObj.seteName("Authentic Taiwanese beef noodle soup Assorted side dishes  ");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "ºë¿ï²¢ÂI¶°";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»¨¡°_¤h³J¿| ¦õ¯ó²ùÀu®æÂæ");
                mObj.seteName("Mashed sweet taro cheese cake with strawberry yoghurt sauce");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen¡VDazs ¦B²N²O");
                mObj.seteName("Haagen¡VDazs ice cream");
                mObj.setClassType(mClassType);
                mObj.setDetail("­»¯ó,¯ó²ù");
                mObj.setQuantity(40);          
                mainMeal.add(mObj);
                mObj = null;    
                
            mType ="Light bites menu";
            alacart = "ªÅ¤¤¤pÂI";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¦×Àê¦Ì­a¥Ø");
                mObj.seteName("Hakka rice noodle with minced pork and shallot");
                mObj.setClassType(mClassType);              
    //          mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¾¥¦è­ô¤û¦×°_¤h¾Ø");
                mObj.seteName("Mexican style beef and cheese tart ");
                mObj.setClassType(mClassType);              
    //          mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
            mType = "Breakfast menu";//¦­À\
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("Western breakfast");
                mObj.setName("®ÉÂA¤ôªG\n" +
                        "Àu®æ\n  " +
                        "©¬º¿¤õ»L³J¥] ¦õªk¦¡µÔµæ¥¤ªoÂæ ªá·¦µæ ¬v¨¡ µf­X");
                mObj.seteName("FRESH FRUITS OF THE SEASON \n" +
                        "Yogurt \n" +
                        "Parma ham omelet with spinach bernaise sauce broccoli  potatoes  tomato ");
                mObj.setDetail("¥i¹|(Croissant),°sÆC®Û¶êÄÑ¥](Longan bread fermented with red wine croissant  ),¥Õ¦R¥q(White toast)");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("Chinese breakfast");
                mObj.setName("²Mµ°-µæ¨j½µªá·Î³J ¥Ê¤l¦×»æ    ­»³Â¹L¿ß ·sªF¶§¦×ÃP ¤¤¦¡¬üÂI");
                mObj.seteName("Plain congee--¡@pan-fried eggs with pickled turnip\n" +
                        "¡@¡@pork and pickled cucumber patties\n" +
                        "   vegetable fern with sesame dressing\n" +
                        "   shredded dry pork,Steamed bun");
                mObj.setClassType(mClassType);              
    //          mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
        } 
//0062
        if("FRATPE".equals(sect) )
        {
            mType = "Lunch menu";//¤ÈÀ\
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("«eµæ");
                mObj.setName("¼Ú¦¡®üÂAµf­X¬Ø");
                mObj.seteName("Marinated seafood stuffed in tomato cup ");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                alacart = "¨F©Ô";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥Ð¶é¨F©Ô ¦õ¸q¦¡ªo¾LÂæ");
                mObj.seteName("Garden salad with Italian dressing");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                alacart = "¥Dµæ";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤¤¦¡­»»[¬õÄK³½ ¦õ¦Ì¶º ªãÂÅ ¬õÅÚ½³");
                mObj.seteName("Fried red snapper in hot garlic sauce with steamed rice kai-lan  carrots ");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»·Î¬õ°s½Þ±Æ ¦õ¬v¨¡ªd ªá·¦µæ ¬õ´Ô");
                mObj.seteName("Fried pork fillet in red wine sauce with mashed potato broccoli  red pepper stripes " );
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»¯N¤z¨¶­»Ä«Âû±Æ ¦õ­ì¨ý¬v¨¡  ¬õÅÚ½³ ¥|©u¨§");
                mObj.seteName("Roasted chicken breast in calvados sauce with new potato baby carrots  French bean ");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "ºë¿ïÄÑ¥]¦õ¤â¤u¥¤ªo";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("»Ã¥À»ÄÄÑ¥]");
                mObj.seteName("Sourdough roll ");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;

                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ªk¦¡ÄÑ¥]");
                mObj.seteName("baguette roll ");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»»[ÄÑ¥]");
                mObj.seteName("garlic bread");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                
                alacart = "²¢«~";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥¤ªo¥¬Á¢¥©§J¤O ¦õ¯ó²ùÂæ");
                mObj.seteName("Creme brulee chocolate with fruity strawberry sauce ");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen¡VDazs ¦B²N²O");
                mObj.seteName("Haagen¡VDazs ice cream");
                mObj.setClassType(mClassType);
                mObj.setDetail("­»¯ó,¯ó²ù");
                mObj.setQuantity(40);          
                mainMeal.add(mObj);
                mObj = null;    
                
            mType ="Light bites menu";
            alacart = "ºë¿ïÂI¤ß";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤õÂû¦×¨Å¹T¤T©úªv");
                mObj.seteName("Turkey and cheese sandwich");
                mObj.setClassType(mClassType);              
    //          mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
            mType = "Refreshment";//«KÀ\
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("Western refreshment");
                mObj.setName("¥Ð¶é¨F©Ô ¦õªo¾LÂæ\n" +
                        "½­µæ¯N³J¬£ ¦õ­»·ÎÂû¶ô ªá·¦µæ Ä¨Û£ µf­X\n" +
                        "®ÉÂA¤ôªG");
                mObj.seteName("Garden salad with vinaigrette dressing\n" +
                        " Vegetable tortilla with seared chicken\n" +
                        " broccoli  mushroom  tomato");
                mObj.setClassType(mClassType); 
                mObj.setDetail("¶Â³ÁÄÑ¥](Rye roll),´ÔÆQ½¹½º»æ(pretzel roll  )");
                
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("Chinese refreshment");
                mObj.setName("¥VÛ£¤e¿N´öÄÑ\n" +
                        "«C¦¿µæ\n" +
                        "°ö®Úª£·¦µæ ­»½µÃz­»¸z ¡@º±µ«°® »¶­»»[¶Â­J´Ô¤ò¨§ \n" +
                        "®ÉÂA¤ôªG");
                mObj.seteName("¡@Chinese noodle soup with barbecued pork pak choy" +
                		"¡@sauteed cabbage with bacon,fried sausage with spring onion" +
                		"¡@braised bamboo shoots,green soybean with chili garlic and pepper\n" +
                        " Fresh fruits of the season");
                mObj.setClassType(mClassType);              
    //          mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
        }
        
//0051
        if("TPESYD".equals(sect) )//¥x¥_-³·±ù
        {
            mType = "Late night supper";//®d©]«KÀ\
                mObj = new MenuMealTypeObj();
//                mObj.setMealType(mType);
//                mObj.setAlacartType("«eµæ");
//                mObj.setName("µf­X¡B¹T±ù¡BÃÉ¦×¨F©Ô¦õµf¬õªá¬ü¥¤´þ");
//                mObj.seteName("Crab meat tartare tomato, avocado, micro greens, saffron mayonnaise");
//                mObj.setClassType(mClassType);              
////              mObj.setQuantity(5);        
//                mainMeal.add(mObj);
//                mObj = null;
            
//                alacart = "¨F©Ô";
//                mObj = new MenuMealTypeObj();
//                mObj.setMealType(mType);
//                mObj.setAlacartType(alacart);
//                mObj.setName("ÂA±m¬ü¨F©Ô¦õª÷®Ü®Ûªáªo¾LÂæ");
//                mObj.seteName("Garden salad with citrus onion ponzu dressing");
//                mObj.setClassType(mClassType);              
////              mObj.setQuantity(5);        
//                mainMeal.add(mObj);
//                mObj = null;
            
                alacart = "¥Dµæ";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¨F©Ô:¥Ð¶é¨F©Ô ¦õ©M­·ªÛ³ÂÂæ\n" +
                		    "¥Dµæ:µf­XÀí¤ûÀU¦×¡@¦õ»Aºñµæ¶º  ¥ÕªG «C¦¿µæ");
//                mObj.setDetail("¶ð­»°_¤hÄÑ¥](Hoshino salty bread),¤é¦¡³nÄÑ¥](Italian style spice bread),­»»[ÄÑ¥](garlic bread)");
                mObj.seteName("Salad:Garden salad with sesame salad dressing\n" +
                		"Main course:Braised beef in tangerine peel and royal port wine sauce with jade rice Beef from Australia gingko nuts  pak choy");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¨F©Ô:¥Ð¶é¨F©Ô ¦õ©M­·ªÛ³ÂÂæ\n" +
                		    "¥Dµæ:ªQ¨Á¦×»æ¡@¦õ±²ÄÑ  «Cªáµæ ¥Õªáµæ ­JÅÚ½³");
//                mObj.setDetail("¬P³¥ÆQÄÑ¥] (Hoshino salty bread),¸q¦¡­»¯óÄÑ¥](Italian style spice bread),­»»[ÄÑ¥](garlic bread)");
                mObj.seteName("Salad:Garden salad with sesame salad dressing\n" +
                        "Main course:Pork jowly meat roll with pasta  broccoli cauliflower carrot");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¨F©Ô:¥Ð¶é¨F©Ô ¦õ©M­·ªÛ³ÂÂæ\n" +
                		    "¥Dµæ:ª¥¯N»Ä¥¤¦h§Q³½¡@¦õªQ¤l¶ÀÁ¤¶º «Cªáµæ ¥Õªáµæ ­JÅÚ½³");
//                mObj.setDetail("¬P³¥ÆQÄÑ¥] (Hoshino salty bread),¸q¦¡­»¯óÄÑ¥](Italian style spice bread),­»»[ÄÑ¥](garlic bread)");
                mObj.seteName("Salad:Garden salad with sesame salad dressing\n" +
                        "Main course:Roasted fish in sour cream sauce with pine nut and turmeric rice broccoli cauliflower carrot");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "ºë¿ïÄÑ¥]¦õ¥¤ªo";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¶ð­»°_¤hÄÑ¥]");
                mObj.seteName("French bread with cheese fresh basil ");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
//
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤é¦¡³nÄÑ¥]");
                mObj.seteName("Japanese soft roll  ");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
//                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»»[ÄÑ¥]");
                mObj.seteName("garlic bread");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                                
                alacart = "²¢«~";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("°_¤h¤ôªG½L");
                mObj.seteName("Passion fruit mousse cake with raspberry sauce");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»¨¡°_¤h³J¿|¡@¦õ¯ó²ùÀu®æÂæ");
                mObj.seteName("Sweet taro cheese cake with strawberry yoghurt ");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen¡VDazs ¦B²N²O");
                mObj.seteName("Haagen¡VDazs ice cream");
                mObj.setClassType(mClassType);
                mObj.setDetail("­»¯ó,¯ó²ù");
                mObj.setQuantity(40);          
                mainMeal.add(mObj);
                mObj = null;  
                
                mType = "Breakfast menu";//¦­À\
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("Western breakfast");
                mObj.setName("®ÉÂA¤ôªG\n" +
                        "Àu®æ\n  " +
                        "µÔµæ¯Z¥§´µ³J¥] ¦õªÛ³Â¬v¨¡ ©¬º¿¤õ»L¡@µf­X¡@«Cªáµæ");
                mObj.setDetail("¦­À\½\Ãþ(Cereals)");
                mObj.seteName("FRESH FRUITS OF THE SEASON \n" +
                        "Yogurt\n" +
                        "Baked omelette in spinach bearnaise sauce with sesame parsley potato Parma ham  tomato  broccoli ");
                mObj.setClassType(mClassType);              
                mObj.setDetail("¥i¹|(Croissant),°sÆC®Û¶êÄÑ¥](Longan bread fermented with red wine croissant ),¥Õ¦R¥q(White toast)");                
                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("Chinese breakfast");
                mObj.setName("²Mµ°--µæ¨j½µªá·Î³J,¥Ê¤l¦×»æ,­»³ÂÂæ¹L¿ß,·sªF¶§¦×ÃP,ÄÐ³J,¤¤¦¡¬üÂI");
                mObj.seteName("SOYBEAN MILK\n" +
                        " Plain congee --¡@pan fried eggs with pickled turnip\n" +
                        "¡@pork and pickled cucumber patties\n" +
                        "¡@vegetable fern with sesame dressing\n" +
                        "¡@shredded dry pork  salted egg" +
                        " Steamed bun\n");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;                
           
        }
        
//0052
        if("SYDTPE".equals(sect) )//³·±ù-¥x¥_ 
        {
            mType = "Late night supper";//®d©]«KÀ\
            
            alacart = "Main course";//¥Dµæ
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("«eµæ:¥Ð¶é¨F©Ô¦õ¸q¦¡ªo¾LÂæ\n" +
                    "¥Dµæ:µL¿ü±Æ°©¡@¦õ¤z¨©³J¥Õª£¶º «C¦¿µæ  ¬õÅÚ½³");
//            mObj.setDetail("ªk°êÄÑ¥](White torpedo roll), ¨È³Â¬óÄÑ¥](linseed and soy roll), »ÄÄÑ¥](sourdough)"); 
            mObj.seteName("Starter:Garden salad balsamic vinaigrette\n" +
                    "Main course:Wu xi style pork ribs with egg white fried rice poy choy  carrot ");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null; 
                            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("«eµæ:¥Ð¶é¨F©Ô¦õ¸q¦¡ªo¾LÂæ\n" +
                    "¥Dµæ:ª¥¯N¤û¦Ø±Æ¡@¦õ¬v¨¡ªd  ¬õÅÚ½³ ¼Ú¦¡ÅÚ½³");
//            mObj.setDetail("ªk°êÄÑ¥](White torpedo roll), ¨È³Â¬óÄÑ¥](linseed and soy roll), »ÄÄÑ¥](sourdough)");                
            mObj.seteName("Starter:Garden salad balsamic vinaigrette\n" +
                    "Main course:Braise short beef ribs in red wine sauce with mashed potato carrot  parsnip ");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("«eµæ:¥Ð¶é¨F©Ô¦õ¸q¦¡ªo¾LÂæ\n" +
                    "¥Dµæ:¡@ãÂÅÚ³½±Æ¡@¦õ«CÂæ¸q¦¡¦ÌÄÑ  ¤°ÀA¿Lµæ");
//            mObj.setDetail("ªk°êÄÑ¥](White torpedo roll), ¨È³Â¬óÄÑ¥](linseed and soy roll), »ÄÄÑ¥](sourdough)"); 
            mObj.seteName("Starter:Garden salad balsamic vinaigrette\n" +
                    "Main Course:Dill crusted fish fillet with basil pesto orzo pasta ratatouille");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;   
            
            alacart = "ºë¿ïÄÑ¥]¦õ¥¤ªo";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("ªk°êÄÑ¥]");
            mObj.seteName("White torpedo roll");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
//
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("»Ä»rÄÑ¥]");
            mObj.seteName("Sourdough rye roll ");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
//            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("ÂøÂ³ÄÑ¥]");
            mObj.seteName("multigram roll  ");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
                            
            alacart = "²¢«~";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("°_¤h¤ôªG½L");
            mObj.seteName("Passion fruit mousse cake with raspberry sauce");
            mObj.setClassType(mClassType);              
//          mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("°_¤h³J¿|");
            mObj.seteName("Cheesecake ");
            mObj.setClassType(mClassType);              
//          mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("¦B²N²O");
            mObj.seteName("ice cream");
            mObj.setClassType(mClassType);
//            mObj.setDetail("­»¯ó,¯ó²ù");
            mObj.setQuantity(40);          
            mainMeal.add(mObj);
            mObj = null;  
            
            
         mType = "Breakfast menu";//    ¦­À\µæ³æ
            mObj = new MenuMealTypeObj();
            alacart = "Western breakfast";//"¦è¦¡ºë¿ï";
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("®ÉÂA¤ôªG\n" +
                    "Àu®æ\n" +
                    "¥Dµæ(µÔµæ°_¥q¯M³J¦õ°ö®Ú¬v¨¡  ¯Nµf­X¡@¤õ»L)\n" +
                    "ºë¿ïÄÑ¥]¦õ¥¤ªo¤ÎªGÂæ");
            mObj.seteName("Fresh fruits of the season,\n" +
                    "Yogurt,\n" +
                    "Main course:Spinach omelet with bacon potato grilled tomato  ham");
            mObj.setDetail("¥i¹|ÄÑ¥](Croissant),¥Õ¦R¥q(toast bread )");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(20);   
            mainMeal.add(mObj);
            mObj = null;
            
            alacart = "Chinese breakfast";//"¤¤¦¡ºë¿ï";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("²Mµ°\n" +
                    "¤pµæºë¿ï:µæ²ã³J ,¼s¦¡ª£®üÂA ,²D©Õ¤p¶À¥Ê ,¦×ÃP,½µªo»æ,®ÉÂA¤ôªG");
            mObj.seteName("Plain congee\n" +
                    "¡@¡@turnip egg cake, stir fried prawn and scallop,¡@¡@preserved cucumber,¡@¡@shredded dry pork  ,Green onion cake ,Seasonal fresh fruits\n");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(20);  
            mainMeal.add(mObj);
            mObj = null;
        }
        
//0031 YVR-TPE        
        if("0031".equals(fltno))
        {
            mType = "Late night supper";//®d©]«KÀ\
            alacart = "Appetizer";//«eµæ
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("·ÏÂtÂD³½¤ÎÀn¦×­á ¦õ¥Íµæ¨F©Ô");
            mObj.seteName("Smoked salmon and duck pate with salad");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
                        
            alacart = "Main course";//¥Dµæ
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("³a¥Ä¤û¦× ¦õ¦Ì¶º ªãÄõ ¬õÅÚ½³");
            mObj.seteName("Wok fried beef in black bean sauce with steamd rice kai lan  carrot ");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null; 
                            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("­J´ÔÂæ¯N½Þµá¤O ¦õÄ¨Û£¿L¶º «Cªáµæ ¬õÅÚ½³");
            mObj.seteName("Grilled pork tenderloin in green pepper sauce with mushroom risotto poy chay  carrot ");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("Âæ¿N¤ñ¥Ø³½ ¦õª£¶º  «C¦¿µæ ¬õÅÚ½³");
            mObj.seteName("Sauteed halibut fillet in brown sauce with fried rice poy chay  carrot");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
            
            alacart = "The bakery";//ºë¿ïÄÑ¥]¦õ¥¤ªo                              
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("¬v½µÄÑ¥]");
            mObj.seteName("Onion roll");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("ªk¦¡ÄÑ¥]");
            mObj.seteName("French roll");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("­»»[ÄÑ¥]");
            mObj.seteName("Garlic bread");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
                           
            alacart = "Dessert ";//²¢ÂI
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("§ö¤¯©@°Ø³J¿|");
            mObj.seteName("Almond  coffee cake ");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
            
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("Haagen-Daz¦B²N²O");
            mObj.seteName("Haagen-Daz ice cream");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
            
//         mType = "Light bites menu";//    ªÅ¤¤¤pÂI
//            
            alacart = "ªÅ¤¤¤pÂI";//"¦è¦¡ºë¿ï";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("ÂA¦×¥]");
            mObj.seteName("Steamed  pork bun");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(20);   
            mainMeal.add(mObj);
            mObj = null;   
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("Âû¦×¨F©Ô³ù");
            mObj.seteName("Ciabatta with chicken salad ");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(20);   
            mainMeal.add(mObj);
            mObj = null;  
            
         mType = "Breakfast menu";//    ¦­À\µæ³æ                
            alacart = "Western breakfast";//"¦è¦¡ºë¿ï";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("®ÉÂA¤ôªG¡BÀu®æ¡B¥Dµæ(¦è¯Z¤úÃ¾¸zµÔµæ³J¶ð ¦õ¯N¬õ¬v¨¡)¡Bºë¿ïÄÑ¥]¦õ¥¤ªo¤ÎªGÂæ");
            mObj.seteName("Fresh fruits of the season,\n" +
                    "Yogurt,\n" +
                    "Main course(Chorizo frittata with roasted potato cherry tomato  ),\n" +
                    "Assorted bread served with butter and jam."); 
            mObj.setDetail("¥Õ¦R¥q(Toast ),¥i¹|ÄÑ¥]( croissant)");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(10);   
            mainMeal.add(mObj);
            mObj = null;
            
            alacart = "Chinese breakfast";//"¤¤¦¡ºë¿ï";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("¤pµæºë¿ï(ÄÐµæ¦×µ·  µf­Xª£³J ²D©Õ¦Ëµ«  ¦×ÃP)¡B²Mµ°¡B¤¤¦¡¬üÂI");
            mObj.seteName("Assorted delicatessen(wok fried pork with preserved vegetable,scramble egg with tomato,bamboo shoot,shredded dry pork),\n" +
                    "Plain congee,Steamed bun");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(10);  
            mainMeal.add(mObj);
            mObj = null;
                
        }         
//0032 TPE-YVR        
        if("0032".equals(fltno))
        {
            mType = "Late night supper";//®d©]«KÀ\
                alacart = "Salad";//¨F©Ô
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥Ð¶é¨F©Ô¦õ©M­·ªÛ³ÂÂæ");
                mObj.seteName("Garden salad with sesame salad dressing");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                            
                alacart = "Main course";//¥Dµæ
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("µf­XÀí¤ûÀU¦×¦õ»Aºñµæ¶º ¥ÕªG«C¦¿µæ");
                mObj.seteName("Braised beef in tangerine peel and royal port wine sauce with jade rice Beef from Australia gingko nuts  pak choy");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ªQ¨Á¦×»æ¦õ±²ÄÑ «Cªáµæ¥Õªáµæ­JÅÚ½³");
                mObj.seteName("Pork jowly meat roll with pasta broccoli cauliflower carrot");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ª¥¯N»Ä¥¤¦h§Q³½¦õªQ¤l¶ÀÁ¤¶º «Cªáµæ¥Õªáµæ­JÅÚ½³");
                mObj.seteName("Roasted sour cream fish with pine nut and turmeric rice broccoli cauliflower carrot");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "The bakery";//ºë¿ïÄÑ¥]¦õ¥¤ªo                              
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¶ð­»°_¤hÄÑ¥]");
                mObj.seteName("Longan bread fermented with red wine");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤é¦¡³n¥]");
                mObj.seteName("Japanese soft roll  garlic bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤j»[ÄÑ¥]");
                mObj.seteName("Garlic bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                               
                alacart = "Dessert ";//²¢ÂI
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»¨¡°_¤h³J¿|¡@¦õ¯ó²ùÀu®æÂæ");
                mObj.seteName("Sweet taro cheese cake with strawberry yoghurt");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
//                alacart = " ";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen¡VDazs ¦B²N²O");
                mObj.seteName("Haagen¡VDazs");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
             mType = "Light bites menu";//    ªÅ¤¤¤pÂI
                
                alacart = "ªÅ¤¤¤pÂI";//"¦è¦¡ºë¿ï";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¦×Àê¦Ì­a¥Ø");
                mObj.seteName("Hakka rice noodle with minced pork and shallot ");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);   
                mainMeal.add(mObj);
                mObj = null;   
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¾¥¦è­ô¤û¦×°_¤h¬£¶ð");
                mObj.seteName("Mexico style beef cheese tart");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);   
                mainMeal.add(mObj);
                mObj = null;  
                
             mType = "Breakfast menu";//    ¦­À\µæ³æ                
                alacart = "Western breakfast";//"¦è¦¡ºë¿ï";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("®ÉÂA¤ôªG¡BÀu®æ¡B¥Dµæ(µÔµæ¯Z¥§´µ³J¥]¦õªÛ³Â¬v¨¡  ©¬º¿¤õ»Lµf­X«Cªáµæ)¡Bºë¿ïÄÑ¥]¦õ¥¤ªo¤ÎªGÂæ");
                mObj.seteName("Fresh fruits of the season,\n" +
                        "Yogurt,\n" +
                        "Main course(Baked omelette in spinach bearnaise sauce with sesame parsley potato Parma ham  tomato  broccoli),\n" +
                        "Assorted bread served with butter and jam."); 
                mObj.setDetail("¥Õ¦R¥q(Cereals),°sÆC®Û¶êÄÑ¥](Longan bread mixed with red wine),¥i¹|(Danish with rum raisin)");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(10);   
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Chinese breakfast";//"¤¤¦¡ºë¿ï";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("²Î¤@¨§¼ß¡B¤pµæºë¿ï(µæ¨j½µªá·Î³J  ¥Ê¤l¦×»æ  ­»³ÂÂæ¹L¿ß  ·sªF¶§¦×ÃP ÄÐ³J)¡B²Mµ°¡B¤¤¦¡¬üÂI");
                mObj.seteName("Soy bean milk,\nAssorted delicatessen(pan fried eggs with pickled turnip," +
                        "pork and pickled cucumber patties,vegetable fern with sesame dressing, shredded dry pork,salted egg),\n" +
                        "Plain congee,Steamed bun");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(10);  
                mainMeal.add(mObj);
                mObj = null;
                
        }        
  
//0063 TPE-VIE        
        if("0063".equals(fltno))
        {
            mType = "Late night supper";//®d©]«KÀ\
                alacart = "Salad";//¨F©Ô
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥Ð¶é¨F©Ô¦õ©M­·ªÛ³ÂÂæ");
                mObj.seteName("Garden salad with sesame dressing");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                            
                alacart = "Main course";//¥Dµæ
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ªQ¨Á¦×»æ±² ¦õ±²ÄÑ  ¬õÅÚ½³ ªá·¦µæ µf­X");
                mObj.seteName("Pork meat roll with noodle carrots  broccoli  tomato  ");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»¯N»Ä¥¤¦h§Q³½ ¦õÂfÂc­»®Æ¥¤ªo¤Î¶ÀÁ¤¶º »[­»½¼¤¯ ªá·¦µæ ªQ¤l");
                mObj.seteName("Roasted sour cream fish with lemon and turmeric rice sauteed shrimp with garlic  broccoli  pine nut");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
//                mObj = new MenuMealTypeObj();
//                mObj.setMealType(mType);
//                mObj.setAlacartType(alacart);
//                mObj.setName("ª¥¯N»Ä¥¤¦h§Q³½¦õªQ¤l¶ÀÁ¤¶º «Cªáµæ¥Õªáµæ­JÅÚ½³");
//                mObj.seteName("Grilled chicken thigh with burdock spicy sauce sauteed shrimp with garlic, mixed vegetables and steamed rice");
//                mObj.setClassType(mClassType);              
////                mObj.setQuantity(10);        
//                mainMeal.add(mObj);
//                mObj = null;
                
                alacart = "The bakery";//ºë¿ïÄÑ¥]¦õ¥¤ªo                              
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¶ð­»°_¤hÄÑ¥]");
                mObj.seteName("French bread with cheese and fresh basil ");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤é¦¡³n¥]");
                mObj.seteName("Japanese soft roll  garlic bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤j»[ÄÑ¥]");
                mObj.seteName("Garlic bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
             mType = "Light bites menu";//    ªÅ¤¤¤pÂI                
                alacart = "ªÅ¤¤¤pÂI";//"¦è¦¡ºë¿ï";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥x¦¡¬õ¿N¤û¦×ÄÑ,ºë¿ï¤pµæ");
                mObj.seteName("Authentic Taiwanese beef noodle soup Assorted side dishes  ");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);   
                mainMeal.add(mObj);
                mObj = null;    
                
             alacart = "Dessert ";//²¢ÂI
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»¨¡°_¤h³J¿|¡@¦õ¯ó²ùÀu®æÂæ");
                mObj.seteName("Mashed sweet taro cheese cake with strawberry yoghurt sauce");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
//                alacart = " ";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen¡VDazs ¦B²N²O");
                mObj.seteName("Haagen¡VDazs");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
             mType = "Light bites menu";//    ªÅ¤¤¤pÂI                
                alacart = "ªÅ¤¤¤pÂI";//"¦è¦¡ºë¿ï";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥x¦×Àê¦Ì­a¥Ø");
                mObj.seteName("Hakka rice noodle with minced pork and shallot");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);   
                mainMeal.add(mObj);
                mObj = null;   
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¾¥¦è­ô¤û¦×°_¤h¬£¶ð");
                mObj.seteName("Mexican style beef and cheese tart ");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(10);   
                mainMeal.add(mObj);
                mObj = null;  
                
             mType = "Breakfast menu";//    ¦­À\µæ³æ                
                alacart = "Western breakfast";//"¦è¦¡ºë¿ï";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("®ÉÂA¤ôªG¡BÀu®æ¡B¥Dµæ(©¬º¿¤õ»L³J¥] ¦õªk¦¡µÔµæ¥¤ªoÂæ  ªá·¦µæ ¬v¨¡ µf­X)¡Bºë¿ïÄÑ¥]¦õ¥¤ªo¤ÎªGÂæ");
                mObj.seteName("Fresh fruits of the season,\n" +
                        "Yogurt,\n" +
                        "Main course(Parma ham omelet with spinach bernaise sauce broccoli potatoes tomato),\n" +
                        "Assorted bread served with butter and jam.");
                mObj.setDetail("¥i¹|(croissant),°sÆC®Û¶êÄÑ¥](Longan bread fermented with red wine ),«p¤ù¦R¥q( white toast)");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);   
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Chinese breakfast";//"¤¤¦¡ºë¿ï";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤pµæºë¿ï(µæ¨j½µªá·Î³J ¥Ê¤l¦×»æ¡B­»³Â¹L¿ß ·sªF¶§¦×ÃP)¡B²Mµ°¡B¤¤¦¡¬üÂI");
                mObj.seteName(
                		"Assorted delicatessen(¡@¡@pan-fried eggs with pickled turnip," +
                        "pork and pickled cucumber patties,vegetable fern with sesame dressing,shredded dry pork),\n" +
                        "Plain congee,\nSteamed bun.");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(10);  
                mainMeal.add(mObj);
                mObj = null;
                
        }    
        
//0064 VIE-TPE        
        if("0064".equals(fltno))
        {
            mType = "Lunch menu";//¤ÈÀ\µæ³æ
                alacart = "Appetizer";//«eµæ
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»­XÂA½¼½L ªQ¤l ©¬º¿´Ë°_¤h µf­X");
                mObj.seteName("Marinated prawns with eggplant salad pine nuts  parmesan  tomato");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                            
                alacart = "Salad";//¨F©Ô
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥Ð¶é¨F©Ô ¦õªk¦¡ªo¾LÂæ");
                mObj.seteName("Garden salad with French dressing");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Main course";//¥Dµæ
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("³a¥Ä¤z¨©¥_Û£ ¦õ¦Ì¶º ¬õÅÚ½³ «C¦¿µæ");
                mObj.seteName("Steamed scallop and mushroom in black bean sauce with rice carrots  pak choy");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¶ø¦a§Q¶Ç²Î­»·Î¤p¤û¦× ¦õ¤Ú¦è§Q¬v¨¡ µf­X ÂfÂc");
                mObj.seteName("Traditional Viennese veal schnitzel with parsley potato tomato  lemon");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»·Î¬KÂû¯Ý ¦õ¬õÀíÄ¨Û£»P¥É¦Ì¿|  Äªµ« µf­X");
                mObj.seteName("Seared chicken breast with mushroom goulash and grilled polenta asparagus  tomato");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Assorted bread served with homemade butter";//ºë¿ïÄÑ¥]¦õ¥¤ªo                              
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¾ñÆV¸q¦¡ÄÑ¥]");
                mObj.seteName("Olive ciabatta ");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥þ³ÁÄÑ¥]");
                mObj.seteName("wholemeal roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("­»»[ÄÑ¥]");
                mObj.seteName("garlic bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                               
                alacart = "Fresh fruits of the season ";//ÂAªG
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ºë¿ï©u¸`ÂAªG");
                mObj.seteName("Fresh fruits of the season");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Dessert ";//²¢ÂI
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥É®Û¥¤ªoÄ«ªG¨÷");
                mObj.seteName("Apple strudel with cinnamon cream ");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;                   
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen¡VDazs ¦B²N²O");
                mObj.seteName("Haagen¡VDazs");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;                

                alacart = "ºë¿ïÂI¤ß ";//²¢ÂI
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("©¬º¿¤õ»L»e¥Ê¤T©úªv »P µf­X°¨¥¾·ç©Ô°_¤h¤T©úªv");
                mObj.seteName("Petit sandwich of prosciutto with honeydew melon and mozzarella cheese with tomato slice");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null; 
                
             mType = "Refreshment";//                  
                alacart = "Western refreshment";//"¦è¦¡«KÀ\";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¥Ð¶é¨F©Ô ¦õ®L«Â¦i°íªGªo¡B¥Dµæ(®üÂA­XÂæ¸q¦¡²Ó«óÄÑ)¡Bºë¿ïÄÑ¥]¦õ¤â¤u¥¤ªo¡Bºë¿ï©u¸`ÂAªG");
                mObj.seteName("Salad:Garden salad with macadamia nut oil,\n" +
                        "Main course(Taglionlini noodles with seafood tomato sauce,black olives  grilled artichoke  asparagus  )\n" +
                        "Assorted bread served with homemade butter\n" +
                        "resh fruits of the season.");
                mObj.setDetail("ªk¦¡ÄÑ¥](Baguette roll),¥É¦ÌÄÑ¥](corn roll )");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(10);   
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Chinese refreshment";//"¤¤¦¡«KÀ\";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("¤pµæºë¿ï(³a¥Ä¦×¥½ »[­]­»¸z  ¬õÅÚ½³ª£¨§¤z ²D©Õªàµæ¨§¥Ö)¡B¥Dµæ(¤¤¦¡¦×¤Y´öÄÑ  ªÅ¤ßµæ ¬õÅÚ½³)¡Bºë¿ï©u¸`ÂAªG");
                mObj.seteName("Assorted delicatessen(minced pork in sweet bean sauce," +
                		"¡@¡@stir fried Chinese sausage with leek, grilled smoked tofu with carrots,¡@¡@" +
                		" marinated celery with beancurd sheet andcarrots),\n" +
                        " Main course(Chinese noodle soup with meatball water spinach  carrots),\n" +
                        " Fresh fruits of the season.");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(10);  
                mainMeal.add(mObj);
                mObj = null;
                
        }    
        
        if(mainMeal.size()<=0)
        {
            mType = "Beverage Order 1";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType("");
            mObj.setName("");
            mObj.seteName("");
            mObj.setClassType("F");              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
            
            mType = "Beverage Order 2";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType("");
            mObj.setName("");
            mObj.seteName("");
            mObj.setClassType("F");              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
            
            mType = "Beverage Order 3";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType("");
            mObj.setName("");
            mObj.seteName("");
            mObj.setClassType("F");              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
            
            mType = "Beverage Order 1";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType("");
            mObj.setName("");
            mObj.seteName("");
            mObj.setClassType("C");              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
            
            mType = "Beverage Order 2";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType("");
            mObj.setName("");
            mObj.seteName("");
            mObj.setClassType("C");              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
            
            mType = "Beverage Order 3";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType("");
            mObj.setName("");
            mObj.seteName("");
            mObj.setClassType("C");              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;            
        }
        

         //return array  
         MenuMealTypeObj[] mArr= new MenuMealTypeObj[mainMeal.size()];
         for(int i=0;i<mainMeal.size();i++){
            mArr[i] = (MenuMealTypeObj) mainMeal.get(i);
         }
         menu.setMenuMarr(mArr);
          
        
    }

    public void saveMenuFbk(SaveMenuFbkRobj[] saveArr){
        StringBuffer sqlsb = null;  
        saveReturn = new SavaCusRObj();
        Statement stmt = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        String sql = null;
        String msg = "";
        boolean chkflag = false;
        ArrayList delAL = new ArrayList();
        String keySql ="";
        int idx = 0;
        int countfbkObj = 0;
        int countdobj = 0;
        int fn = 0;
        String path = "/apsource/csap/projfz/txtin/appLogs/";//"E://";
        FileWriter fw = null;
        String fltd = null;
        String fltno = null;
        String sect = null;
        String user = null;
        try{
            //check ¸ê®Æ.
            for(int i=0;i<saveArr.length;i++){
                SaveMenuFbkRobj fbkObj = (SaveMenuFbkRobj) saveArr[i];
                if ("".equals(fbkObj.getUpdDt())|| "".equals(fbkObj.getUpdUser())){
                    saveReturn.setResultMsg("0");
                    msg += fbkObj.getCardNo()+":§ó·s¤é/¤H,¤£¥i¬°ªÅ";
                    chkflag = false;
                    break;
                }else{
                    chkflag = true;
                }
            }            

            ConnDB cn = new ConnDB();
            cn.setORP3FZUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            
            //connect ORT1 EG            
//              cn.setORT1FZ();
//              Class.forName(cn.getDriver());
//              conn = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());   

            stmt = conn.createStatement();
            //get seqno
            
           //¸ê®Æ¤£¬°ªÅ¤~§RÀÉ&·s¼W
            if(chkflag){
                if(null != saveArr && saveArr.length >0){
                    
                    fltd = saveArr[0].getFltd();
                    fltno = saveArr[0].getFltno();
                    sect = saveArr[0].getSect();
                    user = saveArr[0].getUpdUser();
                    sql = " select series_num from fztmnrelt where fltdt = to_date('"+fltd+"','yyyy/mm/dd') and fltno = '"+fltno+"' and sect = '"+sect+"' " +
                          " and trim(upduser) = '"+user+"' ";
                    rs = stmt.executeQuery(sql); 
                    while (rs.next()) {
                        delAL.add("'"+rs.getString("series_num")+"'");
    //                    System.out.println(rs.getString("seqno"));
                    }       
    
                    conn.setAutoCommit(false);
                    if(null != delAL && delAL.size() > 0){
                        for(int i=0 ;i< delAL.size();i++){
                            if(i != delAL.size()-1){
                                keySql += delAL.get(i)+",";
                            }else{
                                keySql += delAL.get(i);
                            }
                        }
                        //§R²ÓÀÉ
                        sql = "delete from fztmndetl where series_num in ("+keySql+") ";
                        stmt.executeUpdate(sql); 
    //                    System.out.println("Bitreqd:"+stmt.getUpdateCount());
                    }
                    //§R¥DÀÉ
                    sql = " delete from fztmnrelt where fltdt = to_date('"+fltd+"','yyyy/mm/dd') and fltno = '"+fltno+"' and sect = '"+sect+"' " +
                          " and trim(upduser) = '"+user+"' ";
                    stmt.executeUpdate(sql); 
    //                System.out.println("fztmnrelt:"+stmt.getUpdateCount());
                    
                    //·s¼W
                    for(int i=0; i<saveArr.length;i++){          
                        //¨ú¥D¶µ
                        SaveMenuFbkRobj fbkObj = (SaveMenuFbkRobj) saveArr[i];
                        //µLtable key 
                        if(fbkObj.getSeqno()==null || "".equals(fbkObj.getSeqno())){      
                            //¨únext table key
                            sql = "  select Nvl(max(series_num)+1,'1') seqno from fztmnrelt ";
                            rs = stmt.executeQuery(sql);                          
                           
                            if (rs.next()) {
                                fn = rs.getInt("seqno");
                                
                            }                      
//                            System.out.println(fn);
                            
                            
                            //·s¼W¥D¶µ
                            sqlsb = new StringBuffer();
                            sqlsb.append("insert into fztmnrelt (series_num,fltdt,aircd,fltno,sect,classtype," +
                            		"seatno,custlename,custfename,custcname,dfpsno,upduser,upddt)" +                                    
                                    " values (?,to_date(?,'yyyy/mm/dd'),?,?,?,?,?,?,?,?,?,?,to_date(?,'yyyy/mm/dd hh24:mi:ss'))");
                            
                            pstmt = conn.prepareStatement(sqlsb.toString());
                            
                            idx = 0;
                            pstmt.setInt(++idx, fn );
                            pstmt.setString(++idx, fbkObj.getFltd());
                            pstmt.setString(++idx, fbkObj.getaCd());
                            pstmt.setString(++idx, fbkObj.getFltno());
                            pstmt.setString(++idx, fbkObj.getSect());
                            pstmt.setString(++idx, fbkObj.getClassTp());
                            pstmt.setString(++idx, fbkObj.getSeatNo());
                            pstmt.setString(++idx, fbkObj.getLname());
                            pstmt.setString(++idx, fbkObj.getFname());
                            pstmt.setString(++idx, fbkObj.getCname());
                            pstmt.setString(++idx, fbkObj.getCardNo());
                            pstmt.setString(++idx, fbkObj.getUpdUser());
                            pstmt.setString(++idx, fbkObj.getUpdDt());
                            
                            countfbkObj = pstmt.executeUpdate();
    //                        System.out.println(countfbkObj);
                            
                            if(null != fbkObj.getSaveDArr() && fbkObj.getSaveDArr().length > 0 ){                        
                                
                                sqlsb = new StringBuffer();
                                sqlsb.append("insert into fztmndetl (series_num,catalog,type,alacarttype,name,ename,quality,detail) " +
                                        " values (?,?,?,?,?,?,to_number(?),?) ");
                                sqlsb.toString();
                                pstmt = null;
                                pstmt = conn.prepareStatement(sqlsb.toString());
                                
                                for(int j=0 ;j<fbkObj.getSaveDArr().length ;j++){
                                    //¨ú°Æ¶µ
                                    SaveObj dobj = (SaveObj) fbkObj.getSaveDArr()[j];
                                    
                                    idx = 0;
                                    pstmt.setInt(++idx, fn );//saveDetailMVCObj.getTableKey()
                                    pstmt.setString(++idx, dobj.getCatalog());
                                    pstmt.setString(++idx, dobj.getType());
                                    pstmt.setString(++idx, dobj.getAlacarttype());
                                    pstmt.setString(++idx, dobj.getCname());
                                    pstmt.setString(++idx, dobj.getEname());
                                    pstmt.setString(++idx, dobj.getQuantity());
                                    pstmt.setString(++idx, dobj.getDetail());                                
                                    pstmt.addBatch();
                                }//for(int j=0 ;j<saveMvcObj.getDetailAL().length ;j++)
                                
                                pstmt.executeBatch();
                                countdobj = pstmt.getUpdateCount();//.SUCCESS_NO_INFO;
    //                            System.out.println(countdobj);
                                pstmt.clearBatch();
                                
                                saveReturn.setResultMsg("1");
                                msg+="§ó·s§¹¦¨"+countdobj;
                            }else{
                                saveReturn.setResultMsg("1");
                                msg+="¤º®e¬°ªÅ,µL»Ý§ó·s.";
                            }//if(null != saveMvcObj.getDetailAL() && saveMvcObj.getDetailAL().length > 0 ) 
                        }
                        conn.commit();                    
                        saveReturn.setResultMsg("1");
                        msg+="§ó·s¥D¶µ¦¨¥\"+countfbkObj;
                    }//for(int i=0; i<saveAllMVCAL.length;i++)               
                }else{
                    saveReturn.setResultMsg("0");
                    msg+="¥D¶µ¬°ªÅ,µLªk§ó·s.";
                }//if(null != saveAllMVCAL && saveAllMVCAL.length >0)    
            }//if chkfalg
        }catch(Exception e){
            saveReturn.setResultMsg("0");
            msg="§ó·s¥¢±Ñ"+e.toString()+fn;
//            System.out.println(msg+":"+saveCusReturnAL.getErrorMsg());
            try
            {
//                fw = new FileWriter(path+"serviceLog.txt");
                fw = new FileWriter(path+"serviceLog.txt",true);
                fw.write(new java.util.Date() + fltd+","+sect+","+fltno+","+user+", save Meal rpt \r\n");       
                fw.write(msg + " ** Failed \r\n");   
                fw.write(sql+"\r\n");  
                fw.write("****************************************************************\r\n");
                fw.flush();
                fw.close();
                msg="meal order§ó·s¥¢±Ñ"+fn;
            }
            catch (Exception e1)
            {
//                  System.out.println("e1"+e1.toString());
            }
            finally
            {               
            }            
            try{
                conn.rollback();
            }catch(SQLException se){ 
                msg += "rollback exception :"+se.toString();
//                System.out.println("rollback exception :"+se.toString());
            }
            
            //return e.toString();            
        }finally{
            saveReturn.setErrorMsg(msg);
            try{
                if (rs != null)
                    rs.close();
            }
            catch ( SQLException e ){
            }
            try{
                if (stmt != null)
                    stmt.close();
            }
            catch ( SQLException e ){
            }
            try{
                if (pstmt != null){
                    pstmt.close();
                }
            }
            catch ( SQLException e ){
            }
            try{
                if (conn != null){
                    conn.close();
                }
            }
            catch ( SQLException e ){
            }
        } 
        
    }

    public SavaCusRObj getSaveReturn()
    {
        return saveReturn;
    }

    public void setSaveReturn(SavaCusRObj saveReturn)
    {
        this.saveReturn = saveReturn;
    }
    
}

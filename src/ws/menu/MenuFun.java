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
//  0004/0003�Y����
//  0006/0005/0008/0007  ���ذӰȿ�
//  0061/0062/0063/0064/0032/0031/0051(TPE/SYD)/0052(SYD/TPE) �Ӱȿ�
    
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
        
        //����
        MenuDrinkObj dObj = null;
        dClassType="F";  
        /***F��***/
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
            dObj.setDetail("�k��-Pol Roger�D2000/France-Pol Roger 2000");
            drink.add(dObj);
            dObj = null;
            
            //�հs
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("�հs/White Wine");
            dObj.setDetail("�k��-�L���Q�D�L�h��:2009/Chablis Chardonnay 2009,�w��-�p��e���D�R���¡D2012/Germany-Mosel Valley Riesling 2012");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;   
            
            //���s            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("���s/Red Wine");
            dObj.setDetail("�k��V�t���Q�w�ϡD�԰��ڹy 1997:Saint-Julien/France-Chateau Langoa Barton 1997,�D�w�V��ù�F�e���D�ƫ��D2009/Australia-Barossa Valley Shiraz 2009,����-�ǩ��e���D����  2009/U.S.A.-Napa Valley Merlot Reserve 2009");
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
        /***C��***/
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
            dObj.setDetail("�k�� GREMILLET���b/France Champagne Gremillet");
            drink.add(dObj);
            dObj = null;
            
            //�հs
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("�հs/White Wine");
            dObj.setDetail("�k�� �V�L���Q�@�Ÿ���� �L�h�� 2010/France-Chablis 1er Cru Chardonnay 2010,�w�� -�p��e���D�R���¡D2012/Germany-Mosel Valley Riesling 2012");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;   
            
            //���s            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("���s/Red Wine");
            dObj.setDetail("�k��D�԰����D2006/France-Chateau La Gorce 2006,�q�j�Q - �_���Ĭ��áA2011/Italy-Chianti Riserva DOCG 2011,����D�ǩ��e���D���� 2009/U.S.A.-Napa Valley Merlot Reserve 2009");
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
        //�\�I
        MenuMealTypeObj mObj = null;
        
        mClassType="F";  
        /***F��***/
        
        
//        if(sect.substring(0,3).equals("TPE"))
//        {
//        if(sect.substring(0,3).equals("TPE"))
        if("0004".equals(fltno) || "0008".equals(fltno) )
        {
            mType = "Late night supper";//�d�]�K�\
                alacart = "Appetizer";//�e��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�������x�B�~�G�A�z���B����v�����F��");
                mObj.seteName("Chinese deluxe cold plateSpicy beef tendon, mango with scallop, onion mixed celery salad");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�s��������X�B�ͥʡB�����F�Ժ���");
                mObj.seteName("Lobster jelly with dried tomato, zucchini, and fennel salad and orange skin");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                alacart = "Soup";//���~
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���A�n�ʴ�");
                mObj.seteName("Pumpkin stock with seafood");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("��ۣ�M���󽼦i��");
                mObj.seteName("Wild mushroom consomme with chive");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Main course";//�D��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�Q�O��ۣ���B���W�T����ߤl�C���λ����C���ߦ����⽭��");
                mObj.setDetail("���]�̶�(steamed rice),�Q�B�̶�(healthy multi grains rice)");
                mObj.seteName("Pork with shimeji mushroom roll Chicken rolls stuffed with chestnut and scallop with " +
                		"vegetables sauce, stuffed shrimp paste in chili Five-color vegetables, steamed rice");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                             
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�N�������ơB�Q�S��B�t�v��");
//                mObj.setDetail("���ƿ��X���o���(pesto-tomato cream sauce),�i�S�s���(port wine sauce)");
                mObj.seteName("Roasted beef tenderloin with truffle sauce and smoked onion");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                              
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�������� �V���ΰ��ڦϱ�/�z���D�������n�ʡB�f�X�B�C���B���T�Υ��o�C��");
//                mObj.setDetail("���ƿ��X���o���(pesto-tomato cream sauce),�i�S�s���(port wine sauce)");
                mObj.seteName("SURF AND TURF - pan fried lamb wrapped with bacon/ salmon with scallop roll pumpkin, tomato, broccoli, " +
                		"taromash potato, creamy pesto sauce");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "The bakery";//����ѥ]
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�P���Q�ѥ]");
                mObj.seteName("French rye baguette");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�³���s�]");
                mObj.seteName("Dark rye beer bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�@�خ֮�]");
                mObj.seteName("Coffee walnut bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�馡�n�ѥ]");
                mObj.seteName("Soft roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���[�ѥ]");
                mObj.seteName("Garlic bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Sweet finale";//���e�������
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�ɥO���G");
                mObj.seteName("Fresh fruits of the season");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���_�q�L");
                mObj.seteName("Selection of cheese");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�۪������");
                mObj.seteName("Jelly red bean and osmanthus");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�¥��J�O�P�J�}�J�|");
                mObj.seteName("Black Chocolate and Caramel");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen�VDazs �B�N�O");
                mObj.seteName("Haagen�VDazs ice cream");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
             mType = "Light bites menu";//����
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("���N�x�W������ (�i�ɥΧֳt��o���I)");
                mObj.seteName("Authentic Taiwanese beef noodle soup ( Fast and delicate of Taiwan delight)");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("���ʦ̯�");
                mObj.seteName("Fried rice noodle with pumpkin");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("�ڽ��ư��p��");
                mObj.seteName("Turnips with pork ribs soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("�[�]�D����");
                mObj.seteName("Salmon and leek pie");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("�����Y����");
                mObj.seteName("Vegetarian instant noodle");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("���_�q�L");
                mObj.seteName("Cheese platter");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("���G��");
                mObj.seteName("Mixed nuts");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
             mType = "Breakfast menu";//    ���\���
                mObj = new MenuMealTypeObj();
                alacart = "dirnk";
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�h���");
                mObj.seteName("Orange");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ī�G��");
                mObj.seteName("Apple");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                         
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�f�X��");
                mObj.seteName("Tomato");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                              
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�Τ@����");
                mObj.seteName("Soy bean milk");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "others";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�ɥO���G");
                mObj.seteName("FRESH FRUITS OF THE SEASON");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�B���ܤ�");
                mObj.seteName("Cereals are also available upon your choice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;                
         
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�u��");
                mObj.seteName("Yogurt ");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;    
                

                alacart="����ѥ]�����o�ΪG��";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�s�C�۶��ѥ]");
                mObj.seteName("Longan bread mixed with red wine");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�i�|�ѥ]");
                mObj.seteName("Croissant");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                             
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("��������ѥ]");
                mObj.seteName("Pineapple danish");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�p���զR�q");
                mObj.seteName("Toast");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                
                alacart="Main course";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�t�D�[�_�h�J�]���p���׸z�B�۳�����B�͵�F�԰tī�G�o�L");
                mObj.seteName("Smoked salmon and garlic boursin cheese omelet " +
                		"veal sausage, sesame potato cake, mixed salad with cider vinaigrette");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�k�����ڬv���Ь����Ե�B�f�X�BĨۣ�B���׸z�η����}���P��");
                mObj.seteName("Quiche Lorraine spinach, tomato, mushroom, chicken sausage, waffle with maple syrup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���F�A���Bxo���B�ŻȪ������B�Ե��Aۣ�զ�,�S����P�B�����C�Y�B�ڽ�����B�Ψ��Y�|");
                mObj.setDetail("�M��(Plain congee),���T��(chicken congee with yam and mushroom)");
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
            mType = "Dinner menu";//���\
            alacart = "Appetizer";//�e��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�������x�B�~�G�A�z���B����v�����F��");
                mObj.seteName("Chinese deluxe cold plate, Spicy beef tendon, mango with " +
                		"scallop, onion mixed celery salad");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
        
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�s��������X�B�ͥʡB�����F�Ժ���");
                mObj.seteName("Lobster jelly with dried tomato, zucchini, and fennel salad and orange skin");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
        
                alacart = "Soup";//���~
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���A�n�ʴ�");
                mObj.seteName("Pumpkin stock with seafood");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("��ۣ�M���󽼦i��");
                mObj.seteName("Wild mushroom consomme with chive");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Salad";//�F��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("��o�F�Ԧ����t��");
                mObj.setDetail("�S�ž��V�o(extra virgin olive oil),�q�j�Q���~����L(balsamic vinegar),�����۳���(sesame plum dressing)");
                mObj.seteName("Garden salad served with selected condiments");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Main course";//�D��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�Q�O��ۣ���B���W�T����ߤl�C���λ����C���ߦ����⽭��");
                mObj.setDetail("���]�̶�(steamed rice),�Q�B�̶�(healthy multi grains rice)");
                mObj.seteName("Pork with shimeji mushroom roll Chicken rolls stuffed with chestnut and scallop with" +
                		       " vegetables sauce, stuffed shrimp paste in chili Five-color vegetables, steamed rice");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                           
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�N�������ơB�Q�S��B�t�v��");
//                mObj.setDetail("���ƿ��X���o���(pesto-tomato cream sauce),�i�S�s���(port wine sauce)");
                mObj.seteName("Roasted beef tenderloin with truffle sauce and smoked onion");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                                          
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�������� �V���ΰ��ڦϱ�/�z���D�������n�ʡB�f�X�B�C���B���T�Υ��o�C��");
//                mObj.setDetail("���ƿ��X���o���(pesto-tomato cream sauce),�i�S�s���(port wine sauce)");
                mObj.seteName("SURF AND TURF - pan fried lamb wrapped with bacon/salmon with " +
                		"scallop roll pumpkin, tomato, broccoli, taromash potato, creamy pesto sauce");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                        
                alacart = "The bakery";//����ѥ]
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�P���Q�ѥ]");
                mObj.seteName("Hoshino salty bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�³���s�]");
                mObj.seteName("Dark rye beer bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�@�خ֮�]");
                mObj.seteName("Coffee walnut bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�馡�n�ѥ]");
                mObj.seteName("Soft roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���[�ѥ]");
                mObj.seteName("Garlic bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Sweet finale";//���e�������
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�ɥO���G");
                mObj.seteName("Fresh fruits of the season");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���_�q�L");
                mObj.seteName("Selection of cheese");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�۪������");
                mObj.seteName("Jelly red bean and osmanthus");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�¥��J�O�P�J�}�J�|");
                mObj.seteName("Black Chocolate and Caramel");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen�VDazs �B�N�O");
                mObj.seteName("Haagen�VDazs ice cream");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;                
                       
             mType = "Light bites menu";//����
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("���N�x�W������ (�i�ɥΧֳt��o���I)");
                mObj.seteName("Authentic Taiwanese beef noodle soup ( Fast and delicate of Taiwan delight)");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("���ʦ̯�");
                mObj.seteName("Fried rice noodle with pumpkin");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("�ڽ��ư��p��");
                mObj.seteName("Turnips with pork ribs soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("�[�]�D����");
                mObj.seteName("Salmon and leek pie");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("�����Y����");
                mObj.seteName("Vegetarian instant noodle");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("���_�q�L");
                mObj.seteName("Cheese platter");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("���G��");
                mObj.seteName("Mixed nuts");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
            mType = "Breakfast menu";//    ���\���
                mObj = new MenuMealTypeObj();
                alacart = "dirnk";
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�h���");
                mObj.seteName("Orange juice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
            
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ī�G��");
                mObj.seteName("Apple juice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                     
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�f�X��");
                mObj.seteName("Tomato juice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                          
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�Τ@����");
                mObj.seteName("Soy bean milk");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
            
                alacart = "others";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�ɥO���G");
                mObj.seteName("FRESH FRUITS OF THE SEASON");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�B���ܤ�");
                mObj.seteName("Cereals are also available upon your choice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);       
                mainMeal.add(mObj);
                mObj = null;                
         
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�u��");
                mObj.seteName("Yogurt");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;                    
    
                alacart="����ѥ]�����o�ΪG��";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�s�C�۶��ѥ]");
                mObj.seteName("Longan bread mixed with red wine");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�i�|�ѥ]");
                mObj.seteName("Croissant");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                             
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("��������ѥ]");
                mObj.seteName("Pineapple danish");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�p���զR�q");
                mObj.seteName("Toast");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                
                alacart="Main course";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�t�D�[�_�h�J�]���p���׸z�B�۳�����B�͵�F�԰tī�G�o�L");
                mObj.seteName("Smoked salmon and garlic boursin cheese omelet " +
                		"veal sausage, sesame potato cake, mixed salad with cider vinaigrette");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�k�����ڬv���Ь����Ե�B�f�X�BĨۣ�B���׸z�η����}���P��");
                mObj.seteName("Quiche Lorraine spinach, tomato, mushroom, chicken sausage, waffle with maple syrup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���F�A���Bxo����šB�Ȫ������B�Ե��Aۣ�զ�,�S����P�B������u�C�Y�B�ڽ�����B�Ψ��Y�|");
                mObj.setDetail("�M��(Plain congee),���T��(chicken congee with yam and mushroom)");
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
            mType = "Late night supper";//�d�]�K�\
                alacart = "Appetizer";//�e��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�j���B�����סB�ɸ}��");
                mObj.seteName("Abalone sliced, marinated soya chicken, crab claw");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�ɦ׶���T���εf�X�BĪ���F��");
                mObj.seteName("Crab meat tartare with avocado, tomato, asparagus,micro greens");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                alacart = "Soup";//���~
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�ư���ͽ��´�");
                mObj.seteName("Braised lotus root with peanuts and pork rib soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���ڽ���������t�����R");
                mObj.seteName("Carrot and parsnip soup with turnip chips");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Main course";//�D��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�­J�Ԥ��J�� �B�����z�s���������ε��]�̶�");
                mObj.seteName("Wok fried beef short ribs in black pepper sauce Wok fried lobster with ginger onion sauce kai lan, steamed rice");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�L�Ͻ�����X�ɽ��εf����̶�");
                mObj.seteName("Braised lamb shank assorted seasonal vegetables, saffron rice");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�����t�����`�ʡB���ڽ��B�����f�X�_�D�p�̤ή��ڵܩi�����");
                mObj.seteName("Seared sea bass zucchini, carrot, sun-dried tomato with couscous, " +
                		"dill and lime cream sauce");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "The bakery";//����ѥ]                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�q����c�ѥ]");
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
                mObj.setName("���V�ѥ]");
                mObj.seteName("Olive roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�g�����ѥ]");
                mObj.seteName("Rosemary roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���[�ѥ]");
                mObj.seteName("Garlic bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Dessert ";//���I
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�u�`�A�G");
                mObj.seteName("Fresh fruits of the season");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���_�q�L");
                mObj.seteName("Cheese selections");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�Ȧշ����ɦ��S ");
//                mObj.setDetail("�ż� (warm),�N��(cold)");
                mObj.seteName("White fungus, sweet corn with coconut milk sweet soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�@�ؼ}�����Ь֤l��");
                mObj.seteName("Coffee mousse with raspberry jam");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen�VDazs �B�N�O");
                mObj.seteName("Haagen�VDazs ice cream");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
             mType = "Light bites menu";//����
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("��o���N������");
                mObj.seteName("Authentic Taiwanese beef noodle soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("�@�~���A����");
                mObj.seteName("Imperial seafood noodle soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("���ڵԵ��Ь�");
                mObj.seteName("Bacon and spinach quiche");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("�����Y����");
                mObj.seteName("Vegetarian instant noodle");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("���s�_�q�L");
                mObj.seteName("Cheese platter");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("���G��");
                mObj.seteName("Mixed nuts");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
             mType = "Breakfast menu";//    ���\���
                mObj = new MenuMealTypeObj();
                alacart = "dirnk";
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�h���");
                mObj.seteName("Orange juice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);   
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ī�G��");
                mObj.seteName("Apple juice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                         
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�f�X��");
                mObj.seteName("Tomato juice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);    
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "others";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�ɥO���G");
                mObj.seteName("Fresh fruits of the season");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);  
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�B���ܤ�");
                mObj.seteName("Cereals");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);  
                mainMeal.add(mObj);
                mObj = null;                
         
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�u�T��");
                mObj.seteName("Drinking yogurt");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);      
                mainMeal.add(mObj);
                mObj = null;    
                
    
                alacart="����ѥ]�����o�ΪG��";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�i�|�ѥ]");
                mObj.seteName("Croissant");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�P������");
                mObj.seteName("Oatmeal muffin");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                             
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("������G�J�|");
                mObj.seteName("Banana nut cake");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�p���R�q");
                mObj.seteName("Thick white toast");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                
                alacart="Main course";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�ѥ]���B�������έ�����");
                mObj.seteName("Nutella bread pudding mixed berries, vanilla sauce");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�覡�m�Եf�X�J�ճJ�]��Ī���B�f�X�B�[���j���L�B�v����αm�Եf�X���");
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
                mObj.setName("�M��--  �����ץ��γJ�B���ણ�����B�D�դs�ġB���m�����B�����P�B�����p����C�Y�B�e�N�p�B�t�Ʀ��h�����Ѯȫȿ��");
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
            mType = "Dinner menu";//���\
                alacart = "Appetizer";//�e��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�j���B�����סB�ɸ}��");
                mObj.seteName("Abalone sliced, marinated soya chicken, crab claw");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�ɦ׶���T���εf�X�BĪ���F��");
                mObj.seteName("Crab meat tartare with avocado, tomato, asparagus,micro greens");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                alacart = "Soup";//���~
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�ư���ͽ��´�");
                mObj.seteName("Braised lotus root with peanuts and pork rib soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���ڽ���������t�����R");
                mObj.seteName("Carrot and parsnip soup with turnip chips");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Salad";//�F��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("��o�F�Ԧ����t�ƥi�f�t:");
                mObj.setDetail("�S���f�c���V�o(virgin olive oil),����s�L(virgin olive oil),�d�q��(sesame plum dressing)");
                mObj.seteName("Assorted salad served with selected condiments.");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);  
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Main course";//�D��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�­J�Ԥ��J�� �B�����z�s���������ε��]�̶�");
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
                mObj.setName("�L�Ͻ�����X�ɽ��εf����̶�");
                mObj.seteName("Braised lamb shank assorted seasonal vegetables, saffron rice");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�����t�����`�ʡB���ڽ��B�����f�X�_�D�p�̤ή��ڵܩi�����");
                mObj.seteName("Seared sea bass zucchini, carrot, sun-dried tomato with couscous, " +
                		"dill and lime cream sauce");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "The bakery";//����ѥ]                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�q����c�ѥ]");
                mObj.seteName("Ciabatta bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�Ⱳ�ѥ]");
                mObj.seteName("Twist roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���V�ѥ]");
                mObj.seteName("Olive roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�g�����ѥ]");
                mObj.seteName("Rosemary roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���[�ѥ]");
                mObj.seteName("Garlic bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Dessert ";//���I
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�u�`�A�G");
                mObj.seteName("Fresh fruits of the season");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���_�q�L");
                mObj.seteName("Cheese selections");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�Ȧշ����ɦ��S");
//                mObj.setDetail("�ż� (warm),�N��(cold)");
                mObj.seteName("White fungus, sweet corn with coconut milk sweet soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                        
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�@�ؼ}�����Ь֤l��");
                mObj.seteName("Coffee mousse with raspberry jam");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen�VDazs �B�N�O");
                mObj.seteName("Haagen�VDazs ice cream");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
             mType = "Light bites menu";//����
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("��o���N������");
                mObj.seteName("Authentic Taiwanese beef noodle soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("�@�~���A����");
                mObj.seteName("Imperial seafood noodle soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("���ڵԵ��Ь�");
                mObj.seteName("Bacon and spinach quiche");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("�����Y����");
                mObj.seteName("Vegetarian instant noodle");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("���s�_�q�L");
                mObj.seteName("Cheese platter");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("���G��");
                mObj.seteName("Mixed nuts");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
             mType = "Breakfast menu";//    ���\���
                mObj = new MenuMealTypeObj();
                alacart = "dirnk";
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�h���");
                mObj.seteName("Orange juice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);     
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ī�G��");
                mObj.seteName("Apple juice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);     
                mainMeal.add(mObj);
                mObj = null;
                         
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�f�X��");
                mObj.seteName("Tomato juice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);    
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "others";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�ɥO���G");
                mObj.seteName("Fresh fruits of the season");
                mObj.setClassType(mClassType);              
    //          mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�B���ܤ�");
                mObj.seteName("Cereals");
                mObj.setClassType(mClassType);              
    //          mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;                
         
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�u�T��");
                mObj.seteName("Drinking yogurt");
                mObj.setClassType(mClassType);              
    //          mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;    
                
    
                alacart="����ѥ]�����o�ΪG��";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�i�|�ѥ]");
                mObj.seteName("Croissant");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�P������");
                mObj.seteName("Oatmeal muffin");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                             
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("������G�J�|");
                mObj.seteName("Banana nut cake");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�p���R�q");
                mObj.seteName("Thick white toast");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                
                alacart="Main course";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�ѥ]���B�������έ�����");
                mObj.seteName("Nutella bread pudding mixed berries, vanilla sauce");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�覡�m�Եf�X�J�ճJ�]��Ī���B�f�X�B�[���j���L�B�v����αm�Եf�X���");
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
                mObj.setName("�M��--  �����ץ��γJ�B���ણ�����B�D�դs�ġB���m�����B�����P�B�����p����C�Y�B�e�N�p�B �t�Ʀ��h�����Ѯȫȿ��");
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
        /***C��***/
        if("TPEFRA".equals(sect) 
//              ||"0004".equals(fltno.substring(0,4)) || "0008".equals(fltno.substring(0,4))
//              ||"0006".equals(fltno.substring(0,4)) || "0003".equals(fltno.substring(0,4))
//              ||"0005".equals(fltno.substring(0,4)) || "0007".equals(fltno.substring(0,4))
                )
        {
            mType = "Late night supper";//�d�]�K�\
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("�F��");
                mObj.setName("�K�ѦʶרF�Ԧ��~�G�u����");
                mObj.seteName("Mixed green salad with mango yogurt dressing");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;            
                
                alacart = "�D��";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�د�Ť�����W�b-�x�����ư��Ѧ����p��");
                mObj.seteName("Taiwanese signature dish �V Taiwanese style deep fried pork chop noodle soup " +
                        "with assorted side dishes");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�Q�S���O���v��");
                mObj.seteName("Pan fried beef tenderloin with truffle sauce and potatoes with parsley");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�үN���L���i�S�s��Ĥθq������");
                mObj.seteName("Grilled chicken thigh with port wine sauce and orzo pasta");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "����ѥ]����u���o";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�P���Q�ѥ]");
                mObj.seteName("Hoshino salty bread");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�馡�n�ѥ]");
                mObj.seteName("soft roll");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���[�ѥ]");
                mObj.seteName("Garlic bread");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;         
                                
                alacart = "��ﲢ�I��";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("��ﲢ�I��(�N���}���B)");
                mObj.seteName("Dessert(Brown sugar pudding)");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
            mType ="Light bites menu";
            alacart = "�Ť��p�I";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�ǲξ|�׶�");
                mObj.seteName("Traditional braised minced pork with braised tofu, soy egg," +
                		"yellow pickle, steamed rice");
                mObj.setClassType(mClassType);              
    //          mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�[�]�D����");
                mObj.seteName("Salmon and leek pie");
                mObj.setClassType(mClassType);              
    //          mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
            mType = "Breakfast menu";//���\
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("Western breakfast");
                mObj.setName("���A���G\n" +
                        "�u��\n  " +
                        "�k�������K�J:�����׸z�BĨۣ�B�Ե�άv�����ڪ��v��\n" +
                        "�s�C�۶��ѥ]�B�i�|�ѥ]�B�p���R�q");
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
                mObj.setName("�Τ@����\n" +
                        "�M��-���F�A���BXO����šB�Ȫީ������B�����P�B�гJ�B�ڽ�����");
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
            mType = "Lunch menu";//���\
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("�e��");
                mObj.setName("�ڦ����A�f�X��");
                mObj.seteName("Marinated seafood stuffed in tomato cup");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                alacart = "�F��";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�ж�F�Ԧ��q���o�L��");
                mObj.seteName("Garden salad with Italian dressing");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                alacart = "�D��";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�������[���h���̶��ν���");
                mObj.seteName("Fried red snapper in hot garlic sauce with steamed rice and oriental vegetables");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���s�ޱƦ��v���d���A��");
                mObj.seteName("Seared pork in red wine sauce with mashed potato, broccoli and red pepper stripes");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���Τz����ī���Ʀ��v���ά��ڽ�");
                mObj.seteName("Roasted chicken breast in calvados sauce with fried potato, French bean and baby carrot");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "����ѥ]����u���o";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���ѥ]");
                mObj.seteName("Sourdough roll");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;

                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�k���ѥ]");
                mObj.seteName("baguette roll");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���[�ѥ]");
                mObj.seteName("garlic bread");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "���A���G";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���A���G");
                mObj.seteName("Freshe fruits of the season");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "���I";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���J�O�_�h�J�|���Ь֤l��");
                mObj.seteName("Chocolate cheese cake with raspberry coulis");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
            mType = "Refreshment";//�K�\
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("Western refreshment");
                mObj.setName("�ж�F�Ԧ��o�L��\n" +
                        "����N�J�����������h\n" +
                        "�³��ѥ]�B���Q�ѥ] \n" +
                        "���u�`�A�G");
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
                mObj.setName("���ڪ�����B�����z���z \n" +
                        "�Vۣ�e�N����\n" +
                        "���u�`�A�G");
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
        
        //����
        MenuDrinkObj dObj = null;
        dClassType="F";  
        /***F��***/
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
            dObj.setDetail("�k��-Pol Roger�D2000/France-Pol Roger 2000");
            drink.add(dObj);
            dObj = null;
            
            //�հs
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("�հs/White Wine");
            dObj.setDetail("�k��-�L���Q�D�L�h��:2009/Chablis Chardonnay 2009,�w��-�p��e���D�R���¡D2012/Germany-Mosel Valley Riesling 2012");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;   
            
            //���s            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("���s/Red Wine");
            dObj.setDetail("�k��V�t���Q�w�ϡD�԰��ڹy 1997:Saint-Julien/France-Chateau Langoa Barton 1997,�D�w�V��ù�F�e���D�ƫ��D2009/Australia-Barossa Valley Shiraz 2009,����-�ǩ��e���D����  2009/U.S.A.-Napa Valley Merlot Reserve 2009");
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
        /***C��***/
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
            dObj.setDetail("�k�� GREMILLET���b/France Champagne Gremillet");
            drink.add(dObj);
            dObj = null;
            
            //�հs
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("�հs/White Wine");
            dObj.setDetail("�k�� �V�L���Q�@�Ÿ���� �L�h�� 2010/France-Chablis 1er Cru Chardonnay 2010,�w�� -�p��e���D�R���¡D2012/Germany-Mosel Valley Riesling 2012");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;   
            
            //���s            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("���s/Red Wine");
            dObj.setDetail("�k��D�԰����D2006/France-Chateau La Gorce 2006,�q�j�Q - �_���Ĭ��áA2011/Italy-Chianti Riserva DOCG 2011,����D�ǩ��e���D���� 2009/U.S.A.-Napa Valley Merlot Reserve 2009");
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
        //�\�I
        MenuMealTypeObj mObj = null;        
            
        if("0004".equals(fltno))
        {
            mClassType="F";  
            /***F��***/   
            mType = "Late night supper";//�d�]�K�\
                alacart = "Appetizer";//�e��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�Q���l�N�L");
                mObj.seteName("Roasted karasumi");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�n�x�����L��G�����λe�{���G");
                mObj.seteName("Duck liver pate with fig jelly and confit fruits");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                alacart = "Soup";//���~
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�����ȦտL����");
                mObj.seteName("Stewed pear and white fungus chicken soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�q�����L�f�X�C�[��");
                mObj.seteName("Cream soup of vine tomatoes and spring leek with aged balsamic vinegar");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
//                alacart = "Salad";//�F��
//                mObj = new MenuMealTypeObj();
//                mObj.setMealType(mType);
//                mObj.setAlacartType(alacart);
//                mObj.setName("��o�F�Ԧ����t��");
//                mObj.setDetail("�S�ž��V�o(extra virgin olive oil),�q�j�Q���~����L(balsamic vinegar),�����۳���(sesame plum dressing)");
//                mObj.seteName("Garden salad served with selected condiments");
//                mObj.setClassType(mClassType);              
//    //            mObj.setQuantity(5);        
//                mainMeal.add(mObj);
//                mObj = null;
                
                alacart = "Main course";//�D��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�O�ߥժG�N�סB���p�����B���L��������Υն�");
                mObj.setDetail("�Q�B�̶�(healthy multi grains rice)");
                mObj.seteName("Stewed chestnut ginkgo nut pork bell, steamed cod fish with pan-fried crisp bean Stir fried ham cabbage and steamed rice");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                             
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���ή��t����O���A��פή��a���");
//                mObj.setDetail("���ƿ��X���o���(pesto-tomato cream sauce),�i�S�s���(port wine sauce)");
                mObj.seteName("Sea bass filet with clam and seaweed sauce");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                              
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�Ϩ{�����L���B�q����ɽ��B�Q�S��e��");
//                mObj.setDetail("���ƿ��X���o���(pesto-tomato cream sauce),�i�S�s���(port wine sauce)");
                mObj.seteName("Pan-fried morel stuffed chicken thigh with port balsamic sauce Ratatouille and fettuccine with truffle oil");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "The bakery";//����ѥ]
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�P���Q�ѥ]");
                mObj.seteName("Hoshino salty bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("����l�ѥ]");
                mObj.seteName("Sunflower seed roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���Q�_�h�ѥ]");
                mObj.seteName("Rock salt and cheese bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�馡�n�ѥ]");
                mObj.seteName("Italian style spice bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���[�ѥ]");
                mObj.seteName("Garlic bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Sweet finale";//���e�������
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�ɥO���G");
                mObj.seteName("Seasonal fresh fruit");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���_�q�L");
                mObj.seteName("Selection of cheese");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���ܿL�����S");
                mObj.seteName("Stewed kumquat and pear soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���J�O�J�}�q���Ʀ��ʭ��G���o�Ωٯ�����");
                mObj.seteName("Chocolate fudge with spices, passion fruit cream and matcha almonds");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen�VDazs �B�N�O");
                mObj.seteName("Haagen�VDazs ice cream");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
             mType = "Light bites menu";//����
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("���N�x�W������ (�i�ɥΧֳt��o���I)");
                mObj.seteName("Authentic Taiwanese beef noodle soup (Beef is originated from Taiwan)");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("�W���o�ѽu");
                mObj.seteName("White angel hair noodles with camellia oil");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("�s�ĿL�Q�״�");
                mObj.seteName("Stewed Chinese yam with pork jowl meat");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("��ۣ���׶p");
                mObj.seteName("Fresh mushrooms beef puff (Beef is originated from New Zealand)");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("�����Y����");
                mObj.seteName("Vegetarian instant noodle");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("���_�q�L");
                mObj.seteName("Cheese platter");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("���G��");
                mObj.seteName("Mixed nuts");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
             mType = "Breakfast menu";//    ���\���
                mObj = new MenuMealTypeObj();
                alacart = "dirnk";
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�h���");
                mObj.seteName("Orange");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ī�G��");
                mObj.seteName("Apple");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                         
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�f�X��");
                mObj.seteName("Tomato");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                              
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�Τ@����");
                mObj.seteName("Soy bean milk");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "others";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�ɥO���G");
                mObj.seteName("Fresh fruits of the season");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�B���ܤ�");
                mObj.seteName("Cereals");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;                
         
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�u��");
                mObj.seteName("Yogurt ");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;    
                

                alacart="����ѥ]�����o�ΪG��";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�s�C�۶��ѥ]");
                mObj.seteName("Longan bread mixed with red wine");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�i�|�ѥ]");
                mObj.seteName("Chocolate bread with dried orange peel");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                             
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("��֥i�i��");
                mObj.seteName("Danish with rum raisin");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�p���զR�q");
                mObj.seteName("White Toast");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                
                alacart="Main course";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�����_�h�K�J�B�ަ׸z�B�����Ƭv��");
                mObj.seteName("Parma ham and cheese in baked egg, pork sausage, sauteed potatoes with herbs");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�[�_�h�t�D���n�ʯM�J�B���׸z�B���i���v��");
                mObj.seteName("Smoked salmon and boursin cheese on pumpkin omelette, chicken sausage,boiled new potatoes with chive");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���ժ��A���B�ץ��|�u���B��Ĩ��G�X�B�D�ն�����,�гJ�B������u�C�Y�B������u�C�Y");
                mObj.setDetail("�M��(Plain congee),�p�̵�(millet porridge)");
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
            /***C��***/   
            mType = "Dinner menu";//���\
//            
                alacart = "Appetizer,Salad,Soup";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�e��-�t�D���� �c�l��\n" +
                        "�F��-��X�F�Ԧ��M���۳���\n" +
                        "���~-�s�Ĭe���ư���");
                mObj.seteName("Smoked salmon rose and pomelo lemon jelly\n" +
                        "Mixed green saladwith sesame mayonnaise\n"+
                        "Pork rib with yam and wolfberry soup\n");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(40);        
                mainMeal.add(mObj);
                mObj = null;  
                alacart = "Main course";//�D��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�y���T�P���N�l��\n �u�`�A�� �ն�");
                mObj.seteName("Braised pork ribs with Yi-Lanspring onion\n" +
                        "Stir-fried vegetables and steamedrice");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                           
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�����t����O\n�u�`�A�� ���v��\n��ĲH��հs��");
//                mObj.setDetail("���ƿ��X���o���(pesto-tomato cream sauce),�i�S�s���(port wine sauce)");
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
                mObj.setName("�Ϩ{�����L��\n�q����ɽ� �Q�S��e��");
//                mObj.setDetail("���ƿ��X���o���(pesto-tomato cream sauce),�i�S�s���(port wine sauce)");
                mObj.seteName("Pan-fried morel stuffed chicken thigh with port balsamic sauce\n" +
                        "Ratatouille andfettuccine witht ruffle oil");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                        
                alacart = "Assorted bread selection";//�ѥ]
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�P���Q�ѥ]");
                mObj.seteName("Hoshino salty bread");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�馡�n�]");
                mObj.seteName("Japanese soft roll");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(40);        
                mainMeal.add(mObj);
                mObj = null;

                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���[�ѥ]");
                mObj.seteName("Garlic bread");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;                
                
                alacart = "Sweet finale";//���e�������
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�u�`���G");
                mObj.seteName("fresh fruits of the season");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(40);  
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�_�h�L");
                mObj.seteName("Cheese platter");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(40);       
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���J�O�J�}�q���Ʀ��ʭ��G���o�Ωٯ�����");
                mObj.seteName("Chocolate Fudge with OrientalSpices, Passion Fruit Cream andMatcha Almonds");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(40);         
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen�VDazs �B�N�O");
                mObj.seteName("Haagen�VDazs ice cream");
                mObj.setClassType(mClassType);    
                mObj.setDetail("����,���");
                mObj.setQuantity(40);        
                mainMeal.add(mObj);
                mObj = null;                
                       
             mType = "Gourmet savory";
                alacart = "����I��";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("���׶�");
                mObj.seteName("Traditional Taiwan bolognaise meat sauce Served with soy sauce-braised egg, takuwan, steamed rice");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("��ۣ���׶p(���רӷ��G �æ���)");
                mObj.seteName("Fresh mushrooms beef puff");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
               
            mType = "Breakfast menu";//���\���Breakfast menu
                alacart = "Breakfast";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�覡-\n" +
                        "���A���G �u��\n" +
                        "�D��-�t�D�Ե�k���J��\nĨۣ ���X �ᷦ��");
                mObj.setDetail("�s�C�۶��ѥ](Longan bread mixed with red wine),�i�|(Croissant),�զR�q(White toast)");
                mObj.seteName("Fresh fruits of the season, Yogurt\n" +
                        "Main course-\nSmoked salmon spinach scrambled eggs crepe\n" +
                        "Button mushroom, tomato, broccoli");
                mObj.setClassType(mClassType);             
                mObj.setDetail("���b��w����");
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
//                alacart = "Chinese breakfast";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("����-\n" +
                        "�Τ@����  ���A���G\n" +
                        "�p����:���ժ��A��,�ץ��|�u��,�X�l���G�D�ն�����,�M��,�������I");
//                mObj.setDetail("�M��(Plain congee),�P����(mung bean congee)");
                mObj.seteName("Soy bean milk ,Fresh fruits of the season \n" +
                        "Assorted delicatessen:\n" +
                        "Stir-fried bamboo shoot with fungus,\n" +
                        "Stir-fried pork and green beans with soy sauce,\n" +
                        "Tofu and eggplant with garlic soy paste,\n" +
                        "Bean sprouts salad,salty egg,\n " +
                        "Plain congee\n" +
                        "Steamed bun");
                mObj.setClassType(mClassType);              
                mObj.setDetail("���b��w����");
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
          }
          else if( "0008".equals(fltno) ) //#777
          {
              mClassType="C";  
              /***C��***/   
          mType = "Late night supper";//�d�]�K�\
              alacart = "Salad,Soup,Sweet finale";
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("�F��-��X�F�Ԧ��M���۳���\n" +
                      "���~-�s�Ĭe���ư���\n" +
                      "���I-Haagen�VDazs �B�N�O(����/���)");
              mObj.seteName("Salad-Mixed green saladwith sesame mayonnaise\n"+
                      "Soup-Pork rib with yam and wolfberry soup\n" +
                      "Sweet finale-Haagen�VDazs ice cream");
              mObj.setClassType(mClassType);  
              mObj.setDetail("����,���");
              mObj.setQuantity(40);        
              
              mainMeal.add(mObj);
              mObj = null;  
              alacart = "Main course";//�D��
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("�y���T�P���N�l��\n �u�`�A�� �ն�");
              mObj.seteName("Braised pork ribs with Yi-Lanspring onion\n" +
                      "Stir-fried vegetables and steamedrice");
              mObj.setClassType(mClassType);              
//              mObj.setQuantity(10);        
              mainMeal.add(mObj);
              mObj = null; 
                         
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("�����t����O\n�u�`�A�� ���v��\n��ĲH��հs��");
//              mObj.setDetail("���ƿ��X���o���(pesto-tomato cream sauce),�i�S�s���(port wine sauce)");
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
              mObj.setName("�Ϩ{�����L��\n�q����ɽ� �Q�S��e��");
//              mObj.setDetail("���ƿ��X���o���(pesto-tomato cream sauce),�i�S�s���(port wine sauce)");
              mObj.seteName("Pan-fried morel stuffed chicken thigh with port balsamic sauce\n" +
                      "Ratatouille andfettuccine witht ruffle oil");
              mObj.setClassType(mClassType);              
//              mObj.setQuantity(10);        
              mainMeal.add(mObj);
              mObj = null;
                      
              alacart = "Assorted bread selection";//�ѥ]
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("�P���Q�ѥ]");
              mObj.seteName("Hoshino salty bread");
              mObj.setClassType(mClassType);              
              mObj.setQuantity(20);        
              mainMeal.add(mObj);
              mObj = null;
              
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("�馡�n�]");
              mObj.seteName("Japanese soft roll");
              mObj.setClassType(mClassType);              
              mObj.setQuantity(40);        
              mainMeal.add(mObj);
              mObj = null;

              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("���[�ѥ]");
              mObj.seteName("Garlic bread");
              mObj.setClassType(mClassType);              
              mObj.setQuantity(20);        
              mainMeal.add(mObj);
              mObj = null;                
                     
           mType = "Gourmet savory";//����
              alacart = "����I��";
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setName("���׶�");
              mObj.seteName("Traditional Taiwan bolognaise meat sauce Served with soy sauce-braised egg, takuwan, steamed rice");
              mObj.setClassType(mClassType);              
//              mObj.setQuantity(20);        
              mainMeal.add(mObj);
              mObj = null;
              
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setName("��ۣ���׶p(���רӷ��G �æ���)");
              mObj.seteName("Fresh mushrooms beef puff");
              mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
              mainMeal.add(mObj);
              mObj = null;
              
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setName("�_�h�L");
              mObj.seteName("Cheese platter");
              mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
              mainMeal.add(mObj);
              mObj = null;
                           
          mType = "breakfast menu";//���\���Breakfast menu
              alacart = "Breakfast";
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("�覡-\n" +
                      "���A���G �u��\n" +
                      "�D��-�t�D�Ե�k���J��\nĨۣ ���X �ᷦ��");
              mObj.setDetail("�s�C�۶��ѥ](Longan bread mixed with red wine),�i�|(Croissant),�զR�q(White toast)");
              mObj.seteName("Fresh fruits of the season, Yogurt\n" +
                      "Main course-\nSmoked salmon spinach scrambled eggs crepe\n" +
                      "Button mushroom, tomato, broccoli");
              mObj.setClassType(mClassType);          
              mObj.setDetail("���b��w����");
  //            mObj.setQuantity(5);        
              mainMeal.add(mObj);
              mObj = null;
              
//              alacart = "Chinese breakfast";
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("����-\n" +
                      "�Τ@����  ���A���G\n" +
                      "�p����:���ժ��A��,�ץ��|�u��,�X�l���G�D�ն�����,�M��,�������I");
//              mObj.setDetail("�M��(Plain congee),�P����(mung bean congee)");
              mObj.seteName("Soy bean milk ,Fresh fruits of the season \n" +
                      "Assorted delicatessen:\n" +
                      "Stir-fried bamboo shoot with fungus,\n" +
                      "Stir-fried pork and green beans with soy sauce,\n" +
                      "Tofu and eggplant with garlic soy paste,\n" +
                      "Bean sprouts salad,salty egg,\n " +
                      "Plain congee\n" +
                      "Steamed bun");
              mObj.setClassType(mClassType);  
              mObj.setDetail("���b��w����");
  //            mObj.setQuantity(5);        
              mainMeal.add(mObj);
              mObj = null;
        }
       
//        if(sect.substring(4).equals("TPE"))    
        if("0003".equals(fltno))
        {
            mClassType="F";  
            /***F��***/  
            mType = "Late night supper";//�d�]�K�\
                alacart = "Appetizer";//�e��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���M�۳¦ϱơB�D�ծ����֡B������");
                mObj.seteName("Cumin lamb chop, marinated jelly fish, chicken with ginger sauce");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�����F�� �X �C���B�|�u���B�v���B�f�X�B�¾��V");
                mObj.seteName("Nicoise salad �X tuna, green beans, potato, tomato, black olive");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                alacart = "Soup";//���~
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�V�u���ɴ� �X �����ήL��L��");
                mObj.seteName("Braised chinese soup �X conch, mushroom, yam, Chinese herbs");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("����Ĩۣ��");
                mObj.seteName("Chicken and mushroom consomme, garnish with mushroom flan");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Main course";//�D��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�L�N�[�����ѦפY�B���ؤ��L������X�ɽ��Φ̶�");
                mObj.seteName("Braised sea cucumber and meat balls in garlic sauce, steamed chicken with Chinese ham, assorted mixed vegetables, steamed rice");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�үN����O���C���B�ᷦ��B�m�ԡB�N�v���T�ά��s���");
                mObj.seteName("Grilled beef tenderloin, broccoli, cauliflower, bell pepper, duchess potato, red wine sauce");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�q�j�Q�s����B���������汲�εf�X�s�����o��");
                mObj.seteName("Lobster ravioli with prawn vegetable bundle, lobster tomato cream sauce");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "The bakery";//����ѥ]                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�q����c�ѥ]");
                mObj.seteName("Ciabatta bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("��³�ѥ]");
                mObj.seteName("Multi grain roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���o�ѥ]");
                mObj.seteName("Brioche roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�����ѥ]");
                mObj.seteName("Focaccia roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���[�ѥ]");
                mObj.seteName("Garlic bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Dessert ";//���I
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�u�`�A�G");
                mObj.seteName("Fresh fruits of the season");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���_�q�L");
                mObj.seteName("Selection of cheese");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�L�s�����Ǵ� ");
                mObj.setDetail("�ż� (warm),�N��(cold)");
                mObj.seteName("Braised longan, Chinese date");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���J�O�ѥ]���B�������έ�����");
                mObj.seteName("Chocolate bread pudding, mixed berries, vanilla sauce");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen�VDazs �B�N�O");
                mObj.seteName("Haagen�VDazs ice cream");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
             mType = "Light bites menu";//����
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("��o���N������");
                mObj.seteName("Authentic Taiwanese beef noodle soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("�ư�����");
                mObj.seteName("Deep fired pork cutlet with noodle soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("���׫��F�y���F��");
                mObj.seteName("Chicken wellington");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("�����Y����");
                mObj.seteName("Vegetarian instant noodle");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("���s�_�q�L");
                mObj.seteName("Cheese platter");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("���G��");
                mObj.seteName("Mixed nuts");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
             mType = "Breakfast menu";//    ���\���
                mObj = new MenuMealTypeObj();
                alacart = "dirnk";
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�h���");
                mObj.seteName("Orange juice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);   
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ī�G��");
                mObj.seteName("Apple juice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                         
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�f�X��");
                mObj.seteName("Tomato juice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);    
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "others";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���A���G");
                mObj.seteName("Fresh fruits of the season");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);  
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�B���ܤ�");
                mObj.seteName("Cereals");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);  
                mainMeal.add(mObj);
                mObj = null;                
         
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�u�T��");
                mObj.seteName("Drinking yogurt");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);      
                mainMeal.add(mObj);
                mObj = null;    
                
    
                alacart="����ѥ]�����o�ΪG��";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���ڽ��֮簨��");
                mObj.seteName("Chocolate muffin");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�����i�|");
                mObj.seteName("Almond croissant");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                             
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�Ų��N��");
                mObj.seteName("Blueberry scone");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�p���R�q");
                mObj.seteName("Thick white toast");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                
                alacart="Main course";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�覡���J�t�ĥ����`�ʡB�f�X�B���׸z�άv����");
                mObj.seteName("Cheese omelet portabella mushroom, tomato, chicken sausage, fingerling potato");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�d�G���J�O�ѥ]���B�������B�ި��٤έ�����");
                mObj.seteName("Corn and scallion pancake peach compote, tomato, chicken sausage");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�M��--�}���յ�B���N�˲Ʀ׵����G�B�����p�m��աB�D�դz���B  �����P�B�����p�C�Y�B �t�Ʀ��h�����Ѯȫȿ��");
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
            /***C��***/   
            mType = "Dinner menu";//���\
            alacart = "Appetizer,Salad,Soup";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�e��-�����E �A���E �N���צ��[���J����μs�F�w��\n" +
                    "�F��-��X�F�Ԥθq�j�Q�o�L\n" +
                    "���~-���w�ư���");
            mObj.seteName("Appetizer-Roast beef rosette with pesto aioli & steamed flower prawn, jelly fish salad\n" +
                    "Salad-Seasonal leafy salad- Italian balsamic olive dressing\n"+
                    "Soup-Braised pork ribs with lily flower soup\n");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(40);        
            mainMeal.add(mObj);
            mObj = null;  
            alacart = "Main course";//�D��
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("Į�o�j������\n �u�`�A�� �ն�");
            mObj.seteName("Braised abalone and chicken with oyster sauce\n" +
                    "Stir-fried vegetable, steamed rice");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null; 
                       
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("���ε�O����\n�v���T �ᷦ�� ���s��");
//            mObj.setDetail("���ƿ��X���o���(pesto-tomato cream sauce),�i�S�s���(port wine sauce)");
            mObj.seteName("Pan seared beef filet\n" +
                    "Duchess pomme, heirloom cauliflower with bordelaise sauce\n");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null; 
                                      
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�������Q���t\n�ɽ�  �v��  ��ù������");
//            mObj.setDetail("���ƿ��X���o���(pesto-tomato cream sauce),�i�S�s���(port wine sauce)");
            mObj.seteName("Miso glazed Chilean sea bass\n" +
                    "Vegetable, buttered potato, pancetta provencal sauce");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
                    
            alacart = "Assorted bread selection";//�ѥ]
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("���[�ѥ]");
            mObj.seteName("Garlic bread");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(40);        
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("���o�ѥ]");
            mObj.seteName("brioche roll");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(40);        
            mainMeal.add(mObj);
            mObj = null;

            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�p���ѥ]");
            mObj.seteName("wheat roll");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(40);        
            mainMeal.add(mObj);
            mObj = null;                
            
            alacart = "Sweet finale";//���e�������
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("���G");
            mObj.seteName("fresh fruits of the season");
            mObj.setClassType(mClassType);
            mObj.setQuantity(40);       
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�_�h�L");
            mObj.seteName("Cheese platter");
            mObj.setClassType(mClassType); 
            mObj.setQuantity(40);       
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("��Q�ɥ��J�O�}���J�|");
            mObj.seteName("Belgium chocolate mousse cake");
            mObj.setClassType(mClassType);
            mObj.setQuantity(40);       
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("Haagen�VDazs �B�N�O");
            mObj.seteName("Haagen�VDazs ice cream");
            mObj.setClassType(mClassType);
            mObj.setDetail("����,���");
            mObj.setQuantity(40);          
            mainMeal.add(mObj);
            mObj = null;                
                   
         mType = "Gourmet savory";
            alacart = "����I��";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setName("���䦡�p�I");
            mObj.seteName("Assorted delicate dim sum");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(20);        
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setName("�ŹT�J��");
            mObj.seteName("Four cheese quiche");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
           
        mType = "Breakfast menu";//���\���Breakfast menu
            alacart = "Breakfast";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�覡-\n" +
                    "���A���G �u��\n" +
                    "�D��-�Φ������J�����X���\n�v�� ���׸z");
            mObj.setDetail("�i�|(Croissant),ī�G����(apple Danish),�զR�q(White toast)");
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
            mObj.setName("����-\n" +
                    "���A���G\n" +
                    "�p����:�}���յ�,���N�˲Ʀ׵����G,�����p�m���,�����P,�M��,�������I");
//            mObj.setDetail("�M��(Plain congee),�P����(mung bean congee)");
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
            /***C��***/   
            mType = "Late night supper";//�d�]�K�\
                alacart = "Salad,Soup,Sweet finale";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�F��-��X�F�Ԥθq�j�Q�o�L\n" +
                        "���~-���w�ư���\n" +
                        "���I-Haagen�VDazs �B�N�O(����/���)");
                mObj.seteName("Salad-Seasonal leafy salad- Italian balsamic olive dressing\n"+
                        "Soup-Braised pork ribs with lily flower soup\n" +
                        "Sweet finale-Haagen�VDazs ice cream");
                mObj.setClassType(mClassType);         
                mObj.setDetail("����,���");
                mObj.setQuantity(40);        
                mainMeal.add(mObj);
                
                mObj = null;  
                alacart = "Main course";//�D��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Į�o�j������\n �u�`�A�� �ն�");
                mObj.seteName("Braised abalone and chicken with oyster sauce\n" +
                        "Stir-fried vegetable, steamed rice");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                           
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���ε�O����\n�v���T �ᷦ�� ���s��");
    //            mObj.setDetail("���ƿ��X���o���(pesto-tomato cream sauce),�i�S�s���(port wine sauce)");
                mObj.seteName("Pan seared beef filet\n" +
                        "Duchess pomme, heirloom cauliflower with bordelaise sauce");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                                          
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�������Q���t\n�ɽ� �v��  ��ù������");
    //            mObj.setDetail("���ƿ��X���o���(pesto-tomato cream sauce),�i�S�s���(port wine sauce)");
                mObj.seteName("Miso glazed Chilean sea bass\n" +
                        "Vegetable, buttered potato, pancetta provencal sauce");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                        
                alacart = "Assorted bread selection";//�ѥ]
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���[�ѥ]");
                mObj.seteName("Garlic bread");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(40);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���o�ѥ]");
                mObj.seteName("brioche roll");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(40);        
                mainMeal.add(mObj);
                mObj = null;
    
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�p���ѥ]");
                mObj.seteName("wheat roll");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(40);        
                mainMeal.add(mObj);
                mObj = null;                
                       
             mType = "Gourmet savory";//����
                alacart = "����I��";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("���䦡�p�I");
                mObj.seteName("Assorted delicate dim sum");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("�ŹT�J��");
                mObj.seteName("Four cheese quiche");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("�_�h�L");
                mObj.seteName("Cheese platter");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                             
            mType = "Breakfast menu";//���\���Breakfast menu
                alacart = "Breakfast";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�覡-\n" +
                        "���A���G �u��\n" +
                        "�D��-�Φ������J�����X���\n�v�� ���׸z");
                mObj.setDetail("�i�|(Croissant),ī�G����(apple Danish),�զR�q(White toast)");
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
                mObj.setName("����-\n" +
                        "���A���G\n" +
                        "�p����:�}���յ�,���N�˲Ʀ׵����G,�����p�m���,�����P,�M��,�������I");
    //            mObj.setDetail("�M��(Plain congee),�P����(mung bean congee)");
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
        /***C��***/
        if("TPEFRA".equals(sect))
        {
            mType = "Late night supper";//�d�]�K�\
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("�F��");
                mObj.setName("�ж�F�Ԧ��M���۳���");
                mObj.seteName("Garden salad with sesame dressing");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;            
                
                alacart = "�D��";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�د�Ť�����W�b-�x�����ư��Ѧ����p��");
                mObj.seteName("Taiwanese signature dish �VTaiwanese style deep fried pork chop noodle soup with assorted side dishes(Beef is originated from Taiwan)");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�����t����O-�u�`�A���B���v���B��ĲH��հs��");
                mObj.seteName("v,Clam & mussel base with wine sauce");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���δԳ��������X���T��-���A�A���B�q�j�Q����");
                mObj.seteName("Pan fried chicken thigh with lemon grass and tomato creamy sauce,Assorted vegetables and angel hair pasta ");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "����ѥ]����u���o";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�P���Q�ѥ]");
                mObj.seteName("Hoshino salty bread");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���[�ѥ]");
                mObj.seteName("garlic bread");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�馡�n�]");
                mObj.seteName("Japanese soft roll,");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;         
                                
                alacart = "��ﲢ�I��";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("��ﲢ�I��");
                mObj.seteName("Dessert");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
            mType ="Light bites menu";
            alacart = "�Ť��p�I";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�ǲξ|�׶�");
                mObj.seteName("Traditional Taiwanese bolognaise meat sauce Served with soy sauce braised egg, takuwan, steamed rice");
                mObj.setClassType(mClassType);              
    //          mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("��ۣ���׶p�]���רӷ��G�æ����^");
                mObj.seteName("Fresh mushrooms beef puff (Beef is originated from New Zealand)");
                mObj.setClassType(mClassType);              
    //          mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
            mType = "Breakfast menu";//���\
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("Western breakfast");
                mObj.setName("���A���G\n" +
                        "�u��\n  " +
                        "�t�D�Ե�k���J�� :Ĩۣ�B�f�X�B�ᷦ��\n" +
                        "�s�C�۶��ѥ]�B�i�|�B�p���R�q");
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
                mObj.setName("�Τ@����\n" +
                        "�M��-���ժ��A���B�ץ��|�u���B�X�l���G�B�D�ն����ޡB�������I");
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
            mType = "Lunch menu";//���\
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("�e��");
                mObj.setName("�Z�x�� �L�v�� �N�`�ʤά��L��");
                mObj.seteName("Duck liver terrine, onion confit, grilled zucchini, red currant");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                alacart = "�F��";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�ж�F�Ԧ������˰_�q�γͼ���");
                mObj.seteName("Mixed mesculin salad, parmesan cheese, caesar dressing");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                alacart = "�D��";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("��N�ަ� �����ɽ� �涺");
                mObj.seteName("Braised pork in soy sauce,Assorted oriental vegetables, pak choy, steamed rice");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���Ω��� Ī�� �m�� �f�X �f�c�ʨ����L��");
                mObj.seteName("Pan seared prawn, Asparagus, bell pepper, tomato, lemon thyme risotto" );
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���N���ݦ�Ũ�f�X �_�q ����� �C��� �C��q���e��");
                mObj.seteName("Roasted chicken breast with tomato, mozzarella,Beetroot, broccoli, tagliatelle with pesto sauce");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "����ѥ]����u���o";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("��c�ѥ]");
                mObj.seteName("Ciabatta bread");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;

                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�k���ѥ]");
                mObj.seteName("French baguette");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���[�ѥ]");
                mObj.seteName("garlic bread");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "���A���G";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���A���G");
                mObj.seteName("Freshe fruits of the season");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "���I";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���J�O�J�|");
                mObj.seteName("Praline chocolate cake");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
            mType = "Refreshment";//�K�\
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("Western refreshment");
                mObj.setName("�ж�F�Ԧ��d�q��\n" +
                        "�K�NĨۣ��������B����B�f�X�B�k������\n" +
                        "�i�|�B�P���ѥ] \n" +
                        "���u�`�A�G");
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
                mObj.setName("�P���ѥ]�B���צ˵�\n" +
                        "���צ̯���\n" +
                        "���u�`�A�G");
                mObj.seteName("Braised mushroom with tofu,Wok fried chicken with bamboo shoot\n" +
                        "Beef rice noodle soup\n" +
                        "Fresh fruits of the season");
                mObj.setClassType(mClassType);              
    //          mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
        }
        
//0051
        if("TPESYD".equals(sect) )//�x�_-����
        {
            mType = "Late night supper";//�d�]�K�\
                mObj = new MenuMealTypeObj();
//                mObj.setMealType(mType);
//                mObj.setAlacartType("�e��");
//                mObj.setName("�f�X�B�T���B�ɦרF�Ԧ��f���������");
//                mObj.seteName("Crab meat tartare tomato, avocado, micro greens, saffron mayonnaise");
//                mObj.setClassType(mClassType);              
////              mObj.setQuantity(5);        
//                mainMeal.add(mObj);
//                mObj = null;
            
//                alacart = "�F��";
//                mObj = new MenuMealTypeObj();
//                mObj.setMealType(mType);
//                mObj.setAlacartType(alacart);
//                mObj.setName("�A�m���F�Ԧ����ܮ۪�o�L��");
//                mObj.seteName("Garden salad with citrus onion ponzu dressing");
//                mObj.setClassType(mClassType);              
////              mObj.setQuantity(5);        
//                mainMeal.add(mObj);
//                mObj = null;
            
                alacart = "�D��";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�F��:�ж�F�Ԧ��M���۳���\n" +
                            "�D��:���N�l�� �u�`�A�� �ն�\n" +
                            "����ѥ]�����o"+
                            "��ﲢ�I��");
                mObj.setDetail("�P���Q�ѥ] (Hoshino salty bread),�馡�n�](Japanese soft roll),���[�ѥ](garlic bread)");
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
                mObj.setName("�F��:�ж�F�Ԧ��M���۳���\n" +
                            "�D��:���s����� �ɽ� �v��\n"+
                            "����ѥ]�����o"+
                            "��ﲢ�I��");
                mObj.setDetail("�P���Q�ѥ] (Hoshino salty bread),�馡�n�](Japanese soft roll),���[�ѥ](garlic bread)");
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
                mObj.setName("�F��:�ж�F�Ԧ��M���۳���\n" +
                            "�D��:���δԳ��������X���T�� ���A�A�� �q�j�Q����\n" +
                            "����ѥ]�����o"+
                            "��ﲢ�I��");
                mObj.setDetail("�P���Q�ѥ] (Hoshino salty bread),�馡�n�](Japanese soft roll),���[�ѥ](garlic bread)");
                mObj.seteName("Salad:Garden salad with sesame dressing\n" +
                        "Main course:Pan fried chicken thigh with lemon grass and tomato creamy sauce Assorted vegetables and angel hair pasta" +
                        "Assorted bread served with homemade butter" +
                        "Dessert Platter");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
//                alacart = "����ѥ]�����o";
//                mObj = new MenuMealTypeObj();
//                mObj.setMealType(mType);
//                mObj.setAlacartType(alacart);
//                mObj.setName("�P���Q�ѥ]");
//                mObj.seteName("Ciabatta bread");
//                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
//                mainMeal.add(mObj);
//                mObj = null;
//
//                mObj = new MenuMealTypeObj();
//                mObj.setMealType(mType);
//                mObj.setAlacartType(alacart);
//                mObj.setName("�q�������ѥ]");
//                mObj.seteName("pretzel roll");
//                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
//                mainMeal.add(mObj);
//                mObj = null;
//                
//                mObj = new MenuMealTypeObj();
//                mObj.setMealType(mType);
//                mObj.setAlacartType(alacart);
//                mObj.setName("���[�ѥ]");
//                mObj.seteName("garlic bread");
//                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
//                mainMeal.add(mObj);
//                mObj = null;
                                
//                alacart = "��ﲢ�I��";
//                mObj = new MenuMealTypeObj();
//                mObj.setMealType(mType);
//                mObj.setAlacartType(alacart);
//                mObj.setName("��ﲢ�I��");
//                mObj.seteName("Passion fruit mousse cake with raspberry sauce");
//                mObj.setClassType(mClassType);              
////              mObj.setQuantity(5);        
//                mainMeal.add(mObj);
//                mObj = null;
                
                mType = "Breakfast menu";//���\
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("Western breakfast");
                mObj.setName("���A���G\n" +
                        "�u��\n  " +
                        "�t�D�Ե�k���J�� Ĩۣ �f�X �ᷦ��\n" +
                        "�s�C�۶��ѥ]�B�i�|�B�p���R�q");
                mObj.setDetail("���\�\��(Cereals)");
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
                mObj.setName("�Τ@����\n" +
                        "�M��-���ժ��A���B�ץ��|�u���B�X�l���G�B�������I");
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
        if("SYDTPE".equals(sect) )//����-�x�_ 
        {
            mType = "Late night supper";//�d�]�K�\
            
            alacart = "Main course";//�D��
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�e��:��ﭻ������F�Ԧ��q�j�Q�o�L��\n" +
                    "�D��:�z��X.O. ������� ��ۣ ���ڽ� ��������\n" +
                    "����ѥ]�����o \n" +
                    "��ﲢ�I��");
            mObj.setDetail("�k���ѥ](French baguette), ��c�ѥ](ciabatta bread), ��³�ѥ](Multigrain torpedo roll)"); 
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
            mObj.setName("�e��:��ﭻ������F�Ԧ��q�j�Q�o�L��\n" +
                    "�D��:�f�X �C���� �K�N�q���׺��� ���s��\n" +
                    "����ѥ]�����o \n" +
                    "��ﲢ�I��");
            mObj.setDetail("�k���ѥ](French baguette), ��c�ѥ](ciabatta bread), ��³�ѥ](Multigrain torpedo roll)");                
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
            mObj.setName("�e��:��ﭻ������F�Ԧ��q�j�Q�o�L��\n" +
                    "�D��:��������q���ŹT�Ѩ� ��þ�ϥ��_�h �C���\n" +
                    "����ѥ]�����o \n" +
                    "��ﲢ�I��");
            mObj.setDetail("�k���ѥ](French baguette), ��c�ѥ](ciabatta bread), ��³�ѥ](Multigrain torpedo roll)"); 
            mObj.seteName("Starter:Prawn, orange, cherry tomato, asparagus, dill, micro salad Italian vinaigrette dressing\n" +
                    "Main course:Ricotta cannelloni with chicken ragout Sauteed broccoli, cauliflower\n" +
                    "Assorted bread served with homemade butter\n" +
                    "Dessert Platter");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;              
            
         mType = "Breakfast menu";//    ���\���
            mObj = new MenuMealTypeObj();
            alacart = "Western breakfast";//"�覡���";
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("���A���G\n" +
                    "�u��\n" +
                    "�D��(�覡���J ��Ĩۣ, Ī��, ���׸z�άv���y)\n" +
                    "����ѥ]�����o�ΪG��");
            mObj.seteName("Fresh fruits of the season,\n" +
                    "Yogurt,\n" +
                    "Main course:Scrambled egg,Button mushroom, asparagus, chicken sausage, rosti potato)\n" +
                    "Assorted bread served with butter and jam");
            mObj.setDetail("���\�\��(Cereals),�i�|�ѥ](Croissant),�զR�q(toast)");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(20);   
            mainMeal.add(mObj);
            mObj = null;
            
            alacart = "Chinese breakfast";//"�������";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�M��\n" +
                    "�p����:���J�BĨۣ�|�u���B�������I");
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
            mType = "Late night supper";//�d�]�K�\
            alacart = "Appetizer";//�e��
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�������ݤ��������F��");
            mObj.seteName("Seared chicken and teriyaki eel with salad");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
                        
            alacart = "Main course";//�D��
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("������� ������ ���ڽ� �̶�");
            mObj.seteName("Wok-fried prawn with ginger sauce Kailan, carrot, steamed rice");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null; 
                            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�Ϩ{��ۣ��N�� ����X�ɽ� ���v��");
            mObj.seteName("Roasted chicken breast with morel sauce,Sauteed seasonal vegetables, red potato");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("��N�n�� ���յ� ���ڽ� ��X����");
            mObj.seteName("Duck breast with sauce Chinese cabbage, carrot, mixed couscous, beans, orzo pasta, red quinoa");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
            
            alacart = "The bakery";//����ѥ]�����o                              
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�v���ѥ]");
            mObj.seteName("Onion roll");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�k���ѥ]");
            mObj.seteName("French roll");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("���[�ѥ]");
            mObj.seteName("Garlic bread");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
                           
            alacart = "Fresh fruits of the season ";//�A�G
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("���u�`�A�G");
            mObj.seteName("Fresh fruits of the season");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
            
            alacart = "Dessert ";//���I
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("Chapman��s �B�N�O");
            mObj.seteName("Chapman��s Ice cream");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
            
//         mType = "Light bites menu";//    �Ť��p�I
//            
//            alacart = "�Ť��p�I";//"�覡���";
//            mObj = new MenuMealTypeObj();
//            mObj.setMealType(mType);
//            mObj.setAlacartType(alacart);
//            mObj.setName("�ǲκ��׶�");
//            mObj.seteName("Traditional Taiwan bolognaise meat sauce Served with soy sauce-braised egg, takuwan, steamed rice");
//            mObj.setClassType(mClassType);              
//            mObj.setQuantity(20);   
//            mainMeal.add(mObj);
//            mObj = null;   
//            
//            mObj = new MenuMealTypeObj();
//            mObj.setMealType(mType);
//            mObj.setAlacartType(alacart);
//            mObj.setName("���_�j�Ե���L���ĥ]");
//            mObj.seteName("Ham ricotta spinach pizza calzone");
//            mObj.setClassType(mClassType);              
//            mObj.setQuantity(20);   
//            mainMeal.add(mObj);
//            mObj = null;  
            
         mType = "Breakfast menu";//    ���\���                
            alacart = "Western breakfast";//"�覡���";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("���A���G�B�u��B�D��(���L�J��BĪ���B�f�X�ά��v��)�B����ѥ]�����o�ΪG��");
            mObj.seteName("Fresh fruits of the season,\n" +
                    "Yogurt,\n" +
                    "Main course(Egg crepe with black forest ham and scrambled egg and Cherry tomato, asparagus, red potato),\n" +
                    "Assorted bread served with butter and jam."); 
            mObj.setDetail("ī�G�����ѥ](Apple Danish),�i�|�ѥ](croissant)");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(10);   
            mainMeal.add(mObj);
            mObj = null;
            
            alacart = "Chinese breakfast";//"�������";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�Τ@���ߡB�p����(�^�檣���סB���J�B���¤�աB�����P)�B�M���B�������I");
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
            mType = "Late night supper";//�d�]�K�\
                alacart = "Salad";//�F��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�ж�F�Ԧ��M���۳���");
                mObj.seteName("Garden salad with sesame dressing");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                            
                alacart = "Main course";//�D��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���N�l�� �u�`�A�� �ն�");
                mObj.seteName("Braised pork ribs with spring onion Stir-fried vegetables and steamed rice");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���s����ס]���רӷ��G�ڮ����^�ɽ� �v��");
                mObj.seteName("Beef goulash with red wine sauce (Beef is originated from Panama),Broccoli, cauliflower, pumpkin stick and new potatoes with chive");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���δԳ��������X���T��,���A�A�� �q�j�Q����");
                mObj.seteName("Pan fried chicken thigh with lemon grass and tomato creamy sauce ,Assorted vegetables and angel hair pasta");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "The bakery";//����ѥ]�����o                              
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�P���Q�ѥ]");
                mObj.seteName("Hoshino salty bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�馡�n�]");
                mObj.seteName("Japanese soft roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���[�ѥ]");
                mObj.seteName("Garlic bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                               
                alacart = "Fresh fruits of the season ";//�A�G
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���u�`�A�G");
                mObj.seteName("Fresh fruits of the season");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Dessert ";//���I
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen�VDazs �B�N�O");
                mObj.seteName("Haagen�VDazs");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
             mType = "Light bites menu";//    �Ť��p�I
                
                alacart = "�Ť��p�I";//"�覡���";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�ǲκ��׶�");
                mObj.seteName("Traditional Taiwan bolognaise meat sauce Served with soy sauce-braised egg, takuwan, steamed rice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);   
                mainMeal.add(mObj);
                mObj = null;   
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("��ۣ���׶p�]���רӷ��G�æ����^");
                mObj.seteName("Fresh mushrooms beef puff (Beef is originated from New Zealand)");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);   
                mainMeal.add(mObj);
                mObj = null;  
                
             mType = "Breakfast menu";//    ���\���                
                alacart = "Western breakfast";//"�覡���";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���A���G�B�u��B�D��(�t�D�Ե�k���J���BĨۣ �B�f�X �B�ᷦ��)�B����ѥ]�����o�ΪG��");
                mObj.seteName("Fresh fruits of the season,\n" +
                        "Yogurt,\n" +
                        "Main course(Scrambled egg crepe with smoked salmon and spinach,Button mushroom, tomato, broccoli ),\n" +
                        "Assorted bread served with butter and jam."); 
                mObj.setDetail("���\�\��(Cereals),�s�C�۶��ѥ](Longan bread mixed with red wine),�i�|(Croissant),�p���R�q(white toast)");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(10);   
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Chinese breakfast";//"�������";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�Τ@���ߡB�p����(���ժ��A���B�ץ��|�u���B�X�l���G�B�D�ն�����)�B�M���B�������I");
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
            mType = "Late night supper";//�d�]�K�\
                alacart = "Salad";//�F��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�ж�F�Ԧ��M���۳���");
                mObj.seteName("Garden salad with sesame dressing");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                            
                alacart = "Main course";//�D��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�د�Ť�����W�b-�x�����N�����Ѧ����p��");
                mObj.seteName("Taiwanese signature dish �V Authentic Taiwanese Beef noodle soup with assorted side dishes (Beef is originated from Taiwan)");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�����t����O �u�`�A�� ���v�� ��ĲH��հs��");
                mObj.seteName("Pan fried sea bass filet Seasonal vegetables and new potatoes Clam & mussel base with wine sauce");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���δԳ��������X���T�� ���A�A�� �q�j�Q����");
                mObj.seteName("Pan fried chicken thigh with lemon grass and tomato creamy sauce Assorted vegetables and angel hair pasta");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "The bakery";//����ѥ]�����o                              
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�P���Q�ѥ]");
                mObj.seteName("Hoshino salty bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�馡�n�]");
                mObj.seteName("Japanese soft roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���[�ѥ]");
                mObj.seteName("Garlic bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                 
             mType = "Light bites menu";//    �Ť��p�I                
                alacart = "�Ť��p�I";//"�覡���";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�ǲκ��׶�");
                mObj.seteName("Traditional Taiwan bolognaise meat sauce Served with soy sauce-braised egg, takuwan, steamed rice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);   
                mainMeal.add(mObj);
                mObj = null;   
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("��ۣ���׶p�]���רӷ��G�æ����^");
                mObj.seteName("Fresh mushrooms beef puff (Beef is originated from New Zealand)");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(10);   
                mainMeal.add(mObj);
                mObj = null;  
                
             mType = "Breakfast menu";//    ���\���                
                alacart = "Western breakfast";//"�覡���";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���A���G�B�u��B�D��(�t�D�Ե�k���J���BĨۣ �B�f�X �B�ᷦ��)�B����ѥ]�����o�ΪG��");
                mObj.seteName("Fresh fruits of the season,\n" +
                        "Yogurt,\n" +
                        "Main course(Scrambled egg crepe with smoked salmon and spinach,Button mushroom, tomato, broccoli ),\n" +
                        "Assorted bread served with butter and jam."); 
                mObj.setDetail("���\�\��(Cereals),�s�C�۶��ѥ](Longan bread mixed with red wine),�i�|(Croissant),�p���R�q(white toast)");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(10);   
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Chinese breakfast";//"�������";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�Τ@���ߡB�p����(���ժ��A���B�ץ��|�u���B�X�l���G�B�D�ն�����)�B�M���B�������I");
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
            mType = "Lunch menu";//���\���
                alacart = "Appetizer";//�e��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�p�s���F�Ԧ��f�X�ν��i��");
                mObj.seteName("Crayfish salad with tomato, chopped chives, Balsamic reduction, aioli and pesto");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                            
                alacart = "Salad";//�F��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("��þ�_�h�f�X�F�Ԧ��n�ʬ�o�L��");
                mObj.seteName("Mesclun salad with feta cheese, tomato, pumpkin seed dressing");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Main course";//�D��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�|�t�f���»��� �Ե� �ɦ̵� ���ڽ� �̶�");
                mObj.seteName("Wok fried spicy chicken-Sichuan style Chinese vegetable, baby corn, carrot, steamed rice");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���N����O �K�N�v�� �N���� ���ƥ��o ");
                mObj.seteName("Grilled beef tenderloin Grilled mediterranean vegetables, gratin potato, cafe de Paris");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�����K�� ��X�ɽ� �N�g�����v�� �Ĩ��f�c���o��");
                mObj.seteName("Pan seared dorade fillet Grilled assorted vegetables, roasted rosemary potato, caper lemon butter sauce");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Assorted bread served with homemade butter";//����ѥ]�����o                              
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���V��c�ѥ]");
                mObj.seteName("Olive ciabatta bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�w���ѥ]");
                mObj.seteName("laugen roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���[�ѥ]");
                mObj.seteName("garlic bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                               
                alacart = "Fresh fruits of the season ";//�A�G
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���u�`�A�G");
                mObj.seteName("Fresh fruits of the season");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Dessert ";//���I
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���@�~�G���T");
                mObj.seteName("Mango panna cotta");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;                
          
             mType = "Refreshment";//                  
                alacart = "Western refreshment";//"�覡�K�\";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�ж�F�Ԧ��d�q��B�D��(�������צ��X��B�N�`�ʡBĨۣ���o�q�j�Q��)�B����ѥ]����u���o�B���u�`�A�G");
                mObj.seteName("Salad:Garden salad with Thousand Island dressing,\n" +
                        "Main course(Pan seared chicken medallion on tomato salsa sauce Zucchini creamy truffle tortellini),\n" +
                        "Assorted bread served with homemade butter\n" +
                        "resh fruits of the season.");
                mObj.setDetail("�n�ѥ](Soft roll),���]�����ѥ](Viennese salted roll)");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(10);   
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Chinese refreshment";//"�����K�\";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�p����(�K�_����B�}���յ�)�B�D��(�����e�N�_������)�B���u�`�A�G");
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
        
        //����
        MenuDrinkObj dObj = null;
        dClassType="F";  
        /***F��***/
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
            dObj.setDetail("�k��-Pol Roger�D2000/France-Pol Roger 2000");
            drink.add(dObj);
            dObj = null;
            
            //�հs
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("�հs/White Wine");
            dObj.setDetail("�k��-�L���Q�D�L�h��:2009/Chablis Chardonnay 2009,�w��-�p��e���D�R���¡D2012/Germany-Mosel Valley Riesling 2012");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;   
            
            //���s            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("���s/Red Wine");
            dObj.setDetail("�k��V�t���Q�w�ϡD�԰��ڹy 1997:Saint-Julien/France-Chateau Langoa Barton 1997,�D�w�V��ù�F�e���D�ƫ��D2009/Australia-Barossa Valley Shiraz 2009,����-�ǩ��e���D����  2009/U.S.A.-Napa Valley Merlot Reserve 2009");
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
        /***C��***/
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
            dObj.setDetail("�k�� GREMILLET���b/France Champagne Gremillet");
            drink.add(dObj);
            dObj = null;
            
            //�հs
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("�հs/White Wine");
            dObj.setDetail("�k�� �V�L���Q�@�Ÿ���� �L�h�� 2010/France-Chablis 1er Cru Chardonnay 2010,�w�� -�p��e���D�R���¡D2012/Germany-Mosel Valley Riesling 2012");
            //dObj.setQuantity(5);        
            drink.add(dObj);
            dObj = null;   
            
            //���s            
            dObj = new MenuDrinkObj();
            dObj.setType(dType);
            dObj.setClassType(dClassType);
            dObj.seteName("���s/Red Wine");
            dObj.setDetail("�k��D�԰����D2006/France-Chateau La Gorce 2006,�q�j�Q - �_���Ĭ��áA2011/Italy-Chianti Riserva DOCG 2011,����D�ǩ��e���D���� 2009/U.S.A.-Napa Valley Merlot Reserve 2009");
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
        //�\�I
        MenuMealTypeObj mObj = null;        
            
        if("0004".equals(fltno))
        {
            mClassType="F";  
            /***F��***/   
            mType = "Late night supper";//�d�]�K�\
                alacart = "Appetizer";//�e��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�j����Ī���N�L");
                mObj.seteName("Stewed abalone and green asparagus");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�A��v�a�t�D��");
                mObj.seteName("Smoke salmon in zucchini net pattern");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                alacart = "Soup";//���~
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�»[�������");
                mObj.seteName("raised chicken and black garlic soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���ײM��");
                mObj.seteName("Beef consomme");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
//                alacart = "Salad";//�F��
//                mObj = new MenuMealTypeObj();
//                mObj.setMealType(mType);
//                mObj.setAlacartType(alacart);
//                mObj.setName("��o�F�Ԧ����t��");
//                mObj.setDetail("�S�ž��V�o(extra virgin olive oil),�q�j�Q���~����L(balsamic vinegar),�����۳���(sesame plum dressing)");
//                mObj.seteName("Garden salad served with selected condiments");
//                mObj.setClassType(mClassType);              
//    //            mObj.setQuantity(5);        
//                mainMeal.add(mObj);
//                mObj = null;
                
                alacart = "Main course";//�D��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�­���ۣ�� ���[�ܻT�]���� ���̶� ,����s�� ���� �n�� ����");
                mObj.setDetail("�Q�B�̶�(healthy multi grains rice)");
                mObj.seteName("Stir-fried pork and mushroom  Steamed halibut and tofu  with steamed rice or multi grains rice White and purple yam  lotus root  pumpkin  loofah");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                             
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�g������J�����O �����v��,�@�@�ͥ��E����ۣ�i");
//                mObj.setDetail("���ƿ��X���o���(pesto-tomato cream sauce),�i�S�s���(port wine sauce)");
                mObj.seteName("Grilled beef tenderloin in rosemary and green pepper sauce with new potato Abalone mushroom zucchini round");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                              
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�f�c���o��ĵԵ������y  ���X�汲��,�m�y�ͥʲ�");
//                mObj.setDetail("���ƿ��X���o���(pesto-tomato cream sauce),�i�S�s���(port wine sauce)");
                mObj.seteName("Dried shrimp spinach with pasta in tomato sauce Vegetables balls in zucchini section");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "The bakery";//����ѥ]
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�𭻰_�h�ѥ]");
                mObj.seteName("French bread with cheese fresh basil ");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�k��iۣ�]");
                mObj.seteName("French mushroom roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�۳��ѥ]��");
                mObj.seteName("Grissini with sesame");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�´Ԭv���]");
                mObj.seteName("Onion bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���[�ѥ]");
                mObj.seteName("Garlic bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Sweet finale";//���e�������
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�u�`�A�G");
                mObj.seteName("Seasonal fresh fruit");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���_�q");
                mObj.seteName("Selection of cheese");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�[������L�J");
                mObj.seteName("Jasmin tea with egg pudding");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�Ь֤l�_�h�J�|");
                mObj.seteName("Raspberry cheese cake");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen�VDazs �B�N�O");
                mObj.seteName("Haagen�VDazs ice cream");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
             mType = "Light bites menu";//����
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("���N�x�W������ (�i�ɥΧֳt��o���I)");
                mObj.seteName("Authentic Taiwanese beef noodle soup ( Fast and delicate of Taiwan delight)");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("����̭a��");
                mObj.seteName("Hakka rice noodle with minced pork and shallot");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("�ڽ��]�`���Y��");
                mObj.seteName("Stuffed fish ball and turnip soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("��������װ_�h��");
                mObj.seteName("Mexico beef cheese tart ");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("�����Y����");
                mObj.seteName("Vegetarian instant noodle");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("���_�q�L");
                mObj.seteName("Cheese platter");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("���G��");
                mObj.seteName("Mixed nuts");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
             mType = "Breakfast menu";//    ���\���
                mObj = new MenuMealTypeObj();
                alacart = "dirnk";
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�h���");
                mObj.seteName("Orange");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ī�G��");
                mObj.seteName("Apple");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                         
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�f�X��");
                mObj.seteName("Tomato");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                              
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("����");
                mObj.seteName("Milk");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "others";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���A���G");
                mObj.seteName("Fresh fruits of the season");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�B���ܤ�");
                mObj.seteName("Cereals");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;                
         
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�u��");
                mObj.seteName("Yogurt ");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;    
                

                alacart="����ѥ]�����o�ΪG��";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�s�C�۶��ѥ]");
                mObj.seteName("fermented with red wine s");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("��֥i�i��");
                mObj.seteName("Chocolate bread with dried orange peel ");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                             
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�i�|");
                mObj.seteName("Croissant");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�p���զR�q");
                mObj.seteName("White Toast");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                
                alacart="Main course";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Ī���_�h�J�ڽ��J�]  ���v�� �C���  �f�X  �j��ۣ  ���t�a�֤��L");
                mObj.seteName("Asparagus cheese carrot omelette with potatoes Broccoli  tomato  oyster mushroom  smoked virginia ham");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�Q�S�檣�J  ���^���P��� �����ͥ�  �vۣ �f�X  ���t�a�֤��L");
                mObj.seteName("Scrambled eggs in truffle mushroom sauce with muffin Squash with bacon  button mushroom  smoked virginia ham");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�M�� --��j����γJ�B�ʤl�׻�B������L�ߡB�D�ծ���,�s�F�����P�B�гJ");
//                mObj.setDetail("�M��(Plain congee),���\��³��(Oat congee)");
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
            /***C��***/   
            mType = "Dinner menu";//���\
//            
                alacart = "Appetizer,Salad,Soup";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�e��-�ж�F�� ���M���۳���\n" +
                        "�F��-�}�ߪG�_�h�t�D��\n" +
                        "���~-������L�˵�����");
                mObj.seteName("Garden salad with sesame salad dressing\n" +
                        "Smoked salmon with pistachios cream cheese\n"+
                        "Chicken soup with baby cabbage blanched\n");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(40);        
                mainMeal.add(mObj);
                mObj = null;  
                alacart = "Main course";//�D��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�­���ۣ��  ���̶�\n �ժG  �C����  �J�ڽ�");
                mObj.seteName("Stir-fried pork and mushroom with steamed rice ginko nut  pak choy  carrot");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                           
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���s���L���� �����v�� �E��ۣ �ͥ�");
//                mObj.setDetail("���ƿ��X���o���(pesto-tomato cream sauce),�i�S�s���(port wine sauce)");
                mObj.seteName("Braised beef in red wine vegetables sauce with new potatoes abalone mushroom  zucchini");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                                          
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�f�c���o��ĵԵ������y  ���X�汲�� �E��ۣ �ͥ�");
//                mObj.setDetail("���ƿ��X���o���(pesto-tomato cream sauce),�i�S�s���(port wine sauce)");
                mObj.seteName("Dried shrimp spinach in lemon butter sauce with tomato sauce pasta abalone mushroom  zucchini");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                        
                alacart = "Assorted bread selection";//�ѥ]
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�𭻰_�h��");
                mObj.seteName("French bread with cheese  fresh basil");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�馡�n�ѥ]");
                mObj.seteName("Japanese soft roll");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(40);        
                mainMeal.add(mObj);
                mObj = null;

                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���[�ѥ]");
                mObj.seteName("Garlic bread");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;                
                
                alacart = "Sweet finale";//���e�������
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�_�h�L");
                mObj.seteName("Cheese platter");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(40);       
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�Ь֤l�_�h�J�|");
                mObj.seteName("Raspberry cheese cake");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(40);         
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen�VDazs �B�N�O");
                mObj.seteName("Haagen�VDazs ice cream");
                mObj.setClassType(mClassType);    
                mObj.setDetail("����,���");
                mObj.setQuantity(40);        
                mainMeal.add(mObj);
                mObj = null;                
                       
             mType = "Gourmet savory";
                alacart = "����I��";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("����̭a��");
                mObj.seteName("Hakka rice noodle with minced pork and shallot");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("��������װ_�h��");//(���רӷ��G �æ���)
                mObj.seteName("Mexican style beef and cheese tart");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
               
            mType = "Breakfast menu";//���\���Breakfast menu
                alacart = "Breakfast";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�覡-\n" +
                		"���A���G �u��\n" +
                		"�D��-�Ե�Z�����J�] ���۳¬v��\n�������L  �f�X �C���");
                mObj.setDetail("�s�C�۶��ѥ](Longan bread mixed with red wine),�i�|(Croissant),�զR�q(White toast)");
                mObj.seteName("Fresh fruits of the season, Yogurt\n" +
                		"Main course-\nBaked omelette in spinach bearnaise sauce with sesame parsley potatoes Parma ham, tomato, broccoli\n" );
                mObj.setClassType(mClassType);             
//                mObj.setDetail("���b��w����");
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
//                alacart = "Chinese breakfast";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("����-\n" +
                		"���A���G\n" +
                		"�M��  �P  �p����:��j����γJ,�ʤl�׻�,������L��,�гJ,�s�F�����P,�������I");
//                mObj.setDetail("�M��(Plain congee),�P����(mung bean congee)");
                mObj.seteName("Plain congee ,Seasonal fresh fruits\n" +
                        "Assorted delicatessen:\n" +
                		"Pan-fried eggs with pickled turnip,\n" +
                		"Pork and pickled cucumber patties,\n" +
        		        "Vegetable fern with sesame dressing,\n" +
        		        "Shredded dry pork  salted egg,\n " +
        		        "Steamed bun");
                mObj.setClassType(mClassType);              
//                mObj.setDetail("���b��w����");
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
          }//0006
          else if( "0008".equals(fltno) ) //#777
          {
              mClassType="C";  
              /***C��***/   
          mType = "Late night supper";//�d�]�K�\
          alacart = "Salad,Soup,Sweet finale";
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("�F��-�ж�F��  ���M���۳���\n" +
                      "���~-������L�˵�����\n" );
              mObj.seteName("Salad-Garden salad with sesame salad dressing\n"+
                      "Soup-Chicken soup with baby cabbage blanched\n");
              mObj.setClassType(mClassType);  
//              mObj.setDetail("����,���");
              mObj.setQuantity(40);        
              
              mainMeal.add(mObj);
              mObj = null;  
           alacart = "Main course";//�D��
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("�­���ۣ��  ���̶� �ժG  �C����  �J�ڽ�");
              mObj.seteName("Stir-fried pork and mushroom with steamed rice ginko nut  pak choy  carrot");
              mObj.setClassType(mClassType);              
//              mObj.setQuantity(10);        
              mainMeal.add(mObj);
              mObj = null; 

              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("���s���L����   �����v��  �E��ۣ �ͥ�");
//              mObj.setDetail("���ƿ��X���o���(pesto-tomato cream sauce),�i�S�s���(port wine sauce)");
              mObj.seteName("Braised beef in red wine vegetables sauce with new potatoes abalone mushroom zucchini");
              mObj.setClassType(mClassType);              
//              mObj.setQuantity(10);        
              mainMeal.add(mObj);
              mObj = null; 
                                        
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("�f�c���o��ĵԵ������y  ���X�汲�� �E��ۣ �ͥ�");
//              mObj.setDetail("���ƿ��X���o���(pesto-tomato cream sauce),�i�S�s���(port wine sauce)");
              mObj.seteName("Dried shrimp spinach in lemon butter sauce with tomato sauce pasta abalone mushroom  zucchini");
              mObj.setClassType(mClassType);              
//              mObj.setQuantity(10);        
              mainMeal.add(mObj);
              mObj = null;
                      
           alacart = "Assorted bread selection";//�ѥ]
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("�𭻰_�h��");
              mObj.seteName("French bread with cheese  fresh basil");
              mObj.setClassType(mClassType);              
              mObj.setQuantity(20);        
              mainMeal.add(mObj);
              mObj = null;
              
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("�馡�n�ѥ]");
              mObj.seteName("Japanese soft roll");
              mObj.setClassType(mClassType);              
              mObj.setQuantity(40);        
              mainMeal.add(mObj);
              mObj = null;

              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("���[�ѥ]");
              mObj.seteName("Garlic bread");
              mObj.setClassType(mClassType);              
              mObj.setQuantity(20);        
              mainMeal.add(mObj);
              mObj = null;                
              
           alacart = "Sweet finale";//���e�������              
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("�_�h�L");
              mObj.seteName("Cheese platter");
              mObj.setClassType(mClassType);              
              mObj.setQuantity(40);       
              mainMeal.add(mObj);
              mObj = null;
              
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("�Ь֤l�_�h�J�|");
              mObj.seteName("Raspberry cheese cake");
              mObj.setClassType(mClassType);              
              mObj.setQuantity(40);         
              mainMeal.add(mObj);
              mObj = null;
              
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("Haagen�VDazs �B�N�O");
              mObj.seteName("Haagen�VDazs ice cream");
              mObj.setClassType(mClassType);    
              mObj.setDetail("����,���");
              mObj.setQuantity(40);        
              mainMeal.add(mObj);
              mObj = null;                
                     
           mType = "Gourmet savory";
              alacart = "����I��";
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setName("����̭a��");
              mObj.seteName("Hakka rice noodle with minced pork and shallot");
              mObj.setClassType(mClassType);              
//              mObj.setQuantity(20);        
              mainMeal.add(mObj);
              mObj = null;
              
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setName("��������װ_�h��");//(���רӷ��G �æ���)
              mObj.seteName("Mexican style beef and cheese tart");
              mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
              mainMeal.add(mObj);
              mObj = null;
                                         
              mType = "Breakfast menu";//���\���Breakfast menu
              alacart = "Breakfast";
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("�覡-\n" +
                      "���A���G �u��\n" +
                      "�D��-�Ե�Z�����J�] ���۳¬v��\n�������L  �f�X �C���");
              mObj.setDetail("�s�C�۶��ѥ](Longan bread mixed with red wine),�i�|(Croissant),�զR�q(White toast)");
              mObj.seteName("Fresh fruits of the season, Yogurt\n" +
                      "Main course-\nBaked omelette in spinach bearnaise sauce with sesame parsley potatoes Parma ham, tomato, broccoli\n" );
              mObj.setClassType(mClassType);             
//              mObj.setDetail("���b��w����");
  //            mObj.setQuantity(5);        
              mainMeal.add(mObj);
              mObj = null;
              
//              alacart = "Chinese breakfast";
              mObj = new MenuMealTypeObj();
              mObj.setMealType(mType);
              mObj.setAlacartType(alacart);
              mObj.setName("����-\n" +
                      "���A���G \n" +
                      "�M��  �P  �p����:��j����γJ,�ʤl�׻�,������L��,�гJ,�s�F�����P, �������I");
//              mObj.setDetail("�M��(Plain congee),�P����(mung bean congee)");
              mObj.seteName("Plain congee  ,Soy bean milk ,Seasonal fresh fruits\n" +
                      "Assorted delicatessen:\n" +
                      "Pan-fried eggs with pickled turnip,\n" +
                      "Pork and pickled cucumber patties,\n" +
                      "Vegetable fern with sesame dressing,\n" +
                      "Shredded dry pork  salted egg,\n " +
                      "Steamed bun");
              mObj.setClassType(mClassType);              
//              mObj.setDetail("���b��w����");
  //            mObj.setQuantity(5);        
              mainMeal.add(mObj);
              mObj = null;
        }//008
   
//        if(sect.substring(4).equals("TPE"))    
        if("0003".equals(fltno))
        {
            mType = "Late night supper";//�d�]�K�\
                alacart = "Appetizer";//�e��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�j�� ������ �ɸ}��");
                mObj.seteName("Abalone sliced  marinated soya chicken  crab claw");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�ɦ׶�  ���T�� �f�X Ī���F��");
                mObj.seteName("Crab meat tartar with avocado  tomato  asparagus micro greens");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                alacart = "Soup";//���~
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�ư���ͽ��´�");
                mObj.seteName("Braised lotus root with peanuts and pork rib soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���ڽ���������t�����R");
                mObj.seteName("Carrot and parsnip soup with turnip chips");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Main course";//�D��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�­J�Ԥ��J��  �����z�s��  ���� �����]�̶�");
                mObj.seteName("Stir- fried beef short ribs in black pepper sauce Stir- fried lobster with ginger onion sauce�@kai lan  steamed rice");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�L�Ͻ�  ��X�ɽ�  ���f����̶�");
                mObj.seteName("Braised lamb shank assorted seasonal vegetables, saffron rice");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�����t��  �ͥ� ���ڽ� �����f�X  ���_�D�p��  ���ڵܩi�����");
                mObj.seteName("Seared sea bass Zucchini  carrot  sun-dried tomato with couscous�@dill and lime cream sauce");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "The bakery";//����ѥ]                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�q����c�ѥ]");
                mObj.seteName("Ciabatta bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�Ⱳ�ѥ]");
                mObj.seteName("Twist roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���V�ѥ]");
                mObj.seteName("Olive roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�g�����ѥ]");
                mObj.seteName("Rosemary roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���[�ѥ]");
                mObj.seteName("Garlic bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Dessert ";//���I
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�u�`�A�G");
                mObj.seteName("Fresh fruits of the season");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���_�q�L");
                mObj.seteName("Selection of cheese");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�Ȧշ����ɦ��S");
//                mObj.setDetail("�ż� (warm),�N��(cold)");
                mObj.seteName("A White fungus, sweet corn with coconut milk sweet soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�@�ؼ}�����Ь֤l��");
                mObj.seteName("Coffee mousse with raspberry jam");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen�VDazs �B�N�O");
                mObj.seteName("Haagen�VDazs ice cream");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
             mType = "Light bites menu";//����
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("��o���N������");
                mObj.seteName("Authentic Taiwanese beef noodle soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("�@�~���A����");
                mObj.seteName("Imperial seafood noodle soup");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("���ڵԵ��Ь�");
                mObj.seteName("Bacon and spinach quiche");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("�����Y����");
                mObj.seteName("Vegetarian instant noodle");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("���s�_�q�L");
                mObj.seteName("Cheese platter");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("���G��");
                mObj.seteName("Mixed nuts");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
             mType = "Breakfast menu";//    ���\���
                mObj = new MenuMealTypeObj();
                alacart = "dirnk";
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�h���");
                mObj.seteName("Orange juice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);   
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ī�G��");
                mObj.seteName("Apple juice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                         
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�f�X��");
                mObj.seteName("Tomato juice");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);    
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "others";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���A���G");
                mObj.seteName("Fresh fruits of the season");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);  
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�B���ܤ�");
                mObj.seteName("Cereals");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);  
                mainMeal.add(mObj);
                mObj = null;                
         
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�u�T��");
                mObj.seteName("Drinking yogurt");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);      
                mainMeal.add(mObj);
                mObj = null;    
                
    
                alacart="����ѥ]�����o�ΪG��";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�i�|�ѥ]");
                mObj.seteName("Croissant");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�P������");
                mObj.seteName("Oatmeal muffin");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                             
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("������G�J�|");
                mObj.seteName("Banana nut cake");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�p���R�q");
                mObj.seteName("Thick white toast");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                
                alacart="Main course";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�覡�m�Եf�X�J�ճJ�]  ���v���� Ī�� �f�X �[���j���L  �m�Եf�X���  ");
                mObj.seteName("Egg white omelet with potato cake  asparagus tomato Canadian ham bell pepper and tomato salsa ");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���B�������έ�����");
                mObj.seteName("Nutella bread pudding mixed berries  vanilla sauce");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�M��--  �����ߡB ��������γJv���檣�z���B �D�ս���Ĩۣ�B �����P�B �����C�Y�B �t�Ʀ��h�����Ѯȫȿ��");
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
        /***C��***/   
        mType = "Dinner menu";//���\
            alacart = "Appetizer,Salad,Soup";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�e��-�������L �A�����~�G���\n" +
                    "�F��-�ж�F�� ���q�j�Q�o�L��\n" +
                    "���~-���jۣ�Ȧ�����");
            mObj.seteName("Appetizer-Prosciutto di parma and shrimp with mango salsa\n" +
                    "Salad-Garden salad with Italian balsamic olive dressing\n"+
                    "Soup-Chicken soup with king oyster mushroom and snow fungus\n");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(40);        
            mainMeal.add(mObj);
            mObj = null;  
            alacart = "Main course";//�D��
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�L���ư� ���̶� �C���� ���� �ժG");//\n
            mObj.seteName("Braised pork spareribs Wu-shi style with steamed rice Chinese green  red pepper  gingko nuts");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null; 
                       
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("���N����O�ʨ����� ���k�ꥤ���K�N�v�� �J�ڽ� �ᷦ�� ");
//            mObj.setDetail("���ƿ��X���o���(pesto-tomato cream sauce),�i�S�s���(port wine sauce)");
            mObj.seteName("Grilled beef tenderloin with gratin potato baby carrots  broccoli  thyme jus");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null; 
                                      
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("ù�ǵf�X�潼�Τz�� ���[���q�j�Q�󥭲��� ��Ī��");
//            mObj.setDetail("���ƿ��X���o���(pesto-tomato cream sauce),�i�S�s���(port wine sauce)");
            mObj.seteName("Sauteed shrimp and scallop in tomato basil sauce with garlic basil linguini asparagus");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
                    
            alacart = "Assorted bread selection";//�ѥ]
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�k�����o�J��");
            mObj.seteName("Roll brioche");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(40);        
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�����ѥ]");
            mObj.seteName("Wheat bread");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(40);        
            mainMeal.add(mObj);
            mObj = null;

            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("���[�ѥ]");
            mObj.seteName("wheat roll");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(40);        
            mainMeal.add(mObj);
            mObj = null;                
            
            alacart = "Sweet finale";//���e�������
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("���G");
            mObj.seteName("fresh fruits of the season");
            mObj.setClassType(mClassType);
            mObj.setQuantity(40);       
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�_�h�L");
            mObj.seteName("Cheese platter");
            mObj.setClassType(mClassType); 
            mObj.setQuantity(40);       
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("���d�}���J�|");
            mObj.seteName("Mocha mousse cake  ");
            mObj.setClassType(mClassType);
            mObj.setQuantity(40);       
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("Haagen�VDazs �B�N�O");
            mObj.seteName("Haagen�VDazs ice cream");
            mObj.setClassType(mClassType);
            mObj.setDetail("����,���");
            mObj.setQuantity(40);          
            mainMeal.add(mObj);
            mObj = null;                
                   
         mType = "Gourmet savory";
            alacart = "����I��";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setName("�s���I�� �A���z�� ���׿N�� �Ե�� ");
            mObj.seteName("Dim sim,steamed,shrimp rice roll,chicken siew mai,spinach dumpling");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(20);        
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setName("���׬�");
            mObj.seteName("Chicken pot pie");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
           
        mType = "Breakfast menu";//���\���Breakfast menu
            alacart = "Breakfast";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�覡-\n" +
                    "���A���G �u��\n" +
                    "�D��-�_�h�J�] ������v�� ���׸z �N���f�X�� �ᷦ��");
            mObj.setDetail("�i�|(Croissant),ī�G�����p(apple Danish),�զR�q(White toast)");
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
            mObj.setName("����-\n" +
                    "���A���G\n" +
                    "�p����:������ ,��������γJ ,�D�ս��¤�Ĩۣ ,���P,�������I");
//            mObj.setDetail("�M��(Plain congee),�P����(mung bean congee)");
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
            /***C��***/   
            mType = "Late night supper";//�d�]�K�\
                alacart = "Salad,Soup,Sweet finale";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�F��-��X�F�Ԥθq�j�Q�o�L\n" +
                        "���~-���jۣ�Ȧ�����\n");
                mObj.seteName("Salad-Garden salad with Italian balsamic olive dressing\n"+
                        "Soup-Chicken soup with king oyster mushroom and snow fungus\n");
                mObj.setClassType(mClassType);         
                mObj.setDetail("����,���");
                mObj.setQuantity(40);        
                mainMeal.add(mObj);
                
                mObj = null;  
                alacart = "Main course";//�D��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�L���ư� ���̶� �C���� ���� �ժG");
                mObj.seteName("Braised pork spareribs Wu-shi style with steamed rice Chinese green  red pepper  gingko nuts");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                           
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���N����O�ʨ����� ���k�ꥤ���K�N�v�� �J�ڽ� �ᷦ��");
    //            mObj.setDetail("���ƿ��X���o���(pesto-tomato cream sauce),�i�S�s���(port wine sauce)");
                mObj.seteName("Grilled beef tenderloin with gratin potato baby carrots  broccoli  thyme jus");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                                          
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("ù�ǵf�X�潼�Τz�� ���[���q�j�Q�󥭲��� ��Ī�� ");
    //            mObj.setDetail("���ƿ��X���o���(pesto-tomato cream sauce),�i�S�s���(port wine sauce)");
                mObj.seteName("Sauteed shrimp and scallop in tomato basil sauce with garlic basil linguini asparagus");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                        
                alacart = "Assorted bread selection";//�ѥ]
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�k�����o�J��");
                mObj.seteName("Roll brioche");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(40);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�����ѥ]");
                mObj.seteName("wheat bread ");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(40);        
                mainMeal.add(mObj);
                mObj = null;
    
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�p���ѥ]");
                mObj.seteName("garlic bread");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(40);        
                mainMeal.add(mObj);
                mObj = null;          
                
             alacart = "Sweet finale";//���e�������
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���G");
                mObj.seteName("fresh fruits of the season");
                mObj.setClassType(mClassType);
                mObj.setQuantity(40);       
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�_�h�L");
                mObj.seteName("Cheese platter");
                mObj.setClassType(mClassType); 
                mObj.setQuantity(40);       
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���d�}���J�|");
                mObj.seteName("Mocha mousse cake  ");
                mObj.setClassType(mClassType);
                mObj.setQuantity(40);       
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen�VDazs �B�N�O");
                mObj.seteName("Haagen�VDazs ice cream");
                mObj.setClassType(mClassType);
                mObj.setDetail("����,���");
                mObj.setQuantity(40);          
                mainMeal.add(mObj);
                mObj = null;            
                
             mType = "Gourmet savory";//����
                alacart = "����I��";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("�A���z�� ���׿N�� �Ե��");
                mObj.seteName("Dim sim steamed shrimp rice roll,�@chicken siew mai,�@�@spinach dumpling");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(20);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("���׬�");
                mObj.seteName("Chicken pot pie");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setName("�_�h�L");
                mObj.seteName("Cheese platter");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                             
            mType = "Breakfast menu";//���\���Breakfast menu
                alacart = "Breakfast";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�覡-\n" +
                        "���A���G �u��\n" +
                        "�D��- �_�h�J�] ������v��  ���׸z �N���f�X�� �ᷦ��");
                mObj.setDetail("�i�|(Croissant),ī�G�����p(apple Danish),�զR�q(White toast)");
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
                mObj.setName("����-\n" +
                        "���A���G\n" +
                        "�p����:������ ,��������γJ ,�D�ս��¤�Ĩۣ ,���P,�������I");
//                mObj.setDetail("�M��(Plain congee),�P����(mung bean congee)");
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
        /***C��***/
        if("TPEFRA".equals(sect))
        {
            mType = "Late night supper";//�d�]�K�\
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("�F��");
                mObj.setName("�ж�F�� ���M���۳���");
                mObj.seteName("Garden salad with sesame dressing");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;            
                
                alacart = "�D��";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�Q���׻汲 ������ ���ڽ� �ᷦ�� �f�X");
                mObj.seteName("Pork meat roll with noodle carrots  broccoli  tomato  ");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���N�ĥ��h�Q�� ���f�c���ƥ��o�ζ�����  �[������ �ᷦ�� �Q�l");
                mObj.seteName("Roasted sour cream fish with lemon and turmeric rice sauteed shrimp with garlic  broccoli  pine nut");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                
//                mObj = new MenuMealTypeObj();
//                mObj.setMealType(mType);
//                mObj.setAlacartType(alacart);
//                mObj.setName("�����J�������L-���[�������B�ɽ��Υն�");
//                mObj.seteName("Grilled chicken thigh with burdock spicy sauce sauteed shrimp with garlic, mixed vegetables and steamed rice");
//                mObj.setClassType(mClassType);              
////                mObj.setQuantity(10);        
//                mainMeal.add(mObj);
//                mObj = null;
                
                alacart = "����ѥ]����u���o";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�𭻰_�h�ѥ]");
                mObj.seteName("Hoshino salty bread");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�馡�n�]");
                mObj.seteName("garlic bread");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�j�[�ѥ]");
                mObj.seteName("Italian style spice bread");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;         
                  
                alacart = "Taste of Taiwan";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�x�����N������ ���p��");
                mObj.seteName("Authentic Taiwanese beef noodle soup Assorted side dishes  ");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "��ﲢ�I��";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�����_�h�J�| ������u����");
                mObj.seteName("Mashed sweet taro cheese cake with strawberry yoghurt sauce");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen�VDazs �B�N�O");
                mObj.seteName("Haagen�VDazs ice cream");
                mObj.setClassType(mClassType);
                mObj.setDetail("����,���");
                mObj.setQuantity(40);          
                mainMeal.add(mObj);
                mObj = null;    
                
            mType ="Light bites menu";
            alacart = "�Ť��p�I";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("����̭a��");
                mObj.seteName("Hakka rice noodle with minced pork and shallot");
                mObj.setClassType(mClassType);              
    //          mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("��������װ_�h��");
                mObj.seteName("Mexican style beef and cheese tart ");
                mObj.setClassType(mClassType);              
    //          mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
            mType = "Breakfast menu";//���\
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("Western breakfast");
                mObj.setName("���A���G\n" +
                        "�u��\n  " +
                        "�������L�J�] ���k���Ե楤�o�� �ᷦ�� �v�� �f�X");
                mObj.seteName("FRESH FRUITS OF THE SEASON \n" +
                        "Yogurt \n" +
                        "Parma ham omelet with spinach bernaise sauce broccoli  potatoes  tomato ");
                mObj.setDetail("�i�|(Croissant),�s�C�۶��ѥ](Longan bread fermented with red wine croissant  ),�զR�q(White toast)");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("Chinese breakfast");
                mObj.setName("�M��-��j����γJ �ʤl�׻�    ���¹L�� �s�F�����P �������I");
                mObj.seteName("Plain congee--�@pan-fried eggs with pickled turnip\n" +
                        "�@�@pork and pickled cucumber patties\n" +
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
            mType = "Lunch menu";//���\
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("�e��");
                mObj.setName("�ڦ����A�f�X��");
                mObj.seteName("Marinated seafood stuffed in tomato cup ");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                alacart = "�F��";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�ж�F�� ���q���o�L��");
                mObj.seteName("Garden salad with Italian dressing");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
            
                alacart = "�D��";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�������[���K�� ���̶� ���� ���ڽ�");
                mObj.seteName("Fried red snapper in hot garlic sauce with steamed rice kai-lan  carrots ");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���ά��s�ޱ� ���v���d �ᷦ�� ����");
                mObj.seteName("Fried pork fillet in red wine sauce with mashed potato broccoli  red pepper stripes " );
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���N�z����ī���� ������v��  ���ڽ� �|�u��");
                mObj.seteName("Roasted chicken breast in calvados sauce with new potato baby carrots  French bean ");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "����ѥ]����u���o";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�å����ѥ]");
                mObj.seteName("Sourdough roll ");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;

                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�k���ѥ]");
                mObj.seteName("baguette roll ");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���[�ѥ]");
                mObj.seteName("garlic bread");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                                
                alacart = "���~";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���o�������J�O �������");
                mObj.seteName("Creme brulee chocolate with fruity strawberry sauce ");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen�VDazs �B�N�O");
                mObj.seteName("Haagen�VDazs ice cream");
                mObj.setClassType(mClassType);
                mObj.setDetail("����,���");
                mObj.setQuantity(40);          
                mainMeal.add(mObj);
                mObj = null;    
                
            mType ="Light bites menu";
            alacart = "����I��";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�����רŹT�T���v");
                mObj.seteName("Turkey and cheese sandwich");
                mObj.setClassType(mClassType);              
    //          mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
            mType = "Refreshment";//�K�\
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("Western refreshment");
                mObj.setName("�ж�F�� ���o�L��\n" +
                        "����N�J�� ���������� �ᷦ�� Ĩۣ �f�X\n" +
                        "���A���G");
                mObj.seteName("Garden salad with vinaigrette dressing\n" +
                        " Vegetable tortilla with seared chicken\n" +
                        " broccoli  mushroom  tomato");
                mObj.setClassType(mClassType); 
                mObj.setDetail("�³��ѥ](Rye roll),���Q������(pretzel roll  )");
                
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("Chinese refreshment");
                mObj.setName("�Vۣ�e�N����\n" +
                        "�C����\n" +
                        "���ڪ����� �����z���z �@������ �����[�­J�Ԥ� \n" +
                        "���A���G");
                mObj.seteName("�@Chinese noodle soup with barbecued pork pak choy" +
                		"�@sauteed cabbage with bacon,fried sausage with spring onion" +
                		"�@braised bamboo shoots,green soybean with chili garlic and pepper\n" +
                        " Fresh fruits of the season");
                mObj.setClassType(mClassType);              
    //          mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
        }
        
//0051
        if("TPESYD".equals(sect) )//�x�_-����
        {
            mType = "Late night supper";//�d�]�K�\
                mObj = new MenuMealTypeObj();
//                mObj.setMealType(mType);
//                mObj.setAlacartType("�e��");
//                mObj.setName("�f�X�B�T���B�ɦרF�Ԧ��f���������");
//                mObj.seteName("Crab meat tartare tomato, avocado, micro greens, saffron mayonnaise");
//                mObj.setClassType(mClassType);              
////              mObj.setQuantity(5);        
//                mainMeal.add(mObj);
//                mObj = null;
            
//                alacart = "�F��";
//                mObj = new MenuMealTypeObj();
//                mObj.setMealType(mType);
//                mObj.setAlacartType(alacart);
//                mObj.setName("�A�m���F�Ԧ����ܮ۪�o�L��");
//                mObj.seteName("Garden salad with citrus onion ponzu dressing");
//                mObj.setClassType(mClassType);              
////              mObj.setQuantity(5);        
//                mainMeal.add(mObj);
//                mObj = null;
            
                alacart = "�D��";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�F��:�ж�F�� ���M���۳���\n" +
                		    "�D��:�f�X����U�ס@���A��涺  �ժG �C����");
//                mObj.setDetail("�𭻰_�h�ѥ](Hoshino salty bread),�馡�n�ѥ](Italian style spice bread),���[�ѥ](garlic bread)");
                mObj.seteName("Salad:Garden salad with sesame salad dressing\n" +
                		"Main course:Braised beef in tangerine peel and royal port wine sauce with jade rice Beef from Australia gingko nuts  pak choy");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�F��:�ж�F�� ���M���۳���\n" +
                		    "�D��:�Q���׻�@������  �C��� �ժ�� �J�ڽ�");
//                mObj.setDetail("�P���Q�ѥ] (Hoshino salty bread),�q�������ѥ](Italian style spice bread),���[�ѥ](garlic bread)");
                mObj.seteName("Salad:Garden salad with sesame salad dressing\n" +
                        "Main course:Pork jowly meat roll with pasta  broccoli cauliflower carrot");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�F��:�ж�F�� ���M���۳���\n" +
                		    "�D��:���N�ĥ��h�Q���@���Q�l������ �C��� �ժ�� �J�ڽ�");
//                mObj.setDetail("�P���Q�ѥ] (Hoshino salty bread),�q�������ѥ](Italian style spice bread),���[�ѥ](garlic bread)");
                mObj.seteName("Salad:Garden salad with sesame salad dressing\n" +
                        "Main course:Roasted fish in sour cream sauce with pine nut and turmeric rice broccoli cauliflower carrot");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "����ѥ]�����o";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�𭻰_�h�ѥ]");
                mObj.seteName("French bread with cheese fresh basil ");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
//
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�馡�n�ѥ]");
                mObj.seteName("Japanese soft roll  ");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
//                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���[�ѥ]");
                mObj.seteName("garlic bread");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                                
                alacart = "���~";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�_�h���G�L");
                mObj.seteName("Passion fruit mousse cake with raspberry sauce");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�����_�h�J�|�@������u����");
                mObj.seteName("Sweet taro cheese cake with strawberry yoghurt ");
                mObj.setClassType(mClassType);              
//              mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen�VDazs �B�N�O");
                mObj.seteName("Haagen�VDazs ice cream");
                mObj.setClassType(mClassType);
                mObj.setDetail("����,���");
                mObj.setQuantity(40);          
                mainMeal.add(mObj);
                mObj = null;  
                
                mType = "Breakfast menu";//���\
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("Western breakfast");
                mObj.setName("���A���G\n" +
                        "�u��\n  " +
                        "�Ե�Z�����J�] ���۳¬v�� �������L�@�f�X�@�C���");
                mObj.setDetail("���\�\��(Cereals)");
                mObj.seteName("FRESH FRUITS OF THE SEASON \n" +
                        "Yogurt\n" +
                        "Baked omelette in spinach bearnaise sauce with sesame parsley potato Parma ham  tomato  broccoli ");
                mObj.setClassType(mClassType);              
                mObj.setDetail("�i�|(Croissant),�s�C�۶��ѥ](Longan bread fermented with red wine croissant ),�զR�q(White toast)");                
                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType("Chinese breakfast");
                mObj.setName("�M��--��j����γJ,�ʤl�׻�,������L��,�s�F�����P,�гJ,�������I");
                mObj.seteName("SOYBEAN MILK\n" +
                        " Plain congee --�@pan fried eggs with pickled turnip\n" +
                        "�@pork and pickled cucumber patties\n" +
                        "�@vegetable fern with sesame dressing\n" +
                        "�@shredded dry pork  salted egg" +
                        " Steamed bun\n");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;                
           
        }
        
//0052
        if("SYDTPE".equals(sect) )//����-�x�_ 
        {
            mType = "Late night supper";//�d�]�K�\
            
            alacart = "Main course";//�D��
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�e��:�ж�F�Ԧ��q���o�L��\n" +
                    "�D��:�L���ư��@���z���J�ժ��� �C����  ���ڽ�");
//            mObj.setDetail("�k���ѥ](White torpedo roll), �ȳ¬��ѥ](linseed and soy roll), ���ѥ](sourdough)"); 
            mObj.seteName("Starter:Garden salad balsamic vinaigrette\n" +
                    "Main course:Wu xi style pork ribs with egg white fried rice poy choy  carrot ");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null; 
                            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�e��:�ж�F�Ԧ��q���o�L��\n" +
                    "�D��:���N���رơ@���v���d  ���ڽ� �ڦ��ڽ�");
//            mObj.setDetail("�k���ѥ](White torpedo roll), �ȳ¬��ѥ](linseed and soy roll), ���ѥ](sourdough)");                
            mObj.seteName("Starter:Garden salad balsamic vinaigrette\n" +
                    "Main course:Braise short beef ribs in red wine sauce with mashed potato carrot  parsnip ");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�e��:�ж�F�Ԧ��q���o�L��\n" +
                    "�D��:�@���ڳ��ơ@���C��q������  ���A�L��");
//            mObj.setDetail("�k���ѥ](White torpedo roll), �ȳ¬��ѥ](linseed and soy roll), ���ѥ](sourdough)"); 
            mObj.seteName("Starter:Garden salad balsamic vinaigrette\n" +
                    "Main Course:Dill crusted fish fillet with basil pesto orzo pasta ratatouille");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;   
            
            alacart = "����ѥ]�����o";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�k���ѥ]");
            mObj.seteName("White torpedo roll");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
//
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�Ļr�ѥ]");
            mObj.seteName("Sourdough rye roll ");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
//            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("��³�ѥ]");
            mObj.seteName("multigram roll  ");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
                            
            alacart = "���~";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�_�h���G�L");
            mObj.seteName("Passion fruit mousse cake with raspberry sauce");
            mObj.setClassType(mClassType);              
//          mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�_�h�J�|");
            mObj.seteName("Cheesecake ");
            mObj.setClassType(mClassType);              
//          mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�B�N�O");
            mObj.seteName("ice cream");
            mObj.setClassType(mClassType);
//            mObj.setDetail("����,���");
            mObj.setQuantity(40);          
            mainMeal.add(mObj);
            mObj = null;  
            
            
         mType = "Breakfast menu";//    ���\���
            mObj = new MenuMealTypeObj();
            alacart = "Western breakfast";//"�覡���";
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("���A���G\n" +
                    "�u��\n" +
                    "�D��(�Ե�_�q�M�J�����ڬv��  �N�f�X�@���L)\n" +
                    "����ѥ]�����o�ΪG��");
            mObj.seteName("Fresh fruits of the season,\n" +
                    "Yogurt,\n" +
                    "Main course:Spinach omelet with bacon potato grilled tomato  ham");
            mObj.setDetail("�i�|�ѥ](Croissant),�զR�q(toast bread )");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(20);   
            mainMeal.add(mObj);
            mObj = null;
            
            alacart = "Chinese breakfast";//"�������";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�M��\n" +
                    "�p����:���J ,�s�������A ,�D�դp���� ,���P,���o��,���A���G");
            mObj.seteName("Plain congee\n" +
                    "�@�@turnip egg cake, stir fried prawn and scallop,�@�@preserved cucumber,�@�@shredded dry pork  ,Green onion cake ,Seasonal fresh fruits\n");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(20);  
            mainMeal.add(mObj);
            mObj = null;
        }
        
//0031 YVR-TPE        
        if("0031".equals(fltno))
        {
            mType = "Late night supper";//�d�]�K�\
            alacart = "Appetizer";//�e��
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("���t�D�����n�׭� ���͵�F��");
            mObj.seteName("Smoked salmon and duck pate with salad");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
                        
            alacart = "Main course";//�D��
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�a�Ĥ��� ���̶� ���� ���ڽ�");
            mObj.seteName("Wok fried beef in black bean sauce with steamd rice kai lan  carrot ");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null; 
                            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�J����N�޵�O ��Ĩۣ�L�� �C��� ���ڽ�");
            mObj.seteName("Grilled pork tenderloin in green pepper sauce with mushroom risotto poy chay  carrot ");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("��N��س� ������  �C���� ���ڽ�");
            mObj.seteName("Sauteed halibut fillet in brown sauce with fried rice poy chay  carrot");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(10);        
            mainMeal.add(mObj);
            mObj = null;
            
            alacart = "The bakery";//����ѥ]�����o                              
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�v���ѥ]");
            mObj.seteName("Onion roll");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�k���ѥ]");
            mObj.seteName("French roll");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("���[�ѥ]");
            mObj.seteName("Garlic bread");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
                           
            alacart = "Dessert ";//���I
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�����@�سJ�|");
            mObj.seteName("Almond  coffee cake ");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
            
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("Haagen-Daz�B�N�O");
            mObj.seteName("Haagen-Daz ice cream");
            mObj.setClassType(mClassType);              
//            mObj.setQuantity(5);        
            mainMeal.add(mObj);
            mObj = null;
            
//         mType = "Light bites menu";//    �Ť��p�I
//            
            alacart = "�Ť��p�I";//"�覡���";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�A�ץ]");
            mObj.seteName("Steamed  pork bun");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(20);   
            mainMeal.add(mObj);
            mObj = null;   
            
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("���רF�Գ�");
            mObj.seteName("Ciabatta with chicken salad ");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(20);   
            mainMeal.add(mObj);
            mObj = null;  
            
         mType = "Breakfast menu";//    ���\���                
            alacart = "Western breakfast";//"�覡���";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("���A���G�B�u��B�D��(��Z��þ�z�Ե�J�� ���N���v��)�B����ѥ]�����o�ΪG��");
            mObj.seteName("Fresh fruits of the season,\n" +
                    "Yogurt,\n" +
                    "Main course(Chorizo frittata with roasted potato cherry tomato  ),\n" +
                    "Assorted bread served with butter and jam."); 
            mObj.setDetail("�զR�q(Toast ),�i�|�ѥ]( croissant)");
            mObj.setClassType(mClassType);              
            mObj.setQuantity(10);   
            mainMeal.add(mObj);
            mObj = null;
            
            alacart = "Chinese breakfast";//"�������";
            mObj = new MenuMealTypeObj();
            mObj.setMealType(mType);
            mObj.setAlacartType(alacart);
            mObj.setName("�p����(�е�׵�  �f�X���J �D�զ˵�  ���P)�B�M���B�������I");
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
            mType = "Late night supper";//�d�]�K�\
                alacart = "Salad";//�F��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�ж�F�Ԧ��M���۳���");
                mObj.seteName("Garden salad with sesame salad dressing");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                            
                alacart = "Main course";//�D��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�f�X����U�צ��A��涺 �ժG�C����");
                mObj.seteName("Braised beef in tangerine peel and royal port wine sauce with jade rice Beef from Australia gingko nuts  pak choy");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�Q���׻������ �C���ժ��J�ڽ�");
                mObj.seteName("Pork jowly meat roll with pasta broccoli cauliflower carrot");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���N�ĥ��h�Q�����Q�l������ �C���ժ��J�ڽ�");
                mObj.seteName("Roasted sour cream fish with pine nut and turmeric rice broccoli cauliflower carrot");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "The bakery";//����ѥ]�����o                              
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�𭻰_�h�ѥ]");
                mObj.seteName("Longan bread fermented with red wine");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�馡�n�]");
                mObj.seteName("Japanese soft roll  garlic bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�j�[�ѥ]");
                mObj.seteName("Garlic bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                               
                alacart = "Dessert ";//���I
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�����_�h�J�|�@������u����");
                mObj.seteName("Sweet taro cheese cake with strawberry yoghurt");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
//                alacart = " ";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen�VDazs �B�N�O");
                mObj.seteName("Haagen�VDazs");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
             mType = "Light bites menu";//    �Ť��p�I
                
                alacart = "�Ť��p�I";//"�覡���";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("����̭a��");
                mObj.seteName("Hakka rice noodle with minced pork and shallot ");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);   
                mainMeal.add(mObj);
                mObj = null;   
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("��������װ_�h����");
                mObj.seteName("Mexico style beef cheese tart");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);   
                mainMeal.add(mObj);
                mObj = null;  
                
             mType = "Breakfast menu";//    ���\���                
                alacart = "Western breakfast";//"�覡���";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���A���G�B�u��B�D��(�Ե�Z�����J�]���۳¬v��  �������L�f�X�C���)�B����ѥ]�����o�ΪG��");
                mObj.seteName("Fresh fruits of the season,\n" +
                        "Yogurt,\n" +
                        "Main course(Baked omelette in spinach bearnaise sauce with sesame parsley potato Parma ham  tomato  broccoli),\n" +
                        "Assorted bread served with butter and jam."); 
                mObj.setDetail("�զR�q(Cereals),�s�C�۶��ѥ](Longan bread mixed with red wine),�i�|(Danish with rum raisin)");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(10);   
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Chinese breakfast";//"�������";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�Τ@���ߡB�p����(��j����γJ  �ʤl�׻�  ������L��  �s�F�����P �гJ)�B�M���B�������I");
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
            mType = "Late night supper";//�d�]�K�\
                alacart = "Salad";//�F��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�ж�F�Ԧ��M���۳���");
                mObj.seteName("Garden salad with sesame dressing");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                            
                alacart = "Main course";//�D��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�Q���׻汲 ������  ���ڽ� �ᷦ�� �f�X");
                mObj.seteName("Pork meat roll with noodle carrots  broccoli  tomato  ");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���N�ĥ��h�Q�� ���f�c���ƥ��o�ζ����� �[������ �ᷦ�� �Q�l");
                mObj.seteName("Roasted sour cream fish with lemon and turmeric rice sauteed shrimp with garlic  broccoli  pine nut");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
//                mObj = new MenuMealTypeObj();
//                mObj.setMealType(mType);
//                mObj.setAlacartType(alacart);
//                mObj.setName("���N�ĥ��h�Q�����Q�l������ �C���ժ��J�ڽ�");
//                mObj.seteName("Grilled chicken thigh with burdock spicy sauce sauteed shrimp with garlic, mixed vegetables and steamed rice");
//                mObj.setClassType(mClassType);              
////                mObj.setQuantity(10);        
//                mainMeal.add(mObj);
//                mObj = null;
                
                alacart = "The bakery";//����ѥ]�����o                              
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�𭻰_�h�ѥ]");
                mObj.seteName("French bread with cheese and fresh basil ");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�馡�n�]");
                mObj.seteName("Japanese soft roll  garlic bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�j�[�ѥ]");
                mObj.seteName("Garlic bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
             mType = "Light bites menu";//    �Ť��p�I                
                alacart = "�Ť��p�I";//"�覡���";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�x�����N������,���p��");
                mObj.seteName("Authentic Taiwanese beef noodle soup Assorted side dishes  ");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);   
                mainMeal.add(mObj);
                mObj = null;    
                
             alacart = "Dessert ";//���I
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�����_�h�J�|�@������u����");
                mObj.seteName("Mashed sweet taro cheese cake with strawberry yoghurt sauce");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
//                alacart = " ";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen�VDazs �B�N�O");
                mObj.seteName("Haagen�VDazs");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
             mType = "Light bites menu";//    �Ť��p�I                
                alacart = "�Ť��p�I";//"�覡���";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�x����̭a��");
                mObj.seteName("Hakka rice noodle with minced pork and shallot");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);   
                mainMeal.add(mObj);
                mObj = null;   
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("��������װ_�h����");
                mObj.seteName("Mexican style beef and cheese tart ");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(10);   
                mainMeal.add(mObj);
                mObj = null;  
                
             mType = "Breakfast menu";//    ���\���                
                alacart = "Western breakfast";//"�覡���";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���A���G�B�u��B�D��(�������L�J�] ���k���Ե楤�o��  �ᷦ�� �v�� �f�X)�B����ѥ]�����o�ΪG��");
                mObj.seteName("Fresh fruits of the season,\n" +
                        "Yogurt,\n" +
                        "Main course(Parma ham omelet with spinach bernaise sauce broccoli potatoes tomato),\n" +
                        "Assorted bread served with butter and jam.");
                mObj.setDetail("�i�|(croissant),�s�C�۶��ѥ](Longan bread fermented with red wine ),�p���R�q( white toast)");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(20);   
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Chinese breakfast";//"�������";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�p����(��j����γJ �ʤl�׻�B���¹L�� �s�F�����P)�B�M���B�������I");
                mObj.seteName(
                		"Assorted delicatessen(�@�@pan-fried eggs with pickled turnip," +
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
            mType = "Lunch menu";//���\���
                alacart = "Appetizer";//�e��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���X�A���L �Q�l �����˰_�h �f�X");
                mObj.seteName("Marinated prawns with eggplant salad pine nuts  parmesan  tomato");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                            
                alacart = "Salad";//�F��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�ж�F�� ���k���o�L��");
                mObj.seteName("Garden salad with French dressing");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Main course";//�D��
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�a�Ĥz���_ۣ ���̶� ���ڽ� �C����");
                mObj.seteName("Steamed scallop and mushroom in black bean sauce with rice carrots  pak choy");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null; 
                                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���a�Q�ǲέ��Τp���� ���ڦ�Q�v�� �f�X �f�c");
                mObj.seteName("Traditional Viennese veal schnitzel with parsley potato tomato  lemon");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���άK���� ������Ĩۣ�P�ɦ̿|  Ī�� �f�X");
                mObj.seteName("Seared chicken breast with mushroom goulash and grilled polenta asparagus  tomato");
                mObj.setClassType(mClassType);              
//                mObj.setQuantity(10);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Assorted bread served with homemade butter";//����ѥ]�����o                              
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���V�q���ѥ]");
                mObj.seteName("Olive ciabatta ");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�����ѥ]");
                mObj.seteName("wholemeal roll");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���[�ѥ]");
                mObj.seteName("garlic bread");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                               
                alacart = "Fresh fruits of the season ";//�A�G
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("���u�`�A�G");
                mObj.seteName("Fresh fruits of the season");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Dessert ";//���I
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�ɮۥ��oī�G��");
                mObj.seteName("Apple strudel with cinnamon cream ");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;                   
                
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("Haagen�VDazs �B�N�O");
                mObj.seteName("Haagen�VDazs");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null;                

                alacart = "����I�� ";//���I
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�������L�e�ʤT���v �P �f�X������԰_�h�T���v");
                mObj.seteName("Petit sandwich of prosciutto with honeydew melon and mozzarella cheese with tomato slice");
                mObj.setClassType(mClassType);              
    //            mObj.setQuantity(5);        
                mainMeal.add(mObj);
                mObj = null; 
                
             mType = "Refreshment";//                  
                alacart = "Western refreshment";//"�覡�K�\";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�ж�F�� ���L�¦i��G�o�B�D��(���A�X��q���ӫ���)�B����ѥ]����u���o�B���u�`�A�G");
                mObj.seteName("Salad:Garden salad with macadamia nut oil,\n" +
                        "Main course(Taglionlini noodles with seafood tomato sauce,black olives  grilled artichoke  asparagus  )\n" +
                        "Assorted bread served with homemade butter\n" +
                        "resh fruits of the season.");
                mObj.setDetail("�k���ѥ](Baguette roll),�ɦ��ѥ](corn roll )");
                mObj.setClassType(mClassType);              
                mObj.setQuantity(10);   
                mainMeal.add(mObj);
                mObj = null;
                
                alacart = "Chinese refreshment";//"�����K�\";
                mObj = new MenuMealTypeObj();
                mObj.setMealType(mType);
                mObj.setAlacartType(alacart);
                mObj.setName("�p����(�a�Ħץ� �[�]���z  ���ڽ������z �D�ժ�樧��)�B�D��(�����פY����  �Ťߵ� ���ڽ�)�B���u�`�A�G");
                mObj.seteName("Assorted delicatessen(minced pork in sweet bean sauce," +
                		"�@�@stir fried Chinese sausage with leek, grilled smoked tofu with carrots,�@�@" +
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
            //check ���.
            for(int i=0;i<saveArr.length;i++){
                SaveMenuFbkRobj fbkObj = (SaveMenuFbkRobj) saveArr[i];
                if ("".equals(fbkObj.getUpdDt())|| "".equals(fbkObj.getUpdUser())){
                    saveReturn.setResultMsg("0");
                    msg += fbkObj.getCardNo()+":��s��/�H,���i����";
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
            
           //��Ƥ����Ť~�R��&�s�W
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
                        //�R����
                        sql = "delete from fztmndetl where series_num in ("+keySql+") ";
                        stmt.executeUpdate(sql); 
    //                    System.out.println("Bitreqd:"+stmt.getUpdateCount());
                    }
                    //�R�D��
                    sql = " delete from fztmnrelt where fltdt = to_date('"+fltd+"','yyyy/mm/dd') and fltno = '"+fltno+"' and sect = '"+sect+"' " +
                          " and trim(upduser) = '"+user+"' ";
                    stmt.executeUpdate(sql); 
    //                System.out.println("fztmnrelt:"+stmt.getUpdateCount());
                    
                    //�s�W
                    for(int i=0; i<saveArr.length;i++){          
                        //���D��
                        SaveMenuFbkRobj fbkObj = (SaveMenuFbkRobj) saveArr[i];
                        //�Ltable key 
                        if(fbkObj.getSeqno()==null || "".equals(fbkObj.getSeqno())){      
                            //��next table key
                            sql = "  select Nvl(max(series_num)+1,'1') seqno from fztmnrelt ";
                            rs = stmt.executeQuery(sql);                          
                           
                            if (rs.next()) {
                                fn = rs.getInt("seqno");
                                
                            }                      
//                            System.out.println(fn);
                            
                            
                            //�s�W�D��
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
                                    //���ƶ�
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
                                msg+="��s����"+countdobj;
                            }else{
                                saveReturn.setResultMsg("1");
                                msg+="���e����,�L�ݧ�s.";
                            }//if(null != saveMvcObj.getDetailAL() && saveMvcObj.getDetailAL().length > 0 ) 
                        }
                        conn.commit();                    
                        saveReturn.setResultMsg("1");
                        msg+="��s�D�����\"+countfbkObj;
                    }//for(int i=0; i<saveAllMVCAL.length;i++)               
                }else{
                    saveReturn.setResultMsg("0");
                    msg+="�D������,�L�k��s.";
                }//if(null != saveAllMVCAL && saveAllMVCAL.length >0)    
            }//if chkfalg
        }catch(Exception e){
            saveReturn.setResultMsg("0");
            msg="��s����"+e.toString()+fn;
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
                msg="meal order��s����"+fn;
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

package ws;

import fz.psfly.isNewCheckForSFLY;

public class ClassType
{

    /**
     * @param args
     */
    private String[] classTypeAr = null;
    public static void main(String[] args)
    {
        // TODO Auto-generated method stub
        ClassType fun = new ClassType();
        fun.getClassTypebyACno("18052");
        

    }
    
    public String getClassTypebyACno(String acno){
        String str = "N";        
        isNewCheckForSFLY a = new isNewCheckForSFLY();
        boolean isNew = a.checkTime("2014/11/30", "");
        //System.out.println(isNew);
        if(("18051".equals(acno) || "18052".equals(acno) || "18053".equals(acno) || "18054".equals(acno) || "18055".equals(acno)) && isNew){
            String[] array = {"C","W","Y"};
            setClassTypeAr(array);
            str= "Y";
        }else if("18206".equals(acno) || "18207".equals(acno) || "18208".equals(acno) || "18210".equals(acno) || "18211".equals(acno) || "18212".equals(acno) || "18215".equals(acno)){
            String[] array = {"F","C","Y"};
            setClassTypeAr(array);
            str= "Y";
        }else{
            String[] array = {"C","Y"};
            setClassTypeAr(array);
            str= "Y";
        }
//        test only
//        String[] array = {"C","W","Y"};
//        setClassTypeAr(array);
        return str ;
    }
    
    public String getClassTypebyFleet(String fleet){
        String str = "N";        
        if("77".equals(fleet.substring(0,2)) ){            
            String[] array = {"C","W","Y"};
            setClassTypeAr(array);
            str= "Y";
        }else if("74".equals(fleet.substring(0,2)) ){
            String[] array = {"F","C","Y"};
            setClassTypeAr(array);
            str= "Y";
        }else{
            String[] array = {"C","Y"};
            setClassTypeAr(array);
            str= "Y";
        }
//        test only
//        String[] array = {"C","W","Y"};
//        setClassTypeAr(array);
        return str ;
    }

    public String[] getClassTypeAr()
    {
        return classTypeAr;
    }

    public void setClassTypeAr(String[] classTypeAr)
    {
        this.classTypeAr = classTypeAr;
    }
}

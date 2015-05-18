package eg.off;

/**
 * @author cs71 Created on  2007/4/12
 */
public class CancelALCheck
{
    public static void main(String[] args)
    {
        CancelALCheck calc = new CancelALCheck("635856","000262_1","2008/02/07","2007/02/07","SYS");
        System.out.println(calc.getALCheckResult());
        System.out.println("Done");
        
//        String str = "2007/11/162007/11/16224107     ";
//        System.out.println(str.substring(0,10));
//        System.out.println(str.substring(10,20));
//        System.out.println(str.substring(20));
    }

    private ALRules arc = null;
    private String empno = "";
    private String deloffno = "";
    private String offsdate = "";
    private String offedate = "";   
    private String chguser = "";    
    private String offtype = ""; 
    
    public CancelALCheck(String empno, String deloffno, String offsdate, String offedate, String chguser)
    {
        this.empno = empno;
        this.deloffno = deloffno;
        this.offsdate = offsdate;
        this.offedate = offedate;
        this.chguser = chguser;
        this.offtype = "0";
        arc = new ALRules(empno, offtype, offsdate, offedate, chguser); 
    }
    
    public CancelALCheck(String empno, String deloffno, String offtype, String offsdate, String offedate, String chguser)
    {
        this.empno = empno;
        this.deloffno = deloffno;
        this.offsdate = offsdate;
        this.offedate = offedate;
        this.chguser = chguser;
        this.offtype = offtype;
        arc = new ALRules(empno, offtype, offsdate, offedate, chguser); 
    }
    
    public String getALCheckResult()
    {  
        String str = "";
//********************************************
//      是否於可遞單期間
        str = arc.isAvailableCancelAL(deloffno);
        if(!"Y".equals(str) && !"X".equals(str))
        {
            return str;
        }
//********************************************     
        return "Y";
    }
}

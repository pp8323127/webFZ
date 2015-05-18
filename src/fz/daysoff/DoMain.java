package fz.daysoff;

/**
 * @author cs71 Created on  2007/8/21
 */
public class DoMain
{

    public static void main(String[] args)
    {
        String str = "";
        DoMain d = new  DoMain();
        str=d.doMain("200708");
        if("Y".equals(str))
        {
            System.out.println("Done");
        }
        else
        {
            System.out.println(str);    
        }
    }
    
    public String doMain(String yyyymm)
    {    
        String str = "";
        DaysOff doff = new DaysOff();
        doff.getOffDays(yyyymm);
        doff.calDupDays(yyyymm);
        str = doff.insDaysOff();       
        doff.updInfo(yyyymm);    
        return str;
    }
}

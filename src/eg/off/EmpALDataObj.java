package eg.off;

/**
 * @author cs71 Created on  2007/8/1
 */
public class EmpALDataObj
{
    private String empno = "";
    private String basedate = "";
    private int nextyear = 0; // �i���Ѽ�
    private int thisyear = 0; // �i���Ѽ�
    private int lastyear = 0; // �i���Ѽ�
    private int nextdaysused = 0;//�v�����Ѽ�
    private int thisdaysused = 0;//�v�����Ѽ� 
    private int lastdaysused = 0;//�v�����Ѽ�
    private String nextyearstartdate = "";//���ĤѼư_��
    private String nextyearenddate = "";//���ĤѼư_�W��
    private String thisyearstartdate = "";//���ĤѼư_��
    private String thisyearenddate = "";//���ĤѼư_�W��
    private String lastyearstartdate = "";//���ĤѼư_��
    private String lastyearenddate = "";//���ĤѼư_�W��
    private int lastyearundeduct =0;//�������Ѽ�
    private int thisyearundeduct =0;//�������Ѽ�
    private int nextyearundeduct =0;//�������Ѽ�
    private int lastyearthisform =0;//�����������w�����Ѽ�
    private int thisyearthisform =0;//�����������w�����Ѽ�
    private int nextyearthisform =0;//�����������w�����Ѽ�
    
    public String getEmpno()
    {
        return empno;
    }
    public void setEmpno(String empno)
    {
        this.empno = empno;
    }
       
    public String getBasedate()
    {
        return basedate;
    }
    public void setBasedate(String basedate)
    {
        this.basedate = basedate;
    }
    public int getLastdaysused()
    {
        return lastdaysused;
    }
    public void setLastdaysused(int lastdaysused)
    {
        this.lastdaysused = lastdaysused;
    }
    public int getLastyear()
    {
        return lastyear;
    }
    public void setLastyear(int lastyear)
    {
        this.lastyear = lastyear;
    }
    public String getLastyearenddate()
    {
        return lastyearenddate;
    }
    public void setLastyearenddate(String lastyearenddate)
    {
        this.lastyearenddate = lastyearenddate;
    }
    public String getLastyearstartdate()
    {
        return lastyearstartdate;
    }
    public void setLastyearstartdate(String lastyearstartdate)
    {
        this.lastyearstartdate = lastyearstartdate;
    }
    public int getNextdaysused()
    {
        return nextdaysused;
    }
    public void setNextdaysused(int nextdaysused)
    {
        this.nextdaysused = nextdaysused;
    }
    public int getNextyear()
    {
        return nextyear;
    }
    public void setNextyear(int nextyear)
    {
        this.nextyear = nextyear;
    }
    public String getNextyearenddate()
    {
        return nextyearenddate;
    }
    public void setNextyearenddate(String nextyearenddate)
    {
        this.nextyearenddate = nextyearenddate;
    }
    public String getNextyearstartdate()
    {
        return nextyearstartdate;
    }
    public void setNextyearstartdate(String nextyearstartdate)
    {
        this.nextyearstartdate = nextyearstartdate;
    }
    public int getThisdaysused()
    {
        return thisdaysused;
    }
    public void setThisdaysused(int thisdaysused)
    {
        this.thisdaysused = thisdaysused;
    }
    public int getThisyear()
    {
        return thisyear;
    }
    public void setThisyear(int thisyear)
    {
        this.thisyear = thisyear;
    }
    public String getThisyearenddate()
    {
        return thisyearenddate;
    }
    public void setThisyearenddate(String thisyearenddate)
    {
        this.thisyearenddate = thisyearenddate;
    }
    public String getThisyearstartdate()
    {
        return thisyearstartdate;
    }
    public void setThisyearstartdate(String thisyearstartdate)
    {
        this.thisyearstartdate = thisyearstartdate;
    }
    public int getLastyearthisform()
    {
        return lastyearthisform;
    }
    public void setLastyearthisform(int lastyearthisform)
    {
        this.lastyearthisform = lastyearthisform;
    }
    public int getLastyearundeduct()
    {
        return lastyearundeduct;
    }
    public void setLastyearundeduct(int lastyearundeduct)
    {
        this.lastyearundeduct = lastyearundeduct;
    }
    public int getNextyearthisform()
    {
        return nextyearthisform;
    }
    public void setNextyearthisform(int nextyearthisform)
    {
        this.nextyearthisform = nextyearthisform;
    }
    public int getNextyearundeduct()
    {
        return nextyearundeduct;
    }
    public void setNextyearundeduct(int nextyearundeduct)
    {
        this.nextyearundeduct = nextyearundeduct;
    }
    public int getThisyearthisform()
    {
        return thisyearthisform;
    }
    public void setThisyearthisform(int thisyearthisform)
    {
        this.thisyearthisform = thisyearthisform;
    }
    public int getThisyearundeduct()
    {
        return thisyearundeduct;
    }
    public void setThisyearundeduct(int thisyearundeduct)
    {
        this.thisyearundeduct = thisyearundeduct;
    }
}

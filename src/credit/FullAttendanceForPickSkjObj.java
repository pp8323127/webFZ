package credit;

/**
 * CleanMonthObj 全勤基準月份物件
 * 
 * 
 * @author cs66
 * @version 1.0 2008/3/9
 * 
 * Copyright: Copyright (c) 2008
 */
public class FullAttendanceForPickSkjObj
{
    private String empno="";
    private String check_range_start="";
	private String check_range_end="";
	private String check_range_final_end="";
	private String clean_working_date_start="";// 計算全勤基準起始日期
	private String clean_working_date_end="";// 計算全勤基準結束日期
	private String temp_working_date_start = "";
	private String temp_working_date_end = "";
	private String temp_susp_date_start = "";
	private String temp_susp_date_end = "";
	private int temp_working_days = 0;
	private int temp_susp_days = 0;
	private String returnstr = "Y";
	private String comments = "";
	
    public String getEmpno()
    {
        return empno;
    }
    public void setEmpno(String empno)
    {
        this.empno = empno;
    }
    public String getCheck_range_end()
    {
        return check_range_end;
    }
    public void setCheck_range_end(String check_range_end)
    {
        this.check_range_end = check_range_end;
    }
    public String getCheck_range_start()
    {
        return check_range_start;
    }
    public void setCheck_range_start(String check_range_start)
    {
        this.check_range_start = check_range_start;
    }
    public String getClean_working_date_end()
    {
        return clean_working_date_end;
    }
    public void setClean_working_date_end(String clean_working_date_end)
    {
        this.clean_working_date_end = clean_working_date_end;
    }
    public String getClean_working_date_start()
    {
        return clean_working_date_start;
    }
    public void setClean_working_date_start(String clean_working_date_start)
    {
        this.clean_working_date_start = clean_working_date_start;
    }
    public String getTemp_susp_date_start()
    {
        return temp_susp_date_start;
    }
    public void setTemp_susp_date_start(String temp_susp_date_start)
    {
        this.temp_susp_date_start = temp_susp_date_start;
    }
    public String getTemp_working_date_end()
    {
        return temp_working_date_end;
    }
    public void setTemp_working_date_end(String temp_working_date_end)
    {
        this.temp_working_date_end = temp_working_date_end;
    }
    public String getTemp_working_date_start()
    {
        return temp_working_date_start;
    }
    public void setTemp_working_date_start(String temp_working_date_start)
    {
        this.temp_working_date_start = temp_working_date_start;
    }
    public int getTemp_working_days()
    {
        return temp_working_days;
    }
    public void setTemp_working_days(int temp_working_days)
    {
        this.temp_working_days = temp_working_days;
    }
    public String getTemp_susp_date_end()
    {
        return temp_susp_date_end;
    }
    public void setTemp_susp_date_end(String temp_susp_date_end)
    {
        this.temp_susp_date_end = temp_susp_date_end;
    }
    public int getTemp_susp_days()
    {
        return temp_susp_days;
    }
    public void setTemp_susp_days(int temp_susp_days)
    {
        this.temp_susp_days = temp_susp_days;
    }
    public String getCheck_range_final_end()
    {
        return check_range_final_end;
    }
    public void setCheck_range_final_end(String check_range_final_end)
    {
        this.check_range_final_end = check_range_final_end;
    }
    public String getReturnstr()
    {
        return returnstr;
    }
    public void setReturnstr(String returnstr)
    {
        this.returnstr = returnstr;
    }
    public String getComments()
    {
        return comments;
    }
    public void setComments(String comments)
    {
        this.comments = comments;
    }
}

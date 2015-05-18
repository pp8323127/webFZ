package ftdp;

public class ftdpObj2
{

    /**
     * @param args
     */
    public static void main(String[] args)
    {
        // TODO Auto-generated method stub

    }
       

    private String staff_num ="";
    private String sern ="";
    private String cname ="";
    private String grp ="";
    private String rank ="";
    private String base = "";   
    private String cal_dt ="";
    private String cal_sdate ="";
    private String cal_edate ="";
    private String ft ="0";//flt time
    private String dp ="0";//duty period  include ground duty
    private String fdp ="0";//flt duty period
    private String rp ="0";//rest period
    private String credit = "0";
    private String lo = "0";
    private String ft_mins ="0";//flt time
    private String dp_mins ="0";//duty period  include ground duty
    private String fdp_mins ="0";//flt duty period
    private String rp_mins ="0";//rest period
    private String credit_mins = "0";
    
    private String ft2_mins ="0";//flt time
    private String dp2_mins ="0";//duty period  include ground duty
    private String fdp2_mins ="0";//flt duty period
    private String rp2_mins ="0";//rest period
    private String lo_mins = "0";
    private String adjust_mins = "0";//提早併車分鐘
    private String act_total_dead_head_mins ="0";
    private String act_home_stby_mins ="0";
    private String series_num ="";
    private String tod_start_loc_ds ="";
    private String port_a ="";
    private String port_b ="";
    private String dps_duty_cd ="";
    private String flt_num ="";
    private String duty_seq_num ="";
    private String item_seq_num ="";
    private String skj_sd ="";
    private String act_sd ="";
    private String act_ed ="";
    private String act_rpt ="";
    private String act_rls ="";
    private String overnight_ind ="";
    private String r_duty_cd ="";
    private String check_dp = "";
    private String check_ft = "";
    
    
    public String getCheck_dp()
    {
        return check_dp;
    }
    public String getCheck_ft()
    {
        return check_ft;
    }
    public void setCheck_dp(String check_dp)
    {
        this.check_dp = check_dp;
    }
    public void setCheck_ft(String check_ft)
    {
        this.check_ft = check_ft;
    }
    public String getFt2_mins()
    {
        return ft2_mins;
    }
    public String getDp2_mins()
    {
        return dp2_mins;
    }
    public String getFdp2_mins()
    {
        return fdp2_mins;
    }
    public String getRp2_mins()
    {
        return rp2_mins;
    }
    public String getSeries_num()
    {
        return series_num;
    }
    public String getTod_start_loc_ds()
    {
        return tod_start_loc_ds;
    }
    public String getPort_a()
    {
        return port_a;
    }
    public String getPort_b()
    {
        return port_b;
    }
    public String getDps_duty_cd()
    {
        return dps_duty_cd;
    }
    public String getFlt_num()
    {
        return flt_num;
    }
    public String getDuty_seq_num()
    {
        return duty_seq_num;
    }
    public String getItem_seq_num()
    {
        return item_seq_num;
    }
    public String getSkj_sd()
    {
        return skj_sd;
    }
    public String getAct_sd()
    {
        return act_sd;
    }
    public String getAct_ed()
    {
        return act_ed;
    }
    public String getAct_rpt()
    {
        return act_rpt;
    }
    public String getAct_rls()
    {
        return act_rls;
    }
    public String getOvernight_ind()
    {
        return overnight_ind;
    }
    public String getR_duty_cd()
    {
        return r_duty_cd;
    }
    public void setFt2_mins(String ft2_mins)
    {
        this.ft2_mins = ft2_mins;
    }
    public void setDp2_mins(String dp2_mins)
    {
        this.dp2_mins = dp2_mins;
    }
    public void setFdp2_mins(String fdp2_mins)
    {
        this.fdp2_mins = fdp2_mins;
    }
    public void setRp2_mins(String rp2_mins)
    {
        this.rp2_mins = rp2_mins;
    }
    public void setSeries_num(String series_num)
    {
        this.series_num = series_num;
    }
    public void setTod_start_loc_ds(String tod_start_loc_ds)
    {
        this.tod_start_loc_ds = tod_start_loc_ds;
    }
    public void setPort_a(String port_a)
    {
        this.port_a = port_a;
    }
    public void setPort_b(String port_b)
    {
        this.port_b = port_b;
    }
    public void setDps_duty_cd(String dps_duty_cd)
    {
        this.dps_duty_cd = dps_duty_cd;
    }
    public void setFlt_num(String flt_num)
    {
        this.flt_num = flt_num;
    }
    public void setDuty_seq_num(String duty_seq_num)
    {
        this.duty_seq_num = duty_seq_num;
    }
    public void setItem_seq_num(String item_seq_num)
    {
        this.item_seq_num = item_seq_num;
    }
    public void setSkj_sd(String skj_sd)
    {
        this.skj_sd = skj_sd;
    }
    public void setAct_sd(String act_sd)
    {
        this.act_sd = act_sd;
    }
    public void setAct_ed(String act_ed)
    {
        this.act_ed = act_ed;
    }
    public void setAct_rpt(String act_rpt)
    {
        this.act_rpt = act_rpt;
    }
    public void setAct_rls(String act_rls)
    {
        this.act_rls = act_rls;
    }
    public void setOvernight_ind(String overnight_ind)
    {
        this.overnight_ind = overnight_ind;
    }
    public void setR_duty_cd(String r_duty_cd)
    {
        this.r_duty_cd = r_duty_cd;
    }
    public String getAct_total_dead_head_mins()
    {
        return act_total_dead_head_mins;
    }
    public String getAct_home_stby_mins()
    {
        return act_home_stby_mins;
    }
    public void setAct_total_dead_head_mins(String act_total_dead_head_mins)
    {
        this.act_total_dead_head_mins = act_total_dead_head_mins;
    }
    public void setAct_home_stby_mins(String act_home_stby_mins)
    {
        this.act_home_stby_mins = act_home_stby_mins;
    }
    public String getStaff_num()
    {
        return staff_num;
    }
    public String getSern()
    {
        return sern;
    }
    public String getCname()
    {
        return cname;
    }
    public String getGrp()
    {
        return grp;
    }
    public String getRank()
    {
        return rank;
    }
    public String getBase()
    {
        return base;
    }
    public String getCal_dt()
    {
        return cal_dt;
    }
    public String getCal_sdate()
    {
        return cal_sdate;
    }
    public String getCal_edate()
    {
        return cal_edate;
    }
    public String getFt()
    {
        return ft;
    }
    public String getDp()
    {
        return dp;
    }
    public String getFdp()
    {
        return fdp;
    }
    public String getRp()
    {
        return rp;
    }
    public String getCredit()
    {
        return credit;
    }
    public String getLo()
    {
        return lo;
    }
    public String getFt_mins()
    {
        return ft_mins;
    }
    public String getDp_mins()
    {
        return dp_mins;
    }
    public String getFdp_mins()
    {
        return fdp_mins;
    }
    public String getRp_mins()
    {
        return rp_mins;
    }
    public String getCredit_mins()
    {
        return credit_mins;
    }
    public String getLo_mins()
    {
        return lo_mins;
    }
    public String getAdjust_mins()
    {
        return adjust_mins;
    }
    public void setStaff_num(String staff_num)
    {
        this.staff_num = staff_num;
    }
    public void setSern(String sern)
    {
        this.sern = sern;
    }
    public void setCname(String cname)
    {
        this.cname = cname;
    }
    public void setGrp(String grp)
    {
        this.grp = grp;
    }
    public void setRank(String rank)
    {
        this.rank = rank;
    }
    public void setBase(String base)
    {
        this.base = base;
    }
    public void setCal_dt(String cal_dt)
    {
        this.cal_dt = cal_dt;
    }
    public void setCal_sdate(String cal_sdate)
    {
        this.cal_sdate = cal_sdate;
    }
    public void setCal_edate(String cal_edate)
    {
        this.cal_edate = cal_edate;
    }
    public void setFt(String ft)
    {
        this.ft = ft;
    }
    public void setDp(String dp)
    {
        this.dp = dp;
    }
    public void setFdp(String fdp)
    {
        this.fdp = fdp;
    }
    public void setRp(String rp)
    {
        this.rp = rp;
    }
    public void setCredit(String credit)
    {
        this.credit = credit;
    }
    public void setLo(String lo)
    {
        this.lo = lo;
    }
    public void setFt_mins(String ft_mins)
    {
        this.ft_mins = ft_mins;
    }
    public void setDp_mins(String dp_mins)
    {
        this.dp_mins = dp_mins;
    }
    public void setFdp_mins(String fdp_mins)
    {
        this.fdp_mins = fdp_mins;
    }
    public void setRp_mins(String rp_mins)
    {
        this.rp_mins = rp_mins;
    }
    public void setCredit_mins(String credit_mins)
    {
        this.credit_mins = credit_mins;
    }
    public void setLo_mins(String lo_mins)
    {
        this.lo_mins = lo_mins;
    }
    public void setAdjust_mins(String adjust_mins)
    {
        this.adjust_mins = adjust_mins;
    }
}

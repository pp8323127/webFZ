package credit;

import java.util.*;

/**
 * @author CS71 Created on  2012/5/25
 */
public class EPickSkjObj
{
    private  String seq    			= "";
    private  String fltd           	= "";
    private  String weekday        	= "";
    private  String fltno          	= "";
    private  String trip_sect      	= "";
    private  String flt_length     	= "";  
    private  String fleet          	= "";
    private  String longrange		= "";
    private  String station        	= "";
    private  String published      	= "";
    private  String published_date 	= "";
    private  String new_user       	= "";
    private  String new_date       	= "";
    private  String delete_flag    	= "";
    private  String delete_user    	= "";
    private  String delete_date    	= "";
    private  String chg_user       	= "";
    private  String chg_date       	= "";
    private  String pr             	= "";   
    private  String ff             	= "";    
    private  String fy             	= "";
    private  String fc             	= "";   
    private  String my             	= "";    
    private  String pr_used         = "";   
    private  String ff_used         = "";    
    private  String fy_used         = "";
    private  String fc_used         = "";   
    private  String my_used         = "";
    
    private  ArrayList detailAL = new ArrayList();    
    
    public String getFc_used()
    {
        return fc_used;
    }
    public void setFc_used(String fc_used)
    {
        this.fc_used = fc_used;
    }
    public String getFf_used()
    {
        return ff_used;
    }
    public void setFf_used(String ff_used)
    {
        this.ff_used = ff_used;
    }
    public String getFy_used()
    {
        return fy_used;
    }
    public void setFy_used(String fy_used)
    {
        this.fy_used = fy_used;
    }
    public String getMy_used()
    {
        return my_used;
    }
    public void setMy_used(String my_used)
    {
        this.my_used = my_used;
    }
    public String getPr_used()
    {
        return pr_used;
    }
    public void setPr_used(String pr_used)
    {
        this.pr_used = pr_used;
    }
    public String getLongrange()
    {
        return longrange;
    }
    public void setLongrange(String longrange)
    {
        this.longrange = longrange;
    }
    public String getMy()
    {
        return my;
    }
    public void setMy(String my)
    {
        this.my = my;
    }
    
    public ArrayList getDetailAL()
    {
        return detailAL;
    }
    public void setDetailAL(ArrayList detailAL)
    {
        this.detailAL = detailAL;
    }
    public String getWeekday()
    {
        return weekday;
    }
    public void setWeekday(String weekday)
    {
        this.weekday = weekday;
    }
    public String getChg_date()
    {
        return chg_date;
    }
    public void setChg_date(String chg_date)
    {
        this.chg_date = chg_date;
    }
    public String getChg_user()
    {
        return chg_user;
    }
    public void setChg_user(String chg_user)
    {
        this.chg_user = chg_user;
    }
    public String getDelete_date()
    {
        return delete_date;
    }
    public void setDelete_date(String delete_date)
    {
        this.delete_date = delete_date;
    }
    public String getDelete_flag()
    {
        return delete_flag;
    }
    public void setDelete_flag(String delete_flag)
    {
        this.delete_flag = delete_flag;
    }
    public String getDelete_user()
    {
        return delete_user;
    }
    public void setDelete_user(String delete_user)
    {
        this.delete_user = delete_user;
    }
   
    public String getFc()
    {
        return fc;
    }
    public void setFc(String fc)
    {
        this.fc = fc;
    }
    public String getFf()
    {
        return ff;
    }
    public void setFf(String ff)
    {
        this.ff = ff;
    }
    public String getFleet()
    {
        return fleet;
    }
    public void setFleet(String fleet)
    {
        this.fleet = fleet;
    }
    public String getFlt_length()
    {
        return flt_length;
    }
    public void setFlt_length(String flt_length)
    {
        this.flt_length = flt_length;
    }
    public String getFltd()
    {
        return fltd;
    }
    public void setFltd(String fltd)
    {
        this.fltd = fltd;
    }
    public String getFltno()
    {
        return fltno;
    }
    public void setFltno(String fltno)
    {
        this.fltno = fltno;
    }
    public String getFy()
    {
        return fy;
    }
    public void setFy(String fy)
    {
        this.fy = fy;
    }
    public String getNew_date()
    {
        return new_date;
    }
    public void setNew_date(String new_date)
    {
        this.new_date = new_date;
    }
    public String getNew_user()
    {
        return new_user;
    }
    public void setNew_user(String new_user)
    {
        this.new_user = new_user;
    }
    public String getPr()
    {
        return pr;
    }
    public void setPr(String pr)
    {
        this.pr = pr;
    }
    public String getPublished()
    {
        return published;
    }
    public void setPublished(String published)
    {
        this.published = published;
    }
    public String getPublished_date()
    {
        return published_date;
    }
    public void setPublished_date(String published_date)
    {
        this.published_date = published_date;
    }
    public String getSeq()
    {
        return seq;
    }
    public void setSeq(String seq)
    {
        this.seq = seq;
    }
    public String getStation()
    {
        return station;
    }
    public void setStation(String station)
    {
        this.station = station;
    }
    public String getTrip_sect()
    {
        return trip_sect;
    }
    public void setTrip_sect(String trip_sect)
    {
        this.trip_sect = trip_sect;
    }
   
}

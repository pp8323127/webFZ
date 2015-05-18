package crewhr;

import java.sql.*;
import java.util.*;
import java.io.*;

public class da13UtcTime
{
    Statement stmt = null;
    ResultSet myResultSet = null;
    Connection con = null;
    
    public float[] getDa13Atdu(String[] fdate, String[] fltno, String[] dpt) throws Exception
    {
        String sql = "";
        float[] blkhr = new float[fdate.length];
		int ad_hh = 0;
		int ad_mm = 0;
		int aa_hh = 0;
		int aa_mm = 0;
		int blk_hh = 0;
		int blk_mm = 0;
        
        try{
        //connect AOCIPROD
        Class.forName("oracle.jdbc.driver.OracleDriver");
        con = DriverManager.getConnection("jdbc:oracle:thin:@192.168.242.41:1521:AOCIPROD","jzdba","jzdba");
        stmt = con.createStatement();
        for(int i=0; i<fdate.length; i++)
        {
                if (fdate[i]==null)
                {
                        i = 99; //fdate[] max length is 30
                }
                else
                {
                        if(fltno[i].length()<4){fltno[i]="0"+fltno[i];}
                        /*sql = "select NVL(to_char(da13_atdu,'HH24'),'0') ad_hh, NVL(to_char(da13_atdu,'MI'),'0') ad_mm, "+
						"NVL(to_char(da13_atau,'HH24'),'0') aa_hh, NVL(to_char(da13_atau,'MI'),'0') aa_mm "+
						"from v_ittda13_ci "+
                        "where da13_scdate='"+fdate[i].substring(2)+"' and da13_fltno='"+fltno[i]+"' and da13_fm_sector='"+dpt[i]+"'";*/
                        sql = "select NVL(to_char(da13_atdu,'HH24'),'0') ad_hh, NVL(to_char(da13_atdu,'MI'),'0') ad_mm, "+
						"NVL(to_char(da13_atau,'HH24'),'0') aa_hh, NVL(to_char(da13_atau,'MI'),'0') aa_mm "+
						"from v_ittda13_ci "+
                        "where to_char(da13_etdu,'yyyymmdd')='"+fdate[i]+"' and da13_fltno='"+fltno[i]+"' and da13_fm_sector='"+dpt[i]+"'";
                        myResultSet = stmt.executeQuery(sql);
                        if (myResultSet.next())
                        {
							ad_hh = myResultSet.getInt("ad_hh");
							ad_mm = myResultSet.getInt("ad_mm");
							aa_hh = myResultSet.getInt("aa_hh");
							aa_mm = myResultSet.getInt("aa_mm");
							if((ad_hh == 0 && ad_mm == 0) || (aa_hh == 0 && aa_mm == 0))
							{
							        blk_hh = 0;
							        blk_mm = 0;
							}
							else
							{
        							if((aa_hh - ad_hh) < 0)
        							{
        								blk_hh = 24 - ad_hh + aa_hh;
        							}
        							else
        							{
        								blk_hh = aa_hh - ad_hh;
        							}
        							if((aa_mm - ad_mm) < 0)
        							{
        								blk_mm = aa_mm + 60 - ad_mm;
        								blk_hh = blk_hh - 1;
        							}
        							else
        							{
        								blk_mm = aa_mm - ad_mm;
        							}
						        }
                            blkhr[i] = (blk_hh * 60) + blk_mm;
                        }
                }
        }
        return blkhr;//da13_atau - da13_atdu ╓юда ext:10:18 --> 618mm
        } catch(Exception e) {
        	e.printStackTrace();
        	blkhr[0] = -1;
        	return blkhr;
        }
        finally
        {
           myResultSet.close();
           stmt.close();
           con.close();
           myResultSet = null;
           stmt = null;
           con = null;
        }
    }
}
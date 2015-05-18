package eg.CrewEval;

import java.sql.*;
import java.util.*;
import ci.db.*;

/**
 * @author CS71 Created on  2012/10/2
 * cs80 20140411 add sern
 */
public class InqueryCrewEval
{

    public static void main(String[] args)
    {
        InqueryCrewEval ice = new InqueryCrewEval();
        ice.getCrewEvalList("2012","635863");
        ArrayList objAL = new ArrayList();
        objAL = ice.getObjAL();
        for(int i=0; i<objAL.size(); i++)
        {
            InqueryCrewEvalObj obj = (InqueryCrewEvalObj) objAL.get(i);
            System.out.print(obj.getEmpno()+" * "+obj.getSern()+" * "+obj.getYyyy()+"/"+obj.getMm()+" * "+obj.getIndividual_avg()+" * "+obj.getIndividual_seq()+" * "+obj.getBase_total()+" * "+obj.getBase_avg());
            System.out.println("");
        }
    }
    
    private String sql = null;
	private String returnstr = "";
	ArrayList objAL = new ArrayList();
    
	public void getCrewEvalList(String gdyear, String empno) 
    {        
	    Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        String crew_base = "";
        
        try 
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
			stmt = conn.createStatement();	

    		
    		sql = " SELECT to_char(score_month,'yyyy') score_year, to_char(score_month,'mm') score_mm, " +
    			  " empno, sern, trip_cnt, total_score, avg_score, sort_seq, base FROM egtscore " +
    			  " WHERE ( empno = '"+empno+"'  or sern  = '"+empno+"'  ) and score_month BETWEEN To_Date('"+Integer.toString(Integer.parseInt(gdyear)-1)+"1101','yyyymmdd') " +
    			  " AND To_Date('"+gdyear+"1031','yyyymmdd') order by  score_month";
//System.out.println(sql);
    		rs = stmt.executeQuery(sql);      		 		
    		
    		 while (rs.next()) 
             {
    		     InqueryCrewEvalObj obj = new InqueryCrewEvalObj();
    		     obj.setYyyy(rs.getString("score_year"));
    		     obj.setMm(rs.getString("score_mm"));
    		     obj.setEmpno(rs.getString("empno"));
    		     obj.setSern(rs.getString("sern"));
    		     obj.setBase(rs.getString("base"));
    		     crew_base = rs.getString("base");
    		     obj.setIndividual_avg(rs.getString("avg_score"));
    		     obj.setIndividual_seq(rs.getString("sort_seq"));
    		     objAL.add(obj);    		    
    		 } 
    		 
    		 rs.close();
    		 
    		 sql = " SELECT to_char(score_month,'yyyy') score_year, to_char(score_month,'mm') score_mm, " +
    		 	   " Count(*) c, Round(Avg(total_score/trip_cnt),'2') a FROM egtscore " +
    		 	   " WHERE score_month BETWEEN To_Date('"+Integer.toString(Integer.parseInt(gdyear)-1)+"1101','yyyymmdd') " +
    			   " AND To_Date('"+gdyear+"1031','yyyymmdd') AND base ='"+crew_base+"' GROUP BY score_month";
//System.out.println(sql);
     		rs = stmt.executeQuery(sql);        
     		while (rs.next()) 
            {
     		    for(int i=0; i<objAL.size(); i++)
     		    {
     		       InqueryCrewEvalObj obj = (InqueryCrewEvalObj) objAL.get(i);
     		       if(rs.getString("score_year").equals(obj.getYyyy()) && rs.getString("score_mm").equals(obj.getMm()))
     		       {
     		          obj.setBase_total(rs.getString("c"));
         		      obj.setBase_avg(rs.getString("a"));
     		       }     		        
     		    }            
            }
        }
        catch (Exception e)
        {
            System.out.println(e.toString());
        }
        finally
        {
            try{if(rs != null) rs.close();}catch (Exception e){}
        	try{if(stmt != null) stmt.close();}catch (Exception e){}
        	try{if(conn != null) conn.close();}catch (Exception e){}        	
        }
    }   
		
    public ArrayList getObjAL()
    {
        return objAL;
    }
    public void setObjAL(ArrayList objAL)
    {
        this.objAL = objAL;
    }
    public String getReturnstr()
    {
        return returnstr;
    }
    public void setReturnstr(String returnstr)
    {
        this.returnstr = returnstr;
    }
    public String getSql()
    {
        return sql;
    }
    public void setSql(String sql)
    {
        this.sql = sql;
    }
}



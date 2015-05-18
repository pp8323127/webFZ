package eg.off;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * @author cs71 Created on 2007/4/4
 */
public class OffRecordList
{    
    private ArrayList objAL = null;
    private ArrayList objCountAL = null;
    private String errorstr = "";
    private String sql = "";
    

    public static void main(String[] args)
    {
        OffRecordList orl = new OffRecordList();

//        orl.getOffRecord("635856","0","2008");
//        orl.getOffRecord("635863", "offyear", "2008", "", "TPE");
//        System.out.println(orl.getObjAL().size());    
//        System.out.println(orl.getALUndeduct("635856"));
//        orl.getRatifyOffSheet("","","U","","TPE");
//        orl.getHandleOffSheet("","","TPE");
        System.out.println("Done");
    }

    // get empno's off record
    //offtype --> AL or ALL
    // for crew
    public void getOffRecord(String empno, String offcode, String offyear)
    {
        Driver dbDriver = null;
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        objAL = new ArrayList();
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
	        conn = ch.getConnection();
            
//	        EGConnDB cn = new EGConnDB();
//            cn.setORP3EGUserCP(); 
//	    	java.lang.Class.forName(cn.getDriver());
//	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());   
	        
//	        EGConnDB cn = new EGConnDB();
//	    	cn.setORP3EGUser();   
//	    	java.lang.Class.forName(cn.getDriver());
//	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());	    	
           
            stmt = conn.createStatement();

            //******************************************************************************
            if("ALL".equals(offcode))
            {
                sql = " SELECT trim(offno) offno,trim(empn) empn,sern,offtype,To_Char(offsdate,'yyyy/mm/dd') offsdate, " +
                	  " To_Char(offedate,'yyyy/mm/dd') offedate, offdays,offftno,station,remark,offyear," +
                	  " gradeyear,newuser,to_Char(newdate, 'yyyy/mm/dd hh24:mi:ss') newdate, " +
                	  " chguser,to_Char(chgdate, 'yyyy/mm/dd hh24:mi:ss') chgdate, form_num,leaverank," +
                	  " reassign, ef_judge_status, ef_judge_user," +
                	  " to_Char(ef_judge_tmst, 'yyyy/mm/dd hh24:mi:ss') ef_judge_tmst, ed_inform_user," +
                	  " to_Char(ed_inform_tmst, 'yyyy/mm/dd hh24:mi:ss') ed_inform_tmst, doc_status, " +
                	  " delete_user, to_Char(delete_tmst, 'yyyy/mm/dd hh24:mi:ss') delete_tmst, " +
                	  " to_Char(occur_date, 'yyyy/mm/dd') occurdate, o.relation relationid, f.relation relation " +
                	  " FROM egtoffs o, egtfldy f " +
                	  " WHERE empn = '"+empno+"' and offyear = '"+offyear+"' and o.relation = f.flid (+) " +
                	  " order by offsdate desc ";
            }
            else
            {
                sql = " SELECT trim(offno) offno,trim(empn) empn,sern,offtype,To_Char(offsdate,'yyyy/mm/dd') offsdate, " +
                	  " To_Char(offedate,'yyyy/mm/dd') offedate, offdays,offftno,station,remark,offyear," +
                	  " gradeyear,newuser,to_Char(newdate, 'yyyy/mm/dd hh24:mi:ss') newdate, " +
                	  " chguser,to_Char(chgdate, 'yyyy/mm/dd hh24:mi:ss') chgdate, form_num,leaverank," +
                	  " reassign, ef_judge_status, ef_judge_user," +
                	  " to_Char(ef_judge_tmst, 'yyyy/mm/dd hh24:mi:ss') ef_judge_tmst, ed_inform_user," +
                	  " to_Char(ed_inform_tmst, 'yyyy/mm/dd hh24:mi:ss') ed_inform_tmst, doc_status, " +
                	  " delete_user, to_Char(delete_tmst, 'yyyy/mm/dd hh24:mi:ss') delete_tmst, " +
                	  " to_Char(occur_date, 'yyyy/mm/dd') occurdate, o.relation relationid, f.relation relation " +
                	  " FROM egtoffs o, egtfldy f " +
                	  " WHERE empn = '"+empno+"' " +
		          	  " and offtype = '"+offcode+"' and offyear = '"+offyear+"' and o.relation = f.flid (+) " +
		          	  " order by offsdate desc ";                
            }

//            System.out.println(sql);
            rs = stmt.executeQuery(sql);

            while (rs.next())
            {
                OffsObj obj = new OffsObj();      
                obj.setOffno(rs.getString("offno"));
                obj.setEmpn(rs.getString("empn"));
                obj.setSern(rs.getString("sern"));
                obj.setOfftype(rs.getString("offtype"));
                obj.setOffsdate(rs.getString("offsdate"));
                obj.setOffedate(rs.getString("offedate"));
                obj.setOffdays(rs.getString("offdays"));
                obj.setOffftno(rs.getString("offftno"));
                obj.setStation(rs.getString("station"));
                obj.setRemark(rs.getString("remark"));
                obj.setOffyear(rs.getString("offyear"));
                obj.setGradeyear(rs.getString("gradeyear"));
                obj.setNewuser(rs.getString("newuser"));
                obj.setNewdate(rs.getString("newdate"));
                obj.setChguser(rs.getString("chguser"));
                obj.setChgdate(rs.getString("chgdate"));
                obj.setForm_num(rs.getString("form_num"));
                obj.setRank(rs.getString("leaverank"));
                obj.setReassign(rs.getString("reassign"));
                obj.setEf_judge_status(rs.getString("ef_judge_status"));
                obj.setEf_judge_user(rs.getString("ef_judge_user"));
                obj.setEd_inform_user(rs.getString("ed_inform_user"));
                obj.setEd_inform_tmst(rs.getString("ed_inform_tmst"));
                obj.setDoc_status(rs.getString("doc_status"));
                obj.setDelete_user(rs.getString("delete_user"));
                obj.setDelete_tmst(rs.getString("delete_tmst"));
                obj.setOccur_date(rs.getString("occurdate"));
                obj.setRelation(rs.getString("relation"));
                obj.setRelationid(rs.getString("relationid"));
                objAL.add(obj);
            }
            
            errorstr = "Y";
            //******************************************************************************
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            errorstr = e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                    rs.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }
    }
       
    public int getALUndeduct(String empno)
    {
        Driver dbDriver = null;
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
	        conn = ch.getConnection();
            
//	        EGConnDB cn = new EGConnDB();
//            cn.setORP3EGUserCP(); 
//	    	java.lang.Class.forName(cn.getDriver());
//	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());   
	        
//	        EGConnDB cn = new EGConnDB();
//	    	cn.setORP3EGUser();   
//	    	java.lang.Class.forName(cn.getDriver());
//	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());	 
            stmt = conn.createStatement();

            
            sql = " SELECT Nvl(sum(offdays),0) c FROM egtoffs " +
            	  " WHERE empn = '"+empno+"' and offtype in ('0','15','16') and remark = 'N' ";
            
            rs = stmt.executeQuery(sql);

            if (rs.next())
            {
                return rs.getInt("c");
            }
            else
            {
                return 0;
            }
            //******************************************************************************
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            errorstr = e.toString();
            return 0;
        }
        finally
        {
            try
            {
                if (rs != null)
                    rs.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }
    }
    
    public ArrayList getObjAL()
    {
        return objAL;
    }
    
    public ArrayList getObjCountAL()
    {
        return objCountAL;
    }
    
    public String getStr()
    {
        return errorstr;
    }
    
    public String getSQL()
    {
        return sql;
    }
}
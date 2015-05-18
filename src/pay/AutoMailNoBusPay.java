package pay;

import java.io.*;
import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * @author cs71 Created on  2006/11/29
 */
public class AutoMailNoBusPay
{
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
    String sql = null;
    String sqlstr = "";
    String returnstr = "";
    ConnDB cn = new ConnDB();
    Driver dbDriver = null;
    ArrayList objAL = new ArrayList();
    ArrayList objAL2 = new ArrayList();
    
    private String filename = "";
	private String path 	= "C:\\CIITemp\\";
	StringBuffer str = new StringBuffer();
	FileWriter fw =  null;

    public static void main(String[] args)
    {
        AutoMailNoBusPay s = new AutoMailNoBusPay();
        s.setSrc("2007","07");
        s.getAutoMailFile();
        System.out.println("Done");
    }
    
    public void setSrc(String yyyy, String mm)
    {     
        try 
        {
            fw = new FileWriter(path+yyyy+mm+"_nobus.csv",false);
            
        
          //直接連線 AOCIPROD
          cn.setORP3DFUser();
          java.lang.Class.forName(cn.getDriver());
          con = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() ,
                  cn.getConnPW());
          stmt = con.createStatement();
           
            sql = " SELECT  c.NAME name, c.BOX box, l.EMPNO empno, to_char(l.DPTDATE,'yyyy/mm/dd') dptdate, " +
            	  " l.FLTNO fltno, l.DPT dpt," +
            	  " l.ARV arv, l.CARPAY carpay FROM  DFTCREW c, DFTDALG l " +
            	  " WHERE c.EMPNO(+) = l.EMPNO AND c.CABIN = 'B' " +
            	  " AND Trunc(l.dptdate,'mm') = Trunc(To_Date('"+yyyy+"/"+mm+"/01','yyyy/mm/dd')) " +
            	  " ORDER BY l.EMPNO ASC, l.DPTDATE ASC " ;
      
//		      System.out.println(sql);
		      sqlstr = sql;
		      rs = stmt.executeQuery(sql);		  
		      
		      SrcObj emptyobj1 = new SrcObj();
		      objAL2.add(emptyobj1);
		      while (rs.next()) 
		      {
		          SrcObj obj = new SrcObj();
		          obj.setEmpno(rs.getString("empno"));
		          obj.setAmount(rs.getString("carpay"));
		          obj.setDuty(rs.getString("fltno")+" ("+rs.getString("dpt")+"/"+rs.getString("arv")+")");
		          obj.setDutydate(rs.getString("dptdate"));
		          objAL2.add(obj);
		      }   
		      SrcObj emptyobj = new SrcObj();
		      objAL2.add(emptyobj);
		      System.out.println(objAL2.size());
            
            returnstr = "Y";
        } 
        catch (SQLException e) 
        {
            System.out.print(e.toString());
            returnstr = e.toString();
        } 
        catch (Exception e) 
        {
            System.out.print(e.toString());
            returnstr = e.toString();
        }
        finally 
        {

            if ( rs != null ) try {
                rs.close();
            } catch (SQLException e) {}
            if ( stmt != null ) try {
                stmt.close();
            } catch (SQLException e) {}
            if ( con != null ) try {
                con.close();
            } catch (SQLException e) {}

        }
    }
    
    public void getAutoMailFile()
    {
        int total = 0;
        int count = 0;
        int maxlength = 0;
        int templen =0;
        BankData b = new BankData();  
        try
        {           
	        for(int i=1; i<objAL2.size()-1; i++)
	        {
//	            System.out.println(i);
	            templen ++;
	            SrcObj obj0 = (SrcObj) objAL2.get(i-1);
	            SrcObj obj1 = (SrcObj) objAL2.get(i);
	            SrcObj obj2 = (SrcObj) objAL2.get(i+1);
	            BankDataObj obj = b.getBankDataObj(obj1.getEmpno()) ;
	            
	            if(!obj1.getEmpno().equals(obj0.getEmpno()))
	            {
	                count = 0;
	                str.append(obj1.getEmpno().trim()+","+obj.getName().trim()+",");
	            }
	            str.append(obj1.getDuty()+"("+obj1.getDutydate()+")     $"+obj1.getAmount()+",");
	            count = count + Integer.parseInt(obj1.getAmount());
	            if(!obj1.getEmpno().equals(obj2.getEmpno()))
	            {
	                if(templen>maxlength)
	                {
	                    maxlength = templen;
	                }
	                templen =0;
	                str.append("Total : $"+count);
	                str.append("\r\n");
	                total = total + count;
	            }
	        }
	        System.out.println(maxlength);
//	        System.out.println(str.toString());
	        System.out.println(total);
	        fw.write("EMPNO : ,NAME : ,>,>,>,>,>,>,>,>,>\r\n");
	        fw.write(str.toString());
	        fw.flush();	   
	        fw.close();
    	}
        catch(Exception e)
    	{
            System.out.print(e.toString());
    	}
        finally
        {
    	
        }
    
    
    
    }
}

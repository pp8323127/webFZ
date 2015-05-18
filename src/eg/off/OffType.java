/**
 * @author cs71
 * 【假別選單】<br>
 * 做成.jsp的檔案，用include的方式在網頁中顯示<br>
 * 傳回javascript的陣列字串，及選單的HTML字串<br>
 */
package eg.off;
import java.io.*;
import java.sql.*;
import java.util.*;
import ci.db.*;

public class OffType 
{
	
	public static void main(String[] args) 
	{
	    OffType obj = new OffType();
	    obj.getOffType("C:\\");
	    obj.offData();	   
	    System.out.println(obj.getOffDesc("0").offtype);
	    OffTypeObj thisobj = obj.getOffDesc("0");
	    System.out.println(thisobj.offdesc);
	    System.out.println("Done");
		
	}
	
	private String sql = null;
	private String msg = "";
	private String Item = "";
	FileWriter fw1 = null;
    private ArrayList offobjAL = null;
   
	/**
	 * 傳回 <option value="item">item</option> 形式的String，用於第一層選單的選項
	 */
    
    public void getOffType()
    {}
    
	public void getOffType(String path) 
	{
	    Driver dbDriver = null;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;	
		
		try 
		{
		    ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);		
			
			fw1 = new FileWriter(path+"offtp.html",false);	
//			fw1 = new FileWriter("C:\\offtp.html",false);
			
			sql = "SELECT * FROM egdb.egtofftp WHERE flag = 'Y' order by offtype";
			rs = stmt.executeQuery(sql);

			while(rs.next())
			{
				fw1.write("<option value=\""+rs.getString("offcode")+"\">"+rs.getString("offtype")+" "+rs.getString("offdesc")+"</option>\r\n");
			}
			rs.close();		
			fw1.flush();
			fw1.close();
		} 
		catch (Exception e) 
		{
			System.out.println(e.toString());
		}
		finally
		{
		  	try {if (rs != null)	rs.close();		} catch (SQLException e) {}
			try {if (stmt != null)	stmt.close();	} catch (SQLException e) {}
			try {if (conn != null) 	conn.close();	} catch (SQLException e) {}
		}
	}
	
	public void offData() 
	{
	    Driver dbDriver = null;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try 
		{
		    ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);			    
		    
		    offobjAL = new ArrayList();

			sql = "SELECT offcode, offtype, offdesc FROM egdb.egtofftp WHERE flag = 'Y' ";
			rs = stmt.executeQuery(sql);

			while(rs.next())
			{
			    OffTypeObj obj = new OffTypeObj();
			    obj.offcode = rs.getString("offcode");
			    obj.offtype = rs.getString("offtype");
			    obj.offdesc = rs.getString("offdesc");
			    offobjAL.add(obj);
			}
			rs.close();	
		} 
		catch (Exception e) 
		{
			System.out.println(e.toString());
		}
		finally
		{
		  	try {if (rs != null)	rs.close();		} catch (SQLException e) {}
			try {if (stmt != null)	stmt.close();	} catch (SQLException e) {}
			try {if (conn != null) 	conn.close();	} catch (SQLException e) {}
		}
	}
	
	
	public OffTypeObj getOffDesc (String offcode) 
	{
	    OffTypeObj offobj = null;
	        
	    for(int i=0; i<offobjAL.size(); i++)
	    {
	        OffTypeObj obj = (OffTypeObj) offobjAL.get(i);
	        if(offcode.equals(obj.offcode))
	        {
	            offobj = obj;
	        }
	    }
        
		return offobj;		
	}
	
	public ArrayList getObjAL()
	{
	    return offobjAL;
	}
}


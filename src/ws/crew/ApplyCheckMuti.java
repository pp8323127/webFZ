package ws.crew;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import ci.db.ConnDB;

public class ApplyCheckMuti {

	/**
	 * @param args
	 * 砆传
	 */
	
	private String aEmpno;
	private String[] rEmpno;
	private String year;
	private String month;
	private String limitenddate ="";
	private boolean aLocked = false;
	private boolean rLocked = false;
	private boolean isNoSwap = false;// 琌传痁
	private String noSwapStr = "";//传痁瞶パ
	private String rLockedStr = "";//传痁瞶パ
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}
	public ApplyCheckMuti(String aEmpno, String[] rEmpno, String year, String month) 
	{
		this.aEmpno = aEmpno;
		this.rEmpno = rEmpno;
		this.year = year;
		this.month = month;
	}

	public ApplyCheckMuti() 
	{

	}	
	//TPE & KHH 
	public void swapRulesCheck(String aEmpno, String[] rEmpno, String year, String month) 
	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ConnDB cn = new ConnDB();
		Driver dbDriver = null;
		String sql = "";
		int count = 0;
		String rEmpnoSql = "";
		String temp = "";
		try 
		{
			if(null!=rEmpno && rEmpno.length>0){
				for(int i=0;i<rEmpno.length;i++){
					rEmpnoSql += ",'"+rEmpno[i]+"'";
				}
				
			}
			
			cn.setORP3FZUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

//			 cn.setORT1FZUser();
//			 java.lang.Class.forName(cn.getDriver());
//			 conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());
			
			//琌砆腨窽传痁
			 sql = " SELECT empno, To_Char(eff_dt,'yyyy/mm') eff_dt, To_Char(exp_dt,'yyyy/mm') exp_dt, " +
		 	   " reason FROM fztnoswap " +
		 	   " WHERE empno IN ('"+aEmpno+"' "+rEmpnoSql+") " +
			   " and eff_dt <= To_Date('"+year+month+"01','yyyymmdd') " +
			   " AND exp_dt >= To_Date('"+year+month+"01','yyyymmdd') ";
			pstmt = conn.prepareStatement(sql);
	//System.out.println(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) 
			{
				temp += rs.getString("empno")+" 窽ゎ传痁る From "+rs.getString("eff_dt")+" To "+rs.getString("exp_dt");
			    if(!"".equals(getNoSwapStr()) && getNoSwapStr() != null)
			    {
			        setNoSwap(true);
			    }
			}
			setNoSwapStr(temp);
			pstmt.close();
			rs.close();	
			
			
			/* 痁琌玛﹚ */
			pstmt = conn.prepareStatement("SELECT locked FROM fztcrew WHERE empno IN ('"+aEmpno+"' "+rEmpnoSql+")");
			pstmt.setString(1, aEmpno);
			rs = pstmt.executeQuery();

			while (rs.next()) 
			{
				if ("Y".equals(rs.getString("locked"))) 
				{
					setALocked(true);
				}
			}			

			if(null!=rEmpno && rEmpno.length>0){
				for(int i=0;i<rEmpno.length;i++){
					pstmt.clearParameters();
					pstmt.setString(1, rEmpno[i]);
					rs = pstmt.executeQuery();
		
					while (rs.next()) 
					{
						if ("Y".equals(rs.getString("locked"))) 
						{
							setRLocked(true);
							temp += rs.getString("empno")+",";
						}
					}
					setrLockedStr(temp);
				}
				
			}
			
		} catch (SQLException e) {
			System.out.println(e.toString());
		} catch (ClassNotFoundException e) {
			System.out.println(e.toString());
		} catch (Exception e) {
			System.out.println(e.toString());
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println(e.toString());
				}
				conn = null;
			}
		}
	}
	
	
	

	public boolean isALocked() {
		return aLocked;
	}

	private void setALocked(boolean locked) {
		aLocked = locked;
	}

	public boolean isRLocked() {
		return rLocked;
	}
	public void setRLocked(boolean rLocked) {
		this.rLocked = rLocked;
	}
	public String getrLockedStr() {
		return rLockedStr;
	}
	public void setrLockedStr(String rLockedStr) {
		this.rLockedStr = rLockedStr;
	}
	public String getLimitenddate()
    {
        return limitenddate;
    }
    
    public void setLimitenddate(String limitenddate)
    {
        this.limitenddate = limitenddate;
    }
    
    public boolean isNoSwap()
    {
        return isNoSwap;
    }
    public void setNoSwap(boolean isNoSwap)
    {
        this.isNoSwap = isNoSwap;
    }
    public String getNoSwapStr()
    {
        return noSwapStr;
    }
    public void setNoSwapStr(String noSwapStr)
    {
        this.noSwapStr = noSwapStr;
    }
}

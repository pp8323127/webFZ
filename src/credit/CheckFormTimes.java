package credit;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import swap3ac.CheckFullAttendance;
import ci.db.ConnectionHelper;

public class CheckFormTimes {

	/**
	 * @param args
	 */
	private String errorstr = "";
	

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		CheckFormTimes ck = new CheckFormTimes();
		System.out.println(ck.get3FormTimes("640593", "2014", "02") + ck.getErrorstr());
//		System.out.println(ck.getTimes("635863", "2014", "06")+ ck.getErrorstr());
		
	}
	
	public int getTimes(String empno ,String year ,String month){
		Connection conn = null;
		PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        
        int num = 0;
        if(!"".equals(empno) && null != empno){       	
        
			try
			{
			    ConnectionHelper ch = new ConnectionHelper();
			    conn = ch.getConnection();
			    
//            ConnDB cn = new ConnDB();
////            cn.setORP3EGUserCP();
//            cn.setORT1EG();
//            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//            conn = dbDriver.connect(cn.getConnURL(), null);

			
			 // �P�_�O�_�w�g�f�֪��T�����Z��
				
				sql = " SELECT (select count(*) tcount from fztform where (aempno=? or rempno=?) " +
					  " and ed_check='Y' and substr(formno,1,6)=?)+(SELECT Count(*) c FROM fztrform " +
					  " WHERE Yyyy=? AND mm=? AND ( (aempno=? AND aCount='Y') OR (rempno=? AND rCount='Y'))) " +
					  " +(select count(*) tcount from fztbform where ((aempno=? AND aCount='Y') OR (rempno=? AND rCount='Y')) " +
					  " and ed_check='Y' and substr(formno,1,6)=?)" + 
					  " tcount FROM dual ";
				
				pstmt = conn.prepareStatement(sql);
//			
				// �Q����
				pstmt.clearParameters();
				num = 0;
				pstmt.setString(1, empno);
				pstmt.setString(2, empno);
				pstmt.setString(3, year + month);
				pstmt.setString(4, year);
				pstmt.setString(5, month);
				pstmt.setString(6, empno);
				pstmt.setString(7, empno);
				pstmt.setString(8, empno);
				pstmt.setString(9, empno);
				pstmt.setString(10, year + month);

				rs = pstmt.executeQuery();

				while (rs.next()) 
				{
					num = rs.getInt("tcount");
//					System.out.println(dataCount);
				} 
			
//            System.out.println(sql);
		
			//******************************************************************************
			}
			catch ( Exception e )
			{
			    //System.out.println(e.toString());
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
			        if (pstmt != null)
			            pstmt.close();
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
        }else{
        	errorstr = "no empn data!";
        }
        return num;
	}
	
	//�O�_����ܿn�I���Z
	public String get3FormTimes(String empno,String year, String month){
		//�Q���̿�ܤT�����Z�v�Q,���ˮ֬O�_����
		CheckFullAttendance rcs = new CheckFullAttendance(empno, year+month);
		String r_isfullattendance = rcs.getCheckMonth();
//		String displaystr = "";
	
		// �Q���̷��ӽЦ��ư���3���A�i��ܿn�I���Z
		CheckFormTimes ck = new CheckFormTimes();
		int times = ck.getTimes(empno, year, month);
		//***********************************************************************
		String result = "N";
		if("Y".equals(r_isfullattendance)  && times <4){//20150304�אּ4��
		    errorstr = empno + ",times:"+ times + "**"+ck.getErrorstr()+r_isfullattendance;
		    result = "N";							
		}else{
			//result = "�Q����:"+ empno +"=>" + year + month + "�T�����Z�w�β�,�i��ܿn�I���Z.";
		    result = "Y";     
		    errorstr = empno + ",times:"+ times + "**"+ck.getErrorstr()+r_isfullattendance;
		}
		
		return result;
	}

	public String getErrorstr() {
		return errorstr;
	}

	public void setErrorstr(String errorstr) {
		this.errorstr = errorstr;
	}
}

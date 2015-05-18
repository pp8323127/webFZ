package swap3ac;

import java.sql.*;
import java.text.*;
import java.util.*;
import java.util.Date;

import ci.db.*;
import ci.tool.*;

/**
 * �iAirCrews�������j <br>
 * CrewCrossCr ���Z���ɸպ�.���o���Z�ӽЪ̻P�Q���̤�����Z��.�ӤH��ơ]�tCR)��
 * 
 * 
 * @author cs66
 * @version 1.0 2006/05/16
 * @version 1.1 2006/06/15 �����oCR
 * @version 1.2 2008/03/06 �[�Jday of week
 * Copyright: Copyright (c) 2005
 */
public class CrewCrossCr 
{
	public static void main(String[] args) 
	{
//	    String dutycode = "0653Z";
//	    if(dutycode.length()==4)
//	    {
//	        dutycode = dutycode.substring(dutycode.length()-3);
//	    }
//	    else if(dutycode.length()==5)
//	    {
//	        dutycode = dutycode.substring(dutycode.length()-4,dutycode.length()-1);
//	    }
//	    System.out.println(dutycode);
	    
//		CrewSwapSkj csk = new CrewSwapSkj("630397", "629863", "2012", "06");
		CrewCrossCr csk = new CrewCrossCr("630397", "629863", "2012", "06");
		CrewInfoObj obj = null;
		CrewInfoObj obj2 = null;

		try {
			csk.SelectData();
			obj = csk.getACrewInfoObj();
			obj2 = csk.getRCrewInfoObj();
			// System.out.println(obj.getCname());
			ArrayList aCrewSkjAL = csk.getACrewSkjAL();
			ArrayList rCrewSkjAL = csk.getRCrewSkjAL();

			System.out.println("ok");
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();

		}
	    
//	    CrewCrossCr ccc = new CrewCrossCr("630397", "629863", "2012", "06");
//	    System.out.println(ccc.getEachDayOfMonth("2012", "01").size());
	}

	private String aEmpno;// �ӽЪ̭��u��
	private String rEmpno;// �Q���̭��u��
	private String year;
	private String month;
	private int workingDay;// �u�@�Ѽ�
	private CrewInfoObj aCrewInfoObj = null; // �ӽЪ̪��խ��ӤH���
	private CrewInfoObj rCrewInfoObj = null; // �Q���̪��խ��ӤH���
	private ArrayList aCrewSkjAL = null;// �ӽЪ̪��Z��
	private ArrayList rCrewSkjAL = null; // �Q���̪��Z��
	private ArrayList commItemAL = null;// �ӽЪ���
	private String liveTable;

	public CrewCrossCr(String aEmpno, String rEmpno, String year, String month) {
		this.aEmpno = aEmpno;
		this.rEmpno = rEmpno;
		this.year = year;
		this.month = month;
		setWorkingDay();

	}

	public void SelectData() throws SQLException 
	{
	    Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ConnDB cn = new ConnDB();
		ConnAOCI cna = new ConnAOCI();

		Driver dbDriver = null;
		ArrayList al = new ArrayList();
		ArrayList aal = new ArrayList();
		ArrayList ral = new ArrayList();
		boolean isThisMonth = false;
		String dateRangeCondition = "";

		if (aEmpno != null && rEmpno != null && year != null && month != null) 
		{
			// ���o����m�W
			// aircrew.CrewCName cc = new aircrew.CrewCName();

			try 
			{
				// User connection pool
//				cn.setAOCIPRODCP();
//				dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//				conn = dbDriver.connect(cn.getConnURL(), null);

				// �����s�u
				 cna.setAOCIFZUser();
//			    cn.setAOCIPRODFZUser();	
				java.lang.Class.forName(cna.getDriver());
				conn = DriverManager.getConnection(cna.getConnURL(), cna.getConnID(), cna.getConnPW());

//				String ym = null;
//				int dateFlag = 0;

				// �P�_�O�_������,�O->���o�Z�����϶�������+�Ѽ�~�Ӥ�̫�@��,
				// �_->�P�_���o�Z�����϶�(for �멳�̫�X�ѡA������Z�ɡA),
				// dateFlag = 0 ->����01~����̫�@��,
				// dateFlag = 1 =>����+�Ѽ�~����̫�@��

//				pstmt = conn.prepareStatement("SELECT To_Char(SYSDATE,'yyyymm') ym,"
//								+ "(CASE WHEN (SYSDATE+"
//								+ workingDay
//								+ ") > To_Date(?,'yyyymmdd') THEN 1 ELSE 0 END ) dateFlag "
//								+ "FROM dual");
//				pstmt.setString(1, year + month + "01");
//				rs = pstmt.executeQuery();
//				while (rs.next()) 
//				{
//					ym = rs.getString("ym");
//					dateFlag = rs.getInt("dateFlag");
//				}

//				if (ym.equals(year + month)) 
//				{
//					// ������,�O->���o�Z�����϶�������+�Ѽ�~�Ӥ�̫�@��,
//					isThisMonth = true;
//					dateRangeCondition = "BETWEEN To_Date(To_Char(SYSDATE,'yyyymmdd'),'yyyymmdd') +"
//							+ workingDay
//							+ " AND Last_Day(To_Date('"
//							+ year
//							+ month + "01 2359','yyyymmdd hh24mi'))";
//				} 
//				else 
//				{
//					// ������
//					isThisMonth = false;
//					if (dateFlag == 0) 
//					{
//						// dateFlag = 0 ->����01~����̫�@��,
//						dateRangeCondition = "BETWEEN To_Date('" + year + month
//								+ "01 0000','yyyymmdd hh24mi') "
//								+ " AND Last_Day(To_Date('" + year + month
//								+ "01 2359','yyyymmdd hh24mi'))";
//
//					} else {
//						// dateFlag = 1 =>����+�Ѽ�~����̫�@��
//						dateRangeCondition = "BETWEEN To_Date(To_Char(SYSDATE,'yyyymmdd'),'yyyymmdd') +"
//								+ workingDay
//								+ " AND Last_Day(To_Date('"
//								+ year
//								+ month + "01 2359','yyyymmdd hh24mi'))";
//					}
//				}		
//				pstmt.close();
//				rs.close();
				 
				dateRangeCondition = "BETWEEN To_Date('" + year + month
					+ "01 0000','yyyymmdd hh24mi') "
					+ " AND Last_Day(To_Date('" + year + month
					+ "01 2359','yyyymmdd hh24mi'))"; 

				// ���o�խ��ӤH���
				pstmt = conn.prepareStatement("select c.staff_num,sum(c.non_std_fly_hours) totalcr ,"
								+ "crew.preferred_name cname,to_number(crew.seniority_code) sern,crank.rank_cd occu,"
								+ "base.base,crew.section_number grps from crew_cum_hr_cc_v c,crew_v crew,"
								+ "crew_base_v base, crew_rank_v crank where c.staff_num = crew.staff_num "
								+ "AND c.staff_num = crank.staff_num AND c.staff_num= base.staff_num  "
								+ "AND c.staff_num =? and to_char(c.cal_dt,'yyyymm')=? "
								+ "AND (base.exp_dt>SYSDATE OR base.exp_dt IS NULL) "
								+ "AND base.prim_base='Y' "
								+ "AND crank.eff_dt <=SYSDATE AND (crank.exp_dt >=SYSDATE OR crank.exp_dt IS null) "
								+ "GROUP BY c.staff_num,crew.preferred_name,crew.seniority_code,"
								+ "crank.rank_cd,base.base,crew.section_number");

System.out.println("select c.staff_num,sum(c.non_std_fly_hours) totalcr ,"
		+ "crew.preferred_name cname,to_number(crew.seniority_code) sern,crank.rank_cd occu,"
		+ "base.base,crew.section_number grps from crew_cum_hr_cc_v c,crew_v crew,"
		+ "crew_base_v base, crew_rank_v crank where c.staff_num = crew.staff_num "
		+ "AND c.staff_num = crank.staff_num AND c.staff_num= base.staff_num  "
		+ "AND c.staff_num ='"+aEmpno+"' and to_char(c.cal_dt,'yyyymm')='"+year + month+"' "
		+ "AND (base.exp_dt>SYSDATE OR base.exp_dt IS NULL) "
		+ "AND base.prim_base='Y' "
		+ "AND crank.eff_dt <=SYSDATE AND (crank.exp_dt >=SYSDATE OR crank.exp_dt IS null) "
		+ "GROUP BY c.staff_num,crew.preferred_name,crew.seniority_code,"
		+ "crank.rank_cd,base.base,crew.section_number");				
				
				// �ӽЪ�
				pstmt.clearParameters();
				pstmt.setString(1, aEmpno);
				pstmt.setString(2, year + month);

				rs = pstmt.executeQuery();

				//CrewInfoObj obj = null;
				CrewInfoObj aobj = new CrewInfoObj();

				while (rs.next()) 
				{
//					obj = new CrewInfoObj();
//					obj.setEmpno(rs.getString("staff_num"));
//					obj.setSern(rs.getString("sern"));
//					obj.setCname(UnicodeStringParser.removeExtraEscape(rs.getString("cname")));
//					obj.setOccu(rs.getString("occu"));
//					obj.setGrps(rs.getString("grps"));
//					obj.setQual(rs.getString("occu"));
//					obj.setBase(rs.getString("base"));
					
				    aobj.setEmpno(rs.getString("staff_num"));
				    aobj.setSern(rs.getString("sern"));
				    aobj.setCname(UnicodeStringParser.removeExtraEscape(rs.getString("cname")));
				    aobj.setOccu(rs.getString("occu"));
				    aobj.setGrps(rs.getString("grps"));
				    aobj.setQual(rs.getString("occu"));
				    aobj.setBase(rs.getString("base"));
				}
				pstmt.close();
				rs.close();

				// ���oCR

				// 2006/06/14
				pstmt = conn.prepareStatement(" SELECT staff_num,sum(non_std_fly_hours) totalcr "
								+ "FROM crew_cum_hr_cc_v c   WHERE staff_num = ? AND  c.cal_dt  BETWEEN "
								+ "To_Date(?,'yyyymmdd hh24mi')  AND Last_Day(To_Date(?,'yyyymmdd hh24mi')) GROUP BY  staff_num");

System.out.println(" SELECT staff_num,sum(non_std_fly_hours) totalcr "
		+ "FROM crew_cum_hr_cc_v c   WHERE staff_num = '"+aEmpno+"' AND  c.cal_dt  BETWEEN "
		+ "To_Date('"+year + month + "01 0000"+"','yyyymmdd hh24mi')  AND Last_Day(To_Date('"+year + month + "01 2359"+"','yyyymmdd hh24mi')) GROUP BY  staff_num");				
				
				pstmt.clearParameters();
				pstmt.setString(1, aEmpno);
				pstmt.setString(2, year + month + "01 0000");
				pstmt.setString(3, year + month + "01 2359");

				rs = pstmt.executeQuery();

				while (rs.next()) 
				{
//					obj.setPrjcr(rs.getString("totalcr"));
				    aobj.setPrjcr(rs.getString("totalcr"));
				}

				pstmt.close();
				rs.close();

//				setACrewInfoObj(obj);
				setACrewInfoObj(aobj);
				//*****************************************************************************************

				// �Q����
				pstmt = conn.prepareStatement("select c.staff_num,sum(c.non_std_fly_hours) totalcr ,"
								+ "crew.preferred_name cname,to_number(crew.seniority_code) sern,crank.rank_cd occu,"
								+ "base.base,crew.section_number grps from crew_cum_hr_cc_v c,crew_v crew,"
								+ "crew_base_v base, crew_rank_v crank where c.staff_num = crew.staff_num "
								+ "AND c.staff_num = crank.staff_num AND c.staff_num= base.staff_num AND  "
								+ "c.staff_num =? and to_char(c.cal_dt,'yyyymm')=? "
								+ "AND (base.exp_dt>SYSDATE OR base.exp_dt IS NULL) "
								+ "AND base.prim_base='Y' "
								+ "AND crank.eff_dt <=SYSDATE AND (crank.exp_dt >=SYSDATE OR crank.exp_dt IS null) "
								+ "GROUP BY c.staff_num,crew.preferred_name,crew.seniority_code,"
								+ "crank.rank_cd,base.base,crew.section_number");

				pstmt.clearParameters();
				pstmt.setString(1, rEmpno);
				pstmt.setString(2, year + month);

				rs = pstmt.executeQuery();
//				obj = null;
				CrewInfoObj robj = new CrewInfoObj();

				while (rs.next()) 
				{
//					obj = new CrewInfoObj();
//					obj.setEmpno(rs.getString("staff_num"));
//					obj.setSern(rs.getString("sern"));
//					obj.setCname(UnicodeStringParser.removeExtraEscape(rs.getString("cname")));
//					obj.setOccu(rs.getString("occu"));
//					obj.setGrps(rs.getString("grps"));
//					obj.setQual(rs.getString("occu"));
//					obj.setBase(rs.getString("base"));
				    
					robj.setEmpno(rs.getString("staff_num"));
					robj.setSern(rs.getString("sern"));
					robj.setCname(UnicodeStringParser.removeExtraEscape(rs.getString("cname")));
					robj.setOccu(rs.getString("occu"));
					robj.setGrps(rs.getString("grps"));
					robj.setQual(rs.getString("occu"));
					robj.setBase(rs.getString("base"));
				}
				pstmt.close();
				rs.close();

				// �Q����CR
				// 2006/06/14
				pstmt = conn.prepareStatement(" SELECT staff_num,sum(non_std_fly_hours) totalcr "
								+ "FROM crew_cum_hr_cc_v c   WHERE staff_num = ? AND  c.cal_dt  BETWEEN "
								+ "To_Date(?,'yyyymmdd hh24mi')  AND Last_Day(To_Date(?,'yyyymmdd hh24mi')) GROUP BY  staff_num");

				pstmt.clearParameters();
				pstmt.setString(1, rEmpno);
				pstmt.setString(2, year + month + "01 0000");
				pstmt.setString(3, year + month + "01 2359");

				rs = pstmt.executeQuery();

				while (rs.next()) 
				{
//					obj.setPrjcr(rs.getString("totalcr"));
					robj.setPrjcr(rs.getString("totalcr"));
				}

				pstmt.close();
				rs.close();

//				setRCrewInfoObj(obj);
				setRCrewInfoObj(robj);

				// ���o�ӽЪ̯Z��				
				pstmt = conn.prepareStatement("select r.staff_num,  To_Char(dps.series_num) tripno,"
						+ "To_Char(str_dt_tm_loc,'yyyy/mm/dd') fdate,"
						+ " dps.port_a dpt,"
						+ " dps.port_b arv,"
						// �[�Jday of week ,
						+ "To_Char(str_dt_tm_loc,'DY','NLS_DATE_LANGUAGE=AMERICAN') dayOfWeek,"

						// �Dfly���ȫh������ȦW�ٷ�fltno���
						+ " (CASE WHEN dps.duty_cd NOT IN ( 'FLY','TVL') THEN dps.duty_cd ELSE dps.flt_num END ) fltno,"
						+ " dps.duty_cd cd,Nvl(r.special_indicator,' ') spCode "
						+ "from duty_prd_seg_v dps, roster_v r "
						+ "where dps.series_num=r.series_num "
						+ "AND r.series_num <> 0 "// ������series_num
						+ "AND r.staff_num=? AND r.delete_ind='N' "
						+ "AND dps.duty_seq_num||dps.item_seq_num=11 " // �u���1�q
						// + "AND dps.duty_cd NOT IN
						// ('B1','EE','MT','CT','FT','B2','GS') "
						+ "AND act_str_dt_tm_gmt "
						+ dateRangeCondition
						+ " UNION ALL SELECT staff_num,To_Char(series_num) tripno,"
						+ "To_Char(str_dt,'yyyy/mm/dd') fdate, "
						+ " 'TPE' dpt,"
						+ " 'TPE' arv,"
						// �[�Jday of week ,
						+ "To_Char(str_dt,'DY','NLS_DATE_LANGUAGE=AMERICAN') dayOfWeek,"
						+ "duty_cd fltno,duty_cd,"
						+ "Nvl(special_indicator,' ') spCode "
						+ "from roster_v 	WHERE str_dt "
						+ dateRangeCondition
						+ " AND delete_ind='N' AND series_num=0 	AND staff_num=?"
						+ " order by fdate");
				
System.out.println("select r.staff_num,  To_Char(dps.series_num) tripno,"
		+ "To_Char(str_dt_tm_loc,'yyyy/mm/dd') fdate,"
		+ " dps.port_a dpt,"
		+ " dps.port_b arv,"
		// �[�Jday of week ,
		+ "To_Char(str_dt_tm_loc,'DY','NLS_DATE_LANGUAGE=AMERICAN') dayOfWeek,"

		// �Dfly���ȫh������ȦW�ٷ�fltno���
		+ " (CASE WHEN dps.duty_cd NOT IN ( 'FLY','TVL') THEN dps.duty_cd ELSE dps.flt_num END ) fltno,"
		+ " dps.duty_cd cd,Nvl(r.special_indicator,' ') spCode "
		+ "from duty_prd_seg_v dps, roster_v r "
		+ "where dps.series_num=r.series_num "
		+ "AND r.series_num <> 0 "// ������series_num
		+ "AND r.staff_num=? AND r.delete_ind='N' "
		+ "AND dps.duty_seq_num||dps.item_seq_num=11 " // �u���1�q
		// + "AND dps.duty_cd NOT IN
		// ('B1','EE','MT','CT','FT','B2','GS') "
		+ "AND act_str_dt_tm_gmt "
		+ dateRangeCondition
		+ " UNION ALL SELECT staff_num,To_Char(series_num) tripno,"
		+ "To_Char(str_dt,'yyyy/mm/dd') fdate, "
		+ " 'TPE' dpt,"
		+ " 'TPE' arv,"
		// �[�Jday of week ,
		+ "To_Char(str_dt,'DY','NLS_DATE_LANGUAGE=AMERICAN') dayOfWeek,"
		+ "duty_cd fltno,duty_cd,"
		+ "Nvl(special_indicator,' ') spCode "
		+ "from roster_v 	WHERE str_dt "
		+ dateRangeCondition
		+ " AND delete_ind='N' AND series_num=0 	AND staff_num=?"
		+ " order by fdate");				

				// �ӽЪ̯Z��
				pstmt.clearParameters();
				pstmt.setString(1, aEmpno);
				pstmt.setString(2, aEmpno);

				rs = pstmt.executeQuery();
				al = new ArrayList();				
				ArrayList seriesAL = new ArrayList();

				while (rs.next()) 
				{
					CrewSkjObj sobj = new CrewSkjObj();
					sobj.setEmpno(rs.getString("staff_num"));
					sobj.setFdate(rs.getString("fdate"));
					sobj.setTripno(rs.getString("tripno"));
					sobj.setCd(rs.getString("cd"));
					sobj.setSpCode(rs.getString("spCode"));
					sobj.setDutycode(rs.getString("fltno"));
					sobj.setDpt(rs.getString("dpt"));
					sobj.setArv(rs.getString("arv"));
					sobj.setDayOfWeek(rs.getString("dayOfWeek"));
					seriesAL.add(rs.getString("tripno"));
					al.add(sobj);
				}

				pstmt.close();
				rs.close();
				
                //���o�Utrip��cr
				for (int i = 0; i < al.size(); i++) 
				{
					CrewSkjObj sobj = (CrewSkjObj) al.get(i);

					// 'AL', 'WL', 'FL', 'IL', 'OL', 'NB', BL����p��
					// set flttime
					if ("AL".equals(sobj.getDutycode())
							| "WL".equals(sobj.getDutycode())
							| "FL".equals(sobj.getDutycode())
							| "IL".equals(sobj.getDutycode())
							| "OL".equals(sobj.getDutycode())
							| "NB".equals(sobj.getDutycode())
							| "BL".equals(sobj.getDutycode())) 
					{
						sobj.setCr("120");				
					} 
					else if ("0".equals(sobj.getTripno())) 
					{
						// tripno=0,�P�_�O�_��LVCR,�O���ܬ���p�ɡA�_���ܬ�0

						pstmt = conn.prepareStatement("select (CASE WHEN Count(*) <>0 THEN 120 "
										+ "ELSE 0 END) cr from assignment_type_groups_v  "
										+ "where ASSNT_GRP_CD='LVCR' AND duty_cd=?");
						pstmt.clearParameters();
						pstmt.setString(1, sobj.getDutycode());
						rs = pstmt.executeQuery();
						while (rs.next()) 
						{
							sobj.setCr(rs.getString("cr"));
						}
						pstmt.close();
						rs.close();
					} 
					else 
					{
						try 
						{
							pstmt = conn.prepareStatement("select nvl(SUM(trunc(DECODE(duty_cd,'FLY', duration_mins,"
									+ " duration_mins*0.5))),0) totalCr from duty_prd_seg_v"
									+ " where (duty_cd='FLY' or cop_duty_cd='ACM') "
									+ " and series_num=? "
									+ " and act_str_dt_tm_gmt <= Last_Day(To_Date('"+year+"/"+month+"/01 235959','yyyy/mm/dd hh24:mi:ss'))");
System.out.println("select nvl(SUM(trunc(DECODE(duty_cd,'FLY', duration_mins,"
		+ " duration_mins*0.5))),0) totalCr from duty_prd_seg_v"
		+ " where (duty_cd='FLY' or cop_duty_cd='ACM') "
		+ " and series_num=? "
		+ " and act_str_dt_tm_gmt <= Last_Day(To_Date('"+year+"/"+month+"/01 235959','yyyy/mm/dd hh24:mi:ss'))");							

							pstmt.clearParameters();
							pstmt.setString(1, (String) seriesAL.get(i));

							rs = pstmt.executeQuery();
							while (rs.next()) 
							{
								sobj.setCr(rs.getString("totalCr"));	
							}
							pstmt.close();
							rs.close();
							
							//**********************************************************
							//�p����		
							String sql = " select CASE WHEN (act_dt_hr<=480) THEN 8 " +
							" when (act_dt_hr > 480 AND act_dt_hr < 720) THEN 12 ELSE 24 END resthr from ( " +
							" select act_dt_hr from trip_duty_prd_v where series_num=? and delete_ind='N' " +
							" and duty_seq_num <> 99 order by duty_seq_num desc ) where rownum = 1";
							pstmt = conn.prepareStatement(sql);
							pstmt.clearParameters();
							pstmt.setString(1, (String) seriesAL.get(i));

							rs = pstmt.executeQuery();
							while (rs.next()) 
							{
							    sobj.setResthr(rs.getString("resthr"));
							}
							pstmt.close();
							rs.close();		
						} 
						catch (NumberFormatException ne) 
						{
							sobj.setCr("0000");
						}
					}

				}// end of ���o�Utrip ��cr

				// �P�_�̫�@��q�O�_��� ,�ӽЪ�
				if (al != null && al.size() > 0) 
				{
					CrewSkjObj sobjA = (CrewSkjObj) al.get(al.size() - 1);
					MonthCrossTrip mct = new MonthCrossTrip(year, month, sobjA.getTripno(), aEmpno);
					mct.initData();
					if (mct.isCrossMonth()) 
					{
System.out.println("�ӽЪ̸�� ");					    
						if (mct.getTripInthisMonthCr() == null) 
						{
							sobjA.setCr("");
						} 
						else 
						{
							sobjA.setCr(mct.getTripInthisMonthCr());
						}
					}
				}
				setACrewSkjAL(al);
				pstmt.close();
				rs.close();
				// �Q���̯Z��				
				pstmt = conn.prepareStatement("select r.staff_num,  To_Char(dps.series_num) tripno,"
						+ "To_Char(str_dt_tm_loc,'yyyy/mm/dd') fdate,"
						+ " dps.port_a dpt,"
						+ " dps.port_b arv,"
						// �[�Jday of week ,
						+ "To_Char(str_dt_tm_loc,'DY','NLS_DATE_LANGUAGE=AMERICAN') dayOfWeek,"
						// �Dfly���ȫh������ȦW�ٷ�fltno���
						+ " (CASE WHEN dps.duty_cd NOT IN ( 'FLY','TVL') THEN dps.duty_cd ELSE dps.flt_num END ) fltno,"						
						+ " dps.duty_cd cd,Nvl(r.special_indicator,' ') spCode "
						+ "from duty_prd_seg_v dps, roster_v r "
						+ "where dps.series_num=r.series_num "
						+ "AND r.series_num <> 0 "// ������series_num
						+ "AND r.staff_num=? AND r.delete_ind='N' "
						+ "AND dps.duty_seq_num||dps.item_seq_num=11 " // �u���1�q
						// + "AND dps.duty_cd NOT IN
						// ('B1','EE','MT','CT','FT','B2','GS') "
						+ "AND act_str_dt_tm_gmt "
						+ dateRangeCondition
						+ " UNION ALL SELECT staff_num,To_Char(series_num) tripno,"
						+ " To_Char(str_dt,'yyyy/mm/dd') fdate, "
						+ " 'TPE' dpt,"
						+ " 'TPE' arv,"
						// �[�Jday of week ,
						+ "To_Char(str_dt,'DY','NLS_DATE_LANGUAGE=AMERICAN') dayOfWeek,"

						+ "duty_cd fltno,duty_cd,"
						+ "Nvl(special_indicator,' ') spCode "
						+ "from roster_v 	WHERE str_dt "
						+ dateRangeCondition
						+ " AND delete_ind='N' AND series_num=0 	AND staff_num=?"
						+ " order by fdate");
				
System.out.println("select r.staff_num,  To_Char(dps.series_num) tripno,"
		+ "To_Char(str_dt_tm_loc,'yyyy/mm/dd') fdate,"
		+ " dps.port_a dpt,"
		+ " dps.port_b arv,"
		// �[�Jday of week ,
		+ "To_Char(str_dt_tm_loc,'DY','NLS_DATE_LANGUAGE=AMERICAN') dayOfWeek,"
		// �Dfly���ȫh������ȦW�ٷ�fltno���
		+ " (CASE WHEN dps.duty_cd NOT IN ( 'FLY','TVL') THEN dps.duty_cd ELSE dps.flt_num END ) fltno,"						
		+ " dps.duty_cd cd,Nvl(r.special_indicator,' ') spCode "
		+ "from duty_prd_seg_v dps, roster_v r "
		+ "where dps.series_num=r.series_num "
		+ "AND r.series_num <> 0 "// ������series_num
		+ "AND r.staff_num=? AND r.delete_ind='N' "
		+ "AND dps.duty_seq_num||dps.item_seq_num=11 " // �u���1�q
		// + "AND dps.duty_cd NOT IN
		// ('B1','EE','MT','CT','FT','B2','GS') "
		+ "AND act_str_dt_tm_gmt "
		+ dateRangeCondition
		+ " UNION ALL SELECT staff_num,To_Char(series_num) tripno,"
		+ " To_Char(str_dt,'yyyy/mm/dd') fdate, "
		+ " 'TPE' dpt,"
		+ " 'TPE' arv,"
		// �[�Jday of week ,
		+ "To_Char(str_dt,'DY','NLS_DATE_LANGUAGE=AMERICAN') dayOfWeek,"

		+ "duty_cd fltno,duty_cd,"
		+ "Nvl(special_indicator,' ') spCode "
		+ "from roster_v 	WHERE str_dt "
		+ dateRangeCondition
		+ " AND delete_ind='N' AND series_num=0 	AND staff_num=?"
		+ " order by fdate");				
				
				pstmt.clearParameters();
				pstmt.setString(1, rEmpno);
				pstmt.setString(2, rEmpno);

				rs = pstmt.executeQuery();
				al = new ArrayList();
				seriesAL = new ArrayList();
				while (rs.next()) 
				{
					CrewSkjObj sobj = new CrewSkjObj();
					sobj.setEmpno(rs.getString("staff_num"));
					sobj.setFdate(rs.getString("fdate"));
					sobj.setTripno(rs.getString("tripno"));
					sobj.setCd(rs.getString("cd"));
					sobj.setSpCode(rs.getString("spCode"));
					// sobj.setCr(rs.getString("scr"));
					sobj.setDutycode(rs.getString("fltno"));
					sobj.setDpt(rs.getString("dpt"));
					sobj.setArv(rs.getString("arv"));
					sobj.setDayOfWeek(rs.getString("dayOfWeek"));
					seriesAL.add(rs.getString("tripno"));
					al.add(sobj);
				}

				pstmt.close();
				rs.close();
				
//				 ���o�Utrip��cr
				for (int i = 0; i < al.size(); i++) 
				{
					CrewSkjObj sobj = (CrewSkjObj) al.get(i);

					// 'AL', 'WL', 'FL', 'IL', 'OL', 'NB', BL����p��
					if ("AL".equals(sobj.getDutycode())
							| "WL".equals(sobj.getDutycode())
							| "FL".equals(sobj.getDutycode())
							| "IL".equals(sobj.getDutycode())
							| "OL".equals(sobj.getDutycode())
							| "NB".equals(sobj.getDutycode())
							| "BL".equals(sobj.getDutycode())) 
					{
						sobj.setCr("120");

					} 
					else if ("0".equals(sobj.getTripno())) 
					{
						// tripno=0,�P�_�O�_��LVCR,�O���ܬ���p�ɡA�_���ܬ�0

						pstmt = conn.prepareStatement("select (CASE WHEN Count(*) <>0 THEN 120 "
										+ "ELSE 0 END) cr from assignment_type_groups_v  "
										+ "where ASSNT_GRP_CD='LVCR' AND duty_cd=?");
						pstmt.setString(1, sobj.getDutycode());
						rs = pstmt.executeQuery();
						while (rs.next()) 
						{
							sobj.setCr(rs.getString("cr"));
						}
						pstmt.close();
						rs.close();

					} 
					else 
					{
						try 
						{
							pstmt = conn.prepareStatement("select nvl(SUM(trunc(DECODE(duty_cd,'FLY', duration_mins,"
											+ " duration_mins*0.5))),0) totalCr from duty_prd_seg_v"
											+ " where (duty_cd='FLY' or cop_duty_cd='ACM') "
											+ " and series_num=? "
											+ " and act_str_dt_tm_gmt <= Last_Day(To_Date('"+year+"/"+month+"/01 235959','yyyy/mm/dd hh24:mi:ss'))");
System.out.println("select nvl(SUM(trunc(DECODE(duty_cd,'FLY', duration_mins,"
		+ " duration_mins*0.5))),0) totalCr from duty_prd_seg_v"
		+ " where (duty_cd='FLY' or cop_duty_cd='ACM') "
		+ " and series_num=? "
		+ " and act_str_dt_tm_gmt <= Last_Day(To_Date('"+year+"/"+month+"/01 235959','yyyy/mm/dd hh24:mi:ss'))");							

							pstmt.clearParameters();
							pstmt.setString(1, (String) seriesAL.get(i));

							rs = pstmt.executeQuery();
							while (rs.next()) 
							{
								sobj.setCr(rs.getString("totalCr"));
							}
							pstmt.close();
							rs.close();
//							**********************************************************
							//�p����		
							String sql = " select CASE WHEN (act_dt_hr<=480) THEN 8 " +
							" when (act_dt_hr > 480 AND act_dt_hr < 720) THEN 12 ELSE 24 END resthr from ( " +
							" select act_dt_hr from trip_duty_prd_v where series_num=? and delete_ind='N' " +
							" and duty_seq_num <> 99 order by duty_seq_num desc ) where rownum = 1";
							pstmt = conn.prepareStatement(sql);
							pstmt.clearParameters();
							pstmt.setString(1, (String) seriesAL.get(i));

							rs = pstmt.executeQuery();
							while (rs.next()) 
							{
							    sobj.setResthr(rs.getString("resthr"));
							}
							pstmt.close();
							rs.close();		

						} catch (NumberFormatException ne) {
							sobj.setCr("0000");
						}

					}

				}// end of ���o�Utrip ��cr
				
				// �P�_�̫�@��q�O�_��� ,�Q����
				if (al != null && al.size() > 0) 
				{
					CrewSkjObj sobjA = (CrewSkjObj) al.get(al.size() - 1);
					MonthCrossTrip mct = new MonthCrossTrip(year, month, sobjA.getTripno(), rEmpno);
					mct.initData();
					if (mct.isCrossMonth()) 
					{
System.out.println("�Q���̸�� ");					    
						if (mct.getTripInthisMonthCr() == null) 
						{
							sobjA.setCr("");
						} 
						else 
						{
							sobjA.setCr(mct.getTripInthisMonthCr());
						}
					}
				}

				setRCrewSkjAL(al);

				rs.close();
				conn.close();

				// ���o�ӽЪ���
				cn.setORP3FZUserCP();
				dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
				conn = dbDriver.connect(cn.getConnURL(), null);

				pstmt = conn.prepareStatement("select citem from fztccom");
				rs = pstmt.executeQuery();
				al = new ArrayList();
				while (rs.next()) 
				{
					al.add(rs.getString("citem"));
				}
				setCommItemAL(al);
			} catch (SQLException e) {
				// e.printStackTrace();
				System.out.print(e.toString());
			} catch (Exception e) {
				System.out.print(e.toString());
				// e.printStackTrace();
			} finally {
				if (rs != null)
					try {
						rs.close();
					} catch (SQLException e) {}
				if (pstmt != null)
					try {
						pstmt.close();
					} catch (SQLException e) {}
				if (conn != null)
					try {
						conn.close();
					} catch (SQLException e) {}

			}
		}
	}
	/**
	 * �̥ثe�ɶ��A�]�w�u�@�Ѽ� <br>
	 * �C�餭�I�e�A�u�@�ѼƬ�2�� <br>
	 * �C�餭�I��A�u�@�ѼƬ�3��,
	 * 
	 * 2008/03/05 �ק�P�_�ɶ��I���C��U��5�I�b
	 */
	private void setWorkingDay() {
		
	    int workingDay = 2;
		Date curDate = Calendar.getInstance().getTime();
		int nowHH = Integer.parseInt(new SimpleDateFormat("HH").format(curDate));
		int nowMM = Integer.parseInt(new SimpleDateFormat("mm").format(curDate));

//		if (nowHH >= 17 && nowMM >30) {// �U��17:30�H��A��3�Ӥu�@��
//			workingDay = 3;
//		}
		if (nowHH >= 16) 
		{// �U��16:00�H��A��3�Ӥu�@��
			workingDay = 3;
		}
		
		//Add by Betty 2008/07/17
//		if (nowHH > 17 ) 
//		{// �U��17:30�H��A��3�Ӥu�@��
//			workingDay = 3;
//		}		
		//Add by Betty 2008/0717
		
		this.workingDay = workingDay;
	}
	
	//���o�Ӥ�����C�@��
	public ArrayList getEachDayOfMonth(String yyyy, String mm) 
	{
	    Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		ConnDB cn = new ConnDB();
		Driver dbDriver = null;
		ArrayList dayofmonthAL = new ArrayList();	
		String sql = "";

		try 
		{
		    //connection pool
//			cn.setORP3FZUserCP();
//			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//			conn = dbDriver.connect(cn.getConnURL(), null);

			// �����s�u
			cn.setORP3FZUser();
			java.lang.Class.forName(cn.getDriver());
			conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
			stmt = conn.createStatement();

			// SQL works on ORP3, don't work on ORT1
//			sql = " select To_Char(allday,'yyyy/mm/dd') eachdate,to_char(allday,'DY','NLS_DATE_LANGUAGE=AMERICAN') dayofweek  from ( " +
//				  " select to_date('"+yyyy+"/"+mm+"/01','yyyy/mm/dd')-1+rownum allday from dual " +
//				  " connect by rownum <= last_day(to_date('"+yyyy+"/"+mm+"/01','yyyy/mm/dd')) " +
//				  " -(to_date('"+yyyy+"/"+mm+"/01','yyyy/mm/dd')-1)) ";
			
			sql = " select To_Char(allday,'yyyy/mm/dd') eachdate, " +
				  " to_char(allday,'DY','NLS_DATE_LANGUAGE=AMERICAN') dayofweek from (  " +
				  " select to_date('"+yyyy+"/"+mm+"/'||jday,'yyyy/mm/dd') allday from fztdate " +
				  " WHERE jday <= To_Char(Last_Day(To_Date('"+yyyy+"/"+mm+"/01','yyyy/mm/dd')),'dd'))";
			
//			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			while (rs.next()) 
			{
			    dayofmonthAL.add(rs.getString("eachdate")+" ("+rs.getString("dayofweek")+")");
//			    System.out.println(rs.getString("eachdate")+" ("+rs.getString("dayofweek")+")");
			}
		} 
		catch (SQLException e) 
		{
			// e.printStackTrace();
			System.out.print(e.toString());
		} 
		catch (Exception e) 
		{
			System.out.print(e.toString());
			// e.printStackTrace();
		} 
		finally 
		{
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (stmt != null)
				try {
					stmt.close();
				} catch (SQLException e) {}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {}
		}
		return dayofmonthAL;
	}
	
	private void setACrewInfoObj(CrewInfoObj crewInfoObj) {
		aCrewInfoObj = crewInfoObj;
	}

	private void setRCrewInfoObj(CrewInfoObj crewInfoObj) {
		rCrewInfoObj = crewInfoObj;
	}

	public CrewInfoObj getACrewInfoObj() {
		return aCrewInfoObj;
	}

	public CrewInfoObj getRCrewInfoObj() {
		return rCrewInfoObj;
	}

	public ArrayList getACrewSkjAL() {
		return aCrewSkjAL;
	}

	private void setACrewSkjAL(ArrayList crewSkjAL) {
		aCrewSkjAL = crewSkjAL;
	}

	public ArrayList getRCrewSkjAL() {
		return rCrewSkjAL;
	}

	private void setRCrewSkjAL(ArrayList crewSkjAL) {
		rCrewSkjAL = crewSkjAL;
	}
	
	public ArrayList getCommItemAL() {
		return commItemAL;
	}

	public void setCommItemAL(ArrayList commItemAL) {
		this.commItemAL = commItemAL;
	}
}
package ws.prac;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Map;

import ws.prac.PA.PAEvalCrewRObj;
import ws.prac.PA.PAEvalItemRObj;

import ci.db.ConnDB;
import ci.db.ConnectionHelper;
import fz.pracP.BordingOnTime;
import fz.pracP.pa.EvaluationType;
import fz.pracP.pa.EvaluationTypeObj;
import fz.pracP.pa.PACrewEvalData;
import fz.pracP.pa.PACrewEvalObj;

public class FltIrrFun {
    /**
     * @param args
     *PR(CM) 傳回Irr已編輯項目
	 *PR(CM) 傳Irr勾選表單
	 *ZC(PR) 傳Irr勾選表單
     */
	FltIrrRObj irrObj = null;
	FltIrrItemRObj itemObj = null;

	FltIrrItemRObj zcItemObj = null;
	
    public static void main(String[] args) {
        // TODO Auto-generated method stub
    	FltIrrFun irrObj = new FltIrrFun();
//    	irrObj.getEdFltIrr("2013/11/14", "0130", "TPECTS", "630304");
//    	irrObj.getIrrAllItem();
    	irrObj.getZcIrrAllItem();
        System.out.println("done"); 
    }   
    
    //PR(CM) 傳回Irr已編輯項目
    public void getEdFltIrr(String fdate,String fltno,String sect,String empno){//2014/01/09
    	int count = 0;  
		Connection conn = null;
		Driver dbDriver = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		String recomendation = "";
		irrObj = new FltIrrRObj();
		// 登機準時資訊
		BordingOnTime borot = new BordingOnTime(fdate, fltno,sect, empno);
		try {
			borot.SelectData();
			ArrayList bot = new ArrayList();
			bot.add(borot);
			BordingOnTime[] array = new BordingOnTime[bot.size()];
            for (int i = 0; i < bot.size(); i++) {
                array[i] = (BordingOnTime) bot.get(i);
                if(null == array[i].getBdtmYear()){
                    array[i].setBdtmYear(fdate.substring(0,4));
                    array[i].setBdtmMonth(fdate.substring(5,7));
                    array[i].setBdtmDay(fdate.substring(8,10));
                    array[i].setBdtmHM("0001");
                }
                //System.out.println(array[i].getBdtmMonth());
            }
            irrObj.setBot(array);
            irrObj.setResultMsg("1");
		} catch (SQLException e) {
			irrObj.setErrorMsg(e.toString());
			irrObj.setResultMsg("0");
		} catch (Exception e) {
			irrObj.setErrorMsg(e.toString());
			irrObj.setResultMsg("0");
			// out.print(e.toString());
		}
		try {
			ConnDB cn = new ConnDB();
			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);
		    stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);
		    
		    
//			ConnectionHelper ch = new ConnectionHelper();
//			conn = ch.getConnection();
//			stmt = conn.createStatement();					

			sql = "select dt.* from egtcmdt dt " +
					"where fltno='"+ fltno + "' " +
					"and fltd=to_date('"+ fdate	+ "','yyyy/mm/dd') and sect='" + sect + "'";
 
			rs = stmt.executeQuery(sql);
			if(rs != null){
				ArrayList listIrr = new ArrayList();
				while(rs.next()){
					FltIrrObj obj = new FltIrrObj();
					obj.setYearsern(rs.getString("yearsern"));
					obj.setItem_key(rs.getString("itemno"));
					obj.setItemdsc(rs.getString("itemdsc"));
					obj.setComments(rs.getString("comments"));					
					obj.setClb(rs.getString("clb"));
					obj.setMcr(rs.getString("mcr"));
					obj.setRca(rs.getString("rca"));
					obj.setEmg(rs.getString("emg"));
					obj.setReply(rs.getString("reply"));
					listIrr.add(obj);
				}	
				
                FltIrrObj[] array = new FltIrrObj[listIrr.size()];
                for (int i = 0; i < listIrr.size(); i++) {
                    array[i] = (FltIrrObj) listIrr.get(i);
//                    System.out.println(array[i].getItemdsc());
                }
                irrObj.setEdIrr1(array);
                irrObj.setResultMsg("1");
			}
			//查view report - recomendation
			if(rs != null) rs.close();
			
//			sql = "select nvl(comments,'') comments from egtgddt where fltno='"+ fltno + "' " +
//                    "and fltd=to_date('"+ fdate + "','yyyy/mm/dd') and sect='" + sect + "'";
			
			sql = "select nvl(reply,'') recomendation from egtcflt where fltno='"+ fltno + "' " +
                  "and fltd=to_date('"+ fdate + "','yyyy/mm/dd') and sect='" + sect + "'";
			
			rs = stmt.executeQuery(sql);
			if(rs != null){
			    while(rs.next()){
			        recomendation += rs.getString("recomendation") +"\n"; 
			    }
			    irrObj.setRecomendation(recomendation);
//	            System.out.println(recomendation);
			}
//			irrObj.setErrorMsg(sql);
            irrObj.setResultMsg("1");
		} catch (Exception e) {
	         irrObj.setErrorMsg(e.toString());
	         irrObj.setResultMsg("0");
//	            System.out.println(e.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (SQLException e) {
			}
			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException e) {
			}
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
			}
		}
    }  
    //PR(CM) 傳Irr勾選表單
    public void getIrrAllItem(){
    	Connection conn = null;
		Driver dbDriver = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		itemObj = new FltIrrItemRObj();
		try {
			ConnDB cn = new ConnDB();
           
            ConnectionHelper ch = new ConnectionHelper();
  	        conn = ch.getConnection();
            stmt = conn.createStatement();
            //第一版
			//sql = "select i.itemno,i.itemdsc,i.flag,i.kin from egtcmpi i where extflag is null  order by itemno";
            //第二版
//			sql = " select NODE, PARENT_NODE, ITEM_DESC, ITEM_KEY, MUTI, CLB, RCA, EMG, MCR, ATTRIBUTE from fzdb.fztappirr" +
//			  " order by to_number(node) ";
            
			sql = " select NODE, PARENT_NODE, ITEM_DESC, ITEM_KEY, MUTI, CLB, RCA, EMG, MCR, ATTRIBUTE ,flag,kin from" +
				  " (select * from fzdb.fztappirr)" +
				  " left join" +
				  " (select * from egtcmpi where extflag is null)" +
				  " on item_key = itemno" +
				  " order by to_number(node)";
//			select NODE, PARENT_NODE, ITEM_DESC, ITEM_KEY, MUTI, CLB, RCA, EMG, MCR, ATTRIBUTE ,flag,kin from
//			fzdb.fztappirr,(select * from egtcmpi where extflag is null)
//			where item_key = itemno(+)
//			order by to_number(node)
			rs = stmt.executeQuery(sql);
			if(rs != null){
				ArrayList subItemIrr = new ArrayList();
				while(rs.next()){					
					FltIrrItemObj obj = new FltIrrItemObj();
					obj.setNode(rs.getString("NODE"));
					obj.setParent_node(rs.getString("PARENT_NODE"));
					obj.setItem_desc(rs.getString("ITEM_DESC"));
					obj.setItem_key(rs.getString("ITEM_KEY"));
					obj.setMuti(rs.getString("MUTI"));
					obj.setCLB(rs.getString("CLB"));
					obj.setRCA(rs.getString("RCA"));
					obj.setEMG(rs.getString("EMG"));
					obj.setMCR(rs.getString("MCR"));
					//System.out.println(rs.getString("MCR"));
					obj.setAttribute(rs.getString("ATTRIBUTE"));
					obj.setFlag(rs.getString("flag"));
					obj.setKin(rs.getString("kin"));
					
					subItemIrr.add(obj);
				}	
				
				FltIrrItemObj[] array = new FltIrrItemObj[subItemIrr.size()];
                for (int i = 0; i < subItemIrr.size(); i++) {
                    array[i] = (FltIrrItemObj) subItemIrr.get(i);
//                    System.out.println(array[i].getItem_desc());
                }
                itemObj.setItem(array);
                itemObj.setResultMsg("1");
			}
			
		} catch (Exception e) {
			itemObj.setErrorMsg(e.toString());
			itemObj.setResultMsg("0");
	        System.out.println(e.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (SQLException e) {
			}
			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException e) {
			}
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
			}
		}
    }
        
    //ZC(PR) 傳Irr勾選表單
    public void getZcIrrAllItem(){
        Connection conn = null;
        Driver dbDriver = null;
        Statement stmt = null;
        ResultSet rs = null;
        String sql = null;
        String str = "";
        zcItemObj = new FltIrrItemRObj();
        try {           
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();

            sql = " select * from (" +
//                  "    select NODE, PARENT_NODE, ITEM_DESC, ITEM_KEY, MUTI, CLB, RCA, EMG, MCR, ATTRIBUTE ,flag,kin, zcflag from" +
//                  "    fzdb.fztappirr, egtcmpi" +
//                  "      where item_key = itemno(+)  and  extflag is null" +
//                  "    and node in" +
//                  "    (" +
//                  "        select distinct(PARENT_NODE) from" + 
//                  "        fzdb.fztappirr, egtcmpi" +
//                  "      where item_key = itemno(+)  and  extflag is null" +
//                  "        and node in" +
//                  "        (" +
//                  "          select distinct(PARENT_NODE) from" + 
//                  "          fzdb.fztappirr, egtcmpi" +
//                  "          where item_key = itemno(+)  and  extflag is null" +
//                  "          and node in" +
//                  "          (" +
//                  "               select distinct(PARENT_NODE) from" +
//                  "               fzdb.fztappirr, egtcmpi" +
//                  "               where item_key = itemno(+)  and  extflag is null and zcflag ='Y'" +
//                  "          )" +
//                  "        )" +
//                  "    )" +
//                  "  union" +
                  "      select NODE, PARENT_NODE, ITEM_DESC, ITEM_KEY, MUTI, CLB, RCA, EMG, MCR, ATTRIBUTE ,flag,kin, zcflag from " +
                  "      fzdb.fztappirr, egtcmpi" +
                  "      where item_key = itemno(+)  and  extflag is null"+
                  "      and node in" +
                  "      (" +
                  "        select distinct(PARENT_NODE) from" + 
                  "        fzdb.fztappirr, egtcmpi" +
                  "        where item_key = itemno(+)  and  extflag is null" +
                  "        and node in" +
                  "        (" +
                  "          select distinct(PARENT_NODE) from" +
                  "          fzdb.fztappirr, egtcmpi" +
                  "          where item_key = itemno(+)  and  extflag is null and zcflag ='Y'" +
                  "        )" +
                  "      )" +
                  "  union " +
                  "      select NODE, PARENT_NODE, ITEM_DESC, ITEM_KEY, MUTI, CLB, RCA, EMG, MCR, ATTRIBUTE ,flag,kin, zcflag from" +
                  "      fzdb.fztappirr, egtcmpi" +
                  "      where item_key = itemno(+)  and  extflag is null" +
                  "      and node in" +
                  "      (" +
                  "         select distinct(PARENT_NODE) from" +
                  "         fzdb.fztappirr, egtcmpi" +
                  "         where item_key = itemno(+)  and  extflag is null and zcflag ='Y'" +
                  "      )" +
                  "  union " +
                  "      select NODE, PARENT_NODE, ITEM_DESC, ITEM_KEY, MUTI, CLB, RCA, EMG, MCR, ATTRIBUTE ,flag,kin, zcflag from" +
                  "      fzdb.fztappirr, egtcmpi" +
                  "      where item_key = itemno(+)  and  extflag is null and zcflag ='Y'" +
                  "  )order by to_number(node) ";

//            System.out.println(sql);
            rs = stmt.executeQuery(sql);
            if(rs != null){
                ArrayList subItemIrr = new ArrayList();
                while(rs.next()){                   
                    FltIrrItemObj obj = new FltIrrItemObj();
                    obj.setNode(rs.getString("NODE"));
//                    System.out.println(rs.getString("NODE"));
                    obj.setParent_node(rs.getString("PARENT_NODE"));
                    obj.setItem_desc(rs.getString("ITEM_DESC"));
                    obj.setItem_key(rs.getString("ITEM_KEY"));
                    obj.setMuti(rs.getString("MUTI"));
                    obj.setCLB(rs.getString("CLB"));
                    obj.setRCA(rs.getString("RCA"));
                    obj.setEMG(rs.getString("EMG"));
                    obj.setMCR(rs.getString("MCR"));                    
                    obj.setAttribute(rs.getString("ATTRIBUTE"));
                    obj.setFlag(rs.getString("flag"));
                    obj.setKin(rs.getString("kin"));
                    subItemIrr.add(obj);
                }   
                
                FltIrrItemObj[] array = new FltIrrItemObj[subItemIrr.size()];
                for (int i = 0; i < subItemIrr.size(); i++) {
                    array[i] = (FltIrrItemObj) subItemIrr.get(i);
//                    System.out.println(array[i].getItem_desc());
                }
                zcItemObj.setItem(array);
                zcItemObj.setResultMsg("1");
            }
            
        } catch (Exception e) {
            zcItemObj.setErrorMsg(e.toString());
            zcItemObj.setResultMsg("0");
//            System.out.println(e.toString());
        } finally {
            try {
                if (rs != null)
                    rs.close();
            } catch (SQLException e) {
            }
            try {
                if (stmt != null)
                    stmt.close();
            } catch (SQLException e) {
            }
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
            }
        }
    }
}

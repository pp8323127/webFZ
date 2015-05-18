package fz.psfly;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.ibm.db2.jcc.b.ob;

import ws.prac.SFLY.MP.MPsflySafetyChkAttObj;
import ws.prac.SFLY.MP.MPsflySelfCrew;
import ws.prac.SFLY.MP.MPsflySelfCrewObj;
import ws.prac.SFLY.MP.MPsflySelfInsItemObj;
import ws.prac.SFLY.MP.MPsflySelfInsItemRObj;
import ws.prac.SFLY.MP.MPsflySelfInsObj;
import ws.prac.SFLY.MP.MPsflySelfInsRObj;
import ci.db.ConnDB;
import fz.pracP.FlightCrewList;
import fz.pracP.GetFltInfo;
import fzac.*;

public class PSFlySelfIns {

	/**
	 * @param args
	 */
	MPsflySelfInsItemRObj sInsItem = null;
	ArrayList objAL = new ArrayList();
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		PSFlySelfIns a = new PSFlySelfIns();
		a.SelfInsItem("2014/09/30", "TPELAX", "0006", "");
	}
    
	public void SelfInsItem(String fltd,String sect,String fltno,String Empno){
    	sInsItem = new MPsflySelfInsItemRObj();
    
	    ConnDB cn = new ConnDB();
	    Connection con = null;
	    Statement stmt = null;
	    ResultSet rs = null;
	    Driver dbDriver = null;
	    String sql = null;
	    String fdate = "";
	    if(fltd.length()>10){
	    	fdate = fltd.substring(0,10);//yyyy/mm/dd hh24:mm
	    }else{
	    	fdate = fltd;
	    }
	    if(fltno.contains("/")){
	        fltno = fltno.substring(0,fltno.indexOf("/"));
	    }
	    if(fltno.length() < 4){
            fltno = "0000".substring(0, 4 - fltno.length()) + fltno; 
        }
        sect = sect.replace("/", "").substring(0,6);
        try
        {
            
            cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            con = dbDriver.connect(cn.getConnURL(), null);
            
            //connect ORT1 EG     
//          cn.setORP3EGUser();
//          cn.setORT1EG();
//          Class.forName(cn.getDriver());
//          con = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());   
            
            stmt = con.createStatement();       
            
           /*set Attribute*/
            ArrayList attObjAL = new ArrayList();
            sql = "select itemno,itemdsc from egtstrm order by itemno";
            rs = stmt.executeQuery(sql);
            while(rs.next())
            {
                MPsflySafetyChkAttObj attObj = new MPsflySafetyChkAttObj();
                attObj.setItemNo(rs.getString("itemno"));
                attObj.setItemdsc(rs.getString("itemdsc"));
                attObjAL.add(attObj);
            }  
            if(attObjAL.size()>0){
                MPsflySafetyChkAttObj[] attributeArr = new MPsflySafetyChkAttObj[attObjAL.size()];
                for(int i=0;i<attObjAL.size();i++){
                    attributeArr[i] = (MPsflySafetyChkAttObj)attObjAL.get(i);
                }
                sInsItem.setAttributeArr(attributeArr);
            }
            /*set Attribute*/
            
            /*set crew*/
            if(null!=fdate && !"".equals(fdate)){               
              MPsflySelfCrew[] crewArr2 = new MPsflySelfCrew[2];
              MPsflySelfCrew crewobj = new MPsflySelfCrew();
              crewobj.setEmpno("123456");
              crewobj.setName("張大寶");
              crewArr2[0] = crewobj;

              crewobj = new MPsflySelfCrew();
              crewobj.setEmpno("123457");
              crewobj.setName("李二寶");
              crewArr2[1] = crewobj;
              sInsItem.setCrewArr(crewArr2);
                
                GetFltInfo ft = new GetFltInfo(fdate, fltno ,sect ,"");
                if(!ft.isHasData()){                    
                    ft = new GetFltInfo(fdate,  fltno,  sect);
                }
                FlightCrewList fcl = new FlightCrewList(ft,sect);//hhmm
                ArrayList dataAL = new ArrayList();
                ArrayList crewObjList = new ArrayList();
                fzac.CrewInfoObj cmObj = null;
                
                fcl.RetrieveData();
                crewObjList = fcl.getCrewObjList(); // 組員資料名單
                
                ft.RetrieveData();
                dataAL = ft.getDataAL();                
        
                if(null != dataAL){
                  if(dataAL.size()>0){
                      for(int i=0 ;i<dataAL.size();i++){  
                        if(!"TVL".equals(((FlightCrewList) dataAL.get(i)).getPurCrewObj().getDuty_cd())){//抓非TVL 顯示 
                                cmObj = ((FlightCrewList) dataAL.get(i)).getPurCrewObj();
                        }
                      }                  
                  }else{
                      cmObj = ((FlightCrewList) dataAL.get(0)).getPurCrewObj();
                  }         
                  cmObj.setEmpno(cmObj.getEmpno());
                  cmObj.setCname(cmObj.getCname());//客艙經理   去掉特殊符號ex:PA*
                  crewObjList.add(cmObj);
                }
                if (crewObjList != null && crewObjList.size() > 0) {
                    MPsflySelfCrew[] crewArr = new MPsflySelfCrew[crewObjList.size()];
                    for (int i = 0; i < crewObjList.size(); i++) {
                        MPsflySelfCrew obj = new MPsflySelfCrew();
                        obj.setEmpno(((MPsflySelfCrew) crewObjList.get(i)).getEmpno().toString());
                        obj.setName(((MPsflySelfCrew) crewObjList.get(i)).getName().toString());
                        crewArr[i] = obj;
                    }
                    sInsItem.setCrewArr(crewArr);               
                }   
            }else{
                sInsItem.setCrewArr(null);   
            }
            /*set crew*/  
            
            /*set Subject*/
            objAL = null;
            objAL = new ArrayList();
            sql = "select nvl(itemno,'0') itemno ,subject from egtstci where flag = 'Y' order by itemno";
            rs = stmt.executeQuery(sql);
            while(rs.next())
            {
                MPsflySelfInsItemObj itemObj = new MPsflySelfInsItemObj();
                itemObj.setItemno(rs.getString("itemno"));
                itemObj.setSubject(rs.getString("subject"));
                objAL.add(itemObj);
            }  
            
            if(objAL.size()>0){
                MPsflySelfInsItemObj[] itemArr = new MPsflySelfInsItemObj[objAL.size()];
                for(int i=0;i<objAL.size();i++){
                    MPsflySelfInsItemObj obj = (MPsflySelfInsItemObj) objAL.get(i);
//                    obj.setSern(i+1+"");//
//                    if(null != obj){
//                        int temp = Integer.parseInt(obj.getItemno());
//                        if(temp >=159 && temp <=189){//題庫預設值
//                            obj.setNoChecked("1");
//                            obj.setCorr("1");
//                        }
//                    }                    
                    itemArr[i] = obj;
                }
                sInsItem.setInsItem(itemArr);
                
                }
            sInsItem.setResultMsg("1");
            sInsItem.setErrorMsg("done.");
        }
        catch(Exception e)
        {
          // System.out.print(e.toString());
            sInsItem.setResultMsg("0");
            sInsItem.setErrorMsg("sfltyInsItem:"+e.toString());
      }
      finally
      {
          try{if(rs != null) rs.close();}catch(SQLException e){}
          try{if(stmt != null) stmt.close();}catch(SQLException e){}
          try{if(con != null) con.close();}catch(SQLException e){}
      }
	}
		
	public void SelfInsCrew(String fltd,String sect,String fltno,String Empno){
	    sInsItem = new MPsflySelfInsItemRObj();
        String fdate = "";
        try{
    	    if(fltd.length()>10){
                fdate = fltd.substring(0,10);//yyyy/mm/dd hh24:mm
            }else{
                fdate = fltd;
            }
            fltno = fltno.substring(0,fltno.indexOf("/"));
            if(fltno.length() < 4){
                fltno = "0000".substring(0, 4 - fltno.length()) + fltno; 
            }
            sect = sect.replace("/", "").substring(0,6);
            /*set crew*/
            if(null!=fdate && !"".equals(fdate)){               
              MPsflySelfCrew[] crewArr2 = new MPsflySelfCrew[2];
              MPsflySelfCrew crewobj = new MPsflySelfCrew();
              crewobj.setEmpno("123456");
              crewobj.setName("張大寶");
              crewArr2[0] = crewobj;

              crewobj = new MPsflySelfCrew();
              crewobj.setEmpno("123457");
              crewobj.setName("李二寶");
              crewArr2[1] = crewobj;
              sInsItem.setCrewArr(crewArr2);
                
                GetFltInfo ft = new GetFltInfo(fdate, fltno ,sect ,"");
                if(!ft.isHasData()){                    
                    ft = new GetFltInfo(fdate,  fltno,  sect);
                }
                FlightCrewList fcl = new FlightCrewList(ft,sect);//hhmm
                ArrayList<fz.prObj.FltObj> dataAL = new ArrayList<fz.prObj.FltObj>();
                ArrayList<CrewInfoObj> crewObjList = new ArrayList<CrewInfoObj>();
                fzac.CrewInfoObj cmObj = null;
                
                fcl.RetrieveData();
                crewObjList = fcl.getCrewObjList(); // 組員資料名單
                
                ft.RetrieveData();
                dataAL = ft.getDataAL();                
        
                if(null != dataAL){
                  if(dataAL.size()>0){
                      for(int i=0 ;i<dataAL.size();i++){  
                        if(!"TVL".equals((dataAL.get(i)).getPurCrewObj().getDuty_cd())){//抓非TVL 顯示 
                                cmObj = (dataAL.get(i)).getPurCrewObj();
                        }
                      }                  
                  }else{
                      cmObj = (dataAL.get(0)).getPurCrewObj();
                  }         
                  cmObj.setEmpno(cmObj.getEmpno());
                  cmObj.setCname(cmObj.getCname());//客艙經理   去掉特殊符號ex:PA*
                  crewObjList.add(cmObj);
                }
                if (crewObjList != null && crewObjList.size() > 0) {
                    MPsflySelfCrew[] crewArr = new MPsflySelfCrew[crewObjList.size()];
                    for (int i = 0; i < crewObjList.size(); i++) {
                        MPsflySelfCrew obj = new MPsflySelfCrew();
                        obj.setEmpno((crewObjList.get(i)).getEmpno().toString());
                        obj.setName((crewObjList.get(i)).getCname().toString());
                        crewArr[i] = obj;
                    }
                    sInsItem.setCrewArr(crewArr);               
                }   
            }else{
                sInsItem.setCrewArr(null);   
            }
            /*set crew*/ 
            sInsItem.setResultMsg("1");
            sInsItem.setErrorMsg("done.");
        }
        catch ( SQLException e ){
         // System.out.print(e.toString());
            sInsItem.setResultMsg("0");
            sInsItem.setErrorMsg("sfltyInsCrew:"+e.toString());
        }
        catch ( Exception e ){
            sInsItem.setResultMsg("0");
            sInsItem.setErrorMsg("sfltyInsCrew:"+e.toString());
            
        }finally{
            
        }
	}
	
	public String getSelfIns(String seqno){
        Connection conn   = null;
        String sql = null;
        ResultSet rs = null;
        Statement stmt = null;
        ConnDB cn = new ConnDB();
        Driver dbDriver = null;       
        try
        {
            cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            
            //connect ORT1 EG     
//            cn.setORP3EGUser();
//            cn.setORT1EG();
//            Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());   
            
            stmt = conn.createStatement();   
            
            sql = " select cc.sernno, ci.itemno as itemno, ci.subject as subject, "+ 
                    " NVL(cc.tcrew, 0) as tcrew, NVL(cc.correct, 0) as correct, NVL(cc.incomplete, 0) as incomplete,"+ 
                    " NVL(cc.crew_comm, '　') as crew_comm, NVL(cc.acomm, '　') as acomm , cc.itemno_rm "+
                    " from egtstcc cc, egtstci ci "+
                    " where cc.sernno='"+seqno+"' and cc.itemno=ci.itemno"+ 
                    " order by ci.itemno ";
            rs = stmt.executeQuery(sql); 
            
            objAL = new ArrayList();           
            while(rs.next())
            {
            	PSFlySelfInsObj obj = new PSFlySelfInsObj();                 
                obj.setAcomm(rs.getString("acomm"));
                obj.setTcrew(rs.getString("tcrew"));
                obj.setCorrect(rs.getString("correct"));
                obj.setIncomplete(rs.getString("incomplete"));
                obj.setItemno(rs.getString("itemno"));
                obj.setItemno_rm(rs.getString("itemno_rm"));
                obj.setSernno(rs.getString("sernno"));
                obj.setSubject(rs.getString("subject"));
//                obj.setCrew(crew);
                objAL.add(obj);
            }
            
            if(objAL.size()>0){
                for(int i=0;i<objAL.size();i++){
                	PSFlySelfInsObj obj = (PSFlySelfInsObj) objAL.get(i);                                        
                    sql = " select  sernno ,empno ,itemno ,NVL(crew_comm, 'N/A') as crew_comm"+
                            " from egtstcc2 "+
                            " where sernno='"+seqno+"' and itemno= '"+obj.getItemno()+"'"+ 
                            " order by itemno ";
                    rs = stmt.executeQuery(sql); 
                    
                    ArrayList objAL2 = new ArrayList();           
                    while(rs.next())
                    {
                        MPsflySelfCrewObj crewObj = new MPsflySelfCrewObj();                 
                        crewObj.setSeqno(rs.getString("sernno"));
                        crewObj.setEmpno(rs.getString("empno"));
                        crewObj.setItemno(rs.getString("itemno"));
                        crewObj.setCrew_comm(rs.getString("crew_comm"));
                        objAL2.add(crewObj);
                    }
                    if(objAL2.size()>0){
                        MPsflySelfCrewObj[] crewArr = new MPsflySelfCrewObj[objAL2.size()];
                        for(int j=0;j<objAL2.size();j++){
                            crewArr[j] = (MPsflySelfCrewObj) objAL2.get(j);
                        }
                        obj.setCrew(crewArr);
                    }
                    objAL.set(i, obj);
                }
            }
        }
        catch (Exception e)
        {
//             System.out.print("self:"+e.toString());
             return "selfIns:"+e.toString();
        }
        finally
        {
            try{if(rs != null) rs.close();}catch(SQLException e){}
            try{if(stmt != null) stmt.close();}catch(SQLException e){}                      
            try{if(conn != null) conn.close();}catch(SQLException e){}
        }        
        return "Y";
    }
	
	public void getSelfInsCrew(String sernno,String itemno){

		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		String bgColor = null;
		ConnDB cn = new ConnDB();
		Driver dbDriver = null;

		try {
			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);
			objAL = new ArrayList();
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);

			sql = " select  sernno ,empno ,itemno ,crew_comm"
					+ " from egtstcc2 " + " where sernno='" + sernno
					+ "' and itemno= '" + itemno + "'"
					+ " order by itemno ";
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				MPsflySelfCrewObj crewObj = new MPsflySelfCrewObj();
				crewObj.setSeqno(rs.getString("sernno"));
				crewObj.setEmpno(rs.getString("empno"));
				crewObj.setItemno(rs.getString("itemno"));
				crewObj.setCrew_comm(rs.getString("crew_comm"));
				objAL.add(crewObj);
			}
		} catch (Exception e) {
			System.out.print(e.toString());
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
	
	public ArrayList getObjAL() {
		return objAL;
	}
	public void setObjAL(ArrayList objAL) {
		this.objAL = objAL;
	}
	public MPsflySelfInsItemRObj getsInsItem() {
		return sInsItem;
	}
	public void setsInsItem(MPsflySelfInsItemRObj sInsItem) {
		this.sInsItem = sInsItem;
	}
	
	
}

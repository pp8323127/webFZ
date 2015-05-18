package eg;

import java.sql.*;
import java.util.*;
import ci.db.*;

/**
 * @author cs71 Created on 2005/10/6
 */
public class EGInfo
{
    private ArrayList objAL = new ArrayList();
    private String returnStr = "";   
    private String sql = "";     

    public static void main(String[] args)
    {        
//        EGInfo egi = new EGInfo("635856");
//        ArrayList objAL2 = new ArrayList();
//        objAL2 = egi.getObjAL();
//        EgInfoObj obj2 = new EgInfoObj();
//        if(objAL2.size()>0)
//        {
//        	obj2 = (EgInfoObj) objAL2.get(0);
//        }    
        
        EGInfo egi = new EGInfo("635856");
        EgInfoObj obj = egi.getEGInfoObj("635856"); 
        System.out.println(obj.getEmpn());
        System.out.println(obj.getEname());
        System.out.println(obj.getCname());
        System.out.println("Done");        
    }

    
    public EGInfo()
    {
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        
        try 
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
			stmt = conn.createStatement();	

            sql = " SELECT Trim(c.empn) empn, sern, SECTION, cname, ename, d.cdept dept, jobno, " +
            	  " To_Char(hiredate,'yyyy/mm/dd') hiredate, To_Char(indate,'yyyy/mm/dd') indate, " +
            	  " status, worktype, Nvl(To_Char(ssdate,'yyyy/mm/dd'),' ') ssdate, station, id, sex, " +
            	  " To_Char(birth,'yyyy/mm/dd') birth, Nvl(bplace,' ') bplace, Nvl(height,' ') height, " +
            	  " Nvl(blood,' ') blood, nation, Nvl(province,' ') province, Nvl(city,' ') city, " +
            	  " Nvl(educate,' ') educate, Nvl(GROUPS,' ') GROUPS, cabin,green, passport, " +
            	  " To_Char(passdate,'yyyy/mm/dd') passdate, To_Char(visadate,'yyyy/mm/dd') visadate, " +
            	  " cmcno, Nvl(homeadrs,' ') homeadrs, Nvl(mailadrs,' ') mailadrs, Nvl(emailadrs,' ') emailadrs, " +
            	  " phone1, phone2, phone3, phone4, phone5, emgname, emgphone1, emgphone2, resignno, " +
            	  " To_Char(rsndate,'yyyy/mm/dd') rsndate, Nvl(newdept,' ') newdept, Nvl(comments,' ') comments, " +
            	  " c.newuser newuser, c.newdate newdate, c.chguser chguser, c.chgdate chgdate, " +
            	  " visatype, To_Char(visadate1,'yyyy/mm/dd') visadate1, " +
            	  " ckscheckout, specialcode, bplace_en, smsphone, issuestate_app, " +
            	  " To_Char(docissdate_app,'yyyy/mm/dd') docissdate_app, placeissue_app, last_name, " +
            	  " first_name, rptloc, to_char(a.aldate,'yyyy/mm/dd') aldate " +
            	  " FROM egtcbas c, egtdept d, egtaldt a " +
            	  " where trim(c.empn) = a.empno (+) and c.deptno = d.deptno (+) ";
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);            
            
            while (rs.next()) 
            {
                EgInfoObj obj = new EgInfoObj();
                
                obj.setEmpn(rs.getString("empn"));
                obj.setSern(rs.getString("sern"));
                obj.setSection(rs.getString("section"));
                obj.setCname(rs.getString("cname"));
                obj.setEname(rs.getString("ename"));
                obj.setDeptno(rs.getString("dept"));
                obj.setJobno(rs.getString("jobno"));
                obj.setHiredate(rs.getString("hiredate"));
                obj.setIndate(rs.getString("indate"));
                obj.setStatus(rs.getString("status"));
                obj.setWorktype(rs.getString("worktype"));
                obj.setSsdate(rs.getString("ssdate"));
                obj.setId(rs.getString("id"));
                obj.setSex(rs.getString("sex"));
                obj.setBirth(rs.getString("birth"));
                obj.setBplace(rs.getString("bplace"));
                obj.setHeight(rs.getString("height"));
                obj.setEducate(rs.getString("educate"));
                obj.setGroups(rs.getString("groups"));
                obj.setCabin(rs.getString("cabin"));
                obj.setGreen(rs.getString("green"));
                obj.setPassport(rs.getString("passport"));
                obj.setPassdate(rs.getString("passdate"));
                obj.setVisadate(rs.getString("visadate"));
                obj.setCmcno(rs.getString("cmcno"));
                obj.setHomeadrs(rs.getString("homeadrs"));
                obj.setMailadrs(rs.getString("mailadrs"));
                obj.setEmailadrs(rs.getString("emailadrs"));
                obj.setPhone1(rs.getString("phone1")); 
                obj.setPhone2(rs.getString("phone2"));
                obj.setPhone3(rs.getString("phone3"));
                obj.setPhone4(rs.getString("phone4"));
                obj.setPhone5(rs.getString("phone5"));
                obj.setEmgname(rs.getString("emgname"));
                obj.setEmgphone1(rs.getString("emgphone1"));
                obj.setEmgphone2(rs.getString("emgphone2"));
                obj.setResignno(rs.getString("resignno"));
                obj.setRsndate(rs.getString("rsndate"));
                obj.setNewdept(rs.getString("newdept"));
                obj.setComments(rs.getString("comments"));
                obj.setNewuser(rs.getString("newuser"));
                obj.setNewdate(rs.getString("newdate"));
                obj.setChguser(rs.getString("chguser"));
                obj.setChgdate(rs.getString("chgdate"));
                obj.setVisatype(rs.getString("visatype"));
                obj.setVisadate1(rs.getString("visadate1"));
                obj.setCkscheckout(rs.getString("ckscheckout"));
                obj.setSpecialcode(rs.getString("specialcode"));
                obj.setBplace_en(rs.getString("bplace_en"));
                obj.setSmsphone(rs.getString("smsphone"));
                obj.setIssuestate_app(rs.getString("issuestate_app"));
                obj.setDocissdate_app(rs.getString("docissdate_app"));
                obj.setPlaceissue_app(rs.getString("placeissue_app"));
                obj.setLast_name(rs.getString("last_name"));
                obj.setFirst_name(rs.getString("first_name"));
                obj.setRptloc(rs.getString("rptloc"));     
                obj.setAldate(rs.getString("aldate"));
                
                objAL.add(obj);
            }
            returnStr = "Y";
        } 
        catch (SQLException e) 
        {
            System.out.print(e.toString());
            returnStr = e.toString();
        } 
        catch (Exception e) 
        {
            System.out.print(e.toString());
            returnStr = e.toString();
        }
        finally 
        {

            if ( rs != null ) try {
                rs.close();
            } catch (SQLException e) {}
            if ( stmt != null ) try {
                stmt.close();
            } catch (SQLException e) {}
            if ( conn != null ) try {
                conn.close();
            } catch (SQLException e) {}

        }
    }// end of public HRInfo()

    public EGInfo(String empno)
    {
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        
        try 
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
			stmt = conn.createStatement();	

            sql = " SELECT Trim(c.empn) empn, sern, SECTION, cname, ename, d.cdept dept, jobno, " +
		      	  " To_Char(hiredate,'yyyy/mm/dd') hiredate, To_Char(indate,'yyyy/mm/dd') indate, " +
		      	  " status, worktype, Nvl(To_Char(ssdate,'yyyy/mm/dd'),' ') ssdate, station, id, sex, " +
		      	  " To_Char(birth,'yyyy/mm/dd') birth, Nvl(bplace,' ') bplace, Nvl(height,' ') height, " +
		      	  " Nvl(blood,' ') blood, nation, Nvl(province,' ') province, Nvl(city,' ') city, " +
		      	  " Nvl(educate,' ') educate, Nvl(GROUPS,' ') GROUPS, cabin,green, passport, " +
		      	  " To_Char(passdate,'yyyy/mm/dd') passdate, To_Char(visadate,'yyyy/mm/dd') visadate, " +
		      	  " cmcno, Nvl(homeadrs,' ') homeadrs, Nvl(mailadrs,' ') mailadrs, Nvl(emailadrs,' ') emailadrs, " +
		      	  " phone1, phone2, phone3, phone4, phone5, emgname, emgphone1, emgphone2, resignno, " +
		      	  " To_Char(rsndate,'yyyy/mm/dd') rsndate, Nvl(newdept,' ') newdept, Nvl(comments,' ') comments, " +
		      	  " c.newuser newuser, c.newdate newdate, c.chguser chguser, c.chgdate chgdate, " +
		      	  " visatype, To_Char(visadate1,'yyyy/mm/dd') visadate1, " +
		      	  " ckscheckout, specialcode, bplace_en, smsphone, issuestate_app, " +
		      	  " To_Char(docissdate_app,'yyyy/mm/dd') docissdate_app, placeissue_app, last_name, " +
		      	  " first_name, rptloc, to_char(a.aldate,'yyyy/mm/dd') aldate " +
		      	  " FROM egtcbas c, egtdept d, egtaldt a " +
		      	  " where c.empn = '"+empno+"' and trim(c.empn) = a.empno (+)" +
		      	  " and c.deptno = d.deptno (+) ";
            
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);

            while (rs.next()) 
            {
                EgInfoObj obj = new EgInfoObj();
                
                obj.setEmpn(rs.getString("empn"));
                obj.setSern(rs.getString("sern"));
                obj.setSection(rs.getString("section"));
                obj.setCname(rs.getString("cname"));
                obj.setEname(rs.getString("ename"));
                obj.setDeptno(rs.getString("dept"));
                obj.setJobno(rs.getString("jobno"));
                obj.setHiredate(rs.getString("hiredate"));
                obj.setIndate(rs.getString("indate"));
                obj.setStatus(rs.getString("status"));
                obj.setWorktype(rs.getString("worktype"));
                obj.setSsdate(rs.getString("ssdate"));
                obj.setId(rs.getString("id"));
                obj.setSex(rs.getString("sex"));
                obj.setBirth(rs.getString("birth"));
                obj.setBplace(rs.getString("bplace"));
                obj.setHeight(rs.getString("height"));
                obj.setEducate(rs.getString("educate"));
                obj.setGroups(rs.getString("groups"));
                obj.setCabin(rs.getString("cabin"));
                obj.setGreen(rs.getString("green"));
                obj.setPassport(rs.getString("passport"));
                obj.setPassdate(rs.getString("passdate"));
                obj.setVisadate(rs.getString("visadate"));
                obj.setCmcno(rs.getString("cmcno"));
                obj.setHomeadrs(rs.getString("homeadrs"));
                obj.setMailadrs(rs.getString("mailadrs"));
                obj.setEmailadrs(rs.getString("emailadrs"));
                obj.setPhone1(rs.getString("phone1")); 
                obj.setPhone2(rs.getString("phone2"));
                obj.setPhone3(rs.getString("phone3"));
                obj.setPhone4(rs.getString("phone4"));
                obj.setPhone5(rs.getString("phone5"));
                obj.setEmgname(rs.getString("emgname"));
                obj.setEmgphone1(rs.getString("emgphone1"));
                obj.setEmgphone2(rs.getString("emgphone2"));
                obj.setResignno(rs.getString("resignno"));
                obj.setRsndate(rs.getString("rsndate"));
                obj.setNewdept(rs.getString("newdept"));
                obj.setComments(rs.getString("comments"));
                obj.setNewuser(rs.getString("newuser"));
                obj.setNewdate(rs.getString("newdate"));
                obj.setChguser(rs.getString("chguser"));
                obj.setChgdate(rs.getString("chgdate"));
                obj.setVisatype(rs.getString("visatype"));
                obj.setVisadate1(rs.getString("visadate1"));
                obj.setCkscheckout(rs.getString("ckscheckout"));
                obj.setSpecialcode(rs.getString("specialcode"));
                obj.setBplace_en(rs.getString("bplace_en"));
                obj.setSmsphone(rs.getString("smsphone"));
                obj.setIssuestate_app(rs.getString("issuestate_app"));
                obj.setDocissdate_app(rs.getString("docissdate_app"));
                obj.setPlaceissue_app(rs.getString("placeissue_app"));
                obj.setLast_name(rs.getString("last_name"));
                obj.setFirst_name(rs.getString("first_name"));
                obj.setRptloc(rs.getString("rptloc"));     
                obj.setAldate(rs.getString("aldate"));                
                objAL.add(obj);               
            }
            returnStr = "Y";
        } 
        catch (SQLException e) 
        {
            System.out.print(e.toString());
            returnStr = e.toString();
        } 
        catch (Exception e) 
        {
            System.out.print(e.toString());
            returnStr = e.toString();

        }
        finally 
        {

            if ( rs != null ) try {
                rs.close();
            } catch (SQLException e) {}
            if ( stmt != null ) try {
                stmt.close();
            } catch (SQLException e) {}
            if ( conn != null ) try {
                conn.close();
            } catch (SQLException e) {}

        }
    }// end of public HRInfo(String empno) 
    
    public ArrayList getObjAL()
    {
        return objAL;
    }
    
    public String getStr()
    {
        return  returnStr;
    }
    
    public String getSql()
    {
        return sql;
    }
    
    public EgInfoObj getEGInfoObj(String empno) 
    {
        for(int i=0; i<objAL.size(); i++)
        {
            EgInfoObj obj = (EgInfoObj) objAL.get(i);
	        if(empno.equals(obj.getEmpn()) | empno.equals(obj.getSern()))
	        {
	            return obj;
	        }
        }
        return null;
    }   
    
}//end of class

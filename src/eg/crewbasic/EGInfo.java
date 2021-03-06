package eg.crewbasic;

import java.sql.*;
import java.util.*;
import ci.db.*;

/**
 * @author cs71 Created on 2005/10/6
 */
public class EGInfo
{
    private Statement stmt = null;
    private ResultSet rs = null;
    private Connection conn = null;
    private String sql = "";     
    private Driver dbDriver = null;
    private String returnStr = "";   
    private String empno = "";
    private String sern = "";
    private String cname = "";
    private ArrayList objAL = new ArrayList();

    public static void main(String[] args)
    {
        EGInfo c = new EGInfo("636777","","");
        c.getEgInfo();
        System.out.println(c.getObjAL().size());
        System.out.println("Done");
        
    }
    

    public EGInfo(String empno, String sern, String cname)
    {
        this.empno = empno;
        this.sern = sern;
        this.cname = cname;
        
    }
    
    public void getEgInfo()
    {
        try 
        {
            ConnDB cn = new ConnDB();   
//            cn.setORP3FZUser();
//            java.lang.Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() ,
//                    cn.getConnPW());            
            
    		cn.setORP3FZUserCP();
    		dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
    		conn = dbDriver.connect(cn.getConnURL(), null);
            stmt = conn.createStatement();

            sql = " SELECT Trim(empn) empn, sern, SECTION, cname, ename, d.cdept dept, c.jobno, i.cjob jobdesc, " +
		      	  " To_Char(hiredate,'yyyy/mm/dd') hiredate, To_Char(indate,'yyyy/mm/dd') indate, " +
		      	  " decode(status,'1','On Duty','2','Suspend','3','Resign','4','Transfer') status, " +
		      	  " decode(worktype,'1','Crew','2','Officer') worktype, " +
		      	  " Nvl(To_Char(ssdate,'yyyy/mm/dd'),' ') ssdate, station, id, sex, " +
		      	  " To_Char(birth,'yyyy/mm/dd') birth, Nvl(bplace,' ') bplace, Nvl(height,' ') height, " +
		      	  " Nvl(blood,' ') blood, Nvl(province,' ') province, Nvl(city,' ') city, " +
		      	  " decode(nation,'1','ROC','2','Japan','3','Singapore','4','Thailand'," +
		      	  " '5','THI','6','Malaysia','7','India','8','Vietnam') nation, " +
		      	  " Nvl(educate,' ') educate, Nvl(GROUPS,' ') GROUPS, cabin,green, passport, " +
		      	  " To_Char(passdate,'yyyy/mm/dd') passdate, To_Char(visadate,'yyyy/mm/dd') visadate, " +
		      	  " cmcno, Nvl(homeadrs,' ') homeadrs, Nvl(mailadrs,' ') mailadrs, Nvl(emailadrs,' ') emailadrs, " +
		      	  " phone1, phone2, phone3, phone4, phone5, emgname, emgphone1, emgphone2, resignno, " +
		      	  " To_Char(rsndate,'yyyy/mm/dd') rsndate, Nvl(newdept,' ') newdept, Nvl(comments,' ') comments, " +
		      	  " c.newuser newuser, c.newdate newdate, c.chguser chguser, c.chgdate chgdate, " +
		      	  " visatype, To_Char(visadate1,'yyyy/mm/dd') visadate1, " +
		      	  " ckscheckout, specialcode, bplace_en, smsphone, issuestate_app, " +
		      	  " To_Char(docissdate_app,'yyyy/mm/dd') docissdate_app, placeissue_app, last_name, " +
		      	  " first_name, rptloc FROM egtcbas c, egtdept d, egtjobi i " +
		      	  " where (trim(empn) = '"+empno+"' or sern = '"+sern+"' or cname like '"+cname+"') " +
		      	  " and c.deptno = d.deptno (+) and c.jobno = i.jobno(+)";
            
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
                obj.setJobdesc(rs.getString("jobdesc"));
                obj.setHiredate(rs.getString("hiredate"));
                obj.setIndate(rs.getString("indate"));
                obj.setStatus(rs.getString("status"));
                obj.setWorktype(rs.getString("worktype"));
                obj.setSsdate(rs.getString("ssdate"));
                obj.setStation(rs.getString("station"));
                obj.setId(rs.getString("id"));
                obj.setSex(rs.getString("sex"));
                obj.setBirth(rs.getString("birth"));
                obj.setBplace(rs.getString("bplace"));
                obj.setHeight(rs.getString("height"));
                obj.setBlood(rs.getString("blood"));
                obj.setNation(rs.getString("nation"));
                obj.setProvince(rs.getString("province"));
                obj.setCity(rs.getString("city"));
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
    
}//end of class

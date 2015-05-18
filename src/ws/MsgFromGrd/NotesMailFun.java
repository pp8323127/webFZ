package ws.MsgFromGrd;

import java.sql.*;
import java.util.*;

import ci.db.*;

public class NotesMailFun
{

    /**
     * @param args
     */
    NotesMailRObj noteMailObj = null;
    
    
//    public static void main(String[] args)
//    {
//        NotesMailFun f = new NotesMailFun();
////        f.getNotesMail();
////        f.getSitaCode();
//        f.getNotesMail("TPECS");
//        System.out.println("done");
//
//    }
    public void getNotesMail(){
        Driver dbDriver = null;
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;     
        String sql = null;
        noteMailObj = new NotesMailRObj();
        ArrayList<NotesMailObj> alnotes = new ArrayList<NotesMailObj>();
        ArrayList<SitaCodeObj> alsita = new ArrayList<SitaCodeObj>();
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
            sql = "SELECT employid," +
            	" Decode(cname, null, ename, cname) username," +
            	" Decode(sitacode, NULL, 'N/A', sitacode) sitacode," +
            	" Decode(email, NULL, employid || '@cal.aero', email) email," +
            	" Decode(email, null, 'N', 'Y') gotemail  FROM hrvegsitacd" +
            	" WHERE email IS NOT null ORDER BY gotemail desc, sitacode";
            rs = stmt.executeQuery(sql);
            if(rs != null){
                while(rs.next()){
                    NotesMailObj obj = new NotesMailObj();
                    obj.setEmployid(rs.getString("employid"));
                    obj.setUsername(rs.getString("username"));
                    obj.setEmail(rs.getString("email"));
                    obj.setSitacode(rs.getString("sitacode"));
                    alnotes.add(obj);
                }
                
                NotesMailObj obj1 = new NotesMailObj();
                obj1.setEmployid("TPEEFCI");
                obj1.setUsername("TPEEFCI");
                obj1.setEmail("TPEEFCI@china-airlines.com");
                obj1.setSitacode(rs.getString("sitacode"));
                alnotes.add(obj1);
            }
            if (rs != null) rs.close();
            
            sql = "SELECT DISTINCT(Nvl(sitacode,'N/A')) sitacode FROM hrvegsitacd ORDER BY sitacode";
            rs = stmt.executeQuery(sql);
            if(rs != null){    
                while(rs.next()){
                    SitaCodeObj obj = new SitaCodeObj();
                    obj.setSitaCode(rs.getString("sitaCode"));
                    alsita.add(obj);
                }
            }
            /**all notes address**/
            
            if(alnotes.size() > 0){
                NotesMailObj[] arr = new NotesMailObj[alnotes.size()];
                for(int i=0;i<alnotes.size();i++){
                    arr[i] = alnotes.get(i);
//                    System.out.println(arr[i].getEmail());
                }
                noteMailObj.setNoteMailarr(arr);
                noteMailObj.setResultMsg("1");
            }else{
                noteMailObj.setResultMsg("1");
                noteMailObj.setErrorMsg("No data!");
            }
            
            /**all sita code**/
            
            if(alsita.size() > 0){
                SitaCodeObj[] arr = new SitaCodeObj[alsita.size()];
                for(int i=0;i<alsita.size();i++){
                    arr[i] = alsita.get(i);
//                    System.out.println(arr[i].getSitaCode());
                }
                noteMailObj.setSitaCodearr(arr);
                noteMailObj.setResultMsg("2");
            }else{
                noteMailObj.setResultMsg("2");
                noteMailObj.setErrorMsg("No data!");
            }
        }
        catch ( Exception e )
        {
            noteMailObj.setResultMsg("0");
            noteMailObj.setErrorMsg(e.toString());
        }
        finally {
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
    public void getSitaCode(){
        Driver dbDriver = null;
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;     
        String sql = null;
        noteMailObj = new NotesMailRObj();
        ArrayList<SitaCodeObj> alsita = new ArrayList<SitaCodeObj>();
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
            sql = "SELECT DISTINCT(Nvl(sitacode,'N/A')) sitacode FROM hrvegsitacd ORDER BY sitacode";
            rs = stmt.executeQuery(sql);
            if(rs != null){    
                while(rs.next()){
                    SitaCodeObj obj = new SitaCodeObj();
                    obj.setSitaCode(rs.getString("sitaCode"));
                    alsita.add(obj);
                }
            }
            /**all sita code**/
            
            if(alsita.size() > 0){
                SitaCodeObj[] arr = new SitaCodeObj[alsita.size()];
                for(int i=0;i<alsita.size();i++){
                    arr[i] = alsita.get(i);
//                    System.out.println(arr[i].getSitaCode());
                }
                noteMailObj.setSitaCodearr(arr);
                noteMailObj.setResultMsg("1");
            }else{
                noteMailObj.setResultMsg("1");
                noteMailObj.setErrorMsg("No data!");
            }
        }
        catch ( Exception e )
        {
            noteMailObj.setResultMsg("0");
            noteMailObj.setErrorMsg(e.toString());
        }
        finally {
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
    
    public void getNotesMail(String sitaCode){
        Driver dbDriver = null;
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;     
        String sql = null;
        noteMailObj = new NotesMailRObj();
        ArrayList<NotesMailObj> alnotes = new ArrayList<NotesMailObj>();
        ArrayList<SitaCodeObj> alsita = new ArrayList<SitaCodeObj>();
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
            sql = "SELECT employid," +
                " Decode(cname, null, ename, cname) username," +
                " Decode(sitacode, NULL, 'N/A', sitacode) sitacode," +
                " Decode(email, NULL, employid || '@cal.aero', email) email," +
                " Decode(email, null, 'N', 'Y') gotemail  FROM hrvegsitacd" +
                " where sitacode = '"+sitaCode+"' and  email IS NOT null " +
                " ORDER BY gotemail desc, sitacode";
            rs = stmt.executeQuery(sql);
            if(rs != null){
                while(rs.next()){
                    NotesMailObj obj = new NotesMailObj();
                    obj.setEmployid(rs.getString("employid"));
                    obj.setUsername(rs.getString("username"));
                    obj.setEmail(rs.getString("email"));
                    obj.setSitacode(rs.getString("sitacode"));
                    alnotes.add(obj);
                }
            }
           
            /** notes address by sitacode**/
            if(alnotes.size() > 0){
                NotesMailObj[] arr = new NotesMailObj[alnotes.size()];
                for(int i=0;i<alnotes.size();i++){
                    arr[i] = alnotes.get(i);
//                    System.out.println(arr[i].getEmail());
                }
                noteMailObj.setNoteMailarr(arr);
                noteMailObj.setResultMsg("1");
            }else{
                noteMailObj.setResultMsg("1");
                noteMailObj.setErrorMsg("No data!");
            }
        }
        catch ( Exception e )
        {
            noteMailObj.setResultMsg("0");
            noteMailObj.setErrorMsg(e.toString());
        }
        finally {
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

package credit;

import java.io.*;
import java.sql.*;
import java.util.*;
import ci.db.*;

/**
 * @author cs71 Created on  2006/3/17
 */
public class importDB7
{
    public static void main(String[] args)
    {
        importDB7 g = new importDB7();
        g.readFile("tpeopen.csv");
        System.out.println("Done 1 ");
        g.getImportData();  
        System.out.println("Done 2");  
        g.insDB();
        //System.out.println(g.isExist());
//        System.out.println(g.insDB());
        //System.out.println(g.updDB());
        System.out.println("Done 3");        
    }   

    private String filename = null;
    private String path 	= "C:\\EG\\";
    private String userid 	= "";
    private String mark 	= "";
	private Connection conn = null;
	private Driver dbDriver = null;
	private Statement stmt = null;
	private PreparedStatement pstmt = null;
	private PreparedStatement pstmt2 = null;
	private ResultSet rs = null; 
	private String sql = "";
	private String sql2 = "";
	private String returnstr = "The file is blank !";
	private String returnstr2 = "he file is blank !";
	private ArrayList objAL = new ArrayList();
	private ArrayList obj2AL = new ArrayList();

        public String readFile(String filename)
        {
            try
            {
    			java.io.File file_in=new java.io.File(path+filename);
    			BufferedReader br = new BufferedReader(new FileReader(file_in));
    			StringBuffer sb = null;
    			String str = null;
    			int firstline = 1;
    			expObj7 emptyobj = new expObj7();
    			objAL.add(emptyobj);
    			while ((str = br.readLine()) != null) 
    			{
    			    //the first line for column name, ignore
    			    if (firstline > 2)
    			    {
    					tool.splitString s = new tool.splitString();
    					String[] token = s.doSplit(str,",");
                        expObj7 obj = new expObj7();
                        obj.setCol1(token[0]);  	
                        obj.setCol2(token[1]);       
                        obj.setCol3(token[2]); 
//                        System.out.print(token[3]+"  ");
                        obj.setCol4(token[3].trim().substring(0,token[3].trim().indexOf(" "))); 
                        obj.setCol23(token[3].substring(token[3].trim().indexOf(" ")+1));
//                        System.out.println("|"+obj.getCol23());    		
                        obj.setCol5(token[4]); 
                        obj.setCol6(token[5]); 
                        obj.setCol7(token[6]); 
                        obj.setCol8(token[7]); 
                        obj.setCol9(token[8]); 
                        obj.setCol10(token[9]); 
                        obj.setCol11(token[10]); 
                        obj.setCol12(token[11]); 
                        obj.setCol13(token[12]); 
                        obj.setCol14(token[13]); 
                        obj.setCol15(token[14]); 
                        obj.setCol16(token[15]); 
                        obj.setCol17(token[16]); 
                        obj.setCol18(token[17]); 
                        obj.setCol19(token[18]); 
                        obj.setCol20(token[19]); 
                        obj.setCol21(token[20]); 
                        obj.setCol22(token[21]); 
    	                objAL.add(obj);  
    			    }
    			    firstline ++;
    			}
    			br.close();
    			objAL.add(emptyobj);
//    			System.out.println(objAL.size());
//    			for(int i=1; i<objAL.size()-1; i++)
//    			{
//    			    expObj7 obj = (expObj7) objAL.get(i);
//    			    System.out.print(( i+1)+"   ");
//    			    System.out.print(obj.getCol1()+"  -- ");
//    			    System.out.print(obj.getCol2()+"  -- ");
//    			    System.out.print(obj.getCol3()+"  -- ");
//    			    System.out.print(obj.getCol4()+"  -- ");
//    			    System.out.print(obj.getCol5()+"  -- ");
//    			    System.out.print(obj.getCol6()+"  -- ");
//    			    System.out.print(obj.getCol7()+"  -- ");
//    			    System.out.print(obj.getCol8()+"  -- ");
//    			    System.out.print(obj.getCol9()+"  -- ");
//    			    System.out.print(obj.getCol10()+"  -- ");
//    			    System.out.print(obj.getCol11()+"  -- ");
//    			    System.out.print(obj.getCol12()+"  -- ");    
//    			    System.out.print(obj.getCol13()+"  -- ");
//    			    System.out.print(obj.getCol14()+"  -- ");
//    			    System.out.print(obj.getCol15()+"  -- ");
//    			    System.out.print(obj.getCol16()+"  -- ");
//    			    System.out.print(obj.getCol17()+"  -- ");
//    			    System.out.print(obj.getCol18()+"  -- ");
//    			    System.out.print(obj.getCol19()+"  -- ");
//    			    System.out.print(obj.getCol20()+"  -- ");
//    			    System.out.print(obj.getCol21()+"  -- ");
//    			    System.out.println(obj.getCol22()+"  -- ");  
//    			    System.out.println(obj.getCol23()+"  -- ");    		
//    			    System.out.println("");  
//    			}
            }
            catch (Exception e)
            {
            	System.out.print("Error 2 : "+e.toString());                
            }
            finally
            {            
            	//try{if(rs != null) rs.close();}catch(SQLException e){}
            	//try{if(stmt != null) stmt.close();}catch(SQLException e){}
            	//try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
            	//try{if(conn != null) conn.close();}catch(SQLException e){}	
            }
            
            return returnstr;
        }
        
        public void getImportData()
        {
            expObj7 nobj = new expObj7();
            ArrayList detailAL = null;
            for(int i=1; i<objAL.size()-1; i++)
            {
                expObj7 bobj = (expObj7) objAL.get(i-1);
                expObj7 obj = (expObj7) objAL.get(i);
                expObj7 aobj = (expObj7) objAL.get(i+1);
                
                if(obj.getCol2() != null && !"".equals(obj.getCol2()))
                {
                    detailAL = new ArrayList();
                    nobj = new expObj7();
                    nobj.setCol1(obj.getCol2());//tripno
                    nobj.setCol2(obj.getCol4());//sdate
                    nobj.setCol3(obj.getCol6());//ac                    
                    nobj.setCol6(obj.getCol11());//pr
                    nobj.setCol7(Integer.toString(Integer.parseInt(obj.getCol12())+Integer.parseInt(obj.getCol13())));//ff
                    nobj.setCol8(obj.getCol15());//fc
                    nobj.setCol9(obj.getCol16());//my
                    nobj.setCol10(obj.getCol17());//fy
                    nobj.setCol11(obj.getCol18());//trip length
                    nobj.setCol12(obj.getCol19());//long 越洋or區域                  
                } 
                //fltno
                if(nobj.getCol4()== null | "".equals(nobj.getCol4()))
                {
                    nobj.setCol4(obj.getCol7());//fltno
                }
                else
                {
                    nobj.setCol4(nobj.getCol4()+"/"+obj.getCol7());//fltno
                }
                
                //trip sector
                if(nobj.getCol5()== null | "".equals(nobj.getCol5()))
                {
                    nobj.setCol5(obj.getCol8()+"/"+obj.getCol9());//trip sector
                }
                else
                {
                    nobj.setCol5(nobj.getCol5()+"/"+obj.getCol9());//trip sector
                }
                
//              **************************************************************
                //set trip detail
                EPickSkjDetailObj detailObj = new EPickSkjDetailObj();
                detailObj.setFltno(obj.getCol7());
                detailObj.setFltd(obj.getCol4()+" "+obj.getCol23());
                detailObj.setDuty(obj.getCol5());
                detailObj.setDep(obj.getCol8());
                detailObj.setArr(obj.getCol9());
                detailObj.setCd(obj.getCol10());
                detailAL.add(detailObj);
                //**************************************************************
                
                //if tripno  == null
                //set trip combination
//                if(obj.getCol2() == null || "".equals(obj.getCol2()))
//                {   
//                    //若為越洋線
//                    if("Y".equals(obj.getCol19()))
//                    {
////                      day difference obj.fltd - bobj.fltd
//                        Calendar date1 = new GregorianCalendar();
//                        tool.splitString s = new tool.splitString();
//    					String[] token = s.doSplit(bobj.getCol4(),"/");
//                        date1.set(Integer.parseInt(token[0]),Integer.parseInt(token[1])-1,Integer.parseInt(token[2]));
//              
//                        Calendar date2 = new GregorianCalendar();
//                        String[] token2 = s.doSplit(obj.getCol4(),"/");
//                        date2.set(Integer.parseInt(token2[0]),Integer.parseInt(token2[1])-1,Integer.parseInt(token2[2]));
//                        long diffdays = (date2.getTimeInMillis()-date1.getTimeInMillis())/60/60/1000/24;   
//                        
////                        System.out.println(nobj.getCol1()+" ** "+Integer.parseInt(obj.getCol23().replaceAll(":","")) + " ** " +Integer.parseInt(aobj.getCol23().replaceAll(":","")));
////                        若下一班的時間早於前一班時間,不滿一天
//                        if(Integer.parseInt(obj.getCol23().replaceAll(":","")) < Integer.parseInt(aobj.getCol23().replaceAll(":","")))
//                        {
//                            if(diffdays>1)
//                            {
//                                diffdays = diffdays-1;
//                            }
//                        }                        
//                        
//	                    if(nobj.getCol13()== null | "".equals(nobj.getCol13()))
//	                    {
//	                        nobj.setCol13(String.valueOf(diffdays));//set trip combination
//	                    }
//	                    else
//	                    {
//	                        nobj.setCol13(nobj.getCol13()+"-"+String.valueOf(diffdays));//trip sector
//	                    }                    
//                    }
//                }
                
                if(aobj.getCol2() != null && !"".equals(aobj.getCol2())) 
                {//下一筆為新的trip
                    nobj.setDetailAL(detailAL);
                    obj2AL.add(nobj);
                }
            }//for(int i=1; i<objAL.size()-1; i++)
            nobj.setDetailAL(detailAL);
            obj2AL.add(nobj);
            //*****************************************************************************************            
//            System.out.println("obj2AL.size() "+ obj2AL.size());
//            
//            for(int i=0; i<obj2AL.size(); i++)
//			{
//			    expObj7 obj = (expObj7) obj2AL.get(i);
//			    System.out.print(( i+1)+"   ");
//			    System.out.print(obj.getCol1()+"  # ");
//			    System.out.print(obj.getCol2()+"  # ");
//			    System.out.print(obj.getCol3()+"  # ");
//			    System.out.print(obj.getCol4()+"  # ");
//			    System.out.print(obj.getCol5()+"  # ");
//			    System.out.print(obj.getCol6()+"  # ");
//			    System.out.print(obj.getCol7()+"  # ");
//			    System.out.print(obj.getCol8()+"  # ");
//			    System.out.print(obj.getCol9()+"  # ");
//			    System.out.print(obj.getCol10()+"  # ");
//			    System.out.print(obj.getCol11()+"  # ");
//			    System.out.print(obj.getCol12()+"  # ");    
//			    System.out.print(obj.getCol13()+"  # ");  			  
//			    System.out.println("");  
//			}
        }
        
        public String insDB()
        {
            int sno = 0;
            ArrayList dAL = new ArrayList();
            if (obj2AL.size() > 0)
            {
                try
                {
                    ConnDB cn = new ConnDB();      	 
                    cn.setORT1FZ();
                    java.lang.Class.forName(cn.getDriver());
                    conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID(),cn.getConnPW()); 
                    stmt = conn.createStatement();
                   
                    sql = " insert into fztpskj(seq,fltd,weekday,fltno,trip_sect,flt_length," +
                    	  " fleet,longrange,station,published,published_date,new_user,new_date," +
                    	  " delete_flag,delete_user,delete_date,chg_user,chg_date,pr,ff,fy,fc,my) values " +
                    	  " (?,to_date(?,'yyyy/mm/dd'),(SELECT to_char(to_date(?,'yyyy/mm/dd'),'DY','NLS_DATE_LANGUAGE=AMERICAN') FROM dual)," +
                    	  " ?,?,?,?,?,'TPE','N',sysdate,'SYS',sysdate,null,null,null,null,null,?,?,?,?,?)";
                  
    	            pstmt = conn.prepareStatement(sql);
    	            int count =0;    	   
//    	            System.out.println("objAL.size() = "+objAL.size());
    	            for(int i=0; i<obj2AL.size(); i++)
    	            {
    	                sno = 0;
                        rs = stmt.executeQuery("SELECT Nvl(Max(seq),0)+1 sno FROM fztpskj");
            		    if (rs.next())
            			{
            		        sno = rs.getInt("sno");
            			}
            		    rs.close();
	                
    	                int j = 1;
    	                expObj7 obj1 = (expObj7) obj2AL.get(i);        	                
    	                dAL = obj1.getDetailAL();    
    	                
    	                pstmt.setInt(j, sno);
    	                pstmt.setString(++j, obj1.getCol2().trim());
    	                pstmt.setString(++j, obj1.getCol2().trim());
    	                pstmt.setString(++j, obj1.getCol4().trim());
    	                pstmt.setString(++j, obj1.getCol5().trim());     	                
    	                pstmt.setString(++j, obj1.getCol11().trim()); 
    	                pstmt.setString(++j, obj1.getCol3().trim());     	              
    	                pstmt.setString(++j, obj1.getCol12().trim());     	                
    	                pstmt.setString(++j, obj1.getCol6().trim()); 
    	                pstmt.setString(++j, obj1.getCol7().trim()); 
    	                pstmt.setString(++j, obj1.getCol10().trim()); 
    	                pstmt.setString(++j, obj1.getCol8().trim()); 	
    	                pstmt.setString(++j, obj1.getCol9().trim());   
    	        		pstmt.executeUpdate();
    	               

//System.out.println("insert into fztpskj (seq,fltd,weekday,fltno,trip_sect,flt_length," +
//" fleet,longrange,station,published,published_date,new_user,new_date," +
//" delete_flag,delete_user,delete_date,chg_use,chg_date,pr,ff,fy,fc,my) values ('"+sno+"'," +
//" to_date('"+obj1.getCol2().trim()+"','yyyy/mm/dd'), " +
//" (SELECT to_char(to_date('"+obj1.getCol2().trim()+"','yyyy/mm/dd'),'DY','NLS_DATE_LANGUAGE=AMERICAN') FROM dual),'"+obj1.getCol4().trim()+"','"+obj1.getCol5().trim()+"','"+obj1.getCol11().trim()+"','"+obj1.getCol3().trim()+"','"+obj1.getCol12().trim()+"','TPE','N',sysdate,'SYS',sysdate," +
//" null,null,null,null,null,'"+obj1.getCol6().trim()+"','"+obj1.getCol7().trim()+"','"+obj1.getCol10().trim()+"','"+obj1.getCol8().trim()+"','"+obj1.getCol9().trim()+"')");
		
    	                
    	                sql2 = " insert into fztskjd (seq, fltno, fltd, duty,  dep, arr, cd) values " +
    	                	   " (?,?,to_date(?,'yyyy/mm/dd hh24:mi'),?,?,?,?)";   	                
    	                
    	                pstmt2 = conn.prepareStatement(sql2);
    	                for(int d=0; d<dAL.size(); d++)
    	                {
    	                    EPickSkjDetailObj detailObj = (EPickSkjDetailObj) dAL.get(d);
    	                    int jj = 1;
    	                    pstmt2.setInt(jj, sno);
        	                pstmt2.setString(++jj, detailObj.getFltno());
        	                pstmt2.setString(++jj, detailObj.getFltd());
        	                pstmt2.setString(++jj, detailObj.getDuty());     	                
        	                pstmt2.setString(++jj, detailObj.getDep()); 
        	                pstmt2.setString(++jj, detailObj.getArr()); 
        	                pstmt2.setString(++jj, detailObj.getCd());
        	                pstmt2.executeUpdate();
    	                }    	                
                    }
//                    
    				returnstr2 = "0";
                }	 
    	        catch (Exception e)
    	        {
    	            returnstr2 = e.toString();
    	            System.out.println(e.toString());
    	        }
    	        finally
    	        {            
    	            try{if(rs != null) rs.close();}catch(SQLException e){}
    	            try{if(stmt != null) stmt.close();}catch(SQLException e){}
    	            try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
    	        	try{if(pstmt2 != null) pstmt2.close();}catch(SQLException e){}
    	        	try{if(conn != null) conn.close();}catch(SQLException e){}	
    	        }		            
    	   }        
    	   return returnstr2;
        }    
}

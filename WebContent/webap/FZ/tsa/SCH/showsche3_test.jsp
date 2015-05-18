<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*, sch.*, fz.UnicodeStringParser, javax.sql.DataSource, javax.naming.*, java.util.*, java.io.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%!
Context initContext = null;
DataSource ds = null;
	
String schFile(String fmm, String inEmpno) {
		
		String output = "";
		
		Connection dbCon = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		//Driver dbDriver = null;
		
		int lday = 0;
		String sql = null;
		
		ArrayList empn = new ArrayList();
		ArrayList thename = new ArrayList();
		String empno = null;
		String cname = null;

		int sdd = 0;
		int edd = 0;
		int sloc = 0;
		String shh = null;
		String ehh = null;
		String fltno = null;
		String dutycd = null;
		String copcd = null;
		String dpt = null;
		String arv = null;
		String sernum = null;
		
		FileWriter fw = null;
		String[] w = {"SU","MO","TU","WE","TH","FR","SA"};
		String[] sch;
		String wstring = "";
		
		output += "<br>flag1 ";
		
		try{
			fw =new FileWriter("/apsource/csap/projfz/webap/"+fmm+inEmpno+".csv", false);
			UnicodeStringParser usp = new UnicodeStringParser();
			initContext = new InitialContext();
			
			//connect to AOCITEST / AOCIPROD by Datasource
		    ds = (javax.sql.DataSource)initContext.lookup("CAL.FZDS03");
		    dbCon = ds.getConnection();
			
			//dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();//*****
			//dbCon = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP03", null);//*****
			
			//get the last day of input month
			sql = "select to_char(last_day(to_date(?,'yyyymm')),'dd') lday from dual";
			
			pstmt = dbCon.prepareStatement(sql);
			pstmt.setString(1,fmm);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				lday = rs.getInt("lday");
				rs.close();
			}
			sch = new String[lday];
			
			//***表頭製作***
			int yy = Integer.parseInt(fmm.substring(0, 4));
			int mm = Integer.parseInt(fmm.substring(4, 6)) - 1;
			Calendar Calendar = new GregorianCalendar(yy, mm, 1);
			int dayOfWeek = Calendar.get(Calendar.DAY_OF_WEEK);
			int keepindex = dayOfWeek - 1;
			fw.write(fmm + "  " + inEmpno + " ROSTER\n");
			
			for(int i=1; i<=lday; i++){
				wstring = wstring + String.valueOf(i) + " " + w[keepindex] + ",";
				if(keepindex == 6){
					keepindex = 0;
				}
				else{
					keepindex++;
				}
			}
			wstring = "," + wstring.substring(0, wstring.length()-1) + ",CR.,BK.,Qual\n";
			fw.write(wstring);
			wstring = "";
			//***end 表頭製作***
			
			sql = "select c.staff_num empno, c.preferred_name cname, c.seniority_code code, k.rank_cd rank, rt.priority_no pno " +
			"from crew_v c, crew_rank_v k, rank_tp_v rt, crew_fleet_v f " +
			"where c.staff_num=k.staff_num " + 
			"and c.staff_num=f.staff_num " +   
			"and c.staff_num=? " + 
			"and emp_status='A' " +
			"and (f.exp_dt is null or f.exp_dt >= sysdate) " +
			"and (k.exp_dt is null or k.exp_dt >= sysdate) " +  
			"and k.rank_cd=rt.display_rank_cd " + 
			"and rt.fd_ind='Y' " +
			"order by pno, code, empno";
			
			pstmt = dbCon.prepareStatement(sql);
		  pstmt.setString(1,inEmpno);
		  rs = pstmt.executeQuery();
		
			while(rs.next()){ //while 1.
				empn.add(rs.getString("empno"));
				thename.add(new String(usp.removeExtraEscape(rs.getString("cname")).getBytes(), "Big5"));
			} //end while 1.
			rs.close();
			pstmt.close();
			
			for(int j=0; j < empn.size(); j++){
				//******get crew schedule info******//
				sql = "select r.staff_num empno, c.preferred_name cname, " +  
				"to_char(d.act_str_dt_tm_gmt,'dd') sdd, " +   
				"to_char(d.act_end_dt_tm_gmt,'dd') edd, " +   
				"to_char(d.act_str_dt_tm_gmt,'HH24MI') shh, " +   
				"to_char(d.act_end_dt_tm_gmt,'HH24MI') ehh, " +   
				"to_char(d.str_dt_tm_loc,'HH24') sloc, " +  
				"lpad(nvl(d.flt_num,''),4,'0') fltno, r.series_num sernum, " +  
				"decode(d.duty_cd,'LO','---',nvl(d.duty_cd,'')) dutycd, nvl(d.cop_duty_cd,'') copcd, " +   
				"d.port_a dpt, d.port_b arv, c.seniority_code code, k.rank_cd rank, rt.priority_no pno " +  
				"from roster_v r, duty_prd_seg_v d, crew_v c, crew_fleet_v f, crew_rank_v k, rank_tp_v rt " +  
				"where r.series_num=d.series_num " +
				"and r.staff_num=c.staff_num " +
				"and c.staff_num=f.staff_num " +  
				//"and f.fleet_cd=? " + 
				"and c.staff_num=k.staff_num " + 
				"and (k.exp_dt is null or k.exp_dt >= sysdate) " + 
				"and (f.exp_dt is null or f.exp_dt >= sysdate) " +  
				"and k.rank_cd=rt.display_rank_cd " +
				"and rt.fd_ind='Y' " +
				"and r.staff_num='"+empn.get(j)+"' " +   //********
				"and d.act_str_dt_tm_gmt between to_date(?,'yyyymmddHH24MI') and last_day(to_date(?,'yyyymmHH24MI')) " +
				//"and to_char(d.act_str_dt_tm_gmt,'yyyymm')=? " +
				"and r.delete_ind='N' and d.duty_cd<>'RST' " +  
				"union all " +
				"select r.staff_num empno, c.preferred_name cname, " +  
				"to_char(r.act_str_dt,'dd') sdd, " +   
				"to_char(r.act_end_dt,'dd') edd, " +   
				"to_char(r.act_str_dt,'HH24MI') shh, " +   
				"to_char(r.act_end_dt,'HH24MI') ehh, " +   
				"to_char(r.act_str_dt,'HH24') sloc, " +  
				"'' fltno, 0 sernum, " +  
				"r.duty_cd dutycd, '' copcd, " +  
				"r.location_cd dpt, r.location_cd arv, c.seniority_code code, k.rank_cd rank, rt.priority_no pno " +  
				"from roster_v r, crew_v c, crew_fleet_v f, crew_rank_v k, rank_tp_v rt " + 
				"where r.series_num=0 " +
				"and r.staff_num=c.staff_num " +
				"and c.staff_num=f.staff_num " +
				//"and f.fleet_cd=? " +			
				"and c.staff_num=k.staff_num " + 
				"and (k.exp_dt is null or k.exp_dt >= sysdate) " +
				"and (f.exp_dt is null or f.exp_dt >= sysdate) " + 
				"and k.rank_cd=rt.display_rank_cd " +
				"and rt.fd_ind='Y' " +
				"and r.staff_num='"+empn.get(j)+"' " +   //********
				"and r.act_str_dt between to_date(?,'yyyymmddHH24MI') and last_day(to_date(?,'yyyymmHH24MI')) " +
				//"and to_char(r.act_str_dt,'yyyymm')=? " +
	   			"and r.delete_ind='N' " + 
	   			"order by pno, code, empno, sdd, edd";
	   			
				pstmt = dbCon.prepareStatement(sql);
				//pstmt.setString(1,fleet);
				pstmt.setString(1,fmm+"010000");
				pstmt.setString(2,fmm+"2359");
				//pstmt.setString(4,fleet);
				pstmt.setString(3,fmm+"010000");
				pstmt.setString(4,fmm+"2359");
				rs = pstmt.executeQuery() ;
				
				output += "<br>flag2 ";
						
				while(rs.next()){ //while 2.
					output += "<br>================================ ";
					
					//empno = rs.getString("empno");
					//cname = rs.getString("cname");
					//Big5Cname = new String(usp.removeExtraEscape(cname).getBytes(), "Big5");
					sdd = rs.getInt("sdd");
					edd = rs.getInt("edd");
					
					output += "<br>sch["+String.valueOf(sdd-1)+"]= "+sch[sdd - 1];
						
					
					sloc = rs.getInt("sloc");
					shh = rs.getString("shh");
					ehh = rs.getString("ehh");
					fltno = rs.getString("fltno");
					sernum = rs.getString("sernum");
					dutycd = rs.getString("dutycd");
					copcd = rs.getString("copcd");
					if("000".equals(copcd)) copcd = "";
					if(copcd == null) copcd = "";
					
					output += "<br>flag2.1 ";
					output += "<br>sdd= "+String.valueOf(sdd);
					output += "<br>edd= "+String.valueOf(edd);
					output += "<br>sloc= "+String.valueOf(sloc);
					output += "<br>shh= "+shh;
					output += "<br>ehh= "+ehh;
					output += "<br>fltno= "+fltno;
					output += "<br>sernum= "+sernum;
					output += "<br>dutycd= "+dutycd;
					output += "<br>copcd= "+copcd;
					
					fltno = getTrainFun((String)empn.get(j), sernum, dbCon) + copcd + fltno; //ROSTER_SPECIAL_DUTIES_TRG_V : training_function
					
					output += "<br>fltno= "+fltno;
										
					dpt = rs.getString("dpt");
					arv = rs.getString("arv");
					
					output += "<br>dpt= "+dpt;
					output += "<br>arv= "+arv;
										
					if(sch[sdd - 1]==null || "---".equals(sch[sdd - 1])) {
						output += "<br>set sch["+String.valueOf(sdd - 1)+"]=''";
						sch[sdd - 1]="";
					}
					
					if(sch[edd - 1]==null) {
						output += "<br>set sch["+String.valueOf(edd - 1)+"]=''";
						sch[edd - 1]="";
					}
					
					output += "<br>flag2.2 ";
					
					if("FLY".equals(dutycd) || "TVL".equals(dutycd)){
						output += "<br>flag2.3 ";
						
						//here
						output += "<br>sch["+String.valueOf(sdd-1)+"]= "+sch[sdd - 1];
						//dpt date = arv date just show fltno
						//if(sch[sdd - 1].length() >= 11) sch[sdd - 1] = sch[sdd - 1].substring(0, sch[sdd - 1].lastIndexOf(" ")) + " ";
						if(sch[sdd - 1].length() >= 8) {
							if (sch[sdd - 1].indexOf(" ") > 0) {
								sch[sdd - 1] = sch[sdd - 1].substring(0, sch[sdd - 1].indexOf(" ")) + " ";
							}
						}
						
						output += "<br>flag2.31 ";
						
						//loc time 凌晨02:00以前加'*'
						if(sloc < 2) 
							sch[sdd - 1] = sch[sdd - 1] + "*";
						
						output += "<br>flag2.32 ";
						
						if(sdd == edd){
							output += "<br>flag2.33 ";
							if("".equals(sch[sdd - 1])){
								sch[sdd - 1] = sch[sdd - 1] + fltno + " " + dpt + arv;
							}
							else{
								sch[sdd - 1] = sch[sdd - 1] + fltno + " ";
							}
							output += "<br>sch["+String.valueOf(sdd-1)+"]= "+sch[sdd - 1];
						}
						else{
							output += "<br>flag2.34 ";
							sch[sdd - 1] = sch[sdd - 1] + fltno + " " + dpt;
							//跨月資料不顯示
							if(edd >= sdd) 
								sch[edd - 1] = sch[edd - 1] + arv;
							
							output += "<br>sch["+String.valueOf(sdd-1)+"]= "+sch[sdd - 1];
						}
						output += "<br>flag2.39 ";
					}
					else{
						output += "<br>flag2.4 ";
					
						if("---".equals(dutycd)){
							for(int i = sdd - 1; i < edd; i++){
								if("".equals(sch[i]) || sch[i]==null) 
									sch[i] = "---";
							}
							//sch[sdd - 1] = sch[sdd - 1] + dutycd;
						}
						else if("ADO".equals(dutycd) || "BOFF".equals(dutycd)){
							//don't show anything on schedule
						}
						else{
							if("GDT".equals(dutycd) || "GST".equals(dutycd) || dutycd.indexOf("SIM") > -1){
								sch[sdd - 1] = sch[sdd - 1] + dutycd+" "+shh+" "+ehh;
							}
							else{
								sch[sdd - 1] = sch[sdd - 1] + dutycd;
							}
						}
						output += "<br>sch["+String.valueOf(sdd-1)+"]= "+sch[sdd - 1];
						
					}
				} //end while 2.
				
				output += "<br>flag3 ";
						
				fw.write(empn.get(j) + " " + thename.get(j) + " " + getBase((String)empn.get(j), dbCon) + ",");
				wstring = "";
				for(int i=0; i<sch.length; i++){
					if(sch[i]==null) sch[i]="";
					wstring = wstring + sch[i] + ",";
				}
				
				output += "<br>flag4 ";
						
				//get flight crew created hours
				String cr = getCr((String)empn.get(j), fmm, dbCon);
				//get flight crew qualification 
				String qual = getQual((String)empn.get(j), dbCon);
				//****************************
				//wstring = wstring.substring(0, wstring.length()-1) + ","+cr+"\n";
				wstring = wstring.substring(0, wstring.length()-1) + ","+cr+","+qual+","+empn.get(j)+","+thename.get(j)+"\n";
				fw.write(wstring);
				wstring = "";
				sch = null;
				sch = new String[lday];
				rs.close();
				pstmt.close();
			} //end for

			return "0";
			
		} catch(Exception e) {
			return (output + "<br>schFile:"+e.toString()); //connect error or retrieve date error
			//return sql;
		}
		finally {
			try{fw.flush();}catch(Exception e){}
		  	try{if(fw != null) fw.close();}catch(Exception e){}
			try{if(rs != null) rs.close();}catch(SQLException e){}
			try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
	   		try{if(dbCon != null) dbCon.close();}catch(SQLException e){}
		}
	}
	
	
	String getCr(String empno, String fmm, Connection con) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = null;
		String cr = null;
		
		try{
			sql = "SELECT round(Sum(non_std_fly_hours)/60, 3)||','||round(Sum(rem_fh_28)/60, 3) cr " +
			"FROM crew_cum_hr_tc_v WHERE staff_num=? " + 
			"AND cal_dt BETWEEN To_Date(?,'yyyymmdd hh24mi') " + 
			"AND Last_Day(To_Date(?,'yyyymmdd hh24mi'))";
			pstmt = con.prepareStatement(sql);
      pstmt.setString(1,empno);
      pstmt.setString(2,fmm+"01 0000");
      pstmt.setString(3,fmm+"01 2359");
      
      rs = pstmt.executeQuery() ;
      
      while(rs.next()){
      	cr = rs.getString("cr");
      }
			return cr;
		} catch(Exception e) {
			return ("getCr:"+e.toString()); //connect error or retrieve date error
		}
		finally {
			try{if(rs != null) rs.close();}catch(SQLException e){}
	  	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
		}
	}
	
	String getBase(String empno, Connection con) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = null;
		String base = "";
		
		try{
			sql = "select base from crew_base_v where staff_num=? and (exp_dt is null or exp_dt >= sysdate)";
			
			pstmt = con.prepareStatement(sql);
      pstmt.setString(1,empno);
      rs = pstmt.executeQuery() ;
      
      while(rs.next()){
      	if("TPE".equals(rs.getString("base")) || "TSA".equals(rs.getString("base"))){
        }
        else{
        	if("".equals(base)){
        		base = rs.getString("base");
        	}
        	else{
        		base = base + "/" + rs.getString("base");
        	}
      	}
      }
			return base;
		} catch(Exception e) {
			return ("getBase:" + e.toString()); //connect error or retrieve date error
		}
		finally {
			try{if(rs != null) rs.close();}catch(SQLException e){}
	  	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
		}
	}
	
	String getQual(String empno, Connection con) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = null;
		String qual = "";
		
		try{
			sql = "select qual_cd " +
			"from crew_qualifications_v " +
			"where staff_num = ? " + 
			"and qual_cd in ('E1N2','W1N2') " +
			"and (expiry_dts >= sysdate or expiry_dts is null) " +
			"order by actuals_status desc";
			
			pstmt = con.prepareStatement(sql);
      pstmt.setString(1,empno);
      rs = pstmt.executeQuery() ;
      
      if(rs.next()){ //取第一筆qual
      	qual = rs.getString("qual_cd");
      }
			return qual;
		} catch(Exception e) {
			return ("getQual:" + e.toString()); //connect error or retrieve date error
		}
		finally {
			try{if(rs != null) rs.close();}catch(SQLException e){}
	  	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
		}
	}
	
	String getTrainFun(String empno, String sernum, Connection con) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = null;
		String tf = "";
		
		try{
			sql = "SELECT training_function " +
			      "FROM  ROSTER_SPECIAL_DUTIES_TRG_V " +
			      "where staff_num = ? and series_num = ?";
			
			pstmt = con.prepareStatement(sql);
      pstmt.setString(1,empno);
      pstmt.setInt(2,Integer.parseInt(sernum));
      rs = pstmt.executeQuery() ;
		        
      if(rs.next()){
      	tf = rs.getString("training_function");
      	if(tf == null) tf = "";
      }
			return tf;
		} catch(Exception e) {
			return "getTrainFun : " + e.toString(); //connect error or retrieve date error
		}
		finally {
			try{if(rs != null) rs.close();}catch(SQLException e){}
	  	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
		}
	}
%>

<html>
<head>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
/*String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first
	response.sendRedirect("../sendredirect.jsp");
} */
%>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Monthly Schedule</title>
<link href="../../menu.css" rel="stylesheet" type="text/css">
</head>
<body>
<div align="center">
<%

String yy = request.getParameter("yy");
String mm = request.getParameter("mm");
String empno = request.getParameter("empno");
String filename = yy + mm + empno;
//out.println(yy + "," + mm + "," + empno);

//MonthlySch3 ms = new MonthlySch3();
//String rs = ms.schFile(yy+mm, empno);
String rs = schFile(yy+mm, empno);

if("0".equals(rs)){
%>
  <p class="txttitletop">檔案下載/Download File</p>
  <p><a href="../../sample6.jsp?filename=<%=filename%>.csv"><img src="../../images/floder2.gif" width="31" height="27" border="0"><%=filename%> download</a></p>
<%
}
else{
%>
  <p class="txttitletop">檔案製作失敗 : <%=rs%></p>
<%
}

%>
</div>
</body>
</html>

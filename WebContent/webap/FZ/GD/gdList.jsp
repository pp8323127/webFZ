<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,fz.gd.*,java.util.*" %>
<%
String fullUCD = (String) session.getAttribute("fullUCD");//登入CII時，取得之登入者單位代碼
String yyyy = (String) request.getParameter("sel_year") ; 
String mm = (String) request.getParameter("sel_mon") ; 
String dd = (String) request.getParameter("sel_dd") ; 
String fltdate = yyyy+"/"+mm+"/"+dd; // 傳入的查詢日期, format: yyyy/mm/dd

// Betty add start
String ftime = (String) request.getParameter("ftime") ; 
// Betty add end
//String arln = (String) request.getParameter("arln") ; 
String arln = "";
String fltno = (String) request.getParameter("fltno") ; 
String dpt = (String) request.getParameter("dpt") ; 
String str_getWebEgData ="";
String str_getGDFromDB2 ="";
String error = "";

boolean chnflt = false; //CS40 2010-4-27 remove word CHINA in TWN-CHN flts

swap3ac.PublishCheck pc = new swap3ac.PublishCheck(fltdate.substring(0,4), fltdate.substring(5,7));

//非航務、空服簽派者，才檢查班表是否公佈
if( (!"190A".equals(fullUCD) && !"068D".equals(fullUCD)) 
	&& !pc.isPublished()){
%>
<div style="background-color:#99FFFF;text-align:center;color:#FF0000;font-family:Verdana;font-size:10pt; ">
		<%=fltdate.substring(0,7)%>班表尚未正式公佈!!
</div>
<%
}
else
{
WebGdObj objInfo = new WebGdObj();
WebGd we = new WebGd();
// Betty add start
we.getWebEgData(arln,yyyy+"/"+mm+"/"+dd,fltno,dpt,ftime);
// Betty add end

//out.print(we.getSql());
str_getWebEgData = we.getStr();
objInfo = we.getObjInfo();
we.getGDFromDB2(fltno, yyyy+"/"+mm+"/"+dd, dpt);
str_getGDFromDB2 = we.getStr();

ArrayList objAL = new ArrayList();
String arln_fullname = "";
String fdate = "";
String acno = "";
String fltno2 = "";
String dpt_fullname = "";
String arv_fullname = "";
String dpt_short = "";
String arv_short = "";
String dpt_ctry = "";
String arv_ctry = "";


if("Y".equals(str_getWebEgData) && "Y".equals(str_getGDFromDB2))
{
	objAL = we.getObjAL();
	//out.println(we.getSql()+"<br>");
	if(objAL.size() > 0)
	{
		arln = objInfo.getArln_cd();
		//out.println(arln+ "  arln <br>");

		if("CI".equals(arln))
		 {
			  arln_fullname = " CHINA AIRLINES ";
		 }
		 else if("KA".equals(arln))
		 {
			  arln_fullname = " DRAGONAIR ";
		 }
		 else if("VN".equals(arln))
		 {
			  arln_fullname = " VIETNAM AIRLINES ";
		 }
		 else if("CV".equals(arln))
		 {
			  arln_fullname = " CARGOLUX AIRLINES ";
		 }
		 else if("AE".equals(arln))
		 {
			  arln_fullname = " MANDARIN AIRLINES ";
		 }
			
		 fdate = objInfo.getFdate();		
		 fdate = fdate.substring(0,2)+"/"+fdate.substring(2,5)+"/"+fdate.substring(5);
		 fltno2 = objInfo.getFltno();
		 WebGdCity wec = new WebGdCity(objInfo.getDpt(),yyyy+"/"+mm+"/"+dd,arln,fltno);
		 acno = wec.acno;
		 if("168CL".equals(acno))
		 {
			acno = "N168CL";
		 }
		 else
		 {
			acno = "B"+acno;
		 }
		 dpt_fullname = wec.lcity;
		 dpt_ctry = wec.ctry;
		 WebGdCity wec2 = new WebGdCity(objInfo.getArv(),yyyy+"/"+mm+"/"+dd,arln,fltno);
		 arv_fullname = wec2.lcity;
		 arv_ctry = wec2.ctry;
		 dpt_short = objInfo.getDpt();
		 arv_short = objInfo.getArv();
	}
}
else
{
	error = str_getWebEgData +"  /  "+ str_getGDFromDB2;
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>GD</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<style type="text/css">
body
{
font-size: 9pt;
font-family: Courier;
}

input.st1
{
	border-bottom: 1.5px solid #808080 ;
	border-top: 0px solid #FFFFFF ;
	border-left: 0px solid #FFFFFF ;
	border-right: 0px solid #FFFFFF ;
	vertical-align: bottom;
	font-size: 9pt;
}

input.st2
{
	border-bottom: 0px solid #FFFFFF ;
	border-top: 0px solid #FFFFFF ;
	border-left: 0px solid #FFFFFF ;
	border-right: 0px solid #FFFFFF ;
	vertical-align: bottom;
	font-size: 9pt;
}
.style2 {
	font-size: 12;
	color: #FF0000;
}
</style>
</head>
<body>
<%
if(!"Y".equals(str_getWebEgData) | !"Y".equals(str_getGDFromDB2))
{
%>
<table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
  <td align="center"><span class="style2"><%=error%></span></td>
 </tr>
 </table>
<%
}
%>

<table width="650" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
  <td colspan="2">
	  <table width="100%"  border="0" cellspacing="0" cellpadding="0">
		<tr>
		  <td height="25" colspan="6"><div align="center">GENERAL DECLARATION</div></td>
		</tr>
		<tr>
		  <td height="20" colspan="4">OWNER OR OPERATION : <input name="arln_fullname" type="text" value="<%=arln_fullname%>" size="30" maxlength="30" class="st1" onkeyup="javascript:this.value=this.value.toUpperCase();"></td>
		  <td width="34%" colspan="2"><div align="right">DATE : <input name="fdate" type="text" value="<%=fdate%>" size="10" maxlength="10" class="st1" onkeyup="javascript:this.value=this.value.toUpperCase();"></div></td>
		</tr>
		<tr>
		  <td height="20" colspan="4">MARKS OF NATIONALITY AND REGISTRATION : <input name="acno" type="text" value="<%=acno%>" size="8" maxlength="8" class="st1" onkeyup="javascript:this.value=this.value.toUpperCase();"></td>
		  <td colspan="2"><div align="right">FLIGHT NO : <input name="fltno2" type="text" value="<%=arln%><%=fltno2%>" size="10" maxlength="10" class="st1" onkeyup="javascript:this.value=this.value.toUpperCase();"></div></td>
		</tr>
<%
//CS40 2010-4-27 remove word CHINA in TWN-CHN flts
if(("CAN,PVG,SHA,PEK,CKG,CTU,NKG,SZX,HGH,KMG,SHE,CSX,XIY,NGB,CGO,DLC,XMN,TAO,FOC,WUH,YNZ,WNZ,KHN,SYX,HAK,WUX".indexOf(dpt_short) >= 0 | 
    "CAN,PVG,SHA,PEK,CKG,CTU,NKG,SZX,HGH,KMG,SHE,CSX,XIY,NGB,CGO,DLC,XMN,TAO,FOC,WUH,YNZ,WNZ,KHN,SYX,HAK,WUX".indexOf(arv_short) >= 0) ){
    chnflt = true;
}else{
    chnflt = false;
}//if

//if(("CAN,PVG,PEK,CKG,CTU,NKG,SZX,HGH,KMG,SHE,CSX,XIY,NGB,CGO,DLC,XMN".indexOf(dpt_short) >= 0 | "CAN,PVG,PEK,CKG,CTU,NKG,SZX,HGH,KMG,SHE,CSX,XIY,NGB,CGO,DLC,XMN".indexOf(arv_short) >= 0) && ("TPE".equals(dpt_short) | "KHH".equals(dpt_short)))
if (chnflt) //CS40 2010-4-27 remove word CHINA in TWN-CHN flts
{
%>
		<tr>
		  <td width="26%">DEPARTURE FROM </td>
		  <td height="20" colspan="5">: <input name="dpt" type="text" value="<%=dpt_fullname%>" size="50" maxlength="50" class="st2" onkeyup="javascript:this.value=this.value.toUpperCase();"></td>
		</tr>
<%
}
else
{
%>
		<tr>
		  <td width="26%">DEPARTURE FROM </td>
		  <td height="20" colspan="5">: <input name="dpt" type="text" value="<%=dpt_fullname%>  -  <%=dpt_ctry%>" size="50" maxlength="50" class="st2" onkeyup="javascript:this.value=this.value.toUpperCase();"></td>
		</tr>
<%
}	
%>

<%
//if(("CAN,PVG,PEK,CKG,CTU,NKG,SZX,HGH,KMG,SHE,CSX,XIY,NGB,CGO,DLC,XMN".indexOf(dpt_short) >= 0 | "CAN,PVG,PEK,CKG,CTU,NKG,SZX,HGH,KMG,SHE,CSX,XIY,NGB,CGO,DLC,XMN".indexOf(arv_short) >= 0) && ("TPE".equals(arv_short) | "KHH".equals(arv_short)))
if (chnflt) //CS40 2010-4-27 remove word CHINA in TWN-CHN flts
{
%>
		<tr>
		  <td width="26%">ARRIVAL AT </td>
		  <td height="20" colspan="5">: <input name="dpt" type="text" value="<%=arv_fullname%>" size="50" maxlength="50" class="st2"></td>
		</tr>
<%
}
else
{
%>
		<tr>
		  <td width="26%">ARRIVAL AT </td>
		  <td height="20" colspan="5">: <input name="dpt" type="text" value="<%=arv_fullname%>  -  <%=arv_ctry%>" size="50" maxlength="50" class="st2"></td>
		</tr>
<%
}	
%>
	  </table>
  </td>
</tr>
<tr>
  <td width="70%" valign="top">	
   <table width="100%"  border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="1" valign="bottom" colspan="4"><hr></td>
	</tr>
   	<tr>
	  <td width="98%" colspan="3">&nbsp;&nbsp;&nbsp;&nbsp;NAME&nbsp;&nbsp;OF&nbsp;&nbsp;CREW</td>
	  <td width="2%" align = "right">:</td>
	</tr>
	<tr>
		<td height="1" valign="top" colspan="4"><hr></td>
	</tr>
    <tr>
	   <td colspan="4">
	    <table width="100%"  border="0" cellspacing="0" cellpadding="0">
		<%
			for(int i=0; i<objAL.size(); i++)
			{
				WebGdObj obj = (WebGdObj) objAL.get(i);
				String str1 ="";
				String str2 = "";
				String str3 = "";
				String str4 = "";
				if(i+1<10)
				{
					str1 = "0"+Integer.toString((i+1))+"."+obj.getRank()+"&nbsp;";
				}
				else
				{
					str1 = Integer.toString((i+1))+"."+obj.getRank()+"&nbsp;";
				}		

				if("ANC,ATL,BNA,BOS,CVG,DEN,DFW,GUM,HNL,HOU,JFK,LAS,LAX,MIA,NYC,ORD,ORL,PDX,SEA,SFO,TPA,YVR,YTO,YYZ,YMX".indexOf(obj.getDpt()) >= 0 | "ANC,ATL,BNA,BOS,CVG,DEN,DFW,GUM,HNL,HOU,JFK,LAS,LAX,MIA,NYC,ORD,ORL,PDX,SEA,SFO,TPA,YVR,YTO,YYZ,YMX".indexOf(obj.getArv()) >= 0 )
				{//美加線 name
					if("".equals(obj.getWest_ename()) | " ".equals(obj.getWest_ename()) | obj.getWest_ename() == null)
					{//don't have us passport of us or ca
						str2 = obj.getNonwest_ename();
						if (!"".equals(obj.getMeal_type()) && !" ".equals(obj.getMeal_type()))
						{
							str2 = str2 +"&nbsp;"+obj.getMeal_type();
						}

						if (!"".equals(obj.getCop_duty_cd()) && !" ".equals(obj.getCop_duty_cd()))
						{
							str2 = str2 +"&nbsp;"+obj.getCop_duty_cd();
						}

						str3 = obj.getBirthdt()+"/"+obj.getNonwest_nation()+"/"+obj.getNonwest_passno();	
					}
					else
					{//having us passport of us or ca
						str2 = obj.getWest_ename();	
						if (!"".equals(obj.getMeal_type()) && !" ".equals(obj.getMeal_type()))
						{
							str2 = str2 +"&nbsp;"+obj.getMeal_type();
						}

						if (!"".equals(obj.getCop_duty_cd()) && !" ".equals(obj.getCop_duty_cd()))
						{
							str2 = str2 +"&nbsp;"+obj.getCop_duty_cd();
						}
						str3 = obj.getBirthdt()+"/"+obj.getWest_nation()+"/"+obj.getWest_passno();	
					}
				}
				else
				{//not 美加線
				     
					if("ICN".indexOf(obj.getDpt()) >= 0 | "ICN".indexOf(obj.getArv()) >= 0)
					{//韓國班機 Name difference
						//str2 = obj.getNonwest_ename().replaceAll(" |/",""); 
						str2 = obj.getNonwest_ename().replaceAll(" ",""); //2009/3/9 CS40	
					}
					else
					{
						str2 = obj.getNonwest_ename();		
					}

					if (!"".equals(obj.getMeal_type()) && !" ".equals(obj.getMeal_type()))
					{
						str2 = str2 +"&nbsp;"+obj.getMeal_type();
					}

					if (!"".equals(obj.getCop_duty_cd()) && !" ".equals(obj.getCop_duty_cd()))
					{
						str2 = str2 +"&nbsp;"+obj.getCop_duty_cd();
					}

					if("CAN,PVG,SHA,PEK,CKG,CTU,NKG,SZX,HGH,KMG,SHE,CSX,XIY,NGB,CGO,DLC,XMN,TAO,FOC,WUH,YNZ,WNZ,KHN,SYX,HAK,WUX".indexOf(obj.getDpt()) >= 0 | "CAN,PVG,SHA,PEK,CKG,CTU,NKG,SZX,HGH,KMG,SHE,CSX,XIY,NGB,CGO,DLC,XMN,TAO,FOC,WUH,YNZ,WNZ,KHN,SYX,HAK,WUX".indexOf(obj.getArv()) >= 0)
					{//大陸班機 台胞証instead passport
						str3 = obj.getBirthdt()+"/"+obj.getNonwest_nation()+"/"+obj.getLicno();
					}
					else
					{
						str3 = obj.getBirthdt()+"/"+obj.getNonwest_nation()+"/"+obj.getNonwest_passno();		
					}					
				}
				str4 = "/"+obj.getSex();	
%>
				<tr valign="top">
					<td width="4%"><%=str1%></td>
					<td width="50%"><%=str2%></td>
					<td width="40%"><%=str3%></td>
					<td width="4%"><%=str4%></td>
					<td width="2%" align = "right">:</td>
				</tr>
<%
			}//for(int i=0; i<objAL.size(); i++)
		%>
	    </table>
	   </td>
	</tr>	
   </table>
  </td>
  <td width="30%" valign="top">
  <table width="100%"  border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="1" align="center" valign="bottom"><hr></td>
	</tr>
  	<tr>
		<td align="center" valign="middle">PLACE</td>
	</tr>
	<tr>
		<td height="1" align="center" valign="top"><hr></td>
	</tr>
	<tr>
		<td>&nbsp;&nbsp;&nbsp;<input name="dpt" type="text" value="<%=dpt_fullname%>" size="20" maxlength="20" class="st2" onkeyup="javascript:this.value=this.value.toUpperCase();"><br>&nbsp;&nbsp;&nbsp;<input name="dpt" type="text" value="<%=arv_fullname%>" size="20" maxlength="20" class="st2" onkeyup="javascript:this.value=this.value.toUpperCase();"><br><br>
		</td>
	</tr>
	<tr>
		<td height="1" align="center" valign="bottom"><hr></td>
	</tr>
	<tr>
		<td align="center" valign="middle">CARGO</td>
	</tr>
	<tr>
		<td height="1" align="center" valign="top"><hr></td>
	</tr>
	<tr>
		<td align="center">CARGO<br>MANIFESTS<br>ATTACHED<br></td>
	</tr>
	<tr>
		<td height="1" align="center" valign="bottom"><hr></td>
	</tr>
	<tr>
		<td align="center" valign="middle">NUMBER OF PASSENGERS<br>
		  ON THIS STAGE<br></td>
	</tr>
	<tr>
		<td height="1" align="center" valign="top"><hr></td>
	</tr>
	<tr>
		<td align="left">DEPARTURE PLACE : <%=dpt_short%><br>EMBARKING<br>THROUGH ON SAME FLIGHT<br>ARRIVAL PLACE : <%=arv_short%><br>DISEMBARKING<br>THROUGH ON SAME FLIGHT<br>
		</td>
	</tr>
	<tr>
		<td height="1" align="center" valign="bottom"><hr></td>
	</tr>
	<tr>
		<td align="center" valign="middle">FOR OFFICIAL USE ONLY<br>
		</td>
	</tr>
	<tr>
		<td height="1" align="center" valign="top"><hr></td>
	</tr>
	<tr>
		<td align="center"><BR><BR><BR></td>
	</tr>
  </table>
  </td>
</tr>
<tr>
  <td height="406" colspan="2" valign="top"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="1" align="center" valign="bottom" colspan="2"><hr></td>
	</tr>
    <tr>
      <td colspan="2"><div align="center">DECLARATION OF HEALTH </div></td>
    </tr>
    <tr>
      <td colspan="2">
	      <div align="left"> 
              <p>PERSONS ON BOARD KNOWN TO BE SUFFERING FROM ILLNESS OTHER THAN 
                AIR SICKNESS OF<br>
                THE EFFECTS IF ACCIDENTS AS WELL AS THOSE CASES OF ILLNESS DISEMBARKED 
                DURING THE FLIGHT .........................<br>
                ANY OTHER CONDITIONS ON BOARD WHICH MAY LEAD TO THE SPREAD OF 
                DISEASE...<br>
                <br>
                DETAILS OF EACH DISINFECTING OF SANITARY TREATMENT (PLACE/DATE/TIME/METHOD) 
                DURING THE FLIGHT. IF NO DISINFECTING HAS BEEN CARRIED OUT DURING 
                THE FLIGHT AEROSOL SPRAYED 30 MINS BEFORE DEPARTURE.<br>
                <br>
                SIGNED IF REQUIRED...........................(CREW MEMBER CONCERNED)<br>
                <br>
                I DECLARE THAT ALL STATMENTS AND PARTICULARS CONTAINED IN THIS 
                GENERAL DECLARATION. AND IN ANY SUPPLEMENTARY FORMS REQUIRED TO 
                BE PRESENTED WITH THIS GENERAL DECLARATION ARE COMPLETE EXACT 
                AND TRUE TO THE BEST OF MY KNOWLEDGE AND THAT ALL THROUGH PASSENGERS 
                WILL CONTINUE/HAVE CONTINUED ON THE FLIGHT<br>
                <br>
                <br>
                SIGNATURE..............................................<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(AUTHORIZED 
                AGENT OR PILOT IN COMMAND)<br>
              </p>
              </div>
		  </td>
    </tr>
    <tr>
      <td width="81%" height="25">F-OP009</td>
      <td width="19%">VERSION : AA </td>
    </tr>
  </table></td>
</tr>
</table>

</body>
</html>
<%
}
%>
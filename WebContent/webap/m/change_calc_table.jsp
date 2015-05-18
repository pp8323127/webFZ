<%@page import="swap3ac.CrewSkjObj"%>
<%@page import="swap3ac.CrewInfoObj"%>
<%@page import="java.sql.SQLException"%>
<%@page import="credit.SkjPickObj"%>
<%@page import="credit.SkjPickList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="fzAuthP.FZCrewObj"%>
<%@page import="ws.crew.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
try{
LoginAppBObj lObj= (LoginAppBObj) session.getAttribute("loginAppBobj");
if(lObj == null ) {
	out.println("請登入");
	response.sendRedirect("login.jsp");
}else{  
	FZCrewObj uObj = lObj.getFzCrewObj();
	String aEmpno = uObj.getEmpno();
	String rEmpno = request.getParameter("radiorEmpno");
	String yymm = request.getParameter("myDate");
	out.println(rEmpno + yymm);
	String year = "";
	String month = "";
	if(null!=yymm && !"".equals(yymm)){
		String date[] = yymm.split("/");
		year = date[0];
		month = date[1];
		if(month.length()<=1){
			month = "0"+month;
		}	
		//out.println(year +"/"+month);
		
		if("TPE".equals(uObj.getBase())){
			CrewSwapFunALL csf = new CrewSwapFunALL();
			csf.CorssCrSkjTPE(aEmpno, rEmpno, year, month);
			CrewCorssCrRObj rObjAL = csf.getCrewCorssObjAL();
			if("0".equals(rObjAL.getResultMsg())){
				out.println(rObjAL.getErrorMsg());	
			}else{
			
			
			ArrayList aEmpnoAL = rObjAL.getaCrewSkjAL();
			ArrayList rEmpnoAL = rObjAL.getrCrewSkjAL();
		
		
			CrewInfoObj aCrewInfoObj = rObjAL.getaCrewInfoObj();
			CrewInfoObj rCrewInfoObj = rObjAL.getrCrewInfoObj();
			int acnt = 0;
			int rcnt = 0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>iCrew</title>
	<link rel="stylesheet" href="jQueryMob/jquery.mobile.custom.structure.css" />	
	<link rel="stylesheet" href="jQueryMob/jquery.mobile.custom.theme.css" />	
	<link rel="stylesheet" href="jQueryMob/CSS.css">
	<script src="jQueryMob/jquery.js" language="javascript"></script>	
	<script src="jQueryMob/jquery.mobile.custom.js" language="javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btn_menu").click(function(e){
                $.ajax({
                    type: "POST",
                    url: "navbar.jsp",
                    success:function(data){
                        // alert(data);
                        $("#right-list li").remove();
                        $("#right-list").append(data).listview("refresh");
                    },
                    error:function(xhr, ajaxOptions, thrownError){
                        console.log(xhr.status);
                        console.log(thrownError);
                        alert("Error");
                    }
                });
                e.preventDefault();
            });
            
            $("#sub").click(function(e){
            	var yymm = $("#myDate").val();
            	var rEmpno = $("#rEmpno").val();
            	var aEmpnoArr = $('input:checkbox:checked[name="chkA"]').val();
            	var rEmpnoArr = $('input:checkbox:checked[name="chkR"]').val();
            	
            	if("" != yymm && !isNaN(aEmpnoArr) && !isNaN(rEmpnoArr) ){
	            	$("#CrossDetailform").attr("action", "change_calc_result.jsp");
					$("#CrossDetailform").submit();
            	}else{
            		//alert(aEmpnoArr + rEmpnoArr);
            	}
            });
            $("#naviBar_icon_Back").click(function(e){
            	var yymm = $("#myDate").val();
            	var rEmpno = $("#rEmpno").val();
            	if("" != yymm && ""!=rEmpno ){
	            	$("#CrossDetailform").attr("action", "change_calc_compare.jsp");
					$("#CrossDetailform").submit();
            	}else{
            		//console.log(rEmpno+yymm);
            	}
        	});
        });
    </script>

</head>
<body>

<div id="change_calc_table" data-role="page">
<!-- Header bar Start -->
	<div data-role="header" data-position="fixed">
		<table id="header-bar">
			<tr>
				<td id="header-bar-btnBak">
					<a href="#"><div id="naviBar_icon_Back"></div></a>
				</td>
				<td id="header-bar-btnAppname">換班飛時試算</td>
				<td id="header-bar-btnMenu">
					<a id="btn_menu" href="#navbar"><div id="navi_icon_menu"></div></a>
				</td>
			</tr>
		</table>
	</div>
<!-- Header bar End -->

<!-- 換班飛時試算-表格 Start-->
<div role="main" class="ui-content">
<form id="CrossDetailform" method="POST" action="" data-ajax="false">
<div data-role="navbar" id="calc_navbar">
<%
CrewCrossCrMuti ccm = new CrewCrossCrMuti();
ArrayList dayofmonthAL = new ArrayList();
dayofmonthAL=ccm.getEachDayOfMonth(year,month);
out.println(ccm.getStr());
%>
<ul>
<li>
	<div id="calc_datetime">
		<table>
			<tr class="tr_yearmonth">
				<th rowspan="3">
					<p><%=year %></p>
					<p><%=month %></p>
					<input type="hidden" id="rEmpno" name="rEmpno" value="<%=rEmpno%>">
					<input type="hidden" id="myDate" name="myDate" value="<%=yymm%>">
				</th>
			</tr>
			<tr></tr>
			<tr></tr>
<%
String bcolor = "";
for(int o=0; o<dayofmonthAL.size(); o++)
{
	if(((String)dayofmonthAL.get(o)).indexOf("SAT")>=0 || ((String)dayofmonthAL.get(o)).indexOf("SUN")>=0)
	{
		//週末
		bcolor="#ffff00";
	}else{
		bcolor="";
	}
%>
			
			<tr class="tr_date" bgcolor="<%=bcolor%>">
				<td><%=((String) dayofmonthAL.get(o)).substring(8,10)%></td>
			</tr>
<%
}//for(int o=0; o<dayofmonthAL.size(); o++)
%>
		</table>
	</div>
</li>
<li>
	<div id="compare_applicant1">
		<table>
			<tr class="tr_applicant">
				<th colspan="4">Applicant /</th>
			</tr>
			<tr class="tr_name_table">
				<td colspan="4">				
					<p><%=aCrewInfoObj.getCname()%></p>
					<p><%=aCrewInfoObj.getEmpno()%></p>
					<p><%=aCrewInfoObj.getSern()%></p>					
				</td>
			</tr>
			<tr class="tr_fltno_cr_resthr_select">
				<td>Fltno</td>
				<td>CR</td>
				<td>RestHr</td>
				<td>Select</td>
			</tr>
		<%
		if(null!= aEmpnoAL && aEmpnoAL.size() > 0){
			for(int o=0; o<dayofmonthAL.size(); o++)
			{
				if(((String)dayofmonthAL.get(o)).indexOf("SAT")>=0 || ((String)dayofmonthAL.get(o)).indexOf("SUN")>=0)
				{
					//週末
					bcolor="#ffff00";
				}else{
					bcolor="";
				}					
				for(int i=0 ;i<aEmpnoAL.size();i++){
					
					CrewSkjObj sobj = (CrewSkjObj)aEmpnoAL.get(i);
					if(((String)dayofmonthAL.get(o)).equals(sobj.getFdate()+" ("+sobj.getDayOfWeek()+")"))
					{
						acnt++;		
				%>
					<tr class="tr_content_table">
						<td><%=sobj.getDutycode() %></td>
						<td><%=sobj.getCr() %></td>
						<td class="fontgray"><%=sobj.getResthr() %></td>
						<td>
						<%if(csf.isCheckBox(sobj.getDutycode(), sobj.getTripno())){ %>
						<input type="checkbox" name="chkA" value="<%=i%>"> 
						<%} %>
						</td>
					</tr>
				<%
					}//if(((String)dayofmonthAL.get(o))
				}//for(int i=0 ;i<aEmpnoAL.size();i++)
				if(acnt<=0)
				{
				%>
					<tr class="tr_content_table"><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
				<%
				}//if(acnt<=0)
				acnt = 0;
			}//A 	for(int o=0; o<dayofmonthAL.size(); o++)
		}//if(null!= aEmpnoAL && aEmpnoAL.size() > 0)
		%>	
			<!-- <tr class="tr_content_table">
				<td>0000</td>
				<td>1111</td>
				<td >20</td>
				<td class="tr_chk">
					<div id="list_btn_square"></div>
				</td>
			</tr> -->
		</table>
	</div>
</li>


<li>
	<div id="compare_substitle1">
		<table>
			<tr class="tr_substitle">
				<th colspan="4">Substitle /</th>
			</tr>
			<tr class="tr_name_table">
				<td colspan="4">
					<p><%=rCrewInfoObj.getCname() %></p>
					<p><%=rCrewInfoObj.getEmpno() %></p>
					<p><%=rCrewInfoObj.getSern() %></p>
				</td>
			</tr>
			<tr class="tr_fltno_cr_resthr_select">
				<td>Fltno</td>
				<td>CR</td>
				<td>RestHr</td>
				<td>Select</td>
			</tr>
			<%
			if(null!= rEmpnoAL && rEmpnoAL.size() > 0){
			for(int o=0; o<dayofmonthAL.size(); o++)
			{
				if(((String)dayofmonthAL.get(o)).indexOf("SAT")>=0 || ((String)dayofmonthAL.get(o)).indexOf("SUN")>=0)
				{
					//週末
					bcolor="#ffff00";
				}else{
					bcolor="";
				}					
				for(int i=0 ;i<rEmpnoAL.size();i++){
					
					CrewSkjObj sobj = (CrewSkjObj)rEmpnoAL.get(i);
					if(((String)dayofmonthAL.get(o)).equals(sobj.getFdate()+" ("+sobj.getDayOfWeek()+")"))
					{
						rcnt++;		
				%>
					<tr class="tr_content_table">
						<td><%=sobj.getDutycode() %></td>
						<td><%=sobj.getCr() %></td>
						<td class="fontgray"><%=sobj.getResthr() %></td>
						<td>
						<%if(csf.isCheckBox(sobj.getDutycode(), sobj.getTripno())){ %>
						<input type="checkbox" name="chkR" value="<%=i%>"> 
						<%} %>
						</td>
					</tr>
				<%
					}//if(((String)dayofmonthAL.get(o))
				}//for(int i=0 ;i<rEmpnoAL.size();i++)
				if(rcnt<=0)
				{
				%>
					<tr class="tr_content_table"><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
				<%
				}//if(acnt<=0)
				rcnt = 0;
			}//A 	for(int o=0; o<dayofmonthAL.size(); o++)
		}//if(null!= rEmpnoAL && rEmpnoAL.size() > 0)
		%>	
			<!-- <tr class="tr_content_table">
				<td>0000</td>
				<td>1111</td>
				<td class="fontgray">20</td>
				<td class="tr_chk">
					<div id="list_btn_square"></div>
				</td>
			</tr> -->
		</table>
	</div>
</li>

</ul>
</div>
		<!-- <div id="input_calc_table">
			<select>
		 	<option value="已自行查詢，責任自負">已自行查詢，責任自負</option>
			<%
			if(null!=rObjAL.getCommItemAL()){
				for(int i=0;i<rObjAL.getCommItemAL().size();i++){ %>
			<option><%=(String) rObjAL.getCommItemAL().get(i) %></option>
			
			
			<%
				}
			}
			%>
			</select>
			<input type="text" placeholder="放棄特休假請輸入申請者(A)或被換者(R)+日期">
		</div>
 		-->
		<div id="btnApply" class="btn_calc_table">
			<a id="sub" href="#" class="ui-btn ui-corner-all" data-ajax="false"><div>換班飛時試算</div></a>
		</div>
</form>
</div>
<!-- 換班飛時試算-表格 End-->

<!-- navbar Slide Panel -->
    <div id="navbar" data-role="panel" data-position="right" data-position-fixed="false" data-display="overlay" data-theme="b">
        <ul id="right-list" data-role="listview" data-inset="true" data-icon="false">
        </ul>
    </div>
<!-- navbar Slide Panel -->

</div>



</body>
</html>
<%	
			}//if("0".equals(rObjAL.getResultMsg()))
		}else if("KHH".equals( uObj.getBase())){
			//導KHHpage
			//out.println("KHH");
			response.sendRedirect("khh/change_calc_table.jsp");
		}
	}//month & year
}
}catch(Exception e){
	out.println(e.toString());
}
%>
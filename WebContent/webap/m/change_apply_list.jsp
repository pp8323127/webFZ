<%@page import="credit.CreditObj"%>
<%@page import="java.text.DecimalFormat"%>
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
	String rEmpno = request.getParameter("rEmpno");
	String yymm = request.getParameter("myDate");
	String apoint = request.getParameter("apoint");
	String ack =  request.getParameter("ack");
	String aTimes =  request.getParameter("aTimes");
	String rTimes =  request.getParameter("rTimes");
	String rck =  request.getParameter("r_ck");
	String rpoint =  request.getParameter("r_point");
	//out.println(rEmpno+yymm+apoint+ack+aTimes+rTimes);
	String year = "";
	String month = "";
	String str = "";
	int totalTimes = 4;
	boolean flag = false;
	if(null!=yymm && !"".equals(yymm)){
		String date[] = yymm.split("/");
		year = date[0];
		month = date[1];
		if(month.length()<=1){
			month = "0"+month;
		}
		CrewSwapTPE cst = new CrewSwapTPE();

		//取得班表
		
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
					<a data-rel="back"><div id="naviBar_icon_Back"></div></a>
				</td>
				<td id="header-bar-btnAppname">換班申請</td>
				<td id="header-bar-btnMenu">
					<a id="btn_menu" href="#navbar"><div id="navi_icon_menu"></div></a>
				</td>
			</tr>
		</table>
	</div>
<!-- Header bar End -->

<!-- 換班班表 Start-->
	<div role="main" class="ui-content">
	
<div data-role="navbar" id="calc_navbar">
<ul>
<li>
	<div id="calc_datetime">
		<table>
			<tr class="tr_yearmonth">
				<th rowspan="3">
					<p>2015</p>
					<p>JAN.</p>
				</th>
			</tr>

			<tr></tr>
			<tr></tr>
			<tr class="tr_date">
				<td>01</td>
			</tr>
			<tr class="tr_date">
				<td>02</td>
			</tr>
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
					<p>歐陽晶晶</p>
					<p>654320</p>
					<p>(17416)</p>
				</td>
			</tr>
			<tr class="tr_fltno_cr_resthr_select">
				<td>Fltno</td>
				<td>CR</td>
				<td>RestHr</td>
				<td>Select</td>
			</tr>

			<tr class="tr_content_table">
				<td>0000</td>
				<td>1111</td>
				<td class="fontgray">20</td>
				<td class="tr_chk">
					<div id="list_btn_square"></div>
				</td>
			</tr>
			<tr class="tr_content_table">
				<td>0000</td>
				<td>1111</td>
				<td class="fontgray">20</td>
				<td class="tr_chk">
					<div id="list_btn_square"></div>
				</td>
			</tr>
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
					<p>歐陽晶晶</p>
					<p>654320</p>
					<p>(17416)</p>
				</td>
			</tr>
			<tr class="tr_fltno_cr_resthr_select">
				<td>Fltno</td>
				<td>CR</td>
				<td>RestHr</td>
				<td>Select</td>
			</tr>


			<tr class="tr_content_table">
				<td>0000</td>
				<td>1111</td>
				<td class="fontgray">20</td>
				<td class="tr_chk">
					<div id="list_btn_square"></div>
				</td>
			</tr>
			<tr class="tr_content_table">
				<td>0000</td>
				<td>1111</td>
				<td class="fontgray">20</td>
				<td class="tr_chk">
					<div id="list_btn_square"><div id="list_icon_checkmark_blue"></div></div>
				</td>
			</tr>
		</table>
	</div>
</li>

</ul>

		<div id="div_select_comments">
			<label>Comments</label>
			<select id="select_comments" data-icon="list_btn_arrow_down_gray">
				<option value="已自行查詢，責任自負">已自行查詢，責任自負</option>
			</select>
		</div>

		<div id="input_calc_table" class="margintop10">
			<input type="text" placeholder="放棄特休假請輸入申請者(A)或被換者(R)+日期">
		</div>

		<div id="btnApply" class="btn_calc_table">
			<a href="#alert-popup-apply" data-rel="popup" data-transition="pop" class="ui-btn ui-corner-all"><div>送出任務互換資訊</div></a>
		</div>

	</div>
<!-- 換班班表 End-->

<!-- popup container start -->
<div data-role="popup" id="alert-popup-apply" class="ui-content popupDiv" data-overlay-theme="b" data-dismissible="false" data-position-to="window" data-shadow="true" data-corners="true" style="text-align: center;">
    <div data-role="header" class="popup-header" id="change_apply_list_header">
       <p>Tripno:3141437</p>
    </div>

    <div data-role="content" class="popup-content" id="change_apply_list_popup">
		<p>班表時間為起訖站當地時間</p>
		<p>跨月班次之飛時，僅計算至當月底</p>

		<hr>

		<p>2015/01/01　Fltno: 2161</p>
		<p>Dpt: ICN　Arv: TPE</p>
		<p>Btime: 2015/01/01 09:15px</p>
		<p>Etime: 2015/01/01 10:59</p>
		<p>Cr(HHMM): 0244</p>
		<p>Rest Hour: 10　　Sp Code: ---</p>
		
		<hr>

		<p>2015/01/01　Fltno: 2161</p>
		<p>Dpt: ICN　Arv: TPE</p>
		<p>Btime: 2015/01/01 09:15px</p>
		<p>Etime: 2015/01/01 10:59</p>
		<p>Cr(HHMM): 0244</p>
		<p>Rest Hour: 10　　Sp Code: ---</p>

        <a class="ui-btn btnPopOK" href="change_apply_finalcheck.html" data-ajax="false"><div>確 認</div></a>
    </div>
</div>
<!-- popup container end -->

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
	}//	if(null!=yymm && !"".equals(yymm))
}
}catch(Exception e){
	out.println(e.toString());
}
%>
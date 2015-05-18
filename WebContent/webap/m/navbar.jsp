<%@page import="ws.crew.LoginAppBObj"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ page import="java.io.*,java.util.*,java.text.*,java.sql.*,ci.db.*,fzAuthP.*"%>

<%  
   
    LoginAppBObj lObj= (LoginAppBObj) session.getAttribute("loginAppBobj");
    if(lObj == null ) {
    	out.println("請登入");
		response.sendRedirect("login.jsp");
	}else{  
    	FZCrewObj uObj = lObj.getFzCrewObj();
		boolean cabin = ("FA,FS,ZC,PR,PU,CM".indexOf(uObj.getOccu())) > 0;

	
%>
<!-- data-ajex="false" -->
        <li id="li-title">
            <p><%=uObj.getCname() %></p>
            <p><%=uObj.getEmpno() %></p>
            <p>(<%=uObj.getSern() %>)</p>
        </li>
        <%if("N".equals(uObj.getLocked()) && cabin ){%>
        <li data-role="list-divider" class="lidi">
            <a href="change_main.html" id="list-divider-p" data-ajax="false">
                <div id="menu_icon_changes">
                    <p>換班</p>
                </div>
            </a>
        </li>
        
        <li>
            <a href="change_calc.jsp" data-ajax="false">換班飛時試算</a>
        </li>
        <li>
            <a href="change_apply.jsp" data-ajax="false">換班申請</a>
        </li>
        <li>
            <a id="li-noborder" href="change_log.html" data-ajax="false">換班紀錄查詢</a>
        </li>
        <%}%>
        <%if(cabin && ("TPE".equals(uObj.getBase()) || "KHH".equals(uObj.getBase()))  ){//&& "1".equals(uObj.getstatus)%>
        <li data-role="list-divider" class="lidi">
            <a href="choose_main.html" id="list-divider-p" data-ajax="false">
                <div id="menu_icon_airplane">
                    <p>選班</p>
                </div>
            </a>
        </li>
        <li>
            <a href="choose_apply.jsp" data-ajax="false">選班資格申請</a>
        </li>
        <li>
            <a href="choose_reserve.jsp" data-ajax="false">選班預約申請</a>
        </li>
        <li>
            <a id="li-noborder" href="choose_progress.jsp" data-ajax="false">處理進度查詢</a>
        </li>
        <%}%>
        <%if(cabin && ("TPE".equals(uObj.getBase()) || "KHH".equals(uObj.getBase()))  ){//&& "1".equals(uObj.getstatus)%>
        <li data-role="list-divider" class="lidi">
            <a href="#" id="list-divider-p" data-ajax="false">
                <div id="menu_icon_leave">
                    <p>請假</p>
                </div>
            </a>
        </li>
        <li>
            <a href="#" data-ajax="false">特休假查詢</a>
        </li>
        <li>
            <a href="#" data-ajax="false">特休假配額查詢</a>
        </li>
        <li>
            <a href="#" data-ajax="false">特休假申請</a>
        </li>
        <li>
            <a id="li-noborder" href="#" data-ajax="false">假單查詢與刪除</a>
        </li>
        <%}%>
        <li data-role="list-divider" class="lidi lidi_border">
        <a href="#" id="list-divider-p" data-ajax="false">
                <div id="menu_icon_bubble">
                    <p>CIA</p>
                </div>
        </a>
        </li>
        <%if(cabin){ %>
        <li data-role="list-divider" class="lidi lidi_border">
        <a href="#" id="list-divider-p" data-ajax="false">
                <div id="menu_icon_bubble">
                    <p>報到接車查詢</p>
                </div>
        </a>
        </li>
        <%} %>
        <li data-role="list-divider" class="lidi lidi_border">
        <a href="#" id="list-divider-p" data-ajax="false">
                <div id="menu_icon_bubble">
                    <p>全員即時通訊</p>
                </div>
        </a>
        </li>
        <li data-role="list-divider" class="lidi lidi_border">
        <a href="#" id="list-divider-p" data-ajax="false">
            <div id="menu_icon_mail">
                <p>全員信箱</p>
            </div>
        </a>
        </li>
        <li data-role="list-divider" class="lidi lidi_border">
        <a href="#" id="list-divider-p" data-ajax="false">
            <div id="menu_icon_settings">
                <p>設定</p>
            </div>
        </a>
        </li>
        <li>
            <a id="li-noborder" href="login.jsp" data-ajax="false">
                <div id="menu_btn_logout"></div>
            </a>  
        </li>
        <%
        }
        %>
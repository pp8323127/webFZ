<%@ page contentType="text/html; charset=big5" language="java"%>
<%@page import="java.util.*"%>
<%
Calendar sdate = new GregorianCalendar();
sdate.set(2012,5-1,8);

Calendar thisdate = new GregorianCalendar();
long diffdays = (thisdate.getTimeInMillis()-sdate.getTimeInMillis())/60/60/1000/24; 
String filename = Integer.toString((Integer.parseInt(Long.toString(diffdays))%10)+1); 
%>
<p align="center">
<object width="650" height="400">
<param name="movie" value="egswf/<%=filename%>.swf">
<embed src="egswf/<%=filename%>.swf" width="650" height="400">
</embed>
</object>
</p>
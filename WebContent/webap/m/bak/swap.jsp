<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
   String name = request.getParameter("Name"); 
   String pwd = request.getParameter("Pwd"); 
   out.println(name + pwd);
%>

<!--<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="jQueryMob/jquery.mobile.custom.structure.css" />	
<link rel="stylesheet" href="jQueryMob/jquery.mobile.custom.theme.css" />	
<script src="jQueryMob/jquery.js" language="javascript"></script>	
<script src="jQueryMob/jquery.mobile.custom.js" language="javascript"></script>	
</head>
<body>
</body>
</html>-->

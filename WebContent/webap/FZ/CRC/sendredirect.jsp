<% 
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
session.invalidate(); 
%>
<script language="JavaScript">
  parent.location="index.htm";
</script>
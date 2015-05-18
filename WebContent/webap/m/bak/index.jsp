<!DOCTYPE html> 
<html>
<head>
	<title>Page Title</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="jQueryMob/jquery.mobile.custom.structure.css" />
	<link rel="stylesheet" href="jQueryMob/jquery.mobile.custom.theme.css" />
	<script src="jQueryMob/jquery.mobile.custom.js"></script>
	<script type="text/javascript">
	
	
	</script>
</head>

<body>
<!--login page-->
<div id="pagelogin" data-role="page" data-theme="a">
  <div data-role="header" data-position="fixed">
    <h3>iCrew</h3>
  </div>
  <div role="main" class="ui-content">
    <div class="ui-field-contain" id="labId">
      <label for="inputId" class>EmployID</label>
      <input type="text" name id="inputId">
    </div>
    <div class="ui-field-contain" id="labPwd">
      <label for="inputPwd">Password</label>
      <input type="password" name id="inputPwd" value="****" data-mini="false">
    </div>
    <a class="ui-btn" id="btnLogin" data-transition="slide" href="#pageHome">Login</a>
    <!--<label>ID/Password Error </label>-->
  </div>
</div>

<!--login Successful-->
<div id="pageHome" data-role="page" data-theme="a">
  <div role="main" class="ui-content">
    <core-scaffold>
      <core-header-panel mode="seamed" navigation flex>
        <core-toolbar></core-toolbar>
        <paper-item label="´«¯Z­¸®É¸Õºâ" icon="settings" horizontal center layout id="ItemCalSwap"></paper-item>
        <paper-item label="´«¯Z" icon="settings" horizontal center layout id="ItemSwap"></paper-item>
        <paper-item label="¿ï¯Z" icon="settings" horizontal center layout id="ItemPick"></paper-item>
      </core-header-panel>
      <div tool>Welcome</div>
    </core-scaffold>
  </div>
  
<!--´«¯Z-->

</div>
</body>
</html>

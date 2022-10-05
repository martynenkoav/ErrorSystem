<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>Error System</title>
</head>

<body>
  <cfinclude template="menu.cfm" />
  <cfset createObject("component",'ErrorSystem.dbService').createTables() />
</body>
</html>
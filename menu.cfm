<cfset createObject("component",'ErrorSystem.dbService').createTables() />
<cfif structKeyExists(URL,'logout')>
	<cfset createObject("component",'ErrorSystem.authentificationService').doLogout() />
</cfif>
  <div id="menu">
    <ul>
      <li><a href="index.cfm">Home</a></li>
      <li><a href="profile.cfm">Profile</a></li>
      <li><a href="newError.cfm">Add error</a></li>
      <li><a href="newUser.cfm">Register</a></li>
      <li><a href="errorsList.cfm">List of errors</a></li>
      <li><a href="users.cfm">List of users</a></li>
      <li><a href="loginForm.cfm?logout">Logout</a></li>
    </ul>
  </div>

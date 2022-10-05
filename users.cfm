<cfset userService = createobject("component",'ErrorSystem.userService') />
<cfinclude template="menu.cfm" />
<cfif structKeyExists(session,'stLoggedInUser')>
<!---Get all news--->
	<cfset rsAllUsers = userService.getAllUsers() />
	  <h1>Users</h1>
      <table>
		<!---Output users in a table--->
		<cfoutput query="rsAllUsers">
			<tr>
				<td>#name# #last_name#</td>
			</tr>
		</cfoutput>
      </table>
 <cfelse>
	<cfoutput>Please login or register</cfoutput>
</cfif>
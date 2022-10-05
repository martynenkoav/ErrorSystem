<cfset errorsService = createobject("component",'ErrorSystem.errorsService') />
<cfinclude template="menu.cfm" />
<!---Get all news--->
	<cfset rsHistory = errorsService.getErrorHistoryByID() />
	  <h1>History</h1>
      <table>
		<!---Output users in a table--->
		<cfoutput query="rsHistory">
			<tr>
				<td>#date#</td>
				<td>#action#</td>
				<td>#comment#</td>
			</tr>
		</cfoutput>
      </table>
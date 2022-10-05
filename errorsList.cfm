<cfinclude template="menu.cfm" />
<cfif structKeyExists(session,'stLoggedInUser')>
	<cfset errorsService = createobject("component",'ErrorSystem.errorsService') />
	<cfset errorDescriptionService = createobject("component",'ErrorSystem.errorDescriptionService') />
	<cfset todayDate = Now()>
	<cfif structKeyExists(form,'fld_addErrorSubmit')>
		<cfset errorsService.updateError(url.errorID, session.stLoggedInUser.userID, DateFormat(todayDate, "yyyy-mm-dd"), form.fld_Status, form.fld_comment) />
			<cfset variables.formSubmitComplete = true />
	</cfif>

	<cfif isDefined('url.errorID')>
		<cfset rsStatusesList = errorDescriptionService.getStatuses() />
	    		<!---Output a single error if url.errorID is defined--->
	    		<cfset rsSingleError = errorsService.getErrorByID(url.errorID) />
	    		<cfif rsSingleError.status_id EQ 4>
	    			<dt>
	    				<cfoutput>Error #rsSingleError.short_des# has been closed</cfoutput>
	    			</dt>
	    			<cfelse>
				<cfform id="frm_addError">
					<fieldset>
						<cfif structKeyExists(variables,'formSubmitComplete') AND variables.formSubmitComplete>
						<p class="feedback">You changed the error!</p>
					</cfif>
						<dl>
							<dt><label>Short description</label></dt>
							<dd><cfinput type="text" name="fld_shortDes" value="#rsSingleError.short_des#" id="fld_shortDes" required="true" message="Please enter a first name" /></dd>
							<dt><label>Long description</label></dt>
							<dd><cfinput type="text" name="fld_longDes" value="#rsSingleError.long_des#" id="fld_longDes" required="true" message="Please provide your last name" /></dd>
							<dt><label>Status</label></dt>
							<dd>
								<cfselect name="fld_Status" id="fld_Status" query="rsStatusesList" value="status_id" display="name" queryposition="below">
									<option value="#rsSingleError.status_id#">Choose status</option>
								</cfselect>
							</dd>
							<dt><label>Comment</label></dt>
							<dd><cfinput type="text" name="fld_comment" id="fld_comment" required="true" message="Please fill in the comment" /></dd>
						</dl>
						<input type="submit" name="fld_addErrorSubmit" id="fld_addErrorSubmit" value="Change error" />
					</fieldset>
				</cfform>
				</cfif>
				<cfset rsHistory = errorsService.getErrorHistoryByID(url.errorID) />
		  <h1>History</h1>
	      <table>
			<!---Output history in a table--->
			<cfoutput query="rsHistory">
				<tr>
					<td>#dateFormat(date, 'dd.mm.yyyy')#</td>
					<td>#action#</td>
					<td>#comment#</td>
				</tr>
			</cfoutput>
	      </table>
	    	<cfelse>
	<!---Get all errors--->
		<cfset rsAllErrors = errorsService.getAllErrors() />
		  <h1>Errors</h1>
	      <table>
			<!---Output errors in a table--->
			<cfoutput query="rsAllErrors">
				<tr>
					<td>#dateFormat(date, 'dd.mm.yyyy')#</td>
					<td>#short_des#</td>
					<td><a href="errorsList.cfm?errorID=#error_id#">Read More</a></td>
				</tr>
			</cfoutput>
	      </table>
	      </cfif>
<cfelse>
	<cfoutput>Please login or register</cfoutput>
</cfif>
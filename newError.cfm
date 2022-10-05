<cfset userService = createobject("component",'ErrorSystem.userService') />
<cfinclude template="menu.cfm" />
<cfif structKeyExists(session,'stLoggedInUser')>
<!---Form processing script starts here--->
	<cfset dateService = createobject("component",'ErrorSystem.dateService') />
	<cfset errorDescriptionService = createobject("component",'ErrorSystem.errorDescriptionService') />
	<cfset errorsService = createobject("component",'ErrorSystem.errorsService') />
	<cfif structKeyExists(form,'fld_newErrorSubmit')>
	<!---generate the missing data--->
		<cfset form.fld_userId = session.stLoggedInUser.userId />
		<cfset todayDate = Now()>
		<cfset form.fld_date = #DateFormat(todayDate, "yyyy-dd-mm")# />
		<cfset form.fld_status = 1 />
		<!---Insert data in database if no error detected--->
		<cfset errorsService.addError(form.fld_date, form.fld_shortDes,form.fld_longDes,form.fld_userId, form.fld_Status, form.fld_Urgency,form.fld_Criticality) />
		<cfset errorIsInserted = true />
	</cfif>
	<cfset rsStatusesList = errorDescriptionService.getStatuses() />
	<cfset rsUrgencyList = errorDescriptionService.getUrgency() />
	<cfset rsCriticalityList = errorDescriptionService.getCriticality() />
  	<div id="pageBody">
		<div id="calendarSideBar">
			<cfif isDefined('errorIsInserted')>
				<h2>Error has been inserted!</h2>
			<cfelse>
			<h2>Add error information</h2>
				<cfif isDefined('aErrorMessages') AND NOT ArrayIsEmpty(aErrorMessages)>
				<cfoutput>
				<cfloop array="#aErrorMessages#" index="message">
					<p class="errorMessage">#message#</p>
				</cfloop>
				</cfoutput>
			</cfif>
			<cfform id="frm_newError">
				<fieldset>
					<dl>
						<dt><label>Short description</label></dt>
						<dd><cfinput type="text" name="fld_shortDes" id="fld_shortDes" required="true" message="Please enter a first name" /></dd>
						<dt><label>Long description</label></dt>
						<dd><cfinput type="text" name="fld_longDes" id="fld_longDes" required="true" message="Please provide your last name" /></dd>
						<dt><label>Urgency</label></dt>
						<dd>
							<cfselect name="fld_Urgency" id="fld_Urgency" query="rsUrgencyList" value="urgency_id" display="name" queryposition="below">
								<option value="0">Choose urgency</option>
							</cfselect>
						</dd>
						<dt><label>Criticality</label></dt>
						<dd>
							<cfselect name="fld_Criticality" id="fld_Criticality" query="rsCriticalityList" value="criticality_id" display="name" queryposition="below">
								<option value="0">Choose criticality</option>
							</cfselect>
						</dd>
					</dl>
					<input type="submit" name="fld_newErrorSubmit" id="fld_newErrorSubmit" value="Add error" />
				</fieldset>
			</cfform>
		</cfif>
	</div>
	</div>
	<cfelse>
	<cfoutput>Please login or register</cfoutput>		
</cfif>
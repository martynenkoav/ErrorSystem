<!---Check if a user is logged in--->
<cfif NOT isUserLoggedIn()>
	<cflocation url="loginForm.cfm?noaccess">
<cfelse>
<cfset userService = createobject("component",'ErrorSystem.userService') />
<!---Form processing begins here--->
<cfif structKeyExists(form,'fld_editUserSubmit')>
	<!---Server side form validation--->
	<cfset aErrorMessages = userService.validateUser(form.fld_userFirstName,form.fld_userLastName,form.fld_userEmail,form.fld_userPassword,form.fld_userPasswordConfirm) />
	<!---Continue form processing if the aErrorMessages array is empty--->
	<cfif arrayIsEmpty(aErrorMessages)>
		<cfset userService.updateUser(form.fld_userFirstName,form.fld_userLastName,form.fld_userEmail,form.fld_userPassword,form.fld_userID) />
		<cfset variables.formSubmitComplete = true />
	</cfif>
</cfif>
<!---Form processing ends here--->
<cfinclude template="menu.cfm" />
<!---Get user to update--->
<cfset rsUserToUpdate = userService.getUserByID(session.stLoggedInUser.userID) />
	<div id="pageBody">
		<h1>Update your profile</h1>
		<cfform id="frm_editUser">
			<fieldset>
				<legend>Your profile</legend>
				<!---Output error messages if any--->
				<cfif structKeyExists(variables,'aErrorMessages') AND NOT arrayIsEmpty(aErrorMessages)>
					<cfoutput>
						<cfloop array="#aErrorMessages#" index="message">
							<p class="errorMessage">#message#</p>
						</cfloop>
					</cfoutput>
				</cfif>
				<!---Output feedback message if form has been successfully submitted--->
				<cfif structKeyExists(variables,'formSubmitComplete') AND variables.formSubmitComplete>
					<p class="feedback">Your profile has been updated!</p>
				</cfif>
				<dl>
					<!---First name text field--->
					<dt><label for="fld_userFirstName">First Name</label></dt>
					<dd><cfinput name="fld_userFirstName" id="fld_userFirstName" value="#rsUserToUpdate.name#" required="true" message="Please provide a valid first name" validateAt="onSubmit" /></dd>
					<!---Last name text field--->
					<dt><label for="fld_userLastName">Last Name</label></dt>
					<dd><cfinput name="fld_userLastName" id="fld_userLastName" value="#rsUserToUpdate.last_name#" required="true" message="Please, provide a valid last name" validateAt="onSubmit" /></dd>
					<!---E-Mail Address text field--->
					<dt><label for="fld_userEmail">E-mail Address</label></dt>
					<dd><cfinput name="fld_userEmail" id="fld_userEmail" value="#rsUserToUpdate.email#" required="true" validate="email" message="Please, provide a valid e-mail Address" validateAt="onSubmit" /></dd>
					<!---Password text field--->
					<dt><label for="fld_userPassword">Password</label></dt>
					<dd><cfinput type="password" name="fld_userPassword" value="#rsUserToUpdate.password#" id="fld_userPassword" required="true" message="Please, provide a password" validateAt="onSubmit" /></dd>
					<dt><label for="fld_userPasswordConfirm">Confirm password</label></dt>
					<dd><cfinput type="password" name="fld_userPasswordConfirm" value="#rsUserToUpdate.password#" id="fld_userPasswordConfirm" required="true" message="Please, confirm your password" validateAt="onSubmit" /></dd>
				</dl>
				<cfinput name="fld_userID" value="#rsUserToUpdate.user_id#" type="hidden" />
				<cfinput name="fld_userRole" value="1" type="hidden" />
				<cfinput name="fld_userIsActive" value="1" type="hidden" />
				<cfinput name="fld_userIsApproved" value="1" type="hidden" />
				<!---Submit button--->
				<input type="submit" name="fld_editUserSubmit" id="fld_editUserSubmit" value="Update my profile" />
			</fieldset>
		</cfform>
	</div>
</cfif>
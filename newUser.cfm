<cfinclude template="menu.cfm" />
<cfif structKeyExists(session,'stLoggedInUser')>
	<cfoutput>You already have an account. Please logout to create a new accout.</cfoutput>
<cfelse>
<!---Create an instance of the user service component--->
	<cfset userService = createobject("component",'ErrorSystem.userService') />
<!---server side data validation--->
<!---Form processing begins here--->
<cfif structKeyExists(form,'fld_addUserSubmit')>
	<!---Server side form validation--->
	<cfset aErrorMessages = userService.validateUser(form.fld_userFirstName,form.fld_userLastName,form.fld_userEmail,form.fld_userPassword,form.fld_userPasswordConfirm) />
	<!---Continue form processing if the aErrorMessages array is empty--->
	<cfif arrayIsEmpty(aErrorMessages)>
		<cfset userService.addUser(form.fld_userFirstName,form.fld_userLastName,form.fld_userEmail,form.fld_userPassword) />
		<cfset variables.formSubmitComplete = true />
	</cfif>
</cfif>
<!---Form processing ends here--->
<!---Get user to update--->
	<div id="pageBody">
		<h1>Create your profile</h1>
		<cfform id="frm_editUser">
			<fieldset>
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
					<p class="feedback">You registrated successfully!</p>
				</cfif>
				<dl>
					<!---First name text field--->
					<dt><label for="fld_userFirstName">First Name</label></dt>
					<dd><cfinput name="fld_userFirstName" id="fld_userFirstName" required="true" message="Please provide a valid first name" validateAt="onSubmit" /></dd>
					<!---Last name text field--->
					<dt><label for="fld_userLastName">Last Name</label></dt>
					<dd><cfinput name="fld_userLastName" id="fld_userLastName" required="true" message="Please, provide a valid last name" validateAt="onSubmit" /></dd>
					<!---E-Mail Address text field--->
					<dt><label for="fld_userEmail">E-mail Address</label></dt>
					<dd><cfinput name="fld_userEmail" id="fld_userEmail" required="true" validate="email" message="Please, provide a valid e-mail Address" validateAt="onSubmit" /></dd>
					<!---Password text field--->
					<dt><label for="fld_userPassword">Password</label></dt>
					<dd><cfinput type="password" name="fld_userPassword"errorSystemDB id="fld_userPassword" required="true" message="Please, provide a password" validateAt="onSubmit" /></dd>
					<dt><label for="fld_userPasswordConfirm">Confirm password</label></dt>
					<dd><cfinput type="password" name="fld_userPasswordConfirm" id="fld_userPasswordConfirm" required="true" message="Please, confirm your password" validateAt="onSubmit" /></dd>
				</dl>
				<!---Submit button--->
				<input type="submit" name="fld_addUserSubmit" id="fld_addUserSubmit" value="register" />
			</fieldset>
		</cfform>
	</div>
</cfif>
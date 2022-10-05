<!---Handle the logout--->
<cfif structKeyExists(URL,'logout')>
	<cfset createObject("component",'ErrorSystem.authentificationService').doLogout() />
</cfif>

<cfif structkeyExists(form,'fld_submitLogin')>
	<cfset authentificationService = createobject("component",'ErrorSystem.authentificationService') />
	<cfset aErrorMessages = authentificationService.validateUser(form.fld_userEmail,form.fld_userPassword) />
	<cfif ArrayisEmpty(aErrorMessages)>
		<!---proceed to the login procedure--->
		<cfset isUserLoggedIn = authentificationService.doLogin(form.fld_userEmail,form.fld_userPassword) />
	</cfif>
</cfif>
<cfinclude template="menu.cfm" />
<!---Form processing end here--->
<cfform id="frmConnexion" preservedata="true">
	<fieldset>
    <legend>Login</legend>
    <cfif structKeyExists(variables,'aErrorMessages') AND NOT ArrayIsEmpty(aErrorMessages)>
    	<cfoutput>
    		<cfloop array="#aErrorMessages#" item="message">
    			<p class="errorMessage">#message#</p>
    		</cfloop>
    	</cfoutput>
    </cfif>
    <cfif structKeyExists(variables,'isUserLoggedIn') AND isUserLoggedIn EQ false>
    	<p class="errorMessage">User not found. Please try again!</p>
    </cfif>
    <cfif structKeyExists(session,'stLoggedInUser')>
    	<!---Display a welcome message--->
    	<p><cfoutput>Welcome #session.stLoggedInUser.userName#!</cfoutput></p>
    <cfelse>
		<dl>
	    	<dt><label for="fld_userEmail">E-mail address</label></dt>
	        <dd><cfinput type="text" name="fld_userEmail" id="fld_userEmail" required="true" validate="email" validateAt="onSubmit" message="Please enter a valid e-mail Address" /></dd>
			<dt><label for="fld_userPassword">Password</label></dt>
	        <dd><cfinput type="password" name="fld_userPassword" id="fld_userPassword" required="true"  validateAt="onSubmit" message="Please provide a password" /></dd>
	    </dl>
	    <cfinput type="submit" name="fld_submitLogin" id="fld_submitLogin" value="Login" />
    </cfif>
</cfform>

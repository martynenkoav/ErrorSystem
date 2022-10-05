<cfcomponent output="false">

	<cffunction name="validateUser" access="public" output="false" returntype="array">
		<cfargument name="userEmail" type="string" required="true" />
		<cfargument name="userPassword" type="string" required="true" />
		<cfset var aErrorMessages = ArrayNew(1) />
		<!---Validate the eMail---->
		<cfif NOT isValid('email', arguments.userEmail)>
			<cfset arrayAppend(aErrorMessages,'Please, provide a valid eMail address') />
		</cfif>
		<!---Validate the password---->
		<cfif arguments.userPassword EQ ''>
			<cfset arrayAppend(aErrorMessages,'Please, provide a password') />
		</cfif>
		<cfreturn aErrorMessages />
	</cffunction>

	<cffunction name="doLogin" access="public" output="false" returntype="boolean">
		<cfargument name="userEmail" type="string" required="true" />
		<cfargument name="userPassword" type="string" required="true" />
		
		<!---Create the isUserLoggedIn variable--->
		<cfset var isUserLoggedIn = false />
		<!---Get the user data from the database--->
		<cfquery name="rsLoginUser">
			SELECT users.name, users.user_id, users.email, users.password, users.role
			FROM users
			WHERE email = <cfqueryparam value="#arguments.userEmail#" cfsqltype="cf_sql_varchar" /> AND password = <cfqueryparam value="#arguments.userPassword#" cfsqltype="cf_sql_varchar" /> 
		</cfquery>
		<!---Check if the query returns one and only one user--->
		<cfif rsLoginUser.recordCount EQ 1>
			<!---Log the user in--->
			<cflogin >
				<cfloginuser name="#rsLoginUser.name#" password="#rsLoginUser.password#" roles="#rsLoginUser.role#">
			</cflogin>
			<!---Save user data in the session scope--->
			<cfset session.stLoggedInUser = {'userId'=rsLoginUser.user_id, 'userName' = rsLoginUser.name, 'userID' = rsLoginUser.user_id} />
			<!---change the isUserLoggedIn variable to true--->
			<cfset var isUserLoggedIn = true />
		</cfif>
		<!---Return the isUserLoggedIn variable--->
		<cfreturn isUserLoggedIn />
	</cffunction>

	<cffunction name="doLogout" access="public" output="false" returntype="void">
		<!---delete user data from the session scope--->
		<cfset structdelete(session,'stLoggedInUser') />
		<!---Log the user out--->
		<cflogout />

	</cffunction>

</cfcomponent>
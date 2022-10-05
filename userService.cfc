<cfcomponent output="false">
	<!---addUser() method--->
	<cffunction name="addUser" access="public" output="false" returntype="void">
		<cfargument name="userFirstName" type="string" required="true" />
		<cfargument name="userLastName" type="string" required="true" />
		<cfargument name="userEmail" type="string" required="true" />
		<cfargument name="userPassword" type="string" required="true" />
		<cfquery  >
			INSERT INTO users
			(name, last_name, email, password, role)
			VALUES
			(
				<cfqueryparam value="#form.fld_userFirstName#" cfsqltype="cf_sql_varchar" />,
				<cfqueryparam value="#form.fld_userLastName#" cfsqltype="cf_sql_varchar" />,
				<cfqueryparam value="#form.fld_userEmail#" cfsqltype="cf_sql_varchar" />,
				<cfqueryparam value="#form.fld_userPassword#" cfsqltype="cf_sql_varchar" />,
				<cfqueryparam value="simple" cfsqltype="cf_sql_varchar" />
			)
		</cfquery>
	</cffunction>
	<!---validateUser() method--->
	<cffunction name="validateUser" access="public" output="false" returntype="array">
		<cfargument name="userFirstName" type="string" required="true" />
		<cfargument name="userLastName" type="string" required="true" />
		<cfargument name="userEmail" type="string" required="true" />
		<cfargument name="userPassword" type="string" required="true" />
		<cfargument name="userPasswordConfirm" type="string" required="true" />
		<cfset var aErrorMessages = arrayNew(1) />
		<!---Validate firstName--->
		<cfif arguments.userFirstName EQ ''>
			<cfset arrayAppend(aErrorMessages,'Please provide a valid first name') />
		</cfif>
		<!---Validate lastName--->
		<cfif arguments.userLastName EQ ''>
			<cfset arrayAppend(aErrorMessages,'Please provide a valid lastname') />
		</cfif>
		<!---Validate Email--->
		<cfif arguments.userEmail EQ '' OR NOT isValid('email',arguments.userEmail) >
			<cfset arrayAppend(aErrorMessages,'Please provide a valid email address ')/>
		</cfif>
		<!---Validate Password--->
		<cfif arguments.userPassword EQ '' >
			<cfset arrayAppend(aErrorMessages,'Please provide a password ')/>
		</cfif>
		<!---Validate Password confirmation--->
		<cfif arguments.userPasswordConfirm EQ '' >
			<cfset arrayAppend(aErrorMessages,'Please confirm your password')/>
		</cfif>
		<!---validate password and password confirmation Match --->
		<cfif arguments.userPassword NEQ arguments.userPasswordConfirm >
			<cfset arrayAppend(aErrorMessages,'The password and the password confirmation do not match')/>
		</cfif>
		<cfreturn aErrorMessages />
	</cffunction>
	<!---getUserByID() method--->
	<cffunction name="getUserByID" access="public" output="false" returntype="query">
		<cfargument name="userID" type="numeric" required="true" />
		<cfset var rsSingleUser = '' />
		<cfquery  name="rsSingleUser">
			SELECT user_id, name, last_name, email, password, role
			FROM users
			WHERE user_id = <cfqueryparam value="#arguments.userID#" cfsqltype="cf_sql_integer" /> 
		</cfquery>
		<cfreturn rsSingleUser />
	</cffunction>
	<!---updateUser() method--->
	<cffunction name="updateUser" access="public" output="false" returntype="void">
		<cfargument name="userFirstName" type="string" required="true" />
		<cfargument name="userLastName" type="string" required="true" />
		<cfargument name="userEmail" type="string" required="true" />
		<cfargument name="userPassword" type="string" required="true" />
		<cfargument name="userID" type="numeric" required="true" />
		<cfquery>
			UPDATE users
			SET
			name = <cfqueryparam value="#arguments.userFirstName#" cfsqltype="cf_sql_varchar" />,
			last_name = <cfqueryparam value="#arguments.userLastName#" cfsqltype="cf_sql_varchar" />,
			email = <cfqueryparam value="#arguments.userEmail#" cfsqltype="cf_sql_varchar" />,
			password = <cfqueryparam value="#arguments.userPassword#" cfsqltype="cf_sql_varchar" />
			WHERE user_id = <cfqueryparam value="#arguments.userID#" cfsqltype="cf_sql_integer" />
		</cfquery>
	</cffunction>
		
		
		<!---getAllUsers() method --->
	<cffunction name="getAllUsers" access="public" returntype="query">
		<cfargument name="numUsers" type="numeric" required="false" default="-1">
		<cfset var rsAllUsers = '' />
		<cfquery  name="rsAllUsers" maxrows="#arguments.numUsers#">
			SELECT name, last_name
			FROM users
		</cfquery>
		<cfreturn rsAllUsers />
	</cffunction>
		
</cfcomponent>
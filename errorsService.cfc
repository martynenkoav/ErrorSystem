<cfcomponent output="false">
		<!---getAllErrors() method --->
	<cffunction name="getAllErrors" access="public" returntype="query">
		<cfargument name="numErrors" type="numeric" required="false" default="-1">
		<cfset var rsAllErrors = '' />
		<cfquery  name="rsAllErrors" maxrows="#arguments.numErrors#">
			SELECT error_id, date, short_des
			FROM errors
		</cfquery>
		<cfreturn rsAllErrors />
	</cffunction>
	<!---geterrorByID() method --->
	<cffunction name="getErrorByID" access="public" output="false" returntype="query">
		<cfargument name="errorID" type="numeric" required="true" />
		<cfset var rsSingleError = '' />
		<cfquery  name="rsSingleError">
			SELECT error_id, date, short_des, long_des, status_id
			FROM errors
			WHERE error_id = <cfqueryparam value="#arguments.errorID#" cfsqltype="cf_sql_integer" /> 
		</cfquery>
		<cfreturn rsSingleError />
	</cffunction>
	<!---addError() method--->
	<cffunction name="addError" access="public" output="false" returntype="void">
		<cfargument name="date" type="string" required="true" />
		<cfargument name="shortDes" type="string" required="true" />
		<cfargument name="longDes" type="string" required="true" />
		<cfargument name="userId" type="integer" required="true" />
		<cfargument name="status" type="integer" required="true" />
		<cfargument name="urgency" type="integer" required="true" />
		<cfargument name="criticality" type="integer" required="true" />
		<cfquery>
			INSERT INTO errors
			(date, short_des, long_des, user_id, status_id, urgency_id, criticality_id)
			VALUES
			(
				<cfqueryparam value="#form.fld_date#" cfsqltype="cf_sql_varchar" />,
				<cfqueryparam value="#form.fld_shortDes#" cfsqltype="cf_sql_varchar" />,
				<cfqueryparam value="#form.fld_longDes#" cfsqltype="cf_sql_varchar" />,
				<cfqueryparam value="#form.fld_userId#" cfsqltype="cf_sql_integer" />,
				<cfqueryparam value="#form.fld_Status#" cfsqltype="cf_sql_integer" />,
				<cfqueryparam value="#form.fld_Urgency#" cfsqltype="cf_sql_integer" />,
				<cfqueryparam value="#form.fld_Criticality#" cfsqltype="cf_sql_integer" />
			)
		</cfquery>
	</cffunction>
	
	<cffunction name="updateError" access="public" output="false" returntype="void">
		<cfargument name="errorId" type="integer" required="true" />
		<cfargument name="userId" type="integer" required="true" />
		<cfargument name="date" type="string" required="true" />
		<cfargument name="status" type="integer" required="true" />
		<cfargument name="comment" type="string" required="true" />
		<cfset todayDate = Now()>
		<cfquery>
			UPDATE errors
			SET
			status_id = <cfqueryparam value="#arguments.status#" cfsqltype="cf_sql_integer" />
			WHERE error_id = <cfqueryparam value="#arguments.errorID#" cfsqltype="cf_sql_integer" />;
			
			INSERT INTO errors_history
			(error_id, user_id, date, action, comment)
			VALUES
			(
				<cfqueryparam value="#url.errorID#" cfsqltype="cf_sql_integer" />,
				<cfqueryparam value="#session.stLoggedInUser.userID#" cfsqltype="cf_sql_integer" />,
				<cfqueryparam value="#DateFormat(todayDate, "yyyy-dd-mm")#" cfsqltype="cf_sql_varchar" />,
				<cfqueryparam value="#form.fld_Status#" cfsqltype="cf_sql_integer" />,
				<cfqueryparam value="#form.fld_comment#" cfsqltype="cf_sql_varchar" />
			)
		</cfquery>
	</cffunction>
	<!---geterrorHistoryByID() method --->
	<cffunction name="getErrorHistoryByID" access="public" output="false" returntype="query">
		<cfargument name="errorID" type="numeric" required="true" />
		<cfset var rsSingleError = '' />
		<cfquery  name="rsSingleError">
			SELECT date, action, comment
			FROM errors_history
			WHERE error_id = <cfqueryparam value="#arguments.errorID#" cfsqltype="cf_sql_integer" /> 
		</cfquery>
		<cfreturn rsSingleError />
	</cffunction>
</cfcomponent>
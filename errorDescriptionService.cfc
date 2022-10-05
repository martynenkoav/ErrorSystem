<cfcomponent>
	<!---getStatuses() method--->
	<cffunction name="getStatuses" access="public" output="false" returntype="query">
		<cfset var rsStatusesList = '' />
		<cfquery  name="rsStatusesList">
			SELECT status_id, name
			FROM status
			WHERE status_id > 1
		</cfquery>
		<cfreturn rsStatusesList />
	</cffunction>
	
	<!---getUrgency() method--->
	<cffunction name="getUrgency" access="public" output="false" returntype="query">
		<cfset var rsUrgencyList = '' />
		<cfquery  name="rsUrgencyList">
			SELECT urgency_id, name
			FROM urgency
		</cfquery>
		<cfreturn rsUrgencyList />
	</cffunction>

	<!---getCriticality() method--->
	<cffunction name="getCriticality" access="public" output="false" returntype="query">
		<cfset var rsStatusesList = '' />
		<cfquery  name="rsCriticalityList">
			SELECT criticality_id, name
			FROM criticality
		</cfquery>
		<cfreturn rsCriticalityList />
	</cffunction>
</cfcomponent>
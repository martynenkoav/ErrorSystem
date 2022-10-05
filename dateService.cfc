<cfcomponent>
<cffunction name="getDate" access="public" output="false" returntype="string">
		<cfquery name="currentDate">
			SELECT CURRENT_DAY
		</cfquery >
		<cfreturn currentDate />
	</cffunction>
</cfcomponent>
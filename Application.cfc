<cfcomponent output="false">
	<cfset this.name = 'errorSystemWebsite'/>
	<cfset this.applicationTimeout = createtimespan(0, 2, 0, 0) />
	<cfset this.datasource = 'errorSystemDB'/>
	<cfset this.sessionManagement = true />
	<cfset this.sessionTimeout = createtimespan(0, 0, 30, 0) />
	<!---customTagPaths---->
	<!---OnApplicationStart() method--->
	<cffunction name="onApplicationStart" returntype="boolean" >
		<cfreturn true />
	</cffunction>
	<!---onRequestStart() method--->
	<cffunction name="onRequestStart" returntype="boolean" >
		<!---таргетпейдж поменять на страницу которую мне нужно--->
		<cfargument name="targetPage" type="string" required="true" />
		<!---handle some special URL parameters--->
		<cfif isDefined('url.restartApp')>
			<cfset this.onApplicationStart() />
		</cfif>
		<cfreturn true />
	</cffunction>
</cfcomponent>
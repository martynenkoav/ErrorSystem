<cfcomponent>

	<cffunction name="createTables" access="public" returntype="void">
		<cfquery  name="tableUsers">
			CREATE TABLE IF NOT EXISTS users
			(
	   			 user_id   SERIAL PRIMARY KEY,
	   			 name VARCHAR(100) NOT NULL,
	   			 last_name VARCHAR(100) NOT NULL,
	 		     email VARCHAR(100) NOT NULL,
	 			 password VARCHAR(100) NOT NULL,
	             role VARCHAR(100) NOT NULL
			);
		
			CREATE TABLE IF NOT EXISTS errors
			(
	 			error_id       SERIAL PRIMARY KEY,
	    		date VARCHAR(100),
	    		short_des VARCHAR(100),
	    		long_des VARCHAR(255),
	    		user_id INTEGER,
	    		FOREIGN KEY (user_id) REFERENCES users (user_id),
	    		status_id INTEGER,
	    		urgency_id INTEGER,
	    		criticality_id INTEGER
    		);
	
			CREATE TABLE IF NOT EXISTS errors_history
			(
				error_id INTEGER,
				user_id INTEGER,
				FOREIGN KEY (error_id) REFERENCES errors (error_id),
				date VARCHAR(100),
				FOREIGN KEY (user_id) REFERENCES users (user_id),
	    		action INTEGER,
	    		comment VARCHAR(100)
			);

			CREATE TABLE IF NOT EXISTS status
			(
				status_id SERIAL PRIMARY KEY,
				name VARCHAR(100)
			);

			CREATE TABLE IF NOT EXISTS urgency
			(
				urgency_id SERIAL PRIMARY KEY,
				name VARCHAR(100)
				
			);

			CREATE TABLE IF NOT EXISTS criticality
			(
				criticality_id SERIAL PRIMARY KEY,
				name VARCHAR(100)
			)
		</cfquery>
	</cffunction>

</cfcomponent>
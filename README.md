# Conference Application using Spring Boot and JPA

Technologies
	- Java 1.8 or above
	- Spring Boot(2.2.6.RELEASE)
	- JPA
	- Maven
	- h2 Database
POSTMAN (Inorder to perform CRUD Operations)

For running the application locally, set environment variable in run configuration
	DB_URL (Variable) - jdbc:h2:mem:testdb (Value)
	
There are two property files used in the application
	* application.properties (It is the default one) [PORT used - 8089]
	* application-prod.properties [PORT used - 8090]
In order to run the application using application-prod.properties, set the below details under the VM Arguments in run configuration
	"-Dspring.profiles.active=prod"

To use the application as a Standalone one, create jar by
	maven -> execute the command "mvn package" or "package"
It will create a jar with the name "Conference-0.0.1-SNAPSHOT.jar" under target folder inside the application

You can deploy the application using git bash, command propmt or terminal by executing the one of the below command in the target folder
	> java -jar Conference-0.0.1-SNAPSHOT.jar
	> ./Conference-0.0.1-SNAPSHOT.jar
	
Deployment can also be done in the cloud platform like
	- Cloud Foundry
	- Heroku
	- Google Cloud
	- Amazon Web Services
	- Microsoft Azure

**Note- You can also use other databases like PostgreSQL, Oracle, MySQL
Schema details is added under src/main/resources inside Schema.sql
Feature: Security Test. Token Generation test

Scenario: generate token with valid username and password.
	Given url "https://tek-insurance-api.azurewebsites.net"
	And path "/api/token"
	And request {"username": "supervisor", "password": "tek_supervisor"}
	When method post
	Then status 200
	And print response
	
Scenario: test API endpoint "/api/token" with Invalid Username and valid password.
	Given url "https://tek-insurance-api.azurewebsites.net"
	And path "/api/token"
	And request {"username": "supervis", "password": "tek_supervisor"}
	When method post
	Then status 404
	And print response
	* def errorMessage = response.errorMessage
	And assert errorMessage == "USER_NOT_FOUND"
	
Scenario: test API endpoint "/api/token" with valid Username and invalid password.
	Given url "https://tek-insurance-api.azurewebsites.net"
	And path "/api/token"
	And request {"username": "supervisor", "password": "tek_supervis"}
	When method post
	Then status 400
	And print response
	* def errorMessage = response.errorMessage
	And assert errorMessage == "Password Not Matched"
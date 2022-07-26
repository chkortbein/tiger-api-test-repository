# 1) Generate a valid token and verify it with below requirement.



Feature: Security test. Verify Token test.
@Smoke @Regression
	Scenario: Verify valid token.
	Given url "https://tek-insurance-api.azurewebsites.net"
	And path "/api/token"
	And request {"username": "supervisor", "password": "tek_supervisor"}
	When method post
	Then status 200
	* def generatedToken = response.token
	Given path "/api/token/verify"
	And param username = "supervisor"
	And param token = generatedToken
	When method get
	Then status 200
	And print response
	
	# 2) test API endpoint with invalid token
@Smoke @Regression
	Scenario: Verify invalid token.
	Given url "https://tek-insurance-api.azurewebsites.net"
	* def invalidToken = "rgwrgt"
	Given path "/api/token/verify"
	And param username = "supervisor"
	And param token = invalidToken
	When method get
	Then status 400
	And print response
	* def errorMessage = response.errorMessage
	And assert errorMessage == "Token Expired or Invalid Token"
	

	# 3) test api endpoint /api/token/verify with valid token
	# and invalid username, then status should be 400
	@Smoke @Regression
	Scenario: Verify valid token.
	Given url "https://tek-insurance-api.azurewebsites.net"
	And path "/api/token"
	And request {"username": "supervisor", "password": "tek_supervisor"}
	When method post
	Then status 200
	* def generatedToken = response.token
	Given path "/api/token/verify"
	And param username = "supervis"
	And param token = generatedToken
	When method get
	Then status 400
	And print response
		* def errorMessage = response.errorMessage
	And assert errorMessage == "Wrong Username send along with Token"
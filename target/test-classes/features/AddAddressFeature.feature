Feature: Create an account and add address to the account.

  # Step 1) Get a token
  # Step 2) Generate an account
  # Step 3) add address to generated account
  Background: Create new Account.
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def createAccountResult = callonce read('CreateAccountFeature.feature')
    And print createAccountResult
    * def primaryPersonId = createAccountResult.response.id
    * def token = createAccountResult.result.response.token
@Regression
  Scenario: Add address to an account
    Given path '/api/accounts/add-account-address'
    And param primaryPersonId = primaryPersonId
    When header Authorization = "Bearer " + token
    Given request
      """
      {
      "addressType": "Home",
      "addressLine1": "1234 Main St",
      "city": "Berlin",
      "state": "Wisconsin",
      "postalCode": "53201",
      "current": true
      }
      """
			When method post
			Then status 201
			And print response
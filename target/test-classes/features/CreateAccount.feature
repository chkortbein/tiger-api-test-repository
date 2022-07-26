Feature: Create Account

  #1) Create new account: endpoint /api/accounts/add-primary-account
  # status code 201 CREATED, with response generate account with email address
  Background: generate token for all scenarios.
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username": "supervisor", "password": "tek_supervisor"}
    When method post
    Then status 200
    * def generatedToken = response.token

  Scenario: Create new Account happy path
    Given path "/api/accounts/add-primary-account"
    And request {"id": 0,"email": "chkort-tigers2@gmail.com","title": "Mr.","firstName": "Chris","lastName": "Kortbe","gender": "MALE","maritalStatus": "MARRIED","employmentStatus": "Employed","dateOfBirth": "02/02/2000"}
    And header Authorization = "Bearer " + generatedToken
    When method post
    Then status 201
    And print response
    
   #2) Create new account: endpoint /api/accounts/add-primary-account
  # status code 400 BAD REQUEST, with response generate account with existing email address
  Scenario: Create new Account happy path
    Given path "/api/accounts/add-primary-account"
    And request {"id": 0,"email": "chkort-tigers@gmail.com","title": "Mr.","firstName": "Chris","lastName": "Kort","gender": "MALE","maritalStatus": "MARRIED","employmentStatus": "Employed","dateOfBirth": "02/02/2000"}
    And header Authorization = "Bearer " + generatedToken
    When method post
    Then status 400
    And print response

    #3)Test API endpoint /api/accounts/add-account-car to add car to existing account
    #Status code should be 201 - Create , validate response (assert)
   Scenario: Add car to existing account
    Given path "/api/accounts/add-account-car"
    And param primaryPersonId = "8364"
    And request {"id": 0,"primaryPerson": {"id": 8127,"email": "chkort-tigers@gmail.com","title": "Mr.","firstName": "Chris","lastName": "Kort","gender": "MALE","maritalStatus": "MARRIED","employmentStatus": "Employed","dateOfBirth": "02/02/2000"},"make": "Honda","model": "CRV","year": "2018","licensePlate": "bbb-789"}
    And header Authorization = "Bearer " + generatedToken
    When method post
    Then status 201
    And print response
    
    #4) Test API endpoint /api/accounts/add-account-phone to add phone to existing account
    #Status code should be 201 - Create , validate response (assert)
   Scenario: Add phone to existing account
    Given path "/api/accounts/add-account-phone"
    And param primaryPersonId = "8365"
    And request {"id": 0,"phoneNumber": "612-222-2222","phoneExtension": "","phoneTime": "Any Time","phoneType": "Mobile"}
    And header Authorization = "Bearer " + generatedToken
    When method post
    Then status 201
    And print response
    
    
    #5) Test API endpoint /api/accounts/add-account-address to add address to existing account
    #Status code should be 201 - Create , validate response (assert)
   Scenario: Add address to existing account
    Given path "/api/accounts/add-account-address"
    And param primaryPersonId = "8365"
    And request {"id": 0,"addressType": "Home","addressLine1": "111 Cleveland Avenue S.","city": "Saint Paul","state": "MN","postalCode": "55106","countryCode": "01"}
    And header Authorization = "Bearer " + generatedToken
    When method post
    Then assert responseStatus == 201
    And print response
    
    
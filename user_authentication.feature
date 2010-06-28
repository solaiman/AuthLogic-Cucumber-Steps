Feature: User Authentication

The authentication process should allow users to login and logout and should persist a UserSession

Scenario: Clicking the Log In button
	Given I am on the home page
	And I am not logged in
	When I follow "Log In"
	Then I should be on the login page
	And I should see "Login"
	
Scenario: Logging In from the Login Page
	Given I am the user "Bingo"
	When I Log In
	Then there should be a session
	And the user should be "Bingo"

Scenario: The "I am logged in as" method
	Given I am logged in as "Bingo"
	Then there should be a session
	And the user should be "Bingo"
	
Scenario: Logging Out
	Given I am logged in as "Bingo"
	When I logout
	Then there should not be a session
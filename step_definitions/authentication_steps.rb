# Authlogic ~ Cucumber Authentication Steps

# Activate AuthLogic prior to testing

Before do
	include Authlogic::TestCase
	activate_authlogic
end

#
# Helper Methods available to other steps
#

def create_user(login)
  @current_user = User.create!(
    :login => login,
    :password => 'generic',
    :password_confirmation => 'generic',
    :email => "#{login}@example.com"
  )
end

def login_user
  visit "/login" 
  fill_in("login", :with => @current_user.login) 
  fill_in("password", :with => 'generic') 
  click_button("Login")
end

def logout_user
	session = UserSession.find
	session.destroy if session
end

#
# Cucumber Assertions
#

Given /^I am the user "(.*)"$/ do |login|
  create_user login
end

Given /^I am logged in as "(.*)"$/ do |login|
  create_user login
	login_user
end

Given /^I am not logged in$/ do
	logout_user
end

When /^I Log In$/ do
  login_user
end

When /^I logout$/ do
	logout_user
end

Then /^there should be a session$/ do
  @session = UserSession.find
  @session.should_not be nil
end

Then /^there should not be a session$/ do
  @session = UserSession.find
  @session.should be nil
end

Then /^the user should be "([^"]*)"$/ do |login| #"
  @session = UserSession.find
  @session.user.login.should be == login
end
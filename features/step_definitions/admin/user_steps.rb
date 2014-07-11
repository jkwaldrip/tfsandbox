#  Copyright 2005-2014 The Kuali Foundation
#
#  Licensed under the Educational Community License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at:
#
#    http://www.opensource.org/licenses/ecl2.php
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

Given /^I am a user$/ do
  @user = User.new @browser,:user_name => 'ole-khuntley'
end

Then /^I login$/ do
  expect(@user.login).to be_truthy
end

When /^I am logged in$/ do
  expect(@user.logged_in?).to be_truthy
end

Then /^I logout$/ do
  @user.logout
end

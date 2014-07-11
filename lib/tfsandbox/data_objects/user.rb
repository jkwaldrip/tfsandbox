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

# An OLE non-Patron System User with a login.
class User < DataFactory

  def initialize(browser,opts={})
    @browser = browser

    defaults = {}
    set_options(defaults.merge(opts))

    requires :user_name
  end

  def login
    visit PortalPage do |page|
      page.login(@user_name)
    end
  end

  def logout
    visit PortalPage do |page|
      page.logout
    end
  end

  def logged_in?
    on BasePage do |page|
      return page.logged_in_as == @user_name || page.impersonating == @user_name
    end
  end
end
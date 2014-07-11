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

# Base Page Class
class BasePage < PageFactory

  # The OLE build tag (upper right-hand corner of every OLE screen.
  value(:build_info)                    {|b| b.div(:id => 'build').text}

  # Set login elements, visible from every page.
  element(:login_field)                 {|b| b.text_field(:name => 'backdoorId')}
  element(:login_button)                {|b| b.input(:class => 'go',:value => 'Login')}
  element(:logout_button)               {|b| b.input(:class => 'go',:value => 'Logout')}

  # Set up backdoorlogin elements if testing against a development environment.
  if TFSandbox::development?
    element(:login_confirmation)        {|b| b.div(:id => 'login-info').strong(:text => /Impersonating User\:/)}
    value(:logged_in_as)                {|b| b.div(:id => 'login-info').strong(:index => 0).text.match(/(?:\:\s)([\w\-\_]+)/)[1]}
    value(:impersonating)               {|b| elmnt = b.div(:id => 'login-info').strong(:index => 1)
                                        elmnt.present? ?
                                        elmnt.text.match(/(?:\:\s)([\w\-\_]+)/)[1] :
                                        ''
    }


    # Log in with a given username; returns (true|false) depending upon success.
    action(:login)                        {|who,b| b.login_field.when_present.set(who)
                                          b.login_button.click
                                          return false unless b.login_confirmation.wait_until_present
                                          b.impersonating == who ? true : false
    }
    # Log out; returns (true|false) depending upon success.
    action(:logout)                       {|b| b.logout_button.when_present.click
                                          b.login_confirmation.present? ? false : true
    }

  end


  # Define blocks of elements to instantiate via method call on a page definition.
  class << self
    # Define the portal tabs if they are visible on a given page.
    def portal_tabs
      element(:deliver_tab)            {|b| b.div(:id => 'tabs').ul.li.a(:title => 'Deliver')}
      element(:describe_tab)           {|b| b.div(:id => 'tabs').ul.li.a(:title => 'Describe')}
      element(:deliver_tab)            {|b| b.div(:id => 'tabs').ul.li.a(:title => 'Select/Acquire')}
      element(:maintenance_tab)        {|b| b.div(:id => 'tabs').ul.li.a(:title => 'Maintenance')}
      element(:admin_tab)              {|b| b.div(:id => 'tabs').ul.li.a(:title => 'Admin')}
    end

    # Select elements in either the iframeportlet or fancybox iframes.
    def frames
      element(:iframeportlet)                       {|b| b.iframe(:class => 'iframeportlet')}
      element(:fancybox)                            {|b| b.iframe(:class => 'fancybox-iframe')}
    end
  end
end

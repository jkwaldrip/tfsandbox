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

dir = File.join(File.dirname(__FILE__),'../../')
$:.unshift(dir) unless $:.include?(dir)

require 'lib/tfsandbox.rb'
require 'rspec/expectations'

World(RSpec::Matchers)

Before do |scenario|
  @browser = Watir::Browser.new :firefox
end

After do |scenario|
  if scenario.failed?
    filename = "#{Time.now.strftime('%Y%m%d-%I%M%p')}-#{scenario.name.gsub(/\s/,'_')}.png"
    @browser.screenshot.save("screenshots/#{filename}")
  end
  @browser.close
end

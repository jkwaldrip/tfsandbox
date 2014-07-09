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

# Set up Headless.
if TFSandbox.options[:headless?]
	@headless = Headless.new
	@headless.start
end

Before do |scenario|
	timeout = Time.now + 300
	c = 0
	begin
	  @browser = Watir::Browser.new :firefox
		break
	rescue
	  c += 1
		puts "Browser connection not made. Trying again in 5 seconds. (Attempt #{c})"
		sleep 5
  end while Time.now < timeout
	raise TFSandbox::Error,"Browser connection not made after 5 minutes." unless @browser.is_a?(Watir::Browser)
  @browser.driver.manage.timeouts.implicit_wait = TFSandbox::options[:default_wait]
end

After do |scenario|
  if scenario.failed?
    filename = "#{Time.now.strftime('%Y%m%d-%I%M%p')}-#{scenario.name.gsub(/\s/,'_')}.png"
    @browser.screenshot.save("screenshots/#{filename}")
  end
  @browser.close unless @browser.nil?
end

at_exit do
	# Cleaning up Headless if it's been instantiated.
	@headless.destroy if @headless
end

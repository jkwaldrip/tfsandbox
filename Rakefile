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

dir = File.expand_path(File.dirname(__FILE__))
$:.unshift(dir) unless $:.include?(dir)

require 'cucumber/rake/task'
require 'tfsandbox/version'

desc 'Display the current version number'
task :version do
  puts "Version #{TFSandbox::Version}"
end

desc 'Remove all test data and screenshots'
task :clean_all do
  files = Dir['data/downloads/*','data/upload/*','screenshots/*'].sort
  if files.empty?
    puts 'No data found.'
  else
    files.each {|file| File.delete file}
    puts "#{files.count} files deleted."
  end
end
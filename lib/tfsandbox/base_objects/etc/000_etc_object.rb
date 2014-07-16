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

# An object to supplement DataFactory objects with additional data and functionality.
# @note Mostly used to abstract additional data and data transformations away from
#   the data factories themselves for operations like Marc record creation/reading.
class EtcObject

  include StringFactory
  include DateFactory
  include TFSandbox::Helpers

  def opts_to_vars(hsh)
    hsh.each do |k,v|
      # Set instance variables.
      instance_variable_set("@#{k}",v)
      eigenclass = class << self
        self
      end
      # Create accessors, unless the key ends in a question mark.
      eigenclass.class_eval do
        attr_accessor k unless k.to_s[/\?$/]
      end
    end
  end
end

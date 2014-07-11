#  Copyright 2005-2013 The Kuali Foundation
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

module TFSandbox
  # Helper modules to be accessed by Data Objects.
  module Helpers

    include StringFactory
    include DateFactory

    # Capitalize the first letter of two random letter sequences.
    #   Just makes it a little more visually obvious that it's meant to be a name.
    def random_name
      "#{random_letters(pick_range(4..12)).capitalize} #{random_letters(pick_range(4..12)).capitalize}"
    end

    # Return a random string of numbers with the specified length.
    def random_num_string(len = 2, str = "")
      len.times { str << pick_range('0'..'9')}
      str
    end

    # Pick a random value from a range.
    def pick_range(r = 'A'..'Z')
      r.to_a.sample
    end
  end
end

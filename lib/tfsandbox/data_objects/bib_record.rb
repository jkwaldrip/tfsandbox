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

# A MARC-format Bibliographic record in the OLE Library System
# @note MARC is the default format in OLE.  Holdings and Item
#   records can be created with MARC fields, but will be extracted
#   as related records in the OLE Markup Language (OLEML).
# @note MARC record subfield delimiters in OLE are flagged with a bar '|'
#   instead of a dollar sign '$'.
class MarcBibRecord < DataFactory

  include TFSandbox::Helpers

  attr_accessor :title,:author,:circulation_desk,:call_number,:call_number_type,:barcode

  def initialize(browser,opts={})
    @browser = browser
    defaults = {
        # MARC 245 $a
        :title                => MarcDataLine.new(:tag => '245',:subfield => '|A',:value => random_letters(pick_range(9..13)).capitalize),
        # MARC 100 $a
        :author               => MarcDataLine.new(:tag => '100',:subfield => '|A',:value => random_name),
        # The Holdings circulation desk.
        :circulation_desk     => CirculationDesk.new,
        # The Holdings call number.
        :call_number          => "#{random_letters(1).capitalize}#{random_num_string(pick_range(1..3))}.#{random_letters(pick_range(1..3)).capitalize}#{random_num_string(pick_range(1..3))}",
        # The Holdings call number type.
        :call_number_type     => 'LCC',
        # The Item record barcode.
        :barcode              => random_num_string(pick_range(9..16),"OLEQA")
    }
    options = defaults.merge(opts)

    # Select a Holdings location from the Circulation desk unless given.
    options[:location] ||= options[:circulation_desk].locations.sample

    set_options(options)

    requires :title

  end
end
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
class MarcRecord < DataFactory

  attr_accessor :bib,:holdings,:barcode
  alias :bib_record       :bib
  alias :holdings_record  :holdings

  # Options:
  #   :bib                Object        The Marc bib record to use.
  #                                     (See lib/tfsandbox/base_objects/etc/marc_bib.rb)
  #   :holdings           Object        The Holdings record to use.
  #                                     (See lib/tfsandbox/base_objects/etc/holdings_record.rb)
  #   :barcode            String        The barcode to use on the item record.
  def initialize(browser,opts={})
    @browser = browser
    defaults = {
        :bib                  => MarcBib.new,
        :holdings             => HoldingsRecord.new,
        :barcode              => random_num_string(pick_range(9..16),"OLEQA")
    }
    options = defaults.merge(opts)

    set_options(options)

  end

  def create
    create_bib
    # create_holdings
    # create_item
  end

  # Create a bib record only.
  def create_bib
    visit BibEditorPage do |page|

      # Enter all MARC lines in order.
      @bib.marc_lines.each_with_index do |marc_line,i|
        page.tag_field(i).when_present.set(marc_line.tag)
        page.indicator_1_field(i).when_present.set(marc_line.ind_1)
        page.indicator_2_field(i).when_present.set(marc_line.ind_2)
        page.value_field(i).when_present.set(marc_line.subfield)
        page.add_line(i) unless i == @bib.marc_lines.count
      end

      # Save the bib record.
      page.save
    end
  end
end

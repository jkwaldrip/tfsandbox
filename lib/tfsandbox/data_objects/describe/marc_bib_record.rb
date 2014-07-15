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

  # Options:
  #   :title              String        The title on the bib record.    (Marc 245 $a)
  #   :author             String        The author on the bib record.   (Marc 100 $a)
  #   :marc_lines         Array         An array of MARC data values not named above,
  #                                     instantiated as MarcDataLine objects.
  #                                     (See lib/base_objects/etc/marc_data_line.rb)
  #   :circulation_desk   Object        The OLE circulation desk to use.
  #                                     (See lib/base_objects/etc/circulation_desk.rb)
  #   :call_number        String        The call number to use on the holdings record.
  #   :call_number_type   String        The holdings call number type.
  #   :barcode            String        The barcode to use on the item record.
  def initialize(browser,opts={})
    @browser = browser
    defaults = {
        :title                => random_letters(pick_range(9..13)).capitalize,
        :author               => random_name,
        :marc_lines           => []
=begin
        :circulation_desk     => CirculationDesk.new,
        :call_number          => random_lcc,
        :call_number_type     => 'LCC',
        :barcode              => random_num_string(pick_range(9..16),"OLEQA")
=end
    }
    options = defaults.merge(opts)

    # Select a Holdings location from the Circulation desk unless given.
    options[:location] ||= options[:circulation_desk].locations.sample

    set_options(options)

    requires :title,:author

    # Add MARC Data Lines for title and author.
    @marc_lines.unshift(
      MarcDataLine.new(:tag => '100',:subfield => '|A',:value => @title),
      MarcDataLine.new(:tag => '245',:subfield => '|A',:value => @author)
    )
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
      @marc_lines.each_with_index do |marc_line,i|
        page.tag_field(i).when_present.set(marc_line.tag)
        page.indicator_1_field(i).when_present.set(marc_line.ind_1)
        page.indicator_2_field(i).when_present.set(marc_line.ind_2)
        page.value_field(i).when_present.set(marc_line.subfield)
        page.add_line(i) unless i == @marc_lines.count
      end

      # Save the bib record.
      page.save
    end
  end
end

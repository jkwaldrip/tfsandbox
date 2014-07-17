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

  attr_accessor :bib,:holdings
  alias :bib_record         :bib
  alias :holdings_records   :holdings
  alias :holdings_record    :holdings

  # Options:
  #   :bib                Object        The Marc Bib record to use.
  #                                     (See lib/tfsandbox/base_objects/etc/marc_bib.rb)
  #   :holdings           Array         An array of Holdings Records to use.
  #                                     (Defaults to 1 new holdings record.)
  #                                     (See lib/tfsandbox/base_objects/etc/holdings_record.rb)
  def initialize(browser,opts={})
    @browser = browser
    defaults = {
        :bib                  => MarcBib.new,
        :holdings             => [HoldingsRecord.new]
    }
    options = defaults.merge(opts)


    set_options(options)

  end

  def create
    create_bib
    # create_holdings
    # create_item
  end

  # Create a new Holdings Record.
  def new_holdings(opts={})
    defaults = {:number => @holdings.count + 1}
    @holdings << HoldingsRecord.new(defaults.merge(opts))
  end
  alias_method(:new_holdings_record,:new_holdings)

  # Create a new Item Record with the given options on the Holdings Record specified by array index.
  def new_item(which = 0,opts={})
    defaults = {:number => @holdings[which].items.count}
    @holdings[which].new_item(defaults.merge(opts))
  end

  # Create a bib record only.
  def create_bib
    visit BibEditorPage do |page|

      # TODO Implement support for MARC control lines & leader field

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

  # Create a holdings record only.
  # @note This method assumes that we're starting from the BibEditorPage.
  #   When invoking this method outside of initial bib creation, please retrieve
  #   the bib record through the lookup_bib method.
  #
  # Params:
  #   which         Fixnum          The 1-based holdings record number to enter.
  #                                 This is used to determine both the holdings
  #                                 record to select on the screen and the
  #                                 object to select from the holdings array.
  def create_holdings(which = 1)
    ind = which - 1

    on HoldingsEditorPage do |page|
      page.add_instance unless page.holdings_link(which).present?
      page.location_field.when_present.set(@holdings[ind].location)
      page.call_number_field.when_present.set(@holdings[ind].call_number)
      page.call_number_type_selector.when_present.select(@holdings[ind].call_number_type)
      page.save
    end
  end

  # Lookup a record.
  def lookup(opts = {})
    # TODO Describe Workbench lookup support.
  end
end

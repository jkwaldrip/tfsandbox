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
require 'rspec'
require 'spec_helper'

describe 'A MARC Record' do

  before :all do
    @browser  = TFSandbox.start_browser
    @marc     = MarcRecord.new @browser
  end

  after :all do
    @browser.quit unless @browser.nil?
  end

  it 'has a bib record' do
    expect(@marc.bib_record).to be_a(MarcBib)
  end

  it 'has a holdings record' do
    expect(@marc.holdings_record).to be_a(HoldingsRecord)
  end

  it 'has an item record' do
    expect(@marc.item_record).to be_an(ItemRecord)
  end
end
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
#  limitations under the License

# A single line on a MARC record.
class MarcDataLine

  include TFSandbox::Helpers

  attr_accessor :tag,:subfield,:value,:indicator_1,:indicator_2

  alias :ind_1 :indicator_1
  alias :ind_1= :indicator_1=
  alias :ind_2 :indicator_2
  alias :ind_2= :indicator_2=

  # Parameters:
  #   :tag => String            The MARC field tag
  #   :indicator_1 => String    The first subfield indicator.
  #   :indicator_2 => String    The second subfield indicator.
  #   :subfield => String       The MARC subfield delimiter
  #   :value => String          The actual value of the field
  #
  # @note In the OLE Library System, MARC subfields are delimited with a
  #   vertical bar '|' instead of the standard dollar sign '$', and the
  #   subfield code is usually a capital letter.
  #   These substitutions will be made automatically.
  #
  def initialize(opts={})
    defaults = {
        :tag          => '245',
        :subfield     => '|A',
        :indicator_1  => '#',
        :indicator_2  => '#',
        :value        => random_letters(pick_range(6..10)).capitalize
    }
    options = defaults.merge(opts)

    @tag          = options[:tag]
    @subfield     = options[:subfield].gsub(/^\$/,'|').upcase
    @value        = options[:value]
  end

  # Return the full subfield as it would appear in an OLE bibliographic record.
  def subfield_full
    "#{@subfield} #{@value}"
  end

  # TODO Incorporate RubyMarc crosswalks here.
end
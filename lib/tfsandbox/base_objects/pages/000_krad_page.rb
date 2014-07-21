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

# The base page object for all KRAD-based pages in OLE.
class KradPage < BasePage

  uses_frames

  # Load the page inside a Fancybox iframe.
  # @note Fancybox iframes are used for lightboxing
  #   page-inside-a-page views in OLE KRAD-based pages.
  def load_in_frame
    self.instance_eval do 
      def method_missing(sym, *args, &block)
        @browser.iframe(:class => 'fancybox-iframe').send(sym, *args, &block)
      end
    end
  end
  alias_method(:load_in_iframe,:load_in_frame)
end

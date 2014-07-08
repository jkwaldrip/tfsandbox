module TFSandbox
  # Base Page Class
  class BasePage < PageFactory

    # The OLE build tag (upper right-hand corner of every OLE screen.
    value(:build_info)                   {|b| b.div(:id => 'build').text}

    # Define blocks of elements to instantiate via method call on a page definition.
    class << self
      # Define the portal tabs if they are visible on a given page.
      def portal_tabs
        element(:deliver_tab)            {|b| b.div(:id => 'tabs').ul.li.a(:title => 'Deliver')}
        element(:describe_tab)           {|b| b.div(:id => 'tabs').ul.li.a(:title => 'Describe')}
        element(:deliver_tab)            {|b| b.div(:id => 'tabs').ul.li.a(:title => 'Select/Acquire')}
        element(:maintenance_tab)        {|b| b.div(:id => 'tabs').ul.li.a(:title => 'Maintenance')}
        element(:admin_tab)              {|b| b.div(:id => 'tabs').ul.li.a(:title => 'Admin')}  
      end
    end
  end
end

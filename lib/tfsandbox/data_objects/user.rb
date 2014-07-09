
module TFSandbox
  # An OLE non-Patron System User with a login.
  class User < DataFactory

    def initialize(browser,opts={})
      @browser = browser

      defaults = {}
      set_options(defaults.merge(opts))

      requires :user_name
    end

    def login
      visit PortalPage do |page|
        page.login(@user_name)
      end
    end

    def logout
      visit PortalPage do |page|
        page.logout
      end
    end

    def logged_in?
      on BasePage do |page|
        return page.logged_in_as == @user_name || page.impersonating == @user_name
      end
    end
  end
end


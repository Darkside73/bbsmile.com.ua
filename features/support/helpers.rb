module NavigationHelpers
  def path_to(page_name)
    case page_name

    when /home page/
      root_path
    when /admin page/
      admin_path
    # Add more page name => path mappings here
    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
      "Now, go and add a mapping in features/support/paths.rb"
    end
  end
end

module CapybaraHelpers
  def basic_auth(name, password)
    if page.driver.respond_to?(:basic_auth)
      page.driver.basic_auth(name, password)
    elsif page.driver.respond_to?(:basic_authorize)
      page.driver.basic_authorize(name, password)
    elsif page.driver.respond_to?(:browser) && page.driver.browser.respond_to?(:basic_authorize)
      page.driver.browser.basic_authorize(name, password)
    else
      raise "I don't know how to log in!"
    end
  end
end

World(NavigationHelpers, CapybaraHelpers, FactoryGirl::Syntax::Methods)

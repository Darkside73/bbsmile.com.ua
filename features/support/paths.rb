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

World(NavigationHelpers)
World(FactoryGirl::Syntax::Methods)
World(ApplicationHelper)
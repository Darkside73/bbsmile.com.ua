module PgSearch
  class Configuration
    def default_options
      {
        using: {
          tsearch: {
            dictionary: "ru",
            prefix: true
          }
        }
      }
    end
  end
end
if Rails.env.development?
  ActionDispatch::Callbacks.after do
    Dir.glob(["#{Rails.root}/app/models/*/*.rb", "#{Rails.root}/lib/**/*.rb"]) do |entry|
      # require_dependency entry
      load entry
    end
  end
end
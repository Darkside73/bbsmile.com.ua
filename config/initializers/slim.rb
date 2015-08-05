# Allow Slim assets in the asset pipeline
Rails.application.assets.register_engine('.slim', Slim::Template)

Slim::Engine.set_options attr_list_delims: {'(' => ')', '[' => ']'}


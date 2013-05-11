# encoding : utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Ability to use "fixture_file_upload"
require 'action_dispatch/testing/test_process'
module Seedbank
  class Runner
    include ActionDispatch::TestProcess

    # Shortcut for create fixture under db/seeds/files directory
    def seed_file_fixture(file_path)
      content_type = "image/#{File.extname(file_path).sub('.', '')}"
      fixture_file_upload(Rails.root.join("db/seeds/files/#{file_path}"), content_type)
    end
  end
end